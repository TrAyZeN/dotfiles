# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
    . "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

export XDG_CONFIG_HOME="$HOME/.config"

export EDITOR="nvim"

export PGDATA="$HOME/postgres_data"
export PGHOST="/tmp"
export GTK_THEME="Qogir:dark"


install_dir="$HOME/opt"
caravel_dir_name="caravel_user_project"

export PDK_ROOT="$install_dir/pdk"
export OPENLANE_ROOT=$install_dir/openlane
export PDK="sky130A"

export MGMT_AREA_ROOT="$install_dir/$caravel_dir_name/mgmt_core_wrapper"
export DESIGNS="$install_dir/$caravel_dir_name"
export TARGET_PATH="$DESIGNS"
export CARAVEL_ROOT="$DESIGNS/caravel"
export MCW_ROOT="$DESIGNS/mgmt_core_wrapper"
export CORE_VERILOG_PATH="$MCW_ROOT/verilog"

export PATH="$PATH:$install_dir/oss-cad-suite/bin"

export GCC_PATH="$install_dir/riscv64-unknown-elf-toolchain-10.2.0-2020.12.8-x86_64-linux-ubuntu14/bin/"
export PATH="$PATH:$GCC_PATH"
export GCC_PREFIX="riscv64-unknown-elf"

export PATH="$PATH:$install_dir/openlane_summary"

export PATH="$PATH:$HOME/opt/openEMS/bin"


export QSYS_ROOTDIR="$HOME/opt/intelFPGA_lite/23.1std/quartus/sopc_builder/bin"

# cargo
[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"

# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
