From: Petr Mladek <pmladek-IBi9RG/b67k@public.gmane.org>
Subject: Re: [PATCH v2 07/17] debugobjects: Move printk out of db lock
	critical sections
Date: Thu, 22 Nov 2018 17:02:50 +0100
Message-ID: <20181122160250.lxyfzsybfwskrh54@pathway.suse.cz>
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
Cc: Sergey Senozhatsky <sergey.senozhatsky-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kasan-dev-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Ingo Molnar <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Andrey Ryabinin <aryabinin-5HdwGun5lf+gSpxsJD1C4w@public.gmane.org>, Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Waiman Long <longman-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Thu 2018-11-22 11:04:22, Sergey Senozhatsky wrote:
> On (11/21/18 11:49), Waiman Long wrote:
> [..]
> > >  	case ODEBUG_STATE_ACTIVE:
> > > -		debug_print_object(obj, "init");
> > >  		state = obj->state;
> > >  		raw_spin_unlock_irqrestore(&db->lock, flags);
> > > +		debug_print_object(obj, "init");
> > >  		debug_object_fixup(descr->fixup_init, addr, state);
> > >  		return;
> > >  
> > >  	case ODEBUG_STATE_DESTROYED:
> > > -		debug_print_object(obj, "init");
> > > +		debug_printobj = true;
> > >  		break;
> > >  	default:
> > >  		break;
> > >  	}
> > >  
> > >  	raw_spin_unlock_irqrestore(&db->lock, flags);
> > > +	if (debug_chkstack)
> > > +		debug_object_is_on_stack(addr, onstack);
> > > +	if (debug_printobj)
> > > +		debug_print_object(obj, "init");
> > >
> [..]
> >
> > As a side note, one of the test systems that I used generated a
> > debugobjects splat in the bootup process and the system hanged
> > afterward. Applying this patch alone fix the hanging problem and the
> > system booted up successfully. So it is not really a good idea to call
> > printk() while holding a raw spinlock.

Please, was the system hang reproducible? I wonder if it was a
deadlock described by Sergey below.

The commit message is right. printk() might take too long and
cause softlockup or livelock. But it does not explain why
the system could competely hang.

Also note that prinkt() should not longer block a single process
indefinitely thanks to the commit dbdda842fe96f8932 ("printk:
Add console owner and waiter logic to load balance console writes").

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

Anyway, I wonder what was the primary motivation for this patch.
Was it the system hang? Or was it lockdep report about nesting
two terminal locks: db->lock, pool_lock with logbuf_lock?

Printk is problematic. It might delay any atomic context
where it is used. I would like to better understand the
problem here before we start spread printk-related hacks.

Best Regards,
Petr
