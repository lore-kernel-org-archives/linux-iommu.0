Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47766A54
	for <iommu@lists.linux.dev>; Fri, 10 Mar 2023 05:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678424938; x=1709960938;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+J49aPyhvpQwkShbD0yDrpi5G/X/Mfrh2uMgIT+15TA=;
  b=L0+G6667X1UiPpBySRFckkQi8n8lKumXuPBmGxPAKbcFoDLQL+NnJadX
   NELaxbYyveDWsysnLz8AWAlznNt9z8eVwMOZ1gxIaqNPnON9siJooi8dX
   esBX8gtLQjgI1pcOd6IwCHE4OgZ7nMfeOU18u4vUiJ3rUQ+8lrPSexQ0k
   Q3sdCPOzFiS6gl5adgABprQNGlNRu3spu9E6mrLg3TvCiZG4Mz2q2ymIA
   2aWNXeilFJ1dQXQeib1JVlCv5OoPnx1oFQtvlF0G9fpXzBiY0QKCVrMXF
   4uajH4/3AAPVmgxlDApn+j4R4u15lIayYGgIhas6uU0L9Um7gChnC6eHI
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="335345578"
X-IronPort-AV: E=Sophos;i="5.98,248,1673942400"; 
   d="scan'208";a="335345578"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 21:08:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="741826265"
X-IronPort-AV: E=Sophos;i="5.98,248,1673942400"; 
   d="scan'208";a="741826265"
Received: from allen-box.sh.intel.com (HELO [10.239.159.48]) ([10.239.159.48])
  by fmsmga008.fm.intel.com with ESMTP; 09 Mar 2023 21:08:51 -0800
Message-ID: <69753e4a-32f3-8760-ba1d-8286badd159e@linux.intel.com>
Date: Fri, 10 Mar 2023 13:07:51 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Cc: baolu.lu@linux.intel.com, Robin Murphy <robin.murphy@arm.com>,
 Will Deacon <will@kernel.org>, David Woodhouse <dwmw2@infradead.org>,
 Raj Ashok <ashok.raj@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 Yi Liu <yi.l.liu@intel.com>, "Yu, Fenghua" <fenghua.yu@intel.com>,
 Dave Jiang <dave.jiang@intel.com>,
 Kirill Shutemov <kirill.shutemov@linux.intel.com>,
 Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH v5 4/7] iommu/sva: Stop using ioasid_set for SVA
Content-Language: en-US
To: Jacob Pan <jacob.jun.pan@linux.intel.com>,
 LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
 Jason Gunthorpe <jgg@nvidia.com>, Joerg Roedel <joro@8bytes.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Dave Hansen <dave.hansen@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
 X86 Kernel <x86@kernel.org>, bp@alien8.de, "H. Peter Anvin" <hpa@zytor.com>,
 Peter Zijlstra <peterz@infradead.org>, corbet@lwn.net, vkoul@kernel.org,
 dmaengine@vger.kernel.org, linux-doc@vger.kernel.org
References: <20230309222159.487826-1-jacob.jun.pan@linux.intel.com>
 <20230309222159.487826-6-jacob.jun.pan@linux.intel.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230309222159.487826-6-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/10/23 6:21 AM, Jacob Pan wrote:
