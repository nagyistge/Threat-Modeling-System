#!/bin/sh
#
# This script is Free Software under the GNU GPL (>= 3.0)
#
# Description: Return a list with the availables columns and its data type
#

# Arguments
LAYER=$1
SUFFIX=$2

# configure environment
SCRIPTS_DIR=`dirname $0`
. $SCRIPTS_DIR/set_grass_variables.sh $SUFFIX

v.info -c map=$LAYER$VMAP | awk -F'|' '{ printf "%s:%s\r",$2,$1}';

exit 0;
