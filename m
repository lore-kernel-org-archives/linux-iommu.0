From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v9 05/13] iommu/amd: Add function copy_dev_tables()
Date: Fri, 4 Aug 2017 20:21:24 +0800
Message-ID: <20170804122124.GJ1874@x1>
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

Hi Joerg,

Thanks for your reviewing!

On 08/04/17 at 02:09pm, Joerg Roedel wrote:
> Hi Baoquan,
> 
> On Tue, Aug 01, 2017 at 07:37:21PM +0800, Baoquan He wrote:
> > +	for_each_iommu(iommu) {
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
> > +
> > +		if (copied)
> > +			continue;
> > +
> > +		old_devtb_phys = entry & PAGE_MASK;
> > +		old_devtb = memremap(old_devtb_phys, dev_table_size, MEMREMAP_WB);
> > +		if (!old_devtb)
> > +			return -1;
> 
> You forgot to check whether the old device table is also below 4GB.

I did it in patch 10/13. I think it's an sub-issue and can be explained
in a specific patch.

Thanks
Baoquan
