From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 3/9] iommu: Introduce iommu do invalidate API function
Date: Wed, 28 Jun 2017 12:08:23 +0200
Message-ID: <20170628100823.GG14532@8bytes.org>
References: <1498592883-56224-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1498592883-56224-4-git-send-email-jacob.jun.pan@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1498592883-56224-4-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, David Woodhouse <dwmw2@infradead.org>, "Liu, Yi L" <yi.l.liu@intel.com>, Lan Tianyu <tianyu.lan@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>, Alex Williamson <alex.williamson@redhat.com>, Jean Delvare <khali@linux-fr.org>, "Liu, Yi L" <yi.l.liu@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

On Tue, Jun 27, 2017 at 12:47:57PM -0700, Jacob Pan wrote:
> From: "Liu, Yi L" <yi.l.liu@linux.intel.com>
> 
> When a SVM capable device is assigned to a guest, the first level page
> tables are owned by the guest and the guest PASID table pointer is
> linked to the device context entry of the physical IOMMU.
> 
> Host IOMMU driver has no knowledge of caching structure updates unless
> the guest invalidation activities are passed down to the host. The
> primary usage is derived from emulated IOMMU in the guest, where QEMU
> can trap invalidation activities before pass them down the
> host/physical IOMMU. There are IOMMU architectural specific actions
> need to be taken which requires the generic APIs introduced in this
> patch to have opaque data in the tlb_invalidate_info argument.

Which "IOMMU architectural specific actions" are you thinking of?

> +int iommu_invalidate(struct iommu_domain *domain,
> +		struct device *dev, struct tlb_invalidate_info *inv_info)
> +{
> +	int ret = 0;
> +
> +	if (unlikely(!domain->ops->invalidate))
> +		return -ENODEV;
> +
> +	ret = domain->ops->invalidate(domain, dev, inv_info);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(iommu_invalidate);

[...]

> +struct tlb_invalidate_info {
> +	__u32	model;
> +	__u32	length;
> +	__u8	opaque[];
> +};

This interface is aweful. It requires the user of a generic api to know
details about the implementation behind to do anything useful.

Please explain in more detail why this is needed. My feeling is that we
can make this more generic with a small set of invalidation functions in
the iommu-api.



	Joerg
