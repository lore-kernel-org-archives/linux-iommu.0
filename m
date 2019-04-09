From: Andriy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 18/18] iommu/vt-d: Add svm/sva invalidate function
Date: Tue, 9 Apr 2019 17:57:12 +0300
Message-ID: <20190409145712.GR9224@smile.fi.intel.com>
References: <1554767973-30125-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1554767973-30125-19-git-send-email-jacob.jun.pan@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1554767973-30125-19-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, Alex Williamson <alex.williamson@redhat.com>, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, Yi Liu <yi.l.liu@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>, Christoph Hellwig <hch@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, Liu@smile.fi.intel.com, Yi L <yi.l.liu@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

On Mon, Apr 08, 2019 at 04:59:33PM -0700, Jacob Pan wrote:
> When Shared Virtual Address (SVA) is enabled for a guest OS via
> vIOMMU, we need to provide invalidation support at IOMMU API and driver
> level. This patch adds Intel VT-d specific function to implement
> iommu passdown invalidate API for shared virtual address.
> 
> The use case is for supporting caching structure invalidation
> of assigned SVM capable devices. Emulated IOMMU exposes queue
> invalidation capability and passes down all descriptors from the guest
> to the physical IOMMU.
> 
> The assumption is that guest to host device ID mapping should be
> resolved prior to calling IOMMU driver. Based on the device handle,
> host IOMMU driver can replace certain fields before submit to the
> invalidation queue.

> +static int intel_iommu_sva_invalidate(struct iommu_domain *domain,
> +		struct device *dev, struct iommu_cache_invalidate_info *inv_info)
> +{
> +	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
> +	struct device_domain_info *info;
> +	struct intel_iommu *iommu;
> +	unsigned long flags;
> +	int cache_type;
> +	u8 bus, devfn;
> +	u16 did, sid;
> +	int ret = 0;
> +	u64 granu;
> +	u64 size;
> +
> +	if (!inv_info || !dmar_domain ||
> +		inv_info->version != IOMMU_CACHE_INVALIDATE_INFO_VERSION_1)
> +		return -EINVAL;
> +
> +	iommu = device_to_iommu(dev, &bus, &devfn);
> +	if (!iommu)
> +		return -ENODEV;
> +

> +	if (!dev || !dev_is_pci(dev))
> +		return -ENODEV;

How dev is used in above call? Can be dev NULL there optional and give non-NULL
iommu?

> +		switch (1 << cache_type) {

BIT() ?

> +		case IOMMU_CACHE_INV_TYPE_IOTLB:
> +			if (size && (inv_info->addr_info.addr & ((1 << (VTD_PAGE_SHIFT + size)) - 1))) {

BIT() ?

> +				pr_err("Address out of range, 0x%llx, size order %llu\n",
> +					inv_info->addr_info.addr, size);
> +				ret = -ERANGE;
> +				goto out_unlock;
> +			}
> +
> +			qi_flush_piotlb(iommu, did, mm_to_dma_pfn(inv_info->addr_info.addr),
> +					inv_info->addr_info.pasid,
> +					size, granu);
> +
> +			/*
> +			 * Always flush device IOTLB if ATS is enabled since guest
> +			 * vIOMMU exposes CM = 1, no device IOTLB flush will be passed
> +			 * down. REVISIT: cannot assume Linux guest
> +			 */
> +			if (info->ats_enabled) {
> +				qi_flush_dev_piotlb(iommu, sid, info->pfsid,
> +						inv_info->addr_info.pasid, info->ats_qdep,
> +						inv_info->addr_info.addr, size,
> +						granu);
> +			}
> +			break;
> +		case IOMMU_CACHE_INV_TYPE_DEV_IOTLB:
> +			if (info->ats_enabled) {
> +				qi_flush_dev_piotlb(iommu, sid, info->pfsid,
> +						inv_info->addr_info.pasid, info->ats_qdep,
> +						inv_info->addr_info.addr, size,
> +						granu);
> +			} else
> +				pr_warn("Passdown device IOTLB flush w/o ATS!\n");
> +
> +			break;
> +		case IOMMU_CACHE_INV_TYPE_PASID:
> +			qi_flush_pasid_cache(iommu, did, granu, inv_info->pasid);
> +
> +			break;
> +		default:
> +			dev_err(dev, "Unsupported IOMMU invalidation type %d\n",
> +				cache_type);
> +			ret = -EINVAL;
> +		}

> +out_unlock:
> +	spin_unlock(&iommu->lock);
> +	spin_unlock_irqrestore(&device_domain_lock, flags);
> +
> +	return ret;
> +}

-- 
With Best Regards,
Andy Shevchenko
