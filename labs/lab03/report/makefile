%.pdf: %.md
	pandoc "$<" --pdf-engine=xelatex --filter pandoc-crossref -o "$@"# Исходный файл Markdown
SOURCE = report.md

# Итоговые файлы
PDF = report.pdf
DOCX = report.docx

# Фильтр для pandoc (например, pandoc-crossref)
FILTER = --filter pandoc-crossref

# Правило для генерации DOCX
%.docx: %.md
	pandoc "$<" $(FILTER) -o "$@"

# Правило для генерации PDF
%.pdf: %.md
	pandoc "$<" --pdf-engine=xelatex --filter pandoc-crossref -V mainfont="DejaVu Serif" -V sansfont="DejaVu Sans" -V monofont="DejaVu Sans Mono" -o "$@"

# Цель по умолчанию
all: $(PDF) $(DOCX)
	@echo "Сгенерированы файлы: $(PDF) и $(DOCX)"

# Очистка
clean:
	rm -f $(PDF) $(DOCX) *~
