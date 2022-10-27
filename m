Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5CCD1865
	for <iommu@lists.linux.dev>; Thu, 27 Oct 2022 09:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666861641; x=1698397641;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ad9M3i9h/5Kfy1CALxKF2HSFy/sxmTX7+Z0mhlS5eGA=;
  b=ny/RxVCRrsmw6ILOclo7M8LekPWbpYy43thuRgmP2iJdIor5/a2pX+wt
   XYbbigKqQwtP3yLRqcqFmAzr/WMXr5dxTGoSgAtkQnuradP9B5ekuwrOH
   QDrShYzq21fgMbSbaE+45LHmpyamEpiV+5hfwwNQvmMUOUjDDshYoHScW
   St2P6TgdIO4ufHCLH6Mq8lUWrse+7gvTYg7KIVmZ+7JEqlA+7WccoG3um
   LNvtBVVXT2C7hzW9LyC8z+AzaJLJaf33Estm7zsx6h2Bu/IkwIg5w+NMe
   2j0zWkR4uBsvng7cq2KY7oYYnxVmTdtfpCpJIBtYBRzFZeuRHk8ZqrzGT
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10512"; a="291474723"
X-IronPort-AV: E=Sophos;i="5.95,217,1661842800"; 
   d="scan'208";a="291474723"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2022 02:07:21 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10512"; a="701271733"
X-IronPort-AV: E=Sophos;i="5.95,217,1661842800"; 
   d="scan'208";a="701271733"
Received: from rgrilak-mobl.ger.corp.intel.com (HELO [10.213.238.72]) ([10.213.238.72])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2022 02:07:18 -0700
Message-ID: <6621c4d6-c306-c1f9-eefe-818b4ff4469b@linux.intel.com>
Date: Thu, 27 Oct 2022 10:07:16 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH] drm/i915: stop abusing swiotlb_max_segment
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, jani.nikula@linux.intel.com,
 joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com
Cc: airlied@gmail.com, daniel@ffwll.ch, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, iommu@lists.linux.dev,
 oleksandr_tyshchenko@epam.com, marmarek@invisiblethingslab.com,
 Robert Beckett <bob.beckett@collabora.com>
References: <20221020110308.1582518-1-hch@lst.de>
From: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Organization: Intel Corporation UK Plc
In-Reply-To: <20221020110308.1582518-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 20/10/2022 12:03, Christoph Hellwig wrote:
> From: Robert Beckett <bob.beckett@collabora.com>
> 
> swiotlb_max_segment used to return either the maximum size that swiotlb
> could bounce, or for Xen PV PAGE_SIZE even if swiotlb could bounce buffer
> larger mappings.  This made i915 on Xen PV work as it bypasses the
> coherency aspect of the DMA API and can't cope with bounce buffering
> and this avoided bounce buffering for the Xen/PV case.
> 
> So instead of adding this hack back, check for Xen/PV directly in i915
> for the Xen case and otherwise use the proper DMA API helper to query
> the maximum mapping size.
> 
> Replace swiotlb_max_segment() calls with dma_max_mapping_size().
> In i915_gem_object_get_pages_internal() no longer consider max_segment
> only if CONFIG_SWIOTLB is enabled. There can be other (iommu related)
> causes of specific max segment sizes.
> 
> Fixes: a2daa27c0c61 ("swiotlb: simplify swiotlb_max_segment")
> Reported-by: Marek Marczykowski-Górecki <marmarek@invisiblethingslab.com>
> Signed-off-by: Robert Beckett <bob.beckett@collabora.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> [hch: added the Xen hack, rewrote the changelog]

Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>

I'll merge this in a minute - thanks again for the cleanup!

Regards,

Tvrtko

