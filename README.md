# my-vimrc
我的Vim和Neovim配置
My Vim &amp; NeoVim config

## 环境需求
Vim >= 7.3  
Neovim >= 0.7

## 配置我的Vim
[![Vim Logo](https://github.com/vim/vim/raw/master/runtime/vimlogo.gif)](https://www.vim.org)  
切换路径至本仓库目录下，复制本仓库的```.vimrc```作为用户的Vim默认配置文件。
```
cp ./.vimrc ~/.vimrc
```

配置中使用了Vundle作为Vim的插件管理器，按照[官方文档](https://github.com/VundleVim/Vundle.vim)下载Vundle。
```
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
```

下载完毕后，进入Vim，输入命令```:PluginInstall```安装插件。  
主要功能插件的快捷键是```F2~F5```，```F7~F8```。安装完毕后重新进入Vim，即可按动快捷键查看插件是否工作正常。更多的快捷键详见配置文件的最后。  

⚠️注意：  
某些插件需要进行额外的操作才能正常工作（如F3对应的Vimshell和F8对应的Tagbar插件），请根据插件提示操作。  
Tagbar插件需要提供```ctags```程序方可工作，```ctags```程序可通过包管理器安装。```ctags```程序一般由```universal-ctags```包和```exuberant-ctags```包提供，该插件同时兼容两者，但强烈建议安装更加先进的```universal-ctags```。

## 配置我的NeoVim
![Neovim](https://raw.githubusercontent.com/neovim/neovim.github.io/master/logos/neovim-logo-300x87.png)  
**Neovim编辑器是对传统Vim编辑器的新重构**。Neovim拥有着强大的：
- **可扩展性**——几乎所有主流语言都可轻松访问Neovim的API，因此大家很容易地编写它的插件。Neovim对lua语言的内建支持使得插件可以飞速运行，这让**流畅的**代码补全和语法高亮等功能成为可能。
- **可用性**——Neovim修缮了Vim过时的默认配置，并添加了现代编辑器的新功能，如现代GUI、异步加载和终端模拟器等。

### 安装Neovim
本仓库的Neovim配置文件需要比较新的NeoVim版本（大于等于0.7），大多数的包管理器软件源尚未更新该版本，因此需要遵循[官方文档](https://github.com/neovim/neovim/wiki/Installing-Neovim)手动安装。  
对于Linux系统，下载并执行安装程序。
```
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
./nvim.appimage
```
💡如果安装失败，可以手动从安装包里解压Neovim相关文件到本地。
```
./nvim.appimage --appimage-extract
./squashfs-root/AppRun --version
```
如果要全局安装（需sudo权限），先对相关文件进行移动，再将可执行文件软连接到系统二进制文件目录下，命名为nvim。操作完成后，使用nvim命令便可以启动Neovim。
```
sudo mv squashfs-root /
sudo ln -s /squashfs-root/AppRun /usr/bin/nvim
nvim
```
💡如果没有sudo权限，可以仅对当前用户安装Neovim。对Ubuntu系统而言，可以将程序数据移动至当前用户```$HOME```下的```.local/```目录（这是Ubuntu默认用于存放当前用户应用数据的位置）；然后将可执行文件软连接至```~/.local/bin/nvim```（```~/.local/bin/```目录是Ubuntu系统默认用于存放当前用户可执行文件的位置，并应当默认存在于当前用户的```$PATH```中）。
```
mv squashfs-root ~/.local/
ln -s ~/.local/squashfs-root/AppRun ~/.local/bin/nvim
nvim
```

### 配置Neovim
切换路径至本仓库目录下，复制本仓库的```init.vim```作为用户的Neovim默认配置文件（Neovim用户默认配置文件为```~/.config/nvim/init.vim```）。
```
mkdir -p ~/.config/nvim/
cp ./init.vim ~/.config/nvim/init.vim
```
在终端输入```nvim```进入Neovim，此时将自动开始下载插件管理器```plug.vim```。下载成功后输入命令```:PlugInstall```安装所有插件。  
主要功能插件的快捷键是```F2~F5```，```F7~F8```。安装完毕后重新进入Neovim，即可按动快捷键查看插件是否工作正常。更多的快捷键详见配置文件的最后。
