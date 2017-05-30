# hn-front2rss

This goal of this project is to reduce the time I'm spending on Hacker News.
I really love the quality of the submissions and the interesting discussions about them.

However, reading HN is just like gambling. Sometimes you win, but most of the times you loose 
(read: most of the time there are no new interesting articles).

## How it works
This [sinatra](www.sinatrarb.com) server publishes an Atom RSS feed on http://localhost:8084/hn.rss
that contains the stories from the first two pages of the "Front" list.
E.g. on Jan 8th 2017, it will generate RSS items for 
https://news.ycombinator.com/front?day=2017-01-07&p=1 and
https://news.ycombinator.com/front?day=2017-01-07&p=2.

I recommend to use Tiny Tiny RSS to queue incoming stories.

## Installation on nixos
- Fetch the git repository
- Import the module in `$git_root/nixos-service`
- Enable the service `services.hn-front2rss.enable = true`
