Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E7E4E4332
	for <iommu@lists.linux.dev>; Fri,  9 Oct 2026 14:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791555895; cv=none; b=ATA+lkF7XWf+gHJwIsmPhKP5kVRNjGfpMMsvkgSFtUemSdo8cIk6WGYO/AL175Gr4KmyoTeepwlrEKd2ltC4egwjXC1+RVMAQVIUnWirQ2NJFAuuPuMN+z+TywdtQ7tnHhCLAh0iInalO+XFGz9yqDwoZGGZrNIO71QEqwZk59M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791555895; c=relaxed/simple;
	bh=BTM1SaIu5cG3yTWrz2K2vWlOLmwrSJXM5K8HXP2AqSI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=qWC0tubmx5dz4AFZFgg9Ij8iufFEwteebWwS7BqwM9EcUbVbmgjbOgdvZoQ2cCBtz1BZONX090ixgiYFm2mzS8Ur3Kbr2yzAJkvb7UvIWoPUaJ/K+R3rgSa8ltmYQst/rqzkql4cmwycXbI0Iy7FCDmdaBQNwVy7idLmZQ3ZRqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=aiqEJSWO; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="aiqEJSWO"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20261009142450euoutp019a993703ca650948b66974ed961b66f0~c4pc4X6ZG2835128351euoutp01Q
	for <iommu@lists.linux.dev>; Fri,  9 Oct 2026 14:24:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20261009142450euoutp019a993703ca650948b66974ed961b66f0~c4pc4X6ZG2835128351euoutp01Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1791555890;
	bh=i0RSIhug9e9ydgjudmmhXvwA5s3usVBKmgWxJQR/YPg=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=aiqEJSWOpDfUL1AKnBKqTlwcfxTrq/0miLWX+Wzd1JbYG3hVbE9drv9eNOifHgEql
	 emZ8+9HPeiodQIG7JntklpErISRudBQfgtd3p/eahry/SnuvXYkbKxhpz59KMOb5mG
	 M+q0tsnIp/g6YDhqptVYzJndtyaOadY4kv31Cj78=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20261009142450eucas1p22aec6df61384870aa07eecf8ca4f269c~c4pcwGLoI2048820488eucas1p2r;
	Fri,  9 Oct 2026 14:24:50 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20261009142449eusmtip113f1886f9735f58850eaf51a840c30dd~c4pb_Pa1X1436814368eusmtip1V;
	Fri,  9 Oct 2026 14:24:49 +0000 (GMT)
Message-ID: <a4e7873b-f5eb-47cf-91f6-ad3e70f7b0cd@samsung.com>
Date: Fri, 9 Oct 2026 16:24:49 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH] dma-direct: Restore arch_dma_alloc() for the
 DMA_ATTR_NO_KERNEL_MAPPING case
To: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>, Russell King
	<linux@armlinux.org.uk>, "Claude Opus 5 . 5" <noreply@anthropic.com>
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20260930135734.1013905-1-m.szyprowski@samsung.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20261009142450eucas1p22aec6df61384870aa07eecf8ca4f269c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260930135751eucas1p1c3b8b79ed87c3bf6f473d26e4663e7e4
X-EPHeader: CA
X-CMS-RootMailID: 20260930135751eucas1p1c3b8b79ed87c3bf6f473d26e4663e7e4
References: <CGME20260930135751eucas1p1c3b8b79ed87c3bf6f473d26e4663e7e4@eucas1p1.samsung.com>
	<20260930135734.1013905-1-m.szyprowski@samsung.com>

On 30.09.2026 15:57, Marek Szyprowski wrote:
> Commit 849facea92fa ("dma-direct: simplify the DMA_ATTR_NO_KERNEL_MAPPING
> handling") moved the DMA_ATTR_NO_KERNEL_MAPPING shortcut in
> dma_direct_alloc() in front of the arch_dma_alloc() call. Architectures
> providing their own DMA coherent allocator (CONFIG_ARCH_HAS_DMA_ALLOC)
> therefore no longer see such requests. ARM 32bit is one of such. Lack of
> the call to arch_dma_alloc() results in the lack of proper cache
> management on HighMem pages.
>
> Take the dma-direct shortcut only for coherent devices or when the
> architecture doesn't provide arch_dma_alloc(). While touching this,
> move that check into separate function to avoid duplication in alloc
> and free paths.
>
> Fixes: 849facea92fa ("dma-direct: simplify the DMA_ATTR_NO_KERNEL_MAPPING handling")
> Reported-by: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
> Closes: https://lore.kernel.org/all/yq5ams2akznl.fsf@kernel.org/
> Assisted-by: Claude Opus 5.5 <noreply@anthropic.com>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Applied to dma-mapping-for-next, because it looks that this case has no
active users, so it is not the urgent fix.

> ---
>  kernel/dma/direct.c | 22 ++++++++++++++++++----
>  1 file changed, 18 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index da665ca22d5c..a31bd3129f3f 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -179,6 +179,22 @@ static struct page *dma_direct_alloc_from_pool(struct device *dev, size_t size,
>  	return page;
>  }
>  
> +/*
> + * Check if the allocation can skip the kernel mapping and return the page
> + * pointer as the cookie.
> + */
> +static bool dma_direct_use_no_mapping(struct device *dev, unsigned long attrs)
> +{
> +	if ((attrs & (DMA_ATTR_NO_KERNEL_MAPPING | __DMA_ATTR_ALLOC_CC_SHARED)) !=
> +	    DMA_ATTR_NO_KERNEL_MAPPING)
> +		return false;
> +	if (is_swiotlb_for_alloc(dev))
> +		return false;
> +	if (IS_ENABLED(CONFIG_ARCH_HAS_DMA_ALLOC) && !dev_is_dma_coherent(dev))
> +		return false;
> +	return true;
> +}
> +
>  static void *dma_direct_alloc_no_mapping(struct device *dev, size_t size,
>  		dma_addr_t *dma_handle, gfp_t gfp)
>  {
> @@ -226,8 +242,7 @@ void *dma_direct_alloc(struct device *dev, size_t size,
>  	if (attrs & DMA_ATTR_NO_WARN)
>  		gfp |= __GFP_NOWARN;
>  
> -	if (((attrs & (DMA_ATTR_NO_KERNEL_MAPPING | __DMA_ATTR_ALLOC_CC_SHARED)) ==
> -	     DMA_ATTR_NO_KERNEL_MAPPING) && !is_swiotlb_for_alloc(dev))
> +	if (dma_direct_use_no_mapping(dev, attrs))
>  		return dma_direct_alloc_no_mapping(dev, size, dma_handle, gfp);
>  
>  	if (!dev_is_dma_coherent(dev)) {
> @@ -374,8 +389,7 @@ void dma_direct_free(struct device *dev, size_t size,
>  	if (attrs & __DMA_ATTR_ALLOC_CC_SHARED)
>  		mark_mem_encrypted = true;
>  
> -	if (((attrs & (DMA_ATTR_NO_KERNEL_MAPPING | __DMA_ATTR_ALLOC_CC_SHARED)) ==
> -	     DMA_ATTR_NO_KERNEL_MAPPING) && !is_swiotlb_for_alloc(dev)) {
> +	if (dma_direct_use_no_mapping(dev, attrs)) {
>  		/* cpu_addr is a struct page cookie, not a kernel address */
>  		dma_free_contiguous(dev, cpu_addr, size);
>  		return;

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

