.PHONY: run build clean analyze test format clean_and_pub_get

run:
	flutter run

pub_add:
	flutter pub add apk --release

clean_and_pub_get:
	@echo Cleaning and getting dependencies...
	flutter clean
	@echo Running pub get...
	flutter pub get
	@echo done!
	@echo _____________________________________________

build_files:
	${MAKE} clean_and_pub_get
	@echo Build files started....
	flutter pub run build_runner build --delete-conflicting-outputs
	@echo Build finished!
	@echo _____________________________________________
