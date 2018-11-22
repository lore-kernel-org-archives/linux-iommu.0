From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v2 07/17] debugobjects: Move printk out of db lock
 critical sections
Date: Thu, 22 Nov 2018 15:29:35 -0500
Message-ID: <fd006ace-f339-34c2-d87f-51f145ac8364@redhat.com>
References: <1542653726-5655-1-git-send-email-longman@redhat.com>
 <1542653726-5655-8-git-send-email-longman@redhat.com>
 <2ddd9e3d-951e-1892-c941-54be80f7e6aa@redhat.com>
 <20181122020422.GA3441@jagdpanzerIV>
 <20181122160250.lxyfzsybfwskrh54@pathway.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181122160250.lxyfzsybfwskrh54@pathway.suse.cz>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>, Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: iommu@lists.linux-foundation.org

On 11/22/2018 11:02 AM, Petr Mladek wrote:
> On Thu 2018-11-22 11:04:22, Sergey Senozhatsky wrote:
>> On (11/21/18 11:49), Waiman Long wrote:
>> [..]
>>>>  	case ODEBUG_STATE_ACTIVE:
>>>> -		debug_print_object(obj, "init");
>>>>  		state = obj->state;
>>>>  		raw_spin_unlock_irqrestore(&db->lock, flags);
>>>> +		debug_print_object(obj, "init");
>>>>  		debug_object_fixup(descr->fixup_init, addr, state);
>>>>  		return;
>>>>  
>>>>  	case ODEBUG_STATE_DESTROYED:
>>>> -		debug_print_object(obj, "init");
>>>> +		debug_printobj = true;
>>>>  		break;
>>>>  	default:
>>>>  		break;
>>>>  	}
>>>>  
>>>>  	raw_spin_unlock_irqrestore(&db->lock, flags);
>>>> +	if (debug_chkstack)
>>>> +		debug_object_is_on_stack(addr, onstack);
>>>> +	if (debug_printobj)
>>>> +		debug_print_object(obj, "init");
>>>>
>> [..]
>>> As a side note, one of the test systems that I used generated a
>>> debugobjects splat in the bootup process and the system hanged
>>> afterward. Applying this patch alone fix the hanging problem and the
>>> system booted up successfully. So it is not really a good idea to call
>>> printk() while holding a raw spinlock.
> Please, was the system hang reproducible? I wonder if it was a
> deadlock described by Sergey below.

Yes, it is 100% reproducible on the testing system that I used.

> The commit message is right. printk() might take too long and
> cause softlockup or livelock. But it does not explain why
> the system could competely hang.
>
> Also note that prinkt() should not longer block a single process
> indefinitely thanks to the commit dbdda842fe96f8932 ("printk:
> Add console owner and waiter logic to load balance console writes").

The problem might have been caused by the fact that IRQ was also
disabled in the lock critical section.

>> Some serial consoles call mod_timer(). So what we could have with the
>> debug objects enabled was
>>
>> 	mod_timer()
>> 	 lock_timer_base()
>> 	  debug_activate()
>> 	   printk()
>> 	    call_console_drivers()
>> 	     foo_console()
>> 	      mod_timer()
>> 	       lock_timer_base()       << deadlock
> Anyway, I wonder what was the primary motivation for this patch.
> Was it the system hang? Or was it lockdep report about nesting
> two terminal locks: db->lock, pool_lock with logbuf_lock?

The primary motivation was to make sure that printk() won't be called
while holding either db->lock or pool_lock in the debugobjects code. In
the determination of which locks can be made terminal, I focused on
local spinlocks that won't cause boundary to an unrelated subsystem as
it will greatly complicate the analysis.

I didn't realize that it fixed a hang problem that I was seeing until I
did bisection to find out that it was caused by the patch that cause the
debugobjects splat in the first place a few days ago. I was comparing
the performance status of the pre and post patched kernel. The pre-patch
kernel failed to boot in the one of my test systems, but the
post-patched kernel could. I narrowed it down to this patch as the fix
for the hang problem.

Cheers,
Longman
