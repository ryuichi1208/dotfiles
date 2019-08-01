#!/bin/bash

FILES=(.zshrc
       .inputrc
       .vimrc
      )

for item in ${FILES[@]}; do
	rm -f ~/${item}
	ln -s $(pwd)/${item} ~/
done
