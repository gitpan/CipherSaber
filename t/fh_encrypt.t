# tests the fh_encrypt() method
# this will fail if the state array is not reinitialized ... oops!
use Crypt::CipherSaber;
use File::Spec;

my $crypt_in = File::Spec->catfile('t', 'smiles.cs1');
my $crypt_out = File::Spec->catfile('t', 'outsmiles.cs1');
my $img_in = File::Spec->catfile('t', 'smiles.png');
my $img_out = File::Spec->catfile('t', 'outsmiles.png');

print "1..4\n";

open(IN, $crypt_in) or die "Can't get IV!\n";
binmode(IN);
my $iv = unpack("a10", <IN>);

# encrypt a message
my $cs = Crypt::CipherSaber->new('sdrawkcabsihtdaeR');
open(IN, $img_in) or die "Can't open input file!\n";
open(OUT, '>'. $crypt_out) or die "Can't open output file!\n";
binmode(IN);
binmode(OUT);

if ($cs->fh_crypt(\*IN, \*OUT, $iv)) {
	print "ok 1\n";
} else {
	print "not ok 1\n";
}

open(ENCRYPTED, $crypt_out) or die "Can't open encrypted file!\n";
open(FIXED, $crypt_in) or die "Can't open fixed file!\n";
binmode(ENCRYPTED);
binmode(FIXED);

my $status = 0;
while (<ENCRYPTED>) {
	my $fixed = <FIXED>;
	my $pos = 0;
	for my $char (split(//, $_)) {
		next if (substr($fixed, $pos++, 1) eq $char);
		$status = 1;
	}
	last if $status;
}

if ($status == 0) {
	print "ok 2\n";
} else {
	print "not ok 2\n";
}

open(IN, $crypt_in) or die "Can't open input file 2!\n";
open(OUT, '>' . $img_out) or die "Can't open output file 2!\n";
binmode(IN);
binmode(OUT);

if ($cs->fh_crypt(\*IN, \*OUT)) {
	print "ok 3\n";
} else {
	print "not ok 3\n";
}

close(IN);
close(OUT);

open(ENCRYPTED, $img_out) or die "Can't open encrypted file!\n";
open(FIXED, $img_in) or die "Can't open fixed file!\n";
binmode(ENCRYPTED);
binmode(FIXED);

$status = 0;
while (<ENCRYPTED>) {
	my $fixed = <FIXED>;
	my $pos = 0;
	for my $char (split(//, $_)) {
		next if (substr($fixed, $pos++, 1) eq $char);
		$status = 1;
		print STDERR "Error at line $.\n";
		last;
	}
	last if $status;
}

close(ENCRYPTED);
close(FIXED);

if ($status == 0) {
	print "ok 4\n";
} else {
	print "not ok 4\n";
}
