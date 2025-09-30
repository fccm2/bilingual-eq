all: dict.cmo paras.cmo
opt: main.opt

dict.cmi: dict.mli
	ocamlc -c dict.mli

dict.cmo: dict.ml dict.cmi
	ocamlc -c -I ./sexpr/ SExpr.cma dict.ml

dict.cmx: dict.ml dict.cmi
	ocamlopt -c -I ./sexpr/ SExpr.cmxa dict.ml

paras.cmi: paras.mli
	ocamlc -c paras.mli

paras.cmo: paras.ml paras.cmi
	ocamlc -c -I ./xmlerr-0.07/ xmlerr.cma paras.ml

paras.cmx: paras.ml paras.cmi
	ocamlopt -c -I ./xmlerr-0.07/ xmlerr.cmxa paras.ml


main.opt: main.ml dict.cmx paras.cmx strings.cmx io.cmx charEsc.cmx
	ocamlopt strings.cmx io.cmx charEsc.cmx -I ./sexpr/ SExpr.cmxa dict.cmx  -I ./xmlerr-0.07/ xmlerr.cmxa paras.cmx main.ml -o main.opt

run: dict.cmo paras.cmo strings.cmo io.cmo charEsc.cmo
	ocaml strings.cmo io.cmo charEsc.cmo -I ./sexpr/ SExpr.cma dict.cmo  -I ./xmlerr-0.07/ xmlerr.cma paras.cmo main.ml


%.cmi: %.mli
	ocamlc -c $<

%.cmo: %.ml %.cmi
	ocamlc -c $<

%.cmx: %.ml %.cmi
	ocamlopt -c $<

clean:
	$(RM) *.cm[iox] *.o *.opt

cleangen:
	$(RM) /tmp/en/a*
	$(RM) /tmp/en/b*
	$(RM) /tmp/en/c*
	$(RM) /tmp/en/d*
	$(RM) /tmp/en/e*
	$(RM) /tmp/en/f*
	$(RM) /tmp/en/g*
	$(RM) /tmp/en/h*
	$(RM) /tmp/en/i*
	$(RM) /tmp/en/j*
	$(RM) /tmp/en/k*
	$(RM) /tmp/en/l*
	$(RM) /tmp/en/m*
	$(RM) /tmp/en/n*
	$(RM) /tmp/en/o*
	$(RM) /tmp/en/p*
	$(RM) /tmp/en/q*
	$(RM) /tmp/en/r*
	$(RM) /tmp/en/s*
	$(RM) /tmp/en/t*
	$(RM) /tmp/en/u*
	$(RM) /tmp/en/v*
	$(RM) /tmp/en/w*
	$(RM) /tmp/en/x*
	$(RM) /tmp/en/y*
	$(RM) /tmp/en/z*
	$(RM) /tmp/en/*
	
	$(RM) /tmp/fr/a*
	$(RM) /tmp/fr/b*
	$(RM) /tmp/fr/c*
	$(RM) /tmp/fr/d*
	$(RM) /tmp/fr/e*
	$(RM) /tmp/fr/f*
	$(RM) /tmp/fr/g*
	$(RM) /tmp/fr/h*
	$(RM) /tmp/fr/i*
	$(RM) /tmp/fr/j*
	$(RM) /tmp/fr/k*
	$(RM) /tmp/fr/l*
	$(RM) /tmp/fr/m*
	$(RM) /tmp/fr/n*
	$(RM) /tmp/fr/o*
	$(RM) /tmp/fr/p*
	$(RM) /tmp/fr/q*
	$(RM) /tmp/fr/r*
	$(RM) /tmp/fr/s*
	$(RM) /tmp/fr/t*
	$(RM) /tmp/fr/u*
	$(RM) /tmp/fr/v*
	$(RM) /tmp/fr/w*
	$(RM) /tmp/fr/x*
	$(RM) /tmp/fr/y*
	$(RM) /tmp/fr/z*
	$(RM) /tmp/fr/*


# deps:

charEsc.cmo : \
    strings.cmi \
    charEsc.cmi
charEsc.cmx : \
    strings.cmx \
    charEsc.cmi
charEsc.cmi :
dict.cmo : \
    dict.cmi
dict.cmx : \
    dict.cmi
dict.cmi :
io.cmo : \
    io.cmi
io.cmx : \
    io.cmi
io.cmi :
main.cmo : \
    strings.cmi \
    paras.cmi \
    io.cmi \
    dict.cmi \
    charEsc.cmi
main.cmx : \
    strings.cmx \
    paras.cmx \
    io.cmx \
    dict.cmx \
    charEsc.cmx
mkpage.cmo : \
    strings.cmi \
    io.cmi
mkpage.cmx : \
    strings.cmx \
    io.cmx
paras.cmo : \
    paras.cmi
paras.cmx : \
    paras.cmi
paras.cmi :
strings.cmo : \
    strings.cmi
strings.cmx : \
    strings.cmi
strings.cmi :
