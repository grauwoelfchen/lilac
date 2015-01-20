# Lilac

[![Build Status](https://secure.travis-ci.org/grauwoelfchen/lilac.png)](http://travis-ci.org/grauwoelfchen/lilac)

Lilac (luxury indented list another converter) is list converter
that supports list styles of several lightweight markup languages.


## Supported syntax

* Asciidoc
* Markdown


## Installation

```sh
$ gem install lilac
```


```sh
$ git clone https://github.com/grauwoelfchen/lilac.git
```


## Usage

### Ruby

```ruby
text = <<TEXT
* foo
** bar
*** baz
**** qux
** quux
TEXT

list = Lilac::List.new(text)
puts list.to_html #=> <ul><li>foo<li><li><ul><li>...</li></ul></li></ul>
```

### Command line

```sh
$ lilac
* foo
** bar
*** baz
;; press ^D
<ul><li>foo</li><li><ul><li>bar</li><li><ul><li>baz</li></ul></li></ul></li></ul>
```

### Supported list styles

#### Asciidoc

```
- foo
- bar
- baz

;; p list.to_html
<ul>
  <li>foo</li>
  <li>bar</li>
  <li>baz</li>
</ul>
```

```
* foo
** bar
*** baz

;; p list.to_html
<ul>
  <li>foo</li>
  <li>
    <ul>
      <li>bar</li>
      <li>
        <ul>
          <li>baz</li>
        </ul>
      </li>
    </ul>
  </li>
</ul>
```

#### Markdown

```
* foo
  * bar
    * baz

;; p list.to_html
<ul>
  <li>foo</li>
  <li>
    <ul>
      <li>bar</li>
      <li>
        <ul>
          <li>baz</li>
        </ul>
      </li>
    </ul>
  </li>
</ul>
```


## License

[MIT](LICENSE.txt)
