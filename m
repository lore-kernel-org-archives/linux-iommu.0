From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v2 09/17] debugobjects: Make object hash locks nestable
 terminal locks
Date: Thu, 22 Nov 2018 15:17:52 -0500
Message-ID: <6879cb32-1d6e-79bd-04c2-8f7c09c48bfe@redhat.com>
References: <1542653726-5655-1-git-send-email-longman@redhat.com>
 <1542653726-5655-10-git-send-email-longman@redhat.com>
 <20181122153302.y5vqovrsaigi6pte@pathway.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181122153302.y5vqovrsaigi6pte@pathway.suse.cz>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Petr Mladek <pmladek@suse.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>, Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: iommu@lists.linux-foundation.org

On 11/22/2018 10:33 AM, Petr Mladek wrote:
> On Mon 2018-11-19 13:55:18, Waiman Long wrote:
>> By making the object hash locks nestable terminal locks, we can avoid
>> a bunch of unnecessary lockdep validations as well as saving space
>> in the lockdep tables.
> Please, explain which terminal lock might be nested.
>
> Hmm, it would hide eventual nesting of other terminal locks.
> It might reduce lockdep reliability. I wonder if the space
> optimization is worth it.
>
> Finally, it might be good to add a short explanation what (nested)
> terminal locks mean into each commit. It would help people to
> understand the effect without digging into the lockdep code, ...
>
> Best Regards,
> Petr

Nested terminal lock is currently only used in the debugobjects code. It
should only be used on a case-by-case basis. In the case of the
debugojects code, the locking patterns are:

(1)

raw_spin_lock(&db_lock);
...
raw_spin_unlock(&db_lock);

(2)

raw_spin_lock(&db_lock);
...
raw_spin_lock(&pool_lock);
...
raw_spin_unlock(&pool_lock);
...
raw_spin_unlock(&db_lock);

(3)

raw_spin_lock(&pool_lock);
...
raw_spin_unlock(&pool_lock);

So the db_lock is made to be nestable that it can allow acquisition of
pool_lock (a regular terminal lock) underneath it.

Cheers,
Longman
