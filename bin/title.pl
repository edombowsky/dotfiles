#!/usr/bin/env perl

# title.pl - sends xterm escape sequence to
# change window title to @ARGV

$esc = "\x1b";
$bel = "\x7";

$txt = join(" ", @ARGV);

print $esc, "];", $txt, $bel;
