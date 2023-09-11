versione=`cat VERSION`
cookie=`cat SECRET_COOKIE`

pub:
	mix hex.build
	git tag -a $(versione) -m $(versione)
	git push origin $(versione)
	mix hex.publish

# Esempio per collegarsi a livebook
lvb:
	iex --sname alai --cookie $(cookie) -S mix