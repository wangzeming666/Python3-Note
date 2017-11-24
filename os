 os.write(fd, str)

    将str中的字节写入文件描述器fd。返回真正写入的字节数。

    注

    此函数适用于低级I/O，并且必须应用于os.open()或pipe()返回的文件描述器。
    要写内建函数open()或popen()或fdopen()或sys.stdout或sys.stderr，使用其write()方法。

    在版本3.5中更改：如果系统调用中断并且信号处理程序未引发异常，则此函数现在重试系统调用，而不是引发InterruptedError异常 PEP 475）。



 os.fork()

    Fork a child process. 在子项中返回0，在父项中返回子项的进程ID。如果发生错误OSError。

    注意一些平台包括FreeBSD

    Warning

    对于使用带fork()的SSL模块的应用程序，请参见ssl。

    可用的平台：Unix。



 os._exit(n)

    Exit the process with status n, without calling cleanup handlers, flushing stdio buffers, etc.

    注

    退出的标准方法是sys.exit(n)。_exit()通常只应在fork()之后的子进程中使用。

定义了以下退出代码，并且可以与_exit()一起使用，尽管它们不是必需的。These are typically used for system programs written in Python, 
such as a mail server’s external command delivery program.

注

Some of these may not be available on all Unix platforms, since there is some variation. These constants are defined where 
they are defined by the underlying platform.



 os.wait()

    等待子进程的完成，并返回包含其pid和退出状态指示的元组：一个16位数字，其低字节是终止进程的信号编号，并且其高字节是退出状态（如果信号数字为零）；
    如果产生了核心文件，则设置低字节的高位。

    可用的平台：Unix。



 os.waitid(idtype, id, options)

    等待一个或多个子进程的完成。idtype可以是P_PID，P_PGID或P_ALL。id指定要等待的pid。选项是从WEXITED，WSTOPPED或WCONTINUED中的一个或多个的
    ORing构建的， WNOHANG或WNOWAIT。返回值是表示包含在siginfo_t结构中的数据的对象，即：si_pid，si_uid，si_signo ，si_status，
    si_code或None如果指定WNOHANG，且没有处于可等待状态的子节点。

    可用的平台：Unix。

    版本3.3中的新功能。
    
 os.walk(top, topdown=True, onerror=None, followlinks=False)

    遍历目录树，自顶向下或自底向上生成目录树下的文件名。对根目录top（包括根目录top本身）中的每个目录，它都会yield一个3元元组(dirpath, dirnames, filenames)。

    dirpath是一个字符串，为目录路径。dirnames是dirpath中子目录的名称列表（不包括'.'和'..')。filenames 为dirpath 下非目录文件的名称列表。注意，列表中的名称不包含路径部分。要获得dirpath 中的文件或目录的完整路径(以 top开头), 请使用os.path.join(dirpath, name).

    如果可选参数topdown为True或未指定，则在生成其任何子目录的三元组tuple之前生成其本身的三元组tuple。（简言之就是自上而下遍历）如果topdown是False，则在生成所有子目录的三元组之后生成其本身的三元组（即自下而上生成）。No matter the value of topdown, the list of subdirectories is retrieved before the tuples for the directory and its subdirectories are generated.

    当topdown是True时，调用者可以修改dirnames列表（可能使用del ）和walk()只会递归到名称保留在dirnames中的子目录；这可以用于修剪搜索，强加特定的访问顺序，或甚至通知walk()关于调用者在恢复walk()再次。在topdown为False时修改dir名称对步行的行为没有影响，因为在自下而上模式下，在生成dirpath之前生成。

    默认情况下，来自listdir()的错误将被忽略。如果指定了可选参数onerror，它应该是一个函数；it will be called with one argument, an OSError instance.它可以报告错误以继续遍历还是引发一个异常以停止遍历。请注意，文件名可用作异常对象的filename属性。

    默认情况下，walk()不会向下走到符号链接解析到目录。将followlinks设置为True以访问支持它们的系统上symlinks指向的目录。

    注

    请注意，如果链接指向自身的父目录，将followlinks设置为True可能会导致无限递归。walk()不会跟踪其访问过的目录。

    注

    如果传递相对路径名，请不要在walk()的恢复之间更改当前工作目录。walk()从不更改当前目录，并假定其调用者也不会。

    下面的例子显示每个目录下非目录文件占用的字节数，CVS 子目录除外：

    import os
    from os.path import join, getsize
    for root, dirs, files in os.walk('python/Lib/email'):
        print(root, "consumes", end=" ")
        print(sum(getsize(join(root, name)) for name in files), end=" ")
        print("bytes in", len(files), "non-directory files")
        if 'CVS' in dirs:
            dirs.remove('CVS')  # don't visit CVS directories

    在下一个示例中（shutil.rmtree()的简单实现），从下到上行走树是必要的，rmdir()不允许在目录为空：

    # Delete everything reachable from the directory named in "top",
    # assuming there are no symbolic links.
    # CAUTION:  This is dangerous!  For example, if top == '/', it
    # could delete all your disk files.
    import os
    for root, dirs, files in os.walk(top, topdown=False):
        for name in files:
            os.remove(os.path.join(root, name))
        for name in dirs:
            os.rmdir(os.path.join(root, name))

    在版本3.5中更改：此函数现在调用os.scandir()而不是os.listdir()调用os.stat()。



os.fwalk(top='.', topdown=True, onerror=None, *, follow_symlinks=False, dir_fd=None)

    行为与walk()非常类似，不同的是它产生一个4元组(dirpath, dirnames, filenames, dirfd)，并支持dir_fd。

    dirpath, dirnames and filenames are identical to walk() output, and dirfd is a file descriptor referring to the directory dirpath.

    This function always supports paths relative to directory descriptors and not following symlinks. 但请注意，与其他函数不同，fwalk() follow_symlinks的默认值为False。

    注

    由于fwalk()产生文件描述器，所以它们只在下一个迭代步骤有效，因此你应该复制它们。与dup()）如果你想保持它们更长。

    下面的例子显示每个目录下非目录文件占用的字节数，CVS 子目录除外：

    import os
    for root, dirs, files, rootfd in os.fwalk('python/Lib/email'):
        print(root, "consumes", end="")
        print(sum([os.stat(name, dir_fd=rootfd).st_size for name in files]),
              end="")
        print("bytes in", len(files), "non-directory files")
        if 'CVS' in dirs:
            dirs.remove('CVS')  # don't visit CVS directories

    在下一个示例中，从下到上行走树是必不可少的：rmdir()不允许在目录为空之前删除目录：

    # Delete everything reachable from the directory named in "top",
    # assuming there are no symbolic links.
    # CAUTION:  This is dangerous!  For example, if top == '/', it
    # could delete all your disk files.
    import os
    for root, dirs, files, rootfd in os.fwalk(top, topdown=False):
        for name in files:
            os.unlink(name, dir_fd=rootfd)
        for name in dirs:
            os.rmdir(name, dir_fd=rootfd)

    可用的平台：Unix。

    版本3.3中的新功能。
