#!/usr/bin/python3
import argparse
import subprocess
from pathlib import Path
import os

version = "1.0.0"                                                                              
description="TODO: Insert description"
epilog = f"""                                                                                  
Written by: EldosHD                                                                            
Version: {version}                                                                             
This program is licensed under the GNU General Public License v3.0"""

class colors:
    HEADER = '\033[95m'
    OKBLUE = '\033[94m'
    OKGREEN = '\033[92m'
    WARNING = '\033[93m'
    FAIL = '\033[91m'
    ENDC = '\033[0m'
    BOLD = '\033[1m'
    UNDERLINE = '\033[4m'

tools = [
    "curl",
    "wget",
    "git",
    "python3",
    "python3-pip",


shell_packages = [
        "tmux",
        "zsh",
        "fonts-powerline",
        # "oh-my-zsh",
        # tmux mem program
]

editors = [
        "nvim",        
        # TODO: nvim has to be unstable realease
]

def link_dotfiles():
    print("Linking dotfiles")

def install_packages(packages, log_file, no_log):
    failed_installations = []
    for package in packages:
        print(f"Installing {package}")
        output = run_cmd(["sudo", "apt", "install", package, "-y"], log_file, no_log)
        if output.returncode != 0:
            print(f"{colors.FAIL}Failed to install {package}{colors.ENDC}")
            failed_installations.append(package)
    return failed_installations

def install_tools():
    print("Installing tools")

def install_shell():
    print("Installing shell")
    failed_shell_installations = install_packages(shell_packages, args.log_file, args.no_log)
    # TODO: install oh-my-zsh
    # TODO: tmux mem program
    return failed_shell_installations 

def install_editors():
    print("Installing editors")

def install_misc():
    print("Installing misc")

def write_to_log(cmd, message, log_file, no_log):
    if not no_log:
        with open(log_file, "a") as log:
            log.write(f"{' '.join(cmd)}\n")
            log.write(message)
            log.write("\n")
            log.close()

def run_cmd(cmd, log_file, no_log):
    output = subprocess.run(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    output.stdout = output.stdout.decode("utf-8")
    write_to_log(cmd, output.stdout, log_file, no_log)
    return output



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
    parser.add_argument('-f', '--log-file', help="Specify the log file name. Default is \"log.txt\"", default=Path('log.txt'))
    parser.add_argument("--no-log", help="Don't log output of executed commands", action="store_true", default=False)
    parser.add_argument("--no-color", help="Disable color output", action="store_true")
    parser.add_argument('-y', '--yes', help="Answer yes to all questions", action="store_true")

    args = parser.parse_args()

    if args.all:
        args.link = True
        args.shell = True
        args.tools = True
        args.editors = True
        args.misc = True

    if not args.no_log:
        if args.log_file.exists():
            if not args.yes:
                print(f"Log file {args.log_file} already exists. Do you want to overwrite it? [y/N]")
                if input().lower() != "y":
                    print("Exiting")
                    exit(0)
            os.remove(args.log_file)

    print("Updating packages")
    update = run_cmd(["sudo", "apt", "update"], args.log_file, args.no_log)
    upgrade = run_cmd(["sudo", "apt", "upgrade", "-y"], args.log_file, args.no_log)
    if upgrade.returncode != 0 or update.returncode:
        print(f"{colors.FAIL}Failed to update packages{colors.ENDC}")
        exit(1)
    else:
        print(f"{colors.OKGREEN}Updated packages{colors.ENDC}")

    # install packages
    failed_installations = []

    if args.shell:
        failed_installations.extend(install_shell())

    print("Done")
    if len(failed_installations) > 0:
        print(f"\n\n{colors.FAIL}Failed to install the following packages:{colors.ENDC}")
        for package in failed_installations:
            print(package)

