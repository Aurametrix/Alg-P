role FIFO {
    method enqueue ( *@values ) { # Add values to queue, returns the number of values added.
        self.push: @values;
        return @values.elems;
    }
    method dequeue ( ) {         # Remove and return the first value from the queue.
                                 # Return Nil if queue is empty.
        return self.elems ?? self.shift !! Nil;
    }
    method is-empty ( ) {        # Check to see if queue is empty. Returns Boolean value.
        return self.elems == 0;
    }
}


# push (aka enqueue) -- @list.push
# pop (aka dequeue)  -- @list.shift
# empty              -- !@list.elems

my @queue = < a >;
 
@queue.push('b', 'c'); # [ a, b, c ]
 
say @queue.shift; # a
say @queue.pop; # c
 
say @queue.perl; # [ b ]
say @queue.elems; # 1
 
@queue.unshift('A'); # [ A, b ]
@queue.push('C'); # [ A, b, C ]
