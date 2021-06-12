require 'coolline'
require 'coderay'
require 'pp'

cool = Coolline.new do |c|

  # Before the line is displayed, it gets passed through this proc,
  # which performs syntax highlighting.
  c.transform_proc = proc do
    CodeRay.scan(c.line, :ruby).term
  end

  # Add tab completion for constants (and classes)
  c.completion_proc = proc do
    word = c.completed_word
    Object.constants.map(&:to_s).select { |w| w.start_with? word }
  end

  # Alt-R should reverse the line, because we like to look at our code in the mirror
  c.bind "\er" do |cool|
    cool.line.reverse!
  end

end

loop do
  # READ
  line = cool.readline

  # EVAL
  obj = eval(line)

  # PRINT
  print "=> "
  pp obj

  # LOOP
end

