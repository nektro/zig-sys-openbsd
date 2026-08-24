const std = @import("std");
const builtin = @import("builtin");
const arch = builtin.target.cpu.arch;

comptime {
    std.debug.assert(builtin.target.os.tag == .openbsd);
    std.debug.assert(@bitSizeOf(usize) == 64);
}

pub const errno = struct {
    pub const Error = error{
        Unexpected,
        EPERM,
        ENOENT,
        ESRCH,
        EINTR,
        EIO,
        ENXIO,
        E2BIG,
        ENOEXEC,
        EBADF,
        ECHILD,
        EDEADLK,
        ENOMEM,
        EACCES,
        EFAULT,
        ENOTBLK,
        EBUSY,
        EEXIST,
        EXDEV,
        ENODEV,
        ENOTDIR,
        EISDIR,
        EINVAL,
        ENFILE,
        EMFILE,
        ENOTTY,
        ETXTBSY,
        EFBIG,
        ENOSPC,
        ESPIPE,
        EROFS,
        EMLINK,
        EPIPE,
        EDOM,
        ERANGE,
        EAGAIN,
        EINPROGRESS,
        EALREADY,
        ENOTSOCK,
        EDESTADDRREQ,
        EMSGSIZE,
        EPROTOTYPE,
        ENOPROTOOPT,
        EPROTONOSUPPORT,
        ESOCKTNOSUPPORT,
        EOPNOTSUPP,
        EPFNOSUPPORT,
        EAFNOSUPPORT,
        EADDRINUSE,
        EADDRNOTAVAIL,
        ENETDOWN,
        ENETUNREACH,
        ENETRESET,
        ECONNABORTED,
        ECONNRESET,
        ENOBUFS,
        EISCONN,
        ENOTCONN,
        ESHUTDOWN,
        ETOOMANYREFS,
        ETIMEDOUT,
        ECONNREFUSED,
        ELOOP,
        ENAMETOOLONG,
        EHOSTDOWN,
        EHOSTUNREACH,
        ENOTEMPTY,
        EPROCLIM,
        EUSERS,
        EDQUOT,
        ESTALE,
        EREMOTE,
        EBADRPC,
        ERPCMISMATCH,
        EPROGUNAVAIL,
        EPROGMISMATCH,
        EPROCUNAVAIL,
        ENOLCK,
        ENOSYS,
        EFTYPE,
        EAUTH,
        ENEEDAUTH,
        EIPSEC,
        ENOATTR,
        EILSEQ,
        ENOMEDIUM,
        EMEDIUMTYPE,
        EOVERFLOW,
        ECANCELED,
        EIDRM,
        ENOMSG,
        ENOTSUP,
        EBADMSG,
        ENOTRECOVERABLE,
        EOWNERDEAD,
        EPROTO,
    };

    pub const Enum = enum(c_ushort) {
        EPERM = 1,
        ENOENT = 2,
        ESRCH = 3,
        EINTR = 4,
        EIO = 5,
        ENXIO = 6,
        E2BIG = 7,
        ENOEXEC = 8,
        EBADF = 9,
        ECHILD = 10,
        EDEADLK = 11,
        ENOMEM = 12,
        EACCES = 13,
        EFAULT = 14,
        ENOTBLK = 15,
        EBUSY = 16,
        EEXIST = 17,
        EXDEV = 18,
        ENODEV = 19,
        ENOTDIR = 20,
        EISDIR = 21,
        EINVAL = 22,
        ENFILE = 23,
        EMFILE = 24,
        ENOTTY = 25,
        ETXTBSY = 26,
        EFBIG = 27,
        ENOSPC = 28,
        ESPIPE = 29,
        EROFS = 30,
        EMLINK = 31,
        EPIPE = 32,
        EDOM = 33,
        ERANGE = 34,
        EAGAIN = 35,
        EINPROGRESS = 36,
        EALREADY = 37,
        ENOTSOCK = 38,
        EDESTADDRREQ = 39,
        EMSGSIZE = 40,
        EPROTOTYPE = 41,
        ENOPROTOOPT = 42,
        EPROTONOSUPPORT = 43,
        ESOCKTNOSUPPORT = 44,
        EOPNOTSUPP = 45,
        EPFNOSUPPORT = 46,
        EAFNOSUPPORT = 47,
        EADDRINUSE = 48,
        EADDRNOTAVAIL = 49,
        ENETDOWN = 50,
        ENETUNREACH = 51,
        ENETRESET = 52,
        ECONNABORTED = 53,
        ECONNRESET = 54,
        ENOBUFS = 55,
        EISCONN = 56,
        ENOTCONN = 57,
        ESHUTDOWN = 58,
        ETOOMANYREFS = 59,
        ETIMEDOUT = 60,
        ECONNREFUSED = 61,
        ELOOP = 62,
        ENAMETOOLONG = 63,
        EHOSTDOWN = 64,
        EHOSTUNREACH = 65,
        ENOTEMPTY = 66,
        EPROCLIM = 67,
        EUSERS = 68,
        EDQUOT = 69,
        ESTALE = 70,
        EREMOTE = 71,
        EBADRPC = 72,
        ERPCMISMATCH = 73,
        EPROGUNAVAIL = 74,
        EPROGMISMATCH = 75,
        EPROCUNAVAIL = 76,
        ENOLCK = 77,
        ENOSYS = 78,
        EFTYPE = 79,
        EAUTH = 80,
        ENEEDAUTH = 81,
        EIPSEC = 82,
        ENOATTR = 83,
        EILSEQ = 84,
        ENOMEDIUM = 85,
        EMEDIUMTYPE = 86,
        EOVERFLOW = 87,
        ECANCELED = 88,
        EIDRM = 89,
        ENOMSG = 90,
        ENOTSUP = 91,
        EBADMSG = 92,
        ENOTRECOVERABLE = 93,
        EOWNERDEAD = 94,
        EPROTO = 95,

        pub const EWOULDBLOCK: Enum = .EAGAIN;
    };

    comptime {
        // assert Enum is sequential
        var value: c_ushort = 0; // SUCCESS
        for (std.enums.values(Enum)) |val| {
            std.debug.assert(@intFromEnum(val) > value);
            value = @intFromEnum(val);
        }
    }
    comptime {
        // sanity test
        std.debug.assert(@intFromEnum(Enum.EPERM) == 1);
    }
    const list = blk: {
        const values = std.enums.values(Enum);
        const len = @intFromEnum(values[values.len - 1]) + 1;
        var errors: [len]Error = @splat(error.Unexpected);
        for (values) |f| errors[@intFromEnum(f)] = @field(Error, @tagName(f));
        const final = errors;
        break :blk final;
    };
    pub fn fromInt(code: c_int) Error {
        @setRuntimeSafety(false);
        if (code >= list.len) return error.Unexpected;
        if (code <= 0) return error.Unexpected;
        return list[@intCast(code)];
    }
    pub fn fromLibC() c_int {
        return libc.__errno().*;
    }
};

