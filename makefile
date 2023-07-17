versione=`cat VERSION`

pub:
	mix hex.build
	git tag -a $(versione) -m $(versione)
	git push origin $(versione)
	mix hex.publish
