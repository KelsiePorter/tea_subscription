# <p align="center"> :teapot: Tea Subscription :teapot: </p>

This application is a Rails API for a Tea Subscription Service. The project follows guidelines set in place by Turing School of Software & Design. For more information on project requirements: [Take Home Tech Challenge](https://mod4.turing.edu/projects/take_home/take_home_be)

![Ruby](https://img.shields.io/badge/ruby-%23CC342D.svg?style=for-the-badge&logo=ruby&logoColor=white) ![Rails](https://img.shields.io/badge/rails-%23CC0000.svg?style=for-the-badge&logo=ruby-on-rails&logoColor=white) ![Postgres](https://img.shields.io/badge/postgres-%23316192.svg?style=for-the-badge&logo=postgresql&logoColor=white)

## Technologies
- Rails 6.0.6.1
- Ruby 2.7.4
- DB Designer
- Postman
- Gems:
  jsonapi-serializer | shoulda-matchers | rspec-rails 

## Installation
1. Fork and clone this repository
2. `cd` into the root directiory
3. `bundle install`
4. `rails db:{drop,create,migrate}`
5. Run the test suite with `bundle exec rspec`
6. Start the local server by running `rails s`
7. Visit the app on `localhost:3000` in your web browser

## Database Schema

<img width="903" alt="Screen Shot 2023-04-13 at 9 26 18 AM" src="https://user-images.githubusercontent.com/95988505/231808613-2734c478-eb0c-4654-99fa-07b9f6080078.png">

## Endpoints

<details close>

### Create a customer subscription

```http
POST /api/v1/customers/:customer_id/subscriptions/:subscription_id
```

<summary>  Details </summary><br>
This endpoint returns a customer's subscription details
<br><br>

| Code | Description |
| :--- | :--- |
| 201 | `Created` |

Example Value:

```json

{
    "data": {
        "id": "5",
        "type": "customer_subscription",
        "attributes": {
           "customer_id": 1,
            "subscription_id": 2,
            "active": true
        }
    }
}

```

### Get all customer subscriptions

```http
GET /api/v1/customers/:customer_id/subscriptions
```

This endpoint returns all of a customer's subscriptions

| Code | Description |
| :--- | :--- |
| 200 | `OK` |

Example Value:

```json

{
    "data": [
        {
            "id": "1",
            "type": "all_customer_subscriptions",
            "attributes": {
                "id": 1,
                "title": "A",
                "price": 10.99,
                "status": "available",
                "frequency": 30
            }
        },
        {
            "id": "2",
            "type": "all_customer_subscriptions",
            "attributes": {
                "id": 2,
                "title": "Summer Collection",
                "price": 30.5,
                "status": "available",
                "frequency": 30
            }
        },
        {
            "id": "3",
            "type": "all_customer_subscriptions",
            "attributes": {
                "id": 3,
                "title": "Winter Collection",
                "price": 25.99,
                "status": "available",
                "frequency": 30
            }
        }
    ]
}

```

### Update a customer subscription

```http
PATCH /api/v1/customers/:customer_id/subscriptions/:subscription_id
```

This endpoint updates a customer's subscription to be unsubscribed

| Code | Description |
| :--- | :--- |
| 200 | `OK` |

Example Value:

```json

{
    "message": "Successfully unsubscribed from Summer Collection"
}

```

</details>

---


## Contributor
<b>Kelsie Porter</b><br> 
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; GitHub: <a href="https://github.com/KelsiePorter">@KelsiePorter</a> <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; LinkedIn: <a href="https://www.linkedin.com/in/kelsie-porter/">kelsie-porter</a> <br>
