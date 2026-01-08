Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD68428FF1
	for <iommu@lists.linux.dev>; Thu,  8 Jan 2026 12:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767876095; cv=none; b=K6zeB/Wn+J2I1OiUG25rI/lO6xjMmTOxHsuDAhszqpjA4eF9NcZ/wYmnmsDXpje+XfblyAMGCBPwirit/o7Tr/wAhYQIUDuk1+HyZ69S93zfsBCcP+AA+qJTpSFIeVxKCWXPveI35BXP4UoeWDGgQ8WA/wyRPLiL6+RRk+HK8C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767876095; c=relaxed/simple;
	bh=LDay9iU2RhsMNmt+xrxYRWq5ckJAiMS9aP+58wPumNw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=r98Ad8Q7u/NFCBmXVTAAkXmbqzcU1goA4LqeMvJ4cKE6YKcZDJxGrslb0E4Qop0FA9WjzHzL1+PJoBDA87WAmCCk/BulKXeX9oyOP9NKsh7F6FfNR5QTnq/0urd1Tu/cAtaXqz8aXubcXgF2hnfaAly6GM2crXS/+0Qn9n93Hgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=fpnrErLj; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="fpnrErLj"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20260108124131euoutp0102deced963a2cdb95769d7ef3f5cdc34~IwfBB_Jao1646916469euoutp01C
	for <iommu@lists.linux.dev>; Thu,  8 Jan 2026 12:41:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20260108124131euoutp0102deced963a2cdb95769d7ef3f5cdc34~IwfBB_Jao1646916469euoutp01C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1767876091;
	bh=NlVFzcWIEPwVZbCSWLse38Cy0IrbC/UlE/DZrlBOSYs=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=fpnrErLjowUYLy5cnHlmnvEwj9gVempw0WeMKt2vxelUoh7OrJjiU3L7Cbdp3IjV1
	 +rBqLgoNFsHAZxyNyxBFMForVQwfEWBmDTCxkcjrAq5D+O+vIwPO/nWBswhBPOSuI0
	 tFj0gKLcaJXMZ7fjw/Op6wlXhX4po3cZMm30HIBA=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20260108124129eucas1p216f81b7f87e33cf6fdfa8f174d5badb1~Iwe-inu632337923379eucas1p28;
	Thu,  8 Jan 2026 12:41:29 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260108124128eusmtip1f31981c522913c2feff48092abf7a7c5~Iwe_XlOjK1956719567eusmtip1H;
	Thu,  8 Jan 2026 12:41:28 +0000 (GMT)
Message-ID: <9f28b833-5813-4e5d-b705-eed9a2a31863@samsung.com>
Date: Thu, 8 Jan 2026 13:41:27 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH] dma-direct: Skip cache prep for HighMem coherent
 allocations
To: Robin Murphy <robin.murphy@arm.com>, "Aneesh Kumar K.V (Arm)"
	<aneesh.kumar@kernel.org>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@kernel.org>, Linus Walleij <linusw@kernel.org>,
	Matthew Wilcox <willy@infradead.org>, Suzuki K Poulose
	<suzuki.poulose@arm.com>
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <9cbe49ae-6612-491d-8ac6-6a99a08d73e2@arm.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20260108124129eucas1p216f81b7f87e33cf6fdfa8f174d5badb1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260108105031eucas1p2a3e8d0308ae6a5d43b5250ca8b14ecb9
X-EPHeader: CA
X-CMS-RootMailID: 20260108105031eucas1p2a3e8d0308ae6a5d43b5250ca8b14ecb9
References: <20260102155118.2551804-1-aneesh.kumar@kernel.org>
	<CGME20260108105031eucas1p2a3e8d0308ae6a5d43b5250ca8b14ecb9@eucas1p2.samsung.com>
	<9cbe49ae-6612-491d-8ac6-6a99a08d73e2@arm.com>

On 08.01.2026 11:50, Robin Murphy wrote:
> On 2026-01-02 3:51 pm, Aneesh Kumar K.V (Arm) wrote:
>> dma_direct_alloc() calls arch_dma_prep_coherent() to clean any dirty
>> cache lines from the kernel linear alias before creating a coherent
>> remapping.
>>
>> HighMem pages have no kernel alias mapping, so there are no alias cache
>> lines to clean. Skip arch_dma_prep_coherent() for HighMem allocations.
>
> This is assuming that caches are always cleaned when unmapping 
> highmem, and no still-mapped highmem pages are dirty - how is that 
> guaranteed? The fact that they're not in the linear map doesn't mean 
> they don't necessarily have kernel aliases in either vmalloc 
> pagetables or caches.


Right, so it is better to keep this unconditional 
arch_dma_prep_coherent() call. I will drop it from dma-mapping-fixes then.


Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

