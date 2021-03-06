#!/bin/sh

# IBM DOES NOT WARRANT OR REPRESENT THAT THE CODE PROVIDED IS COMPLETE OR UP-TO-DATE.
# IBM DOES NOT WARRANT, REPRESENT OR IMPLY RELIABILITY, SERVICEABILITY OR FUNCTION OF THE CODE.
# IBM IS UNDER NO OBLIGATION TO UPDATE CONTENT NOR PROVIDE FURTHER SUPPORT. 

# ALL CODE IS PROVIDED "AS IS," WITH NO WARRANTIES OR GUARANTEES WHATSOEVER.
# IBM EXPRESSLY DISCLAIMS TO THE FULLEST EXTENT PERMITTED BY LAW ALL EXPRESS, IMPLIED,
# STATUTORY AND OTHER WARRANTIES, GUARANTEES, OR REPRESENTATIONS, INCLUDING, WITHOUT LIMITATION,
# THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE, AND NON-INFRINGEMENT OF
# PROPRIETARY AND INTELLECTUAL PROPERTY RIGHTS.  YOU UNDERSTAND AND AGREE THAT YOU USE THESE MATERIALS,
# INFORMATION, PRODUCTS, SOFTWARE, PROGRAMS, AND SERVICES, AT YOUR OWN DISCRETION AND RISK AND
# THAT YOU WILL BE SOLELY RESPONSIBLE FOR ANY DAMAGES THAT MAY RESULT, INCLUDING LOSS OF DATA
# OR DAMAGE TO YOUR COMPUTER SYSTEM.

# IN NO EVENT WILL IBM BE LIABLE TO ANY PARTY FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
# EXEMPLARY OR CONSEQUENTIAL DAMAGES OF ANY TYPE WHATSOEVER RELATED TO OR ARISING FROM USE OF
# THE CODE FOUND HEREIN, WITHOUT LIMITATION, ANY LOST PROFITS, BUSINESS INTERRUPTION, LOST SAVINGS,
# LOSS OF PROGRAMS OR OTHER DATA, EVEN IF IBM IS EXPRESSLY ADVISED OF THE POSSIBILITY OF SUCH DAMAGES.
# THIS EXCLUSION AND WAIVER OF LIABILITY APPLIES TO ALL CAUSES OF ACTION, WHETHER BASED ON CONTRACT,
# WARRANTY, TORT OR ANY OTHER LEGAL THEORIES.

openAS2=/opt/OpenAS2

config=${1:-''}
if [ -z "$config" ] ; then
  for i in config myCompany myPartner ; do
    config=$i.xml
    [ -s "$config" ] && break
  done
fi
[ ! -s "$config" ] && echo "${0##*/}: cannot find configuration file $config" && exit

echo "Starting OpenAS2 with file $config"

libDir=$openAS2/lib
ARGS="-Xms32m -Xmx384m"
debug="-Dorg.apache.commons.logging.Log=org.openas2.logging.Log"
Main="org.openas2.app.OpenAS2Server"
CP="."
for jar in  activation.jar mail.jar bcprov-jdk16-143.jar \
            bcmail-jdk16-143.jar commons-logging-1.1.1.jar \
            openas2-lib.jar ; do
  if [ ! -s "${libDir}/${jar}" ] ; then
    echo "${0##*/}: cannot find ${libDir}/${jar}"
    exit 1
  fi
  CP="${CP}:${libDir}/${jar}"
done

java $ARGS $debug -cp $CP $Main $config

