package data_api2::data_api2Client;

use JSON::RPC::Client;
use POSIX;
use strict;
use Data::Dumper;
use URI;
use Bio::KBase::Exceptions;
my $get_time = sub { time, 0 };
eval {
    require Time::HiRes;
    $get_time = sub { Time::HiRes::gettimeofday() };
};

use Bio::KBase::AuthToken;

# Client version should match Impl version
# This is a Semantic Version number,
# http://semver.org
our $VERSION = "0.1.0";

=head1 NAME

data_api2::data_api2Client

=head1 DESCRIPTION


A KBase module: data_api2


=cut

sub new
{
    my($class, $url, @args) = @_;
    

    my $self = {
	client => data_api2::data_api2Client::RpcClient->new,
	url => $url,
	headers => [],
    };

    chomp($self->{hostname} = `hostname`);
    $self->{hostname} ||= 'unknown-host';

    #
    # Set up for propagating KBRPC_TAG and KBRPC_METADATA environment variables through
    # to invoked services. If these values are not set, we create a new tag
    # and a metadata field with basic information about the invoking script.
    #
    if ($ENV{KBRPC_TAG})
    {
	$self->{kbrpc_tag} = $ENV{KBRPC_TAG};
    }
    else
    {
	my ($t, $us) = &$get_time();
	$us = sprintf("%06d", $us);
	my $ts = strftime("%Y-%m-%dT%H:%M:%S.${us}Z", gmtime $t);
	$self->{kbrpc_tag} = "C:$0:$self->{hostname}:$$:$ts";
    }
    push(@{$self->{headers}}, 'Kbrpc-Tag', $self->{kbrpc_tag});

    if ($ENV{KBRPC_METADATA})
    {
	$self->{kbrpc_metadata} = $ENV{KBRPC_METADATA};
	push(@{$self->{headers}}, 'Kbrpc-Metadata', $self->{kbrpc_metadata});
    }

    if ($ENV{KBRPC_ERROR_DEST})
    {
	$self->{kbrpc_error_dest} = $ENV{KBRPC_ERROR_DEST};
	push(@{$self->{headers}}, 'Kbrpc-Errordest', $self->{kbrpc_error_dest});
    }

    #
    # This module requires authentication.
    #
    # We create an auth token, passing through the arguments that we were (hopefully) given.

    {
	my $token = Bio::KBase::AuthToken->new(@args);
	
	if (!$token->error_message)
	{
	    $self->{token} = $token->token;
	    $self->{client}->{token} = $token->token;
	}
        else
        {
	    #
	    # All methods in this module require authentication. In this case, if we
	    # don't have a token, we can't continue.
	    #
	    die "Authentication failed: " . $token->error_message;
	}
    }

    my $ua = $self->{client}->ua;	 
    my $timeout = $ENV{CDMI_TIMEOUT} || (30 * 60);	 
    $ua->timeout($timeout);
    bless $self, $class;
    #    $self->_validate_version();
    return $self;
}




=head2 get_taxon

  $return = $obj->get_taxon($ref)

=over 4

=item Parameter and return types

=begin html

<pre>
$ref is a data_api2.ObjectReference
$return is a data_api2.ObjectReference
ObjectReference is a string

</pre>

=end html

=begin text

$ref is a data_api2.ObjectReference
$return is a data_api2.ObjectReference
ObjectReference is a string


=end text

=item Description

Retrieve the Taxon associated with this GenomeAnnotation.

=back

=cut

 sub get_taxon
{
    my($self, @args) = @_;

# Authentication: required

    if ((my $n = @args) != 1)
    {
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error =>
							       "Invalid argument count for function get_taxon (received $n, expecting 1)");
    }
    {
	my($ref) = @args;

	my @_bad_arguments;
        (!ref($ref)) or push(@_bad_arguments, "Invalid type for argument 1 \"ref\" (value was \"$ref\")");
        if (@_bad_arguments) {
	    my $msg = "Invalid arguments passed to get_taxon:\n" . join("", map { "\t$_\n" } @_bad_arguments);
	    Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
								   method_name => 'get_taxon');
	}
    }

    my $result = $self->{client}->call($self->{url}, $self->{headers}, {
	method => "data_api2.get_taxon",
	params => \@args,
    });
    if ($result) {
	if ($result->is_error) {
	    Bio::KBase::Exceptions::JSONRPC->throw(error => $result->error_message,
					       code => $result->content->{error}->{code},
					       method_name => 'get_taxon',
					       data => $result->content->{error}->{error} # JSON::RPC::ReturnObject only supports JSONRPC 1.1 or 1.O
					      );
	} else {
	    return wantarray ? @{$result->result} : $result->result->[0];
	}
    } else {
        Bio::KBase::Exceptions::HTTP->throw(error => "Error invoking method get_taxon",
					    status_line => $self->{client}->status_line,
					    method_name => 'get_taxon',
				       );
    }
}
 


=head2 get_assembly

  $return = $obj->get_assembly($ref)

=over 4

=item Parameter and return types

=begin html

<pre>
$ref is a data_api2.ObjectReference
$return is a data_api2.ObjectReference
ObjectReference is a string

</pre>

=end html

=begin text

$ref is a data_api2.ObjectReference
$return is a data_api2.ObjectReference
ObjectReference is a string


=end text

=item Description

Retrieve the Assembly associated with this GenomeAnnotation.

=back

=cut

 sub get_assembly
{
    my($self, @args) = @_;

# Authentication: required

    if ((my $n = @args) != 1)
    {
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error =>
							       "Invalid argument count for function get_assembly (received $n, expecting 1)");
    }
    {
	my($ref) = @args;

	my @_bad_arguments;
        (!ref($ref)) or push(@_bad_arguments, "Invalid type for argument 1 \"ref\" (value was \"$ref\")");
        if (@_bad_arguments) {
	    my $msg = "Invalid arguments passed to get_assembly:\n" . join("", map { "\t$_\n" } @_bad_arguments);
	    Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
								   method_name => 'get_assembly');
	}
    }

    my $result = $self->{client}->call($self->{url}, $self->{headers}, {
	method => "data_api2.get_assembly",
	params => \@args,
    });
    if ($result) {
	if ($result->is_error) {
	    Bio::KBase::Exceptions::JSONRPC->throw(error => $result->error_message,
					       code => $result->content->{error}->{code},
					       method_name => 'get_assembly',
					       data => $result->content->{error}->{error} # JSON::RPC::ReturnObject only supports JSONRPC 1.1 or 1.O
					      );
	} else {
	    return wantarray ? @{$result->result} : $result->result->[0];
	}
    } else {
        Bio::KBase::Exceptions::HTTP->throw(error => "Error invoking method get_assembly",
					    status_line => $self->{client}->status_line,
					    method_name => 'get_assembly',
				       );
    }
}
 


=head2 get_feature_types

  $return = $obj->get_feature_types($ref)

=over 4

=item Parameter and return types

=begin html

<pre>
$ref is a data_api2.ObjectReference
$return is a reference to a list where each element is a string
ObjectReference is a string

</pre>

=end html

=begin text

$ref is a data_api2.ObjectReference
$return is a reference to a list where each element is a string
ObjectReference is a string


=end text

=item Description

Retrieve the list of Feature types in this GenomeAnnotation.

=back

