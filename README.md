Augustine's 16th Law
===

[Augustine's Laws](https://en.wikipedia.org/wiki/Augustine%27s_laws)
are a collection of tips from a decades of government contracting.
One of them observed that the price of fighter aircraft was growing
faster than the US defense budget:

> Law Number XVI: In the year 2054, the entire defense budget will
> purchase just one aircraft. This aircraft will have to be shared by
> the Air Force and Navy 3-1/2 days each per week except for leap year,
> when it will be made available to the Marines for the extra day.

This R script attempts to verify this law.

* [FDEX](https://fred.stlouisfed.org/series/FDEFX)
* [GDP](https://fred.stlouisfed.org/series/GDP)
* [Combat aircraft prices](https://en.wikipedia.org/wiki/File:Augustine%27s_law.svg)


![Plot of combat aircraft prices, FDEX and GDP on a logscale](augustine.png)

Some concerns about the data sets:
* Are they all nominal prices or is there a mix of real (inflation adjusted) and nominal?
* How accurate are the prices? Wikipedia F-35 disagrees, for instance.
* What happens when `FDEX` > `GDP`?
* Does it make sense to do linear extrapolation on log of nominal prices?
* Is it true that everything looks linear on a log/log scale?
