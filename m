Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA7A36C0CE
	for <iommu@lists.linux.dev>; Thu, 28 May 2026 08:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779956132; cv=none; b=csMsRrGoD6n4DU87Wm2GfzTmp8uTxIFqBJc4DGVNsepOe1W3vRw3HeJgFzzubF15D6gldFmf5LeXFdVzYc9kxsWGXZ2+PCjS5E+BKy0b1AJ+1nc2PVIZDtk9KFt/apEWB3g1I2XIB0v5Pug7cXjPc/pqv29rrZRGWQfCI1+iSys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779956132; c=relaxed/simple;
	bh=ph6AVxU2mN85eYp4CXUuth8twL1G3NolslbRj7aatRk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=QTAGGAlKWqvR6S6af85ZdV3unYXvqenIus9qPhZY1rFXMncqY9Pl++YymhtPEU8jfGlCsA1YSLEF6Sg0loDAB+pZIJfZCXQX7XDnEBVj9CUJQVEPtN2usCh9mpqYmsMBLZrr5i03Wtmkjw/vJx9vWO/FoUgU+GUjBTFaz3IHl68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=X/ijxmwM; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="X/ijxmwM"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20260528081522euoutp01aea263400f7d1c6f36f89fedef371e1d~zrKmcA5b81062910629euoutp01e
	for <iommu@lists.linux.dev>; Thu, 28 May 2026 08:15:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20260528081522euoutp01aea263400f7d1c6f36f89fedef371e1d~zrKmcA5b81062910629euoutp01e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1779956122;
	bh=IbG5k8tuaI3ySlwPK27Q1QWmqnOtdP159Rj033Gk+vY=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=X/ijxmwM8b1885B/lHJcusc1+3nBMqeTO+fgfQyDBl8ndmgCqOske0KLa/aI6xYjZ
	 a+oWdAog75k4WNRaPNmCKcDuy8IuucvjMAKXfXBfWphpNGJAqNbFetloybWbMjbsCj
	 Kqw+FWBaUOp2wO5ffupdj+wToUmN9RxLWQhQz0Yo=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20260528081521eucas1p2bc331b88ce47a15e48d45c18d6c8f016~zrKmJ0S0W1498614986eucas1p2F;
	Thu, 28 May 2026 08:15:21 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260528081521eusmtip2ca6d181521a06dab5847ee55a6f16654~zrKlpirKv3211632116eusmtip2r;
	Thu, 28 May 2026 08:15:21 +0000 (GMT)
Message-ID: <f1188fbb-74a8-492c-ba84-37cdec1dc38f@samsung.com>
Date: Thu, 28 May 2026 10:15:20 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH] dma-contiguous: simplify numa cma area handling
To: Feng Tang <feng.tang@linux.alibaba.com>, Robin Murphy
	<robin.murphy@arm.com>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
	<skhan@linuxfoundation.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20260525015111.6267-1-feng.tang@linux.alibaba.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20260528081521eucas1p2bc331b88ce47a15e48d45c18d6c8f016
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260525015116eucas1p2a5c7b0c3eb05630b892ff23e16875fd2
X-EPHeader: CA
X-CMS-RootMailID: 20260525015116eucas1p2a5c7b0c3eb05630b892ff23e16875fd2
References: <CGME20260525015116eucas1p2a5c7b0c3eb05630b892ff23e16875fd2@eucas1p2.samsung.com>
	<20260525015111.6267-1-feng.tang@linux.alibaba.com>

On 25.05.2026 03:51, Feng Tang wrote:
> Currently, there are 2 kernel cmdline ways to setup numa cma area:
> "cma_pernuma=" and "numa_cma=", and there are 2 cma arrays as well,
> while they have no difference technically. Robin suggested to cleanup
> the code and only use one array [1], as "the apparent intent that
> users only want one _or_ the other".
>
> Simplify the code by only using one array to save the numa cma area.
> And in rare case that a user really setup the 2 cmdline parameters
> at the same time,  let the per-node specific size setting 'numa_cma='
> take priority over the global numa cma setting.
>
> Link[1]: https://lore.kernel.org/lkml/43c5301c-fe6a-41e4-9482-ccfc7b62f2a7@arm.com/
>
> Suggested-by: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Feng Tang <feng.tang@linux.alibaba.com>

Applied to dma-mapping-for-next. Thanks!