=cut

 sub get_feature_types
{
    my($self, @args) = @_;

# Authentication: required

    if ((my $n = @args) != 1)
    {
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error =>
							       "Invalid argument count for function get_feature_types (received $n, expecting 1)");
    }
    {
	my($ref) = @args;

	my @_bad_arguments;
        (!ref($ref)) or push(@_bad_arguments, "Invalid type for argument 1 \"ref\" (value was \"$ref\")");
        if (@_bad_arguments) {
	    my $msg = "Invalid arguments passed to get_feature_types:\n" . join("", map { "\t$_\n" } @_bad_arguments);
	    Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
								   method_name => 'get_feature_types');
	}
    }

    my $result = $self->{client}->call($self->{url}, $self->{headers}, {
	method => "data_api2.get_feature_types",
	params => \@args,
    });
    if ($result) {
	if ($result->is_error) {
	    Bio::KBase::Exceptions::JSONRPC->throw(error => $result->error_message,
					       code => $result->content->{error}->{code},
					       method_name => 'get_feature_types',
					       data => $result->content->{error}->{error} # JSON::RPC::ReturnObject only supports JSONRPC 1.1 or 1.O
					      );
	} else {
	    return wantarray ? @{$result->result} : $result->result->[0];
	}
    } else {
        Bio::KBase::Exceptions::HTTP->throw(error => "Error invoking method get_feature_types",
					    status_line => $self->{client}->status_line,
					    method_name => 'get_feature_types',
				       );
    }
}
 


=head2 get_feature_type_descriptions

  $return = $obj->get_feature_type_descriptions($ref, $feature_type_list)

=over 4

=item Parameter and return types

=begin html

<pre>
$ref is a data_api2.ObjectReference
$feature_type_list is a reference to a list where each element is a string
$return is a reference to a hash where the key is a string and the value is a string
ObjectReference is a string

</pre>

=end html

=begin text

$ref is a data_api2.ObjectReference
$feature_type_list is a reference to a list where each element is a string
$return is a reference to a hash where the key is a string and the value is a string
ObjectReference is a string


=end text

=item Description

Retrieve the descriptions for each Feature type in this GenomeAnnotation.

=back

=cut

 sub get_feature_type_descriptions
{
    my($self, @args) = @_;

# Authentication: required

    if ((my $n = @args) != 2)
    {
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error =>
							       "Invalid argument count for function get_feature_type_descriptions (received $n, expecting 2)");
    }
    {
	my($ref, $feature_type_list) = @args;

	my @_bad_arguments;
        (!ref($ref)) or push(@_bad_arguments, "Invalid type for argument 1 \"ref\" (value was \"$ref\")");
        (ref($feature_type_list) eq 'ARRAY') or push(@_bad_arguments, "Invalid type for argument 2 \"feature_type_list\" (value was \"$feature_type_list\")");
        if (@_bad_arguments) {
	    my $msg = "Invalid arguments passed to get_feature_type_descriptions:\n" . join("", map { "\t$_\n" } @_bad_arguments);
	    Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
								   method_name => 'get_feature_type_descriptions');
	}
    }

    my $result = $self->{client}->call($self->{url}, $self->{headers}, {
	method => "data_api2.get_feature_type_descriptions",
	params => \@args,
    });
    if ($result) {
	if ($result->is_error) {
	    Bio::KBase::Exceptions::JSONRPC->throw(error => $result->error_message,
					       code => $result->content->{error}->{code},
					       method_name => 'get_feature_type_descriptions',
					       data => $result->content->{error}->{error} # JSON::RPC::ReturnObject only supports JSONRPC 1.1 or 1.O
					      );
	} else {
	    return wantarray ? @{$result->result} : $result->result->[0];
	}
    } else {
        Bio::KBase::Exceptions::HTTP->throw(error => "Error invoking method get_feature_type_descriptions",
					    status_line => $self->{client}->status_line,
					    method_name => 'get_feature_type_descriptions',
				       );
    }
}
 


=head2 get_feature_type_counts

  $return = $obj->get_feature_type_counts($ref, $feature_type_list)

=over 4

=item Parameter and return types

=begin html

<pre>
$ref is a data_api2.ObjectReference
$feature_type_list is a reference to a list where each element is a string
$return is a reference to a hash where the key is a string and the value is an int
ObjectReference is a string

</pre>

=end html

=begin text

$ref is a data_api2.ObjectReference
$feature_type_list is a reference to a list where each element is a string
$return is a reference to a hash where the key is a string and the value is an int
ObjectReference is a string


=end text

=item Description

Retrieve the count of each Feature type in this GenomeAnnotation.

=back

=cut

 sub get_feature_type_counts
{
    my($self, @args) = @_;

# Authentication: required

    if ((my $n = @args) != 2)
    {
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error =>
							       "Invalid argument count for function get_feature_type_counts (received $n, expecting 2)");
    }
    {
	my($ref, $feature_type_list) = @args;

	my @_bad_arguments;
        (!ref($ref)) or push(@_bad_arguments, "Invalid type for argument 1 \"ref\" (value was \"$ref\")");
        (ref($feature_type_list) eq 'ARRAY') or push(@_bad_arguments, "Invalid type for argument 2 \"feature_type_list\" (value was \"$feature_type_list\")");
        if (@_bad_arguments) {
	    my $msg = "Invalid arguments passed to get_feature_type_counts:\n" . join("", map { "\t$_\n" } @_bad_arguments);
	    Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
								   method_name => 'get_feature_type_counts');
	}
    }

    my $result = $self->{client}->call($self->{url}, $self->{headers}, {
	method => "data_api2.get_feature_type_counts",
	params => \@args,
    });
    if ($result) {
	if ($result->is_error) {
	    Bio::KBase::Exceptions::JSONRPC->throw(error => $result->error_message,
					       code => $result->content->{error}->{code},
					       method_name => 'get_feature_type_counts',
					       data => $result->content->{error}->{error} # JSON::RPC::ReturnObject only supports JSONRPC 1.1 or 1.O
					      );
	} else {
	    return wantarray ? @{$result->result} : $result->result->[0];
	}
    } else {
        Bio::KBase::Exceptions::HTTP->throw(error => "Error invoking method get_feature_type_counts",
					    status_line => $self->{client}->status_line,
					    method_name => 'get_feature_type_counts',
				       );
    }
}
 


=head2 get_feature_ids

  $return = $obj->get_feature_ids($ref, $filters, $group_type)

=over 4

=item Parameter and return types

=begin html

<pre>
$ref is a data_api2.ObjectReference
$filters is a data_api2.Feature_id_filters
$group_type is a string
$return is a data_api2.Feature_id_mapping
ObjectReference is a string
Feature_id_filters is a reference to a hash where the following keys are defined:
	type_list has a value which is a reference to a list where each element is a string
	region_list has a value which is a reference to a list where each element is a data_api2.Region
	function_list has a value which is a reference to a list where each element is a string
	alias_list has a value which is a reference to a list where each element is a string
Region is a reference to a hash where the following keys are defined:
	contig_id has a value which is a string
	strand has a value which is a string
	start has a value which is an int
	length has a value which is an int
Feature_id_mapping is a reference to a hash where the following keys are defined:
	by_type has a value which is a reference to a hash where the key is a string and the value is a reference to a list where each element is a string
	by_region has a value which is a reference to a hash where the key is a string and the value is a reference to a hash where the key is a string and the value is a reference to a hash where the key is a string and the value is a reference to a list where each element is a string
	by_function has a value which is a reference to a hash where the key is a string and the value is a reference to a list where each element is a string
	by_alias has a value which is a reference to a hash where the key is a string and the value is a reference to a list where each element is a string

</pre>

=end html

=begin text

