#!/usr/bin/python3
import argparse

version = "1.0.0"                                                                              
description="TODO: Insert description"
epilog = f"""                                                                                  
Written by: EldosHD                                                                            
Version: {version}                                                                             
This program is licensed under the GNU General Public License v3.0"""

def installShell():
    print("Installing shell")

if(__name__ == "__main__"):
    parser = argparse.ArgumentParser(formatter_class=argparse.RawDescriptionHelpFormatter, description=description, epilog=epilog)



    args = parser.parse_args()
