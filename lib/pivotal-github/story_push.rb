require 'optparse'
require 'ostruct'
require 'pivotal-github/options'
require 'pivotal-github/command'

class StoryPush < Command

  def parse
    options = OpenStruct.new
    parser = OptionParser.new do |opts|
      opts.banner = "Usage: git story-push [options]"
      opts.on("-t", "--target TARGET",
              "push to a given target (defaults to origin)") do |t|
        options.target = t
      end
      opts.on_tail("-h", "--help", "this usage guide") do
        puts opts.to_s; exit 0
      end
    end
    self.known_options   = Options::known_options(parser, args)
    self.unknown_options = Options::unknown_options(parser, args)
    parser.parse(known_options)
    options
  end

  # Returns a command appropriate for executing at the command line
  def cmd
    c = ['git push']
    c << argument_string(unknown_options) unless unknown_options.empty?
    c << target
    c << current_branch
    c.join(' ')
  end

  def run!
    system cmd
  end

  private

    def pull_request_branch
      options.pull_request_branch
    end

    def target
      options.target || 'origin'
    end
end