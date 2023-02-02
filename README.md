# PDF Annotation Extractor
Automatically extract annotations from a PDF as markdown with various processing.

## Features
- inserts bibliographic metadata as YAML frontmatter
- inserts pandoc citations with the correct page numbers instead of "PDF page 3"
- merges highlights across pages
- used just by opening a PDF file via the "Open With" menu
- extract rectangles as images, puts those images into an `attachments` subfolder, and inserts markdown images (`![[citekey_image1.png]]`) into the markdown file.
- If output path is in an Obsidian vault, automatically opens the file in Obsidian and copies the wikilink for the file to the clipboard
- …

This app is the successor of the [PDF Annotation Extractor for Alfred](https://github.com/chrisgrieser/pdf-annotation-extractor-alfred) and works now completely without Alfred.

> __Note__  
> Please note that this app is still beta.

## Table of Contents
<!--toc:start-->
  - [Features](#features)
  - [Installation](#installation)
  - [Usage](#usage)
	- [Requirements for the PDF](#requirements-for-the-pdf)
	- [Basics](#basics)
	- [Automatic Page Number Identification](#automatic-page-number-identification)
	- [Annotation Codes](#annotation-codes)
	- [Extracting Images](#extracting-images)
  - [Troubleshooting](#troubleshooting)
  - [Credits](#credits)
    - [Thanks](#thanks)
    - [About the Developer](#about-the-developer)
    - [Buy me a Coffee](#buy-me-a-coffee)
<!--toc:end-->

## Installation
- Install [Homebrew](https://brew.sh/)
- Install `pdfannots2json` by pasting the following into your terminal:

  ```bash
  brew install mgmeyers/pdfannots2json/pdfannots2json
  ```

- Run the following code in your terminal: 

  ```bash
  /bin/bash -c (curl -sL "https://raw.githubusercontent.com/chrisgrieser/pdf-annotation-extractor/main/install.sh")
  ```

- Open a PDF with the app. On the first run, the app opens a text file containing the settings required.

## Usage

### Requirements for the PDF
- The PDF Annotation Extractor works on any PDF that has valid annotations saved *in the PDF file*. (Some PDF readers like __Skim__ or __Zotero 6__ do not store annotations int eh PDF itself by default.)
- The filename of the PDF must be *exactly* the citekey (without `@`), optionally followed by an underscore and some text like `{citekey}_{title}.pdf`. The citekey must not contain underscores (`_`).

> __Note__  
> You can achieve such a filename pattern with automatic renaming rules of most reference managers, for example with the [ZotFile plugin for Zotero](http://zotfile.com/#renaming-rules) or the [AutoFile feature of BibDesk](https://bibdesk.sourceforge.io/manual/BibDeskHelp_77.html#SEC140).

### Basics
Open a PDF file with the Annotation Extractor via the "Open With" menu. That's it.

__Annotation Types extracted__
- Highlight ➡️ bullet point, quoting text and prepending the comment
- Underline ➡️ output to [Drafts.app](https://getdrafts.com/); they are not included in the annotations. 
- Free Comment ➡️ blockquote of the comment text
- Strikethrough ➡️ Markdown strikethrough
- Rectangle ➡️ image

### Automatic Page Number Identification
Instead of the PDF page numbers, this workflow retrieves information about the *real* page numbers from the BibTeX library and inserts them. If there is no page data in the BibTeX entry (e.g., monographies), you are prompted to enter the page number manually.
- In that case, enter the __real page number__ of your __first PDF page__.
- In case there is content before the actual text (e.g., a foreword or Table of Contents), the real page number `1` often occurs later in the PDF. In that case, you must enter a __negative page number__, reflecting the true page number the first PDF would have. *Example: Your PDF is a book which has a foreword, and uses roman numbers for it; real page number 1 is PDF page number 12. If you continued the numbering backwards, the first PDF page would have page number `-10`, you enter the value `-10` when prompted for a page number.*

### Annotation Codes
Insert these special codes at the __beginning__ of an annotation to invoke special actions on that annotation. Annotation Codes do not apply to Strikethroughs. (You can run the Alfred command `acode` to display a cheat sheet showing all the following information.)

- `+`: Merge this highlight/underline with the previous highlight/underline. Works for annotations on the same page (= skipping text in between) and for annotations across two pages.
- `? foo` __(free comments)__: Turns "foo" into a [Question Callout](https://help.obsidian.md/How+to/Use+callouts)  (`> ![QUESTION]`) and move up. (Callouts are Obsidian-specific Syntax.)
- `##`: Turns highlighted/underlined text into a __heading__ that is added at that location. The number of `#` determines the heading level. If the annotation is a free comment, the text following the `#` is used as heading instead (Space after `#` required).
- `=`: Adds highlighted/underlined text as __tags__ to the YAML-frontmatter (mostly used for Obsidian as output). If the annotation is a free comment, uses the text after the `=`. In both cases, the annotation is removed afterwards.
- `_` __(highlights only)__: Removes the `_` and creates a copy of the annotation, but with the type `underline`. This annotation code avoids having to highlight *and* underline the same text segment to have it in both places.

### Extracting Images
- The respective images is saved in the `attachments` subfolder of the output folder, and named `{citekey}_image{n}.png`.
- The images is embedded in the markdown file with the `![[ ]]` syntax, e.g. `![[filename.png|foobar]]`
- Any `rectangle` type annotation in the PDF is extracted as image.
- If the rectangle annotation has any comment, it is used as the alt-text for the image. (Note that some PDF readers like PDF Expert do not allow you to add a comment to rectangular annotations.)

## Troubleshooting
- Update to the latest version of `pdfannots2json` by running the following Terminal command `brew upgrade pdfannots2json` in your terminal.
- This app does not work with annotations that are not actually saved in the PDF file. Some PDF Readers like __Skim__ or __Zotero 6__ do this, but you can [tell those PDF readers to save the notes in the actual PDF.](https://skim-app.sourceforge.io/manual/SkimHelp_45.html)
- This app sometimes does not work when the PDF has bigger free-form annotations (e.g., from using a stylus on a tablet). Delete all annotations of the type "free form" and the app should work.
- There are some cases where the extracted text is all jumbled up. In that case, it's a is a problem with the upstream `pdfannots2json`. [The issue is tracked here](https://github.com/mgmeyers/pdfannots2json/issues/11), and you can also report your problem.

> __Note__  
> As a fallback, you can use `pdfannots` as extraction engine, as a different PDF engine sometimes fixes issues. This requires installing [pdfannots](https://github.com/mgmeyers/pdfannots2json/issues/11) via `pip3 install pdfannots`. Note that `pdfannots` does not support image extraction or extracting only recent annotations, so normally you want to keep using `pdfannots2json`.

## Credits

<!-- vale Google.FirstPerson = NO -->
### Thanks
- Thanks to [Andrew Baumann for pdfannots](https://github.com/0xabu/pdfannots), which caused me to develop this workflow (even though it does not use `pdfannots` anymore).
- Also many thanks to [@mgmeyers for pdfannots2json](https://github.com/mgmeyers/pdfannots2json/), which enabled many improvements to this workflow.
- I also thank [@StPag](https://github.com/stefanopagliari/) for his ideas on annotation codes.

### About the Developer
In my day job, I am a sociologist studying the social mechanisms underlying the digital economy. For my PhD project, I investigate the governance of the app economy and how software ecosystems manage the tension between innovation and compatibility. If you are interested in this subject, feel free to get in touch!

<!-- markdown-link-check-disable -->
- [Academic Website](https://chris-grieser.de/)
- [Discord](https://discordapp.com/users/462774483044794368/)
- [GitHub](https://github.com/chrisgrieser/)
- [Twitter](https://twitter.com/pseudo_meta)
- [ResearchGate](https://www.researchgate.net/profile/Christopher-Grieser)
- [LinkedIn](https://www.linkedin.com/in/christopher-grieser-ba693b17a/)

### Buy me a Coffee
<a href='https://ko-fi.com/Y8Y86SQ91' target='_blank'><img height='36' style='border:0px;height:36px;' src='https://cdn.ko-fi.com/cdn/kofi1.png?v=3' border='0' alt='Buy Me a Coffee at ko-fi.com' /></a>
