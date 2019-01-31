From: Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH 2/2] iommu/amd: Remove clear_flush_young notifier
Date: Thu, 31 Jan 2019 15:59:41 +0800
Message-ID: <20190131075941.GB25119@xz-x1>
References: <20190130055758.3994-1-peterx@redhat.com>
 <20190130055758.3994-3-peterx@redhat.com>
 <69af2b6f-bfc1-a4b9-675a-6fc93a7efef2@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <69af2b6f-bfc1-a4b9-675a-6fc93a7efef2@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Jerome Glisse <jglisse@redhat.com>, Jason Wang <jasowang@redhat.com>
List-Id: iommu@lists.linux-foundation.org

On Wed, Jan 30, 2019 at 12:27:40PM +0000, Jean-Philippe Brucker wrote:
> Hi Peter,

Hi, Jean,

> 
> On 30/01/2019 05:57, Peter Xu wrote:
> > AMD IOMMU driver is using the clear_flush_young() to do cache flushing
> > but that's actually already covered by invalidate_range().  Remove the
> > extra notifier and the chunks.
> 
> Aren't uses of clear_flush_young() and invalidate_range() orthogonal? If
> I understood correctly, when doing reclaim the kernel clears the young
> bit from the PTE. This requires flushing secondary TLBs (ATCs), so that
> new accesses from devices will go through the IOMMU, set the young bit
> again and the kernel can accurately track page use. I didn't see
> invalidate_range() being called by rmap or vmscan in this case, but
> might just be missing it.
> 
> Two MMU notifiers are used for the young bit, clear_flush_young() and
> clear_young(). I believe the former should invalidate ATCs so that DMA
> accesses participate in PTE aging. Otherwise the kernel can't know that
> the device is still using entries marked 'old'. The latter,
> clear_young() is exempted from invalidating the secondary TLBs by
> mmu_notifier.h and the IOMMU driver doesn't need to implement it.

Yes I agree most of your analysis, but IMHO the problem is that the
AMD IOMMU is not really participating in the PTE aging after all.
Please have a look at mn_clear_flush_young() below at [1] - it's
always returning zero, no matter whether the page has been accessed by
device or not.  A real user of it could be someone like KVM (please
see kvm_mmu_notifier_clear_flush_young) where we'll try to lookup the
shadow PTEs and do test-and-clear on that, then return the result to
the core mm.  That's why I think currently the AMD driver was only
trying to use that as a way to do an extra flush however IMHO it's
redundant.

Thanks,

> > -static int mn_clear_flush_young(struct mmu_notifier *mn,
> > -				struct mm_struct *mm,
> > -				unsigned long start,
> > -				unsigned long end)
> > -{
> > -	for (; start < end; start += PAGE_SIZE)
> > -		__mn_flush_page(mn, start);
> > -
> > -	return 0;

[1]

-- 
Peter Xu
