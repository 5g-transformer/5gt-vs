#!/usr/bin/perl
use strict;
#use JSON;
my %In = ();
my $JScode = '';
my $vnf_deployed = ();
my $hash = '';
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
($In{sn},$In{ss}) = split /&/,$ENV{QUERY_STRING};



#($v1,$v2) = split /\n/, `openstack server list --project admin | grep SHUTOFF | awk '{ print \$4 }'`;
(@sname)= split /\n/, ` openstack vnf list --tenant-id 9468d750efe845a3bcd30bfc994da68d | grep 3e77b699 | awk '{ print \$4}'`;
(@ss)= split /\n/, ` openstack vnf list --tenant-id 9468d750efe845a3bcd30bfc994da68d | grep 3e77b699 | awk '{ print \$9}'`;
# 3. Create JavaScript code to send back.
#print @sname[0] . " aaaa\n";
#print @sname[1] . " bbbb\n";
$JScode = "$In{sn}=\"@sname\";$In{ss}=\"@ss\";";
#$JScode = "$In{CPU}=$cpu_used;$In{ram}=$ram_used;$In{disk}=$disk_used;$In{sn}=$v2;$In{vnf2}=$v2;";
# 4. Send code to the JavaScript on the web page.
print "Content-type: text/javascript\n\n";
print $JScode;
### end of script ###


