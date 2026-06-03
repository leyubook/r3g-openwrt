use strict;
use warnings;

my $file = "/root/openwrt/scripts/download.pl";
open(my $fh, "<", $file) or die "Cannot open: $!";
my @lines = <$fh>;
close $fh;

open($fh, ">", $file) or die "Cannot write: $!";

my $in_github_block = 0;
my $in_else = 0;
my $else_done = 0;

for (my $i = 0; $i < @lines; $i++) {
    my $line = $lines[$i];

    # Detect @GITHUB handler block
    if ($line =~ /\@GITHUB/) {
        $in_github_block = 1;
    }

    # Patch: before the for loop in @GITHUB, add gh-proxy mirror
    if ($in_github_block && $line =~ /for \(1 \.\. 5\)/) {
        print $fh "\t\tpush \@mirrors, \"https://gh-proxy.com/https://github.com/\$1\";\n";
        $in_github_block = 0;
    }

    # Detect else clause
    if ($line =~ /^\s*\} else \{/) {
        $in_else = 1;
        print $fh $line;
        next;
    }

    # Patch else clause: wrap the push with github check
    if ($in_else && !$else_done && $line =~ /push \@mirrors, \$mirror/) {
        print $fh "\t\tif (\$mirror =~ /^https:\\/\\/github\\.com\\//) {\n";
        print $fh "\t\t\tmy \$mirror_path = \$mirror;\n";
        print $fh "\t\t\t\$mirror_path =~ s/^https:\\/\\/github\\.com\\//https:\\/\\/gh-proxy.com\\/https:\\/\\/github\\.com\\//;\n";
        print $fh "\t\t\tpush \@mirrors, \$mirror_path;\n";
        print $fh "\t\t}\n";
        $else_done = 1;
        $in_else = 0;
    }

    print $fh $line;
}

close $fh;
print "download.pl patched successfully\n";
