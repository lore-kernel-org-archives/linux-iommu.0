From: Andriy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 16/18] iommu: add max num of cache and granu types
Date: Tue, 9 Apr 2019 17:53:08 +0300
Message-ID: <20190409145308.GQ9224@smile.fi.intel.com>
References: <1554767973-30125-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1554767973-30125-17-git-send-email-jacob.jun.pan@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1554767973-30125-17-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, Alex Williamson <alex.williamson@redhat.com>, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, Yi Liu <yi.l.liu@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>, Christoph Hellwig <hch@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

On Mon, Apr 08, 2019 at 04:59:31PM -0700, Jacob Pan wrote:

Commit message?

> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>  include/uapi/linux/iommu.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
> index 9344cbb..59569d6 100644
> --- a/include/uapi/linux/iommu.h
> +++ b/include/uapi/linux/iommu.h
> @@ -197,6 +197,7 @@ struct iommu_inv_addr_info {
>  	__u64	granule_size;
>  	__u64	nb_granules;
>  };
> +#define NR_IOMMU_CACHE_INVAL_GRANU	(3)
>  
>  /**
>   * First level/stage invalidation information
> @@ -228,6 +229,7 @@ struct iommu_cache_invalidate_info {
>  		struct iommu_inv_addr_info addr_info;
>  	};
>  };
> +#define NR_IOMMU_CACHE_TYPE		(3)

+ blank line?

>  /**
>   * struct gpasid_bind_data - Information about device and guest PASID binding
>   * @gcr3:	Guest CR3 value from guest mm
> -- 
> 2.7.4
> 

-- 
With Best Regards,
Andy Shevchenko
