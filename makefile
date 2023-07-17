FILE=VERSION
versione=`cat $(FILE)`

pub:
	mix hex.build
	git tag -a $(ver) -m (ver)
	git push origin $(ver)
	mix hex.publish
