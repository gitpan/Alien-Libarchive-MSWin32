package Alien::Libarchive::MSWin32;

use strict;
use warnings;
use base qw( Alien::Base );

# ABSTRACT: Build and make available libarchive on MSWin32
our $VERSION = '0.04'; # VERSION


sub import
{
  my $class = shift;
  $ENV{PATH} = $class->dist_dir . "/bin;$ENV{PATH}";
  $class->SUPER::import(@_);
}

sub dist_dir
{
  my $dir = shift->SUPER::dist_dir;
  $dir =~ s/\\/\//g;
  $dir;
}

sub cflags
{
  "-I" . shift->dist_dir . "/include";
}

sub libs
{
  my $self = shift;
  if($self->config('msvs'))
  {
    require File::Spec;
    my $path = File::Spec->catdir($self->dist_dir, "lib");
    $path =~ s{\\}{/}g;
    return join(' ', join(':', '-libpath', $path), 'archive.lib');
  }
  else
  {
    return "-L" . $self->dist_dir . "/lib -larchive";
  }
}

sub dll_path
{
  shift->dist_dir . "/bin/libarchive.dll";
}

1;

__END__

=pod

=encoding UTF-8

=head1 NAME

Alien::Libarchive::MSWin32 - Build and make available libarchive on MSWin32

=head1 VERSION

version 0.04

=head1 SYNOPSIS

 use Alien::Libarchive;

=head1 DESCRIPTION

This distribution downloads and installs libarchive for native (non-cygwin)
Windows Perls.  You should not use this module directly, instead set
your prerequisite to L<Alien::Libarchive>, which will work on non
native Windows Perls, and will delegate to this module on native Windows.

The rationale for distributing as a separate distribution is that building
on native Windows Perls has additional configuration prerequisites that
I don't want to impose on non-Windows users of L<Alien::Libarchive>.

=head1 CAVEATS

The build step will probably only work with a MinGW based Perl
(for example, Strawberry Perl).  Patches to fix this would be appreciated.
If you lack the expertise, contact me, I can probably help.

=head1 SEE ALSO

=over 4

=item L<Alien::Libarchive>

=back

=head1 AUTHOR

Graham Ollis <plicease@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Graham Ollis.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