$ref is a data_api2.ObjectReference
$filters is a data_api2.Feature_id_filters
$group_type is a string
$return is a data_api2.Feature_id_mapping
ObjectReference is a string
Feature_id_filters is a reference to a hash where the following keys are defined:
	type_list has a value which is a reference to a list where each element is a string
	region_list has a value which is a reference to a list where each element is a data_api2.Region
	function_list has a value which is a reference to a list where each element is a string
	alias_list has a value which is a reference to a list where each element is a string
Region is a reference to a hash where the following keys are defined:
	contig_id has a value which is a string
	strand has a value which is a string
	start has a value which is an int
	length has a value which is an int
Feature_id_mapping is a reference to a hash where the following keys are defined:
	by_type has a value which is a reference to a hash where the key is a string and the value is a reference to a list where each element is a string
	by_region has a value which is a reference to a hash where the key is a string and the value is a reference to a hash where the key is a string and the value is a reference to a hash where the key is a string and the value is a reference to a list where each element is a string
	by_function has a value which is a reference to a hash where the key is a string and the value is a reference to a list where each element is a string
	by_alias has a value which is a reference to a hash where the key is a string and the value is a reference to a list where each element is a string


=end text

=item Description

Retrieve Feature ids in this GenomeAnnotation, optionally filtered by type, region, function, alias.

=back

=cut

 sub get_feature_ids
{
    my($self, @args) = @_;

# Authentication: required

    if ((my $n = @args) != 3)
    {
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error =>
							       "Invalid argument count for function get_feature_ids (received $n, expecting 3)");
    }
    {
	my($ref, $filters, $group_type) = @args;

	my @_bad_arguments;
        (!ref($ref)) or push(@_bad_arguments, "Invalid type for argument 1 \"ref\" (value was \"$ref\")");
        (ref($filters) eq 'HASH') or push(@_bad_arguments, "Invalid type for argument 2 \"filters\" (value was \"$filters\")");
        (!ref($group_type)) or push(@_bad_arguments, "Invalid type for argument 3 \"group_type\" (value was \"$group_type\")");
        if (@_bad_arguments) {
	    my $msg = "Invalid arguments passed to get_feature_ids:\n" . join("", map { "\t$_\n" } @_bad_arguments);
	    Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
								   method_name => 'get_feature_ids');
	}
    }

    my $result = $self->{client}->call($self->{url}, $self->{headers}, {
	method => "data_api2.get_feature_ids",
	params => \@args,
    });
    if ($result) {
	if ($result->is_error) {
	    Bio::KBase::Exceptions::JSONRPC->throw(error => $result->error_message,
					       code => $result->content->{error}->{code},
					       method_name => 'get_feature_ids',
					       data => $result->content->{error}->{error} # JSON::RPC::ReturnObject only supports JSONRPC 1.1 or 1.O
					      );
	} else {
	    return wantarray ? @{$result->result} : $result->result->[0];
	}
    } else {
        Bio::KBase::Exceptions::HTTP->throw(error => "Error invoking method get_feature_ids",
					    status_line => $self->{client}->status_line,
					    method_name => 'get_feature_ids',
				       );
    }
}
 


=head2 get_features

  $return = $obj->get_features($ref, $feature_id_list)

=over 4

=item Parameter and return types

=begin html

<pre>
$ref is a data_api2.ObjectReference
$feature_id_list is a reference to a list where each element is a string
$return is a reference to a hash where the key is a string and the value is a data_api2.Feature_data
ObjectReference is a string
Feature_data is a reference to a hash where the following keys are defined:
	feature_id has a value which is a string
	feature_type has a value which is a string
	feature_function has a value which is a string
	feature_aliases has a value which is a reference to a hash where the key is a string and the value is a reference to a list where each element is a string
	feature_dna_sequence_length has a value which is an int
	feature_dna_sequence has a value which is a string
	feature_md5 has a value which is a string
	feature_locations has a value which is a reference to a list where each element is a data_api2.Region
	feature_publications has a value which is a reference to a list where each element is a string
	feature_quality_warnings has a value which is a reference to a list where each element is a string
	feature_quality_score has a value which is a reference to a list where each element is a string
	feature_notes has a value which is a reference to a list where each element is a string
	feature_inference has a value which is a string
Region is a reference to a hash where the following keys are defined:
	contig_id has a value which is a string
	strand has a value which is a string
	start has a value which is an int
	length has a value which is an int

</pre>

=end html

=begin text

$ref is a data_api2.ObjectReference
$feature_id_list is a reference to a list where each element is a string
$return is a reference to a hash where the key is a string and the value is a data_api2.Feature_data
ObjectReference is a string
Feature_data is a reference to a hash where the following keys are defined:
	feature_id has a value which is a string
	feature_type has a value which is a string
	feature_function has a value which is a string
	feature_aliases has a value which is a reference to a hash where the key is a string and the value is a reference to a list where each element is a string
	feature_dna_sequence_length has a value which is an int
	feature_dna_sequence has a value which is a string
	feature_md5 has a value which is a string
	feature_locations has a value which is a reference to a list where each element is a data_api2.Region
	feature_publications has a value which is a reference to a list where each element is a string
	feature_quality_warnings has a value which is a reference to a list where each element is a string
	feature_quality_score has a value which is a reference to a list where each element is a string
	feature_notes has a value which is a reference to a list where each element is a string
	feature_inference has a value which is a string
Region is a reference to a hash where the following keys are defined:
	contig_id has a value which is a string
	strand has a value which is a string
	start has a value which is an int
	length has a value which is an int


=end text

=item Description

Retrieve Feature data available in this GenomeAnnotation.

=back

=cut

 sub get_features
{
    my($self, @args) = @_;

# Authentication: required

    if ((my $n = @args) != 2)
    {
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error =>
							       "Invalid argument count for function get_features (received $n, expecting 2)");
    }
    {
	my($ref, $feature_id_list) = @args;

	my @_bad_arguments;
        (!ref($ref)) or push(@_bad_arguments, "Invalid type for argument 1 \"ref\" (value was \"$ref\")");
        (ref($feature_id_list) eq 'ARRAY') or push(@_bad_arguments, "Invalid type for argument 2 \"feature_id_list\" (value was \"$feature_id_list\")");
        if (@_bad_arguments) {
	    my $msg = "Invalid arguments passed to get_features:\n" . join("", map { "\t$_\n" } @_bad_arguments);
	    Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
								   method_name => 'get_features');
	}
    }

    my $result = $self->{client}->call($self->{url}, $self->{headers}, {
	method => "data_api2.get_features",
	params => \@args,
    });
    if ($result) {
	if ($result->is_error) {
	    Bio::KBase::Exceptions::JSONRPC->throw(error => $result->error_message,
					       code => $result->content->{error}->{code},
					       method_name => 'get_features',
					       data => $result->content->{error}->{error} # JSON::RPC::ReturnObject only supports JSONRPC 1.1 or 1.O
					      );
	} else {
	    return wantarray ? @{$result->result} : $result->result->[0];
	}
    } else {
        Bio::KBase::Exceptions::HTTP->throw(error => "Error invoking method get_features",
					    status_line => $self->{client}->status_line,
					    method_name => 'get_features',
				       );
    }
}
 


=head2 get_proteins

  $return = $obj->get_proteins($ref)

=over 4

=item Parameter and return types

=begin html

