CONTAINER_NAME:="rustbuilder-oneget:local"
RUST_MOUNT_PATH:=C:\Users\quadm\Develop\rust

all: build

build:
	docker build -t $(CONTAINER_NAME) .

run:
	docker run --name rust_builder_oneget --rm -it -v "$(RUST_MOUNT_PATH):C:\rust" $(CONTAINER_NAME)