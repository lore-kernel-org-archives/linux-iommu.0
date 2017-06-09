From: Tomasz Figa <tfiga@chromium.org>
Subject: Re: [PATCH 02/12] intel-ipu3: mmu: implement driver
Date: Fri, 9 Jun 2017 14:59:10 +0900
Message-ID: <CAAFQd5DdeRV_N6apPDUoDW1CrOmOtgvyq-5BvCRzh2pM6vKx9w@mail.gmail.com>
References: <1496695157-19926-1-git-send-email-yong.zhi@intel.com>
 <1496695157-19926-3-git-send-email-yong.zhi@intel.com> <CAAFQd5BZGVBdbN-8L+pvAf4AkBkB9UFy7_mmMpusFUMxDugQDw@mail.gmail.com>
 <CAAFQd5CdV4ZfAYHH7DBBfOY=c4_Lwnuf8COs=JUKRSjp1VTn7Q@mail.gmail.com> <20170608164350.GH1019@valkosipuli.retiisi.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <20170608164350.GH1019@valkosipuli.retiisi.org.uk>
Sender: linux-media-owner@vger.kernel.org
To: Sakari Ailus <sakari.ailus@iki.fi>
Cc: Yong Zhi <yong.zhi@intel.com>, linux-media@vger.kernel.org, Sakari Ailus <sakari.ailus@linux.intel.com>, "Zheng, Jian Xu" <jian.xu.zheng@intel.com>, "Mani, Rajmohan" <rajmohan.mani@intel.com>, "Toivonen, Tuukka" <tuukka.toivonen@intel.com>, "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>, Joerg Roedel <joro@8bytes.org>
List-Id: iommu@lists.linux-foundation.org

On Fri, Jun 9, 2017 at 1:43 AM, Sakari Ailus <sakari.ailus@iki.fi> wrote:
> Hi Tomasz,
>
> On Wed, Jun 07, 2017 at 05:35:13PM +0900, Tomasz Figa wrote:
>> Hi Yong, Tuukka,
>>
>> Continuing from yesterday. Please see comments inline.
>>
>> > On Tue, Jun 6, 2017 at 5:39 AM, Yong Zhi <yong.zhi@intel.com> wrote:
>> [snip]
>> >> +       ptr = ipu3_mmu_alloc_page_table(mmu_dom, false);
>> >> +       if (!ptr)
>> >> +               goto fail_page_table;
>> >> +
>> >> +       /*
>> >> +        * We always map the L1 page table (a single page as well as
>> >> +        * the L2 page tables).
>> >> +        */
>> >> +       mmu_dom->dummy_l2_tbl = virt_to_phys(ptr) >> IPU3_MMU_PAGE_SHIFT;
>> >> +       mmu_dom->pgtbl = ipu3_mmu_alloc_page_table(mmu_dom, true);
>> >> +       if (!mmu_dom->pgtbl)
>> >> +               goto fail_page_table;
>> >> +
>> >> +       spin_lock_init(&mmu_dom->lock);
>> >> +       return &mmu_dom->domain;
>> >> +
>> >> +fail_page_table:
>> >> +       free_page((unsigned long)TBL_VIRT_ADDR(mmu_dom->dummy_page));
>> >> +       free_page((unsigned long)TBL_VIRT_ADDR(mmu_dom->dummy_l2_tbl));
>> >> +fail_get_page:
>> >> +       kfree(mmu_dom);
>> >> +       return NULL;
>> >> +}
>> >> +
>> >> +static void ipu3_mmu_domain_free(struct iommu_domain *dom)
>> >> +{
>> >> +       struct ipu3_mmu_domain *mmu_dom =
>> >> +               container_of(dom, struct ipu3_mmu_domain, domain);
>> >> +       uint32_t l1_idx;
>> >> +
>> >> +       for (l1_idx = 0; l1_idx < IPU3_MMU_L1PT_PTES; l1_idx++)
>> >> +               if (mmu_dom->pgtbl[l1_idx] != mmu_dom->dummy_l2_tbl)
>> >> +                       free_page((unsigned long)
>> >> +                                 TBL_VIRT_ADDR(mmu_dom->pgtbl[l1_idx]));
>> >> +
>> >> +       free_page((unsigned long)TBL_VIRT_ADDR(mmu_dom->dummy_page));
>> >> +       free_page((unsigned long)TBL_VIRT_ADDR(mmu_dom->dummy_l2_tbl));
>>
>> I might be overly paranoid, but reading back kernel virtual pointers
>> from device accessible memory doesn't seem safe to me. Other drivers
>> keep kernel pointers of page tables in a dedicated array (it's only 8K
>> of memory, but much better safety).
>
> Do you happen to have an example of that?

Hmm, looks like I misread rockchip-iommu code. Let me quietly back off
from this claim, sorry.

>
> All system memory typically is accessible for devices, I think you wanted to
> say that the device is intended to access that memory. Albeit for reading
> only.

Unless you activate DMAR and make only the memory you want to be
accessible to your devices. I know DMAR is a device too, but there is
a difference between a system level fixed function IOMMU and a PCI
device running a closed source firmware. Still, given Robin's reply,
current DMA and IOMMU frameworks might not be able to handle this
easily, so let's temporarily forget about this setup. We might revisit
it later, with incremental patches, anyway.

>
> ...
>
>> >> +static int ipu3_mmu_bus_remove(struct device *dev)
>> >> +{
>> >> +       struct ipu3_mmu *mmu = dev_get_drvdata(dev);
>> >> +
>> >> +       put_iova_domain(&mmu->iova_domain);
>> >> +       iova_cache_put();
>>
>> Don't we need to set the L1 table address to something invalid and
>> invalidate the TLB, so that the IOMMU doesn't reference the page freed
>> below anymore?
>
> I think the expectation is that if a device gets removed, its memory is
> unmapped by that time. Unmapping that memory will cause explicit TLB flush.

Right, but that will only mark the L2 entries as invalid. The L1 table
will still point to the L2 tables installed earlier and the MMU page
directory register will still point to the L1 table, despite the call
below freeing all the associated memory.

Best regards,
Tomasz
