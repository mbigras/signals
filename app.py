# https://stackabuse.com/handling-unix-signals-in-python/
import signal
import os
import time
import sys

def shutdown(signal_num, frame):
    print('received signal {}'.format(signal_num))
    print ('exiting...')
    sys.exit()

def receive_signal(signal_num, frame):
    print('received signal {}'.format(signal_num))
    return

if __name__ == '__main__':
    # register the signals to be caught
    signal.signal(signal.SIGHUP, receive_signal)
    signal.signal(signal.SIGINT, shutdown)
    signal.signal(signal.SIGQUIT, receive_signal)
    signal.signal(signal.SIGILL, receive_signal)
    signal.signal(signal.SIGTRAP, receive_signal)
    signal.signal(signal.SIGABRT, receive_signal)
    signal.signal(signal.SIGBUS, receive_signal)
    signal.signal(signal.SIGFPE, receive_signal)
    #signal.signal(signal.SIGKILL, receive_signal)
    signal.signal(signal.SIGUSR1, receive_signal)
    signal.signal(signal.SIGSEGV, receive_signal)
    signal.signal(signal.SIGUSR2, receive_signal)
    signal.signal(signal.SIGPIPE, receive_signal)
    signal.signal(signal.SIGALRM, receive_signal)
    signal.signal(signal.SIGTERM, shutdown)

    # output current process id
    print('pid {}'.format(os.getpid()))
    print('args {}'.format(sys.argv[1:]))

    # wait in an endless loop for signals 
    while True:
        time.sleep(1)
