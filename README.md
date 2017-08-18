# DOI Library

[![Build Status](https://secure.travis-ci.org/phluid61/libdoi.png)](http://travis-ci.org/phluid61/libdoi)
[![Gem Version](https://badge.fury.io/rb/libdoi.png)](http://badge.fury.io/rb/libdoi)

The library that lets you do stuff with DOIs.

And stuff.

----

## DOI

### Constants

* `VERSION` = `"1.0.0"`

### Class Methods

#### `DOI::parse(str)`

Parses the given string as a DOI.

Raises an ArgumentError if parsing fails.

#### `DOI::find(doi)`

Looks for a DOI at doi.org.

Returns a URI if it finds a match, otherwise returns nil.

~~~ruby
require 'doi/network'

url = DOI.find('10.17487/RFC8089')
~~~

#### `DOI::data(doi)`

Gets data about a DOI from CrossRef.

~~~ruby
require 'doi/network'

data = DOI.data('10.17487/RFC8089')
~~~

### Instance Methods

#### `doi + other`

Concatenation--Returns a new DOI containing _other_ concatenated to this DOI's suffix string.

#### `doi << other`

Append--Concatenates the given object to this DOI's suffix string.

#### `doi.to_s(prefix: true)`

Returns a String that represents this DOI.

* _prefix_:  Prepends `'doi:'` to the returned string.

#### `doi.to_uri(info: false)`

Returns a URI.

For example: `"https://doi.org/10.1000/foo%23bar"`

* _info_:  Returns an 'info:' URI instead of 'https:'

#### `doi.find`

Looks for a DOI at doi.org.

Returns a URI if it finds a match, otherwise returns nil.

~~~ruby
require 'doi/network'

url = DOI.parse('10.17487/RFC8089').find
~~~

#### `doi.data`

Gets data about this DOI from CrossRef.

~~~ruby
require 'doi/network'

data = DOI.parse('10.17487/RFC8089').data
~~~

----

