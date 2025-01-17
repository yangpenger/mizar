module := mizar

submodules := tests
-include $(patsubst %, $(module)/%/module.mk, $(submodules))

GRPC_FLAGS := -I mizar/proto/ --python_out=. --grpc_python_out=.
PATH := $(PATH):/usr/local/go/bin:$(HOME)/go/bin

.PHONY: proto
proto:
	python3 -m grpc_tools.protoc $(GRPC_FLAGS) mizar/proto/mizar/proto/*.proto

.PHONY: proto_go
proto_go:
	protoc --go_out=. --go-grpc_out=. mizar/proto/mizar/proto/interface.proto

clean::
	rm -rf mizar/proto/__pycache__
	find mizar/proto/ -name '*.py' -not -name '__init__.py' -delete
	rm -rf pkg/grpc/