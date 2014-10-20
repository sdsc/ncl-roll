#!/usr/bin/perl -w
# ncl roll installation test.  Usage:
# ncl.t [nodetype]
#   where nodetype is one of "Compute", "Dbnode", "Frontend" or "Login"
#   if not specified, the test assumes either Compute or Frontend

use Test::More qw(no_plan);

my $appliance = $#ARGV >= 0 ? $ARGV[0] :
                -d '/export/rocks/install' ? 'Frontend' : 'Compute';
my $installedOnAppliancesPattern = '.';
my $isInstalled = -d '/opt/ncl';
my $output;

my $TESTFILE = 'tmpncl';

open(OUT, ">$TESTFILE.ncl");
print OUT <<END;
modelYears = (/1900, 1920, 1940, 1960/)
print(modelYears)
END
close(OUT);

open(OUT, ">$TESTFILE.sh");
print OUT <<END;
#!/bin/bash
module load ncl
ncl $TESTFILE.ncl
END
close(OUT);

# ncl-common.xml
if($appliance =~ /$installedOnAppliancesPattern/) {
  ok($isInstalled, 'ncl installed');
} else {
  ok(! $isInstalled, 'ncl not installed');
}
SKIP: {

  skip 'ncl not installed', 4 if ! $isInstalled;
  $output = `bash $TESTFILE.sh 2>&1`;
  like($output, qr/4 values/, 'ncl works');

  `/bin/ls /opt/modulefiles/applications/ncl/[0-9]* 2>&1`;
  ok($? == 0, 'ncl module installed');
  `/bin/ls /opt/modulefiles/applications/ncl/.version.[0-9]* 2>&1`;
  ok($? == 0, 'ncl version module installed');
  ok(-l '/opt/modulefiles/applications/ncl/.version',
     'ncl version module link created');

}

`rm -f $TESTFILE*`;
