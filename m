Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4A147607E
	for <iommu@lists.linux.dev>; Thu,  8 Oct 2026 10:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791454618; cv=none; b=rpKeP8ifU33LQZwtjiiVlajx+g/vEItEuOrsfZHw5OxH+57lejFfk6fDD5shxDgo03YjIfpFZpAllbjDOi4NTIRmLetso8vnctzvO8QfEgZWMbzQhVUXz8V4uyzU6I/+70LW3gZdN0w7m0QaCNxndf6LoIpx9jGWR6O/RZ+zAIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791454618; c=relaxed/simple;
	bh=fOswragu1AKcU46BJAJ04JSQ3/APl0pHvmtWXy9S58w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=N1OLt+66Bozc9yS/DD0/3yC5SFTB7bgUnm/1yWnV05SkKn68qZ09tCQnkHCEwzbWwp2LSlsgnaHifx+LN1t8WF0k8uk2MyOvPvc+WwppnIWOjwJSKb5cTQSicYKXs85m6bnRMtdopKuuOupgu2t2TXkHztNd9t2g0cGmemAk/vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=RyO+WNwU; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="RyO+WNwU"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20261008101653euoutp02a418ef8959a188513cd92d6a66beab66~chnrEe9E-3230732307euoutp02V
	for <iommu@lists.linux.dev>; Thu,  8 Oct 2026 10:16:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20261008101653euoutp02a418ef8959a188513cd92d6a66beab66~chnrEe9E-3230732307euoutp02V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1791454613;
	bh=mO4q4g0VGAokDsTnWCtbTL+H8XVcJzLn5OxmzhD0cdI=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=RyO+WNwUSfa24tfqEVn30FJVpxPoHsWDhqUoSf4SU6BUSj7n+E4ksCk0UftGrFtMJ
	 epit+ff7Tyb2DfzpNjpAsUNl9hVBaVijdfNpwW+7ADftqkOShT6EwtJQATn+uOo/eb
	 zfvVoWbPNEj4cEqDsviDE4pEITEe5ASd/J1DZfbY=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20261008101650eucas1p2fa4adb7e7ece5173cba39c726300b64b~chnoAgJC60145601456eucas1p2Q;
	Thu,  8 Oct 2026 10:16:50 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20261008101649eusmtip2ee55bcf0281241017f5f2c9511114ef9~chnnP_ko_2421124211eusmtip2t;
	Thu,  8 Oct 2026 10:16:49 +0000 (GMT)
Message-ID: <04643c93-7d1b-49f6-870e-15c4c7306a05@samsung.com>
Date: Thu, 8 Oct 2026 12:16:48 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH] swiotlb: fix default_swiotlb_limit() for non-growable
 default pool
To: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	xen-devel@lists.xenproject.org
Cc: Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
	Petr Tesarik <petr.tesarik.ext@huawei.com>, Andreas Greve
	<andreas.greve@a-greve.de>, James Dingwall <james@dingwall.me.uk>
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20261005070518.1590097-1-m.szyprowski@samsung.com>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20261008101650eucas1p2fa4adb7e7ece5173cba39c726300b64b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261005070528eucas1p18d16ec6ecc4e879d0adc66538122132c
X-EPHeader: CA
X-CMS-RootMailID: 20261005070528eucas1p18d16ec6ecc4e879d0adc66538122132c
References: <CGME20261005070528eucas1p18d16ec6ecc4e879d0adc66538122132c@eucas1p1.samsung.com>
	<20261005070518.1590097-1-m.szyprowski@samsung.com>

On 05.10.2026 09:05, Marek Szyprowski wrote:
> Commit ad96ce3252db ("swiotlb: determine potential physical address
> limit") changed default_swiotlb_limit() to return the maximum physical
> address that could ever be used by dynamically allocated pools, so that
> the value stays constant when CONFIG_SWIOTLB_DYNAMIC=y. However,
> io_tlb_default_mem.phys_limit is returned even when the default pool
> cannot grow, e.g. when swiotlb_init_remap() is called with a remap
> callback.
>
> This breaks Xen dom0 on x86: pci_xen_swiotlb_init() passes SWIOTLB_ANY
> and xen_swiotlb_fixup(), so phys_limit is set to the top of dom0 memory,
> although xen_swiotlb_fixup() makes the default pool below the 32-bit
> boundary. xen_swiotlb_dma_supported() then rejects 32-bit DMA masks,
> even though the bounce buffer is perfectly usable by such devices.
>
> Return phys_limit only if the default pool can actually grow, otherwise
> report the real end of the default pool, like in the
> !CONFIG_SWIOTLB_DYNAMIC case.
>
> Reported-by: Andreas Greve <andreas.greve@a-greve.de>
> Reported-by: James Dingwall <james@dingwall.me.uk>
> Fixes: ad96ce3252db ("swiotlb: determine potential physical address limit")
> Closes: https://lore.kernel.org/xen-devel/f74668db-52fd-4575-8372-7bfdf10d62ac@a-greve.de/
> Cc: stable@vger.kernel.org
> Assisted-by: Claude Opus 5.5 (1M context) <noreply@anthropic.com>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>

Applied to dma-mapping-fixes with additional "Tested-by: James Dingwall"
tag, which I've received on priv.


> ---
>  kernel/dma/swiotlb.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index aa2f1c4588b9..5edea93ec635 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -1844,10 +1844,10 @@ phys_addr_t default_swiotlb_base(void)
>  phys_addr_t default_swiotlb_limit(void)
>  {
>  #ifdef CONFIG_SWIOTLB_DYNAMIC
> -	return io_tlb_default_mem.phys_limit;
> -#else
> -	return io_tlb_default_mem.defpool.end - 1;
> +	if (io_tlb_default_mem.can_grow)
> +		return io_tlb_default_mem.phys_limit;
>  #endif
> +	return io_tlb_default_mem.defpool.end - 1;
>  }
>  
>  #ifdef CONFIG_DEBUG_FS

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

