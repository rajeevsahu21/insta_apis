# Insta Api Project

## List of all the apis
```bash
POST Login
POST Signup
GET logout

GET users => list of all users
POST follow => accept user id and add that user from current users followers
POST unfollow => accept user id and remove that user from current users followers

POST posts => Creating post. Will accept multiple images, caption, tags, location(text field).
PUT posts => Updating the post. Will accept caption, tags and location
DELETE posts => soft deleting a post
GET posts => Will get all the posts of current users except posts that are not deleted. Details will include post images, caption, tags, location and number of likes

GET feed => get all the posts of the users that current user follows
GET comments => Getting all the comments of a particular post
PUT comments => create a comment on a post
PUT likes => like a post, should be unique on user and post
GET likes => Will get which user has liked the post
```

# API Documentation
https://documenter.getpostman.com/view/25422027/2s9YeBeZ2s
