#!/usr/bin/python3
import argparse
import subprocess
from pathlib import Path
import os
import glob
from tqdm import tqdm

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
]

misc = [
    "neofetch",
    "nyancat",
]

dotfile_dir = Path.home() / ".dotFiles"

to_link = {
    Path(dotfile_dir / ".tmux.conf"): Path.home() / ".tmux.conf",
    Path(dotfile_dir / ".zshrc"): Path.home() / ".zshrc",
    Path(dotfile_dir / ".fzf.zsh"): Path.home() / ".fzf.zsh",
    Path(dotfile_dir / ".gitconfig"): Path.home() / ".gitconfig",
    Path(dotfile_dir / "VScode/settings.json"): Path.home() / ".config/Code/User/settings.json",
    Path(dotfile_dir / "VScode/snippets/"): Path.home() / ".config/Code/User/snippets",
    Path(dotfile_dir / "cute.zsh-theme"): Path.home() / ".oh-my-zsh/custom/themes/cute.zsh-theme",
    Path(dotfile_dir / "Uni/sshConfig"): Path.home() / ".ssh/config",
    Path(dotfile_dir / "nvim/"): Path.home() / ".config/nvim",
}

def progress_bar(iterable: list, desc: str, colour: str="green", ascii: bool=True):
    return tqdm(iterable, desc=desc, colour=colour, ascii=ascii)

def add_ppas(log_file, no_log):
    failed_ppas = []
    for ppa in progress_bar(ppas, desc="Adding PPAs", colour="green", ascii=True):
        output = run_cmd(["sudo", "add-apt-repository", ppa, "-y"], log_file, no_log)
        if output.returncode != 0:
            failed_ppas.append(ppa)
    return failed_ppas

def upgrade_system(log_file, no_log):
    upgrade_cmds = [["sudo", "apt", "update"], ["sudo", "apt", "upgrade", "-y"], ["sudo", "snap", "refresh"]]
    failed_upgrades = []
    for cmd in progress_bar(upgrade_cmds, desc="Upgrading system", colour="green", ascii=True):
        output = run_cmd(cmd, log_file, no_log)
        if output.returncode != 0:
            failed_upgrades.append(cmd)
    return failed_upgrades

def link_file(target, name, log_file, no_log, force, dry_run):
    if not dry_run:
        if force:
            output = run_cmd(["ln", "-sf", str(target), str(name)], log_file, no_log)
        else:
            output = run_cmd(["ln", "-s", str(target), str(name)], log_file, no_log)
        if output.returncode != 0:
            return (target, name)
    else:
        print(f"Would link {target} to {name}")
        return None

def link_dotfiles(log_file, no_log, force, dry_run):
    failed_links = []
    for target, name in progress_bar(to_link.items(), desc="Linking dotfiles", colour="green", ascii=True):
        failed_link = link_file(target, name, log_file, no_log, force, dry_run)
        if failed_link:
            failed_links.append(failed_link)
    return failed_links
    

def install_packages(packages: list, log_file: Path, no_log: bool, name: str):
    failed_installations = []
    for package in progress_bar(packages, desc=f"Installing {name}", colour="green", ascii=True):
        output = run_cmd(["sudo", "apt", "install", package, "-y"], log_file, no_log)
        if output.returncode != 0:
            failed_installations.append(package)
    return failed_installations

def install_tools(log_file, no_log):
    failed_tool_installations = install_packages(tools, log_file, no_log, "tools")
    return failed_tool_installations

def install_shell(log_file, no_log):
    failed_shell_installations = install_packages(shell_packages, log_file, no_log, "shell")
    return failed_shell_installations 

def install_editors(log_file, no_log):
    failed_editor_installations = []
    editor_cmds = [["sudo", "snap", "install", "code", "--classic"], ["sudo", "apt", "install", "neovim", "-y"]]
    for cmd in progress_bar(editor_cmds, desc="Installing editors", colour="green", ascii=True):
        output = run_cmd(cmd, log_file, no_log)
        if output.returncode != 0:
            failed_editor_installations.append(cmd)
    return failed_editor_installations

def install_misc(log_file, no_log):
    failed_misc_installations = []
    failed_misc_installations = install_packages(misc, log_file, no_log, "misc")
    return failed_misc_installations

