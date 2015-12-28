#!/usr/bin/perl

use strict;
use warnings;

use File::Copy::Recursive qw(dircopy fcopy);

use feature 'say';

my $root = $ENV{'HOME'}; 
my $current_dir = $ENV{'PWD'};

my %files = (
	#awesome
	"freedesktop" => $root . "/.config/awesome",
	"scratchdrop" => $root . "/.config/awesome",
	"starbreaker" => $root . "/.config/awesome/themes",
	
	"menugen.lua" => $root . "/.config/awesome",
	"rc.lua"      => $root . "/.config/awesome",
	"widgets.lua" => $root . "/.config/awesome",
	"xrandr.lua"  => $root . "/.config/awesome",

	#weechat
	".weechat/irc.conf" => $root . "/weechat",
	".weechat/plugins.conf" => $root . "/weechat",

	#general
	".bash_profile" => $root,
	".bashrc" => $root,
	".emacs" => $root,
	".gitconfig" => $root,
	".tmux.conf" => $root,
	".vimrc" => $root,
	".xbindkeysrc" => $root,	
	".Xresources" => $root,	
);

=doc
	Install dotfiles of the current repository for the current user in the system
=cut

sub install {
	foreach my $key (keys %files) {
		my $source_file = $current_dir . "/" . $key;
		my $destiny_file = $files{$key} . "/" . $key;

		print("Installing " . $key . " in " . $destiny_file . "\n");
		
		if (-d $source_file) {
			if (!dircopy($source_file, $destiny_file)) {
				say "Failed to install " . $key . " is probably being used by other application";
			}
		} else {
			if (!fcopy($source_file, $destiny_file)) {
				say "Failed to install " . $key . " is probably being used by other application";
			}
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
		
		if (-d $source_file) {
			if (!dircopy($source_file, $destiny_file)) {
				say "Failed to update " . $key . " is probably being used by other application";
			}
		} else {
			if (!fcopy($source_file, $destiny_file)) {
				say "Failed to update " . $key . " is probably being used by other application";
			}
		}
	}
}

if ($#ARGV != 0) {
	print("perl dotmanager.pl -install \nperl dotmanager.pl -update\n");
} else {
	if ($ARGV[0] eq "-install") {
		install;
	} elsif ($ARGV[0] eq "-update") {
		update;
	} else {
		print("Invalid argument");
	}
}
