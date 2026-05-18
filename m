Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7923E3DEFFB
	for <iommu@lists.linux.dev>; Mon, 18 May 2026 07:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779088053; cv=none; b=Q1N69vyYNDhEEnAMKdMTj18cf2PG0AYIYb/ApTK23m6cOXM4cVH3UZxmshKGUv2mRaNIHG5j5JYBA62KTLKxB3hxw5Omaupuo8wdSy9F0U5c/oIDMaq/i9adXHkpPuJVtbrqHZBzwSWW+3GwbGtuIZGklT3yBaWcG+2dIYqQyAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779088053; c=relaxed/simple;
	bh=Z5OY2IHoPB+1Er90lz4GiGNmOR0DTsWsdcvcMwwqKqQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=LG0KM2y5powyxsn0eH0tvpMhjiq7ZTgX6KApEbwBSPrjmlPJt3BXAP7ZdWaKCuAv42WySJWU+5ij875BYnpvCWQCRkXI/w88pQwJpJPgY4hbEwp3fIyTpeM05TNmJFUklcKaJC2ZEoFYwHiWSFmlafPsClEcWJMhvAFwbh9BXRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=N8vKQItw; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="N8vKQItw"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20260518070723euoutp01eb1e4af497fa9f406b6141b1dfae8365~wlyY9I_oY2968829688euoutp018
	for <iommu@lists.linux.dev>; Mon, 18 May 2026 07:07:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20260518070723euoutp01eb1e4af497fa9f406b6141b1dfae8365~wlyY9I_oY2968829688euoutp018
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1779088043;
	bh=oTO/xMbM7EdMpOs+eyRRMjSicVoQEg0A4gbllBijLlA=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=N8vKQItw8uwSuuySlo5Lv0kZ5tfprwScVNJyZbLsqdd6hrXXQHVk0q2DPcm6ouO8w
	 1RXBPP/ydjG5AIRA6rSb6XQQWZn2vFyxrm+tmvHx62Ofx/UBJ3QpzakVo3vdNd0fVg
	 Ys23UGPTK90Wxkj7gLAl7zO+GT6axRFqi60Rt/OM=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260518070722eucas1p1ba3571fc0a0049ac3cec976d68a2576c~wlyYd-5oD1788617886eucas1p1A;
	Mon, 18 May 2026 07:07:22 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260518070721eusmtip23a7a174bd7376619be8239ae16125562~wlyXs6TKa2573325733eusmtip2U;
	Mon, 18 May 2026 07:07:21 +0000 (GMT)
Message-ID: <0eef232a-cbf9-453c-8727-8f97fcfd4ab5@samsung.com>
Date: Mon, 18 May 2026 09:07:21 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH v3] dma-mapping: move dma_map_resource() sanity check
 into debug code
To: Jianpeng Chang <jianpeng.chang.cn@windriver.com>
Cc: robin.murphy@arm.com, leon@kernel.org, kbusch@kernel.org, jgg@ziepe.ca,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20260513072209.1486986-1-jianpeng.chang.cn@windriver.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20260518070722eucas1p1ba3571fc0a0049ac3cec976d68a2576c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260513072249eucas1p157fef8aac2399cd3cb35f716904143a7
X-EPHeader: CA
X-CMS-RootMailID: 20260513072249eucas1p157fef8aac2399cd3cb35f716904143a7
References: <CGME20260513072249eucas1p157fef8aac2399cd3cb35f716904143a7@eucas1p1.samsung.com>
	<20260513072209.1486986-1-jianpeng.chang.cn@windriver.com>

On 13.05.2026 09:22, Jianpeng Chang wrote:
> dma_map_resource() uses pfn_valid() to ensure the range is not RAM.
> However, pfn_valid() only checks for availability of the memory map for
> a PFN but it does not ensure that the PFN is actually backed by RAM. On
> ARM64 with SPARSEMEM (128MB section granularity), MMIO addresses that
> share a section with RAM will falsely trigger the WARN_ON_ONCE and cause
> dma_map_resource() to return DMA_MAPPING_ERROR.
>
> This causes a WARNING on Raspberry Pi 4 during spi_bcm2835 probe because
> the SPI FIFO register (0xfe204004) falls in the same sparsemem section
> as the end of RAM (0xf8000000-0xfbffffff), both in section 31
> (0xf8000000-0xffffffff).
>
> Move the sanity check from dma_map_resource() into debug_dma_map_phys()
> and replace the unreliable pfn_valid() with pfn_valid() &&
> !PageReserved(), which correctly identifies actual usable RAM without
> false positives for MMIO regions that happen to have struct pages.
>
> Since dma_map_resource() is dma_map_phys(DMA_ATTR_MMIO), the check
> applies equally to both APIs. Any non-reserved page represents kernel
> memory to a sufficient degree that using DMA_ATTR_MMIO on it is almost
> certainly wrong and risks breaking coherency on non-coherent platforms.
> ZONE_DEVICE pages used for PCI P2P DMA (MEMORY_DEVICE_PCI_P2PDMA) have
> PageReserved set, so they will not trigger a false positive.
>
> The check no longer blocks the mapping and uses err_printk() to
> integrate with dma-debug filtering.
>
> Fixes: f7326196a781 ("dma-mapping: export new dma_*map_phys() interface")
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Jianpeng Chang <jianpeng.chang.cn@windriver.com>

Applied to dma-mapping-fixes, thanks!

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

