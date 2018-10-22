# README

For relational db, in order to know which likes and comments go to which article, 
the News API doesn't assign an unique id for each article, so instead of storing the raw url as the id, 
I use encode the article url using MD5 and use it as an id in the database.
So for https://www.cnn.com/2018/10/22/politics/transgender-trump-protection-rollback-trnd/index.html, the id
would be ff02cfef42e6667b032fd69d803a3e3d

We are using this: https://newsapi.org/docs/endpoints/top-headlines