> From: Jason Gunthorpe <jgg@nvidia.com>
> 
> Instead SVA drivers can use a simple global IDA to allocate PASIDs for
> each mm_struct.
> 
> Future work would be to allow drivers using the SVA APIs to reserve global
> PASIDs from this IDA for their internal use, eg with the DMA API PASID
> support.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
> v5:
> 	- Put removing iommu_sva_find() to a separate patch (Kevin)
> 	- Make pasid allocation range to be inclusive (Tina)
> 	- Simplified return code handling (Baolu)
> v4:
> 	- Keep GFP_ATOMIC flag for PASID allocation, will changed to
> 	GFP_KERNEL in a separate patch.
> ---
>   drivers/iommu/iommu-sva.c | 42 +++++++++++++--------------------------
>   drivers/iommu/iommu-sva.h |  2 --
>   2 files changed, 14 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
> index 4f357ef14f04..b75711bdbe97 100644
> --- a/drivers/iommu/iommu-sva.c
> +++ b/drivers/iommu/iommu-sva.c
> @@ -9,47 +9,33 @@
>   #include "iommu-sva.h"
>   
>   static DEFINE_MUTEX(iommu_sva_lock);
> -static DECLARE_IOASID_SET(iommu_sva_pasid);
> +static DEFINE_IDA(iommu_global_pasid_ida);
>   
> -/**
> - * iommu_sva_alloc_pasid - Allocate a PASID for the mm
> - * @mm: the mm
> - * @min: minimum PASID value (inclusive)
> - * @max: maximum PASID value (inclusive)
> - *
> - * Try to allocate a PASID for this mm, or take a reference to the existing one
> - * provided it fits within the [@min, @max] range. On success the PASID is
> - * available in mm->pasid and will be available for the lifetime of the mm.
> - *
> - * Returns 0 on success and < 0 on error.
> - */
> -int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t max)
> +static int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t max)
>   {
>   	int ret = 0;
> -	ioasid_t pasid;
>   
> -	if (min == INVALID_IOASID || max == INVALID_IOASID ||
> -	    min == 0 || max < min)
> +	if (!pasid_valid(min) || !pasid_valid(max) ||
> +	     min == 0 || max < min)

No need to change above line.

>   		return -EINVAL;
>   
>   	mutex_lock(&iommu_sva_lock);
>   	/* Is a PASID already associated with this mm? */
>   	if (pasid_valid(mm->pasid)) {
> -		if (mm->pasid < min || mm->pasid >= max)
> +		if (mm->pasid < min || mm->pasid > max)

I forgot why do we need to change above line. But it's better to put
some comments there so that people don't need to dive into
ioasid_alloc() to know the inclusion or exclusion of @min or @max.

>   			ret = -EOVERFLOW;
>   		goto out;
>   	}
>   
> -	pasid = ioasid_alloc(&iommu_sva_pasid, min, max, mm);
> -	if (!pasid_valid(pasid))
> -		ret = -ENOMEM;
> -	else
> -		mm->pasid = pasid;
> +	ret = ida_alloc_range(&iommu_global_pasid_ida, min, max, GFP_ATOMIC);
> +	if (ret < 0)
> +		goto out;
> +	mm->pasid = ret;
> +	ret = 0;
>   out:
>   	mutex_unlock(&iommu_sva_lock);
>   	return ret;
>   }
> -EXPORT_SYMBOL_GPL(iommu_sva_alloc_pasid);
>   
>   /**
>    * iommu_sva_bind_device() - Bind a process address space to a device
> @@ -221,8 +207,8 @@ iommu_sva_handle_iopf(struct iommu_fault *fault, void *data)
>   
>   void mm_pasid_drop(struct mm_struct *mm)
>   {
> -	if (pasid_valid(mm->pasid)) {
> -		ioasid_free(mm->pasid);
> -		mm->pasid = INVALID_IOASID;
> -	}
> +	if (likely(!pasid_valid(mm->pasid)))
> +		return;
> +
> +	ida_free(&iommu_global_pasid_ida, mm->pasid);

Any reason why do you drop "mm->pasid = INVALID_IOASID;" here?

>   }
> diff --git a/drivers/iommu/iommu-sva.h b/drivers/iommu/iommu-sva.h
> index 102eae1817a2..c22d0174ad61 100644
> --- a/drivers/iommu/iommu-sva.h
> +++ b/drivers/iommu/iommu-sva.h
> @@ -8,8 +8,6 @@
>   #include <linux/ioasid.h>
>   #include <linux/mm_types.h>
>   
> -int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t max);
> -
>   /* I/O Page fault */
>   struct device;
>   struct iommu_fault;

Best regards,
baolu
