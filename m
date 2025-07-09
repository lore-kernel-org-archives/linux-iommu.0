Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7C523B63F
	for <iommu@lists.linux.dev>; Wed,  9 Jul 2025 20:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752094554; cv=none; b=CMHbIGV45tptaVaVFvPa2JHFZ16h2yK67qTD2SZ4K36nN7qQI5gVISsPR3e0vuO1YzxrYTPZOtL6W5Dhc/6nvPZT31OvdGIdE9QcbavuN5B8m5yNZ36D2n6lclRVBcfwCOcl2YFb8dOaOP+zNyz4iiG6XsBrXSkpI8DjSrygOR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752094554; c=relaxed/simple;
	bh=naButEGbExtz6y972mVS5DJpWmJcweYD7Zdg3sZP1AY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=a5QtOJ7wR1UcXWh6g52dIjBaOPu7ic+q12iE5KyFBM6DXlcGQH5rlVKX/1VT1aAQJKx9LcF7DN4zZxr12bQsYjPyPjJg2pc6nuOhB0Qtli0ltRFTA0SxKZ3I6dLfXyI2i9ZzqpOk+kgWdH+OC1UsNvPAHzw1sZ6Q7HDLiy6R0PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=bq1u1ps3; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="bq1u1ps3"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250709205544euoutp02398391f58341001de3c2dbc7ae0339ce~QsLSDYXo41677816778euoutp023
	for <iommu@lists.linux.dev>; Wed,  9 Jul 2025 20:55:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250709205544euoutp02398391f58341001de3c2dbc7ae0339ce~QsLSDYXo41677816778euoutp023
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1752094544;
	bh=8KVp4Uu/iXtdzi0LbHCUSko8eD9CrKxudcAVrvax0xc=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=bq1u1ps3YTa5hEGL9X8INZ/596VnKSidwmD8GJts2UMuURHnzhZ+TxN/q9fjEDDv+
	 mKpkAWz8XHxF1NwbGgH2mJfdT+m79fPF5RRASm2P8MoBVuUZknHFD7wdqfHJaSWFr2
	 r51QY0ICuY9RgH249s201t91QficGro0uRZskDOE=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250709205543eucas1p220a753e813a8f8115514651444c81741~QsLRdeORk2292222922eucas1p2u;
	Wed,  9 Jul 2025 20:55:43 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250709205543eusmtip2c59725b5be8fee6b22a5ecf04bdf65ed~QsLQ89xJ_0372603726eusmtip2c;
	Wed,  9 Jul 2025 20:55:43 +0000 (GMT)
Message-ID: <3c17c387-6801-4831-ad9e-8a79a2ec587c@samsung.com>
Date: Wed, 9 Jul 2025 22:55:42 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dma-mapping: properly calculate offset in the page
To: Leon Romanovsky <leon@kernel.org>
Cc: Leon Romanovsky <leonro@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
	iommu@lists.linux.dev, Stephen Rothwell <sfr@canb.auug.org.au>, Christoph
	Hellwig <hch@lst.de>
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <4f1d25f73d1a035fe5a7c9ff3818bfb0f16d3f88.1752085358.git.leonro@nvidia.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20250709205543eucas1p220a753e813a8f8115514651444c81741
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250709182545eucas1p1383b3a9950b7b06362970c11df3086a3
X-EPHeader: CA
X-CMS-RootMailID: 20250709182545eucas1p1383b3a9950b7b06362970c11df3086a3
References: <CGME20250709182545eucas1p1383b3a9950b7b06362970c11df3086a3@eucas1p1.samsung.com>
	<4f1d25f73d1a035fe5a7c9ff3818bfb0f16d3f88.1752085358.git.leonro@nvidia.com>

On 09.07.2025 20:25, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
>
> Fix typo of offset calculation of dma_map_phys() function.
> In addition, reduce scope of rarely used variables.
>
> Fixes: ec7352735abf ("dma-mapping: export new dma_*map_phys() interface")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Closes: https://lore.kernel.org/all/20250709233953.7afb7a8a@canb.auug.org.au
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Thanks for the quick fix! Applied to dma-mapping-for-next.

> ---
>   kernel/dma/mapping.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
> index 29e8594a725a..8d29ff76aa4d 100644
> --- a/kernel/dma/mapping.c
> +++ b/kernel/dma/mapping.c
> @@ -156,9 +156,6 @@ dma_addr_t dma_map_phys(struct device *dev, phys_addr_t phys, size_t size,
>   		enum dma_data_direction dir, unsigned long attrs)
>   {
>   	const struct dma_map_ops *ops = get_dma_ops(dev);
> -	struct page *page = phys_to_page(phys);
> -	size_t offset = offset_in_page(page);
> -	bool is_pfn_valid = true;
>   	dma_addr_t addr;
>   
>   	BUG_ON(!valid_dma_direction(dir));
> @@ -172,6 +169,10 @@ dma_addr_t dma_map_phys(struct device *dev, phys_addr_t phys, size_t size,
>   	else if (use_dma_iommu(dev))
>   		addr = iommu_dma_map_phys(dev, phys, size, dir, attrs);
>   	else {
> +		struct page *page = phys_to_page(phys);
> +		size_t offset = offset_in_page(phys);
> +		bool is_pfn_valid = true;
> +
>   		if (IS_ENABLED(CONFIG_DMA_API_DEBUG))
>   			is_pfn_valid = pfn_valid(PHYS_PFN(phys));
>   

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

