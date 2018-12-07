From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 09/17] debugobjects: Make object hash locks nestable
 terminal locks
Date: Fri, 7 Dec 2018 10:47:39 +0100
Message-ID: <20181207094739.GG2237@hirez.programming.kicks-ass.net>
References: <1542653726-5655-1-git-send-email-longman@redhat.com>
 <1542653726-5655-10-git-send-email-longman@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1542653726-5655-10-git-send-email-longman@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Waiman Long <longman@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>, Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, Nov 19, 2018 at 01:55:18PM -0500, Waiman Long wrote:
> By making the object hash locks nestable terminal locks, we can avoid
> a bunch of unnecessary lockdep validations as well as saving space
> in the lockdep tables.

So the 'problem'; which you've again not explained; is that debugobjects
has the following lock order:

	&db->lock
	  &pool_lock

And you seem to want to tag '&db->lock' as terminal, which is obviuosly
a big fat lie.

You've also not explained why it is safe to do this (I think it actually
is, but you really should've spelled it out).

Furthermore; you've not justified any of this 'insanity' with numbers.
What do we gain with this nestable madness that justifies the crazy?
