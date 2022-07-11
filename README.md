# my-vimrc
我的Vim和Neovim配置
My Vim &amp; NeoVim config

## 环境需求
Vim >= 7.3  
Neovim >= 0.7

## 配置我的Vim
复制本仓库的```.vimrc```作为用户的Vim默认配置文件。
```
cp ./.vimrc ~/.vimrc
```

配置中使用了Vundle作为Vim的插件管理器，按照[官方文档]下载Vundle(https://github.com/VundleVim/Vundle.vim)。
```
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
```

下载完毕后，进入Vim，输入命令```:PluginInstall```安装插件。  
主要功能插件的快捷键是```F2~F5```，```F7~F8```。安装完毕后重新进入Vim，即可按动快捷键查看插件是否工作正常。更多的快捷键详见配置文件的最后。  

⚠️注意：  
某些插件需要进行额外的操作才能正常工作（如F3对应的Vimshell和F8对应的Tagbar插件），请根据插件提示操作。  
Tagbar插件需要提供```ctags```程序方可工作，```ctags```程序可通过包管理器安装。```ctags```程序一般由```universal-ctags```包和```exuberant-ctags```包提供，该插件同时兼容两者，但强烈建议安装更加先进的```universal-ctags```。
