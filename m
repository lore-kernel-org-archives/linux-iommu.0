From: Sergey Senozhatsky <sergey.senozhatsky.work-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 07/17] debugobjects: Move printk out of db lock
	critical sections
Date: Fri, 23 Nov 2018 11:35:14 +0900
Message-ID: <20181123023514.GC1582@jagdpanzerIV>
References: <1542653726-5655-1-git-send-email-longman@redhat.com>
	<1542653726-5655-8-git-send-email-longman@redhat.com>
	<2ddd9e3d-951e-1892-c941-54be80f7e6aa@redhat.com>
	<20181122020422.GA3441@jagdpanzerIV>
	<c8c29a58-f356-d379-2bf4-cea09b03dc3e@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <c8c29a58-f356-d379-2bf4-cea09b03dc3e-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Waiman Long <longman-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Petr Mladek <pmladek-IBi9RG/b67k@public.gmane.org>, Sergey Senozhatsky <sergey.senozhatsky.work-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sergey Senozhatsky <sergey.senozhatsky-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kasan-dev-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Ingo Molnar <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Andrey Ryabinin <aryabinin-5HdwGun5lf+gSpxsJD1C4w@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On (11/22/18 14:57), Waiman Long wrote:
> > [..]
> >> As a side note, one of the test systems that I used generated a
> >> debugobjects splat in the bootup process and the system hanged
> >> afterward. Applying this patch alone fix the hanging problem and the
> >> system booted up successfully. So it is not really a good idea to call
> >> printk() while holding a raw spinlock.
> > Right, I like this patch.
> > And I think that we, maybe, can go even further.
> >
> > Some serial consoles call mod_timer(). So what we could have with the
> > debug objects enabled was
> >
> > 	mod_timer()
> > 	 lock_timer_base()
> > 	  debug_activate()
> > 	   printk()
> > 	    call_console_drivers()
> > 	     foo_console()
> > 	      mod_timer()
> > 	       lock_timer_base()       << deadlock
> >
> > That's one possible scenario. The other one can involve console's
> > IRQ handler, uart port spinlock, mod_timer, debug objects, printk,
> > and an eventual deadlock on the uart port spinlock. This one can
> > be mitigated with printk_safe. But mod_timer() deadlock will require
> > a different fix.
> >
> > So maybe we need to switch debug objects print-outs to _always_
> > printk_deferred(). Debug objects can be used in code which cannot
> > do direct printk() - timekeeping is just one example.
> =

> Actually, I don't think that was the cause of the hang.

Oh, I didn't suggest that this was the case. Just talked about more
problems with printk in debug objects. Serial consoles call mod_time,
mod_timer calls debug objects, debug objects call printk and end up
in serial console again. Serial consoles are not re-entrant at this
point.

> The debugobjects splat was caused by debug_object_is_on_stack(), below
> was the output:
>
> [=A0=A0=A0 6.890048] ODEBUG: object (____ptrval____) is NOT on stack
> (____ptrval____), but annotated.
> [=A0=A0=A0 6.891000] WARNING: CPU: 28 PID: 1 at lib/debugobjects.c:369
> __debug_object_init.cold.11+0x51/0x2d6
[..]
> =A0=A0 11.270654] systemd[1]: systemd 239 running in system mode. (+PAM
> +AUDIT +SELINUX +IMA -APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP
> +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD +IDN2 -IDN
> +PCRE2 default-hierarchy=3Dlegacy)
> [=A0=A0 11.311307] systemd[1]: Detected architecture x86-64.
> [=A0=A0 11.316420] systemd[1]: Running in initial RAM disk.
> =

> Welcome to
> =

> The system is not responsive at this point.
> =

> I am not totally sure what caused this.

Hmm, me neither.

	-ss
