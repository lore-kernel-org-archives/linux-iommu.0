From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 08/17] locking/lockdep: Add support for nestable
 terminal locks
Date: Fri, 7 Dec 2018 10:22:52 +0100
Message-ID: <20181207092252.GF2237@hirez.programming.kicks-ass.net>
References: <1542653726-5655-1-git-send-email-longman@redhat.com>
 <1542653726-5655-9-git-send-email-longman@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1542653726-5655-9-git-send-email-longman@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Waiman Long <longman@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>, Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, Nov 19, 2018 at 01:55:17PM -0500, Waiman Long wrote:
> There are use cases where we want to allow nesting of one terminal lock
> underneath another terminal-like lock. That new lock type is called
> nestable terminal lock which can optionally allow the acquisition of
> no more than one regular (non-nestable) terminal lock underneath it.

I think I asked for a more coherent changelog on this. The above is
still self contradictory and doesn't explain why you'd ever want such a
'misfeature' :-)
