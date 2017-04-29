# Process word list
  while (my $word = <>) {
    chomp $word;
    my $sorted = join "", sort split //, $word;  # normal form
    push @{$anagrams{$sorted}}, $word;
  }

  for my $words (values %anagrams) {
      print "@$words\n" if @$words > 1;
  }
