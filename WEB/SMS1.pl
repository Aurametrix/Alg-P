#!/usr/bin/perl
use LWP::UserAgent;
use HTTP::Request;

$ua = new LWP::UserAgent(keep_alive=>1);
 
$response = $ua->post('https://app.clubtexting.com/api/sending/',
 [user=>'username', pass=>'userpassword', phonenumber=>'2125551234', subject=>'test', message=>'test message', express=>1]);
 
print $response->content;
