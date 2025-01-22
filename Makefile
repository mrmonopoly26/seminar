# Configure your paper
TEMPLATE_PATH				:= templates/feif

# Configure programs to use
PDF_VIEWER 					:= evince

# Configure main input files
MAIN_FILE_TEX				:= main.tex
BIBLIOGRAPHY				:= common/bibliography.bib

# Configure output files
OUTPUT_DIR					:= build
OUTPUT_FILE					:= Paper1024

PACKAGE_DIR					:= $(OUTPUT_DIR)/package

### Do not edit below this line
TEMPLATE_LINK				:= template
OUTPUT_FILE_PDF				:= $(OUTPUT_DIR)/$(OUTPUT_FILE).pdf

BIB_PREVIEW_NAME			:= BibPreview
BIB_PREVIEW_NAME_PDF		:= $(OUTPUT_DIR)/$(BIB_PREVIEW_NAME).pdf
BIB_PREVIEW_TEX				:= template/BibPreview.tex

### Latex tools
LATEX_COMPILER				:= pdflatex -shell-escape -halt-on-error -file-line-error -output-directory $(OUTPUT_DIR) 
BIBTEX_COMPILER				:= bibtex

### Folders
TEMPLATE_FILES 				:= $(wildcard $(TEMPLATE_PATH)/**)
COMMON_FILES 				:= $(wildcard common/*.*)
CONTENT_TEX					:= $(wildcard secs/*.tex)
TABLES_TEX					:= $(wildcard tabs/*.tex)
FIGURES_SVG 				:= $(wildcard figs/*.svg)
IMAGES_PNG 					:= $(wildcard imgs/*.png)

BUILD_DEP					:= Makefile $(TEMPLATE_FILES) $(COMMON_FILES) $(CONTENT_TEX) $(TABLES_TEX) $(FIGURES_SVG) $(IMAGES_PNG)

### Timing tools
START_TIME					:= @date +%s%N > $@.time_txt
END_TIME					:= @echo "Build time in seconds: "; echo "scale=3;$$(($$(($$(date +%s%N)-$$(cat $@.time_txt))))).0 * 0.000000001"| bc; rm $@.time_txt	

### Build Rules. Do not edit below this line unless you know what to do.
all: $(OUTPUT_FILE_PDF)

clean:	
	@rm -rf $(OUTPUT_DIR)
	@rm -f $(TEMPLATE_LINK)
	@rm -rf $(PACKAGE_DIR)

$(OUTPUT_FILE_PDF): $(TEMPLATE_LINK) $(BUILD_DEP) 
	$(START_TIME)	
	@$(LATEX_COMPILER) -jobname=$(OUTPUT_FILE) $(MAIN_FILE_TEX); touch $(OUTPUT_DIR)/$(MAINFILE_PDF)
	-@$(BIBTEX_COMPILER) $(OUTPUT_DIR)/$(OUTPUT_FILE)
	@$(LATEX_COMPILER) -jobname=$(OUTPUT_FILE) $(MAIN_FILE_TEX)
	@$(LATEX_COMPILER) -jobname=$(OUTPUT_FILE) $(MAIN_FILE_TEX)
	$(END_TIME)

rebuild: clean $(OUTPUT_FILE_PDF)

bibpreview: $(BIB_PREVIEW_NAME_PDF) 

$(BIB_PREVIEW_NAME_PDF): $(BIBLIOGRAPHY) $(TEMPLATE_LINK) 
	$(START_TIME)	
	@$(LATEX_COMPILER) $(BIB_PREVIEW_TEX); 
	-@$(BIBTEX_COMPILER) $(OUTPUT_DIR)/$(BIB_PREVIEW_NAME)
	@$(LATEX_COMPILER) $(BIB_PREVIEW_TEX); 
	@$(LATEX_COMPILER) $(BIB_PREVIEW_TEX); 
	$(END_TIME)

view: $(OUTPUT_FILE_PDF)	
	@$(PDF_VIEWER) $(shell realpath $(OUTPUT_FILE_PDF)) &

$(OUTPUT_DIR)/%.pdf: tabs/%.tex $(TEMPLATE_LINK) 
	$(START_TIME)	
	@touch $@
	@$(LATEX_COMPILER) $(OUTPUT_DIR)/preview_tab.tex;  mv $(OUTPUT_DIR)/preview_tab.pdf $@;	
	-@$(BIBTEX_COMPILER) $(OUTPUT_DIR)/preview_tab
	@$(LATEX_COMPILER) $(OUTPUT_DIR)/preview_tab.tex
	@$(LATEX_COMPILER) $(OUTPUT_DIR)/preview_tab.tex
	$(END_TIME)

$(OUTPUT_DIR)/%.pdf: figs/%.svg	$(TEMPLATE_LINK) 
	$(START_TIME)	
	@touch $@	
	@$(LATEX_COMPILER) $(OUTPUT_DIR)/preview_fig.tex;  mv $(OUTPUT_DIR)/preview_fig.pdf $@;	
	-@$(BIBTEX_COMPILER) $(OUTPUT_DIR)/preview_fig
	@$(LATEX_COMPILER) $(OUTPUT_DIR)/preview_fig.tex
	@$(LATEX_COMPILER) $(OUTPUT_DIR)/preview_fig.tex
	$(END_TIME)

$(TEMPLATE_LINK): Makefile
	@mkdir -p $(OUTPUT_DIR)	
	@ln -sfn $(TEMPLATE_PATH) $(TEMPLATE_LINK)	
	@if [ -f "$(TEMPLATE_PATH)/Makefile" ]; then \
		$(MAKE) -C "$(TEMPLATE_PATH)"; \
	fi

package: 
	@rm -rf $(PACKAGE_DIR)
	@mkdir -p $(PACKAGE_DIR)
	@mkdir -p $(PACKAGE_DIR)/template	
	@mkdir -p $(PACKAGE_DIR)/figs
	@mkdir -p $(PACKAGE_DIR)/imgs
	@mkdir -p $(PACKAGE_DIR)/tabs
	@cp -r $(TEMPLATE_PATH)/* $(PACKAGE_DIR)/template
	@rm $(PACKAGE_DIR)/template/TabPreview.tex $(PACKAGE_DIR)/template/FigPreview.tex $(PACKAGE_DIR)/template/BibPreview.tex $(PACKAGE_DIR)/template/*.svg
	@cp -r common/ $(PACKAGE_DIR)/.
	@cp -r secs/ $(PACKAGE_DIR)/.
	@find figs -type f \( -name "*.svg" -o -name "*.png" \) -exec cp --parents {} $(PACKAGE_DIR) \;
	@find imgs -type f \( -name "*.png" \) -exec cp --parents {} $(PACKAGE_DIR) \;
	@find tabs -type f \( -name "*.tex" \) -exec cp --parents {} $(PACKAGE_DIR) \;
	@cp tools/Makefile.package  $(PACKAGE_DIR)/Makefile
	@cp main.tex LICENSE $(PACKAGE_DIR)
	@zip -r $(OUTPUT_DIR)/package.zip $(PACKAGE_DIR)

	
help:
	@echo "Run \"make\" with one of the options:"
	@echo "Option           Description"
	@echo "----------------------------------------------------------------------------------"
	@echo "all              Creates $(OUTPUT_FILE_PDF)."
	@echo "clean            Removes all build-artifacts including the $(OUTPUT_DIR) directory."
	@echo "view             Shows the $(OUTPUT_FILE_PDF) with $(PDF_VIEWER)."
	@echo "bibpreview       Creates $(BIB_PREVIEW_NAME_PDF) to preview all entries of the    "
	@echo "                 bibliography."
	@echo "----------------------------------------------------------------------------------"
	@echo ""

.PHONY: all clean rebuild bibpreview view help package
