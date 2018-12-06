# cython: language_level=3
import cython
import numpy as np
cimport numpy as np


INT32 = np.int32
ctypedef np.int32_t INT32_t


cdef short bytes_to_short(const unsigned char b0, const unsigned char b1):
    return ((<short> b0) << 8) | (<short> b1)


@cython.wraparound(False)  # disable negative indexing
cpdef read_sector_information(
    const unsigned char[:] data,
    unsigned long n_pixels,
    unsigned long offset = 0,
):
    cdef unsigned long pos = 0
    cdef unsigned long i
    cdef short n = 0
    cdef np.ndarray[INT32_t, ndim=1] sector
    cdef list sectors = []

    for i in range(n_pixels):
        n = bytes_to_short(data[pos + offset + 1], data[pos + offset])
        pos += 2

        sector = np.frombuffer(data, dtype=INT32, count=n, offset=offset + pos)
        pos += 2 * n

        # FIXME:
        # according to a comment in the c-sources
        # there is might be an old bug here,
        # which is trailing zeros.
        # is an ascending list of numbes, so any zero
        # after the first position indicates the end of sector.
        #
        # DN: maybe this bug was fixed long ago,
        # so maybe we do not have to account for it here
        # I will check for it in the tests.
        sectors.append(sector)

    return sectors, pos
