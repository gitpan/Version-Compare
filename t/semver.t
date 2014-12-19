use Test::More qw( no_plan );

use Version::Compare;

# Test version_compare
# this tests use the examples from the semantic versioning spec 2.0.0.
# see also https://github.com/blang/semver/blob/master/semver_test.go
{
  my %version = (
    '1.0.0 eq 1.0.0'                => [ '1.0.0',         '1.0.0',         0 ],
    '2.0.0 gt 1.0.0'                => [ '2.0.0',         '1.0.0',         1 ],
    '0.1.0 eq 0.1.0'                => [ '0.1.0',         '0.1.0',         0 ],
    '0.2.0 gt 0.1.0'                => [ '0.2.0',         '0.1.0',         1 ],
    '0.0.1 eq 0.0.1'                => [ '0.0.1',         '0.0.1',         0 ],
    '0.0.2 gt 0.0.1'                => [ '0.0.2',         '0.0.1',         1 ],
    '1.2.3 eq 1.2.3'                => [ '1.2.3',         '1.2.3',         0 ],
    '2.2.4 gt 1.2.4'                => [ '2.2.4',         '1.2.4',         1 ],
    '1.3.3 gz 1.2.3'                => [ '1.3.3',         '1.2.3',         1 ],

    # Spec Examples #11
    '1.0.0 lt 2.0.0'                => [ '1.0.0',         '2.0.0',        -1 ],
    '2.0.0 lt 2.1.0'                => [ '2.0.0',         '2.1.0',        -1 ],
    '2.1.0 lt 2.1.1'                => [ '2.1.0',         '2.1.1',        -1 ],

    # Spec Examples #9
    '1.0.0 gt 1.0.0-alpha'          => [ '1.0.0',         '1.0.0-alpha',   1 ],
    '1.0.0-alpha lt 1.0.0-alpha.1'  => [ '1.0.0-alpha',   '1.0.0-alpha.1', -1 ],
    '1.0.0-alpha.1 lt 1.0.0-beta'    => [ '1.0.0-alpha.1',  '1.0.0-beta',   -1 ],
    '1.0.0-beta lt 1.0.0-beta.2'     => [ '1.0.0-beta',    '1.0.0-beta.2',  -1 ],
    '1.0.0-beta.2 lt 1.0.0-beta.11'   => [ '1.0.0-beta.2',   '1.0.0-beta.11', -1 ],
    '1.0.0-beta.11 lt 1.0.0-rc.1'     => [ '1.0.0-beta.11',  '1.0.0-rc.1',    -1 ],
    '1.0.0-rc1 lt 1.0.0'            => [ '1.0.0-rc1',     '1.0.0',        -1 ],

    # Ignore build metadata
    '1.0.0+123 eq 1.0.0'            => [ '1.0.0+123',     '1.0.0',         0 ],

    # TODO test for leading zeroes and invalid numbers
  );
  foreach my $key ( keys %version ) {
      my ( $left_version, $right_version, $expected ) = @{ $version{$key} };
      is( Version::Compare::semver_compare( $left_version, $right_version ), $expected, $key );
  }
}
