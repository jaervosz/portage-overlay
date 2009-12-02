PREFIX=/usr
all:
	@echo Usage make install; make uninstall
install:
	echo Installing Tux Droid
	echo Cleanup the system ...
	rm -f /etc/tuxdroid/tuxdroid.conf
	rm -f /usr/bin/tuxsh
	rm -f /usr/bin/tux_updater
	rm -f /usr/bin/tux_control_center
	rm -f /usr/bin/tuxhttpserver
	rm -f /usr/bin/tuxgi
	rm -f /usr/bin/dfu-programmer
	rm -f /usr/bin/tux_wifi_channel
	rm -f /usr/bin/tuxup
	echo Copying files
	if [ ! -e $(PREFIX) ]; then mkdir -p $(PREFIX); fi
	if [ ! -e $(PREFIX)/lib ]; then mkdir $(PREFIX)/lib; fi
	if [ ! -e $(PREFIX)/bin ]; then mkdir $(PREFIX)/bin; fi
	if [ ! -e $(PREFIX)/share]; then mkdir $(PREFIX)/share; fi
	if [ ! -e $(PREFIX)/share/applications]; then mkdir $(PREFIX)/share/applications; fi
	if [ ! -e $(PREFIX)/share/pixmaps]; then mkdir $(PREFIX)/share/pixmaps; fi
	cp -r ./mirror/etc/* /etc/
	cp -r ./mirror/opt /
	cp -r ./mirror/$(PREFIX)/lib/* $(PREFIX)/lib/
	cp -r ./mirror/$(PREFIX)/bin/* $(PREFIX)/bin/
	cp -r ./mirror/$(PREFIX)/share/tuxdroid $(PREFIX)/share/
	cp -r ./mirror/usr/share/applications/* /usr/share/applications/
	cp -r ./mirror/usr/share/pixmaps/* /usr/share/pixmaps/
	echo Installing python API
	cp -r $(PREFIX)/lib/tuxdroid/python-api/tuxisalive .
	cp $(PREFIX)/lib/tuxdroid/python-api/setup.py .
	python setup.py install >/dev/null
	rm -rf tuxisalive setup.py build
	chmod 0755 $(PREFIX)/share/tuxdroid/tuxhttpserver/tuxhttpserver.py
	chmod 0755 $(PREFIX)/share/tuxdroid/tux_updater/tux_updater
	echo Done.

uninstall:
	echo "Uninstalling Tux Droid"
	rm -r $(PREFIX)/share/tuxdroid
	rm -r $(PREFIX)/lib/tuxdroid
	rm $(PREFIX)/bin/tuxsh
	rm $(PREFIX)/bin/tuxup
	rm $(PREFIX)/bin/tux_control_center
	rm $(PREFIX)/bin/tux_updater
	rm $(PREFIX)/bin/tuxhttpserver
	rm $(PREFIX)/bin/dfu-programmer
	rm $(PREFIX)/bin/tux_wifi_channel
	rm /etc/udev/rules.d/45-tuxdroid.rules
	rm /usr/share/applications/controlcenter.desktop
	rm /usr/share/applications/updater.desktop
	rm /usr/share/pixmaps/tuxcc.png
	rm /usr/share/pixmaps/tuxupd.png
	rm -r /etc/tuxdroid
	echo Done.

