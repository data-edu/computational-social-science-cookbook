-- Use the first-edition production artwork for these two generated figures.
local figures = {
  ["chapter-5_files/figure-html/visualize-network-dlt1-2.png"] = "Figure_5_03",
  ["chapter-5_files/figure-pdf/visualize-network-dlt1-2.pdf"] = "Figure_5_03",
  ["chapter-5_files/figure-html/visualize-dlt2-roles-1.png"] = "Figure_5_06",
  ["chapter-5_files/figure-pdf/visualize-dlt2-roles-1.pdf"] = "Figure_5_06"
}

function Image(image)
  local figure = figures[image.src]
  if not figure then
    return nil
  end

  local extension
  if FORMAT == "latex" then
    extension = ".pdf"
  elseif FORMAT:match("^html") then
    extension = ".png"
  else
    return nil
  end

  image.src = "Artwork/figures/" .. figure .. extension
  if quarto and quarto.doc and quarto.doc.add_resource then
    quarto.doc.add_resource(image.src)
  end
  return image
end

function Div(div)
  if FORMAT ~= "latex" or not div.classes:includes("cell-output-display") then
    return nil
  end

  local is_figure_5_06 = false
  div:walk({
    Image = function(image)
      if image.src == "Artwork/figures/Figure_5_06.pdf" then
        is_figure_5_06 = true
      end
    end
  })
  if is_figure_5_06 then
    -- Tighten the gap before the next code block after the taller legend.
    return {div, pandoc.RawBlock("latex", "\\vspace{-\\baselineskip}")}
  end
end

function CodeBlock(block)
  if FORMAT ~= "latex" then
    return nil
  end
  if block.text:find("# 7. Density, reciprocity, clustering, distances", 1, true) == 1
      and block.text:find('ggraph(dlt2_network, layout = "fr")', 1, true) then
    -- Keep this block together without moving it into the figure caption.
    return {
      pandoc.RawBlock("latex", "\\begingroup\\fvset{baselinestretch=0.92}"),
      block,
      pandoc.RawBlock("latex", "\\endgroup")
    }
  end
end
