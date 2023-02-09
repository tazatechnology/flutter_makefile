# Flutter Application Makefile
.DEFAULT_TARGET: help

help:
	@echo "###########################################"
	@echo "Makefile Summary"
	@echo "###########################################"
	@echo "make latest          | Update to the latest version of this Makefile (from Github)"
	@echo "---------------------|---------------------"
	@echo "make clean           | Clean the Flutter project folder"
	@echo "make outdated        | List outdated application dependencies"
	@echo "make upgrade         | Upgrade the outdated application dependencies"
	@echo "---------------------|---------------------"
	@echo "make build-android   | Build application for Android (appbundle)"
	@echo "make build-ios       | Build application for iOS"
	@echo "make build-linux     | Build application for Linux"
	@echo "make build-macos     | Build application for MacOS"
	@echo "make build-web       | Build application for Web"
	@echo "make build-windows   | Build application for Windows"
	@echo "---------------------|---------------------"
	@echo "make run             | Run application in release mode for the default platform"
	@echo "make run-[X]         | [X] = linux | macos | web | windows"
	@echo "---------------------|---------------------"
	@echo "make run-debug       | Run application in debug mode for the default platform"
	@echo "make run-debug-[X]   | [X] = linux | macos | web | windows"
	@echo "---------------------|---------------------"
	@echo "make run-profile     | Run application in profile mode for the default platform"
	@echo "make run-profile-[X] | [X] = linux | macos | web | windows"
	@echo "---------------------|---------------------"
	@echo "make pods-ios        | Rebuild CocoaPods for iOS from a clean state"
	@echo "make pods-macos      | Rebuild CocoaPods for MacOS from a clean state"

########################################
# Update to Latest Makefile
########################################

latest:
	@FILE_URL=https://raw.githubusercontent.com/tazatechnology/flutter_makefile/main/Makefile && \
	echo "Updating to latest: $${FILE_URL}" && \
	wget --quiet $${FILE_URL} -O Makefile

########################################
# Flutter Build
########################################

clean:
	flutter clean
	rm -rf pubspec.lock
	flutter pub get

outdated:
	flutter pub get
	flutter pub outdated

upgrade:
	flutter pub get
	flutter pub upgrade
	flutter pub outdated

########################################
# Flutter Build
########################################

build-android: clean
	flutter build appbundle

build-ios: clean
	flutter build ios

build-linux: clean
	flutter build linux

build-macos: clean
	flutter build macos

build-web: clean
	flutter build web

build-windows: clean
	flutter build windows

########################################
# Flutter Run Release 
########################################

run: clean
	flutter run --release

run-linux: clean
	flutter run --release -d linux

run-macos: clean
	flutter run --release -d macos

run-web: clean
	flutter run --release -d chrome

run-windows: clean
	flutter run --release -d windows

########################################
# Flutter Run Debug 
########################################

run-debug: clean
	flutter run --debug

run-debug-linux: clean
	flutter run --debug -d linux

run-debug-macos: clean
	flutter run --debug -d macos

run-debug-web: clean
	flutter run --debug -d chrome

run-debug-windows: clean
	flutter run --debug -d windows

########################################
# Flutter Run Profile 
########################################

run-profile: clean
	flutter run --profile

run-profile-linux: clean
	flutter run --debug -d linux

run-profile-macos: clean
	flutter run --debug -d macos

run-profile-web: clean
	flutter run --debug -d chrome

run-profile-windows: clean
	flutter run --debug -d windows

########################################
# Flutter Build Runner
########################################

build-runner:
	flutter pub get
	flutter pub run build_runner build --delete-conflicting-outputs

########################################
# CocoaPods
########################################

pods-ios: clean
	cd ios && rm -rf Podfile.lock
	cd ios && rm -rf Pods
	cd ios && rm -rf pubspec.lock
	cd ios && pod repo update
	cd ios && pod cache clean --all
	cd ios && pod deintegrate
	cd ios && pod setup
	cd ios && pod install --repo-update

pods-macos: clean
	cd macos && rm -rf Podfile.lock
	cd macos && rm -rf Pods
	cd macos && rm -rf pubspec.lock
	cd macos && pod repo update
	cd macos && pod cache clean --all
	cd macos && pod deintegrate
	cd macos && pod setup
	cd macos && pod install --repo-update
