BIN = node_modules/.bin
COFFEE_SRC = coffee/
COFFEE_OUT = js/
JS_SRC     = js/home.js js/artworks.js js/artwork.js
JS_OUT 	   = js/bundle.min.js
LESS_SRC   = less/style.less
LESS_OUT   = css/bundle.min.css

# Minify javascript and css files and generate bundled files.
assets:
	$(BIN)/coffee --compile --output $(COFFEE_OUT) $(COFFEE_SRC)
	$(BIN)/uglifyjs $(JS_SRC) -o $(JS_OUT) -c -m
	$(BIN)/lessc --clean-css $(LESS_SRC) > $(LESS_OUT)
