# vim-and-cp

Some helpful bits and pieces for your vimrc

## compiling

```vim
:CompileAndRun
```

Using a file as input, for example `input.txt`

```vim
:CompileAndRunWithFile "input.txt"
```

To compile and run separately, you can use the following command definitions:

```vim
command! -nargs=0 Compile call TermWrapper(printf('g++ -std=c++11 %s', expand('%')))
command! -nargs=0 Run call TermWrapper('./a.out')
```

These commands can be mapped to keys of your choice, for example:

```vim
autocmd FileType cpp nnoremap <leader>fw :CompileAndRun<CR>
```

## options

Choose between 'vertical' and 'horizontal' for how the terminal window is split
(default is vertical)

```vim
let g:split_term_style = 'horizontal'
```

Add a custom command to resize the terminal window to your preference
(default is to split the screen equally)

```vim
let g:split_term_resize_cmd = 'resize 6'
```
