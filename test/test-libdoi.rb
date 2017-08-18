require 'test/unit'
require 'uri'
$VERBOSE = true

require_relative '../lib/libdoi'
class Test_libdoi < Test::Unit::TestCase
  DIR = '10'.freeze
  REQ = '17487'.freeze
  DSS = 'RFC8089'.freeze

  STRING1 = 'doi:10.17487/RFC8089'.freeze
  STRING2 =     '10.17487/RFC8089'.freeze

  HTTP_URL = URI('https://doi.org/10.17487/RFC8089')
  INFO_URL = URI('info:doi/10.17487/RFC8089')

  def test_construct
    doi = DOI.new DIR.dup, REQ.dup, DSS.dup
    assert_kind_of( DOI, doi )
    assert_equal( DIR, doi.dir )
    assert_equal( REQ, doi.reg )
    assert_equal( DSS, doi.dss )
  end
  def test_concat
    doi1 = DOI.new DIR.dup, REQ.dup, 'RFC'
    doi2 = doi1 + '8089'
    assert_equal( [DIR,REQ,'RFC'],     [doi1.dir, doi1.reg, doi1.dss] )
    assert_equal( [DIR,REQ,'RFC8089'], [doi2.dir, doi2.reg, doi2.dss] )
  end
  def test_append
    doi1 = DOI.new DIR.dup, REQ.dup, 'RFC'
    doi2 = doi1 << '8089'
    assert_equal( [DIR.dup,REQ.dup,'RFC8089'], [doi1.dir, doi1.reg, doi1.dss] )
    assert_same( doi1, doi2 )
  end
  def test_to_s
    doi = DOI.new DIR.dup, REQ.dup, DSS.dup
    assert_equal( STRING1, doi.to_s )
    assert_equal( STRING1, doi.to_s(prefix: true) )
    assert_equal( STRING2, doi.to_s(prefix: false) )
  end
  def test_to_uri
    doi = DOI.new DIR.dup, REQ.dup, DSS.dup
    uri1 = doi.to_uri
    assert_kind_of( URI, uri1 )
    assert_equal( HTTP_URL, uri1 )

    uri2 = doi.to_uri(info: false)
    assert_kind_of( URI, uri2 )
    assert_equal( HTTP_URL, uri2 )

    uri3 = doi.to_uri(info: true)
    assert_kind_of(URI, uri3)
    assert_equal( INFO_URL, uri3 )
  end
  def test_parse
    [
      'http://dx.doi.org/10.17487/RFC8089',
      'https://doi.org/10.17487/RFC8089',
      'http://doi.acm.org/10.17487/RFC8089',
      'http://doi.ieeecomputersociety.org/10.17487/RFC8089',
      'info:doi/10.17487/RFC8089',
      'doi:10.17487/RFC8089',
      'DOI: 10.17487/RFC8089',
      '10.17487/RFC8089',
    ].each do |good|
      doi = DOI.parse(good)
      assert_kind_of( DOI, doi )
      assert_equal( STRING1, doi.to_s )
    end

    [
      '10.0001/x/abc', # DSS matching "^./" is forbidden by the spec
      'https://doi.org/not-a-doi',
      'garbage',
    ].each do |bad|
      assert_raise(ArgumentError) { DOI.parse bad }
    end
  end
end