<pre>
$ref is a data_api2.ObjectReference
$return is a reference to a hash where the key is a string and the value is a data_api2.Protein_data
ObjectReference is a string
Protein_data is a reference to a hash where the following keys are defined:
	protein_id has a value which is a string
	protein_amino_acid_sequence has a value which is a string
	protein_function has a value which is a string
	protein_aliases has a value which is a reference to a list where each element is a string
	protein_md5 has a value which is a string
	protein_domain_locations has a value which is a reference to a list where each element is a string

</pre>

=end html

=begin text

$ref is a data_api2.ObjectReference
$return is a reference to a hash where the key is a string and the value is a data_api2.Protein_data
ObjectReference is a string
Protein_data is a reference to a hash where the following keys are defined:
	protein_id has a value which is a string
	protein_amino_acid_sequence has a value which is a string
	protein_function has a value which is a string
	protein_aliases has a value which is a reference to a list where each element is a string
	protein_md5 has a value which is a string
	protein_domain_locations has a value which is a reference to a list where each element is a string


=end text

=item Description

Retrieve Protein data available in this GenomeAnnotation.

=back

=cut

 sub get_proteins
{
    my($self, @args) = @_;

# Authentication: required

    if ((my $n = @args) != 1)
    {
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error =>
							       "Invalid argument count for function get_proteins (received $n, expecting 1)");
    }
    {
	my($ref) = @args;

	my @_bad_arguments;
        (!ref($ref)) or push(@_bad_arguments, "Invalid type for argument 1 \"ref\" (value was \"$ref\")");
        if (@_bad_arguments) {
	    my $msg = "Invalid arguments passed to get_proteins:\n" . join("", map { "\t$_\n" } @_bad_arguments);
	    Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
								   method_name => 'get_proteins');
	}
    }

    my $result = $self->{client}->call($self->{url}, $self->{headers}, {
	method => "data_api2.get_proteins",
	params => \@args,
    });
    if ($result) {
	if ($result->is_error) {
	    Bio::KBase::Exceptions::JSONRPC->throw(error => $result->error_message,
					       code => $result->content->{error}->{code},
					       method_name => 'get_proteins',
					       data => $result->content->{error}->{error} # JSON::RPC::ReturnObject only supports JSONRPC 1.1 or 1.O
					      );
	} else {
	    return wantarray ? @{$result->result} : $result->result->[0];
	}
    } else {
        Bio::KBase::Exceptions::HTTP->throw(error => "Error invoking method get_proteins",
					    status_line => $self->{client}->status_line,
					    method_name => 'get_proteins',
				       );
    }
}
 


=head2 get_feature_locations

  $return = $obj->get_feature_locations($ref, $feature_id_list)

=over 4

=item Parameter and return types

=begin html

<pre>
$ref is a data_api2.ObjectReference
$feature_id_list is a reference to a list where each element is a string
$return is a reference to a hash where the key is a string and the value is a reference to a list where each element is a data_api2.Region
ObjectReference is a string
Region is a reference to a hash where the following keys are defined:
	contig_id has a value which is a string
	strand has a value which is a string
	start has a value which is an int
	length has a value which is an int

</pre>

=end html

=begin text

$ref is a data_api2.ObjectReference
$feature_id_list is a reference to a list where each element is a string
$return is a reference to a hash where the key is a string and the value is a reference to a list where each element is a data_api2.Region
ObjectReference is a string
Region is a reference to a hash where the following keys are defined:
	contig_id has a value which is a string
	strand has a value which is a string
	start has a value which is an int
	length has a value which is an int


=end text

=item Description

Retrieve Feature locations in this GenomeAnnotation.

=back

=cut

 sub get_feature_locations
{
    my($self, @args) = @_;

# Authentication: required

    if ((my $n = @args) != 2)
    {
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error =>
							       "Invalid argument count for function get_feature_locations (received $n, expecting 2)");
    }
    {
	my($ref, $feature_id_list) = @args;

	my @_bad_arguments;
        (!ref($ref)) or push(@_bad_arguments, "Invalid type for argument 1 \"ref\" (value was \"$ref\")");
        (ref($feature_id_list) eq 'ARRAY') or push(@_bad_arguments, "Invalid type for argument 2 \"feature_id_list\" (value was \"$feature_id_list\")");
        if (@_bad_arguments) {
	    my $msg = "Invalid arguments passed to get_feature_locations:\n" . join("", map { "\t$_\n" } @_bad_arguments);
	    Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
								   method_name => 'get_feature_locations');
	}
    }

    my $result = $self->{client}->call($self->{url}, $self->{headers}, {
	method => "data_api2.get_feature_locations",
	params => \@args,
    });
    if ($result) {
	if ($result->is_error) {
	    Bio::KBase::Exceptions::JSONRPC->throw(error => $result->error_message,
					       code => $result->content->{error}->{code},
					       method_name => 'get_feature_locations',
					       data => $result->content->{error}->{error} # JSON::RPC::ReturnObject only supports JSONRPC 1.1 or 1.O
					      );
	} else {
	    return wantarray ? @{$result->result} : $result->result->[0];
	}
    } else {
        Bio::KBase::Exceptions::HTTP->throw(error => "Error invoking method get_feature_locations",
					    status_line => $self->{client}->status_line,
					    method_name => 'get_feature_locations',
				       );
    }
}
 


=head2 get_feature_publications

  $return = $obj->get_feature_publications($ref, $feature_id_list)

=over 4

=item Parameter and return types

=begin html

<pre>
$ref is a data_api2.ObjectReference
$feature_id_list is a reference to a list where each element is a string
$return is a reference to a hash where the key is a string and the value is a reference to a list where each element is a string
ObjectReference is a string

</pre>

=end html

=begin text

$ref is a data_api2.ObjectReference
$feature_id_list is a reference to a list where each element is a string
$return is a reference to a hash where the key is a string and the value is a reference to a list where each element is a string
ObjectReference is a string


=end text

=item Description

Retrieve Feature publications in this GenomeAnnotation.

=back

=cut

 sub get_feature_publications
{
    my($self, @args) = @_;

# Authentication: required

    if ((my $n = @args) != 2)
    {
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error =>
							       "Invalid argument count for function get_feature_publications (received $n, expecting 2)");
    }
    {
	my($ref, $feature_id_list) = @args;

	my @_bad_arguments;
        (!ref($ref)) or push(@_bad_arguments, "Invalid type for argument 1 \"ref\" (value was \"$ref\")");
        (ref($feature_id_list) eq 'ARRAY') or push(@_bad_arguments, "Invalid type for argument 2 \"feature_id_list\" (value was \"$feature_id_list\")");
        if (@_bad_arguments) {
	    my $msg = "Invalid arguments passed to get_feature_publications:\n" . join("", map { "\t$_\n" } @_bad_arguments);
	    Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
								   method_name => 'get_feature_publications');
	}
    }

    my $result = $self->{client}->call($self->{url}, $self->{headers}, {
	method => "data_api2.get_feature_publications",
	params => \@args,
    });
    if ($result) {
	if ($result->is_error) {
	    Bio::KBase::Exceptions::JSONRPC->throw(error => $result->error_message,
					       code => $result->content->{error}->{code},
					       method_name => 'get_feature_publications',
					       data => $result->content->{error}->{error} # JSON::RPC::ReturnObject only supports JSONRPC 1.1 or 1.O
					      );
	} else {
	    return wantarray ? @{$result->result} : $result->result->[0];
	}
    } else {
        Bio::KBase::Exceptions::HTTP->throw(error => "Error invoking method get_feature_publications",
					    status_line => $self->{client}->status_line,
					    method_name => 'get_feature_publications',
				       );
    }
}
 


=head2 get_feature_dna

  $return = $obj->get_feature_dna($ref, $feature_id_list)

