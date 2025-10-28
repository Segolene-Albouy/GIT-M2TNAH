def func_a():
    print("Function A")
    func_b()


def func_b():
    print("Function B")
    func_c()


def func_c():
    print("Function C")
    func_d()


def func_d():
    print("Function D")
    func_a()
