#!/usr/bin/perl
use strict;
#use JSON;
my %In = ();
my $JScode = '';
my $ram_used = 0;
my $cpu_used = 0;
my $disk_used = 0;
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
($In{CPU},$In{ram},$In{disk},$In{sn},$In{ss}) = split /&/,$ENV{QUERY_STRING};


# 2. do sth
$hash = `openstack project show admin | grep "\ id\ "  | awk '{ print \$4 }'`; #change admin
($rel[0], $rel[1], $rel[2]) = split / /,`openstack host show trans-edge | grep \Q$hash\E | awk '{ print \$6, \$8, \$10}'`; # CPU, RAM, Disk



$cpu_used = ($rel[0]+0)  / 10; #SLA
$ram_used = ($rel[1]+0)  / 15000; #SLA
$disk_used = ($rel[2]+0) / 500; #SLA




=begin
$disk_used = `openstack usage show --project admin | grep Disk | awk '{ print \$5 }'`; #change to value only
$disk_used = $disk_used / 1000000; #SLA
$cpu_used = `openstack usage show --project admin | grep CPU | awk '{ print \$5 }'`;
$cpu_used = $cpu_used / 100000; #SLA
$ram_used = `openstack usage show --project admin | grep RAM | awk '{ print \$5 }'`;
$ram_used = $ram_used / 100000000; #SLA
=end
=cut

#($v1,$v2) = split /\n/, `openstack server list --project admin | grep SHUTOFF | awk '{ print \$4 }'`;
(@sname)= split /\n/, ` openstack vnf list --tenant-id 9468d750efe845a3bcd30bfc994da68d | grep 3e77b699 | awk '{ print \$4}'`;
(@ss)= split /\n/, ` openstack vnf list --tenant-id 9468d750efe845a3bcd30bfc994da68d | grep 3e77b699 | awk '{ print \$9}'`;
# 3. Create JavaScript code to send back.
#print @sname[0] . " aaaa\n";
#print @sname[1] . " bbbb\n";
$JScode = "$In{CPU}=$cpu_used;$In{ram}=$ram_used;$In{disk}=$disk_used;$In{sn}=\"@sname\";$In{ss}=\"@ss\";";
#$JScode = "$In{CPU}=$cpu_used;$In{ram}=$ram_used;$In{disk}=$disk_used;$In{sn}=$v2;$In{vnf2}=$v2;";
# 4. Send code to the JavaScript on the web page.
print "Content-type: text/javascript\n\n";
print $JScode;
### end of script ###