pub const eai = struct {
    pub const Error = error{
        EAI_BADFLAGS,
        EAI_NONAME,
        EAI_AGAIN,
        EAI_FAIL,
        EAI_NODATA,
        EAI_FAMILY,
        EAI_SOCKTYPE,
        EAI_SERVICE,
        EAI_ADDRFAMILY,
        EAI_MEMORY,
        EAI_SYSTEM,
        EAI_BADHINTS,
        EAI_PROTOCOL,
        EAI_OVERFLOW,
    };

    pub const Enum = enum(c_int) {
        EAI_BADFLAGS = -1,
        EAI_NONAME = -2,
        EAI_AGAIN = -3,
        EAI_FAIL = -4,
        EAI_NODATA = -5,
        EAI_FAMILY = -6,
        EAI_SOCKTYPE = -7,
        EAI_SERVICE = -8,
        EAI_ADDRFAMILY = -9,
        EAI_MEMORY = -10,
        EAI_SYSTEM = -11,
        EAI_BADHINTS = -12,
        EAI_PROTOCOL = -13,
        EAI_OVERFLOW = -14,
    };

    pub fn fromInt(code: c_int) Error {
        return switch (@as(Enum, @enumFromInt(code))) {
            .EAI_BADFLAGS => error.EAI_BADFLAGS,
            .EAI_NONAME => error.EAI_NONAME,
            .EAI_AGAIN => error.EAI_AGAIN,
            .EAI_FAIL => error.EAI_FAIL,
            .EAI_NODATA => error.EAI_NODATA,
            .EAI_FAMILY => error.EAI_FAMILY,
            .EAI_SOCKTYPE => error.EAI_SOCKTYPE,
            .EAI_SERVICE => error.EAI_SERVICE,
            .EAI_ADDRFAMILY => error.EAI_ADDRFAMILY,
            .EAI_MEMORY => error.EAI_MEMORY,
            .EAI_SYSTEM => error.EAI_SYSTEM,
            .EAI_BADHINTS => error.EAI_BADHINTS,
            .EAI_PROTOCOL => error.EAI_PROTOCOL,
            .EAI_OVERFLOW => error.EAI_OVERFLOW,
        };
    }
};

