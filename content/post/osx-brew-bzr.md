---
author: Adam Israel
categories:
- Technical
date: 2016-05-06T08:34:39-04:00
hidden: false
tags:
- brew
- osx
- python
- bzr
title: bzr "Insecure string pickle"
---
I've been bit by a bug in the `bzr` source code control system where running a commit
throws an ugly stack trace blaming an "insecure string pickle", but I've found a workaround.

<!--more-->
Environment:

- Mac OS X 10.11.4 build 15E65
- Python 2.7.11 installed via [homebrew]
- bzr 2.7.0 installed via [homebrew].


```bash
$ cd /path/to/dirty-bzr-repo/
$ bzr commit
bzr: ERROR: exceptions.ValueError: insecure string pickle

Traceback (most recent call last):
  File "/usr/local/lib/python2.7/site-packages/bzrlib/commands.py", line 930, in exception_to_return_code
    return the_callable(*args, **kwargs)
  File "/usr/local/lib/python2.7/site-packages/bzrlib/commands.py", line 1121, in run_bzr
    ret = run(*run_argv)
  File "/usr/local/lib/python2.7/site-packages/bzrlib/commands.py", line 673, in run_argv_aliases
    return self.run(**all_cmd_args)
  File "/usr/local/lib/python2.7/site-packages/bzrlib/commands.py", line 697, in run
    return self._operation.run_simple(*args, **kwargs)
  File "/usr/local/lib/python2.7/site-packages/bzrlib/cleanup.py", line 136, in run_simple
    self.cleanups, self.func, *args, **kwargs)
  File "/usr/local/lib/python2.7/site-packages/bzrlib/cleanup.py", line 166, in _do_with_cleanups
    result = func(*args, **kwargs)
  File "/usr/local/lib/python2.7/site-packages/bzrlib/builtins.py", line 3687, in run
    lossy=lossy)
  File "/usr/local/lib/python2.7/site-packages/bzrlib/decorators.py", line 218, in write_locked
    result = unbound(self, *args, **kwargs)
  File "/usr/local/lib/python2.7/site-packages/bzrlib/workingtree_4.py", line 218, in commit
    result = WorkingTree.commit(self, message, revprops, *args, **kwargs)
  File "/usr/local/lib/python2.7/site-packages/bzrlib/decorators.py", line 218, in write_locked
    result = unbound(self, *args, **kwargs)
  File "/usr/local/lib/python2.7/site-packages/bzrlib/mutabletree.py", line 211, in commit
    *args, **kwargs)
  File "/usr/local/lib/python2.7/site-packages/bzrlib/commit.py", line 290, in commit
    lossy=lossy)
  File "/usr/local/lib/python2.7/site-packages/bzrlib/cleanup.py", line 132, in run
    self.cleanups, self.func, self, *args, **kwargs)
  File "/usr/local/lib/python2.7/site-packages/bzrlib/cleanup.py", line 166, in _do_with_cleanups
    result = func(*args, **kwargs)
  File "/usr/local/lib/python2.7/site-packages/bzrlib/commit.py", line 443, in _commit
    message = message_callback(self)
  File "/usr/local/lib/python2.7/site-packages/bzrlib/builtins.py", line 3664, in get_message
    start_message=start_message)
  File "/usr/local/lib/python2.7/site-packages/bzrlib/msgeditor.py", line 150, in edit_commit_message_encoded
    if not _run_editor(msgfilename):
  File "/usr/local/lib/python2.7/site-packages/bzrlib/msgeditor.py", line 67, in _run_editor
    x = call(edargs + [filename])
  File "/usr/local/Cellar/python/2.7.11/Frameworks/Python.framework/Versions/2.7/lib/python2.7/subprocess.py", line 522, in call
    return Popen(*popenargs, **kwargs).wait()
  File "/usr/local/Cellar/python/2.7.11/Frameworks/Python.framework/Versions/2.7/lib/python2.7/subprocess.py", line 710, in __init__
    errread, errwrite)
  File "/usr/local/Cellar/python/2.7.11/Frameworks/Python.framework/Versions/2.7/lib/python2.7/subprocess.py", line 1334, in _execute_child
    child_exception = pickle.loads(data)
  File "/usr/local/Cellar/python/2.7.11/Frameworks/Python.framework/Versions/2.7/lib/python2.7/pickle.py", line 1388, in loads
    return Unpickler(file).load()
  File "/usr/local/Cellar/python/2.7.11/Frameworks/Python.framework/Versions/2.7/lib/python2.7/pickle.py", line 864, in load
    dispatch[key](self)
  File "/usr/local/Cellar/python/2.7.11/Frameworks/Python.framework/Versions/2.7/lib/python2.7/pickle.py", line 972, in load_string
    raise ValueError, "insecure string pickle"
ValueError: insecure string pickle

bzr 2.7.0 on python 2.7.11 (Darwin-15.4.0-x86_64-i386-64bit)
arguments: ['/usr/local/bin/bzr', 'commit']
plugins: bash_completion[2.7.0], changelog_merge[2.7.0],
    fastimport[0.14.0dev], grep[2.7.0], launchpad[2.7.0],
    netrc_credential_store[2.7.0], news_merge[2.7.0], po_merge[2.7.0],
    weave_fmt[2.7.0]
encoding: 'utf-8', fsenc: 'utf-8', lang: 'en_CA.UTF-8'

*** Bazaar has encountered an internal error.  This probably indicates a
    bug in Bazaar.  You can help us fix it by filing a bug report at
        https://bugs.launchpad.net/bzr/+filebug
    including this traceback and a description of the problem.
```

I've been bit by this bug a few times. The easy workaround was to set the
commit message on the command line:

```bash
$ cd /path/to/dirty-bzr-repo/
$ bzr commit -m "Some commit message"
```

Ultimately, the problem is that bzr expects BZR_EDITOR to be set. If it's not,
it will throw this cryptic exception. You can fix this by setting this
environment variable in your shell.

```bash
# ~/.bash_profile

# Tell bzr which editor to use
export BZR_EDITOR=vim
```

I've filed [lp:1579048](https://bugs.launchpad.net/bzr/+bug/1579048) to
document the bugs and workaround(s)



[homebrew]: https://brew.sh
