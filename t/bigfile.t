# test to see if we can decrypt files via filehandles 
# this tests for a subtle bug, ie, missing a modulo on $i

use Crypt::CipherSaber;
use File::Spec;

print "1..1\n";

my $cs = new Crypt::CipherSaber ('sdrawkcabsihtdaeR');
open(INPUT, File::Spec->catfile('t', 'smiles.cs1')) or die "Couldn't open: $!";
binmode(INPUT);
open(OUTPUT, '>' . File::Spec->catfile('t', 'smiles.png')) 
	or die "Couldn't open: $!";
binmode(OUTPUT);
$cs->fh_crypt(\*INPUT, \*OUTPUT);
close INPUT;
close OUTPUT;

open(TEST, File::Spec->catfile('t', 'smiles.png')) or die "Couldn't open: $!";
my $line = <TEST>;

if ($line =~ /PNG/) {
	print "ok 1\n";
} else {
	print "not ok 1\n";
}
