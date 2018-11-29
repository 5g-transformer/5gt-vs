#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include<unistd.h>
#include<stdint.h>
#include<sys/wait.h>

#define MAXLINE 1024
#define SH_DIR "/home/trans/Documents/tacker/autodeploy.sh" 
#define PARAM 2

void parse_string(char *qstring, char *delim, char *param[PARAM]){		
	char *ptr = NULL;
	int i = 1, index = 0;
	ptr = strtok(qstring, delim);
	while(ptr){
		ptr = strtok(NULL, delim);
		if(i % 2){
			param[index++] = ptr;
		}
		i++;
	}
}

void set_env(void){
	setenv("OS_USERNAME", "admin", 1);
	setenv("OS_PASSWORD", "password", 1);
	setenv("OS_PROJECT_NAME", "admin", 1);
	setenv("OS_USER_DOMAIN_NAME", "Default", 1);
	setenv("OS_PROJECT_DOMAIN_NAME", "Default", 1);
	setenv("OS_AUTH_URL", "http://trans-edge:35357/v3", 1);
	setenv("OS_IDENTITY_API_VERSION", "3", 1);


}

int main(int argc, char *argv[], char *envp[]){
	int pid = fork();
	int status = 0;
	if(pid != 0){
	    char *qstr;
	    char buffer[MAXLINE];

	    memset(buffer, '\0', MAXLINE);
	    qstr = getenv("QUERY_STRING");
	    printf("Content-Type: text/html\n\n");
	    printf("<font face=\"monospace\">\r\n");
		printf("%s\n<br>", qstr); 
		waitpid(pid, &status, WNOHANG);
		const char * redirect_page_format =
		"<html>\n"
		"<head>\n"
		"<meta http-equiv=\"REFRESH\"\n"
		"content=\"0;url=%s\">\n"
		"</head>\n"
		"</html>\n";
		printf (redirect_page_format, getenv ("HTTP_REFERER"));
	}

	else{
		//system("source admin-edge.rc");	
	    char *qstr, *param[PARAM];
		char *delim = "=&";
		qstr = getenv("QUERY_STRING");
		parse_string(qstr, delim, param);	
		set_env();
		char buffer[100] = {0};
		sprintf(buffer, "bash %s %s", SH_DIR, "vlc"); //param[1]
		system(buffer);
		exit(0);
	}


    return 0;
}
