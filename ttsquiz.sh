#!/bin/sh
DIR=`dirname $0`
DIR=`readlink -f ${DIR}`
ruby -I${DIR}/lib ${DIR}/bin/ttsquiz.rb "$@"

