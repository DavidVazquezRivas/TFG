if (Get-Command latexmk -ErrorAction SilentlyContinue) {
    latexmk -C
}

Get-ChildItem -Path . -Recurse -Include *.aux,*.fls,*.log,*.out,*.toc,*.bbl,*.bcf,*.blg,*.synctex.gz,*.lof,*.lot,*.fdb_latexmk -File -ErrorAction SilentlyContinue |
Remove-Item -Force -ErrorAction SilentlyContinue

