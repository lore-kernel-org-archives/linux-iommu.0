From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH v5 09/23] iommu/vt-d: add svm/sva invalidate function
Date: Mon, 14 May 2018 13:49:27 -0700
Message-ID: <20180514134927.04886814@jacob-builder>
References: <1526072055-86990-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1526072055-86990-10-git-send-email-jacob.jun.pan@linux.intel.com>
        <5AF903E9.6070408@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5AF903E9.6070408@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alex Williamson <alex.williamson@redhat.com>, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>, Jean Delvare <khali@linux-fr.org>, Christoph Hellwig <hch@infradead.org>, jacob.jun.pan@linux.intel.com
List-Id: iommu@lists.linux-foundation.org

On Mon, 14 May 2018 11:35:05 +0800
Lu Baolu <baolu.lu@linux.intel.com> wrote:

> > +	switch (inv_info->hdr.type) {
> > +	case IOMMU_INV_TYPE_TLB:
> > +		if (inv_info->size &&
> > +			(inv_info->addr & ((1 << (VTD_PAGE_SHIFT +
> > inv_info->size)) - 1))) {
> > +			pr_err("Addr out of range, addr 0x%llx,
> > size order %d\n",
> > +				inv_info->addr, inv_info->size);
> > +			ret = -ERANGE;
> > +			goto out_unlock;
> > +		}
> > +
> > +		qi_flush_eiotlb(iommu, did,
> > mm_to_dma_pfn(inv_info->addr),
> > +				inv_info->pasid,
> > +				inv_info->size, granu,
> > +				inv_info->flags &
> > IOMMU_INVALIDATE_GLOBAL_PAGE);
> > +		/**
> > +		 * Always flush device IOTLB if ATS is enabled
> > since guest
> > +		 * vIOMMU exposes CM = 1, no device IOTLB flush
> > will be passed
> > +		 * down.
> > +		 */
> > +		info = iommu_support_dev_iotlb(dmar_domain, iommu,
> > bus, devfn);
> > +		if (info && info->ats_enabled) {
> > +			qi_flush_dev_eiotlb(iommu, sid,
> > +					inv_info->pasid,
> > info->ats_qdep,
> > +					inv_info->addr,
> > inv_info->size,
> > +					granu);
> > +		}
> > +		break;
> > +	case IOMMU_INV_TYPE_PASID:
> > +		qi_flush_pasid(iommu, did, granu, inv_info->pasid);
> > +
> > +		break;
> > +	default:
> > +		dev_err(dev, "Unknown IOMMU invalidation type
> > %d\n",
> > +			inv_info->hdr.type);  
> 
> There are three types of invalidation:
> 
> enum iommu_inv_type {
>         IOMMU_INV_TYPE_DTLB,
>         IOMMU_INV_TYPE_TLB,
>         IOMMU_INV_TYPE_PASID,
>         IOMMU_INV_NR_TYPE
> };
> 
> So "unsupported" looks better than "unknown" in the message.
> 
agreed, makes more sense.
>  [...]  
