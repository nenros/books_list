# Books list

## Endpoints
### Unathorized: 
* `POST` `/author` -> create new author, return authorization token in header `x-author-token`
### Needs authorization
By authorization I mean correct token `x-author-token`
* `GET` `/api/author` -> return current author
* `PATCH` `PUT` `/api/author` -> updates current author
* `GET` `/api/articles` -> return list of articles with author details
* `POST` `/api/articles` -> create article
* `DELETE` `/api/articles/:id` -> deletes given article (need to be current author article)


## Improvements
* prepare function to authorize conn instead copying header name everywhere
* add test for authenticate plug
