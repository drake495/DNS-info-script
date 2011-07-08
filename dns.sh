#!/bin/bash
#
##################################################
#
# file: dns.sh
#
# Version 2.0 !!!!
# Written by: Derek Creason
#
# Date:    09/16/2009
#
# Updated: 5/19/2011
##################################################
#
# This script will look up the following for a Domain.
#
# Domain Name Servers
# Domain's Registrar
# Domain's Status
# Domain's IP address it is resolving to
# Domain's MX records
###################################################
#
# It's ugly and inefficient, but it works.
#
# Thanks to FredM for helping with output formatting.
#
##################################################

echo "What is the Domain Name? "
read domain
echo " "
echo "-----------------------------------------------------"
echo " $domain has the following information:"
echo "-----------------------------------------------------"
echo " "
whois $domain | grep 'Name Server:'
echo " "
whois $domain | grep 'Registrar:'
echo " "
whois $domain | grep 'Status:'
echo " "
whois $domain | grep 'Expiration Date:'
echo " "
host $domain | grep 'has address'
ip=`host $domain | grep 'has address' | cut -d " " -f4`
echo " "
echo " $ip IP address is owned by: `whois $ip | grep OrgName: | cut -d" " -f2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19`"
echo " "
echo "----------------------------------------------------"
echo " $domain's MX records:"
echo "----------------------------------------------------"
echo " "
host $domain | grep 'is handled by' | sort
echo " "
echo "----------------------------------------------------"
echo " $domain has the following ports open:"
echo "----------------------------------------------------" 
nmap $domain | grep 'open' | sort -u
echo " "
