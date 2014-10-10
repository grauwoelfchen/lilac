# Lilac

Lilac is list syntax parser that supports styles from several lightweight markup languages.  
It means that LIst LAzy Converter.

Currently, does not work yet :'(

## Supported syntax

* Asciidoc

## Installation

```sh
$ git clone https://github.com/grauwoelfchen/lilac.git
```

## Usage

```ruby
text = <<TEXT
* foo
** bar
*** baz
**** qux
** quux
TEXT

# TODO
# You can filter list via Enumerator::Lazy, but it needs more elegant way
list = Lilac::List.new(text)
list.list #=> #<Enumerator::Lazy: #<Enumerator: "...":each_line>>
list.list = list.list.take(2)
list.parse #=> #<Enumerator::Lazy: ... >
list.data = list.parse.select {|v| ... }
puts list.to_html #=> <ul><li>foo<li><li><ul><li>bar</li></ul>

list = Lilac::List.new(text)
puts list.to_html #=> <ul><li>foo<li><li><ul><li>bar</li><li>...</li></ul></li></ul>
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/lilac/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
