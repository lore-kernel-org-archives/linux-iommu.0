Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09EEA256D
	for <iommu@lists.linux.dev>; Mon, 24 Nov 2025 18:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764009979; cv=none; b=BpRWl/aEkD1m9UCw0OwKM/cs+Qrcxop6PKjWMkRtKN48hRtmu9q3ZyJx2GRHJX+OMCI6xLIuZ7t37PgCJuQFvO6WjrRT7lTvqKoL1X7RAYd+nIheTqwU/kdeX5LqIvYXx3SQdKwm77LQhCk95HBRTk9AthEgwF89U2zBqvEiRG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764009979; c=relaxed/simple;
	bh=c66y1sLGb6p8bGi2PN6eIN01Qve3ShlhGuHPUXivAeI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=Fz7AQw5lf8edNead7OPrPUdpojRUn4KsbI2mVKAgESuB77JDDjdj311FxYS/iT0RN2TbgbVigvKuSa7QqhajmpiYn5E/LXstv5AbNp+WVxFvZNoy4y6VQ1Z4qKrdnoPHH2qYExQ15AWuD48EkQ0Gn9FHTXudfllVLOQU928Jy3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=h+kK+l4P; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="h+kK+l4P"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20251124184615euoutp023be0125efb0c1f3a65fb5e6a1132b1d8~7Bbnxfw5s2602226022euoutp02w
	for <iommu@lists.linux.dev>; Mon, 24 Nov 2025 18:46:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20251124184615euoutp023be0125efb0c1f3a65fb5e6a1132b1d8~7Bbnxfw5s2602226022euoutp02w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1764009975;
	bh=Iy1gcphEzOlGC6ilh+7gjrMcC0WWtC24Q9d/DrJeujQ=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=h+kK+l4PVcPdZpDkpI9TfYAMzDUq0iFymAv8JdMggXvTWcOMZwt2H6KNNxVTEAfHE
	 yna+BOKKTwPZXQO47WLSmq97JVB3Hsk6lDV3PwuQZU6PhbuTe8YLzXwckqvGCkWljT
	 GTxtSiIiHkD1QBH9Dyom/vfSmIz4tmL++Od1Z8jI=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20251124184614eucas1p2aea3fa90dbfccadaa6c0fc2b432594e2~7BbnCK5U33266032660eucas1p2j;
	Mon, 24 Nov 2025 18:46:14 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20251124184613eusmtip2189f0f7940761929d99078eca9d54398~7BbmPHz210521805218eusmtip2F;
	Mon, 24 Nov 2025 18:46:13 +0000 (GMT)
Message-ID: <b890945a-49af-4c45-a325-0fb106be7832@samsung.com>
Date: Mon, 24 Nov 2025 19:46:12 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH] iommu/dma: add missing support for DMA_ATTR_MMIO for
 dma_iova_unlink()
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, Robin Murphy
	<robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon
	<will@kernel.org>, Leon Romanovsky <leon@kernel.org>
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20251124181752.GX233636@ziepe.ca>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20251124184614eucas1p2aea3fa90dbfccadaa6c0fc2b432594e2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20251124171014eucas1p21d3a0f2c10b43bfdb7861ee804f09951
X-EPHeader: CA
X-CMS-RootMailID: 20251124171014eucas1p21d3a0f2c10b43bfdb7861ee804f09951
References: <CGME20251124171014eucas1p21d3a0f2c10b43bfdb7861ee804f09951@eucas1p2.samsung.com>
	<20251124170955.3884351-1-m.szyprowski@samsung.com>
	<20251124181752.GX233636@ziepe.ca>

On 24.11.2025 19:17, Jason Gunthorpe wrote:
> On Mon, Nov 24, 2025 at 06:09:55PM +0100, Marek Szyprowski wrote:
>> Commit c288d657dd51 added support for DMA_ATTR_MMIO attribute in the
>> dma_iova_link() code path, but missed that the CPU cache is being also
>> touched in the dma_iova_unlink() path. Fix this.
>>
>> Fixes: c288d657dd51 ("iommu/dma: implement DMA_ATTR_MMIO for dma_iova_link().")
>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> ---
>>   drivers/iommu/dma-iommu.c | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
>
> Did you find it by code inspection?

Yes, I checked how the batched CPu sync will fit there and noticed the 
unlink path, see 
https://lore.kernel.org/all/f8a0b873-b93c-4a91-b47d-2d11bfcf36b4@samsung.com/

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

