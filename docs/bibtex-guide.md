# Guía de uso de BibTeX para estilo IEEE (resumen y buenas prácticas)

Esta guía explica cómo organizar y emplear archivos `.bib` para citar siguiendo el estándar IEEE, con ejemplos prácticos y recomendaciones para estructurar la bibliografía en un proyecto LaTeX.

---

## 1. ¿Qué es un fichero `.bib`?

Un archivo `.bib` es una base de datos de referencias en formato BibTeX. Cada entrada tiene un identificador (clave) y un tipo (`@article`, `@book`, `@inproceedings`, etc.) con campos (autor, título, año...). La herramienta que formatea la bibliografía (por ejemplo `IEEEtran.bst` o `biblatex`+`biber`) convierte estas entradas en la sección de referencias del documento.

## 2. Estructura básica de una entrada

Ejemplo `@article`:

```bibtex
@article{smith2019fastalg,
  author = {Smith, John and Roe, Jane},
  title  = {A fast algorithm for examples},
  journal = {IEEE Trans. Something},
  year   = {2019},
  volume = {10},
  number = {2},
  pages  = {123-130},
  doi    = {10.1000/example.doi}
}
```

Campos comunes:
- `author` (use `Last, First` o `First Last`; BibTeX maneja ambos). Para múltiples autores use ` and ` como separador.
- `title` (entre llaves `{}` si contiene mayúsculas que deben conservarse).
- `year`, `journal`/`booktitle`, `volume`, `number`, `pages`, `doi`, `publisher`, `address`.
- `url` y `note` para recursos online; en IEEE el DOI suele preferirse al URL.

## 3. Tipos de entrada relevantes (resumen)
- `@article` — artículos en revistas o transacciones.
- `@inproceedings` / `@conference` — artículos en actas de congresos.
- `@book` — libros.
- `@incollection` — capítulo en libro.
- `@techreport` — informes técnicos.
- `@phdthesis` / `@mastersthesis` — tesis.
- `@misc` — recursos varios (software, páginas web, datasets) si no encajan en otro tipo.

## 4. Reglas IEEE importantes (aplicables al `.bib`)
- Los nombres se formatean en el resultado como iniciales + apellidos (esto lo hace el `.bst`). En el `.bib` proporcione nombres completos o `Last, First`.
- Incluya DOI cuando esté disponible (`doi = {...}`); el estilo IEEE lo imprimirá adecuadamente.
- Si cita recursos online y hay DOI y URL, coloque primero el DOI (como campo `doi`), luego puede añadir `url` o `note = {Accessed: ...}` si hace falta.
- Consulte la guía IEEE para la forma de abreviación en nombres de conferencias o revistas; los `bst` estándar suelen usar las abreviaturas comunes.

## 5. Convención de claves (recomendación)
Use claves legibles y reproducibles, por ejemplo:
`ApellidoAñoPalabraClave` → `knuth1984texbook`, `smith2019fastalg`.
Evite caracteres raros y espacios; use minúsculas y sin signos (a-z0-9).

## 6. Organización por archivos (`.bib`) — por qué y cómo
Motivos para dividir en varios `.bib`:
- Mantener un archivo por capítulo facilita la colaboración y la reutilización.
- Separar referencias primarias de secundarias, o bibliografía de anexos.

Formas de usar varias bases:
- Con BibTeX tradicional y `IEEEtran.bst`: en `main.tex` ponga

```tex
\bibliographystyle{IEEEtran}
\bibliography{references,refs/cap1,refs/cap2}
```

(La lista separada por comas sin extensiones — `references.bib` y `refs/cap1.bib`).

- Con `biblatex` + `biber` (más flexible), registre recursos con `\addbibresource{refs/cap1.bib}` y use secciones/filtrado para bibliografías por capítulo.

