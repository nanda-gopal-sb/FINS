## Known issues
	* profile pic accepts all files, but should  only accept jpg/png/webp
	* Sensor data is stuck in loading screen when input from Rasberry-pi not available. Should show previous availiable data.

- [x] Interface
	- [x] Main page
	- [x] sensor dashboard
	- [x] User page

- [ ] Connectors
	- [ ] define how connector/api should work
	- [ ] Upload data from app to blockchain network
		- Q: should data be stored on database?
	- [x] provide interface for capturing picture in home screen
	- [x] make the ML algorithm - API - to upload picture and get output.
	- [] Implement the DL program in flutter using, packages 
	```
	[backend] <-> [connector] <-> [interface]
	```