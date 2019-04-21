use strict;
use warnings;

package RT::ExternalTools::Flights;
use base qw(RT::ExternalTools);

sub Action {
    my $self = shift;
    my %args = (@_);

    return (
        Delay    => '10 minutes',
        Gate     => '12',
        Terminal => 'D',
    );
}

sub UpdateFlightsCustomField {
    my $self = shift;
    my %args = (
        TicketId     => undef,
        FlightNumber => undef,
        CurrentUser  => undef,
        @_
    );
    return unless $args{'CurrentUser'};

    my $ticket = RT::Ticket->new($args{'CurrentUser'});
    my ($ret, $msg) = $ticket->Load($args{'TicketId'});
    RT::Logger->error($msg) unless $ticket->Id;
    return unless $ticket->Id;

    ($ret, $msg) = $ticket->AddCustomFieldValue(Field => 'Flight Number', Value => $args{'FlightNumber'});
    RT::Logger->error("Could not set CF 'Flight Number': $msg") unless $ret;

    return ($ret, $msg);
}

1;
