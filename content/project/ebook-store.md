+++
# Date this page was created.
date = "2016-04-27"

# Project title.
title = "Ebook Store"

# Project summary to display on homepage.
summary = "A storefront to sell and manage ebook sales and subscriptions."

# Optional image to display on homepage (relative to `static/img/` folder).
image_preview = "headers/ebook.jpg"

# Tags: can be used for filtering projects.
# Example: `tags = ["machine-learning", "deep-learning"]`
tags = ["publishing"]

# Optional external URL for project (replaces project detail page).
external_link = ""

# Does the project detail page use math formatting?
math = false

# Optional featured image (relative to `static/img/` folder).
[header]
image = "headers/ebook.jpg"
caption = "©Andrew Mason via <a href='https://www.flickr.com/photos/a_mason/4738779282/'>Flickr</a>"

+++

Credits: John Klima, John Joseph Adams, and Jacob Haddon.

The idea for the ebook store was born back in 2011. I was frustrated with subscriptions to small presses that expired without notice. I reached out to John Klima at Electric Velocipede and we started talking.

I learned more about the distribution side of the publishing business. A small press is a labour of love, often run by small groups of folks whose time is stretched thin. I decided that I would start building tools to
make their jobs easier, allowing them more time to spend on the *craft* of publishing.

Since then, I've written the ebook store in use today by Lightspeed Magazine, Fantasy Magazine, Nightmare Magazine, and <a href="http://lamplightmagazine.com/">Lamplight Magazine</a>, and previously served Fireside Magazine, before they moved to Patreon.

## Ebook Store 1.0
It's implemented via a plugin that integrates into Wordpress. Wordpress is a solid content management system used by a lot of people but it's not without its drawbacks. This platform has served us well, but we're hitting limitations on what we can do without some seriously hacky code.

## Ebook Store 2.0

With the above experience in mind, I've started work on a new ebook store that'll bring with it a slew of new features. The main feature will be centralization. One login will get you access to your account on every ebook store, and a single place where you can see manage all of your magazine subscriptions.

The current stores will continue unchanged for the foreseeable future. When the new storefront is ready, the Wordpress plugin will be deprecate for a new one that takes advantage of the new asynchronous API.
