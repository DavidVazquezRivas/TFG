# TFG LaTeX — Plantilla adaptada a TFGEPSUIB

Este repositorio contiene una memoria TFG adaptada a la clase oficial `TFGEPSUIB` (fichero de clase ubicado en `config/TFGEPSUIB.cls`). El proyecto sigue la plantilla de la universidad y usa BibTeX/`IEEEtran` con una bibliografía centralizada en `Bibliografia.bib` en la raíz del proyecto.

## Estructura principal (actualizada)

- `main.tex` — entrada principal (usa `config/TFGEPSUIB.cls`).
- `config/preamble.tex` — paquetes y configuración (la plantilla evita `geometry`, `titlesec` y `fancyhdr`).
- `config/data.tex` — metadatos (autor, título, tutores, estudios, etc.).
- `Bibliografia.bib` — bibliografía consolidada en la raíz (uso con `IEEEtran`).
- `contents/CapituloN/` — capítulos principales (se eliminó la estructura por `Parte`).
- `contents/Acronimos/Acronims.tex` — fichero de acrónimos (se imprime solo los usados).
- `images/` — recursos gráficos.

Hemos movido los capítulos fuera de `contents/Parte1/` a `contents/CapituloN/` para simplificar la jerarquía de la memoria. La bibliografía se mantiene centralizada en `Bibliografia.bib`.

## Compilación

Recomendado (latexmk):

```powershell
latexmk -pdf -interaction=nonstopmode -halt-on-error main.tex
```

Flujo clásico (si prefieres pasos manuales):

```powershell
pdflatex -interaction=nonstopmode main.tex
bibtex main
pdflatex -interaction=nonstopmode main.tex
pdflatex -interaction=nonstopmode main.tex
```

Notas:
- La plantilla usa BibTeX con `IEEEtran.bst`. Si necesitas BibLaTeX/Biber explícitamente, dímelo y lo revertimos.
- `latexmk` detectará automáticamente las dependencias si lo usas.

## Acrónimos

Se añadió soporte de acrónimos en `config/preamble.tex` y el fichero de ejemplo en `contents/Acronimos/Acronims.tex`. Los acrónimos se imprimen solo si están usados (`printonlyused`).

## Limpieza / Backups

- El script de limpieza sigue disponible en `scripts/clean.ps1`.
- `front.tex` (plantilla anterior de portada) se ha movido a `backups/front.tex.removed` antes de eliminarla.

## Problemas conocidos y advertencias

- Durante la migración aparecen advertencias PDF relacionadas con identificadores duplicados en hipervínculos (warnings de `destination with the same identifier`). Son inofensivas; se redujeron añadiendo secciones claras antes de las inclusiones. Si ves bookmarks/anchors duplicados en el visor PDF, puedo aplicar una limpieza más agresiva.
- Una entrada (`tool2022pkg`) no se ajustaba exactamente al estilo IEEE; BibTeX mostró una advertencia en la ejecución. Puedo normalizar esa entrada si quieres.

## Tareas siguientes que puedo hacer por ti

- Actualizar `docs/README.md` (hecho).
- Revisar visual del PDF y ajustar estilos finos (encabezados, saltos de página, portadas).
- Repartir entradas `.bib` por capítulos o mantener la base consolidada en `Bibliografia.bib` en la raíz (este proyecto usa la opción centralizada por defecto).

Pide la acción que prefieras y la aplico.
