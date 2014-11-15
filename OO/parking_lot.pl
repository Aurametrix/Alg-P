package Car;

sub park {
  # park a generic Car
}

package Ferrari;
use base 'Car';
sub park {
  # take the Ferrari for a spin before parking it
  $self->drive_fast;
  $self->SUPER::park;
}

package Chevrolet;
use base 'Car';
# No sub park defined, so it just parks like a generic Car

package ParkingLot;

sub add_car {
$car->park;
}
