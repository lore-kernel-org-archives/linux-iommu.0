From: Sergey Senozhatsky <sergey.senozhatsky.work-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 07/17] debugobjects: Move printk out of db lock
	critical sections
Date: Mon, 26 Nov 2018 13:57:09 +0900
Message-ID: <20181126045709.GD540@jagdpanzerIV>
References: <1542653726-5655-1-git-send-email-longman@redhat.com>
	<1542653726-5655-8-git-send-email-longman@redhat.com>
	<2ddd9e3d-951e-1892-c941-54be80f7e6aa@redhat.com>
	<20181122020422.GA3441@jagdpanzerIV>
	<20181122101606.GP2131@hirez.programming.kicks-ass.net>
	<20181123024048.GD1582@jagdpanzerIV>
	<20181123114826.h27t7qiwfp7grrqx@pathway.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20181123114826.h27t7qiwfp7grrqx-KsEp0d+Q8qECVLCxKZUutA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Petr Mladek <pmladek-IBi9RG/b67k@public.gmane.org>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sergey Senozhatsky <sergey.senozhatsky-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kasan-dev-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Ingo Molnar <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Steven Rostedt <rostedt-nx8X9YLhiw1AfugRpC6u6w@public.gmane.org>, Andrey Ryabinin <aryabinin-5HdwGun5lf+gSpxsJD1C4w@public.gmane.org>, Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Waiman Long <longman-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On (11/23/18 12:48), Petr Mladek wrote:
[..]
> > This should make serial consoles re-entrant.
> > So printk->console_driver_write() hopefully will not deadlock.
> 
> Is the re-entrance safe? Some risk might be acceptable in Oops/panic
> situations. It is much less acceptable for random warnings.

Good question.

But what's the alternative? A deadlock in a serial console driver; such
that even panic() is not guaranteed to make through it (at least of now).
debug objects are used from the code which cannot re-entrant console
drivers.

bust_spinlock is called from various paths, not only panic.
git grep bust_spinlocks | wc -l
62

So we already switch to re-entrant consoles (and accept the risks) in
mm/fault.c, kernel/traps.c and so on. Which, I guess, makes us a little
more confident, faults/traps happen often enough.

It seems, that, more or less, serial consoles are ready to handle it.
UART consoles in ->write() callbacks just do a bunch of writel() [for
every char + \r\n].

	-ss