pub const libc = struct {
    pub extern fn __errno() *c_int;
    pub extern fn pipe2(pipefd: *[2]c_int, flag: c_int) c_int;
    pub extern fn openat(fd: c_int, file: [*:0]const u8, oflag: c_int, ...) c_int;
    pub extern fn close(fildes: c_int) c_int;
    pub extern fn fork() pid_t;
    pub extern fn dup2(fildes: c_int, fildes2: c_int) c_int;
    pub extern fn _exit(status: c_int) noreturn;
    pub extern fn fchdir(fildes: c_int) c_int;
    pub extern fn execvp(file: [*:0]const u8, argv: [*:null]const ?[*:0]const u8) c_int;
    pub extern fn kill(pid: pid_t, sig: c_int) c_int;
    pub extern fn poll(fds: [*]struct_pollfd, nfds: nfds_t, timeout: c_int) c_int;
    pub extern fn read(fd: c_int, buf: [*]u8, count: usize) isize;
    pub extern fn write(fd: c_int, buf: *const anyopaque, n: usize) isize;
    pub extern fn waitpid(pid: pid_t, stat_loc: ?*c_int, options: c_int) pid_t;
    pub extern fn getenv(name: [*:0]const u8) ?[*:0]const u8;
    pub extern fn exit(status: c_int) noreturn;
    pub extern fn mkdirat(fd: c_int, path: [*:0]const u8, mode: mode_t) c_int;
    pub extern fn fstatat(fd: c_int, noalias path: [*:0]const u8, noalias buf: *struct_stat, flag: c_int) c_int;
    pub extern fn getaddrinfo(noalias nodename: ?[*:0]const u8, noalias servname: ?[*:0]const u8, noalias hints: ?*const struct_addrinfo, noalias res: **const struct_addrinfo) c_int;
    pub extern fn freeaddrinfo(ai: *const struct_addrinfo) void;
    pub extern fn socket(domain: c_int, type: c_int, protocol: c_int) c_int;
    pub extern fn connect(socket: c_int, address: *const struct_sockaddr, address_len: socklen_t) c_int;
    pub extern fn arc4random_buf(buf: [*]u8, n: usize) void;
    pub extern fn pthread_mutex_init(mutex: *pthread_mutex_t, attr: ?*const pthread_mutexattr_t) c_int;
    pub extern fn pthread_mutex_destroy(mutex: *pthread_mutex_t) c_int;
    pub extern fn pthread_mutex_lock(mutex: *pthread_mutex_t) c_int;
    pub extern fn pthread_mutex_trylock(mutex: *pthread_mutex_t) c_int;
    pub extern fn pthread_mutex_unlock(mutex: *pthread_mutex_t) c_int;
    pub extern fn pthread_cond_init(noalias cond: *pthread_cond_t, noalias attr: ?*const pthread_condattr_t) c_int;
    pub extern fn pthread_cond_destroy(cond: *pthread_cond_t) c_int;
    pub extern fn pthread_cond_wait(noalias cond: *pthread_cond_t, noalias mutex: *pthread_mutex_t) c_int;
    pub extern fn pthread_cond_timedwait(noalias cond: *pthread_cond_t, noalias mutex: *pthread_mutex_t, noalias abstime: *const struct_timespec) c_int;
    pub extern fn pthread_cond_signal(cond: *pthread_cond_t) c_int;
    pub extern fn pthread_cond_broadcast(cond: *pthread_cond_t) c_int;
    pub extern fn pthread_rwlock_init(noalias rwlock: *pthread_rwlock_t, noalias attr: ?*const pthread_rwlockattr_t) c_int;
    pub extern fn pthread_rwlock_destroy(rwlock: *pthread_rwlock_t) c_int;
    pub extern fn pthread_rwlock_rdlock(rwlock: *pthread_rwlock_t) c_int;
    pub extern fn pthread_rwlock_tryrdlock(rwlock: *pthread_rwlock_t) c_int;
    pub extern fn pthread_rwlock_wrlock(rwlock: *pthread_rwlock_t) c_int;
    pub extern fn pthread_rwlock_trywrlock(rwlock: *pthread_rwlock_t) c_int;
    pub extern fn pthread_rwlock_unlock(rwlock: *pthread_rwlock_t) c_int;
    pub extern fn clock_gettime(clock_id: clockid_t, tp: *struct_timespec) c_int;
    pub extern fn renameat(oldfd: c_int, old: [*:0]const u8, newfd: c_int, new: [*:0]const u8) c_int;
    pub extern fn send(fd: c_int, buffer: [*]const u8, length: usize, flags: c_int) isize;
    pub extern fn recv(fd: c_int, buffer: [*]u8, length: usize, flags: c_int) isize;
    pub extern fn fstat(fd: c_int, buf: *struct_stat) c_int;
    pub extern fn mmap(addr: ?*anyopaque, len: usize, prot: c_int, flags: c_int, fd: c_int, offset: off_t) *allowzero anyopaque;
    pub extern fn writev(fd: c_int, iovec: [*]const struct_iovec, count: c_int) isize;
    pub extern fn faccessat(fd: c_int, path: [*:0]const u8, amode: c_int, flag: c_int) c_int;
    pub extern fn readlinkat(fd: c_int, noalias path: [*:0]const u8, noalias buf: [*]u8, len: usize) isize;
    pub extern fn futimens(fd: c_int, times: *const [2]struct_timespec) c_int;
    pub extern fn setsockopt(fd: c_int, level: c_int, optname: c_int, optval: *const anyopaque, optlen: socklen_t) c_int;
    pub extern fn bind(socket: c_int, address: *const struct_sockaddr, address_len: socklen_t) c_int;
    pub extern fn listen(socket: c_int, backlog: c_int) c_int;
    pub extern fn getsockname(fd: c_int, noalias addr: *struct_sockaddr, noalias len: *socklen_t) c_int;
    pub extern fn pthread_attr_init(attr: *pthread_attr_t) c_int;
    pub extern fn pthread_attr_destroy(attr: *pthread_attr_t) c_int;
    pub extern fn pthread_attr_setguardsize(attr: *pthread_attr_t, guardsize: usize) c_int;
    pub extern fn pthread_attr_setstacksize(attr: *pthread_attr_t, stacksize: usize) c_int;
    pub extern fn pthread_create(noalias newthread: *pthread_t, noalias attr: *const pthread_attr_t, start_routine: *const fn (*anyopaque) callconv(.c) ?*anyopaque, noalias arg: *anyopaque) c_int;
    pub extern fn pthread_detach(thread: pthread_t) c_int;
    pub extern fn pthread_join(thread: pthread_t, retval: ?*?*anyopaque) c_int;
    pub extern fn munmap(addr: *const anyopaque, len: usize) c_int;
    pub extern fn getdents(dirfd: c_int, buf: [*]u8, nbytes: usize) c_int;
    pub extern fn accept4(socket: c_int, noalias address: ?*struct_sockaddr, noalias address_len: *socklen_t, flags: c_int) c_int;
    pub extern fn shutdown(socket: c_int, how: c_int) c_int;
    pub extern fn unlinkat(fd: c_int, name: [*:0]const u8, flag: c_int) c_int;
};

