> i guess there's some problem in app's structure. probably need a rewrite


## Known issues
	* profile pic accepts all files, but should  only accept jpg/png/webp


- [ ] Interface
	- [x] Main page
	- [x] sensor dashboard
	- [ ] User page

- [ ] Connectors
	- [ ] define how connector/api should work
	- [ ] Upload data from app to blockchain network
		- Q: should data be stored on database?
	- [x] provide interface for capturing picture in home screen
	- [ ] make the ML algorithm - API - to upload picture and get output. 
	```
	[backend] <-> [connector] <-> [interface]
	```