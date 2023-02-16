#!/usr/bin/bash
# script to print out all the python modules installed in the current environment without the version number
pip freeze | sed "s/=.*//"