pub const blkcnt_t = i64;
pub const blksize_t = i32;
pub const clock_t = i64;
pub const clockid_t = i32;
pub const cpuid_t = c_ulong;
pub const dev_t = i32;
pub const fixpt_t = u32;
pub const fsblkcnt_t = u64;
pub const fsfilcnt_t = u64;
pub const gid_t = u32;
pub const id_t = u32;
pub const in_addr_t = u32;
pub const in_port_t = u16;
pub const ino_t = u64;
pub const key_t = c_long;
pub const mode_t = u32;
pub const nlink_t = u32;
pub const off_t = i64;
pub const pid_t = i32;
pub const rlim_t = u64;
pub const sa_family_t = u8;
pub const segsz_t = i32;
pub const socklen_t = u32;
pub const suseconds_t = c_long;
pub const time_t = i64;
pub const timer_t = i32;
pub const uid_t = u32;
pub const useconds_t = u32;
pub const struct_pollfd = extern struct { fd: c_int, events: c_short, revents: c_short };
pub const nfds_t = c_uint;
pub const struct_stat = extern struct { mode: mode_t, dev: dev_t, ino: ino_t, nlink: nlink_t, uid: uid_t, gid: gid_t, rdev: dev_t, atim: struct_timespec, mtim: struct_timespec, ctim: struct_timespec, size: off_t, blocks: blkcnt_t, blksize: blksize_t, flags: u32, gen: u32, birthtim: struct_timespec };
pub const struct_timespec = extern struct { sec: time_t, nsec: c_long };
pub const struct_iovec = extern struct { base: [*]u8, len: usize };
pub const struct_in_addr = extern struct { addr: in_addr_t };
pub const struct_in6_addr = extern struct { addr: extern union { a8: [16]u8, a16: [8]u16, a32: [4]u32 } };
pub const struct_sockaddr = extern struct { len: u8, family: AF, data: [14]u8 };
pub const struct_sockaddr_in = extern struct { len: u8 = 16, family: AF = .INET, port: in_port_t, addr: struct_in_addr, zero: [8]u8 = @splat(0) };
pub const struct_sockaddr_in6 = extern struct { len: u8 = 28, family: AF = .INET6, port: in_port_t, flowinfo: u32, addr: struct_in6_addr, scope_id: u32 };
pub const struct_sockaddr_un = extern struct { len: u8 = 106, family: AF = .UNIX, path: [104]u8 };
comptime {
    std.debug.assert(@sizeOf(struct_sockaddr_in) == 16);
    std.debug.assert(@sizeOf(struct_sockaddr_in6) == 28);
    std.debug.assert(@sizeOf(struct_sockaddr_un) == 106);
}
pub const struct_addrinfo = extern struct { flags: c_int, family: c_int, socktype: c_int, protocol: c_int, addrlen: socklen_t, addr: ?*struct_sockaddr, canonname: ?[*:0]u8, next: ?*struct_addrinfo };
pub const struct_dirent = extern struct { fileno: ino_t, off: off_t, reclen: u16, type: DT, namlen: u8, padding: [4]u8, name: [NAME_MAX + 1]u8 };
pub const struct_timeval = extern struct { sec: time_t, usec: suseconds_t };

const impdef = @cImport({
    @cInclude("pthread.h");
});
pub const pthread_t = impdef.pthread_t;
pub const pthread_attr_t = impdef.pthread_attr_t;
pub const pthread_mutexattr_t = impdef.pthread_mutexattr_t;
pub const pthread_mutex_t = impdef.pthread_mutex_t;
pub const pthread_condattr_t = impdef.pthread_condattr_t;
pub const pthread_cond_t = impdef.pthread_cond_t;
pub const pthread_rwlockattr_t = impdef.pthread_rwlockattr_t;
pub const pthread_rwlock_t = impdef.pthread_rwlock_t;

pub const INT_MAX = std.math.maxInt(c_int);
pub const UINT_MAX = std.math.maxInt(c_uint);
pub const ARG_MAX = (512 * 1024);
pub const CHILD_MAX = 80;
pub const LINK_MAX = 32767;
pub const MAX_CANON = 255;
pub const MAX_INPUT = 255;
pub const NAME_MAX = 255;
pub const NGROUPS_MAX = 16;
pub const OPEN_MAX = 64;
pub const PATH_MAX = 1024;
pub const PIPE_BUF = 512;
pub const SYMLINK_MAX = PATH_MAX;
pub const SYMLOOP_MAX = 32;
pub const BC_BASE_MAX = INT_MAX;
pub const BC_DIM_MAX = 65535;
pub const BC_SCALE_MAX = INT_MAX;
pub const BC_STRING_MAX = INT_MAX;
pub const COLL_WEIGHTS_MAX = 2;
pub const EXPR_NEST_MAX = 32;
pub const LINE_MAX = 2048;
pub const RE_DUP_MAX = 255;
pub const SEM_VALUE_MAX = UINT_MAX;

pub const O = struct {
    pub const RDONLY = 0x0000;
    pub const WRONLY = 0x0001;
    pub const RDWR = 0x0002;
    pub const ACCMODE = 0x0003;
    pub const NONBLOCK = 0x0004;
    pub const APPEND = 0x0008;
    pub const SHLOCK = 0x0010;
    pub const EXLOCK = 0x0020;
    pub const ASYNC = 0x0040;
    pub const FSYNC = 0x0080;
    pub const SYNC = 0x0080;
    pub const DSYNC = SYNC;
    pub const RSYNC = SYNC;
    pub const NOFOLLOW = 0x0100;
    pub const CREAT = 0x0200;
    pub const TRUNC = 0x0400;
    pub const EXCL = 0x0800;
    pub const NOCTTY = 0x8000;
    pub const CLOEXEC = 0x10000;
    pub const DIRECTORY = 0x20000;
    pub const CLOFORK = 0x40000;
};

