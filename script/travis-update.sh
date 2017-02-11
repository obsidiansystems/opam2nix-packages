#!/bin/bash
set -eux
pushd opam-repository
	rm -f .push
	git fetch git://github.com/ocaml/opam-repository.git
	if ! git diff -q --exit-code FETCH_HEAD; then
		git merge --no-edit FETCH_HEAD
		touch .push
	fi
popd


rm -f .push
./repo/packages.gup --update
if ! git diff -q --exit-code; then
	git add opam-repository repo/packages
	git commit -m "Automated package update";
	touch .push
fi
