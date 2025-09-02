Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E941826E6F4
	for <iommu@lists.linux.dev>; Tue,  2 Sep 2025 08:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756802496; cv=none; b=Z+6/YXcQnXQmjzq5Lejr/tHE9npig8awJNrzOLZqAH9mZRGmQiUKCWdtPzze4Xi0//LCjqZidervxOeUZgKf1xSc+plyYCADv/RgprwhjJ3euheOCbUZi4wFFigY7IPdY/EFZ2oPc8HdIJyaDqWcbJoDNLT+73Xa0rIJAQcfNh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756802496; c=relaxed/simple;
	bh=siwxqdvmc2cGsQ7i4gMzL7n/eO5qT7+mvM9ee17l5tM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=H7AElBS1fv1GiVsgCoAZ5aiXOZh+HCWylvCM6e2FYAGWd8LNnAi41312zu2IG+eUe0LkgaYVY1dWp/WnrR8FRteWQ5QytzB/PLLdlGlXIqTcsNL+nMZ3TGJBrSs4ebmCF/JysALI+cZ235QqE0XYxxJ+IskBkCUo9uqKwm62fNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Eci+vruD; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Eci+vruD"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250902084128euoutp01ca6de1f231f94db0de686e72e95940e8~hao5Hwzwq3062330623euoutp01b
	for <iommu@lists.linux.dev>; Tue,  2 Sep 2025 08:41:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250902084128euoutp01ca6de1f231f94db0de686e72e95940e8~hao5Hwzwq3062330623euoutp01b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1756802489;
	bh=2rFlZSvDXJ6UB5LFmsBy2n4fbjL45t5bwREA8keC6AM=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=Eci+vruDS9b6+2c4o/Ij4S7tSXyFK8b/dG3rEiFaSQRuPxHLeJDIOJueGmU1wD+u7
	 nZ5+Tk6H0eEP/gDXMTpU3l+jaANBRIADTWA6cd4uLhmpKG4NiRbW/Z+U7YgM0hUzj2
	 fnpxeWSTrtPrgueG/LBFfs65iJ3fq169zlNfXvvQ=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250902084128eucas1p1c7d199644e80fa6acb97b6a38ac0436a~hao46LE432028120281eucas1p1T;
	Tue,  2 Sep 2025 08:41:28 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250902084128eusmtip232ee9d590d90df9cf1673840c53f0d18~hao4RzhK_2319223192eusmtip2R;
	Tue,  2 Sep 2025 08:41:27 +0000 (GMT)
Message-ID: <3d756d9a-38fa-4e50-8999-cc7232dd595e@samsung.com>
Date: Tue, 2 Sep 2025 10:41:27 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH] dma-debug: don't enforce dma mapping check on
 noncoherent allocations
To: Baochen Qiang <baochen.qiang@oss.qualcomm.com>, Robin Murphy
	<robin.murphy@arm.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20250828-dma-debug-fix-noncoherent-dma-check-v1-1-76e9be0dd7fc@oss.qualcomm.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20250902084128eucas1p1c7d199644e80fa6acb97b6a38ac0436a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250828081745eucas1p17e199b6fb90348d6a2187e4a5c6da692
X-EPHeader: CA
X-CMS-RootMailID: 20250828081745eucas1p17e199b6fb90348d6a2187e4a5c6da692
References: <CGME20250828081745eucas1p17e199b6fb90348d6a2187e4a5c6da692@eucas1p1.samsung.com>
	<20250828-dma-debug-fix-noncoherent-dma-check-v1-1-76e9be0dd7fc@oss.qualcomm.com>

