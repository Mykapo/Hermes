# Hermes

Pickle API

## Install and deploy

This project works with docker and docker-compose. It was tested for docker version `18.09.2` and docker-compose version `1.23.2`. To run this project simply do

```bash
git clone https://github.com/Mykapo/Hermes.git
cd Hermes
```

You will need to create a `global.env` file which you have a model with `global.env.dist`. So you can run
```bash
cp global.env.dist global.env
```

and eventually change the values.


The exposed port is `8080` and no volume is mapped, so make sure your port `8080` is free to use. When you're ready, juste run 
```bash
# Make sure none of these container is running
yes | docker-compose rm && docker-compose up --build
```

## Available routes

### Static Files
`GET`
```
/:image_name
```

return image if it exists

### User

`GET`
```
/user/new
```

create a new user and returns it as JSON

`GET`
```bash
/user/:user_id
```

returns user if it exists

### Mission

Missions are sent based on user level, so you always have to send a valid user_id to get missions

`GET`
```bash
/:user_id/missions/new
``` 

Returns the long mission currently running or a new one, plus 3 short missions based on user level

`GET`
```bash
/:user_id/:mission_id/:result
```

Where `:result` must be either victory, defeat or draw. Update the user's elo score.

## JSON Format

As codables are shared between frontend and backend, they are defined in a library you can find on [this repo](https://github.com/Mykapo/GaiaCodables)

### User
```json
{
  "id": String, // (from UUID)
  "level":Int,
  "missions":[Mission],
  "nickname": String,
  "elo": Elo,
}
```

### Mission
```json
{
  "duration":Int,
  "id": String, // (from UUID),
  "results": String,
  "explanations": String,
  "image": String,
  "mainSubject": String, // in energy, food, waste
  "description": String,
  "tips": [String],
  "elo": Elo,
}
```

### Elo
```json
{
  "energy": Int,
  "waste": Int,
  "food": Int,
}
```

## Elo

User's progression is based on [Elo Score](https://en.wikipedia.org/wiki/Elo_rating_system) in order to always propose coherent mission compared to user's level.

For a better repartition of our users, we chose to set the diffrent steps at 800 elo and 2000. This score is obtained by making an average of all three elos (energy, waste and food).
