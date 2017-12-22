.ONESHELL:
setup:
	@echo 'You only need to run setup once'
	@echo
	@echo '=====! Installing jailkit tool !===='
	wget http://olivier.sessink.nl/jailkit/jailkit-2.19.tar.gz
	tar -xf jailkit-2.19.tar.gz
	cd jailkit-2.17/
	./configure && make
	su root
	make install
