#! /bin/sh

# This script is Free Software under the GNU GPL (>= 3.0)
#
# Import a shapefile into the grass database. This script appends the
# SUFFIX to basename of the Path file.
#
# It creates a new location location with the name: loc_$SUFFIX if it
# doesn't exist.
#

# Arguments
MAP=$1
SUFFIX=$2

# Variables
VMAP="V_$(basename $MAP .shp)_$SUFFIX"
LOCATION="LOC_$SUFFIX"
DBASE="$HOME/Projects/sand_box/grass"

# Environment initialization
export GISRC="/tmp/.grassrc6_$SUFFIX" #temporal GRASS RC file
export GISBASE="/usr/lib/grass64"
export PATH="$PATH:$GISBASE/bin:$GISBASE/scripts"
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$GISBASE/lib"

# Import the map.
if [ -d "$DBASE/LOC_$SUFFIX" ];
then
	RESULT=$(v.in.ogr dsn=$MAP.shp output=$VMAP --quiet);
else
	RESULT=$(v.in.ogr dsn=$MAP.shp output=$VMAP location=$LOCATION --quiet);
fi;

exit $RESULT;