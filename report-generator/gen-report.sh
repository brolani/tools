#!/bin/bash
# Thie is a script to generate the regression report for a given date.

export report_print_date=$(date +%d-%m-%Y)
echo "Generating report for $report_print_date..."

# Resolve report dates from the input report file into a temporary output 'report.md' file.
echo "Resolving variables in report..."
envsubst '$report_print_date' < "report.md.in" > "report.md"

# Get the date used to set the name for the generated PDF report.
report_date=$(date +%Y%m%d)

# Generate PDF report from the temporary output 'report.md' file which contains the resolved variables.
echo "Writing report to PDF..."
pandoc --variable mainfont="Helvetica" --variable sansfont="Helvetica" --variable monofont="Menlo" --variable fontsize=11pt --variable version=2.0 report.md --pdf-engine=xelatex -o report-$report_date.pdf

# Remove temporary output file: 'report.md'.
echo "Cleaning up temp files..."
rm "report.md"

echo "Done."
