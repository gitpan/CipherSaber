# encrypt and decrypt a line greater than 256 characters long
# this tests for a subtle bug, ie, missing a modulo on $i

use Crypt::CipherSaber;

print "1..1\n";

my $cs = new Crypt::CipherSaber ('first key');
my $long_line = join(' ', (1 .. 100));
my $coded = $cs->encrypt($long_line);

if ($long_line = $cs->decrypt($coded)) {
	print "ok 1\n";
} else {
	print "not ok 1\n";
}