def additional_installations(log_file, no_log):
    failed_additional_installations = []
    # get all bash scripts in additional_install_scripts
    additional_install_scripts = glob.glob("additional_install_scripts/*.sh")
    # TODO: add error handling for scripts since they return 0 even if they fail
    for script in progress_bar(additional_install_scripts, desc="Running additional installation scripts", colour="green", ascii=True):
        output = run_cmd(["sudo", "bash", script], log_file, no_log)
        if output.returncode != 0:
            failed_additional_installations.append(script)
    return failed_additional_installations

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

    parser.add_argument("-l", "--list", help="List packages", action="store_true")
    parser.add_argument("-a", "--all", help="Install all packages and link dotfiles", action="store_true")
    parser.add_argument("-i", "--install", help="Install all packages without linking dotfiles", action="store_true")
    parser.add_argument("-p", "--ppas", help="Add PPAs", action="store_true")
    parser.add_argument("-u", "--upgrade", help="Upgrade system", action="store_true")
    parser.add_argument("-L", "--link", help="Link dotfiles", action="store_true")
    parser.add_argument("--dry", help="Don't link any files", action="store_true")
    parser.add_argument("-s", "--shell", help="Install shell related packages", action="store_true")
    parser.add_argument("-t", "--tools", help="Install general tools", action="store_true")
    parser.add_argument("-e", "--editors", help="Install all editors that I currently use", action="store_true")
    parser.add_argument("-m", "--misc", help="Install misc packages", action="store_true")
    parser.add_argument("-A", "--additional", help="Execute the scripts in the additional_install_scripts folder", action="store_true")
    parser.add_argument("--no-log", help="Don't log output of executed commands", action="store_true", default=False)
    parser.add_argument('-F', '--log-file', help="Specify the log file name. Default is \"log.txt\"", default=Path('log.txt'))
    parser.add_argument("--no-color", help="Disable color output", action="store_true")
    parser.add_argument("-f", "--force", help="Force all checks to pass", action="store_true")
    parser.add_argument("-v", "--version", help="Print version and exit", action="store_true")


    args = parser.parse_args()

    if args.list:
        print("List")
        exit(0)

    if args.all:
        args.install = True
        args.link = True

    if args.install:
        args.ppas = True
        args.upgrade = True
        args.shell = True
        args.tools = True
        args.editors = True
        args.misc = True
        args.additional = True

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
            if not args.force:
                print(f"{colors.FAIL}Log file \"{args.log_file}\" already exists. Use -f to force overwrite.{colors.ENDC}")
                exit(1)
            os.remove(args.log_file)

    # initialize lists for failed installations
    failed_ppas = []
    failed_upgrades = []
    failed_installations = []
    failed_bash_scripts = []
    failed_linking = []

    run_cmd(["sudo", "echo", "-n", ""], args.log_file, True) # ask for sudo password
    
    # add PPAs
    if args.ppas:
        failed_ppas = add_ppas(args.log_file, args.no_log)

    # upgrade system
    if args.upgrade:
        failed_upgrades = upgrade_system(args.log_file, args.no_log)

    # install packages
    if args.shell:
        failed_installations.extend(install_shell(args.log_file, args.no_log))

    if args.tools:
        failed_installations.extend(install_tools(args.log_file, args.no_log))

    if args.editors:
        failed_installations.extend(install_editors(args.log_file, args.no_log))

    if args.misc:
        failed_installations.extend(install_misc(args.log_file, args.no_log))

    # run additional bash scripts
    if args.additional:
        failed_bash_scripts = additional_installations(args.log_file, args.no_log)

    # link dotfiles
    if args.link:
        failed_linking = link_dotfiles(args.log_file, args.no_log, args.force, args.dry)

    if not args.no_log:
        log = open(args.log_file, "a")

    # print failed installations
    if len(failed_ppas) > 0:
        print(f"\n{colors.FAIL}Failed to add the following PPAs:{colors.ENDC}")
        for ppa in failed_ppas:
            print(ppa)
            log.write(f"Failed to add PPA: {ppa}")

    if len(failed_upgrades) > 0:
        print(f"\n{colors.FAIL}Failed to execute the following commands:{colors.ENDC}")
        for cmd in failed_upgrades:
            print(' '.join(cmd))
            log.write(f"Failed to execute command: {' '.join(cmd)}")

    if len(failed_installations) > 0:
        print(f"\n{colors.FAIL}Failed to install the following packages:{colors.ENDC}")
        for package in failed_installations:
            print(package)
            log.write(f"Failed to install package: {package}")

    if len(failed_bash_scripts) > 0:
        print(f"\n{colors.FAIL}Failed to execute the following bash scripts:{colors.ENDC}")
        for script in failed_bash_scripts:
            print(script)
            log.write(f"Failed to execute bash script: {script}")

    if not args.no_log:
        log.close()


