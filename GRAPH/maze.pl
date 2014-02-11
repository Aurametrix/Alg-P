use strict;
use warnings;
use Data::Dumper;

# Breadth First Recursion
# Create a queue to store original nodes, 
# while it is not empty Pop the first node N off the queue.
# Mark that node as "traversed" in a hash with a key of N by changing value to 1
# Print N to the path
# Find all the nodes from DB connected from N.
# Add those nodes from the last step that have NOT yet been seen to the end of the queue.

sub solve_maze {
  
    my $me = $_[0];
    my $dest = $_[1];
  
    return ($me) if $me eq $dest;
 
    # list of directories we have not taken yet and need to get back to  
    my @queue = ($me);
    # all routes we have found
    my %route = ($me => [$me]); 
    my @routes_to_dest;
  
    while(my $ob = shift @queue) {
  
      foreach my $i (@{$ob->neighbors()}) {
  
      #  log all routes found, not merely the first
      push @routes_to_dest, [ @{$route{$ob}}, $i ] if($i eq $dest);
   
        if(!$route{$i}) {
          $route{$i} = [ @{$route{$ob}}, $i ];
          return \$route{$i} if($i eq $dest);
          push @queue, $i;
        }       
  
      }
    } 
  }


my %route =(36=>[31],31=>[30,22],30=>[20],22=>[20,8],20=>[1],8=>[5],5=>[2],2=>[1,20]);
solve_maze();