## 7. Bibliografía por capítulo (opciones)
- Opción simple: mantener archivos `refs/cap1.bib`, `refs/cap2.bib` y cargar todos en la bibliografía global (sencillo, pero genera una sola lista al final).
- Opción con bibliografías separadas por capítulo:
  - `biblatex` con `refsection=chapter` (recomendado): permite `\printbibliography[heading=subbibliography]` por capítulo y compila con `biber`.
  - Alternativa clásica: paquete `bibunits` (más complejo) que genera archivos auxiliares y requiere ejecutar `bibtex` por unidad.

Ejemplo básico con `biblatex`:

```tex
\usepackage[backend=biber,style=ieee,sorting=none]{biblatex}
\addbibresource{references.bib}
\addbibresource{refs/cap1.bib}

% En cada capítulo:
\begin{refsection}
... texto con \cite{clave} ...
\printbibliography[heading=subbibliography]
\end{refsection}
```

Compilar con `biber` en lugar de `bibtex`.

### Recomendación de estructura por parte/capítulo

Si prefieres mantener cada capítulo junto con sus referencias, organiza así:

```
contents/
  Parte1/
    Capitulo1/
      Ejemplo.tex
      Ejemplo.bib
    Capitulo2/
      Cap2.tex
      Cap2.bib
```

Con BibTeX tradicional puedes listar los `.bib` en `\bibliography{...}` (sin `.bib`), p. ej.: `\bibliography{references,contents/Parte1/Capitulo1/Ejemplo}`.

Con `biblatex` puedes usar `\addbibresource{contents/Parte1/Capitulo1/Ejemplo.bib}` y, si usas `refsection=chapter`, imprimir la bibliografía local por capítulo.

## 8. Cómo citar en el texto (IEEE)
- Use `\cite{clave}` para obtener citas numéricas entre corchetes: `[1]`.
- Para citar varios elementos: `\cite{a,b,c}` → normalmente `[1], [2], [3]` o, si se usan paquetes que comprimen rangos, `[1]–[3]`.
- La guía IEEE indica listar cada referencia separada en ciertos contextos; si necesita el formato exacto del manual (no usar rangos), evite paquetes que compriman (vea sección 10).

## 9. Compilación (BibTeX tradicional)
Secuencia manual si no usa `latexmk`:

```bash
pdflatex main.tex
bibtex main
pdflatex main.tex
pdflatex main.tex
```

Con `latexmk -pdf` la herramienta normalmente ejecuta `bibtex` automáticamente cuando detecta referencias.

## 10. Patronos y paquetes útiles
- `IEEEtran` class y `IEEEtran.bst` — estilo clásico IEEE.
- `biblatex` con `style=ieee` y backend `biber` — gran control y bibliografías por sección.
- `JabRef`, `Zotero`, `Mendeley` — gestores de bibliografía que exportan `.bib` y ayudan a limpiar metadatos.
- `doi2bib` o la API de CrossRef — para obtener entradas BibTeX desde un DOI.

Nota sobre rangos en citas: muchos paquetes (p. ej. `cite`) comprimen números consecutivos en un rango; la guía que tienes adjunta sugiere listar cada número por separado en el texto. Si necesitas acatar ese detalle exactamente, lo más sencillo es usar `biblatex` y desactivar la compresión: `\usepackage[style=ieee,sorting=none,compress=false]{biblatex}`.

## 11. Buenas prácticas rápidas
- Consistente: mantén la misma convención de claves y subcarpetas `refs/`.
- Completo: incluye DOI siempre que sea posible.
- Verificable: revisa que nombres y títulos estén bien capitalizados (usa `{}` cuando sea necesario en `title`).
- Control: si quieres bibliografías por capítulo, usa `biblatex` — la gestión con `bibunits` y `bibtex` es más propensa a errores.

## 12. Ejemplos prácticos
- `refs/references.bib` (global): entradas generales.
- `refs/cap1.bib`: solo referencias citadas en el capítulo 1.

En `main.tex` puede incluirse la referencia global y luego usar `biblatex` para impresiones locales (ver ejemplos en la guía completa en línea).