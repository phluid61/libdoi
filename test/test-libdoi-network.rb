require 'test/unit'
require 'uri'
$VERBOSE = true

require_relative '../lib/libdoi/network'
class Test_libdoi_network < Test::Unit::TestCase
  STRING = '10.17487/RFC8089'.freeze

  URL = URI('https://www.rfc-editor.org/info/rfc8089')

  FAMILY = 'Kerwin'.freeze
  TITLE  = 'The "file" URI Scheme'.freeze

  def test_find
    doi = DOI.parse STRING
    url = doi.find
    assert_equal( url, URL )
  end
  def test_find2
    url = DOI.find STRING
    assert_equal( url, URL )
  end
  def test_data
    doi = DOI.parse STRING
    data = doi.data
    assert_equal( data['author'][0]['family'], FAMILY )
    assert_equal( data['title'], TITLE )
  end
  def test_data2
    data = DOI.data STRING
    assert_equal( data['author'][0]['family'], FAMILY )
    assert_equal( data['title'], TITLE )
  end
end


