package Data::LinkedList;

sub new {
    my $pkg = shift;
    my %proto = @_;

    bless \%proto, $pkg;
}

sub data {
    my $self = shift;

    @_ ? ($self->{data} = shift) : $self->{data};
}

sub next {
    my $self = shift;

    @_ ? ($self->{next} = shift) : $self->{next};
}

1;

__END__

my $ele1 = Data::LinkedList->new( data => 'abel' );
my $ele2 = Data::LinkedList->new( data => 'baker', next => $ele1);
