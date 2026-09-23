Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2B7352C52
	for <iommu@lists.linux.dev>; Wed, 23 Sep 2026 07:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790150323; cv=none; b=cELCl32UL3zJvSX+lNUXoK0brdxXSprueFLDu4kmkDImKjGkFQbMun3gxXhWWoiYi11mmwquioS/kjS5+yafEuq1CvK13n1+vD20lsxAO1pAf2dwPBRO7r2BI5pG8yayXtdFu8eP37Cd0g/+R+B7HXerCy8V/408fsanoiMItbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790150323; c=relaxed/simple;
	bh=Dk4ell1sggcPNMor+D+EIrp0EtboUTwYE7AbGXYU1fI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=TO1HvFg2id2tAiQibbNCPs+DtF5To7xocAe3UqqC2JBtaJBOEuWrIX2O4EFtG7yWWRfz0gX7S81ahrWacRA88RyZ/qj9YeGa6lvq9bfbKwSVJSE7ifLjQPD3QldqycF7Zm9v40kefiPP8rwFBEcqe2C9bXnY18Ou860aTxOcqEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=jli3Jpy6; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="jli3Jpy6"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20260923075831euoutp01602a469f8e410af4f7fecb243368ea85~X5DlM5fHU2782927829euoutp01P
	for <iommu@lists.linux.dev>; Wed, 23 Sep 2026 07:58:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20260923075831euoutp01602a469f8e410af4f7fecb243368ea85~X5DlM5fHU2782927829euoutp01P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1790150311;
	bh=NLHiHP9oES0/4v1znH/+Y+tVY/g8uuZAdpV7fjYmUCs=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=jli3Jpy6XpcTkS5JhomWNFcZYqqd60JWnlK27Wva6vrjXd+FMvwgRrzLVv+yc44We
	 VYH/3djBt0jSf4mcP8x1Z4Yg9J8tHUwZXXCnohqlEpvwRIlOCX+6sToJtLv7AgvxLW
	 Q3yi+6gtak2IK395VrmKfP1pJ9IapUp5wuBrk8Uw=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260923075831eucas1p10e4827538fd7f70f278f11157225c07a~X5Dk9kAZT1276212762eucas1p1Y;
	Wed, 23 Sep 2026 07:58:31 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260923075830eusmtip24d59db8c7701f60d390302eb88d1b12c~X5Dka9FWj3018730187eusmtip2B;
	Wed, 23 Sep 2026 07:58:30 +0000 (GMT)
Message-ID: <dcd1f1d2-a15e-4998-b57c-6f4de21ebf6f@samsung.com>
Date: Wed, 23 Sep 2026 09:58:30 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH RFC 1/2] iommu/dma: skip swiotlb bounce for
 DMA_ATTR_MMIO in iommu_dma_map_phys
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, Robin Murphy
	<robin.murphy@arm.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon
	<will@kernel.org>, Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe
	<jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, Peng Fan
	<peng.fan@nxp.com>
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20260916-iommu-dma-fix-v1-1-a59a0c45ec5b@nxp.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20260923075831eucas1p10e4827538fd7f70f278f11157225c07a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260916151931eucas1p2f69ddb55e61c8455dedb946b319fb938
X-EPHeader: CA
X-CMS-RootMailID: 20260916151931eucas1p2f69ddb55e61c8455dedb946b319fb938
References: <20260916-iommu-dma-fix-v1-0-a59a0c45ec5b@nxp.com>
	<CGME20260916151931eucas1p2f69ddb55e61c8455dedb946b319fb938@eucas1p2.samsung.com>
	<20260916-iommu-dma-fix-v1-1-a59a0c45ec5b@nxp.com>

On 16.09.2026 17:23, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
>
> MMIO resources mapped via dma_map_resource() carry DMA_ATTR_MMIO. These
> never need swiotlb bounce buffering, but the current code enters the
> swiotlb path when the physical address is not page-aligned, then rejects
> the mapping because MMIO cannot be bounced.
>
> Move the DMA_ATTR_MMIO check before the swiotlb block so the entire bounce
> path is skipped for MMIO, falling through directly to __iommu_dma_map()
> which creates the IOVA mapping.
>
> Fixes: f9374de14c0e8 ("iommu/dma: implement DMA_ATTR_MMIO for iommu_dma_(un)map_phys()")
> Assisted-by: Claude:claude-opus-4-6
> Signed-off-by: Peng Fan <peng.fan@nxp.com>


Applied only this patch to dma-mapping-fixes. Thanks!

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

