#!/bin/bash

FILES=(.zshrc
       .inputrc
      )

for item in ${FILES[@]}; do
	rm -f ~/${item}
	ln -s $(pwd)/${item} ~/
done
