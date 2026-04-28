# DOI Library

[![Gem Version](https://badge.fury.io/rb/libdoi.png)](http://badge.fury.io/rb/libdoi)
[![Contributor Covenant](https://img.shields.io/badge/Contributor%20Covenant-v3.0%20adopted-ff69b4.svg)](code_of_conduct.md)

The library that lets you do stuff with DOIs.

And stuff.

----

## DOI

### Constants

* `VERSION` = `"1.0.0"`

### Class Methods

#### `DOI::parse(str) → doi`

Parses the given string as a DOI.

Raises an ArgumentError if parsing fails.

#### `DOI::find(doi) → uri`

Looks for a DOI at doi.org.

Returns a URI if it finds a match, otherwise returns nil.

~~~ruby
require 'doi/network'

url = DOI.find('10.17487/RFC8089')
~~~

#### `DOI::data(doi) → hash`

Gets data about a DOI from CrossRef.

~~~ruby
require 'doi/network'

data = DOI.data('10.17487/RFC8089')
~~~

### Instance Methods

#### `doi + other → new_doi`

Concatenation--Returns a new DOI containing _other_ concatenated to this DOI's suffix string.

#### `doi << other → doi`

Append--Concatenates the given object to this DOI's suffix string.

#### `doi.to_s(prefix: true) → str`

Returns a String that represents this DOI.

* _prefix_:  Prepends `'doi:'` to the returned string.

#### `doi.to_uri(info: false) → uri`

Returns a URI.

For example: `"https://doi.org/10.1000/foo%23bar"`

* _info_:  Returns an 'info:' URI instead of 'https:'

#### `doi.find → uri`

Looks for a DOI at doi.org.

Returns a URI if it finds a match, otherwise returns nil.

~~~ruby
require 'doi/network'

url = DOI.parse('10.17487/RFC8089').find
~~~

#### `doi.data → hash`

Gets data about this DOI from CrossRef.

~~~ruby
require 'doi/network'

data = DOI.parse('10.17487/RFC8089').data
~~~

## Contributing

We require all contributors to comply with the [Developer Certificate of Origin](https://developercertificate.org/). This ensures that all contributions are properly licensed and attributed.


## Contributor Code of Conduct

This repository is subject to a [Contributor Code of Conduct](code_of_conduct.md)
adapted from the [Contributor Covenant][cc], version 3.0, available at
<https://www.contributor-covenant.org/version/3/0/>


[cc]: https://www.contributor-covenant.org


## Licence

This project is licensed under the ISC licence. See [LICENSE](LICENSE)
for details