=over 4

=item Parameter and return types

=begin html

<pre>
$ref is a data_api2.ObjectReference
$feature_id_list is a reference to a list where each element is a string
$return is a reference to a hash where the key is a string and the value is a string
ObjectReference is a string

</pre>

=end html

=begin text

$ref is a data_api2.ObjectReference
$feature_id_list is a reference to a list where each element is a string
$return is a reference to a hash where the key is a string and the value is a string
ObjectReference is a string


=end text

=item Description

Retrieve Feature DNA sequences in this GenomeAnnotation.

=back

=cut

 sub get_feature_dna
{
    my($self, @args) = @_;

# Authentication: required

    if ((my $n = @args) != 2)
    {
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error =>
							       "Invalid argument count for function get_feature_dna (received $n, expecting 2)");
    }
    {
	my($ref, $feature_id_list) = @args;

	my @_bad_arguments;
        (!ref($ref)) or push(@_bad_arguments, "Invalid type for argument 1 \"ref\" (value was \"$ref\")");
        (ref($feature_id_list) eq 'ARRAY') or push(@_bad_arguments, "Invalid type for argument 2 \"feature_id_list\" (value was \"$feature_id_list\")");
        if (@_bad_arguments) {
	    my $msg = "Invalid arguments passed to get_feature_dna:\n" . join("", map { "\t$_\n" } @_bad_arguments);
	    Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
								   method_name => 'get_feature_dna');
	}
    }

    my $result = $self->{client}->call($self->{url}, $self->{headers}, {
	method => "data_api2.get_feature_dna",
	params => \@args,
    });
    if ($result) {
	if ($result->is_error) {
	    Bio::KBase::Exceptions::JSONRPC->throw(error => $result->error_message,
					       code => $result->content->{error}->{code},
					       method_name => 'get_feature_dna',
					       data => $result->content->{error}->{error} # JSON::RPC::ReturnObject only supports JSONRPC 1.1 or 1.O
					      );
	} else {
	    return wantarray ? @{$result->result} : $result->result->[0];
	}
    } else {
        Bio::KBase::Exceptions::HTTP->throw(error => "Error invoking method get_feature_dna",
					    status_line => $self->{client}->status_line,
					    method_name => 'get_feature_dna',
				       );
    }
}
 


=head2 get_feature_functions

  $return = $obj->get_feature_functions($ref, $feature_id_list)

=over 4

=item Parameter and return types

=begin html

<pre>
$ref is a data_api2.ObjectReference
$feature_id_list is a reference to a list where each element is a string
$return is a reference to a hash where the key is a string and the value is a string
ObjectReference is a string

</pre>

=end html

=begin text

$ref is a data_api2.ObjectReference
$feature_id_list is a reference to a list where each element is a string
$return is a reference to a hash where the key is a string and the value is a string
ObjectReference is a string


=end text

=item Description

Retrieve Feature functions in this GenomeAnnotation.

=back

=cut

 sub get_feature_functions
{
    my($self, @args) = @_;

# Authentication: required

    if ((my $n = @args) != 2)
    {
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error =>
							       "Invalid argument count for function get_feature_functions (received $n, expecting 2)");
    }
    {
	my($ref, $feature_id_list) = @args;

	my @_bad_arguments;
        (!ref($ref)) or push(@_bad_arguments, "Invalid type for argument 1 \"ref\" (value was \"$ref\")");
        (ref($feature_id_list) eq 'ARRAY') or push(@_bad_arguments, "Invalid type for argument 2 \"feature_id_list\" (value was \"$feature_id_list\")");
        if (@_bad_arguments) {
	    my $msg = "Invalid arguments passed to get_feature_functions:\n" . join("", map { "\t$_\n" } @_bad_arguments);
	    Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
								   method_name => 'get_feature_functions');
	}
    }

    my $result = $self->{client}->call($self->{url}, $self->{headers}, {
	method => "data_api2.get_feature_functions",
	params => \@args,
    });
    if ($result) {
	if ($result->is_error) {
	    Bio::KBase::Exceptions::JSONRPC->throw(error => $result->error_message,
					       code => $result->content->{error}->{code},
					       method_name => 'get_feature_functions',
					       data => $result->content->{error}->{error} # JSON::RPC::ReturnObject only supports JSONRPC 1.1 or 1.O
					      );
	} else {
	    return wantarray ? @{$result->result} : $result->result->[0];
	}
    } else {
        Bio::KBase::Exceptions::HTTP->throw(error => "Error invoking method get_feature_functions",
					    status_line => $self->{client}->status_line,
					    method_name => 'get_feature_functions',
				       );
    }
}
 


=head2 get_feature_aliases

  $return = $obj->get_feature_aliases($ref, $feature_id_list)

=over 4

=item Parameter and return types

=begin html

<pre>
$ref is a data_api2.ObjectReference
$feature_id_list is a reference to a list where each element is a string
$return is a reference to a hash where the key is a string and the value is a reference to a list where each element is a string
ObjectReference is a string

</pre>

=end html

=begin text

$ref is a data_api2.ObjectReference
$feature_id_list is a reference to a list where each element is a string
$return is a reference to a hash where the key is a string and the value is a reference to a list where each element is a string
ObjectReference is a string


=end text

=item Description

Retrieve Feature aliases in this GenomeAnnotation.

=back

=cut

 sub get_feature_aliases
{
    my($self, @args) = @_;

# Authentication: required

    if ((my $n = @args) != 2)
    {
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error =>
							       "Invalid argument count for function get_feature_aliases (received $n, expecting 2)");
    }
    {
	my($ref, $feature_id_list) = @args;

	my @_bad_arguments;
        (!ref($ref)) or push(@_bad_arguments, "Invalid type for argument 1 \"ref\" (value was \"$ref\")");
        (ref($feature_id_list) eq 'ARRAY') or push(@_bad_arguments, "Invalid type for argument 2 \"feature_id_list\" (value was \"$feature_id_list\")");
        if (@_bad_arguments) {
	    my $msg = "Invalid arguments passed to get_feature_aliases:\n" . join("", map { "\t$_\n" } @_bad_arguments);
	    Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
								   method_name => 'get_feature_aliases');
	}
    }

    my $result = $self->{client}->call($self->{url}, $self->{headers}, {
	method => "data_api2.get_feature_aliases",
	params => \@args,
    });
    if ($result) {
	if ($result->is_error) {
	    Bio::KBase::Exceptions::JSONRPC->throw(error => $result->error_message,
					       code => $result->content->{error}->{code},
					       method_name => 'get_feature_aliases',
					       data => $result->content->{error}->{error} # JSON::RPC::ReturnObject only supports JSONRPC 1.1 or 1.O
					      );
	} else {
	    return wantarray ? @{$result->result} : $result->result->[0];
	}
    } else {
        Bio::KBase::Exceptions::HTTP->throw(error => "Error invoking method get_feature_aliases",
					    status_line => $self->{client}->status_line,
					    method_name => 'get_feature_aliases',
				       );
    }
}
 


=head2 get_cds_by_gene

  $return = $obj->get_cds_by_gene($ref, $gene_id_list)

=over 4

=item Parameter and return types

=begin html

<pre>
$ref is a data_api2.ObjectReference
$gene_id_list is a reference to a list where each element is a string
$return is a reference to a hash where the key is a string and the value is a reference to a list where each element is a string
ObjectReference is a string

</pre>

=end html

=begin text

$ref is a data_api2.ObjectReference
$gene_id_list is a reference to a list where each element is a string
$return is a reference to a hash where the key is a string and the value is a reference to a list where each element is a string
ObjectReference is a string


