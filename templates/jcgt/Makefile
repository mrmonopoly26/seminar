# Makefile to get CGF Template

OUTPUT_DIR					:= ../../download
TEMPLATE_URL				:= https://www.jcgt.org/files/jcgt-template.zip
TEMPLATE_ZIP				:= $(OUTPUT_DIR)/jcgt-template.zip
TEMPLATE_EXTRACT_DIR		:= $(OUTPUT_DIR)/jcgt-template/

.PHONY:

all: $(TEMPLATE_EXTRACT_DIR)

$(TEMPLATE_ZIP): 
	mkdir -p $(OUTPUT_DIR)
	wget -N -P $(OUTPUT_DIR)  $(TEMPLATE_URL)

$(TEMPLATE_EXTRACT_DIR): $(TEMPLATE_ZIP)
	unzip -o $(TEMPLATE_ZIP) -d $(OUTPUT_DIR)





