STAGEDIR = stage

.PHONY: all clean jekyll stage-javadoc pull-javadoc open

all: jekyll stage-javadoc

clean:
	rm -rf $(STAGEDIR)/*

jekyll:
	jekyll build -s jekyll -d $(STAGEDIR)

stage-javadoc :
	cp -r javadoc $(STAGEDIR)/

pull-javadoc:
	cp -r ../diet4j/target/site/apidocs/* javadoc/

open:
	open -a Firefox http://diet4j.aviatis.com/

