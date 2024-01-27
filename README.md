# README for code challenge for Thomas Ditman

## Code challenge portion

Using an HTTP GET method, retrieve information from Wikipedia using a given topic.
Query
https://en.wikipedia.org/w/api.php?action=parse&section=0&prop=text&format=json&page=[topic] to get the topic Wikipedia article. Print the total number of times that the string [topic] appears in the article's text field.
Note: the search is case-sensitive
The query response from the website is a JSON object described below:
• parse: A JSON object representing the article's parsed web page. It has the following three fields:
1. title: The article's title, as specified by the argument passed as topic
2. pageid: The article's Page ID
3. text: A JSON object that contains the Wikipedia article as an HTML dump

## Long form Questions

Planning for failure
It’s fairly easy to write code for the happy path- code executes quickly, all external api calls respond quickly, no errors, etc. Handling problems gracefully can be a bit more challenging.
Let’s say you’ve got an online store and you use some external api to process payments. If all goes well, when the user clicks “submit order” on the website, your code creates an order in the database, calls the payment api (which usually returns in about 1 second or so), and then the UI for the user updates to let them know their order will be shipped.

###Happy Path:

User clicks submit -> waits 1 - 2 seconds -> UI updates to say order is shipped.

Today, however, the payment processor is having issues and the api is very slow.
Shortly after that starts, your customer service department is getting complaints from people saying that nothing happens when they submit an order. Other customers are reporting that they’ve been charged multiple times for one order.


###Unhappy customer 1:

User clicks submit -> waits 30 seconds -> nothing happens -> user is charged and order is shipped.


###Unhappy customer 2:

User clicks submit -> waits 45 seconds -> user is charged twice -> UI updates to say order is shipped.


###Unhappy customer 3:

User clicks submit -> nothing happens -> user clicks submit again -> UI updates to say order is shipped. User was charged twice, order shipped once.


## Task

For each scenario, describe what might have gone wrong, and then propose a solution.