From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v9 05/13] iommu/amd: Add function copy_dev_tables()
Date: Fri, 4 Aug 2017 20:30:39 +0800
Message-ID: <20170804123039.GK1874@x1>
References: <1501587449-9817-1-git-send-email-bhe@redhat.com>
 <1501587449-9817-6-git-send-email-bhe@redhat.com>
 <20170804120908.GT3431@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170804120908.GT3431@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <jroedel@suse.de>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On 08/04/17 at 02:09pm, Joerg Roedel wrote:
> 
> On Tue, Aug 01, 2017 at 07:37:21PM +0800, Baoquan He wrote:
> > +	for_each_iommu(iommu) {

	......

> > +		if (copied)
> > +			continue;
> > +
> > +		old_devtb_phys = entry & PAGE_MASK;
> > +		old_devtb = memremap(old_devtb_phys, dev_table_size, MEMREMAP_WB);
> > +		if (!old_devtb)
> > +			return -1;
> 
> You forgot to check whether the old device table is also below 4GB.
> 
> > +
> > +		gfp_flag = GFP_KERNEL | __GFP_ZERO;
> > +		old_dev_tbl_cpy = (void *)__get_free_pages(gfp_flag,
> > +					get_order(dev_table_size));
> > +		if (old_dev_tbl_cpy == NULL) {
> > +			pr_err("Failed to allocate memory for copying old device table!/n");
> > +			return -1;
> > +		}
> > +
> > +		for (devid = 0; devid <= amd_iommu_last_bdf; ++devid) {
> > +			old_dev_tbl_cpy[devid] = old_devtb[devid];
> > +			dom_id = old_devtb[devid].data[1] & DEV_DOMID_MASK;
> > +			dte_v = old_devtb[devid].data[0] & DTE_FLAG_V;
> > +			if (dte_v && dom_id)
> > +				__set_bit(dom_id, amd_iommu_pd_alloc_bitmap);
> > +		}
> > +		memunmap(old_devtb);
> > +		copied = 1;
> 
> And this one should be outside of the loop, then you can get rid of the
> 'copied' variable. Also I don't really understand why you need a
> temporary copy of the old device-table. Can't you just smart-copy the
> contents of the old table to the real new one?

Sorry, I don't get 'this one' meaning, are you suggesting the copy for
loop should be take out of the iommu for loop? 

About the temporary copy of the old device-table, you can see in patch
7/13, if irq sanity check failed, it return -1. This return could happen
in the middle of copy. So I think we should do a whole successful copy,
or don't copy at all. It might not be good do half copy.
