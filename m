Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294583E9C14
	for <iommu@lists.linux.dev>; Wed,  3 Jun 2026 16:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780503930; cv=none; b=NRWGIwZvvuV4+tfKH73Md545kfkQvYjna7j5Oz0sJCY4CEWU71DSPDfWFlyTfo7E1/S+Kh7hm3G0ZFTa9QxGodxwvHd0T+U051Yg1SbXsRqyFDFzdkwh0jUPGfoEK7NxkLU4S0XCU5kQ7DH7DKuov7jyoT+IbkQbNmDdSfIBF7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780503930; c=relaxed/simple;
	bh=J/Q216rrwfN6D7TJI3AK5xE5hAJrUT9gwbxFqLZB05Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:In-Reply-To:
	 Content-Type:References; b=ohL0Ipmrw4B9esi5MJlPEXlO5XXAMjQfbPfaWxTd+kyUlMPR+RGhAveWfT84zeBYfyKmhCRL3xwmDt3S5VEYg8S+7bHeNzpeNjNeVI+sXYLWt5DxOlYNF3l6HkSlXk+cwXgZCYIJAeP476jRe5J3lR2buaBKsqsNqvqHmq5FhrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=VCXsCHYC; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="VCXsCHYC"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20260603162524euoutp01ff738c7e7012b5617feb4ecd7f21a7ba~1nuK4QRkL2292922929euoutp01M
	for <iommu@lists.linux.dev>; Wed,  3 Jun 2026 16:25:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20260603162524euoutp01ff738c7e7012b5617feb4ecd7f21a7ba~1nuK4QRkL2292922929euoutp01M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1780503924;
	bh=pNuNfJLH987ESFQGfEtDUqo1u5ysTbW8B08YkGwhZAg=;
	h=Date:Subject:To:From:In-Reply-To:References:From;
	b=VCXsCHYCJX5waW+HNpG9uBeZjGMZyfrm6laRNifqVSqSI3keS/t6xEzb9rv4UF4kx
	 K2YCDk8s+6raxxP9vBzBbsIxLtHXM/htXaftG06BAKdlwQ5bTtz2veGgQGSTZ6moLq
	 t3ndlzsuu2UJ1le+TpZK8zcZBEVUXYA7v5XF1MwQ=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260603162523eucas1p18845e6f28707defa808865629a912a45~1nuKkwlD02601726017eucas1p1W;
	Wed,  3 Jun 2026 16:25:23 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260603162523eusmtip24f3d507cffb05571384fc723a1ce2bd6~1nuJ7KQqG2555925559eusmtip2k;
	Wed,  3 Jun 2026 16:25:23 +0000 (GMT)
Message-ID: <d5b8f939-02d5-4016-9ccb-dd0be0714abb@samsung.com>
Date: Wed, 3 Jun 2026 18:25:22 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH] dma-mapping: direct: fix missing mapping for
 THRU_HOST_BRIDGE segments
To: lirongqing <lirongqing@baidu.com>, Robin Murphy <robin.murphy@arm.com>,
	Lu Baolu <baolu.lu@linux.intel.com>, Luis Chamberlain <mcgrof@kernel.org>,
	Leon Romanovsky <leon@kernel.org>, Logan Gunthorpe <logang@deltatee.com>,
	Bjorn Helgaas <bhelgaas@google.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, hch@lst.de
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20260603013723.2439-1-lirongqing@baidu.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20260603162523eucas1p18845e6f28707defa808865629a912a45
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260603013739eucas1p2acd3cd59c1083639deb58723d57558af
X-EPHeader: CA
X-CMS-RootMailID: 20260603013739eucas1p2acd3cd59c1083639deb58723d57558af
References: <CGME20260603013739eucas1p2acd3cd59c1083639deb58723d57558af@eucas1p2.samsung.com>
	<20260603013723.2439-1-lirongqing@baidu.com>

On 03.06.2026 03:37, lirongqing wrote:
> From: Li RongQing <lirongqing@baidu.com>
>
> In dma_direct_map_sg(), the case PCI_P2PDMA_MAP_THRU_HOST_BRIDGE
> incorrectly used 'break' instead of falling through to MAP_NONE.
> As a result, segments traversing the host bridge skipped the required
> dma_direct_map_phys() call entirely, leaving sg->dma_address
> uninitialized and leading to DMA failures. Fix this by using
> 'fallthrough;'.
>
> Fixes: a25e7962db0d79 ("PCI/P2PDMA: Refactor the p2pdma mapping helpers")
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> Signed-off-by: Li RongQing <lirongqing@baidu.com>

Applied to dma-mapping-fixes, thanks!


> ---
>  kernel/dma/direct.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index 583c592..4391b79 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -476,7 +476,7 @@ int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
>  			 * must be mapped with CPU physical address and not PCI
>  			 * bus addresses.
>  			 */
> -			break;
> +			fallthrough;
>  		case PCI_P2PDMA_MAP_NONE:
>  			need_sync = true;
>  			sg->dma_address = dma_direct_map_phys(dev, sg_phys(sg),

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

