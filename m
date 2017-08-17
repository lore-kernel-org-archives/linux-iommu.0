From: Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH 02/13] iommu: Introduce Interface for IOMMU TLB Flushing
Date: Thu, 17 Aug 2017 23:20:54 +0200
Message-ID: <20170817212054.GL2853@suse.de>
References: <1502974596-23835-1-git-send-email-joro@8bytes.org>
 <1502974596-23835-3-git-send-email-joro@8bytes.org>
 <20170817163234.GB30719@arm.com>
 <20170817165040.GK2853@suse.de>
 <20170817171704.GD30719@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170817171704.GD30719@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>, Alex Williamson <alex.williamson@redhat.com>, Robin Murphy <robin.murphy@arm.com>
List-Id: iommu@lists.linux-foundation.org

Hi Will,

On Thu, Aug 17, 2017 at 06:17:05PM +0100, Will Deacon wrote:
> On Thu, Aug 17, 2017 at 06:50:40PM +0200, Joerg Roedel wrote:
> > Problem currently is how to get this information from
> > 'struct iommu_device' to 'struct iommu_domain'. As a workaround I
> > consider a per-domain flag in the iommu drivers which checks whether any
> > unmap has happened and just do nothing on the flush-call-back if there
> > were none.
> 
> Given that this can all happen concurrently, I really don't like the idea of
> having to track things with a flag. We'd end up introducing atomics and/or
> over-invalidating the TLBs.

Okay, I look into a better solution for that.

> We don't actually tend to see issues adding the TLB invalidation commands
> under the lock -- the vast majority of the overhead comes from the SYNC.
> Besides, I don't see how adding the commands in the ->iotlb_range_add
> callback is any better: it still happens on unmap and it still needs to
> take the lock.

With the deferred flushing you don't flush anything in the unmap path in
most cases.  All you do there is to add the unmapped iova-range to a
per-cpu list (its actually a ring-buffer). Only when that buffer is full
you do a flush_tlb_all() on the domain and then free all the iova
ranges.

With the flush-counters you can also see which entries in your buffer
have already been flushed from the IO/TLB by another CPU, so that you
can release them right away without any further flush. This way its less
likely that the buffer fills up.

In my tests on x86 I got the flush-rate down to ~1800 flushes/sec at a
network packet rate of 1.45 million pps.

> There are a few reasons I'm not rushing to move to the deferred flushing
> code for ARM:
> 
>   1. The performance numbers we have suggest that we can achieve near-native
>      performance without needing to do that.

Hard to believe when all CPUs fight for the cmd-buffer lock, especially
when you have around 96 CPUs :) Can you share the performance numbers
you have and what you measured?

>   2. We can free page-table pages in unmap, but that's not safe if we defer
>      flushing

Right, VT-d has the same problem and solved it with a free-list of pages
that is passed to the deferred flushing code. When the IO/TLB is flushed
it calls back into the driver which then frees the pages.

>   3. Flushing the whole TLB is undesirable and not something we currently
>      need to do

Is the TLB-refill cost higher than the time needed to add a
flush-command for every unmapped range?

>   4. There are security implications of deferring the unmap and I'm aware
>      of a security research group that use this to gain root privileges.

Interesting, can you share more about that?

>   5. *If* performance figures end up showing that deferring the flush is
>      worthwhile, I would rather use an RCU-based approach for protecting
>      the page tables, like we do on the CPU.

Yeah, I don't like the entry_dtor_cb() I introduced for that very much, so if
there are better solutions I am all ears.


Regards,

	Joerg
