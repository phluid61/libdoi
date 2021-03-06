# frozen_string_literal: true

require 'cgi'
require 'uri'

class DOI

  VERSION = '1.0.0'.freeze

  def initialize dir, reg, dss #:nodoc:
    @dir = dir
    @reg = reg
    @dss = dss
  end
  attr_reader :dir, :reg, :dss

  ##
  # Concatenation--Returns a new DOI containing +other+ concatenated to this DOI's suffix string.
  #
  def + other
    self.class.new @dir, @reg, @dss + other.to_s
  end

  ##
  # Append--Concatenates the given object to this DOI's suffix string.
  #
  def << other
    @dss << other.to_s
    self
  end

  ##
  # Returns a String that represents this DOI.
  #
  # * prefix:  Prepends 'doi:' to the returned string.
  #
  def to_s prefix: true
    (prefix ? 'doi:' : '') + "#{@dir}.#{@reg}/#{@dss}"
  end

  ##
  # Returns a URI.
  #
  # For example: "https://doi.org/10.1000/foo%23bar"
  #
  # * info:  Returns an 'info:' URI instead of 'https:'
  #
  def to_uri info: false
    if info
      URI(_info_uri)
    else
      URI(_http_url)
    end
  end

  class <<self
    ##
    # Parses the given string as a DOI.
    #
    # Raises an ArgumentError if parsing fails.
    #
    def parse str
      str = "#{str}"
      if str =~ %r[^https?://(?:(?:dx\.)?doi\.org|doi\.acm\.org|doi\.ieeecomputersociety\.org)/+(?:doi:)?(.*)]i
        # It looks like a HTTP proxy URL.
        doi = CGI.unescape $1
      elsif str =~ %r[^info:doi/(.*)]i
        # It looks like an info URI.
        doi = CGI.unescape $1
      else
        # It's probably a DOI string.
        doi = str.sub %r[^doi:\s*]i, ''
      end

      # ANSI/NISO Z39.84-2005
      # <http://www.niso.org/apps/group_public/download.php/6587/Syntax%20for%20the%20Digital%20Object%20Identifier.pdf>
      if doi =~ %r[^(10)\.([^/]+)/(\p{Graph}(?:[^/]\p{Graph}*)?)$]
        # FIXME: $2 and $3 may contain characters outside of /\p{Graph}/
        new $1, $2, $3
      else
        raise ArgumentError, "'#{str}' is not a valid DOI string"
      end
    end
  end

private

  InfoURI = 'info:doi/'.freeze
  HTTPURI = 'https://doi.org/'.freeze

  # Returns a percent-encoded "dir.reg/dss" string.
  def _uri_path
    "#{@dir}.#{CGI.escape @reg}/#{CGI.escape @dss}"
  end

  # Returns an "info:doi/..." URI string.
  def _info_uri
    InfoURI + _uri_path
  end

  # Returns a "https://doi.org/..." URI string.
  def _http_url
    HTTPURI + _uri_path
  end

end


