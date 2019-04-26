From: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH v2 17/19] iommu: Add max num of cache and granu types
Date: Fri, 26 Apr 2019 18:22:46 +0200
Message-ID: <a9f2c804-24a8-03fb-96ac-0c4661870dd5@redhat.com>
References: <1556062279-64135-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1556062279-64135-18-git-send-email-jacob.jun.pan@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1556062279-64135-18-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jacob Pan <jacob.jun.pan@linux.intel.com>, iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, Alex Williamson <alex.williamson@redhat.com>, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc: Yi Liu <yi.l.liu@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>, Christoph Hellwig <hch@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, Andriy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

Hi Jacob,

On 4/24/19 1:31 AM, Jacob Pan wrote:
> To convert to/from cache types and granularities between generic and
> VT-d specific counterparts, a 2D arrary is used. Introduce the limits
array
> to help define the converstion array size.
conversion
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>  include/uapi/linux/iommu.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
> index 5c95905..2d8fac8 100644
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
> @@ -235,6 +236,7 @@ struct iommu_cache_invalidate_info {
>  		struct iommu_inv_addr_info addr_info;
>  	};
>  };
> +#define NR_IOMMU_CACHE_TYPE		(3)
>  /**
>   * struct gpasid_bind_data - Information about device and guest PASID binding
>   * @gcr3:	Guest CR3 value from guest mm
> 
Is it really something that needs to be exposed in the uapi?

Thanks

Eric
