From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 02/13] iommu: Introduce Interface for IOMMU TLB Flushing
Date: Fri, 18 Aug 2017 16:16:10 +0100
Message-ID: <20170818151610.GA7900@arm.com>
References: <1502974596-23835-1-git-send-email-joro@8bytes.org>
	<1502974596-23835-3-git-send-email-joro@8bytes.org>
	<20170817163234.GB30719@arm.com> <20170817165040.GK2853@suse.de>
	<20170817171704.GD30719@arm.com> <20170817212054.GL2853@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170817212054.GL2853-l3A5Bk7waGM@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Joerg,

On Thu, Aug 17, 2017 at 11:20:54PM +0200, Joerg Roedel wrote:
> On Thu, Aug 17, 2017 at 06:17:05PM +0100, Will Deacon wrote:
> > On Thu, Aug 17, 2017 at 06:50:40PM +0200, Joerg Roedel wrote:
> > > Problem currently is how to get this information from
> > > 'struct iommu_device' to 'struct iommu_domain'. As a workaround I
> > > consider a per-domain flag in the iommu drivers which checks whether any
> > > unmap has happened and just do nothing on the flush-call-back if there
> > > were none.
> > 
> > Given that this can all happen concurrently, I really don't like the idea of
> > having to track things with a flag. We'd end up introducing atomics and/or
> > over-invalidating the TLBs.
> 
> Okay, I look into a better solution for that.

Thanks. One possibility is that IOMMU drivers requiring TLB invalidation on
->map can set a flag on the domain when they allocate it, which the IOMMU
core can test for later on.

> > We don't actually tend to see issues adding the TLB invalidation commands
> > under the lock -- the vast majority of the overhead comes from the SYNC.
> > Besides, I don't see how adding the commands in the ->iotlb_range_add
> > callback is any better: it still happens on unmap and it still needs to
> > take the lock.
> 
> With the deferred flushing you don't flush anything in the unmap path in
> most cases.  All you do there is to add the unmapped iova-range to a
> per-cpu list (its actually a ring-buffer). Only when that buffer is full
> you do a flush_tlb_all() on the domain and then free all the iova
> ranges.
> 
> With the flush-counters you can also see which entries in your buffer
> have already been flushed from the IO/TLB by another CPU, so that you
> can release them right away without any further flush. This way its less
> likely that the buffer fills up.
> 
> In my tests on x86 I got the flush-rate down to ~1800 flushes/sec at a
> network packet rate of 1.45 million pps.
> 
> > There are a few reasons I'm not rushing to move to the deferred flushing
> > code for ARM:
> > 
> >   1. The performance numbers we have suggest that we can achieve near-native
> >      performance without needing to do that.
> 
> Hard to believe when all CPUs fight for the cmd-buffer lock, especially
> when you have around 96 CPUs :) Can you share the performance numbers
> you have and what you measured?

I can only point to numbers that have already been posted to the list, but
the numbers in this thread here are promising:

https://marc.info/?i=c1d85f28-c57b-4414-3504-16afb3a19ce0%40codeaurora.org

Note that patch 1 in that series doesn't remove the locking, it just removes
the heavy barrier instruction after advancing the queue pointer (and we
can easily do that with your series, deferring it to the sync).

As I said, if the locking does turn out to be a problem and this is backed
up by profiling data, then I'll look into it, but at the moment it doesn't
appear to be the case.

Just a thought, but if we could return a token from unmap to pass to the
TLB invalidation functions, then it would be possible to do a spin_trylock
on the command queue lock in ->unmap. If you get the lock, then you put the
command in, if you don't then you set something in the token and the
add_range would see that flag and insert the commands then.

> >   2. We can free page-table pages in unmap, but that's not safe if we defer
> >      flushing
> 
> Right, VT-d has the same problem and solved it with a free-list of pages
> that is passed to the deferred flushing code. When the IO/TLB is flushed
> it calls back into the driver which then frees the pages.

There are some situations where we cannot defer. For example, if we map 2MB
at the PMD level in the page table, but 4k of that region is then unmapped.
In this case, we have to allocate a new level but we cannot plumb it into
the table without performing (and completing) TLB maintenance.

> >   3. Flushing the whole TLB is undesirable and not something we currently
> >      need to do
> 
> Is the TLB-refill cost higher than the time needed to add a
> flush-command for every unmapped range?

The TLB-refill cost is likely to be significantly higher for an SMMU than
the CPU, because the TLBs tend to be distributed with a centralised table
walker. Furthermore, doing an invalidate-all on a domain may cause other
masters in the domain to miss a deadline, which is a common complaint we've
had from graphics folks in the past (who basically pin their buffers and
rely on never missing).

> >   4. There are security implications of deferring the unmap and I'm aware
> >      of a security research group that use this to gain root privileges.
> 
> Interesting, can you share more about that?

Unfortunately, the paper isn't public yet so I can't say more right now.
When it's published, I'll point you to it!

> >   5. *If* performance figures end up showing that deferring the flush is
> >      worthwhile, I would rather use an RCU-based approach for protecting
> >      the page tables, like we do on the CPU.
> 
> Yeah, I don't like the entry_dtor_cb() I introduced for that very much, so if
> there are better solutions I am all ears.

I think it should be possible to protect the page tables with RCU and then
run the TLB invalidation, freeing and IOVA reclaim as part of the callback.
It's not simple to implement, though, because you run into concurrency
issues where the callback can run in parallel with unmappers etc.

Will
