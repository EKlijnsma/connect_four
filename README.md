# The Odin Project - Connect Four with Test Driven Development
From the assignment:
> The game rules are fairly straightforward and you’ll be building it on the command line like you did with the other games. If you want to spice up your game pieces, look up the unicode miscellaneous symbols on Wikipedia. The Ruby part of this should be well within your capability by now so it shouldn’t tax you much to think about it.
>
> The major difference here is that you’ll be doing this TDD-style. So figure out what needs to happen, write a (failing) test for it, then write the code to make that test pass, then see if there’s anything you can do to refactor your code and make it better.
>
> Only write exactly enough code to make your test pass. Oftentimes, you’ll end up having to write two tests in order to make a method do anything useful. That’s okay here. It may feel a bit like overkill, but that’s the point of the exercise. Your thoughts will probably be something like “Okay, I need to make this thing happen. How do I test it? Okay, wrote the test, how do I code it into Ruby? Okay, wrote the Ruby, how can I make this better?” You’ll find yourself spending a fair bit of time Googling and trying to figure out exactly how to test a particular bit of functionality. That’s also okay… You’re really learning RSpec here, not Ruby, and it takes some getting used to.

Honestly I find this quite difficult, probably because I need to think in advance about what the code or the class must do. 
For a start I considered that the Player class would be very a very small example to start with. 
So what does it need to do initially? 
- get the users' input (which column of the cage to drop a token into)
- verify the input (make sure the input is valid)
That's what I started with.
