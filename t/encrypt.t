use Crypt::CipherSaber;

print "1..2\n";

# encrypt a message
my $cs = Crypt::CipherSaber->new('asdfg');
my $coded = $cs->crypt('abcdefghij', 'This is another test.');
my $message = join('', map { chr } qw ( 153 90 51 37 126 114 217 0 50 245 103 36 219 18 4 44 169 53 32 64 15 ));

if ($coded eq $message) {
	print "ok 1\n";
} else {
	print "not ok 1\n";
}

# decrypt a previously encrypted message
$message = join('', map{ chr } qw( 99 228 225 111 163 246 142 168 143 125 239 199 167 58 192 81 211 122 19 200 97 57 101 151 19 ));

if ($cs->decrypt($message) eq 'This is a test.') {
	print "ok 2\n";
} else {
	print "not ok 2\n";
}
