From: Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH 2/2] iommu/amd: Remove clear_flush_young notifier
Date: Fri, 1 Feb 2019 11:51:21 +0800
Message-ID: <20190201035121.GF25119@xz-x1>
References: <20190130055758.3994-1-peterx@redhat.com>
 <20190130055758.3994-3-peterx@redhat.com>
 <69af2b6f-bfc1-a4b9-675a-6fc93a7efef2@arm.com>
 <20190131075941.GB25119@xz-x1>
 <926c28c2-66a0-8068-f7bc-2d8f9ce9f0ad@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <926c28c2-66a0-8068-f7bc-2d8f9ce9f0ad@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc: Jerome Glisse <jglisse@redhat.com>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Jason Wang <jasowang@redhat.com>
List-Id: iommu@lists.linux-foundation.org

On Thu, Jan 31, 2019 at 12:25:40PM +0000, Jean-Philippe Brucker wrote:
> On 31/01/2019 07:59, Peter Xu wrote:
> > On Wed, Jan 30, 2019 at 12:27:40PM +0000, Jean-Philippe Brucker wrote:
> >> Hi Peter,
> > 
> > Hi, Jean,
> > 
> >>
> >> On 30/01/2019 05:57, Peter Xu wrote:
> >>> AMD IOMMU driver is using the clear_flush_young() to do cache flushing
> >>> but that's actually already covered by invalidate_range().  Remove the
> >>> extra notifier and the chunks.
> >>
> >> Aren't uses of clear_flush_young() and invalidate_range() orthogonal? If
> >> I understood correctly, when doing reclaim the kernel clears the young
> >> bit from the PTE. This requires flushing secondary TLBs (ATCs), so that
> >> new accesses from devices will go through the IOMMU, set the young bit
> >> again and the kernel can accurately track page use. I didn't see
> >> invalidate_range() being called by rmap or vmscan in this case, but
> >> might just be missing it.
> >>
> >> Two MMU notifiers are used for the young bit, clear_flush_young() and
> >> clear_young(). I believe the former should invalidate ATCs so that DMA
> >> accesses participate in PTE aging. Otherwise the kernel can't know that
> >> the device is still using entries marked 'old'. The latter,
> >> clear_young() is exempted from invalidating the secondary TLBs by
> >> mmu_notifier.h and the IOMMU driver doesn't need to implement it.
> > 
> > Yes I agree most of your analysis, but IMHO the problem is that the
> > AMD IOMMU is not really participating in the PTE aging after all.
> > Please have a look at mn_clear_flush_young() below at [1] - it's
> > always returning zero, no matter whether the page has been accessed by
> > device or not.  A real user of it could be someone like KVM (please
> > see kvm_mmu_notifier_clear_flush_young) where we'll try to lookup the
> > shadow PTEs and do test-and-clear on that, then return the result to
> > the core mm.  That's why I think currently the AMD driver was only
> > trying to use that as a way to do an extra flush however IMHO it's
> > redundant.
> 
> Yes, in IOMMU drivers clear_flush_young() doesn't do the clear, only the
> flush, since the level-1 page table is shared with the CPU. But removing
> the flush gets you in the following situation:
> 
>   (1) Devices wants to access $addr, sends ATS query, the IOMMU sets PTE
> young and the entry is cached in the ATC.
> 
>   (2) The CPU does ptep_clear_flush_young_notify(), clears young,
> notices that the page is being used.
> 
>   (3) Device accesses $addr again. Given that we didn't invalidate the
> ATC in (2) it accesses the page directly, without going through the IOMMU.
> 
>   (4) CPU does ptep_clear_flush_young_notify() again, the PTE doesn't
> have the young bit, which means the page isn't being used and can be
> reclaimed.
> 
> That's not accurate since the page is being used by the device. At step
> (2) we should invalidate the ATC, so that (3) fetches the PTE again and
> marks it young.
> 
> I can agree that the clear_flush_young() notifier is too brutal for this
> purpose, since we send spurious ATC invalidation even when the PTE
> wasn't young (and ATC inv is expensive). There should be another MMU
> notifier "flush_young()" that is called by
> ptep_clear_flush_young_notify() only when the page was actually young.
> But for the moment it's the best we have to avoid the situation above.
> 
> I don't know enough about mm to understand exactly how the
> page_referenced() information is used, but I believe the problem is only
> about accuracy and not correctness. So applying this patch might not
> break anything (after all, intel-svm.c never implemented the notifier)
> but I think I'll keep the notifier in my SVA rework [1].

I see your point.  I'm not an expert of mm either, but I'd say AFAIU
this happens in CPU TLB too.  Please have a look at
ptep_clear_flush_young():

int ptep_clear_flush_young(struct vm_area_struct *vma,
			   unsigned long address, pte_t *ptep)
{
	/*
	 * On x86 CPUs, clearing the accessed bit without a TLB flush
	 * doesn't cause data corruption. [ It could cause incorrect
	 * page aging and the (mistaken) reclaim of hot pages, but the
	 * chance of that should be relatively low. ]
	 *
	 * So as a performance optimization don't flush the TLB when
	 * clearing the accessed bit, it will eventually be flushed by
	 * a context switch or a VM operation anyway. [ In the rare
	 * event of it not getting flushed for a long time the delay
	 * shouldn't really matter because there's no real memory
	 * pressure for swapout to react to. ]
	 */
	return ptep_test_and_clear_young(vma, address, ptep);
}

So maybe it is a tradeoff between performance and accuracy.  IMHO the
IOMMU cache flushing might affect the performance even more than CPU
TLB flushing if the invalidation command takes a long time to run
(e.g., amd_iommu_flush_page is far slower than a TLB flush
instruction, locks to take, queue commands, explicit wait for the
invalidation to happen, etc.) so it can potentially even drag down the
mm young bit access as a whole not to mention the future cache misses
from the device side.

Even if you really want to make the young bit accurate for the SVA
work, IMHO you may still want to implement the lightweight version of
clear_young() too otherwise it might be inaccurate again in idle page
tracking.

Another thing to mention is that disregarding the discussion about
young bit - IMO you should probably don't need the change_pte() which
I'm more confident with.

Thanks,

> 
> Thanks,
> Jean
> 
> [1] https://www.spinics.net/lists/iommu/msg30081.html

-- 
Peter Xu
