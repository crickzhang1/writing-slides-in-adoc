.PHONY: test clean install-ruby all httpd FORCE

all: clean index
	@./rubyconvert *.adoc

test: clean presentation.html

%.adoc: FORCE
	@./rubyconvert $@

%.html: FORCE
	@./rubyconvert $*.adoc

httpd: index
	@./rubyhttpd

clean:
	-@rm -f *.html index.adoc

FORCE:

install-ruby:
	@echo "Import public key"
	# Directly import since on Debian 9 gpg2 has a bug failing with key-server
	command curl -sSL https://rvm.io/mpapis.asc | gpg --import -
	@echo "Install rvm and ruby"
	@\curl -sSL https://get.rvm.io | bash -s stable --ruby
	@grep ".rvm/scripts/rvm" ~/.bashrc 1>/dev/null 2>&1
	@if [ $? == 1 ]; then \
	    echo "source ~/.rvm/scripts/rvm" > ~/.bashrc; \
	fi
	@echo "Installing bundler and asciidoctor-revealjs"
	@gem install bundler
	@make install-bundle

install-bundle:
	@echo "Bundle installing packages."
	@bundle config --local github.https true
	@bundle --path=.bundle/gems --binstubs=.bundle/.bin
	@echo "Cloning Reveal.js"
	@if [ ! -d reveal.js ]; then \
	    git clone -b 3.6.0 --depth 1 https://github.com/hakimel/reveal.js.git; \
	else \
	    echo "    Already cloned. Skipping it."; \
	fi

index: FORCE
	@echo "Generating index.html."
	-@rm -f index.adoc index.html
	@./generateindex
	@bundle exec asciidoctor index.adoc
