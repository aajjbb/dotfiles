#!/usr/bin/perl

use strict;
use warnings;

use feature 'say';

my $root = $ENV{'HOME'};
my $current_dir = $ENV{'PWD'};

my %files = (
    #awesome
    "freedesktop"     => $root . "/.config/awesome",
    "starbreaker"     => $root . "/.config/awesome/themes",

    "menugen.lua"     => $root . "/.config/awesome",
    "rc.lua"          => $root . "/.config/awesome",

    #general
    ".bash_profile"   => $root,
    ".bashrc"         => $root,
    ".emacs"          => $root,
	"xclip.el"		  => $root . "/.emacs.d",
    ".gitconfig"      => $root,
    ".tmux.conf"      => $root,
    ".vimrc"          => $root,
    ".Xresources"     => $root,
);

=doc
    Install dotfiles of the current repository for the current user in the system
=cut

sub install {
    foreach my $key (keys %files) {
        my $source_file = $current_dir . "/" . $key;
        my $destiny_file = $files{$key} . "/" . $key;

        print("Installing " . $key . " in " . $destiny_file . "\n");

        my $result = `cp -TR $source_file $destiny_file`;

        if ($result) {
            say "Failed to install " . $key . " is probably being used by other application or it does not exists";
        }
    }
}

=doc
    Updates the current system dotfiles to the repository
=cut

sub update {
    foreach my $key (keys %files) {
        my $source_file = $files{$key} . "/" . $key;
        my $destiny_file = $current_dir . "/" . $key;

        print("Uploading " . $source_file . " in " . $destiny_file . "\n");

        my $result = `cp -TR $source_file $destiny_file`;

        if ($result) {
            say "Failed to update " . $key . " is probably being used by other application  or it does not exists";
        }
    }
}

if ($#ARGV != 0) {
    print("Usage: perl dotmanager.pl [OPTIONS]\n --install [Install current files in repository to system]\n --update [Update files in repository with ones from the system]\n");
} else {
    if ($ARGV[0] eq "--install") {
        install;
    } elsif ($ARGV[0] eq "--update") {
        update;
    } else {
        print("Invalid argument");
    }
}
