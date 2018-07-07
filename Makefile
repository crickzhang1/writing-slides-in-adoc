.PHONY: test clean install-ruby all httpd

all:
	@make clean
	@./rubyconvert *.adoc

test:
	-@rm -f presentation.html
	make presentation.html

%.html: %.adoc
	@make clean
	@./rubyconvert $<

httpd:
	@./rubyhttpd

clean:
	-@rm -f *.html

install-ruby:
	echo "Import public key"
	# Directly import since on Debian 9 gpg2 has a bug failing with key-server
	command curl -sSL https://rvm.io/mpapis.asc | gpg --import -
	echo "Install rvm and ruby"
	\curl -sSL https://get.rvm.io | bash -s stable --ruby
	grep ".rvm/scripts/rvm" .bashrc 1>/dev/null 2>&1
	if [ $? == 1 ]\
	then\
	    echo "source ~.rvm/scripts/rvm"\
	fi
	echo "Installing bundler and asciidoctor-revealjs"
	gem install bundler
	bundle config --local github.https true
	bundle --path=.bundle/gems --binstubs=.bundle/.bin
	echo "Cloning Reveal.js"
	git clone -b 3.6.0 --depth 1 https://github.com/hakimel/reveal.js.git
