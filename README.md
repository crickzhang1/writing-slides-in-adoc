# Writing Slides with Asciidoctor

Convenience configuration to set up to writing slides with Asciidoctor.

Refer to official website page [Asciidoctor Reveal.js](https://asciidoctor.org/docs/asciidoctor-revealjs/) more details about environtment/tooling setup and usage.

Presentation.adoc is an example and also as my template for new slides.

## Simple Usage

* Clone this repo and run `make install-ruby`.
** If already run `make install-ruby` before, may just run `make install-bundle`
* To converting `.adoc` to `.html`: `make all`
* To serve current directory with simple http server at port 5000: `make httpd`
* Open browser and navigate to `localhost:5000` and open your `presentation.html`.

## LICENSE

MIT.
