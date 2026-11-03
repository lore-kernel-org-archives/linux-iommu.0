Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.118.77.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793712397;
	b=cNBeaDg0mDmUMjdQOniAHpkQnn0Vwo1uIdDhfUr8gYA/AC+DEPjOoJK3XfXbYJBTgs9c
	 /lxRfjnoOrHpkhmGwABCmH2mLR7e/WJz0S3APJwlJ21/GiDIeTkpSleARk6bgqu2YoAJO
	 v7UsSH6a9LsBkaR550vUzTGwrZLvqinKoMtPio9XL5o7zHDwirLzyjXH03zXPtTw0V67K
	 qk6s3EW3LLrGfPR7pbgrXrQYaoH5JsEAKTvktUiVBFvCZgsrYieJsdu8CxE0tO7Lol9Dv
	 UIt1YmIekLXEQgDaqvdKgKmMeZZAE1FWSX63uzJhvl5zBZJCdkkc5+25IclOmRwIATg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793712397;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 Content-Language:From:In-Reply-To:Content-Transfer-Encoding:
	 X-CMS-MailID:X-Msg-Generator:Content-Type:X-RootMTR:X-EPHeader:
	 X-CMS-RootMailID:References;
	bh=2w/cBt8SFV6c6sgzQ509UEQpLuc3Rotm2hPM5F68N64=;
	b=wPb/x69s81rRtHWa4PX1mN+lm3mlfTkzRELRD2uVNnBotNhuBBdtExzbgmIV4/21m9rW
	 EhujdHIsec7df2etMwWEkXmhH4fIQDUrtvSCRAgiad9ZWZZA/UXOmWWl/sHx0nKpl8Oug
	 1N4X+xswZCf0oB+in2/9QkrgQBxNSRywb2IHRdW+G9OAk19KeNExObVV/UCMxYfe1nK2k
	 aT05d+SOyXt28mwUgwFoh1Alk/cDsgAK+OgByt3W0VJtpzmiD+SOuolrgU4ijYZxUI55p
	 ksZV3PAsusVic8k7VZhvig9oc0rTEKdj9xdroEGqnPa2J2FB/I6Ili4aq/SCepJvY7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=samsung.com;
	spf=pass smtp.mailfrom=samsung.com;
	dkim=pass header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=dGs7N5G+;
	arc=none smtp.remote-ip=210.118.77.11
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A6F606A32E
	for <iommu@lists.linux.dev>; Tue,  3 Nov 2026 13:26:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D4A6F606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=dGs7N5G+
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20261103132635euoutp015ae62b4a459783f485df65cc071c1f68~ki_uBF8fF2300423004euoutp01F
	for <iommu@lists.linux.dev>; Tue,  3 Nov 2026 13:26:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20261103132635euoutp015ae62b4a459783f485df65cc071c1f68~ki_uBF8fF2300423004euoutp01F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1793712395;
	bh=2w/cBt8SFV6c6sgzQ509UEQpLuc3Rotm2hPM5F68N64=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=dGs7N5G+hpsS7t4gKSXfSOkYOZx3K14sJjRRZv6NcXJ39ggWQVZEcUDQA2jE82R79
	 rMxVh5iN6b4eH8C6VJYUBTDozSIVirVLdWgui8CNEKIvtrqyWAEiDtpqKCtO4UPgcn
	 +3KppBaFaMej7QYEYzF9SiQHmrxmvUQG+qHF9Q04=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20261103132634eucas1p2997b284ddb7acd9b517acdc393ff0850~ki_tk2fbs0707007070eucas1p2Z;
	Tue,  3 Nov 2026 13:26:34 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20261103132634eusmtip1521231d3ad2b41212f89afb56933a604~ki_s7sOoN1604916049eusmtip1e;
	Tue,  3 Nov 2026 13:26:33 +0000 (GMT)
Message-ID: <852a953d-8a75-4d2c-892e-9566126883f2@samsung.com>
Date: Tue, 3 Nov 2026 14:26:33 +0100
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
Subject: Re: [RFC 02/11] dma-direct: pass the NUMA node to
 dma_direct_alloc()
To: Jakub Kicinski <kuba@kernel.org>, robin.murphy@arm.com
Cc: tglx@kernel.org, dave.hansen@linux.intel.com, x86@kernel.org,
	joro@8bytes.org, will@kernel.org, leon@kernel.org, mbloch@nvidia.com,
	iommu@lists.linux.dev, netdev@vger.kernel.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20261027022528.633359-3-kuba@kernel.org>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20261103132634eucas1p2997b284ddb7acd9b517acdc393ff0850
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261027022612eucas1p212c4f3c149e121940f3ebe190164fb57
X-EPHeader: CA
X-CMS-RootMailID: 20261027022612eucas1p212c4f3c149e121940f3ebe190164fb57
References: <20261027022528.633359-1-kuba@kernel.org>
	<CGME20261027022612eucas1p212c4f3c149e121940f3ebe190164fb57@eucas1p2.samsung.com>
	<20261027022528.633359-3-kuba@kernel.org>

On 27.10.2026 03:25, Jakub Kicinski wrote:
> dma_direct_alloc() allocates the pages on the node of the device.
> Pass the node in explicitly, so that a node-aware coherent allocation
> API can be layered on top.
>
> Memory from the atomic pools, the global coherent pool, restricted
> swiotlb pools and arch_dma_alloc() is not node-aware, the node is only
> used for the page allocator and the per-numa CMA areas.
>
> Callers pass dev_to_node() for now, no functional change.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>


> ---
>  include/linux/dma-direct.h    |  2 +-
>  arch/x86/kernel/amd_gart_64.c |  3 ++-
>  kernel/dma/direct.c           | 18 ++++++++++--------
>  kernel/dma/mapping.c          |  3 ++-
>  4 files changed, 15 insertions(+), 11 deletions(-)
>
> ...

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

