pub:
	mix hex.build
	git tag -a "v0.1.6" -m "v0.1.6"
	git push origin "v0.1.6"
	mix hex.publish