pub const AT = struct {
    pub const FDCWD = -100;
    pub const EACCESS = 0x01;
    pub const SYMLINK_NOFOLLOW = 0x02;
    pub const SYMLINK_FOLLOW = 0x04;
    pub const REMOVEDIR = 0x08;
};

pub const SIG = struct {
    pub const HUP = 1;
    pub const INT = 2;
    pub const QUIT = 3;
    pub const ILL = 4;
    pub const TRAP = 5;
    pub const ABRT = 6;
    pub const IOT = ABRT;
    pub const EMT = 7;
    pub const FPE = 8;
    pub const KILL = 9;
    pub const BUS = 10;
    pub const SEGV = 11;
    pub const SYS = 12;
    pub const PIPE = 13;
    pub const ALRM = 14;
    pub const TERM = 15;
    pub const URG = 16;
    pub const STOP = 17;
    pub const TSTP = 18;
    pub const CONT = 19;
    pub const CHLD = 20;
    pub const TTIN = 21;
    pub const TTOU = 22;
    pub const IO = 23;
    pub const XCPU = 24;
    pub const XFSZ = 25;
    pub const VTALRM = 26;
    pub const PROF = 27;
    pub const WINCH = 28;
    pub const INFO = 29;
    pub const USR1 = 30;
    pub const USR2 = 31;
    pub const THR = 32;
};

pub const POLL = struct {
    pub const IN = 0x0001;
    pub const PRI = 0x0002;
    pub const OUT = 0x0004;
    pub const ERR = 0x0008;
    pub const HUP = 0x0010;
    pub const NVAL = 0x0020;
    pub const RDNORM = 0x0040;
    pub const NORM = RDNORM;
    pub const WRNORM = OUT;
    pub const RDBAND = 0x0080;
    pub const WRBAND = 0x0100;
};

pub const W = struct {
    pub const NOHANG = 0x01;
    pub const UNTRACED = 0x02;
    pub const CONTINUED = 0x08;
    pub const EXITED = 0x04;
    pub const STOPPED = UNTRACED;
    pub const NOWAIT = 0x10;
    pub const TRAPPED = 0x20;
    pub const _STOPPED = 0o177;
    pub const _CONTINUED = 0o177777;
    pub const COREFLAG = 0o200;

    pub fn _STATUS(x: c_int) u8 {
        return @intCast(x & 0o177);
    }
    pub fn IFSTOPPED(x: c_int) bool {
        return (x & 0xff) == _STOPPED;
    }
    pub fn STOPSIG(x: c_int) u8 {
        return @truncate(@as(c_uint, @bitCast(x >> 8)));
    }
    pub fn IFSIGNALED(x: c_int) bool {
        return _STATUS(x) != _STOPPED and _STATUS(x) != 0;
    }
    pub fn TERMSIG(x: c_int) u8 {
        return _STATUS(x);
    }
    pub fn IFEXITED(x: c_int) bool {
        return _STATUS(x) == 0;
    }
    pub fn EXITSTATUS(x: c_int) u8 {
        return @truncate(@as(c_uint, @bitCast(x >> 8)));
    }
    pub fn IFCONTINUED(x: c_int) bool {
        return (x & _CONTINUED) == _CONTINUED;
    }
    pub fn COREDUMP(x: c_int) u8 {
        return x & COREFLAG;
    }
    pub fn _EXITCODE(r: c_int, s: c_int) c_int {
        return r << 8 | s;
    }
    pub fn _STOPCODE(s: c_int) c_int {
        return s << 8 | _STOPPED;
    }
};

pub const S = struct {
    pub const ISUID = 0o004000;
    pub const ISGID = 0o002000;
    pub const ISTXT = 0o001000;
    pub const IRWXU = 0o000700;
    pub const IRUSR = 0o000400;
    pub const IWUSR = 0o000200;
    pub const IXUSR = 0o000100;
    pub const IREAD = IRUSR;
    pub const IWRITE = IWUSR;
    pub const IEXEC = IXUSR;
    pub const IRWXG = 0o000070;
    pub const IRGRP = 0o000040;
    pub const IWGRP = 0o000020;
    pub const IXGRP = 0o000010;
    pub const IRWXO = 0o000007;
    pub const IROTH = 0o000004;
    pub const IWOTH = 0o000002;
    pub const IXOTH = 0o000001;
    pub const IFMT = 0o170000;
    pub const IFIFO = 0o010000;
    pub const IFCHR = 0o020000;
    pub const IFDIR = 0o040000;
    pub const IFBLK = 0o060000;
    pub const IFREG = 0o100000;
    pub const IFLNK = 0o120000;
    pub const IFSOCK = 0o140000;
    pub const ISVTX = 0o001000;
};