> ---
>   drivers/gpu/drm/i915/gem/i915_gem_internal.c | 19 +++--------
>   drivers/gpu/drm/i915/gem/i915_gem_shmem.c    |  2 +-
>   drivers/gpu/drm/i915/gem/i915_gem_ttm.c      |  4 +--
>   drivers/gpu/drm/i915/gem/i915_gem_userptr.c  |  2 +-
>   drivers/gpu/drm/i915/i915_scatterlist.h      | 34 ++++++++++++--------
>   5 files changed, 29 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_internal.c b/drivers/gpu/drm/i915/gem/i915_gem_internal.c
> index c698f95af15fe..629acb403a2c9 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_internal.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_internal.c
> @@ -6,7 +6,6 @@
>   
>   #include <linux/scatterlist.h>
>   #include <linux/slab.h>
> -#include <linux/swiotlb.h>
>   
>   #include "i915_drv.h"
>   #include "i915_gem.h"
> @@ -38,22 +37,12 @@ static int i915_gem_object_get_pages_internal(struct drm_i915_gem_object *obj)
>   	struct scatterlist *sg;
>   	unsigned int sg_page_sizes;
>   	unsigned int npages;
> -	int max_order;
> +	int max_order = MAX_ORDER;
> +	unsigned int max_segment;
>   	gfp_t gfp;
>   
> -	max_order = MAX_ORDER;
> -#ifdef CONFIG_SWIOTLB
> -	if (is_swiotlb_active(obj->base.dev->dev)) {
> -		unsigned int max_segment;
> -
> -		max_segment = swiotlb_max_segment();
> -		if (max_segment) {
> -			max_segment = max_t(unsigned int, max_segment,
> -					    PAGE_SIZE) >> PAGE_SHIFT;
> -			max_order = min(max_order, ilog2(max_segment));
> -		}
> -	}
> -#endif
> +	max_segment = i915_sg_segment_size(i915->drm.dev) >> PAGE_SHIFT;
> +	max_order = min(max_order, get_order(max_segment));
>   
>   	gfp = GFP_KERNEL | __GFP_HIGHMEM | __GFP_RECLAIMABLE;
>   	if (IS_I965GM(i915) || IS_I965G(i915)) {
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
> index f42ca1179f373..11125c32dd35d 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
> @@ -194,7 +194,7 @@ static int shmem_get_pages(struct drm_i915_gem_object *obj)
>   	struct intel_memory_region *mem = obj->mm.region;
>   	struct address_space *mapping = obj->base.filp->f_mapping;
>   	const unsigned long page_count = obj->base.size / PAGE_SIZE;
> -	unsigned int max_segment = i915_sg_segment_size();
> +	unsigned int max_segment = i915_sg_segment_size(i915->drm.dev);
>   	struct sg_table *st;
>   	struct sgt_iter sgt_iter;
>   	struct page *page;
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_ttm.c b/drivers/gpu/drm/i915/gem/i915_gem_ttm.c
> index 4f861782c3e85..a4aa9500fa179 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_ttm.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_ttm.c
> @@ -189,7 +189,7 @@ static int i915_ttm_tt_shmem_populate(struct ttm_device *bdev,
>   	struct drm_i915_private *i915 = container_of(bdev, typeof(*i915), bdev);
>   	struct intel_memory_region *mr = i915->mm.regions[INTEL_MEMORY_SYSTEM];
>   	struct i915_ttm_tt *i915_tt = container_of(ttm, typeof(*i915_tt), ttm);
> -	const unsigned int max_segment = i915_sg_segment_size();
> +	const unsigned int max_segment = i915_sg_segment_size(i915->drm.dev);
>   	const size_t size = (size_t)ttm->num_pages << PAGE_SHIFT;
>   	struct file *filp = i915_tt->filp;
>   	struct sgt_iter sgt_iter;
> @@ -538,7 +538,7 @@ static struct i915_refct_sgt *i915_ttm_tt_get_st(struct ttm_tt *ttm)
>   	ret = sg_alloc_table_from_pages_segment(st,
>   			ttm->pages, ttm->num_pages,
>   			0, (unsigned long)ttm->num_pages << PAGE_SHIFT,
> -			i915_sg_segment_size(), GFP_KERNEL);
> +			i915_sg_segment_size(i915_tt->dev), GFP_KERNEL);
>   	if (ret) {
>   		st->sgl = NULL;
>   		return ERR_PTR(ret);
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_userptr.c b/drivers/gpu/drm/i915/gem/i915_gem_userptr.c
> index d4398948f0162..f34e01a7fefb9 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_userptr.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_userptr.c
> @@ -129,7 +129,7 @@ static void i915_gem_object_userptr_drop_ref(struct drm_i915_gem_object *obj)
>   static int i915_gem_userptr_get_pages(struct drm_i915_gem_object *obj)
>   {
>   	const unsigned long num_pages = obj->base.size >> PAGE_SHIFT;
> -	unsigned int max_segment = i915_sg_segment_size();
> +	unsigned int max_segment = i915_sg_segment_size(obj->base.dev->dev);
>   	struct sg_table *st;
>   	unsigned int sg_page_sizes;
>   	struct page **pvec;
> diff --git a/drivers/gpu/drm/i915/i915_scatterlist.h b/drivers/gpu/drm/i915/i915_scatterlist.h
> index 9ddb3e743a3e5..b0a1db44f8950 100644
> --- a/drivers/gpu/drm/i915/i915_scatterlist.h
> +++ b/drivers/gpu/drm/i915/i915_scatterlist.h
> @@ -9,7 +9,8 @@
>   
>   #include <linux/pfn.h>
>   #include <linux/scatterlist.h>
> -#include <linux/swiotlb.h>
> +#include <linux/dma-mapping.h>
> +#include <xen/xen.h>
>   
>   #include "i915_gem.h"
>   
> @@ -127,19 +128,26 @@ static inline unsigned int i915_sg_dma_sizes(struct scatterlist *sg)
>   	return page_sizes;
>   }
>   
> -static inline unsigned int i915_sg_segment_size(void)
> +static inline unsigned int i915_sg_segment_size(struct device *dev)
>   {
> -	unsigned int size = swiotlb_max_segment();
> -
> -	if (size == 0)
> -		size = UINT_MAX;
> -
> -	size = rounddown(size, PAGE_SIZE);
> -	/* swiotlb_max_segment_size can return 1 byte when it means one page. */
> -	if (size < PAGE_SIZE)
> -		size = PAGE_SIZE;
> -
> -	return size;
> +	size_t max = min_t(size_t, UINT_MAX, dma_max_mapping_size(dev));
> +
> +	/*
> +	 * For Xen PV guests pages aren't contiguous in DMA (machine) address
> +	 * space.  The DMA API takes care of that both in dma_alloc_* (by
> +	 * calling into the hypervisor to make the pages contiguous) and in
> +	 * dma_map_* (by bounce buffering).  But i915 abuses ignores the
> +	 * coherency aspects of the DMA API and thus can't cope with bounce
> +	 * buffering actually happening, so add a hack here to force small
> +	 * allocations and mappings when running in PV mode on Xen.
> +	 *
> +	 * Note this will still break if bounce buffering is required for other
> +	 * reasons, like confidential computing hypervisors or PCIe root ports
> +	 * with addressing limitations.
> +	 */
> +	if (xen_pv_domain())
> +		max = PAGE_SIZE;
> +	return round_down(max, PAGE_SIZE);
>   }
>   
>   bool i915_sg_trim(struct sg_table *orig_st);
