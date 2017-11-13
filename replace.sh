#!/bin/sh -
#===============================================================================
#
#          FILE: replace.sh
# 
#         USAGE: ./replace.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: imquanquan (Admin), imquanquan99@gmail.com
#  ORGANIZATION: SCAULUG
#       CREATED: 2017年11月13日 09时01分48秒
#      REVISION:  ---
#===============================================================================

while : ;do
    Mirrors_List=$(sed -n '2,$p' result | awk '{print $1}')
    for mirror in ${Mirrors_List} ; do
	time=$(sed -n "/${mirror} /p" /mirrors/result| grep -Eo '[0-9]{4}-[0-9]{2}-[0-9]{2} [0-9]{2}:[0-9]{2}:[0-9]{2}')
	if  [ "${time}" != "" ]; then
	    sed  -i "/${mirror}\//{n ;s/<TD>.*<\/TD>/<TD>${time}<\/TD>/g}" /Mirrors-Index/index.html
	fi
    done
    sleep 1m
done
