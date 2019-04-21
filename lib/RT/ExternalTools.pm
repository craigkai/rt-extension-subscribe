use strict;
use warnings;

package RT::ExternalTools;

use RT::ExternalTools::Flights;

sub Prepare {
    my $self = shift;
    my %args = @_;

    my %ret = ();
    my $class_name = 'RT::ExternalTools::'.$args{'Action'};
    %ret = $class_name->Action(
        %args,
    );
    return %ret;
}

sub Action {
    return ();
}

1;
