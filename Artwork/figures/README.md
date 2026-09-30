# First-edition production figures

`Figure_5_03.pdf` and `Figure_5_06.pdf` restore the complete legends in the original vector figures. The network layouts and plotted values are preserved; the repairs concern the canvas and legend display. The matching PNG files are the web versions. No analysis code was changed.

The `filters/production-figures.lua` filter substitutes these assets for the two generated figure paths during rendering. It keeps the image attributes and captions, uses PDF for print and PNG for HTML, and leaves all other images unchanged.

For PDF output, the filter slightly tightens the space after Figure 5.6 and the line spacing in the immediately following code block. The code text and font size are unchanged.

These overrides belong to the first edition. If the analyses are rerun or revised, review and update these assets or remove the corresponding overrides so an earlier figure does not replace a new result.
