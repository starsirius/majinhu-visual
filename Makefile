BIN = node_modules/.bin
COFFEE_SRC = coffee/
COFFEE_OUT = js/
JS_SRC     = js/home.js js/artworks.js js/artwork.js
JS_OUT 	   = js/bundle.min.js
LESS_SRC   = less/style.less
LESS_OUT   = css/style.css
CSS_SRC    = css/icon-fonts.css css/style.css
CSS_OUT    = css/bundle.min.css

# Minify javascript and css files and generate bundled files.
assets:
	$(BIN)/coffee --compile --output $(COFFEE_OUT) $(COFFEE_SRC)
	$(BIN)/uglifyjs $(JS_SRC) -o $(JS_OUT) -c -m
	$(BIN)/lessc $(LESS_SRC) > $(LESS_OUT)
	cat $(CSS_SRC) | $(BIN)/cleancss -o $(CSS_OUT)
