CPP = g++
CFLAGS = -O3 -march=native -mtune=native -Wall -ggdb -pthread
LIBS = -lrelic
RELIC_INCLUDES = -I ../relic-target/include -I ../relic/include -L ../relic-target/lib
RELIC_PATH = ../relic-target/lib

all: Mixnet_lib APITest APITest_full APIBench APITestLib

APITest: APITest.c APISimulator.c APISimulator.h
	${CPP} ${CFLAGS} ${RELIC_INCLUDES} APITest.c APISimulator.c sha224-256.c sha384-512.c ${LIBS} -o APITest -Wl,-R${RELIC_PATH}

APITest_full: APITest_full.c APISimulator.c APISimulator.h
	${CPP} ${CFLAGS} ${RELIC_INCLUDES} APITest_full.c APISimulator.c sha224-256.c sha384-512.c ${LIBS} -o APITest_full -Wl,-R${RELIC_PATH}

APIBench: APIBench.c APISimulator.c APISimulator.h
	${CPP} ${CFLAGS} ${RELIC_INCLUDES} APIBench.c APISimulator.c sha224-256.c sha384-512.c ${LIBS} -o APIBench -Wl,-R${RELIC_PATH}

Mixnet_lib: APISimulator.c APISimulator.h
	${CPP} ${CFLAGS} ${RELIC_INCLUDES} -fPIC -c APISimulator.c sha224-256.c sha384-512.c
	${AR} rcs libmixnet.a APISimulator.o sha224-256.o sha384-512.o

APITestLib: APITest.c APISimulator.c APISimulator.h
	${CPP} ${CFLAGS} ${RELIC_INCLUDES} -L${RELIC_PATH}  APITest.c -L./ -lmixnet ${LIBS} -o APITestLib -Wl,-R${RELIC_PATH}

clean:
	rm *.o *.a APITest APIBench APITest_full APITestLib; ./CleanSession.sh