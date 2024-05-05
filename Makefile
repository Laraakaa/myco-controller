NAME=myco-controller
TARGET=thumbv7em-none-eabihf

RUST_OBJ_COPY=cargo-objcopy
RUST_CARGO_COPY=cargo-size
UF2CONV=uf2conv

UF2BASE=0x26000

.PHONY: all bin uf2
all: bin uf2
bin: target/$(TARGET)/release/$(NAME).bin
uf2: target/$(TARGET)/release/$(NAME).uf2

target/$(TARGET)/release/$(NAME).bin: src/*
	$(RUST_OBJ_COPY) --release -- -O binary $@
	$(RUST_CARGO_COPY) --release -- -A

target/$(TARGET)/release/$(NAME).uf2: target/$(TARGET)/release/$(NAME).bin
	$(UF2CONV) -f 0xADA52840 --base $(UF2BASE) --output $@ $<

.PHONY: clean
clean:
	cargo clean