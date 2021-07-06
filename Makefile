#CONFIGURE BUILD SYSTEM
TARGET	   = spmv-SELLC-$(TAG)
TARGET_CRS	   = spmv-CRS-$(TAG)
BUILD_DIR  = ./$(TAG)
SRC_DIR    = ./src
MAKE_DIR   = ./
Q         ?= @

#DO NOT EDIT BELOW
include $(MAKE_DIR)/config.mk
include $(MAKE_DIR)/include_$(TAG).mk
include $(MAKE_DIR)/include_LIKWID.mk
INCLUDES  += -I./include

VPATH     = $(SRC_DIR)
ASM      += $(patsubst $(SRC_DIR)/%.cpp, $(BUILD_DIR)/%.s,$(wildcard $(SRC_DIR)/*.cpp))
OBJ      += $(patsubst $(SRC_DIR)/%.cpp, $(BUILD_DIR)/%.o,$(wildcard $(SRC_DIR)/*.cpp))
OBJ_SELLC      += $(filter-out $(BUILD_DIR)/main_crs.o, ${OBJ})
OBJ_CRS      += $(filter-out $(BUILD_DIR)/main.o, ${OBJ})

CPPFLAGS := $(CPPFLAGS) $(DEFINES) $(OPTIONS) $(INCLUDES)

all: ${TARGET_CRS} ${TARGET}

${TARGET_CRS}: $(BUILD_DIR) $(OBJ_CRS)
	@echo "===>  LINKING  $(TARGET_CRS)"
	$(Q)${LINKER} ${LFLAGS} -o $(TARGET_CRS) $(OBJ_CRS) $(LIBS)


${TARGET}: $(BUILD_DIR) $(OBJ_SELLC)
	@echo "===>  LINKING  $(TARGET)"
	$(Q)${LINKER} ${LFLAGS} -o $(TARGET) $(OBJ_SELLC) $(LIBS)

asm:  $(BUILD_DIR) $(ASM)

$(BUILD_DIR)/%.o:  %.cpp
	@echo "===>  COMPILE  $@"
	$(Q)$(CXX) -c $(CPPFLAGS) $< -o $@
	$(Q)$(CXX) $(CPPFLAGS) -MT $(@:.d=.o) -MM  $< > $(BUILD_DIR)/$*.d


$(BUILD_DIR)/%.s:  %.cpp
	@echo "===>  GENERATE ASM  $@"
	$(CXX) -S $(CPPFLAGS) $(CFLAGS) $< -o $@


tags:
	@echo "===>  GENERATE  TAGS"
	$(Q)ctags -R

$(BUILD_DIR):
	@mkdir $(BUILD_DIR)

ifeq ($(findstring $(MAKECMDGOALS),clean),)
-include $(OBJ:.o=.d)
endif

.PHONY: clean distclean

clean:
	@echo "===>  CLEAN"
	@rm -rf $(BUILD_DIR)
	@rm -f tags

distclean: clean
	@echo "===>  DIST CLEAN"
	@rm -f $(TARGET)
	@rm -f tags

