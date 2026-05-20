# TFG LaTeX — Plantilla mínima

Proyecto LaTeX minimalista para la memoria del TFG. Plantilla limpia y organizada por partes y capítulos.

## Estructura

- `main.tex` — entrada principal.
- `config/preamble.tex` — paquetes y estilos (incluye `biblatex`).
- `config/data.tex` — metadatos (autor, título, etc.).
- `contents/{Parte}/{Capitulo}/` — contenido por parte y capítulo.
- `images/` — recursos gráficos.

## Uso rápido

Compilar desde la raíz del proyecto:

```powershell
latexmk -pdf -interaction=nonstopmode -halt-on-error main.tex
```

`latexmk` invocará `biber` automáticamente si `biblatex` está en uso.

## Limpieza de auxiliares

El proyecto incluye un script de limpieza disponible en `scripts/clean.ps1`.

Ejecuta:

```powershell
.\scripts\clean.ps1
```

El script usa `latexmk -C` si está instalado, y en caso contrario elimina recursivamente las extensiones auxiliares más comunes.

## Convenciones recomendadas

- Mantén cada capítulo en `contents/{Parte}/{Capitulo}/archivo.tex`.
- Guarda la bibliografía por capítulo con `biblatex` (`\addbibresource{...}`) y usa `refsection` si quieres bibliografías separadas por capítulo.

## Bibliografía (IEEE)

El proyecto utiliza `biblatex` con estilo IEEE en el preámbulo. Añade entradas `.bib` en los directorios de capítulo o registra recursos en `config/preamble.tex`.

Para compilar y actualizar bibliografías simplemente ejecuta:

```powershell
latexmk -pdf
```

## Guía rápida: BibTeX / BibLaTeX (IEEE)

Breve resumen y buenas prácticas para usar `.bib` en este proyecto:

- ¿Qué es un `.bib`?: base de datos BibTeX con entradas `@article`, `@book`, `@inproceedings`, etc.
- Entradas: incluya `author`, `title`, `year` y `doi` cuando esté disponible; use `{}` en `title` para preservar mayúsculas importantes.
- Convención de claves: `apellidoAñoPalabra` (por ejemplo `knuth1984texbook`).
- Organización por archivos: puedes tener un `.bib` por capítulo, p.ej. `contents/Parte1/Capitulo1/Ejemplo.bib`.
- Bibliografías por capítulo: con `biblatex` registre las fuentes con `\addbibresource{...}` en el preámbulo y en cada capítulo use `\begin{refsection} ... \printbibliography[heading=subbibliography]` para imprimir la bibliografía local.
- Compilación (si no usas `latexmk`):

```bash
pdflatex main.tex
biber main
pdflatex main.tex
pdflatex main.tex
```

O simplemente `latexmk -pdf` (recomendado).

## Ayuda y tareas comunes

Si necesitas que haga algo por ti, dime exactamente cuál de las siguientes opciones prefieres y lo implemento:

- **Distribuir entradas**: mover entradas de una antigua `references.bib` a los `.bib` por capítulo.
- **Crear plantillas `.bib`**: generar plantillas vacías por capítulo en `contents/...`.
- **Ejemplo listo para compilar**: actualizar `main.tex` con `biblatex`+`refsection=chapter` y ejemplo completo.
- **Limpiar historial**: eliminar los archivos en `.history` relacionados con `.bib` o temporales.

Indica la opción (por ejemplo: “Distribuir entradas”) y procedo.
