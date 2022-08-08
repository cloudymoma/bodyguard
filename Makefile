# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)

SRC = $(wildcard src*) 
CLEAN = $(addsuffix _clean,$(SRC))

.PHONY: clean $(SRC) $(CLEAN)

all: $(SRC)
clean: $(CLEAN)

$(SRC):
	$(MAKE) -C $@

$(CLEAN):
	$(MAKE) -C $(subst _clean,,$@) clean
