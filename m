From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v5 2/8] iommu/vt-d: Add per-device IOMMU feature ops
 entries
Date: Fri, 11 Jan 2019 12:16:44 +0100
Message-ID: <20190111111644.epawu474jdjv4a33@8bytes.org>
References: <20190110030027.31447-1-baolu.lu@linux.intel.com>
 <20190110030027.31447-3-baolu.lu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190110030027.31447-3-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>, Alex Williamson <alex.williamson@redhat.com>, Kirti Wankhede <kwankhede@nvidia.com>, ashok.raj@intel.com, sanjay.k.kumar@intel.com, jacob.jun.pan@intel.com, kevin.tian@intel.com, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, yi.l.liu@intel.com, yi.y.sun@intel.com, peterx@redhat.com, tiwei.bie@intel.com, Zeng@8bytes.org, Xin <xin.zeng@intel.com>, iommu@lists.linux-foundation.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Jacob Pan <jacob.jun.pan@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

Hi,

this looks a bit confusing to me because I can see no checking whether
the device actually supports scalable mode. More below:

On Thu, Jan 10, 2019 at 11:00:21AM +0800, Lu Baolu wrote:
> +static int intel_iommu_enable_auxd(struct device *dev)
> +{
> +	struct device_domain_info *info;
> +	struct dmar_domain *domain;
> +	unsigned long flags;
> +
> +	if (!scalable_mode_support())
> +		return -ENODEV;
> +
> +	domain = get_valid_domain_for_dev(dev);
> +	if (!domain)
> +		return -ENODEV;
> +
> +	spin_lock_irqsave(&device_domain_lock, flags);
> +	info = dev->archdata.iommu;
> +	info->auxd_enabled = 1;
> +	spin_unlock_irqrestore(&device_domain_lock, flags);
> +
> +	return 0;
> +}

This code sets a flag to mark scalable mode enabled. Doesn't the device
need some handling too, like enabling the PASID capability and all?

> +
> +static bool
> +intel_iommu_dev_has_feat(struct device *dev, enum iommu_dev_features feat)
> +{
> +	struct device_domain_info *info = dev->archdata.iommu;
> +
> +	if (feat == IOMMU_DEV_FEAT_AUX)
> +		return scalable_mode_support() && info && info->auxd_enabled;
> +
> +	return false;
> +}

Why is this checking the auxd_enabled flag? The function should just
return whether the device _supports_ scalable mode, not whether it is
enabled.

Regards,

	Joerg