pub const AF = enum(sa_family_t) {
    UNSPEC = 0,
    UNIX = 1,
    INET = 2,
    IMPLINK = 3,
    PUP = 4,
    CHAOS = 5,
    NS = 6,
    ISO = 7,
    ECMA = 8,
    DATAKIT = 9,
    CCITT = 10,
    SNA = 11,
    DECnet = 12,
    DLI = 13,
    LAT = 14,
    HYLINK = 15,
    APPLETALK = 16,
    ROUTE = 17,
    LINK = 18,
    XTP = 19,
    COIP = 20,
    CNT = 21,
    RTIP = 22,
    IPX = 23,
    INET6 = 24,
    PIP = 25,
    ISDN = 26,
    NATM = 27,
    ENCAP = 28,
    SIP = 29,
    KEY = 30,
    HDRCMPLT = 31,
    BLUETOOTH = 32,
    MPLS = 33,
    PFLOW = 34,
    PIPEX = 35,
    FRAME = 36,

    pub const LOCAL: AF = .UNIX;
    pub const OSI: AF = .ISO;
    pub const E164: AF = .ISDN;
};

pub const SOCK = struct {
    pub const STREAM = 1;
    pub const DGRAM = 2;
    pub const RAW = 3;
    pub const RDM = 4;
    pub const SEQPACKET = 5;
    pub const CLOEXEC = 0x8000;
    pub const NONBLOCK = 0x4000;
    pub const DNS = 0x1000;
    pub const CLOFORK = 0x0800;
};

pub const IPPROTO = struct {
    pub const IP = 0;
    pub const HOPOPTS = IP;
    pub const ICMP = 1;
    pub const IGMP = 2;
    pub const GGP = 3;
    pub const IPIP = 4;
    pub const IPV4 = IPIP;
    pub const TCP = 6;
    pub const EGP = 8;
    pub const PUP = 12;
    pub const UDP = 17;
    pub const IDP = 22;
    pub const TP = 29;
    pub const IPV6 = 41;
    pub const ROUTING = 43;
    pub const FRAGMENT = 44;
    pub const RSVP = 46;
    pub const GRE = 47;
    pub const ESP = 50;
    pub const AH = 51;
    pub const MOBILE = 55;
    pub const ICMPV6 = 58;
    pub const NONE = 59;
    pub const DSTOPTS = 60;
    pub const EON = 80;
    pub const ETHERIP = 97;
    pub const ENCAP = 98;
    pub const PIM = 103;
    pub const IPCOMP = 108;
    pub const CARP = 112;
    pub const SCTP = 132;
    pub const UDPLITE = 136;
    pub const MPLS = 137;
    pub const PFSYNC = 240;
    pub const RAW = 255;
};

pub const CLOCK = enum(clockid_t) {
    REALTIME = 0,
    PROCESS_CPUTIME_ID = 2,
    MONOTONIC = 3,
    THREAD_CPUTIME_ID = 4,
    UPTIME = 5,
    BOOTTIME = 6,
    _,
};

pub const SOL = struct {
    pub const SOCKET = 0xffff;
};

pub const SO = struct {
    pub const DEBUG = 0x0001;
    pub const ACCEPTCONN = 0x0002;
    pub const REUSEADDR = 0x0004;
    pub const KEEPALIVE = 0x0008;
    pub const DONTROUTE = 0x0010;
    pub const BROADCAST = 0x0020;
    pub const USELOOPBACK = 0x0040;
    pub const LINGER = 0x0080;
    pub const OOBINLINE = 0x0100;
    pub const REUSEPORT = 0x0200;
    pub const TIMESTAMP = 0x0800;
    pub const BINDANY = 0x1000;
    pub const ZEROIZE = 0x2000;
    pub const SNDBUF = 0x1001;
    pub const RCVBUF = 0x1002;
    pub const SNDLOWAT = 0x1003;
    pub const RCVLOWAT = 0x1004;
    pub const SNDTIMEO = 0x1005;
    pub const RCVTIMEO = 0x1006;
    pub const ERROR = 0x1007;
    pub const TYPE = 0x1008;
    pub const RTABLE = 0x1021;
    pub const PEERCRED = 0x1022;
    pub const SPLICE = 0x1023;
    pub const DOMAIN = 0x1024;
    pub const PROTOCOL = 0x1025;
};

pub const DT = enum(u8) {
    UNKNOWN = 0,
    FIFO = 1,
    CHR = 2,
    DIR = 4,
    BLK = 6,
    REG = 8,
    LNK = 10,
    SOCK = 12,
};

pub const SHUT = enum(c_int) {
    RD = 0,
    WR = 1,
    RDWR = 2,
};

pub const MAP = struct {
    pub const SHARED = 0x0001;
    pub const PRIVATE = 0x0002;
    pub const FIXED = 0x0010;
    pub const NOREPLACE = 0x0800;
    pub const ANON = 0x1000;
    pub const ANONYMOUS = ANON;
    pub const NOFAULT = 0x2000;
    pub const STACK = 0x4000;
    pub const CONCEAL = 0x8000;
    pub const FAILED = -1;
};

pub const PROT = struct {
    pub const NONE = 0x00;
    pub const READ = 0x01;
    pub const WRITE = 0x02;
    pub const EXEC = 0x04;
};

