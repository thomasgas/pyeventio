import struct 

class WrongTypeException(Exception):
	pass

def unpack_from(fmt, _buffer):
    result = struct.unpack_from(fmt, 
    	_buffer[_buffer.tell():_buffer.tell()+struct.calcsize(fmt)])
    _buffer.seek(struct.calcsize(fmt), 1)
    return result

def read_ints(n ,f):
    return unpack_from(str(n)+'i', f)

#nice decorator
def counted(fn):
    def wrapper(*args, **kwargs):
        wrapper.called+= 1
        return fn(*args, **kwargs)
    wrapper.called= 0
    wrapper.__name__= fn.__name__
    return wrapper

