from argparse import ArgumentParser
from configparser import ConfigParser
from logging import basicConfig, getLogger
from os import makedirs
from os.path import isdir, exists, join, dirname

from tornado.ioloop import IOLoop
from tornado.routing import Rule, PathMatches
from tornado.web import RequestHandler, Application


class SaveHandler(RequestHandler):

    def __init__(self, *a, **ka):
        self.root_dir = None
        super(SaveHandler, self).__init__(*a, **ka)

    def initialize(self, root_dir=None):
        self.root_dir = root_dir

    def set_default_headers(self):
        self.set_header("Access-Control-Allow-Origin", "*")
        self.set_header("Access-Control-Allow-Headers", "Content-Type, x-requested-with")
        self.set_header('Access-Control-Allow-Methods', 'GET, PUT')

    def put(self, *args, **kwargs):
        path = r'/'.join(args)
        full_path = join(self.root_dir, path)
        dir_path = dirname(full_path)
        makedirs(dir_path, exist_ok=True)
        with open(full_path, 'wb') as f:
            f.write(self.request.body)
        self.set_status(204)

    def options(self, *args, **kwargs):
        self.set_status(204)

    def get(self, *args, **kwargs):
        path = r'/'.join(args)
        full_path = join(self.root_dir, path)
        if not exists(full_path):
            self.set_status(404)
            return
        else:
            self.set_header("Content-Type", "image/*")
            with open(full_path, 'rb') as f:
                self.write(f.read())
            self.set_status(200)
            return


def make_app(root_dir):
    rules = [
        Rule(PathMatches(r'/(.*)'), SaveHandler, target_kwargs={'root_dir': root_dir})
    ]
    return Application(rules)


def main(port, root_dir):
    app = make_app(root_dir)
    app.listen(port)
    logger.info("Listening on port {}.".format(port))
    try:
        IOLoop.current().start()
    except KeyboardInterrupt:
        logger.info('Interrupted.')


if __name__ == '__main__':
    basicConfig()
    logger = getLogger(__name__)
    logger.setLevel('DEBUG')
    command_line_parser = ArgumentParser()
    command_line_parser.add_argument(
        "-c",
        "--config",
        type=str,
        default="fileserver.conf",
        help="Fileserver config file path",
    )
    command_line = command_line_parser.parse_args()
    cfg = ConfigParser()
    cfg.read(command_line.config)
    base_dir = cfg.get('filesystem', 'root-dir', fallback='/tmp')
    port = int(cfg.get('HTTP', 'port', fallback='8080'))
    if not exists(base_dir):
        logger.warning('Inexistent root dir "%s", creating.', base_dir)
        makedirs(base_dir, exist_ok=True)
    if not isdir(base_dir):
        logger.error('"%s" is not a directory, cannot be root dir.', base_dir)
        exit(1)
    main(port, base_dir)