On 28.08.2025 10:17, Baochen Qiang wrote:
> As discussed in [1], there is no need to enforce dma mapping check on
> noncoherent allocations, a simple test on the returned CPU address is
> good enough.
>
> Add a new pair of debug helpers and use them for noncoherent alloc/free
> to fix this issue.
>
> Fixes: efa70f2fdc84 ("dma-mapping: add a new dma_alloc_pages API")
> Link: https://lore.kernel.org/all/ff6c1fe6-820f-4e58-8395-df06aa91706c@oss.qualcomm.com # 1
> Signed-off-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Thanks, applied to dma-mapping-fixes branch.
> ---
>   kernel/dma/debug.c   | 48 +++++++++++++++++++++++++++++++++++++++++++++++-
>   kernel/dma/debug.h   | 20 ++++++++++++++++++++
>   kernel/dma/mapping.c |  4 ++--
>   3 files changed, 69 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
> index e43c6de2bce4e7d3e58f8d9601a7637d8f6da767..b82399437db03116a396c7d1cebd16b2e1af98c3 100644
> --- a/kernel/dma/debug.c
> +++ b/kernel/dma/debug.c
> @@ -39,6 +39,7 @@ enum {
>   	dma_debug_sg,
>   	dma_debug_coherent,
>   	dma_debug_resource,
> +	dma_debug_noncoherent,
>   };
>   
>   enum map_err_types {
> @@ -141,6 +142,7 @@ static const char *type2name[] = {
>   	[dma_debug_sg] = "scatter-gather",
>   	[dma_debug_coherent] = "coherent",
>   	[dma_debug_resource] = "resource",
> +	[dma_debug_noncoherent] = "noncoherent",
>   };
>   
>   static const char *dir2name[] = {
> @@ -993,7 +995,8 @@ static void check_unmap(struct dma_debug_entry *ref)
>   			   "[mapped as %s] [unmapped as %s]\n",
>   			   ref->dev_addr, ref->size,
>   			   type2name[entry->type], type2name[ref->type]);
> -	} else if (entry->type == dma_debug_coherent &&
> +	} else if ((entry->type == dma_debug_coherent ||
> +		    entry->type == dma_debug_noncoherent) &&
>   		   ref->paddr != entry->paddr) {
>   		err_printk(ref->dev, entry, "device driver frees "
>   			   "DMA memory with different CPU address "
> @@ -1581,6 +1584,49 @@ void debug_dma_sync_sg_for_device(struct device *dev, struct scatterlist *sg,
>   	}
>   }
>   
> +void debug_dma_alloc_pages(struct device *dev, struct page *page,
> +			   size_t size, int direction,
> +			   dma_addr_t dma_addr,
> +			   unsigned long attrs)
> +{
> +	struct dma_debug_entry *entry;
> +
> +	if (unlikely(dma_debug_disabled()))
> +		return;
> +
> +	entry = dma_entry_alloc();
> +	if (!entry)
> +		return;
> +
> +	entry->type      = dma_debug_noncoherent;
> +	entry->dev       = dev;
> +	entry->paddr	 = page_to_phys(page);
> +	entry->size      = size;
> +	entry->dev_addr  = dma_addr;
> +	entry->direction = direction;
> +
> +	add_dma_entry(entry, attrs);
> +}
> +
> +void debug_dma_free_pages(struct device *dev, struct page *page,
> +			  size_t size, int direction,
> +			  dma_addr_t dma_addr)
> +{
> +	struct dma_debug_entry ref = {
> +		.type           = dma_debug_noncoherent,
> +		.dev            = dev,
> +		.paddr		= page_to_phys(page),
> +		.dev_addr       = dma_addr,
> +		.size           = size,
> +		.direction      = direction,
> +	};
> +
> +	if (unlikely(dma_debug_disabled()))
> +		return;
> +
> +	check_unmap(&ref);
> +}
> +
>   static int __init dma_debug_driver_setup(char *str)
>   {
>   	int i;
> diff --git a/kernel/dma/debug.h b/kernel/dma/debug.h
> index f525197d3cae605aa7e0499eb2ca6f1ae134ec93..48757ca13f31403f58090e1015de828893b8f94f 100644
> --- a/kernel/dma/debug.h
> +++ b/kernel/dma/debug.h
> @@ -54,6 +54,13 @@ extern void debug_dma_sync_sg_for_cpu(struct device *dev,
>   extern void debug_dma_sync_sg_for_device(struct device *dev,
>   					 struct scatterlist *sg,
>   					 int nelems, int direction);
> +extern void debug_dma_alloc_pages(struct device *dev, struct page *page,
> +				  size_t size, int direction,
> +				  dma_addr_t dma_addr,
> +				  unsigned long attrs);
> +extern void debug_dma_free_pages(struct device *dev, struct page *page,
> +				 size_t size, int direction,
> +				 dma_addr_t dma_addr);
>   #else /* CONFIG_DMA_API_DEBUG */
>   static inline void debug_dma_map_page(struct device *dev, struct page *page,
>   				      size_t offset, size_t size,
> @@ -126,5 +133,18 @@ static inline void debug_dma_sync_sg_for_device(struct device *dev,
>   						int nelems, int direction)
>   {
>   }
> +
> +static inline void debug_dma_alloc_pages(struct device *dev, struct page *page,
> +					 size_t size, int direction,
> +					 dma_addr_t dma_addr,
> +					 unsigned long attrs)
> +{
> +}
> +
> +static inline void debug_dma_free_pages(struct device *dev, struct page *page,
> +					size_t size, int direction,
> +					dma_addr_t dma_addr)
> +{
> +}
>   #endif /* CONFIG_DMA_API_DEBUG */
>   #endif /* _KERNEL_DMA_DEBUG_H */
> diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
> index 107e4a4d251df65fb86a1d7302261c31138061b7..56de28a3b1799f7c18f7e3f8e5ecd438c5748677 100644
> --- a/kernel/dma/mapping.c
> +++ b/kernel/dma/mapping.c
> @@ -712,7 +712,7 @@ struct page *dma_alloc_pages(struct device *dev, size_t size,
>   	if (page) {
>   		trace_dma_alloc_pages(dev, page_to_virt(page), *dma_handle,
>   				      size, dir, gfp, 0);
> -		debug_dma_map_page(dev, page, 0, size, dir, *dma_handle, 0);
> +		debug_dma_alloc_pages(dev, page, size, dir, *dma_handle, 0);
>   	} else {
>   		trace_dma_alloc_pages(dev, NULL, 0, size, dir, gfp, 0);
>   	}
> @@ -738,7 +738,7 @@ void dma_free_pages(struct device *dev, size_t size, struct page *page,
>   		dma_addr_t dma_handle, enum dma_data_direction dir)
>   {
>   	trace_dma_free_pages(dev, page_to_virt(page), dma_handle, size, dir, 0);
> -	debug_dma_unmap_page(dev, dma_handle, size, dir);
> +	debug_dma_free_pages(dev, page, size, dir, dma_handle);
>   	__dma_free_pages(dev, size, page, dma_handle, dir);
>   }
>   EXPORT_SYMBOL_GPL(dma_free_pages);
>
> ---
> base-commit: 95bf875b89b48a95a82aca922eeaf19d52543028
> change-id: 20250828-dma-debug-fix-noncoherent-dma-check-8e6915d58494
>
> Best regards,

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

