inglorious-helper

xemdetia

* Purpose

  We have to write software that runs on multiple machines using
  multiple toolchains. At this moment I've never really been able to
  be productive with multiple make systems, and additionally even if
  the make system problem is figured out there is also the issue of
  having a testing framework that plays nice across both systems.

  The author of this piece of software does a lot of C programming,
  and in general unit testing frameworks for C are either not very
  abstract or fall into macro hell, and C being how it is does not
  allow you to isolate functions in a reasonable manner, and again
  since build systems for C programs are always a problem it just adds
  more to the wall between you and an easy to use testing environment.

  In the theory behind [[http://i3wm.org/docs/testsuite.html][i3]] (a tiling window manager for Linux) the
  author of this code agrees strongly with the idea of:

  #+begin_quote
  It is a good idea to use a different language for the tests than the
  implementation itself.
  #+end_quote
  
  So the two hurt points for having C programs on different platforms
  are then directly summarized by:

  1. Difficulty of managing consistent build environments across
     platforms.
  2. Difficulty of managing a test framework consistently across build
     environments.

     If you assume that you are building for two systems, this counts as
     two build environments. In case 2 it is also true that a testing
     environment is also a build environment which has to be maintained
     across more than one platform. If you are a single developer that
     means that you have 4 build environments to maintain and try to keep
     consistent and the author has never really found a way to do
     it. Even in using an IDE you still usually have to do a lot of
     fiddling to try and make sure everything stays consistent.

     Beyond those two cases you also have the problem of trying to create
     debug builds, production builds and packaging/install buildsthe list
     goes on. Again the author of this software has never really found a
     good answer to this problem.

     Beyond the build system, there are also possibilities for simple
     code/project management. If you are an emacs user one of the simple
     cross-platform methods for code searching is a mix of grep and TAGS
     files. Any help there would be appreciated.

* Design Goals
  
  On top of all the reasoning provided by the [[Purpose]], there hasn't
  been a build system that has played super nicely with Emacs for the
  author. The closest was the simple and trivial =M-x compile= but
  this also relies on a coherent build tool backing it up. One of the
  best tool-driving extensions for Emacs that the author has used has
  been [[http://philjackson.github.com/magit/][magit]] which truly exploits Emacs as a tool to help get things
  done. Another good tool has been [[http://emacswiki.org/GrandUnifiedDebugger][gud]], especially after you apply
  =M-x gdb-many-windows=. With both of these successful interfaces in
  mind it is hopeful that a similarly useful tool can be developed.

  Another feature that the author desires is for an always-on build
  backend. There's nothing clever to it except build management
  features that are yet to be figured out. The theory is that if it
  stays always on more features like code completion and so forth can
  be added onto the existing data channels. It is likely that some
  sort of grammar/AST analysis will have to be plugged on to help
  work out dependencies so being able to utilize that would probably
  be helpful.

* Languages/Tools

  The kernel build backend is to be written in clojure. For one it is
  a JVM language so it runs the same on all JVM platforms- or at
  least enough to be consistent. Additionally clojure has it's own
  cross-platform build tool called [[http://leiningen.org/][Leiningen]], which means that the
  end build environment is something that can be bootstrapped on a
  fresh machine without hopefully a huge amount of fuss. Since
  Clojure has a long spin-up time as spoken of [[http://martinsprogrammingblog.blogspot.com/2012/02/why-is-clojure-so-slow.html][here]] this also lends
  to the always-on product.

  The tests will either be written in Python using PyPy as an
  intepreter, under the premise that a Python program is easier to
  parse than a clojure program at a glance and also that a
  well-formed piece of C code can be creatively compiled into a
  shared library and Python inherently has the feature set to work
  with a shared library with ctypes. A shared library at least in C
  terms can be naively thought of an enumeration of all included
  functions so I do not feel it is that unreasonable to think that
  this would not be possible. Again this subscribes to the principle
  that a language should be tested in another language.

  The UI extension for emacs will be written in emacs lisp for
  trivial reasons.
