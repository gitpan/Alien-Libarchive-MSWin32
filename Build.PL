use lib 'inc';
use Devel::AssertOS qw[MSWin32];

use strict;
use warnings;

use Module::Build 0.3601;
use lib qw{inc}; use Alien::Libarchive::MSWin32::ModuleBuild;

my %module_build_args = (
  "alien_build_commands" => [
    "%x -I../../inc -MAlien::Libarchive::MSWin32::ModuleBuild -e alien_build"
  ],
  "alien_install_commands" => [
    "%x -I../../inc -MAlien::Libarchive::MSWin32::ModuleBuild -e alien_install %s"
  ],
  "alien_name" => "libarchive",
  "alien_repository" => {
    "host" => "www.libarchive.org",
    "location" => "/downloads/",
    "pattern" => qr/(^libarchive-([\d\.]+)\.tar\.gz$)/,
    "protocol" => "http"
  },
  "build_requires" => {},
  "configure_requires" => {
    "Alien::Base" => "0.002",
    "Alien::CMake" => 0,
    "File::ShareDir" => "1.03"
  },
  "dist_abstract" => "Build and make available libarchive on MSWin32",
  "dist_author" => [
    "Graham Ollis <plicease\@cpan.org>"
  ],
  "dist_name" => "Alien-Libarchive-MSWin32",
  "dist_version" => "0.01",
  "license" => "perl",
  "module_name" => "Alien::Libarchive::MSWin32",
  "recommends" => {},
  "recursive_test_files" => 1,
  "requires" => {
    "Alien::Base" => "0.002",
    "File::ShareDir" => "1.03",
    "perl" => "5.006"
  },
  "script_files" => [],
  "test_requires" => {
    "Test::More" => 0
  }
);


my %fallback_build_requires = (
  "Test::More" => 0
);


unless ( eval { Module::Build->VERSION(0.4004) } ) {
  delete $module_build_args{test_requires};
  $module_build_args{build_requires} = \%fallback_build_requires;
}

my $build = Alien::Libarchive::MSWin32::ModuleBuild->new(%module_build_args);

$build->create_build_script;
