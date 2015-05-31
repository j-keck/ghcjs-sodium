minimal ghcjs + sodium example with doesn't work.

* build it (see [build](#build))
* open dist/build/ghcjs-sodium/ghcjs-sodium.jsexe/index.html
* click the button repeatedly
* after 3 seconds, the counter doesn't update anymore
* reload the page, and the counter updates again - for 3 seconds

but why?


# build

## fetch ghcjs-jquery 

  git submodule init

  git submodule update

## build modules / project

  cabal sandbox init

  cabal install ./ghcjs-jquery

  cabal install
    
  cabal build

  
