#!/usr/bin/perl

use strict;
use warnings;

use feature 'say';

my $root = $ENV{'HOME'};
my $current_dir = $ENV{'PWD'};

my %files = (
    # awesome-wm
    # awesome depends on other packages:
    # (awesome-copycats, awesome-revelation, freedesktop)
    ".config/awesome/rc.lua"        => $root,
    ".config/awesome/xrandr.lua"    => $root,

    # i3 config
    ".config/i3/config"   => $root,
    ".config/i3/init.sh"  => $root,

    # kitty config
    ".config/kitty/kitty.conf" => $root,

    #general
    ".bash_profile"         => $root,
    ".bashrc"               => $root,
    ".config/.compton.conf" => $root,
    ".emacs"                => $root,
    ".gitconfig"            => $root,
    ".spacemacs"            => $root,
    ".tmux.conf"            => $root,
    ".vimrc"                => $root,
    ".Xresources"           => $root,
    ".zshrc"                => $root,

    #scripts
    ".bin/lock.sh"      => $root,
    ".bin/suspend.sh" => $root,
);

=doc
    Reads input prompt and returns answer (taken from StackOverflow)
=cut

sub prompt {
    my ($query) = @_;
    local $| = 1;
    print $query;
    chomp(my $answer = <STDIN>);
    return $answer;
}

=doc
    Install dotfiles of the current repository for the current user in the system
=cut

sub install {
    my $skip = shift;

    print("Starting the Installing Process \n");

    foreach my $key (keys %files) {
        my $source_file = $current_dir . "/" . $key;
        my $destiny_file = $files{$key} . "/" . $key;

        if (not $skip) {
            my $answer = prompt("Are you sure you want to install $key ? [y/n]");

            if (not ($answer eq 'y' || $answer eq 'Y')) {
                print("Skipping $key update\n");
                next;
            }
        }

        print("Installing " . $key . " in " . $destiny_file . "\n");

        my $result = `ln -s $source_file $destiny_file`;

        if ($result) {
            say "Failed to install " . $key . " is probably being used by other application or it does not exists";
        }
    }
}

=doc
    Updates the current system dotfiles to the repository
=cut

sub update {
    my $skip = shift;
    print("Starting the Uploading Process\n");

    foreach my $key (keys %files) {
        my $source_file = $files{$key} . "/" . $key;
        my $destiny_file = $current_dir . "/" . $key;

        if (not $skip) {
            my $answer = prompt("Are you sure you want to upload $key ? [y/n]");

            if (not ($answer eq 'y' || $answer eq 'Y')) {
                print("Skipping $key update\n");
                next;
            }
        }
        print("Uploading " . $source_file . " in " . $destiny_file . "\n");

        my $result = `cp -TR $source_file $destiny_file`;

        if ($result) {
            print("Failed to update " . $key . " is probably being used by other application  or it does not exists\n");
        }
    }
}

my $usage = "Usage: perl dotmanager.pl [OPTION] [BYPASS]\n
  Options:
    install [Install current files in repository to system]\n
    update [Update files in repository with ones from the system]\n
  Bypass:
    --skip [Skip Confirmations]\n
    ";

if ($#ARGV > 2) {
    print($usage);
} else {
    my $option = $ARGV[0];
    my $bypass = ($ARGV[1] and ($ARGV[1] eq "--skip")) or 0;

    if ($option eq "install") {
        install($bypass);
    } elsif ($option eq "update") {
        update($bypass);
    } else {
        print("Invalid argument\n$usage");
    }
}
