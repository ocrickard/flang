#
# Copyright (c) 2015, NVIDIA CORPORATION.  All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#


########## Make rule for test oop327  ########

fcheck.o check_mod.mod: $(SRC)/check_mod.f90
	-$(FC) -c $(FFLAGS) $(SRC)/check_mod.f90 -o fcheck.o

oop327.o:  $(SRC)/oop327.f90 check_mod.mod
	@echo ------------------------------------ building test $@
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/oop327.f90 -o oop327.o

oop327: oop327.o fcheck.o
	-$(FC) $(FFLAGS) $(LDFLAGS) oop327.o fcheck.o $(LIBS) -o oop327

oop327.run: oop327
	@echo ------------------------------------ executing test oop327
	oop327
	-$(RM) shape_mod.mod

### TA Expected Targets ###

build: $(TEST)

.PHONY: run
run: $(TEST).run

verify: ; 

### End of Expected Targets ###
