STAGEDIR = stage
CACHEDIR = cache

.PHONY: all clean jekyll open

all: jekyll

clean:
	rm -rf $(STAGEDIR)/*

jekyll:
	jekyll build -s jekyll -d $(STAGEDIR)

open:
	open -a Firefox http://diet4j.aviatis.com/

