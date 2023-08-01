# maggot-fb

### Filebrowser for use with Maggot

* Here are some scripts facilitating the configuration and launching of the server application

* First of all, you must edit the _etc/initdb.sh_ then _run.sh_ files in order to specify the parameters such as the path to the data root (_FB_DATADIR_), the listening port (_FB_PORT_).
* In the _etc/initdb.sh_ file you must also
	* specify keys for [reCAPTCHA](https://www.google.com/recaptcha/about/) if needed
	* change the passwords for the two users (admin and maggot) created when the database was initialized.

* Then you have to run the database initialization only once.
	```sh
	sh  ./etc/initdb.sh
	```
* You will probably need to configure your web server (Apache or Nginx) if you use a proxy server. Under ./etc is provided an example for Nginx.

* To launch the Filebrowser app
	```sh
	sh  ./run.sh start
	```

* To stop the Filebrowser app
	```sh
	sh  ./run.sh stop
	```

### Links related to Filebrowser

#### Web site
https://filebrowser.org/

#### Github
https://github.com/filebrowser/filebrowser

#### Release - v2.23.0
https://github.com/filebrowser/filebrowser/releases/tag/v2.23.0

