From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v8 05/13] iommu/amd: Add function copy_dev_tables()
Date: Fri, 28 Jul 2017 11:59:15 +0800
Message-ID: <20170728035915.GH24304@x1>
References: <1500627551-12930-1-git-send-email-bhe@redhat.com>
 <1500627551-12930-6-git-send-email-bhe@redhat.com>
 <20170727152925.GL3610@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170727152925.GL3610@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <jroedel@suse.de>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On 07/27/17 at 05:29pm, Joerg Roedel wrote:
> On Fri, Jul 21, 2017 at 04:59:03PM +0800, Baoquan He wrote:
> > Add function copy_dev_tables to copy the old DEV table entries of the panicked
> 
> Since there is only one (for now), you can name the function in
> singular: copy_dev_table() or copy_device_table().

Make sense, will change it to copy_device_table(). Thanks.

> 
> > kernel to the new allocated DEV table. Since all iommus share the same DTE table
> > the copy only need be done one time. Besides, we also need to:
> > 
> >   - Check whether all IOMMUs actually use the same device table with the same size
> > 
> >   - Verify that the size of the old device table is the expected size.
> > 
> >   - Reserve the old domain id occupied in 1st kernel to avoid touching the old
> >     io-page tables. Then on-flight DMA can continue looking it up.
> > 
> > And also define MACRO DEV_DOMID_MASK to replace magic number 0xffffULL, it can be
> > reused in copy_dev_tables().
> > 
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> > ---
> >  drivers/iommu/amd_iommu.c       |  2 +-
> >  drivers/iommu/amd_iommu_init.c  | 55 +++++++++++++++++++++++++++++++++++++++++
> >  drivers/iommu/amd_iommu_types.h |  1 +
> >  3 files changed, 57 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
> > index e5a03f259986..4d00f1bda900 100644
> > --- a/drivers/iommu/amd_iommu.c
> > +++ b/drivers/iommu/amd_iommu.c
> > @@ -2086,7 +2086,7 @@ static void set_dte_entry(u16 devid, struct protection_domain *domain, bool ats)
> >  		flags    |= tmp;
> >  	}
> >  
> > -	flags &= ~(0xffffUL);
> > +	flags &= ~DEV_DOMID_MASK;
> >  	flags |= domain->id;
> >  
> >  	amd_iommu_dev_table[devid].data[1]  = flags;
> > diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
> > index f6da5fe03b31..c58f091ce232 100644
> > --- a/drivers/iommu/amd_iommu_init.c
> > +++ b/drivers/iommu/amd_iommu_init.c
> > @@ -842,6 +842,61 @@ static int get_dev_entry_bit(u16 devid, u8 bit)
> >  }
> >  
> >  
> > +static int copy_dev_tables(void)
> > +{
> > +	struct dev_table_entry *old_devtb = NULL;
> > +	u32 lo, hi, devid, old_devtb_size;
> > +	phys_addr_t old_devtb_phys;
> > +	u64 entry, last_entry = 0;
> > +	struct amd_iommu *iommu;
> > +	u16 dom_id, dte_v;
> > +	static int copied;
> > +
> > +	for_each_iommu(iommu) {
> > +		if (!translation_pre_enabled(iommu)) {
> > +			pr_err("IOMMU:%d is not pre-enabled!/n",
> > +				iommu->index);
> > +			return -1;
> > +		}
> > +
> > +		/* All IOMMUs should use the same device table with the same size */
> > +		lo = readl(iommu->mmio_base + MMIO_DEV_TABLE_OFFSET);
> > +		hi = readl(iommu->mmio_base + MMIO_DEV_TABLE_OFFSET + 4);
> > +		entry = (((u64) hi) << 32) + lo;
> > +		if (last_entry && last_entry != entry) {
> > +			pr_err("IOMMU:%d should use the same dev table as others!/n",
> > +				iommu->index);
> > +			return -1;
> > +		}
> > +		last_entry = entry;
> > +
> > +		old_devtb_size = ((entry & ~PAGE_MASK) + 1) << 12;
> > +		if (old_devtb_size != dev_table_size) {
> > +			pr_err("The device table size of IOMMU:%d is not expected!/n",
> > +				iommu->index);
> > +			return -1;
> > +		}
> 
> I think the loop can end here. There is only one table to copy, so you
> don't need to copy it for every iommu. Just do the checks in the loop
> and the copy once after the loop.

Ok, will change. I worried that device table addr might not be stored
into iommu register correctly. I am fine we only do the check only at
the first time.

> 
> > +
> > +		old_devtb_phys = entry & PAGE_MASK;
> > +		old_devtb = memremap(old_devtb_phys, dev_table_size, MEMREMAP_WB);
> > +		if (!old_devtb)
> > +			return -1;
> > +
> > +		if (copied)
> > +			continue;
> > +		for (devid = 0; devid <= amd_iommu_last_bdf; ++devid) {
> > +			amd_iommu_dev_table[devid] = old_devtb[devid];
> > +			dom_id = old_devtb[devid].data[1] & DEV_DOMID_MASK;
> > +			dte_v = old_devtb[devid].data[0] & DTE_FLAG_V;
> > +			if (dte_v && dom_id)
> > +				__set_bit(dom_id, amd_iommu_pd_alloc_bitmap);
> > +		}
> 
> Please only copy the DTE when DTE.V is set in the old table. Also

Sorry, the sanity check about DTE.V has been done in patch 7/13. I
should rewrite the subject and git log for patch 7/13.

> don't copy any of the IOMMUv2 enablement bits from the old DTE. PRI
> faults are recoverable by design and a device shouldn't fail on a
> negative answer from the IOMMU.

Yes, this is done in patch 11/13. Saw your comment in patch 11/13.

> 
