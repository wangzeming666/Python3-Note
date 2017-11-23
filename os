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