pub fn pipe2(flag: c_int) ![2]c_int {
    var fildes: [2]c_int = @splat(-1);
    const rc = libc.pipe2(&fildes, flag);
    if (rc == -1) return errno.fromInt(errno.fromLibC());
    std.debug.assert(rc == 0);
    return fildes;
}
pub fn openat(fd: c_int, file: [*:0]const u8, oflag: c_int) errno.Error!c_int {
    const rc = libc.openat(fd, file, oflag);
    if (rc == -1) return errno.fromInt(errno.fromLibC());
    std.debug.assert(rc >= 0);
    return rc;
}
pub fn openat4(fd: c_int, file: [*:0]const u8, oflag: c_int, mode: mode_t) errno.Error!c_int {
    const rc = libc.openat(fd, file, oflag, mode);
    if (rc == -1) return errno.fromInt(errno.fromLibC());
    return rc;
}
pub fn close(fd: c_int) errno.Error!void {
    const rc = libc.close(fd);
    if (rc == -1) return errno.fromInt(errno.fromLibC());
    std.debug.assert(rc == 0);
}
pub fn fork() !pid_t {
    const rc = libc.fork();
    if (rc == -1) return errno.fromInt(errno.fromLibC());
    std.debug.assert(rc >= 0);
    return rc;
}
pub fn dup2(fildes: c_int, fildes2: c_int) !void {
    const rc = libc.dup2(fildes, fildes2);
    if (rc == -1) return errno.fromInt(errno.fromLibC());
    std.debug.assert(rc >= 0);
}
pub fn fchdir(fildes: c_int) !void {
    const rc = libc.fchdir(fildes);
    if (rc == -1) return errno.fromInt(errno.fromLibC());
    std.debug.assert(rc == 0);
}
pub fn execvp(file: [*:0]const u8, argv: [*:null]const ?[*:0]const u8) !noreturn {
    const rc = libc.execvp(file, argv);
    std.debug.assert(rc == -1);
    return errno.fromInt(errno.fromLibC());
}
pub fn kill(pid: pid_t, sig: c_int) !void {
    const rc = libc.kill(pid, sig);
    if (rc == -1) return errno.fromInt(errno.fromLibC());
    std.debug.assert(rc == 0);
}
pub fn poll(fds: []struct_pollfd, timeout_ms: c_int) !c_int {
    const rc = libc.poll(fds.ptr, @intCast(fds.len), timeout_ms);
    if (rc == -1) return errno.fromInt(errno.fromLibC());
    std.debug.assert(rc >= 0);
    return rc;
}
pub fn read(fd: c_int, buf: []u8) errno.Error!usize {
    const rc = libc.read(fd, buf.ptr, buf.len);
    if (rc == -1) return errno.fromInt(errno.fromLibC());
    std.debug.assert(rc >= 0);
    return @intCast(rc);
}
pub fn write(fd: c_int, buf: []const u8) !usize {
    const rc = libc.write(fd, buf.ptr, buf.len);
    if (rc == -1) return errno.fromInt(errno.fromLibC());
    std.debug.assert(rc >= 0);
    return @intCast(rc);
}
pub fn waitpid(pid: pid_t, options: c_int) !struct { pid_t, c_int } {
    var status: c_int = 0;
    const rc = libc.waitpid(pid, &status, options);
    if (rc == -1) return errno.fromInt(errno.fromLibC());
    std.debug.assert(rc >= 0);
    return .{ rc, status };
}
pub fn getenv(name: [:0]const u8) ?[:0]const u8 {
    return std.mem.sliceTo(libc.getenv(name.ptr) orelse return null, 0);
}
pub fn exit(status: c_int) noreturn {
    return libc.exit(status);
}
pub fn mkdirat(fd: c_int, path: [*:0]const u8, mode: mode_t) errno.Error!void {
    const rc = libc.mkdirat(fd, path, mode);
    if (rc == -1) return errno.fromInt(errno.fromLibC());
    std.debug.assert(rc == 0);
}
pub fn fstatat(fd: c_int, path: [*:0]const u8, flag: c_int) errno.Error!struct_stat {
    var buf: struct_stat = undefined;
    const rc = libc.fstatat(fd, path, &buf, flag);
    if (rc == -1) return errno.fromInt(errno.fromLibC());
    std.debug.assert(rc == 0);
    return buf;
}
pub fn getaddrinfo(noalias nodename: ?[*:0]const u8, noalias servname: ?[*:0]const u8, noalias req: ?*const struct_addrinfo) eai.Error!*const struct_addrinfo {
    var pai: *const struct_addrinfo = undefined;
    var hints = std.mem.zeroes(struct_addrinfo);
    const rc = libc.getaddrinfo(nodename, servname, req orelse &hints, &pai);
    if (rc < 0) return eai.fromInt(rc);
    std.debug.assert(rc == 0);
    return pai;
}
pub fn freeaddrinfo(ai: *const struct_addrinfo) void {
    return libc.freeaddrinfo(ai);
}
pub fn socket(domain: AF, ty: c_int, protocol: c_int) errno.Error!c_uint {
    const rc = libc.socket(@intFromEnum(domain), ty, protocol);
    if (rc == -1) return errno.fromInt(errno.fromLibC());
    std.debug.assert(rc > 0);
    return @intCast(rc);
}
pub fn connect(socketfd: c_uint, address: *const struct_sockaddr, address_len: socklen_t) errno.Error!void {
    const rc = libc.connect(@intCast(socketfd), address, address_len);
    if (rc == -1) return errno.fromInt(errno.fromLibC());
    std.debug.assert(rc == 0);
}
pub fn clock_gettime(clock_id: CLOCK) !struct_timespec {
    var tp: struct_timespec = undefined;
    const rc = libc.clock_gettime(@intFromEnum(clock_id), &tp);
    if (rc == -1) return errno.fromInt(errno.fromLibC());
    std.debug.assert(rc == 0);
    return tp;
}
pub fn renameat(oldfd: c_int, old: [*:0]const u8, newfd: c_int, new: [*:0]const u8) !void {
    const rc = libc.renameat(oldfd, old, newfd, new);
    if (rc == -1) return errno.fromInt(errno.fromLibC());
    std.debug.assert(rc == 0);
}
pub fn send(socketfd: c_uint, buffer: []const u8, flags: c_int) errno.Error!usize {
    const rc = libc.send(@intCast(socketfd), buffer.ptr, buffer.len, flags);
    if (rc == -1) return errno.fromInt(errno.fromLibC());
    std.debug.assert(rc >= 0);
    return @intCast(rc);
}
pub fn recv(socketfd: c_uint, buffer: []u8, flags: c_int) errno.Error!usize {
    const rc = libc.recv(@intCast(socketfd), buffer.ptr, buffer.len, flags);
    if (rc == -1) return errno.fromInt(errno.fromLibC());
    std.debug.assert(rc >= 0);
    return @intCast(rc);
}
pub fn fstat(fd: c_int) errno.Error!struct_stat {
    var buf: struct_stat = undefined;
    const rc = libc.fstat(fd, &buf);
    if (rc == -1) return errno.fromInt(errno.fromLibC());
    std.debug.assert(rc == 0);
    return buf;
}
pub fn mmap(addr: ?*anyopaque, len: usize, prot: c_int, flags: c_int, fd: c_int, offset: off_t) errno.Error![]u8 {
    const rc = libc.mmap(addr, len, prot, flags, fd, offset);
    if (@intFromPtr(rc) == MAP.FAILED) return errno.fromInt(errno.fromLibC());
    const ptr: [*]u8 = @ptrCast(rc);
    return ptr[0..len];
}
pub fn writev(fd: c_int, iovec: []const struct_iovec) !usize {
    const rc = libc.writev(fd, iovec.ptr, @intCast(iovec.len));
    if (rc == -1) return errno.fromInt(errno.fromLibC());
    std.debug.assert(rc >= 0);
    return @intCast(rc);
}
pub fn faccessat(fd: c_int, path: [*:0]const u8, amode: c_int, flag: c_int) !void {
    const rc = libc.faccessat(fd, path, amode, flag);
    if (rc == -1) return errno.fromInt(errno.fromLibC());
    std.debug.assert(rc == 0);
}
pub fn readlinkat(dirfd: c_int, noalias path: [*:0]const u8, noalias buf: []u8) ![:0]u8 {
    const rc = libc.readlinkat(dirfd, path, buf.ptr, buf.len);
    if (rc == -1) return errno.fromInt(errno.fromLibC());
    std.debug.assert(rc >= 0);
    buf[@intCast(rc)] = 0;
    return buf[0..@intCast(rc) :0];
}
pub fn futimens(fd: c_int, times: [2]struct_timespec) !void {
    const rc = libc.futimens(fd, &times);
    if (rc == -1) return errno.fromInt(errno.fromLibC());
    std.debug.assert(rc == 0);
}
pub fn setsockopt(socketfd: c_uint, level: c_int, optname: c_int, opaque_opt: []const u8) errno.Error!void {
    const rc = libc.setsockopt(@intCast(socketfd), level, optname, opaque_opt.ptr, @intCast(opaque_opt.len));
    if (rc == -1) return errno.fromInt(errno.fromLibC());
    std.debug.assert(rc == 0);
}
pub fn bind(socketfd: c_uint, address: *const struct_sockaddr, address_len: socklen_t) errno.Error!void {
    const rc = libc.bind(@intCast(socketfd), address, address_len);
    if (rc == -1) return errno.fromInt(errno.fromLibC());
    std.debug.assert(rc == 0);
}
pub fn listen(socketfd: c_uint, backlog: c_int) errno.Error!void {
    const rc = libc.listen(@intCast(socketfd), backlog);
    if (rc == -1) return errno.fromInt(errno.fromLibC());
    std.debug.assert(rc == 0);
}
pub fn getsockname(socketfd: c_uint, noalias address: *struct_sockaddr, noalias address_len: *socklen_t) errno.Error!void {
    const rc = libc.getsockname(@intCast(socketfd), address, address_len);
    if (rc == -1) return errno.fromInt(errno.fromLibC());
    std.debug.assert(rc == 0);
}
pub fn munmap(addr: *const anyopaque, len: usize) errno.Error!void {
    const rc = libc.munmap(addr, len);
    if (rc == -1) return errno.fromInt(errno.fromLibC());
    std.debug.assert(rc == 0);
}
pub fn getdents(dirfd: c_int, buf: []u8) errno.Error!usize {
    const rc = libc.getdents(dirfd, buf.ptr, buf.len);
    if (rc == -1) return errno.fromInt(errno.fromLibC());
    std.debug.assert(rc >= 0);
    return @intCast(rc);
}
pub fn accept4(socketfd: c_uint, noalias address: ?*struct_sockaddr, noalias address_len: *socklen_t, flags: c_int) errno.Error!c_uint {
    const rc = libc.accept4(@intCast(socketfd), address, address_len, flags);
    if (rc == -1) return errno.fromInt(errno.fromLibC());
    std.debug.assert(rc > 0);
    return @intCast(rc);
}
pub fn shutdown(socketfd: c_uint, how: SHUT) errno.Error!void {
    const rc = libc.shutdown(@intCast(socketfd), @intFromEnum(how));
    if (rc == -1) return errno.fromInt(errno.fromLibC());
    std.debug.assert(rc == 0);
}
pub fn unlinkat(fd: c_int, name: [*:0]const u8, flag: c_int) !void {
    const rc = libc.unlinkat(fd, name, flag);
    if (rc == -1) return errno.fromInt(errno.fromLibC());
    std.debug.assert(rc == 0);
}
