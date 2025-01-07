# Makefile to get CGF Template

OUTPUT_DIR					:= ../../download
EG_TEMPLATE_URL				:= https://www.eg.org/wp/wp-content/uploads/2024/12/egPublStyle-cgf.zip
EG_TEMPLATE_ZIP				:= $(OUTPUT_DIR)/egPublStyle-cgf.zip
EG_TEMPLATE_EXTRACT_DIR		:= $(OUTPUT_DIR)/egPublStyle-cgf/

.PHONY:

all: $(EG_TEMPLATE_EXTRACT_DIR)

$(EG_TEMPLATE_ZIP): 
	mkdir -p $(OUTPUT_DIR)
	wget -N -P $(OUTPUT_DIR)  $(EG_TEMPLATE_URL)

$(EG_TEMPLATE_EXTRACT_DIR): $(EG_TEMPLATE_ZIP)
	unzip -o $(EG_TEMPLATE_ZIP) -d $(OUTPUT_DIR)


