use Crypt::CipherSaber;

print "1..1\n";

# first, try to create an object
my $cs = Crypt::CipherSaber->new('first key') or die "not ok 2";
if (defined($cs)) {
	print "ok 1\n";
} else {
	print "not ok 1\n";
}
