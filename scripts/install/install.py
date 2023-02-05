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

    parser.add_argument("-v", "--version", help="Print version and exit", action="store_true")
    parser.add_argument("-l", "--list", help="List packages", action="store_true")
    parser.add_argument("-L", "--link", help="Link dotfiles", action="store_true")
    parser.add_argument("-a", "--all", help="Install all packages", action="store_true")
    parser.add_argument("-s", "--shell", help="Install shell related packages", action="store_true")
    parser.add_argument("-t", "--tools", help="Install general tools", action="store_true")
    parser.add_argument("-e", "--editors", help="Install all editors that I currently use", action="store_true")
    parser.add_argument("-m", "--misc", help="Install misc packages", action="store_true")
    args = parser.parse_args()
