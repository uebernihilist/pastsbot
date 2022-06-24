# pastsbot

Simple Discord selfbot for trolling using pastes

## Installation

### Releases

<https://github.com/uebernihilist/pastsbot/releases>

### Compilation

Check if you have Crystal and Shards installed in order to compile the selfbot

```sh
crystal --version && shards --version
```

It should output something like this

```sh
Crystal 1.4.1 [b7377c041] (2022-04-22)

LLVM: 10.0.0
Default target: x86_64-unknown-linux-gnu
Shards 0.17.0 [85b30b5] (2022-03-24)
```

Then clone the repo

```sh
git clone git@github.com:uebernihilist/pastsbot.git && cd pastsbot
```

Install dependencies

```sh
shards install
```

And finally compile

```sh
shards build --release
```

## Usage

After installation you need to create an `.env` file in the root of the project with the following variables:

```sh
TOKEN # Discord user token
ID # Discord user ID
DB_NAME # MongoDB DB name
DB_USER_NAME # MongoDB DB user name
DB_USER_PASSWD # MongoDB DB user password
```

Run the binary. Profit!

### Commands

```sh
:! # name all pastes
:* # tthe amount of all pastes
:+ name <> past # add new past
:? past # get paste by name
:@ # show this help message
```

## Contributing

1. Fork it (<https://github.com/uebernihilist/pastsbot/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [uebernihilist](https://github.com/uebernihilist) - creator and maintainer
