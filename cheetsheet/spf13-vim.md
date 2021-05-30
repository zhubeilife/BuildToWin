## Install and Update

```bash
# Installation
curl http://j.mp/spf13-vim3 -L -o - | sh

# Update
d $HOME/to/spf13-vim/
git pull
vim +BundleInstall! +BundleClean +q
```

## Shortcuts

### spf13-vim

    + <Leader> ---> ,

### NERDTree-file Navigation

    + <Ctrl e> to toggle NERDTree
        - t / T   : Open file in new tab
        - i / gi  : Open file in split
        - s / gs  : Open file in vsplit
        - r       : Refresh folder
        - m       : File copy/m­ove­/delete
        - q       : Close NERDTree

### ctrlp - file finder
    
    + <Ctrl p>

### NERDCommenter - add comment
    
    + <Leader> + <c> + <space>

### neocomplacche - autocomplete

    + <Ctrl k> for completeting snippets

### Tagbar - tag generation and navigation

    + <Ctrl -> to jump to definition
    + <Leader> + tt for toggle the bagbar panel
    + <Ctrl T> to jump back

### 

## Customize

### Add bunddle

Create ~/.vimrc.bundles.local for any additional bundles.

```bash
#To add a new bundle
echo Bundle \'spf13/vim-colors\' >> ~/.vimrc.bundles.local
```


