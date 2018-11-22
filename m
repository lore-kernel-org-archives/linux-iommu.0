From: Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Subject: Re: [PATCH v2 07/17] debugobjects: Move printk out of db lock
	critical sections
Date: Thu, 22 Nov 2018 11:16:06 +0100
Message-ID: <20181122101606.GP2131@hirez.programming.kicks-ass.net>
References: <1542653726-5655-1-git-send-email-longman@redhat.com>
	<1542653726-5655-8-git-send-email-longman@redhat.com>
	<2ddd9e3d-951e-1892-c941-54be80f7e6aa@redhat.com>
	<20181122020422.GA3441@jagdpanzerIV>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20181122020422.GA3441@jagdpanzerIV>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Sergey Senozhatsky <sergey.senozhatsky.work-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Petr Mladek <pmladek-IBi9RG/b67k@public.gmane.org>, Sergey Senozhatsky <sergey.senozhatsky-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kasan-dev-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Ingo Molnar <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Andrey Ryabinin <aryabinin-5HdwGun5lf+gSpxsJD1C4w@public.gmane.org>, Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Waiman Long <longman-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, Nov 22, 2018 at 11:04:22AM +0900, Sergey Senozhatsky wrote:
> Some serial consoles call mod_timer(). So what we could have with the
> debug objects enabled was
> 
> 	mod_timer()
> 	 lock_timer_base()
> 	  debug_activate()
> 	   printk()
> 	    call_console_drivers()
> 	     foo_console()
> 	      mod_timer()
> 	       lock_timer_base()       << deadlock
> 
> That's one possible scenario. The other one can involve console's
> IRQ handler, uart port spinlock, mod_timer, debug objects, printk,
> and an eventual deadlock on the uart port spinlock. This one can
> be mitigated with printk_safe. But mod_timer() deadlock will require
> a different fix.
> 
> So maybe we need to switch debug objects print-outs to _always_
> printk_deferred(). Debug objects can be used in code which cannot
> do direct printk() - timekeeping is just one example.

No, printk_deferred() is a disease, it needs to be eradicated, not
spread around.
