Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A618F3559DF
	for <iommu@lists.linux.dev>; Thu, 30 Apr 2026 06:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777530177; cv=none; b=aJH+DNDYB2vvRowSPCYQWd37xT1xWDvjxYd0d+DDcsdxLkT0Km6feOdqxAKmVQ+uDiZlx1dMkxt6PfmvHrnIx8ehD0p9QKktXbzyRU7fqqZNRGJC5zP1p9F51qUPE9V5elD+DjqUwMsbKdotF/bdJXDl4rcKOeLwkf3CYYaG8lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777530177; c=relaxed/simple;
	bh=OGnidlCzhA0F4/Z1vrqwqz5+nlxg8SqNC86SvA0Hlbk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=XfHYozxH9nFEJFAjQ4fXXzqT6hHrB/fO/xKFJ5zgqMDW3As357d7fR3i9d2ErQhpIZH4daIIebfaJRRWjolih7cw4b1vEvNz4SkyGoMytCHO27ysDDSFSa0dXxqgWGZJGg22zVs8wANBTKZjZI+HvBaGf6A6A57XUPFM7MEht7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=J0IedF5O; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="J0IedF5O"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20260430062246euoutp01343614bb2daddb9791c9e6e39909fb55~rDkTF7i801571115711euoutp01f
	for <iommu@lists.linux.dev>; Thu, 30 Apr 2026 06:22:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20260430062246euoutp01343614bb2daddb9791c9e6e39909fb55~rDkTF7i801571115711euoutp01f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1777530166;
	bh=XSGGClWujqSw1eCqMU2KpQZI6X1o5DKjanJnuaMOXIY=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=J0IedF5OqFOdjSjS5Da3kWktekjIJ5dFjypWKZNOjkS2HiSUG3o5U4w2K9/MD9cqW
	 ix0+Cvm6xNZvFbjUHLLZWHf0T+IAh/XEMUt/oekhwF+TDzOBvfhmwZgRCYYT7NAWST
	 T1nPvGdiTI9d1cuTYWkgv9+y+vfwfuy9SKkEfocU=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260430062246eucas1p1733cbb99aa531dfedf7d49a57f72884f~rDkS5l3cl2363823638eucas1p1o;
	Thu, 30 Apr 2026 06:22:46 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260430062245eusmtip1b497e04bddc3ccb7c59bd1c3db00ef40~rDkSHtETb0080800808eusmtip1p;
	Thu, 30 Apr 2026 06:22:45 +0000 (GMT)
Message-ID: <3ba1efbb-abde-41a9-9090-e70fcde362ea@samsung.com>
Date: Thu, 30 Apr 2026 08:22:44 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 1/1] dma-direct: fix use of max_pfn
To: Petr Tesarik <ptesarik@suse.com>, Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20260410113506.262579-1-ptesarik@suse.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20260430062246eucas1p1733cbb99aa531dfedf7d49a57f72884f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260410113518eucas1p2b4149df13e7716f6f05710b577b37f1a
X-EPHeader: CA
X-CMS-RootMailID: 20260410113518eucas1p2b4149df13e7716f6f05710b577b37f1a
References: <CGME20260410113518eucas1p2b4149df13e7716f6f05710b577b37f1a@eucas1p2.samsung.com>
	<20260410113506.262579-1-ptesarik@suse.com>

On 10.04.2026 13:35, Petr Tesarik wrote:
> Calculate the correct physical address of the last byte of memory. Since
> max_pfn is in fact "the PFN of the first page after the highest system RAM
> in physical address space", the highest address that might be used for a
> DMA buffer is one byte below max_pfn << PAGE_SHIFT.
>
> This fix is unlikely to make any difference in practice. It's just that the
> current formula is slightly confusing.
>
> Signed-off-by: Petr Tesarik <ptesarik@suse.com>

Applied to dma-mapping-fixes, thanks!

> ---
>  kernel/dma/direct.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index 8f43a930716d4..fefa6c4ac467f 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -39,7 +39,7 @@ static inline struct page *dma_direct_to_page(struct device *dev,
>  
>  u64 dma_direct_get_required_mask(struct device *dev)
>  {
> -	phys_addr_t phys = (phys_addr_t)(max_pfn - 1) << PAGE_SHIFT;
> +	phys_addr_t phys = ((phys_addr_t)max_pfn << PAGE_SHIFT) - 1;
>  	u64 max_dma = phys_to_dma_direct(dev, phys);
>  
>  	return (1ULL << (fls64(max_dma) - 1)) * 2 - 1;
> @@ -540,7 +540,7 @@ int dma_direct_mmap(struct device *dev, struct vm_area_struct *vma,
>  
>  int dma_direct_supported(struct device *dev, u64 mask)
>  {
> -	u64 min_mask = (max_pfn - 1) << PAGE_SHIFT;
> +	u64 min_mask = ((u64)max_pfn << PAGE_SHIFT) - 1;
>  
>  	/*
>  	 * Because 32-bit DMA masks are so common we expect every architecture

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

