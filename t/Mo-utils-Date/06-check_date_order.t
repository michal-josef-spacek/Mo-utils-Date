use strict;
use warnings;

use DateTime;
use English;
use Error::Pure::Utils qw(clean);
use Mo::utils::Date qw(check_date_order);
use Test::More 'tests' => 8;
use Test::NoWarnings;

# Test.
my $self = {
	'date1' => '20',
	'date2' => '30',
};
my $ret = check_date_order($self, 'date1', 'date2');
is($ret, undef, "Date '20' is lesser than date '30'.");

# Test.
$self = {
	'date1' => '2020-12-31',
	'date2' => '2021-1-1',
};
$ret = check_date_order($self, 'date1', 'date2');
is($ret, undef, "Date '2020-12-31' is lesser than date '2021-1-1'.");

# Test.
$self = {
	'date1' => '-600',
	'date2' => '-500',
};
$ret = check_date_order($self, 'date1', 'date2');
is($ret, undef, "Date '-600' is lesser than date '-500'.");

# Test.
$self = {
	'date1' => DateTime->new('year' => '-600'),
	'date2' => DateTime->new('year' => '-500'),
};
$ret = check_date_order($self, 'date1', 'date2');
is($ret, undef, "Date '-600' is lesser than date '-500' (DateTime objects).");

# Test.
$self = {
	'date1' => '2021-1-1',
	'date2' => '2020-12-31',
};
eval {
	check_date_order($self, 'date1', 'date2');
};
is($EVAL_ERROR, "Parameter 'date1' has date greater or same as parameter 'date2' date.\n",
	"Parameter 'date1' has date greater as parameter 'date2' date.");
clean();

# Test.
$self = {
	'date1' => '2021-1-1',
	'date2' => '2021-1-1',
};
eval {
	check_date_order($self, 'date1', 'date2');
};
is($EVAL_ERROR, "Parameter 'date1' has date greater or same as parameter 'date2' date.\n",
	"Parameter 'date1' has date same as parameter 'date2' date.");
clean();

# Test.
$self = {
	'date1' => DateTime->new('year' => 2021, 'month' => 1, 'day' => 1),
	'date2' => DateTime->new('year' => 2021, 'month' => 1, 'day' => 1),
};
eval {
	check_date_order($self, 'date1', 'date2');
};
is($EVAL_ERROR, "Parameter 'date1' has date greater or same as parameter 'date2' date.\n",
	"Parameter 'date1' has date same as parameter 'date2' date (DateTime objects).");
clean();
