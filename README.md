Oyster card challenge
=====================
Synopsis
========
Our challenge from week 2 at Makers Academy focuses on Object orientated orientated design principles. We have been asked to design a system that replicates the use of an oyster card given a set of user stories as a guideline. To my understanding the process that the challenge took us revolves around the idea of starting with a main class and then begin delegating behaviors to other classes in order to follow the single response principles. Currently the project is incomplete.

Challenge -(https://github.com/makersacademy/course/tree/master/oystercard)

Struggles faced
==============
- I had trouble during the delegating process. Changing tests and moving methods whilst still retaining things in a test driven manner was quite stressful.
- Writing a successful feature specs. Especially in this scenario where we would delegate classes, I found myself constantly having to spend time change my feature specs.

Progression / Things I would want to improve
============================================
- To refactor my code further
- To delete unnecessary tests
- More testing on edge cases
- Refine my feature spec

Usage
==========
1) On your terminal, run the command gem install bundle (if you don't have bundle already)

2) Once the installation completes, run bundle

3) On your terminal, run irb and below is an example of how to use the program

```
2.3.3 :001 > require './lib/oystercard'
 => true
2.3.3 :002 > mycard = OysterCard.new
 => #<OysterCard:0x007fad0a969d30 @balance=0, @current_journey=#<Journey:0x007fad0a969d08 @journey_hist=[], @entry_station=nil, @exit_station=nil>>
2.3.3 :003 > mycard.top_up(50)
 => 50
2.3.3 :004 > mycard.touch_in("Leyton")

 => "Leyton"
2.3.3 :005 > mycard.touch_out("Leytonstone")
 => [{:entry=>"Leyton", :exit=>"Leytonstone"}]
2.3.3 :006 > mycard.balance
 => 49
 ```

Running tests
=============

Author/Pair Partners
====================
Albert Yanit, Katie Koschland, Joe Maidman, John Chang, Tahir Razer
