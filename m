From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v5 4/8] iommu/amd: Add function copy_dev_tables
Date: Tue, 20 Sep 2016 13:58:04 +0200
Message-ID: <20160920115804.GC3541@8bytes.org>
References: <1473951806-25511-1-git-send-email-bhe@redhat.com>
 <1473951806-25511-5-git-send-email-bhe@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1473951806-25511-5-git-send-email-bhe@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Baoquan He <bhe@redhat.com>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, kexec@lists.infradead.org, dyoung@redhat.com, xlpang@redhat.com, Vincent.Wan@amd.com
List-Id: iommu@lists.linux-foundation.org

Hi Baoquan,

On Thu, Sep 15, 2016 at 11:03:22PM +0800, Baoquan He wrote:
> +static int copy_dev_tables(void)
> +{
> +	u64 entry;
> +	u32 lo, hi, devid;
> +	phys_addr_t old_devtb_phys;
> +	struct dev_table_entry *old_devtb = NULL;
> +	u16 dom_id, dte_v;
> +	struct amd_iommu *iommu;
> +	static int copied;

Please order this by line-length, longer lines first.

> +        for_each_iommu(iommu) {
> +		if (!translation_pre_enabled(iommu)) {
> +			pr_err("IOMMU:%d is not pre-enabled!/n", iommu->index);
> +			return -1;
> +		}
> +
> +		if (copied)
> +			continue;
> +
> +                lo = readl(iommu->mmio_base + MMIO_DEV_TABLE_OFFSET);
> +                hi = readl(iommu->mmio_base + MMIO_DEV_TABLE_OFFSET + 4);
> +                entry = (((u64) hi) << 32) + lo;
> +                old_devtb_phys = entry & PAGE_MASK;
> +                old_devtb = memremap(old_devtb_phys, dev_table_size, MEMREMAP_WB);
> +		if (!old_devtb)
> +			return -1;
> +                for (devid = 0; devid <= amd_iommu_last_bdf; ++devid) {
> +                        amd_iommu_dev_table[devid] = old_devtb[devid];
> +                        dom_id = amd_iommu_dev_table[devid].data[1] & DEV_DOMID_MASK;
> +			dte_v = amd_iommu_dev_table[devid].data[0] & DTE_FLAG_V;
> +			if (!dte_v || !dom_id)
> +				continue;
> +                        __set_bit(dom_id, amd_iommu_pd_alloc_bitmap);
> +                }
> +		memunmap(old_devtb);
> +		copied = 1;
> +        }

This loop need more refinement and sanity checking code. I suggest using
two loops and do the sanity checking in the first one. The sanity checks
should do:

	* Check whether all IOMMUs actually use the same device table
	  with the same size

	* Verify that the size of the old device table is the expected
	  size.

	* Also sanity check the irq-remapping information and remapping
	  table sizes.

If any of these checks fail, just bail out of copying.

What is further needed it some more selection on what is copied from the
old kernel. There is no need to copy all the GCR3 root-pointer
information. If a device is set up with guest translations (DTE.GV=1),
then don't copy that information but move the device over to an empty
guest-cr3 table and handle the faults in the PPR log (which should just
answer them with INVALID). After all these PPR faults are recoverable
for the device and we should not allow the device to change old-kernels
data when we don't have to.


	Joerg