> ---
>  .../admin-guide/kernel-parameters.txt         |  4 ++
>  kernel/dma/Kconfig                            |  4 +-
>  kernel/dma/contiguous.c                       | 46 +++++--------------
>  3 files changed, 19 insertions(+), 35 deletions(-)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 4d0f545fb3ec..8e717a587870 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -895,6 +895,10 @@ Kernel parameters
>  			contiguous memory allocations. It will reserve CMA
>  			area for the specified node.
>  
> +			If it is setup together with upper 'cmd_pernuma='
> +			(unlikely), its size setting takes priority for the
> +			specified numa nodes.
> +
>  			With numa CMA enabled, DMA users on node nid will
>  			first try to allocate buffer from the numa area
>  			which is located in node nid, if the allocation fails,
> diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
> index c9fa0a922cba..0a4ba21a57a7 100644
> --- a/kernel/dma/Kconfig
> +++ b/kernel/dma/Kconfig
> @@ -179,7 +179,9 @@ config DMA_NUMA_CMA
>  
>  	  You can set the size of pernuma CMA by specifying "cma_pernuma=size"
>  	  or set the node id and its size of CMA by specifying "numa_cma=
> -	  <node>:size[,<node>:size]" on the kernel's command line.
> +	  <node>:size[,<node>:size]" on the kernel's command line. And in
> +	  rare case that the above 2 are both setup, then the "numa_cma="
> +	  takes priority for the specified numa nodes.
>  
>  config CMA_SIZE_PERNUMA
>  	bool "Default CMA area per NUMA node"
> diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
> index 799f6e9c88bd..f754079a287d 100644
> --- a/kernel/dma/contiguous.c
> +++ b/kernel/dma/contiguous.c
> @@ -134,7 +134,6 @@ EXPORT_SYMBOL_GPL(dev_get_cma_area);
>  
>  static struct cma *dma_contiguous_numa_area[MAX_NUMNODES];
>  static phys_addr_t numa_cma_size[MAX_NUMNODES] __initdata;
> -static struct cma *dma_contiguous_pernuma_area[MAX_NUMNODES];
>  static phys_addr_t pernuma_size_bytes __initdata;
>  static bool numa_cma_configured __initdata;
>  
> @@ -208,7 +207,7 @@ static void __init dma_numa_cma_reserve(void)
>  		pernuma_size_bytes = cma_get_size(dma_contiguous_default_area);
>  
>  	for_each_node(nid) {
> -		int ret;
> +		int size, ret;
>  		char name[CMA_MAX_NAME];
>  		struct cma **cma;
>  
> @@ -218,27 +217,17 @@ static void __init dma_numa_cma_reserve(void)
>  			continue;
>  		}
>  
> -		if (pernuma_size_bytes) {
> -
> -			cma = &dma_contiguous_pernuma_area[nid];
> -			snprintf(name, sizeof(name), "pernuma%d", nid);
> -			ret = cma_declare_contiguous_nid(0, pernuma_size_bytes, 0, 0,
> -							 0, false, name, cma, nid);
> -			if (ret)
> -				pr_warn("%s: reservation failed: err %d, node %d", __func__,
> -					ret, nid);
> -		}
> -
> -		if (numa_cma_size[nid]) {
> +		/* per-node numa setting has the priority */
> +		size = numa_cma_size[nid] ?: pernuma_size_bytes;
> +		if (!size)
> +			continue;
>  
> -			cma = &dma_contiguous_numa_area[nid];
> -			snprintf(name, sizeof(name), "numa%d", nid);
> -			ret = cma_declare_contiguous_nid(0, numa_cma_size[nid], 0, 0, 0, false,
> -							 name, cma, nid);
> -			if (ret)
> -				pr_warn("%s: reservation failed: err %d, node %d", __func__,
> -					ret, nid);
> -		}
> +		cma = &dma_contiguous_numa_area[nid];
> +		snprintf(name, sizeof(name), "numa%d", nid);
> +		ret = cma_declare_contiguous_nid(0, size, 0, 0, 0, false, name, cma, nid);
> +		if (ret)
> +			pr_warn("%s: reservation failed: err %d, node %d", __func__,
> +				ret, nid);
>  	}
>  }
>  #else
> @@ -437,16 +426,8 @@ struct page *dma_alloc_contiguous(struct device *dev, size_t size, gfp_t gfp)
>  
>  #ifdef CONFIG_DMA_NUMA_CMA
>  	if (nid != NUMA_NO_NODE && !(gfp & (GFP_DMA | GFP_DMA32))) {
> -		struct cma *cma = dma_contiguous_pernuma_area[nid];
> +		struct cma *cma = dma_contiguous_numa_area[nid];
>  		struct page *page;
> -
> -		if (cma) {
> -			page = cma_alloc_aligned(cma, size, gfp);
> -			if (page)
> -				return page;
> -		}
> -
> -		cma = dma_contiguous_numa_area[nid];
>  		if (cma) {
>  			page = cma_alloc_aligned(cma, size, gfp);
>  			if (page)
> @@ -484,9 +465,6 @@ void dma_free_contiguous(struct device *dev, struct page *page, size_t size)
>  		 * otherwise, page is from either per-numa cma or default cma
>  		 */
>  #ifdef CONFIG_DMA_NUMA_CMA
> -		if (cma_release(dma_contiguous_pernuma_area[page_to_nid(page)],
> -					page, count))
> -			return;
>  		if (cma_release(dma_contiguous_numa_area[page_to_nid(page)],
>  					page, count))
>  			return;
>
> base-commit: 7e6ace2535d032c908e4d8747d9a7952617c001a

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

