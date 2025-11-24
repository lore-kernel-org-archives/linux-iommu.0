Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21802C21EB
	for <iommu@lists.linux.dev>; Mon, 24 Nov 2025 18:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764007880; cv=none; b=iXnJc9RbXlEGGJZJHpE2ZZX+xOT68kKXG+/6u4raQKoKdqL5R6c4ec9xHHDdbT8wwkY+FBxhhu7vc7SzOZk4vnMnPc1FgpVs/4knzFsDUIu4HHbZ3GJd09/jQNJKCdh5edAAavAizm79jwrOxCE9TiY27MihTT/UANKCHgdMbxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764007880; c=relaxed/simple;
	bh=V3lKiCOqTmuSyHMCBiRRzu0/4INcRYOmWSJXw1oQ7xY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=WfsbY4nEoFqlcSIfcWi2/2tDo3xCEcYDowzGoud7UnEJmryyWrVUoeu1pn4zrTndCgtPuf0haxy1ERMIYOIPXHOGu1cazTdcsF0ZN/WoH+7TDL9PRLe5R3J6m3fQORKXga9MSbw3eBrST1CrJqM+dcDNJit4m4n55w1Y12MkgT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=MoVOKuxN; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="MoVOKuxN"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20251124181116euoutp0232e8b692f0fb4e5cd7a35b297f3b8aa9~7A9Evot2T2497124971euoutp02J
	for <iommu@lists.linux.dev>; Mon, 24 Nov 2025 18:11:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20251124181116euoutp0232e8b692f0fb4e5cd7a35b297f3b8aa9~7A9Evot2T2497124971euoutp02J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1764007876;
	bh=mAKEXc7Po5ZcQ8NHiJ/6YgIjS+LUifyXpnXyqV/E/2I=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=MoVOKuxNGqVDeVT0yIHn45anwe5rIfm5oBvd0Acai2JzB0E7TmmbJ5TsMrz6n/mHm
	 mHz0iuvdGe8j28YB5ykYU9GPrewVcVVX1gca64ezZGlspj2oz6wKr6cKC5Q8tbHRM+
	 w/9zfZjRlrVgXWZ1qf32pCj26qfg8HMxviOMO3uo=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20251124181115eucas1p194eb1fe47ad6b90c5e22bd8ed2e0bfbb~7A9EJtcS63164331643eucas1p1C;
	Mon, 24 Nov 2025 18:11:15 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20251124181113eusmtip137fc2398eb412a7d397c6aee5961bac6~7A9Cu-DoB1470614706eusmtip1-;
	Mon, 24 Nov 2025 18:11:13 +0000 (GMT)
Message-ID: <f8a0b873-b93c-4a91-b47d-2d11bfcf36b4@samsung.com>
Date: Mon, 24 Nov 2025 19:11:13 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [RFC PATCH 5/5] dma-mapping: Allow batched DMA sync operations
 if supported by the arch
To: Barry Song <21cnbao@gmail.com>
Cc: ada.coupriediaz@arm.com, anshuman.khandual@arm.com, ardb@kernel.org,
	catalin.marinas@arm.com, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	maz@kernel.org, robin.murphy@arm.com, ryan.roberts@arm.com,
	surenb@google.com, v-songbaohua@oppo.com, will@kernel.org,
	zhengtangquan@oppo.com
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20251121232807.40491-1-21cnbao@gmail.com>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20251124181115eucas1p194eb1fe47ad6b90c5e22bd8ed2e0bfbb
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20251121232820eucas1p13f5798a2d8c5049ae7cadc62cce63df7
X-EPHeader: CA
X-CMS-RootMailID: 20251121232820eucas1p13f5798a2d8c5049ae7cadc62cce63df7
References: <253c870f-770b-4102-be47-f8c06e9e6c31@samsung.com>
	<CGME20251121232820eucas1p13f5798a2d8c5049ae7cadc62cce63df7@eucas1p1.samsung.com>
	<20251121232807.40491-1-21cnbao@gmail.com>

On 22.11.2025 00:28, Barry Song wrote:
> On Sat, Nov 22, 2025 at 12:09 AM Marek Szyprowski <m.szyprowski@samsung.com> wrote:
> [...]
>> This version looks a bit better to me. Similar batching could be added
>> also to dma_iova_link()/dma_iova_sync() paths.
> Thanks, Marek. I will respin a new version. For dma_iova, I assume you meant
> something like the following?
>
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 7944a3af4545..7bb6ed663236 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -1837,7 +1837,7 @@ static int __dma_iova_link(struct device *dev, dma_addr_t addr,
>   	int prot = dma_info_to_prot(dir, coherent, attrs);
>   
>   	if (!coherent && !(attrs & (DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_MMIO)))
> -		arch_sync_dma_for_device(phys, size, dir);
> +		arch_sync_dma_for_device_batch_add(phys, size, dir);
>   
>   	return iommu_map_nosync(iommu_get_dma_domain(dev), addr, phys, size,
>   			prot, GFP_ATOMIC);
> @@ -1980,6 +1980,8 @@ int dma_iova_sync(struct device *dev, struct dma_iova_state *state,
>   	dma_addr_t addr = state->addr + offset;
>   	size_t iova_start_pad = iova_offset(iovad, addr);
>   
> +	if (!dev_is_dma_coherent(dev))
> +		arch_sync_dma_batch_flush();
>   	return iommu_sync_map(domain, addr - iova_start_pad,
>   		      iova_align(iovad, size + iova_start_pad));
>   }
>
> If so, I don't really have such hardware to test. I wonder if I can make it as
> patch 6/6 when respinning, and still mark it as RFC v2. Or should I leave it as
> is and expect someone with the hardware to test and send it?

Yes, I meant something like the above diff, also for dma_iova_unlink(). 
It can be an additional, 6th patch with RFC tag, assuming You have no 
way to test it.

Please notice that I've just sent a patch touching the similar code paths:

https://lore.kernel.org/all/20251124170955.3884351-1-m.szyprowski@samsung.com/

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

