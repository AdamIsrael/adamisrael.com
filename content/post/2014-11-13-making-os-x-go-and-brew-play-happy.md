---
title: Making OS X, Go, and Brew play happy
author: Adam
layout: post
date: 2014-11-13
url: /blog/2014/11/13/making-os-x-go-and-brew-play-happy/
panels_data:
  - 'a:0:{}'
masonry_settings:
  - 'a:1:{s:4:"size";s:2:"11";}'
ljID:
  - 382
ljURL:
  - http://stonetable.livejournal.com/97985.html
categories:
  - Technical
tags:
  - go
  - homebrew
  - juju
  - os x

---
# GO and OS X

I&#8217;m doing a little hacking with [juju actions][1] before they land in a stable release but I ran into some hurdles getting Go working with the [brew][2]-installed version. Trying to install Go packages failed with a bunch of &#8216;unrecognized import path&#8217; errors. Here&#8217;s how I fixed it.

# STOP, GO, STOP

Even though you can install Go via brew, there&#8217;s more to be done to get it working. Go relies on two environment variables: [GOPATH][3], and GOROOT. GOROOT is the path where Go is installed, and GOPATH is the directory you&#8217;ve created for your code workspace (which I&#8217;ve defaulted to $HOME/go).  We then need to tell our shell where to find these installed executable and run them first<sup><a href="#1">1</a></sup>.

<pre class="lang:default decode:true" title="Add go to your bash profile">cat &lt;&lt; EOF &gt; ~/.bash_profile
# Go go gadget Go!
GOVERSION=$(brew list go | head -n 1 | cut -d '/' -f 6)
export GOPATH=$HOME/go
export GOROOT=$(brew --prefix)/Cellar/go/$GOVERSION/libexec
PATH=$GOROOT/bin:"${PATH}"
EOF
</pre>

Now you can run something like to have easier access to docs:

<pre class="theme:terminal lang:default decode:true">$ go get code.google.com/p/go.tools/cmd/godoc
$ godoc gofmt
COMMAND DOCUMENTATION

    Gofmt formats Go programs. It uses tabs (width = 8) for indentation and
    blanks for alignment.

    Without an explicit path, it processes the standard input. Given a file,
    it operates on that file; given a directory, it operates on all .go
    files in that directory, recursively. (Files starting with a period are
    ignored.) By default, gofmt prints the reformatted sources to standard
    output.

    Usage:

    gofmt [flags] [path ...]

    The flags are:

    -d
        Do not print reformatted sources to standard output.
        If a file's formatting is different than gofmt's, print diffs
        to standard output.
    -e
        Print all (including spurious) errors.
    -l
        Do not print reformatted sources to standard output.
        If a file's formatting is different from gofmt's, print its name
        to standard output.
    -r rule
        Apply the rewrite rule to the source before reformatting.
    -s
        Try to simplify code (after applying the rewrite rule, if any).
    -w
        Do not print reformatted sources to standard output.
        If a file's formatting is different from gofmt's, overwrite it
        with gofmt's version.

    Debugging support:

    -cpuprofile filename
        Write cpu profile to the specified file.

    The rewrite rule specified with the -r flag must be a string of the
    form:

    pattern -&gt; replacement

    Both pattern and replacement must be valid Go expressions. In the
    pattern, single-character lowercase identifiers serve as wildcards
    matching arbitrary sub-expressions; those expressions will be
    substituted for the same identifiers in the replacement.

    When gofmt reads from standard input, it accepts either a full Go
    program or a program fragment. A program fragment must be a
    syntactically valid declaration list, statement list, or expression.
    When formatting such a fragment, gofmt preserves leading indentation as
    well as leading and trailing spaces, so that individual sections of a Go
    program can be formatted by piping them through gofmt.

    Examples

    To check files for unnecessary parentheses:

    gofmt -r '(a) -&gt; a' -l *.go

    To remove the parentheses:

    gofmt -r '(a) -&gt; a' -w *.go

    To convert the package tree from explicit slice upper bounds to implicit
    ones:

    gofmt -r 'α[β:len(α)] -&gt; α[β:]' -w $GOROOT/src/pkg


    The simplify command

    When invoked with -s gofmt will make the following source
    transformations where possible.

    An array, slice, or map composite literal of the form:
        []T{T{}, T{}}
    will be simplified to:
        []T{{}, {}}

    A slice expression of the form:
        s[a:len(s)]
    will be simplified to:
        s[a:]

    A range of the form:
        for x, _ = range v {...}
    will be simplified to:
        for x = range v {...}

BUGS

   The implementation of -r is a bit slow.
</pre>

# Homebrew Gotchas

Homebrew installs the go formula with a bin/ directory, which symlinks to the go and gofmt binaries in libexec/. Other binaries, such as godoc, will be installed to libexec but are not symlinked to bin/. Adding go/$GOVERSION/libexec, instead of go/$GOVERSION/bin, to PATH makes sure we&#8217;re looking in the right place, and this setup will survive a version upgrade.

* * *

<a name="1"></a>
  
<sup>1</sup>: It would probably be better to create a script that would toggle the PATH to include/exclude my $GOPATH/bin in $PATH. I&#8217;m using this to run the latest cutting edge version of juju, but I can see the need to switch back to using the released version of juju, without having to hack my ~/.bash_profile

 [1]: https://github.com/juju-actions/juju/wiki
 [2]: http://brew.sh/
 [3]: https://code.google.com/p/go-wiki/wiki/GOPATH