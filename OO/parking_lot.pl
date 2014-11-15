package Car;

package Ferrari;
use base 'Car';

package Chevrolet;
use base 'Car';

package ParkingLot;

sub add_car {
  if (ref $car = 'Ferrari') {
    $self->park_ferrari;
  } elsif (ref $car = 'Chevrolet') {
    $self->park_chevrolet;
  } else {
    die "Unknown car model!";
  }
}