=end text

=item Description

Retrieve the CDS id for each Gene id in this GenomeAnnotation.

=back

=cut

 sub get_cds_by_gene
{
    my($self, @args) = @_;

# Authentication: required

    if ((my $n = @args) != 2)
    {
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error =>
							       "Invalid argument count for function get_cds_by_gene (received $n, expecting 2)");
    }
    {
	my($ref, $gene_id_list) = @args;

	my @_bad_arguments;
        (!ref($ref)) or push(@_bad_arguments, "Invalid type for argument 1 \"ref\" (value was \"$ref\")");
        (ref($gene_id_list) eq 'ARRAY') or push(@_bad_arguments, "Invalid type for argument 2 \"gene_id_list\" (value was \"$gene_id_list\")");
        if (@_bad_arguments) {
	    my $msg = "Invalid arguments passed to get_cds_by_gene:\n" . join("", map { "\t$_\n" } @_bad_arguments);
	    Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
								   method_name => 'get_cds_by_gene');
	}
    }

    my $result = $self->{client}->call($self->{url}, $self->{headers}, {
	method => "data_api2.get_cds_by_gene",
	params => \@args,
    });
    if ($result) {
	if ($result->is_error) {
	    Bio::KBase::Exceptions::JSONRPC->throw(error => $result->error_message,
					       code => $result->content->{error}->{code},
					       method_name => 'get_cds_by_gene',
					       data => $result->content->{error}->{error} # JSON::RPC::ReturnObject only supports JSONRPC 1.1 or 1.O
					      );
	} else {
	    return wantarray ? @{$result->result} : $result->result->[0];
	}
    } else {
        Bio::KBase::Exceptions::HTTP->throw(error => "Error invoking method get_cds_by_gene",
					    status_line => $self->{client}->status_line,
					    method_name => 'get_cds_by_gene',
				       );
    }
}
 


=head2 get_cds_by_mrna

  $return = $obj->get_cds_by_mrna($ref, $mrna_id_list)

=over 4

=item Parameter and return types

=begin html

<pre>
$ref is a data_api2.ObjectReference
$mrna_id_list is a reference to a list where each element is a string
$return is a reference to a hash where the key is a string and the value is a string
ObjectReference is a string

</pre>

=end html

=begin text

$ref is a data_api2.ObjectReference
$mrna_id_list is a reference to a list where each element is a string
$return is a reference to a hash where the key is a string and the value is a string
ObjectReference is a string


=end text

=item Description

Retrieve the CDS id for each mRNA id in this GenomeAnnotation.

=back

=cut

 sub get_cds_by_mrna
{
    my($self, @args) = @_;

# Authentication: required

    if ((my $n = @args) != 2)
    {
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error =>
							       "Invalid argument count for function get_cds_by_mrna (received $n, expecting 2)");
    }
    {
	my($ref, $mrna_id_list) = @args;

	my @_bad_arguments;
        (!ref($ref)) or push(@_bad_arguments, "Invalid type for argument 1 \"ref\" (value was \"$ref\")");
        (ref($mrna_id_list) eq 'ARRAY') or push(@_bad_arguments, "Invalid type for argument 2 \"mrna_id_list\" (value was \"$mrna_id_list\")");
        if (@_bad_arguments) {
	    my $msg = "Invalid arguments passed to get_cds_by_mrna:\n" . join("", map { "\t$_\n" } @_bad_arguments);
	    Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
								   method_name => 'get_cds_by_mrna');
	}
    }

    my $result = $self->{client}->call($self->{url}, $self->{headers}, {
	method => "data_api2.get_cds_by_mrna",
	params => \@args,
    });
    if ($result) {
	if ($result->is_error) {
	    Bio::KBase::Exceptions::JSONRPC->throw(error => $result->error_message,
					       code => $result->content->{error}->{code},
					       method_name => 'get_cds_by_mrna',
					       data => $result->content->{error}->{error} # JSON::RPC::ReturnObject only supports JSONRPC 1.1 or 1.O
					      );
	} else {
	    return wantarray ? @{$result->result} : $result->result->[0];
	}
    } else {
        Bio::KBase::Exceptions::HTTP->throw(error => "Error invoking method get_cds_by_mrna",
					    status_line => $self->{client}->status_line,
					    method_name => 'get_cds_by_mrna',
				       );
    }
}
 


=head2 get_gene_by_cds

  $return = $obj->get_gene_by_cds($ref, $cds_id_list)

=over 4

=item Parameter and return types

=begin html

<pre>
$ref is a data_api2.ObjectReference
$cds_id_list is a reference to a list where each element is a string
$return is a reference to a hash where the key is a string and the value is a string
ObjectReference is a string

</pre>

=end html

=begin text

$ref is a data_api2.ObjectReference
$cds_id_list is a reference to a list where each element is a string
$return is a reference to a hash where the key is a string and the value is a string
ObjectReference is a string


=end text

=item Description

Retrieve the Gene id for each CDS id in this GenomeAnnotation.

=back

=cut

 sub get_gene_by_cds
{
    my($self, @args) = @_;

# Authentication: required

    if ((my $n = @args) != 2)
    {
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error =>
							       "Invalid argument count for function get_gene_by_cds (received $n, expecting 2)");
    }
    {
	my($ref, $cds_id_list) = @args;

	my @_bad_arguments;
        (!ref($ref)) or push(@_bad_arguments, "Invalid type for argument 1 \"ref\" (value was \"$ref\")");
        (ref($cds_id_list) eq 'ARRAY') or push(@_bad_arguments, "Invalid type for argument 2 \"cds_id_list\" (value was \"$cds_id_list\")");
        if (@_bad_arguments) {
	    my $msg = "Invalid arguments passed to get_gene_by_cds:\n" . join("", map { "\t$_\n" } @_bad_arguments);
	    Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
								   method_name => 'get_gene_by_cds');
	}
    }

    my $result = $self->{client}->call($self->{url}, $self->{headers}, {
	method => "data_api2.get_gene_by_cds",
	params => \@args,
    });
    if ($result) {
	if ($result->is_error) {
	    Bio::KBase::Exceptions::JSONRPC->throw(error => $result->error_message,
					       code => $result->content->{error}->{code},
					       method_name => 'get_gene_by_cds',
					       data => $result->content->{error}->{error} # JSON::RPC::ReturnObject only supports JSONRPC 1.1 or 1.O
					      );
	} else {
	    return wantarray ? @{$result->result} : $result->result->[0];
	}
    } else {
        Bio::KBase::Exceptions::HTTP->throw(error => "Error invoking method get_gene_by_cds",
					    status_line => $self->{client}->status_line,
					    method_name => 'get_gene_by_cds',
				       );
    }
}
 


=head2 get_gene_by_mrna

  $return = $obj->get_gene_by_mrna($ref, $mrna_id_list)

=over 4

=item Parameter and return types

=begin html

<pre>
$ref is a data_api2.ObjectReference
$mrna_id_list is a reference to a list where each element is a string
$return is a reference to a hash where the key is a string and the value is a string
ObjectReference is a string

</pre>

=end html

=begin text

$ref is a data_api2.ObjectReference
$mrna_id_list is a reference to a list where each element is a string
$return is a reference to a hash where the key is a string and the value is a string
ObjectReference is a string


=end text

=item Description

Retrieve the Gene id for each mRNA id in this GenomeAnnotation.

=back

