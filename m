From: Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH v2 07/17] debugobjects: Move printk out of db lock
 critical sections
Date: Fri, 23 Nov 2018 12:36:48 +0100
Message-ID: <20181123113648.6fieltetklnoex6v@pathway.suse.cz>
References: <1542653726-5655-1-git-send-email-longman@redhat.com>
 <1542653726-5655-8-git-send-email-longman@redhat.com>
 <2ddd9e3d-951e-1892-c941-54be80f7e6aa@redhat.com>
 <20181122020422.GA3441@jagdpanzerIV>
 <20181122160250.lxyfzsybfwskrh54@pathway.suse.cz>
 <fd006ace-f339-34c2-d87f-51f145ac8364@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <fd006ace-f339-34c2-d87f-51f145ac8364@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Waiman Long <longman@redhat.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>, Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: iommu@lists.linux-foundation.org

On Thu 2018-11-22 15:29:35, Waiman Long wrote:
> On 11/22/2018 11:02 AM, Petr Mladek wrote:
> > Anyway, I wonder what was the primary motivation for this patch.
> > Was it the system hang? Or was it lockdep report about nesting
> > two terminal locks: db->lock, pool_lock with logbuf_lock?
> 
> The primary motivation was to make sure that printk() won't be called
> while holding either db->lock or pool_lock in the debugobjects code. In
> the determination of which locks can be made terminal, I focused on
> local spinlocks that won't cause boundary to an unrelated subsystem as
> it will greatly complicate the analysis.

Then please mention this as the real reason in the commit message.

The reason that printk might take too long in IRQ context does
not explain why we need the patch. printk() is called in IRQ
context in many other locations. I do not see why this place
should be special. The delay is the price for the chance to
see the problem.


> I didn't realize that it fixed a hang problem that I was seeing until I
> did bisection to find out that it was caused by the patch that cause the
> debugobjects splat in the first place a few days ago. I was comparing
> the performance status of the pre and post patched kernel. The pre-patch
> kernel failed to boot in the one of my test systems, but the
> post-patched kernel could. I narrowed it down to this patch as the fix
> for the hang problem.

The hang is a mystery. My guess is that there is a race somewhere.
The patch might have reduced the race window but it probably did
not fix the race itself.

Best Regards,
Petr
