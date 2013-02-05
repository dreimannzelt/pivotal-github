require 'optparse'
require 'ostruct'
require 'pivotal-github/options'

class Record

  attr_accessor :args, :cmd

  def initialize(args)
    self.args = args
  end

  def parse
    options = OpenStruct.new
    parser = OptionParser.new do |opts|
      opts.banner = "Usage: git record [options]"
      opts.on("-m", "--message MESSAGE",
              "add a commit message (with ticket #)") do |m| 
        options.message = m
      end
      opts.on("-a", "--all", "commit all changed files") do |a|
        options.all = a
      end
      opts.on("-f", "--finish", "mark story as finished") do |f|
        options.finish = f
      end
      opts.on_tail("-h", "--help", "this usage guide") do
        puts opts.to_s; exit 0
      end
    end
    parser.parse!(Options::known_options(parser, args))
    options
  end
end