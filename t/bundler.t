use v6;
use Test;
use Panda::Bundler;

plan 11;

my $repo_dir_with_meta = 'testmodules/with-META-info-supplied';

my $proj_with_meta;
lives-ok { $proj_with_meta = guess-project($repo_dir_with_meta); };
ok $proj_with_meta.name eq "Example", 'name specified in META.info';
ok $proj_with_meta.metainfo{'description'} eq "an example module", 'desc specified in META.info';
ok $proj_with_meta.metainfo{'source-url'} eq "git://github.com/astj/nosuchrepo.git", 'source-url specified in META.info';

my $proj_with_override;
lives-ok { $proj_with_override = guess-project($repo_dir_with_meta, :name("OverRideName"), :desc("OverRideDescription")); };
ok $proj_with_override.name eq "OverRideName", 'Prefer specified name rather than META.info';
ok $proj_with_override.metainfo{'description'} eq "OverRideDescription", 'Prefer specifed description rather than META.info';
ok $proj_with_override.metainfo{'source-url'} eq "git://github.com/astj/nosuchrepo.git", 'source-url specified in META.info';


my $repo_dir_without_meta = 'testmodules/dummymodule';

my $proj_without_meta_with_override;
lives-ok { $proj_without_meta_with_override = guess-project($repo_dir_without_meta, :name("OverRideName"), :desc("OverRideDescription")); }, 'Can guess project even META.info is not exists';
ok $proj_without_meta_with_override.name eq "OverRideName", 'Prefer specified name rather than META.info';
ok $proj_without_meta_with_override.metainfo{'description'} eq "OverRideDescription", 'Prefer specifed description rather than META.info';
