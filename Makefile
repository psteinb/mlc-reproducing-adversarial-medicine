all: index.html

prepare :
	bundle config --local github.https true
	bundle --path=.bundle/gems --binstubs=.bundle/.bin
	git clone -b 3.6.0 --depth 1 https://github.com/hakimel/reveal.js.git || true
	npm install decktape


%.html : %.adoc references.adoc
	bundle exec asciidoctor-revealjs $<
	sed -i -e '/.*controls: true.*/s/.*/&\n  hash: true,/' -e 's/height: 700/height: 1080/' $@

%.pdf : %.html
	node_modules/.bin/decktape -s 1920x1080 reveal $<\?fragments=true $@

add_images:
	@git add -v `grep 'image:' index.adoc|sed -e 's@.*:\(.*\)\[.*@images/\1@'`
