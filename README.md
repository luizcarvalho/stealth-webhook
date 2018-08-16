Stealth Webhook give to [Stealth](https://hellostealth.com) a webhook URL to send messages.

PS: Is not generic (YET).
- Uses ActiveRecord
- For Facebook Messenger only
- Static defined fields (yet)


## Getting Started

Getting started with Stealth Wehook is simple:


Add to Gemfile


```
gem 'stealth-webhook'
```

And send a simple notification

    curl -H "Content-Type: application/json" -d '{"recipient": {"fb_id": "1540684789327149"}, "message": "This is a simple notification"}' -X POST http://localhost:3000/api/v1/webhook



## Thanks

Stealth wouldn't exist without the great work of many other open source projects and people including:

* [Stealth](https://hellostealth.com) for creating this awesome bot framework to Ruby.
* [Defensoria Pública do Estado do Tocantins](http://www.defensoria.to.def.br) for belive in this project.

## License

Stealth Webhook source code is released under the MIT License.
