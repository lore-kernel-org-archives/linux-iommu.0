Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.118.77.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793865812;
	b=vrkHFHsZ3x+WoGL+qZ8LgEjaCPm3pp6kXczUqAtprvPMFfHa5GmIzdJYuG9xAqzj6xTm
	 YySU4nSIef4RxdZCSApayr0npBpX1EF8jy3jiWLdqf1rztPOwJciEQHZyAckL09xWVjLK
	 KULExXzYeoh/M2jx4TQ6apwvHOIaTteQybaJXmj9ZDoPC++P4YFad65ealjXSlq69TKb4
	 4JDTgAD3aqPXyuACL6u1FQlf63Bic/2EfnVeprA2SJiSA9uZsaNr2mDycznOLHzY+tJW4
	 CFr+N35lxZI/qsbju6xEwWKg4o8VNFbN282wAIor03Q4d/PxAB/mD/c5v210IWBQVSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793865812;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 Content-Language:From:In-Reply-To:Content-Transfer-Encoding:
	 X-CMS-MailID:X-Msg-Generator:Content-Type:X-RootMTR:X-EPHeader:
	 X-CMS-RootMailID:References;
	bh=/R6SjvlIEakmX2LCOEwbTiKWcwW/bEJjJXxzK8ev4Gk=;
	b=ArPrOgTZ791DbCzRdkhjogsNc9Dl0rAfB1cR22LH469wzARMwkHmN+pDeMg2Y9td5c/G
	 IPmGA/AzFc0rXOwkcyTw+xheAzzTAqOeLKbW+H3CzhCBJg2GhUaMjNV98sLfDGGc5wQJl
	 +xWeQGZ+lqdam3v9omE3TQd0Z789r9RTMhpE/JubZgSZn0lUUs8a10Pn3x5kQK6C7UtgP
	 6pMNUYzIsVD2YhFFpLLaqgLO/6W9IqR1iyh/TVApOrc8GRxJP5bcuo2CyALuMxplgc/iJ
	 wm6Kqzd8iMHct11yiB6nO5YHXIZIRwS/HZ71XYgAaLRALvl4fgqePrWHwjTfG54ySfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=samsung.com;
	spf=pass smtp.mailfrom=samsung.com;
	dkim=pass header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=T4OMYUYd;
	arc=none smtp.remote-ip=210.118.77.11
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B354606A328
	for <iommu@lists.linux.dev>; Thu,  5 Nov 2026 08:03:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B354606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=T4OMYUYd
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20261105080329euoutp01b845359dbfe4dd3a14824586ca2d2c1d~lF3MQz6vL0891908919euoutp01G
	for <iommu@lists.linux.dev>; Thu,  5 Nov 2026 08:03:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20261105080329euoutp01b845359dbfe4dd3a14824586ca2d2c1d~lF3MQz6vL0891908919euoutp01G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1793865809;
	bh=/R6SjvlIEakmX2LCOEwbTiKWcwW/bEJjJXxzK8ev4Gk=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=T4OMYUYdo4ZjlXwESJaabPslfVlDhslwZoZdj/C6h91T6fT6tkW79fPbXFFrYb81X
	 Uwv7dkqkoc9WZ3pPmGcBfhE/7aC5kXHllwYcmbINWbOJ01fAi4+v+grEe7KKjNnbYM
	 7tX0eyg81vcZNMPQyNJyGGT6o9bexR6BjRXxhsbI=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20261105080329eucas1p1386a0920ebaf45ff525de8361501bdf1~lF3MJHMDI2293122931eucas1p1b;
	Thu,  5 Nov 2026 08:03:29 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20261105080328eusmtip23f9ebfe62c4c6fea3cc323dfc91f24b4~lF3Lc2JLn1089310893eusmtip2h;
	Thu,  5 Nov 2026 08:03:28 +0000 (GMT)
Message-ID: <286d09f6-0fd6-46be-9290-a7d89af18892@samsung.com>
Date: Thu, 5 Nov 2026 09:03:27 +0100
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 0/5] dma-mapping: assorted sashiko.dev fixes
To: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: Robin Murphy <robin.murphy@arm.com>, Andrew Morton
	<akpm@linux-foundation.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Claire Chang <tientzu@chromium.org>, Petr Tesarik
	<petr.tesarik.ext@huawei.com>, Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Lucas Stach <l.stach@pengutronix.de>
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20261026095423.966856-1-m.szyprowski@samsung.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20261105080329eucas1p1386a0920ebaf45ff525de8361501bdf1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261026095434eucas1p29408e916eda327a5e9c83f64b0df4e66
X-EPHeader: CA
X-CMS-RootMailID: 20261026095434eucas1p29408e916eda327a5e9c83f64b0df4e66
References: <CGME20261026095434eucas1p29408e916eda327a5e9c83f64b0df4e66@eucas1p2.samsung.com>
	<20261026095423.966856-1-m.szyprowski@samsung.com>

On 26.10.2026 10:54, Marek Szyprowski wrote:
> This series collects fixes for the DMA-mapping code, developed while
> analyzing issues reported by the sashiko.dev automated review. All
> patches were prepared with LLM assistance and then reviewed manually.
>
> Best regards
> Marek Szyprowski, PhD
> Samsung R&D Institute Poland
>
>
> Marek Szyprowski (5):
>   dma-coherent: serialize reserved memory pool initialization
>   dma: swiotlb: Serialize restricted DMA pool initialization
>   dma: swiotlb: Remove default pool from the pools list on exit
>   dma-pool: release CMA pages on atomic_pool_expand() error path
>   dma-direct: zero memory allocated with DMA_ATTR_NO_KERNEL_MAPPING
Applied patches 1,2 & 4 to dma-mapping-fixes. The remaining two patches
need more work, I will post v2 soon.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

