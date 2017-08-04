OCBFLAGS := -classic-display
OCB := ocamlbuild $(OCBFLAGS)

.PHONY: all debug clean top

all: clean laslib.cma laslib.cmxa las.native las.byte

debug: all las.cma

%.cma:
	$(OCB) $@

%.cmxa:
	$(OCB) $@

%.native:
	$(OCB) $@
	
%.byte:
	$(OCB) $@

clean:
	$(OCB) -clean
	$(RM) src/version.ml*

top: debug
	ocaml
