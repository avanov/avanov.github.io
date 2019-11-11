build-script:
	# https://nixos.org/nixpkgs/manual/#users-guide-to-the-haskell-infrastructure
	cabal2nix --shell ./. > default.nix

build-site:
	nix-shell --command "cabal build" ./default.nix

watch: build-site
	./dist-newstyle/build/*/ghc-*/avanov-github-io-*/x/site/build/site/site watch

clean: build-site
	./dist-newstyle/build/*/ghc-*/avanov-github-io-*/x/site/build/site/site clean

initial-create-master:
	# Create a subtree as a master branch that would contain compiled
	# Hakyll pages
	# http://brittanderson.github.io/posts/2018-01-17-hakyll-and-github-with-subtrees.html
	git subtree split --squash --prefix _site -b master

publish-changes-master:
	git subtree push --squash --prefix _site . master