# Lilac

Lilac is list syntax parser that supports styles from several lightweight markup languages.  
It means that LIst LAzy Converter.

Currently, does not work yet :'(

## Supported syntax

* Asciidoc
* Markdown

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

### Supported list styles

#### Asciidoc

```ruby
- foo
- bar
- baz

puts list.to_html #=> <ul><li>foo</li><li>bar</li><li>baz</li></ul>
```

```ruby
- foo
-- bar
--- baz

puts list.to_html #=> <ul><li>foo</li><li>bar</li><li>baz</li></ul>
```

```ruby
* foo
** bar
*** baz

puts list.to_html #=> <ul><li>foo</li><li><ul><li>bar</li><li><ul><li>baz</li></ul></li></ul></li></ul>
```

#### Markdown

```ruby
* foo
  * bar
    * baz

puts list.to_html #=> <ul><li>foo</li><li><ul><li>bar</li><li><ul><li>baz</li></ul></li></ul></li></ul>
```


## License

[MIT](LICENSE.txt)
