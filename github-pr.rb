# This is intended to be used from Circle CI, if you want to have the
# coverage posted on Github but can't use an external service.
#
# You'll need to add a GITHUB_ACCESS_TOKEN to your CI secret vars
#
# The coverage needs to be reported in clover format for this to work
#
# Configuration

REPOSITORY = "aurbano/robinhood-node"
COVERAGE_PATH = "coverage/coverage.xml"

# ------------------------------------

require 'octokit'
require 'uri'
require 'nokogiri'
require 'net/http'
require 'json'

def check_env(key)
  unless ENV.has_key?(key)
    puts "Missing #{key} env variable"
    exit
  end
  value = ENV[key]
  unless value.length > 0
    puts "#{key} is not set"
    exit
  end
end

check_env('GITHUB_ACCESS_TOKEN')
check_env('CI_PULL_REQUEST')

client = Octokit::Client.new :access_token => ENV['GITHUB_ACCESS_TOKEN']

PULL_REQUEST_URL = ENV['CI_PULL_REQUEST']
PULL_REQUEST_ID = URI(PULL_REQUEST_URL).path.split('/').last

report = File.open(COVERAGE_PATH, "rb")
@coverage = Nokogiri::XML(report.read)

def get_coverage(type)
  100 * Float(@coverage.at_xpath('//coverage/project/metrics').attribute("covered#{type}").value) / Float(@coverage.at_xpath('//coverage/project/metrics').attribute(type).value)
end

lines = get_coverage('statements')
statements = get_coverage('elements')
branches = get_coverage('conditionals')
functions = get_coverage('methods')

puts "Coverage: S #{statements.round}%, B #{branches.round}%, L #{lines.round}%, F #{functions.round}%"

comment = "**Code Coverage:**\n"\
          " * Statements: `#{statements.round}%`\n"\
          " * Branches: `#{branches.round}%`\n"\
          " * Lines: `#{lines.round}%`\n"\
          " * Functions: `#{functions.round}%`"

## The following commented out code was intended to link to the coverage artifact from the comment
## but the attribute URL is generated AFTER this script runs, so there is no way at the moment
## to get a link to the final attributes.

# Now get URL of coverage report:
# check_env('CIRCLE_CI_TOKEN');
# circle_token = ENV['CIRCLE_CI_TOKEN']
# build = ENV['CIRCLE_BUILD_NUM']
# puts 'Requesting attribute list...'
# response = Net::HTTP.get_response(URI("https://circleci.com/api/v1.1/project/github/#{REPOSITORY}/#{build}/attributes?circle-token=#{circle_token}"))
# puts response.body
# attributes = JSON.parse(response.body)
# attribute_url = ''
#
# for attribute in attributes
#   if attribute['pretty_path'] == '$CIRCLE_ARTIFACTS/coverage/lcov-report/index.html'
#     attribute_url = attribute['url']
#   end
# end
# puts "Attribute URL: #{attribute_url}"
# comment = "#{comment}\n\n*[Coverage details](#{attribute_url})*"

puts 'Posting comment...'

client.add_comment(REPOSITORY, PULL_REQUEST_ID, comment)

puts 'Done!'
