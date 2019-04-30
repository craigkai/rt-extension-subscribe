use strict;
use warnings;
package RT::Extension::Subscribe;

our $VERSION = '0.01';

RT->AddStyleSheets('rt-extension-subscribe.css');
RT->AddJavaScript('rt-extension-subscribe.js');

RT::Queue->AddRight( Travelers => IsTraveler => "Right to be a traveler" );
RT::Queue->AddRight( Travelers => AdminTraveler => "Means you are a traveler and more" );

=head1 NAME

RT-Extension-Subscribe

=head1 DESCRIPTION


=head1 RT VERSION

Works with RT 4.4

=head1 INSTALLATION

=over

=item C<perl Makefile.PL>

=item C<make>

=item C<make install>

May need root permissions

=item Edit your F</opt/rt4/etc/RT_SiteConfig.pm>

Add this line:

    Plugin('RT::Extension::Subscribe');

1. Create group "Travelers" (Need to be user created)
2. $make initdb (Do this once)
3. Install OAuth for Google sign in.
4. Install RT::Extension::Announce

=item Clear your mason cache

    rm -rf /opt/rt4/var/mason_data/obj

=item Restart your webserver

=back

=head1 AUTHOR

Best Practical Solutions, LLC E<lt>modules@bestpractical.comE<gt>

=for html <p>All bugs should be reported via email to <a
href="mailto:bug-RT-Extension-Subscribe@rt.cpan.org">bug-RT-Extension-Subscribe@rt.cpan.org</a>
or via the web at <a
href="http://rt.cpan.org/Public/Dist/Display.html?Name=RT-Extension-Subscribe">rt.cpan.org</a>.</p>

=for text
    All bugs should be reported via email to
        bug-RT-Extension-Subscribe@rt.cpan.org
    or via the web at
        http://rt.cpan.org/Public/Dist/Display.html?Name=RT-Extension-Subscribe

=head1 LICENSE AND COPYRIGHT

This software is Copyright (c) 2019 by craig kaiser

This is free software, licensed under:

  The GNU General Public License, Version 2, June 1991

=cut

1;