=cut

 sub get_gene_by_mrna
{
    my($self, @args) = @_;

# Authentication: required

    if ((my $n = @args) != 2)
    {
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error =>
							       "Invalid argument count for function get_gene_by_mrna (received $n, expecting 2)");
    }
    {
	my($ref, $mrna_id_list) = @args;

	my @_bad_arguments;
        (!ref($ref)) or push(@_bad_arguments, "Invalid type for argument 1 \"ref\" (value was \"$ref\")");
        (ref($mrna_id_list) eq 'ARRAY') or push(@_bad_arguments, "Invalid type for argument 2 \"mrna_id_list\" (value was \"$mrna_id_list\")");
        if (@_bad_arguments) {
	    my $msg = "Invalid arguments passed to get_gene_by_mrna:\n" . join("", map { "\t$_\n" } @_bad_arguments);
	    Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
								   method_name => 'get_gene_by_mrna');
	}
    }

    my $result = $self->{client}->call($self->{url}, $self->{headers}, {
	method => "data_api2.get_gene_by_mrna",
	params => \@args,
    });
    if ($result) {
	if ($result->is_error) {
	    Bio::KBase::Exceptions::JSONRPC->throw(error => $result->error_message,
					       code => $result->content->{error}->{code},
					       method_name => 'get_gene_by_mrna',
					       data => $result->content->{error}->{error} # JSON::RPC::ReturnObject only supports JSONRPC 1.1 or 1.O
					      );
	} else {
	    return wantarray ? @{$result->result} : $result->result->[0];
	}
    } else {
        Bio::KBase::Exceptions::HTTP->throw(error => "Error invoking method get_gene_by_mrna",
					    status_line => $self->{client}->status_line,
					    method_name => 'get_gene_by_mrna',
				       );
    }
}
 


=head2 get_mrna_by_cds

  $return = $obj->get_mrna_by_cds($ref, $gene_id_list)

=over 4

=item Parameter and return types

=begin html

<pre>
$ref is a data_api2.ObjectReference
$gene_id_list is a reference to a list where each element is a string
$return is a reference to a hash where the key is a string and the value is a string
ObjectReference is a string

</pre>

=end html

=begin text

$ref is a data_api2.ObjectReference
$gene_id_list is a reference to a list where each element is a string
$return is a reference to a hash where the key is a string and the value is a string
ObjectReference is a string


=end text

=item Description

Retrieve the mRNA id for each CDS id in this GenomeAnnotation.

=back

=cut

 sub get_mrna_by_cds
{
    my($self, @args) = @_;

# Authentication: required

    if ((my $n = @args) != 2)
    {
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error =>
							       "Invalid argument count for function get_mrna_by_cds (received $n, expecting 2)");
    }
    {
	my($ref, $gene_id_list) = @args;

	my @_bad_arguments;
        (!ref($ref)) or push(@_bad_arguments, "Invalid type for argument 1 \"ref\" (value was \"$ref\")");
        (ref($gene_id_list) eq 'ARRAY') or push(@_bad_arguments, "Invalid type for argument 2 \"gene_id_list\" (value was \"$gene_id_list\")");
        if (@_bad_arguments) {
	    my $msg = "Invalid arguments passed to get_mrna_by_cds:\n" . join("", map { "\t$_\n" } @_bad_arguments);
	    Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
								   method_name => 'get_mrna_by_cds');
	}
    }

    my $result = $self->{client}->call($self->{url}, $self->{headers}, {
	method => "data_api2.get_mrna_by_cds",
	params => \@args,
    });
    if ($result) {
	if ($result->is_error) {
	    Bio::KBase::Exceptions::JSONRPC->throw(error => $result->error_message,
					       code => $result->content->{error}->{code},
					       method_name => 'get_mrna_by_cds',
					       data => $result->content->{error}->{error} # JSON::RPC::ReturnObject only supports JSONRPC 1.1 or 1.O
					      );
	} else {
	    return wantarray ? @{$result->result} : $result->result->[0];
	}
    } else {
        Bio::KBase::Exceptions::HTTP->throw(error => "Error invoking method get_mrna_by_cds",
					    status_line => $self->{client}->status_line,
					    method_name => 'get_mrna_by_cds',
				       );
    }
}
 


=head2 get_mrna_by_gene

  $return = $obj->get_mrna_by_gene($ref, $gene_id_list)

=over 4

=item Parameter and return types

=begin html

<pre>
$ref is a data_api2.ObjectReference
$gene_id_list is a reference to a list where each element is a string
$return is a reference to a hash where the key is a string and the value is a reference to a list where each element is a string
ObjectReference is a string

</pre>

=end html

=begin text

$ref is a data_api2.ObjectReference
$gene_id_list is a reference to a list where each element is a string
$return is a reference to a hash where the key is a string and the value is a reference to a list where each element is a string
ObjectReference is a string


=end text

=item Description

Retrieve the mRNA id for each Gene id in this GenomeAnnotation.

=back

=cut

 sub get_mrna_by_gene
{
    my($self, @args) = @_;

# Authentication: required

    if ((my $n = @args) != 2)
    {
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error =>
							       "Invalid argument count for function get_mrna_by_gene (received $n, expecting 2)");
    }
    {
	my($ref, $gene_id_list) = @args;

	my @_bad_arguments;
        (!ref($ref)) or push(@_bad_arguments, "Invalid type for argument 1 \"ref\" (value was \"$ref\")");
        (ref($gene_id_list) eq 'ARRAY') or push(@_bad_arguments, "Invalid type for argument 2 \"gene_id_list\" (value was \"$gene_id_list\")");
        if (@_bad_arguments) {
	    my $msg = "Invalid arguments passed to get_mrna_by_gene:\n" . join("", map { "\t$_\n" } @_bad_arguments);
	    Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
								   method_name => 'get_mrna_by_gene');
	}
    }

    my $result = $self->{client}->call($self->{url}, $self->{headers}, {
	method => "data_api2.get_mrna_by_gene",
	params => \@args,
    });
    if ($result) {
	if ($result->is_error) {
	    Bio::KBase::Exceptions::JSONRPC->throw(error => $result->error_message,
					       code => $result->content->{error}->{code},
					       method_name => 'get_mrna_by_gene',
					       data => $result->content->{error}->{error} # JSON::RPC::ReturnObject only supports JSONRPC 1.1 or 1.O
					      );
	} else {
	    return wantarray ? @{$result->result} : $result->result->[0];
	}
    } else {
        Bio::KBase::Exceptions::HTTP->throw(error => "Error invoking method get_mrna_by_gene",
					    status_line => $self->{client}->status_line,
					    method_name => 'get_mrna_by_gene',
				       );
    }
}
 
  

sub version {
    my ($self) = @_;
    my $result = $self->{client}->call($self->{url}, $self->{headers}, {
        method => "data_api2.version",
        params => [],
    });
    if ($result) {
        if ($result->is_error) {
            Bio::KBase::Exceptions::JSONRPC->throw(
                error => $result->error_message,
                code => $result->content->{code},
                method_name => 'get_mrna_by_gene',
            );
        } else {
            return wantarray ? @{$result->result} : $result->result->[0];
        }
    } else {
        Bio::KBase::Exceptions::HTTP->throw(
            error => "Error invoking method get_mrna_by_gene",
            status_line => $self->{client}->status_line,
            method_name => 'get_mrna_by_gene',
        );
    }
}

