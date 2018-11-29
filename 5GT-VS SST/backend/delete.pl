#!/usr/bin/perl
use strict;
#use JSON;
my %In = ();
my $JScode = '';
my $disk_used = 0;
my $status = 0;
my $vnf_deployed = ();
my $redirect = '';
my @rel = ();
my @sname = ();
my @ss = ();
#to be modified: read username from env and source username.sh

$ENV{"OS_USERNAME"} = "admin";
$ENV{"OS_PASSWORD"} = "password";
$ENV{"OS_PROJECT_NAME"} = "admin";
$ENV{"OS_USER_DOMAIN_NAME"} = "Default";
$ENV{"OS_PROJECT_DOMAIN_NAME"} = "Default";
$ENV{"OS_AUTH_URL"} = "http://trans-edge:35357/v3";
$ENV{"OS_IDENTITY_API_VERSION"} = "3";

# 1. Read what the JavaScript sent.
($In{service_name}) = split / /,$ENV{QUERY_STRING};
#($In{service_name}) = $ENV{QUERY_STRING};


# 2. do sth
$status = `openstack vnf delete $In{service_name}`;


$redirect ="<html>\n"."<head>\n"."<meta http-equiv=\"REFRESH\"\n"."content=\"0;url=$ENV{HTTP_REFERER}\">\n"."</head>\n"."</html>\n";



# 3. Create JavaScript code to send back.
$JScode="$In{service_name}, $status";
# 4. Send code to the JavaScript on the web page.
print "Content-type: text/html\n\n";
print "$redirect";
### end of script ###


