.PHONY: build

build:
	cd build && cmake .. -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -DCMAKE_BUILD_TYPE=Debug
	cd build && make -j16
	cd build && ./MyProject
