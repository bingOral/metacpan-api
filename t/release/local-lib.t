use Test::More;
use strict;
use warnings;

use DDP;
use lib 't/lib';
use MetaCPAN::TestHelpers;

test_release(
    {
        name       => 'local-lib-0.01',
        author     => 'BORISNAT',
        abstract   => 'Legitimate module',
        authorized => \1,
        first      => \1,
        provides   => ['local::lib'],
        modules    => {
            'lib/local/lib.pm' => [
                {
                    name             => 'local::lib',
                    indexed          => \1,
                    authorized       => \1,
                    version          => '0.01',
                    version_numified => 0.01,
                    associated_pod =>
                        'BORISNAT/local-lib-0.01/lib/local/lib.pm',
                },
            ],
        },
        extra_tests => sub {
            my ($self) = @_;

            {
                my $file = $self->file_by_path('lib/local/lib.pm');

                ok $file->indexed,    'local::lib should be indexed';
                ok $file->authorized, 'local::lib should be authorized';
                is $file->sloc,       3, 'sloc';
                is $file->slop,       2, 'slop';

                p $file->{pod_lines};
                is_deeply $file->{pod_lines}, [ [ 4, 3 ] ], 'pod_lines';

                is $file->abstract, q[Legitimate module], 'abstract';
            }

        },
    }
);

done_testing;