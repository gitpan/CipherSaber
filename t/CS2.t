# now do a bidirectional check with CS-2

use Crypt::CipherSaber;

print "1..1\n";

my $cs2 = Crypt::CipherSaber->new('second key', 5);
my $long_line = join(' ', (1 .. 100));
my $coded = $cs2->encrypt($long_line);

if ($long_line = $cs2->decrypt($coded)) {
	print "ok 1\n";
} else {
	print "not ok 1\n";
}
