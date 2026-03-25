
library(DiagrammeR)

grViz("
digraph fieldguide {

  graph [layout = neato, overlap = false]

  node [shape = circle, style = filled, fillcolor = '#e6f0ff',
        color = '#3366cc', fontname = Helvetica, fontsize = 12]

  Ideas      [pos = '0,2!']
  RQs        [pos = '2,2!'; label = 'Research\\nQuestions']
  Data       [pos = '4,2!']
  Writeups   [pos = '2,0!'; label = 'Write-ups\\nCommunication']

  # Analysis block (rectangle)
  node [shape = rectangle, width = 2, height = 1,
        fillcolor = '#d9ecff', fontsize = 12]

  Analysis   [pos = '2,1!'; label = 'Analysis']

  # Two method blocks
  node [shape = rectangle, fillcolor = '#fff2cc', fontsize = 11]

  Comp       [pos = '0.5,1!'; label = 'Computational\\nMethods']
  LLM        [pos = '3.5,1!'; label = 'LLMs / AI\\nMethods']

  # Arrows: cycle
  Ideas     -> RQs
  RQs       -> Data
  Data      -> Analysis
  Analysis  -> Writeups
  Writeups  -> Ideas

  # method links
  Comp -> Analysis
  LLM  -> Analysis
}
")

