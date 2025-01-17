#!/bin/bash

nevents=$1
job_id=$2

if [ -z "$CONDOR_DIR_INPUT" -o -z "$CONDOR_DIR_OUTPUT" ] ; then
    echo "!ERROR!  CONDOR_DIR_INPUT/OUTPUT is undefined.  Abort."
    exit 1
fi
echo "INPUT  = $CONDOR_DIR_INPUT"
echo "OUTPUT = $CONDOR_DIR_OUTPUT"
echo "HOST   = $HOSTNAME"
echo "PWD    = $PWD"

tar xzf $CONDOR_DIR_INPUT/input.tar.gz

E1039_CORE_VERSION=pr.112
FN_SETUP=/e906/app/software/osg/software/e1039/this-e1039.sh
if [ ! -e $FN_SETUP ] ; then # On grid
    FN_SETUP=/cvmfs/seaquest.opensciencegrid.org/seaquest/${FN_SETUP#/e906/app/software/osg/}
fi
echo "SETUP = $FN_SETUP"
source $FN_SETUP
export   LD_LIBRARY_PATH=inst/lib:$LD_LIBRARY_PATH
export ROOT_INCLUDE_PATH=inst/include:$ROOT_INCLUDE_PATH

time root -b -q Fun4Sim.C\($nevents\)
RET=$?
if [ $RET -ne 0 ] ; then
    echo "Error in Fun4Sim.C: $RET"
    exit $RET
fi

mv  *.root *.tsv  $CONDOR_DIR_OUTPUT

echo "gridrun.sh finished!"
