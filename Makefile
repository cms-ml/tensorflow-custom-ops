ALLIBS := $(patsubst %_module.cc,libtf_op_%.so,$(wildcard *_module.cc))

all: $(ALLIBS)

libtf_op_%.so: %_kernel.o %_module.o 
	g++ -shared -o $@ $^ $(TF_OPS_CFLAGS) -fPIC $(TF_OPS_LFLAGS)

%_module.o: %_module.cc	
	g++ -c -o $@ $< $(TF_OPS_CFLAGS) -fPIC

%_kernel.o: %_kernel.cc
	g++ -c -o $@ $< $(TF_OPS_CFLAGS) -fPIC

clean:
	rm -f $(ALLIBS)

.PRECIOUS: %.o
