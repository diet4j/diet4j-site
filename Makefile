STAGEDIR = stage

.PHONY: all clean jekyll pull-stage-javadoc open

all: jekyll pull-stage-javadoc

clean:
	rm -rf $(STAGEDIR)/*

jekyll:
	jekyll build -s jekyll -d $(STAGEDIR)

# First generate javadoc in ../diet4j with mvn javadoc:javadoc
pull-stage-javadoc:
	mkdir "$(STAGEDIR)/javadoc"
	cp -r ../diet4j/target/site/apidocs/* "$(STAGEDIR)/javadoc/"

# for me lazy person on a Mac
open:
	open -a Firefox http://diet4j.aviatis.com/

