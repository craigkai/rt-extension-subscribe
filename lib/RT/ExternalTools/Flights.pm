use strict;
use warnings;

package RT::ExternalTools::Flights;
use base qw(RT::ExternalTools);

use JSON;
use LWP::UserAgent;

sub GetFlightData {
    my $self = shift;
    my %args = (
        TicketId     => undef,
        CurrentUser  => undef,
        FlightNumber => undef,
        @_
    );
    
    my $ticket = RT::Ticket->new($args{'CurrentUser'});
    $ticket->Load($args{'TicketId'});
    RT::Logger->error("Could not load ticket: " . $args{'TicketId'}) unless $ticket->Id;
    return unless $ticket->Id;

    my $departure_datetime = $ticket->FirstCustomFieldValue('Depart');
    return unless $departure_datetime and $args{'FlightNumber'};

    my $ua = LWP::UserAgent->new;
    my $url = 'https://adsbexchange.com/api/aircraft/icao/'.$args{'FlightNumber'};

    my $req = HTTP::Request->new(GET => $url);
    $req->header('content-type' => 'application/json');

    my $resp = $ua->request($req);
    my $message = decode_json($resp->decoded_content);

    my %ret = ();

    return (
        Delay    => $ret{'departure'}->{'estimatedTime'},
        Gate     => $ret{'departure'}->{'gate'},
        Terminal => $ret{'departure'}->{'terminal'},
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
