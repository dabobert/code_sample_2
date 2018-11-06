# Challenge

Welcome to the movies! Our team is interested in learning about your process, style, and implementation when solving a software problem. You are staffed on a new project for a movie theater client, the description is below. 

You may email us with any questions, we just ask that you research  and read the documentation below before asking.

Requirements:

* Any programming language is acceptable and you should use a language you're comfortable in. You may be asked to refactor or extend your solution and we may discuss your choice of language.
* Setup a repository on Github and use Git version control to manage project history - we ask that you do not include our company name in your repo name or anywhere in your file.
* Use whichever external libraries you are comfortable with, but please do not use a web framework - it is required for any of the functionality and will get in your way.
* For documentation, a README along with your submission with usage instructions and comments on your design decisions is sufficient.
* Tests are important - they demonstrate that the code is "production ready."
* Email us a link to your repository to us when completed.

## Background

It's your first day on the job for a small movie theater company. Your program will be used to replace a manual system to feed data to showtime tickers and boards located at theaters and on the web. The theater manager Mildred has been using this manual system for years, however she is about to retire. Not only that, the theater is growing and will soon need to scale this system to multiple locations. This is where you come in.

Currently the current movie inventory is kept in a spreadsheet that Mildred manually enters into the marquee. Using a list of the movies exported to a text file, you need to produce a schedule of showings for the theater on a given day. Your application should read a file passed on the command line.

The schedule should be created based on the theater's hours of operation for the given day. The theater hours are as follows (subject to change):

```
Monday - Thursday 8:00am - 11:00pm
Friday - Sunday 10:30am - 11:30pm
```

The client described some business rules in discovery meetings and you should try to follow as many as possible. Assuming that the theater has one available screen per movie, the schedule should repeat each movie as many times possible during the hours of operation. A movie cannot end after the theater closing time. All theaters close before midnight.

When the theater opens it takes one hour to setup the theater before any movies can be shown. Theater cleanup, change over work, and previews require a combined 35 minutes between the end of one showtime and the start of the next. Movies should be scheduled as late as possible so the prime-time evening hours are maximized. Even though the theater is open and ready in the morning, the early hours are the least busy and therefore scheduled last. Showtimes should start at easy to read times (2:35 is preferred to 2:37, for example) and should be formatted in 24 hour time (e.g. hours run from 0-24).

### Example Input

Example Input File

```
Movie Title, Release Year, MPAA Rating, Run Time
There's Something About Mary, 1998, R, 2:14
How to Lose a Guy in 10 Days, 2003, PG-13, 1:56
Knocked Up, 2007, R, 2:08
The Wedding Singer, 1998, PG-13, 1:36
High Fidelity, 2000, R, 1:54
Sleepless in Seattle, 1993, PG, 1:46
The Proposal, 2009, PG-13, 1:48
```

_You can assume comma delimiters will not appear anywhere in the data values (no movie titles with commas, for example)._

### Example Output

Theater management wants to run your program on the command line and expects to see the output printed. For example:

```
application_name example_client_data_file.txt

Thursday 12/31/2015

There's Something About Mary - Rated R, 2:14
  12:15 - 14:29
  15:05 - 17:19
  17:55 - 20:09
  20:45 - 22:59

High Fidelity - Rated R, 1:54
  ...
```

Please note that the above example input file is not a complete set of records as we won't have client data for a few more weeks. You may build your own input files or records however you would like for development purposes. The client will eventually provide a new file every few weeks, so please indicate how to run the program with a specific file in your README.

Email us a link to your repo when you're done!

Have fun and please remember to not include our company name in your repo name, thank you!