sub _validate_version {
    my ($self) = @_;
    my $svr_version = $self->version();
    my $client_version = $VERSION;
    my ($cMajor, $cMinor) = split(/\./, $client_version);
    my ($sMajor, $sMinor) = split(/\./, $svr_version);
    if ($sMajor != $cMajor) {
        Bio::KBase::Exceptions::ClientServerIncompatible->throw(
            error => "Major version numbers differ.",
            server_version => $svr_version,
            client_version => $client_version
        );
    }
    if ($sMinor < $cMinor) {
        Bio::KBase::Exceptions::ClientServerIncompatible->throw(
            error => "Client minor version greater than Server minor version.",
            server_version => $svr_version,
            client_version => $client_version
        );
    }
    if ($sMinor > $cMinor) {
        warn "New client version available for data_api2::data_api2Client\n";
    }
    if ($sMajor == 0) {
        warn "data_api2::data_api2Client version is $svr_version. API subject to change.\n";
    }
}

=head1 TYPES



=head2 ObjectReference

=over 4



=item Description

A string representing a reference id.


=item Definition

=begin html

<pre>
a string
</pre>

=end html

=begin text

a string

=end text

=back



=head2 Region

=over 4



=item Definition

=begin html

<pre>
a reference to a hash where the following keys are defined:
contig_id has a value which is a string
strand has a value which is a string
start has a value which is an int
length has a value which is an int

</pre>

=end html

=begin text

a reference to a hash where the following keys are defined:
contig_id has a value which is a string
strand has a value which is a string
start has a value which is an int
length has a value which is an int


=end text

=back



=head2 Feature_id_filters

=over 4



=item Definition

=begin html

<pre>
a reference to a hash where the following keys are defined:
type_list has a value which is a reference to a list where each element is a string
region_list has a value which is a reference to a list where each element is a data_api2.Region
function_list has a value which is a reference to a list where each element is a string
alias_list has a value which is a reference to a list where each element is a string

</pre>

=end html

=begin text

a reference to a hash where the following keys are defined:
type_list has a value which is a reference to a list where each element is a string
region_list has a value which is a reference to a list where each element is a data_api2.Region
function_list has a value which is a reference to a list where each element is a string
alias_list has a value which is a reference to a list where each element is a string


=end text

=back



=head2 Feature_id_mapping

=over 4



=item Definition

=begin html

<pre>
a reference to a hash where the following keys are defined:
by_type has a value which is a reference to a hash where the key is a string and the value is a reference to a list where each element is a string
by_region has a value which is a reference to a hash where the key is a string and the value is a reference to a hash where the key is a string and the value is a reference to a hash where the key is a string and the value is a reference to a list where each element is a string
by_function has a value which is a reference to a hash where the key is a string and the value is a reference to a list where each element is a string
by_alias has a value which is a reference to a hash where the key is a string and the value is a reference to a list where each element is a string

</pre>

=end html

=begin text

a reference to a hash where the following keys are defined:
by_type has a value which is a reference to a hash where the key is a string and the value is a reference to a list where each element is a string
by_region has a value which is a reference to a hash where the key is a string and the value is a reference to a hash where the key is a string and the value is a reference to a hash where the key is a string and the value is a reference to a list where each element is a string
by_function has a value which is a reference to a hash where the key is a string and the value is a reference to a list where each element is a string
by_alias has a value which is a reference to a hash where the key is a string and the value is a reference to a list where each element is a string


=end text

=back



=head2 Feature_data

=over 4



=item Definition

=begin html

<pre>
a reference to a hash where the following keys are defined:
feature_id has a value which is a string
feature_type has a value which is a string
feature_function has a value which is a string
feature_aliases has a value which is a reference to a hash where the key is a string and the value is a reference to a list where each element is a string
feature_dna_sequence_length has a value which is an int
feature_dna_sequence has a value which is a string
feature_md5 has a value which is a string
feature_locations has a value which is a reference to a list where each element is a data_api2.Region
feature_publications has a value which is a reference to a list where each element is a string
feature_quality_warnings has a value which is a reference to a list where each element is a string
feature_quality_score has a value which is a reference to a list where each element is a string
feature_notes has a value which is a reference to a list where each element is a string
feature_inference has a value which is a string

</pre>

=end html

=begin text

a reference to a hash where the following keys are defined:
feature_id has a value which is a string
feature_type has a value which is a string
feature_function has a value which is a string
feature_aliases has a value which is a reference to a hash where the key is a string and the value is a reference to a list where each element is a string
feature_dna_sequence_length has a value which is an int
feature_dna_sequence has a value which is a string
feature_md5 has a value which is a string
feature_locations has a value which is a reference to a list where each element is a data_api2.Region
feature_publications has a value which is a reference to a list where each element is a string
feature_quality_warnings has a value which is a reference to a list where each element is a string
feature_quality_score has a value which is a reference to a list where each element is a string
feature_notes has a value which is a reference to a list where each element is a string
feature_inference has a value which is a string


=end text

=back



=head2 Protein_data

=over 4



=item Definition

=begin html

<pre>
a reference to a hash where the following keys are defined:
protein_id has a value which is a string
protein_amino_acid_sequence has a value which is a string
protein_function has a value which is a string
protein_aliases has a value which is a reference to a list where each element is a string
protein_md5 has a value which is a string
protein_domain_locations has a value which is a reference to a list where each element is a string

</pre>

=end html

=begin text

a reference to a hash where the following keys are defined:
protein_id has a value which is a string
protein_amino_acid_sequence has a value which is a string
protein_function has a value which is a string
protein_aliases has a value which is a reference to a list where each element is a string
protein_md5 has a value which is a string
protein_domain_locations has a value which is a reference to a list where each element is a string


=end text

=back



=cut

package data_api2::data_api2Client::RpcClient;
use base 'JSON::RPC::Client';
use POSIX;
use strict;

#
# Override JSON::RPC::Client::call because it doesn't handle error returns properly.
#

sub call {
    my ($self, $uri, $headers, $obj) = @_;
    my $result;


    {
	if ($uri =~ /\?/) {
	    $result = $self->_get($uri);
	}
	else {
	    Carp::croak "not hashref." unless (ref $obj eq 'HASH');
	    $result = $self->_post($uri, $headers, $obj);
	}

    }

    my $service = $obj->{method} =~ /^system\./ if ( $obj );

    $self->status_line($result->status_line);

    if ($result->is_success) {

        return unless($result->content); # notification?

        if ($service) {
            return JSON::RPC::ServiceObject->new($result, $self->json);
        }

        return JSON::RPC::ReturnObject->new($result, $self->json);
    }
    elsif ($result->content_type eq 'application/json')
    {
        return JSON::RPC::ReturnObject->new($result, $self->json);
    }
    else {
        return;
    }
}


sub _post {
    my ($self, $uri, $headers, $obj) = @_;
    my $json = $self->json;

    $obj->{version} ||= $self->{version} || '1.1';

    if ($obj->{version} eq '1.0') {
        delete $obj->{version};
        if (exists $obj->{id}) {
            $self->id($obj->{id}) if ($obj->{id}); # if undef, it is notification.
        }
        else {
            $obj->{id} = $self->id || ($self->id('JSON::RPC::Client'));
        }
    }
    else {
        # $obj->{id} = $self->id if (defined $self->id);
	# Assign a random number to the id if one hasn't been set
	$obj->{id} = (defined $self->id) ? $self->id : substr(rand(),2);
    }

    my $content = $json->encode($obj);

    $self->ua->post(
        $uri,
        Content_Type   => $self->{content_type},
        Content        => $content,
        Accept         => 'application/json',
	@$headers,
	($self->{token} ? (Authorization => $self->{token}) : ()),
    );
}



1;
