# frozen_string_literal: true

require_relative '../libdoi'

require 'net/http'
require 'json'

class DOI

  ##
  # Looks for a DOI at doi.org.
  #
  # Returns a URI if it finds a match, otherwise returns nil.
  #
  def find
    _http_get(self.to_uri) do |response|
      # FIXME: this is both presumptuous and intolerant
      loc = response['Location']
      return URI(loc) if loc
    end
    nil
  end

  ##
  # Gets data about this DOI from CrossRef.
  #
  def data
    uri = URI(_data_url)
    _http_get(uri, 'Accept'=>JSON_Type) do |response|
      return JSON.parse(response.body) if response.code.to_i == 200
    end
    nil
  end

  class <<self
    ##
    # Looks for a DOI at doi.org.
    #
    # Returns a URI if it finds a match, otherwise returns nil.
    #
    def find doi
      doi = parse(doi) unless doi.is_a? DOI
      doi.find
    end

    ##
    # Gets data about a DOI from CrossRef.
    #
    def data doi
      doi = parse(doi) unless doi.is_a? DOI
      doi.data
    end
  end

private

  JSON_Type   = 'application/vnd.citationstyles.csl+json'.freeze
  UAString    = "ruby/#{::RUBY_VERSION} libdoi/#{DOI::VERSION}".freeze
  CrossRefURL = 'https://data.crossref.org/'.freeze

  def _http_get uri, opts={}, &block
    Net::HTTP.start(uri.host, uri.port,
                    :use_ssl=>uri.is_a?(URI::HTTPS),
                   ) do |http|
      query = Net::HTTP::Get.new uri, 'Accept-Encoding'=>''
      query['Connection'] = 'close'
      query['User-Agent'] = UAString
      opts.each_pair {|k,v| query[k] = v }
      http.request query, &block
    end
  end

  # Returns a data.crossref.org URI string.
  def _data_url
    CrossRefURL + _uri_path
  end

end


