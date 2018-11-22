From: Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH v2 09/17] debugobjects: Make object hash locks nestable
 terminal locks
Date: Thu, 22 Nov 2018 16:33:02 +0100
Message-ID: <20181122153302.y5vqovrsaigi6pte@pathway.suse.cz>
References: <1542653726-5655-1-git-send-email-longman@redhat.com>
 <1542653726-5655-10-git-send-email-longman@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1542653726-5655-10-git-send-email-longman@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Waiman Long <longman@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>, Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: iommu@lists.linux-foundation.org

On Mon 2018-11-19 13:55:18, Waiman Long wrote:
> By making the object hash locks nestable terminal locks, we can avoid
> a bunch of unnecessary lockdep validations as well as saving space
> in the lockdep tables.

Please, explain which terminal lock might be nested.

Hmm, it would hide eventual nesting of other terminal locks.
It might reduce lockdep reliability. I wonder if the space
optimization is worth it.

Finally, it might be good to add a short explanation what (nested)
terminal locks mean into each commit. It would help people to
understand the effect without digging into the lockdep code, ...

Best Regards,
Petr
