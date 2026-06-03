Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C0B2DC344
	for <iommu@lists.linux.dev>; Wed,  3 Jun 2026 16:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780503945; cv=none; b=YWg9fEx6QvVzFtqQFU/+p+tEECDOPkrnPpWrU1GFuXsU8eqynerRvcWmrRpGygva7fOtQx2FgAPSALmBGXGicQb8CGSY0wj15njWTlg/ORO/3cOc8IQIESMG5D7K72kDbdXO+GunIaca1isG7GsyTHgZHktOzNjKXWRhABU03To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780503945; c=relaxed/simple;
	bh=7B84NCfZuKG4Hsg7BG5/Xe3IgPqV7+Fphl+XrLNEEc4=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:In-Reply-To:
	 Content-Type:References; b=bcJ9UtfFZYYDvYbSObfBV663xseWalBB66HER81n03lxeDfIwZTwg6xXJFL/6qhAvTrzyCDVkAXNHacSHtFuZFJ5urYwP872u53RTVxEdVJxITvkL/FNhlJNuyO8n53x4U4OayzdZ70Ge/MAjqDQTx6T5MwUQSvE7f0N99VM5Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Tc++dRfH; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Tc++dRfH"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20260603162542euoutp01c577f540e073176759fd2f8aed901db0~1nubjZcbH2305223052euoutp01Q
	for <iommu@lists.linux.dev>; Wed,  3 Jun 2026 16:25:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20260603162542euoutp01c577f540e073176759fd2f8aed901db0~1nubjZcbH2305223052euoutp01Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1780503942;
	bh=pJROqRmgyExK5WmWqqHQO2qY5/C8xYxRor0VJyZDfFs=;
	h=Date:Subject:To:From:In-Reply-To:References:From;
	b=Tc++dRfHj9bw44505VnMEVV7IoKmyepIob/ZuoBZ6c9LAvmDYe0+FIpGyrTtu8WnP
	 JL4hc1x5Zd/atsi5XyYebU22kSOMlbBGT8kFNl7oRWINTn7eI2UTK/YX7V+HxENaK6
	 IWyflvBQwzjMseBPnZAs5ktybDvZymcx+NyEdtYM=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20260603162541eucas1p200481d8b862c8add3bd298a8b813f036~1nubQ_coa2350723507eucas1p2k;
	Wed,  3 Jun 2026 16:25:41 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260603162541eusmtip2ebd3ce541445a264719262f3a4fdd4f2~1nubCILXA0040900409eusmtip2x;
	Wed,  3 Jun 2026 16:25:41 +0000 (GMT)
Message-ID: <fbce1140-eb8d-4afd-a92a-424859bcbeca@samsung.com>
Date: Wed, 3 Jun 2026 18:25:41 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH] dma-debug: fix physical address retrieval in
 debug_dma_sync_sg_for_device
To: lirongqing <lirongqing@baidu.com>, Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20260603123708.1665-1-lirongqing@baidu.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20260603162541eucas1p200481d8b862c8add3bd298a8b813f036
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260603123724eucas1p1d84be25a6da439618a24931e65315cd8
X-EPHeader: CA
X-CMS-RootMailID: 20260603123724eucas1p1d84be25a6da439618a24931e65315cd8
References: <CGME20260603123724eucas1p1d84be25a6da439618a24931e65315cd8@eucas1p1.samsung.com>
	<20260603123708.1665-1-lirongqing@baidu.com>

On 03.06.2026 14:37, lirongqing wrote:
> From: Li RongQing <lirongqing@baidu.com>
>
> In debug_dma_sync_sg_for_device(), when iterating over a scatterlist,
> the debug entry population mistakenly uses the head of the scatterlist
> 'sg' to fetch the physical address via sg_phys(), instead of using the
> current iterator variable 's'.
>
> This causes dma-debug to track the physical address of the very first
> scatterlist entry for all subsequent entries in the list.
>
> Fix this by passing the correct loop iterator 's' to sg_phys()
>
> Fixes: 9d4f645a1fd49ee ("dma-debug: store a phys_addr_t in struct dma_debug_entry")
> Signed-off-by: Li RongQing <lirongqing@baidu.com>

Nice catch! Applied to dma-mapping-fixes, thanks!


> ---
>  kernel/dma/debug.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
> index 3248f8b..2c0e2cd 100644
> --- a/kernel/dma/debug.c
> +++ b/kernel/dma/debug.c
> @@ -1556,7 +1556,7 @@ void debug_dma_sync_sg_for_device(struct device *dev, struct scatterlist *sg,
>  		struct dma_debug_entry ref = {
>  			.type           = dma_debug_sg,
>  			.dev            = dev,
> -			.paddr		= sg_phys(sg),
> +			.paddr		= sg_phys(s),
>  			.dev_addr       = sg_dma_address(s),
>  			.size           = sg_dma_len(s),
>  			.direction      = direction,

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

