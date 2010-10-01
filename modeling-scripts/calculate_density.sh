#!/bin/sh
#
# This script is Free Software under the GNU GPL (>= 3.0)
#
# Description: Sets the new categories to a map.
#

# Arguments
LAYER=$1
RADIUS=$2
SUFFIX=$3

# configure environment
SCRIPTS_DIR=`dirname $0`
. $SCRIPTS_DIR/set_grass_variables.sh $SUFFIX

TEMPORAL_MAP="temp_$SUFFIX"

r.neighbors -c input=$LAYER$RMAP output=$TEMPORAL_MAP method=sum size=$RADIUS  --quiet --overwrite
r.mapcalc "$LAYER$RRMAP = ($TEMPORAL_MAP/$RADIUS.0)*1000";

exit 0;