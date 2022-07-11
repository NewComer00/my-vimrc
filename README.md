# my-vimrc
我的Vim和Neovim配置  
My Vim &amp; NeoVim config

## 环境需求
```Vim >= 7.3```或```Neovim >= 0.7```

## 配置功能介绍
### 主要快捷键
**⌨️描述约定**：  
- ```<F2>```表示短促地按一下```F2```功能键。  
有些电脑的功能键需要先按住```fn```键才能启用，建议设置成不需要按```fn```键就能直接用。  
- ```<C-p>```表示先按住```Ctrl```不松手，再按下小写的```p```。  
- ```<F>```（大写```F```）表示先按住```Shift```不松手，再按下小写的```f```，此时输出大写的```F```。

|快捷键|功能（再按一次快捷键可关闭窗口）|
| - | - |
|```<F2>```|以文件树的方式查看当前目录。可以在其中打开/删除/新建文件等。|
|```<F3>```|在编辑器内部打开一个系统命令行。支持```Tab```命令补全，```<C-p>```上翻历史记录，```<C-n>```下翻。|
|```<F4>```|展示当前文件撤销和重做的历史记录。历史记录可以分叉，并且可以随时将文件内容回退到选定历史版本。|
|```<F5>```|开启一个漂亮的底部状态栏。可以显示当前文件的详细信息，如行列号/文件路径/编码/当前按键等。|
|```<F7>```|列举最近（通过编辑器）复制的所有内容。输入数字或双击对应行，即可粘贴相应内容。|
|```<F8>```|分析并展示当前代码文件的所有标签（指函数/变量/包含文件/宏等），依赖于外部```ctags```程序。鼠标双击/键盘回车某个标签，即可跳转至标签定义位置。|

### 辅助快捷键
**⌨️描述约定**：  
- ```<Leader>t```表示先短促地按一下```反斜杠\```（即Leader键），紧接着再短促地按一下小写的```t```。  
两次按键间隔要短，不然编辑器会认为这是两次不相关的输入。  
- ```<Leader>F```表示先短促地按一下```反斜杠\```，紧接着再短促地按一下大写的```T```（按```Shift```不松手并按```t```）。

|快捷键|功能|
| - | - |
|```<Leader>l```|展示/隐藏空白字符，按多次可在展示/隐藏间来回切换。|
|```<Leader>p```|进入/退出```粘贴模式```。在```粘贴模式```下，自动缩进和一些插件功能会自动关闭。对于Vim来说，需要从**外部**（如博客等）粘贴内容进入编辑器时，如果内容包含复杂的换行和缩进，建议先切换成```粘贴模式```再粘贴，以避免错误激活自动缩进和插件功能。按多次可在进入/退出```粘贴模式```间来回切换。|
|```<Leader>t```|将```<Tab>```的输入在空格和```制表符\t```之间切换，本配置文件默认配置```<Tab>```的输入为四个空格。|
|```<Leader>f```|美化代码的指定行/块。需要外部的软件支持。|
|```<Leader>F```|美化整个代码文件。需要外部的软件支持。|
|```<Leader>s```|删除所有多余的空格。在行尾多余的空格会被红色高亮显示，该操作可以快速删除这些多余空格。**注意**：在某些语言（如Markdown）的语法中，行尾空格是有实际语法意义的，这种情况下请不要轻易使用本快捷键。|

详细信息请见配置文件最后```hotkeys```部分。

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
**Neovim编辑器是对传统Vim编辑器的重构**。Neovim拥有着强大的：
- **可扩展性**——几乎所有主流语言都可以轻松访问Neovim的API，因此大家能够很容易地编写它的插件。Neovim对lua语言的内建支持使得插件可以飞速运行，这让**流畅的**代码补全和语法高亮等功能成为可能。
- **可用性**——Neovim修缮了Vim过时的默认配置（Neovim定制了一套自己的新默认配置），并添加了现代编辑器的新功能，如现代GUI、异步加载和终端模拟器等。

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
