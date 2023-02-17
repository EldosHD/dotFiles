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

ppas = [
    "ppa:neovim-ppa/unstable",
]

tools = [
    "curl",
    "wget",
    "git",
    "python3",
    "python3-pip",
    "fzf",
    "htop",
]


shell_packages = [
        "tmux",
        "zsh",
        "fonts-powerline",
        # "oh-my-zsh",
        # tmux mem program
]


# Print iterations progress
# credit: https://stackoverflow.com/questions/3173320/text-progress-bar-in-the-console
def printProgressBar (iteration, total, prefix = '', suffix = '', decimals = 1, length = 100, fill = '█', printEnd = "\r"):
    """
    Call in a loop to create terminal progress bar
    @params:
        iteration   - Required  : current iteration (Int)
        total       - Required  : total iterations (Int)
        prefix      - Optional  : prefix string (Str)
        suffix      - Optional  : suffix string (Str)
        decimals    - Optional  : positive number of decimals in percent complete (Int)
        length      - Optional  : character length of bar (Int)
        fill        - Optional  : bar fill character (Str)
        printEnd    - Optional  : end character (e.g. "\r", "\r\n") (Str)
    """
    percent = ("{0:." + str(decimals) + "f}").format(100 * (iteration / float(total)))
    filledLength = int(length * iteration // total)
    bar = fill * filledLength + '-' * (length - filledLength)
    print(f'\r{prefix} [{bar}] {percent}% {suffix}', end = printEnd)
    # Print New Line on Complete
    if iteration == total: 
        print()

def add_ppas(log_file, no_log):
    print("Adding PPAs")
    failed_ppas = []
    for ppa in ppas:
        output = run_cmd(["sudo", "add-apt-repository", ppa, "-y"], log_file, no_log)
        if output.returncode != 0:
            failed_ppas.append(ppa)
    if len(failed_ppas) == 0:
        print(f"{colors.OKGREEN}All PPAs added successfully{colors.ENDC}")
    return failed_ppas

def link_dotfiles():
    print("Linking dotfiles")

def install_packages(packages, log_file, no_log):
    failed_installations = []
    printProgressBar(0, len(packages), prefix = 'Progress:', suffix = 'Complete', length = 50, fill="=")
    for package in packages:
        # print(f"Installing {package}")
        output = run_cmd(["sudo", "apt", "install", package, "-y"], log_file, no_log)
        if output.returncode != 0:
            # print(f"{colors.FAIL}Failed to install {package}{colors.ENDC}")
            failed_installations.append(package)
        printProgressBar(packages.index(package) + 1, len(packages), prefix = 'Progress:', suffix = 'Complete', length = 50, fill="=")
    return failed_installations

def install_tools(log_file, no_log):
    print("Installing tools")
    failed_tool_installations = install_packages(tools, log_file, no_log)
    return failed_tool_installations

def install_shell(log_file, no_log):
    print("Installing shell")
    failed_shell_installations = install_packages(shell_packages, log_file, no_log)
    return failed_shell_installations 

def install_editors(log_file, no_log):
    # TODOOOO: Editors
    print("Installing editors")
    failed_editor_installations = []
    failed_editor_installations.extend(install_packages(["neovim"], log_file, no_log))
    return failed_editor_installations

def install_misc(log_file, no_log):
    print("Installing misc")

def additonal_installations(log_file, no_log):
    print("Installing additional programs")

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

def run_cmd_with_msg(cmd, log_file, no_log, msg_before, msg_after_OK, msg_after_FAIL):
    print(msg_before)
    output = run_cmd(cmd, log_file, no_log)
    if output.returncode == 0:
        print(f"{colors.OKGREEN}{msg_after_OK}{colors.ENDC}")
    else:
        print(f"{colors.FAIL}{msg_after_FAIL}{colors.ENDC}")




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

    if args.no_color:
        colors.HEADER = ""
        colors.OKBLUE = ""
        colors.OKGREEN = ""
        colors.WARNING = ""
        colors.FAIL = ""
        colors.ENDC = ""
        colors.BOLD = ""
        colors.UNDERLINE = ""

    if not args.no_log:
        if args.log_file.exists():
            if not args.yes:
                print(f"Log file {args.log_file} already exists. Do you want to overwrite it? [y/N]")
                if input().lower() != "y":
                    print("Exiting")
                    exit(0)
            os.remove(args.log_file)

    failed_ppas = add_ppas(args.log_file, args.no_log)

    run_cmd_with_msg(["sudo", "apt", "update"], args.log_file, args.no_log, "Updating package list", "Done", "Failed to update package list")
    run_cmd_with_msg(["sudo", "apt", "upgrade", "-y"], args.log_file, args.no_log, "Upgrading packages", "Done", "Failed to upgrade packages")
    run_cmd_with_msg(["sudo", "snap", "refresh"], args.log_file, args.no_log, "Refreshing snaps", "Done", "Failed to refresh snaps")

    # install packages
    failed_installations = []

    if args.shell:
        failed_installations.extend(install_shell(args.log_file, args.no_log))

    if args.tools:
        failed_installations.extend(install_tools(args.log_file, args.no_log))

    if args.editors:
        failed_installations.extend(install_editors(args.log_file, args.no_log))

    print(f"{colors.OKGREEN}Done{colors.ENDC}")
    if len(failed_ppas) > 0:
        print(f"\n\n{colors.FAIL}Failed to add the following PPAs:{colors.ENDC}")
        for ppa in failed_ppas:
            print(ppa)

    if len(failed_installations) > 0:
        print(f"\n\n{colors.FAIL}Failed to install the following packages:{colors.ENDC}")
        for package in failed_installations:
            print(package)


