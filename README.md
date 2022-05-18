# shopify_challenge

Just a basic backend application, and my first Ruby program!

Made in just 2 days! Learned Ruby and Rails in that time! (Had experience with REST, SQL, templating (Handlebars), and Node.JS in the past, so it was really just learning how MVC worked and the syntax)

### Running on replit

1. Fork the repl
2. Initialize with **`sh init.sh`** in the console/shell *(drops, creates and migrates database + processes SCSS; give some time to run)* *(**optional**, try running the repl first without it to get a sense of what the site looks like)*
3. Run the repl project
4. Open in new tab *(**optional**, replit hides the relative path of pages, but opening it in a tab lets you see the full URL)*

### Possible issues that may occur (and hopefully how to fix them)

You got to fork the repl in order to run the project. Otherwise, it won't load or you'll get some sort of blocking issue. It works the same as with replit's Rails template. If you fork it and you don't see anything, try opening in a new tab. If that failed, the URL probably didn't match the regex in "/config/application.rb".

You don't have to run `sh init.sh`, it's just for rebuilding the project (and keeping my sanity). But if you want to start with an empty database, or if the CSS looks weird, run it. Also, `./init.sh` will fail due to permission issues, so you got to call it through `sh` directly.

If you have an issue with RAM usage, just run **`kill 1`** in the shell and reload the page.

If none of that works, just try **`busybox reboot`** and select `busybox.out` from the list of commands, or just give it 5-10 minutes for replit.com to fix itself (yeah, had an issue once where it just resolved itself with time)

### Instructions on how to use the site

There are three pages for interacting with the site: Shopping (`/`), Inventory (`/inventory/`) and Backlog (`/backlog/`)

First thing to do is create items to buy. An admin would go to the Inventory page and add items (name and quantity) to the inventory.

Then, a customer would use the Shopping page to add items (click on the cards) to their cart (to remove, just click on items in the cart). They can then put in their name and address and submit their order.

To see the orders, admins can go to the Backlog page. By clicking on customers, they can see their order.

**NOTE: In order to see changes, you need to refresh the page manually, I didn't add any auto-refresh to the frontend**

### Internal Design

There are 4 tables/models: Item, Store, Order, Request. 
* Item stores the names of goods.
* Store is the inventory and stores references to items (belongs-to) and their quantities.
* Order stores customers' names and destinations.
* Request stores references to items and orders (belong-to) and the requested quantity.

When a number of items is added to the inventory, the server creates the item (if it doesn't exist already) and creates or increments the quantity in the corresponding store. When a customer orders something, it creates an order and the corresponding requests and decrements the quantity in the corresponding store for each item ordered.

### API Structure
All API paths are located in `/api/v1/`
* `items` resource
* `orders` resource
* `requests` resource
* `stores` resource
* `checkout`
* `additem`

Resource APIs directly modify tables with CRUD commands

For example, the `items` resource:
* CREATE: `POST /items/`
* READ: `GET /items/` or `GET /items/:id`
* UPDATE: `PUT /items/:id`
* DELETE: `DELETE /items/:id`

Rather than use CRUD commands directly (which would be difficult to secure), the webapp uses a mixture of templating and specific transactional API calls (if something goes wrong in the API call, all changes to the database are rolled back)

Transactional API calls:

`/api/v1/checkout` is used on the Shopping page to create an order

`/api/v1/additem` is used on the Inventory page to add items to inventory

### Language, Frameworks & Dependencies
* Ruby, as language of choice
* Rails, for server framework (since Shopify uses it, I figured it would be good if I did too)
* Bootstrap, for basic styling
* JQuery, for easier JS
* dartsass-rails, for CSS preprocessing

### TODO

In the future, this app could be extended to have an `removeitem` API for admins to delete items.

There could also be an API to fulfill orders or rollback canceled orders.

There is no proper security on this site, there would have to be token authorization to make the API secure, which would involve storing User accounts and salted+hashed passwords

Make the page refresh automatically; didn't do it since it would be easiest with AJAX, but didn't want to spend any more time before submitting adding new dependencies
