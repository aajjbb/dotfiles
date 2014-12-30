#!/usr/bin/perl

use strict;
use warnings;

#WOWJS35OFF

my $root = "~/";
my $current_dir = $ENV{'PWD'};

my @files = {
	".emacs.d" => $root,
	".weechat" => $root,
	"awesome" => $root . ".config/",
	".Xresources" => $root,
	".Xdefaults" => $root,
	".bash_profile" => $root,
	".bashrc" => $root,
	".emacs" => $root,
	".gitconfig" => $root,
	".tmux.conf" => $root,
	".vimrc" => $root,
	".Xresources" => $root,
};

sub install {
	
}

sub update {

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
