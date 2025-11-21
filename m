Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37CE34DCD1
	for <iommu@lists.linux.dev>; Fri, 21 Nov 2025 16:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763741365; cv=none; b=Ve01XN87m73rfuojroYpBG/H6mxHUJy5hco37OJEkqTIUQcwobRnEIEw8Rr7lvMtDBxfMuTVgO+gdzKM/PKtz/typZG1OAAm1xo0ZktZ9JlGld/YK5nKjVyZaCy7XzbDw0rOQ0GWkYjds4fQzdgjP/2Pu6x5jV0zObdnJp1XxjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763741365; c=relaxed/simple;
	bh=Cgt4gsHh0JmHc/3lhWtapEF1aoXtf1qnMD5fEfsh5Ws=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=qpdPZFqupE/DnhlOwbcPLpeYVOk/jnFP/koLgWnkf8Fax1x4jCm39WMet4sjaO98F1OMkRaXprI1YXSwTIpJebB2BhGj0TKBRCdXnTydfKEmSx7ZCpKNa+AqhssG86D0Y3YeMPLdalhgNQ+7Vocuff2aKePONfiMNy+V4T3EhNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=oxgqOZSQ; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="oxgqOZSQ"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20251121160919euoutp02ffdeaffa231f0c95d0e342c51e9fa918~6EWwIRN5O0616206162euoutp02F
	for <iommu@lists.linux.dev>; Fri, 21 Nov 2025 16:09:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20251121160919euoutp02ffdeaffa231f0c95d0e342c51e9fa918~6EWwIRN5O0616206162euoutp02F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1763741359;
	bh=cEIFEsZjqLqTlAWa7FShEGjSydpKYXhq+/BbMr0lwwA=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=oxgqOZSQxx6UWDH3ITx/ESED4l8z4OtkINJsp9yoIsFW1b3/SQi7iZXbriA1xHoq7
	 FJvKprbYcyk9KG+dMP2rvOPX1Mf+oyXI53f/YSr9Hc1sCUhJIX8Jr4UqFf5KJlROOn
	 xBCkkGRXDFu0mzChCK/ktj/OnV90TiGRffVLDJpk=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20251121160919eucas1p2c41767600decb68d934fbdc9b7a94327~6EWvoH0ml1074810748eucas1p2S;
	Fri, 21 Nov 2025 16:09:19 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20251121160917eusmtip26751c3f185d43eb406d8d849751bef2a~6EWuCd3h_1221312213eusmtip2o;
	Fri, 21 Nov 2025 16:09:17 +0000 (GMT)
Message-ID: <253c870f-770b-4102-be47-f8c06e9e6c31@samsung.com>
Date: Fri, 21 Nov 2025 17:09:16 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [RFC PATCH 5/5] dma-mapping: Allow batched DMA sync operations
 if supported by the arch
To: Barry Song <21cnbao@gmail.com>, catalin.marinas@arm.com
Cc: ada.coupriediaz@arm.com, anshuman.khandual@arm.com, ardb@kernel.org,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, maz@kernel.org, robin.murphy@arm.com,
	ryan.roberts@arm.com, surenb@google.com, v-songbaohua@oppo.com,
	will@kernel.org, zhengtangquan@oppo.com
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20251117211238.50126-1-21cnbao@gmail.com>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20251121160919eucas1p2c41767600decb68d934fbdc9b7a94327
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20251117211252eucas1p19e6b369400971b6b9407ae63aaa4c299
X-EPHeader: CA
X-CMS-RootMailID: 20251117211252eucas1p19e6b369400971b6b9407ae63aaa4c299
References: <aRYhJO9_eR9W-EnZ@arm.com>
	<CGME20251117211252eucas1p19e6b369400971b6b9407ae63aaa4c299@eucas1p1.samsung.com>
	<20251117211238.50126-1-21cnbao@gmail.com>

Hi Barry,

On 17.11.2025 22:12, Barry Song wrote:
> On Fri, Nov 14, 2025 at 2:19 AM Catalin Marinas <catalin.marinas@arm.com> wrote:
>> On Wed, Oct 29, 2025 at 10:31:15AM +0800, Barry Song wrote:
>>> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
>>> index 1f9ee9759426..a0b45f84a91f 100644
>>> --- a/kernel/dma/direct.c
>>> +++ b/kernel/dma/direct.c
>>> @@ -403,9 +403,16 @@ void dma_direct_sync_sg_for_device(struct device *dev,
>>>                swiotlb_sync_single_for_device(dev, paddr, sg->length, dir);
>>>
>>>                if (!dev_is_dma_coherent(dev))
>>> -                     arch_sync_dma_for_device(paddr, sg->length,
>>> -                                     dir);
>>> +#ifdef CONFIG_ARCH_WANT_BATCHED_DMA_SYNC
>>> +                     arch_sync_dma_for_device_batch_add(paddr, sg->length, dir);
>>> +#else
>>> +                     arch_sync_dma_for_device(paddr, sg->length, dir);
>>> +#endif
>>>        }
>>> +#ifdef CONFIG_ARCH_WANT_BATCHED_DMA_SYNC
>>> +     if (!dev_is_dma_coherent(dev))
>>> +             arch_sync_dma_batch_flush();
>>> +#endif
>>>   }
>>>   #endif
>> Just a high-level comment for now. I'm not opposed to the idea of
>> batching the DSB barriers, we do this for ptes. However, the way it's
>
> Thanks, Catalin. I agree we need batching, as phones and embedded systems
> could use many DMA buffers while some chips lack DMA-coherency.
>
>
>> implemented in the generic files, with lots of #ifdefs, makes the code
>> pretty unreadable.
>>
>> Can we have something like arch_sync_dma_begin/end() and let the arch
>> code handle the barriers as they see fit?
>
> I guess I can refactor it as below and then remove the #ifdef/#else/#endif blocks.
>
> diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
> index 8fcd0a9c1f39..73bca4d7149d 100644
> --- a/include/linux/dma-map-ops.h
> +++ b/include/linux/dma-map-ops.h
> @@ -373,6 +373,20 @@ void arch_sync_dma_for_device_batch_add(phys_addr_t paddr, size_t size,
>   void arch_sync_dma_for_cpu_batch_add(phys_addr_t paddr, size_t size,
>   		enum dma_data_direction dir);
>   void arch_sync_dma_batch_flush(void);
> +#else
> +static inline void arch_sync_dma_for_device_batch_add(phys_addr_t paddr, size_t size,
> +		enum dma_data_direction dir)
> +{
> +	arch_sync_dma_for_device(paddr, size, dir);
> +}
> +static inline void arch_sync_dma_for_cpu_batch_add(phys_addr_t paddr, size_t size,
> +		enum dma_data_direction dir)
> +{
> +	arch_sync_dma_for_cpu(paddr, size, dir);
> +}
> +static inline void arch_sync_dma_batch_flush(void)
> +{
> +}
>   #endif
>   
>   #ifdef CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index a0b45f84a91f..69b14b0c0501 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -403,16 +403,10 @@ void dma_direct_sync_sg_for_device(struct device *dev,
>   		swiotlb_sync_single_for_device(dev, paddr, sg->length, dir);
>   
>   		if (!dev_is_dma_coherent(dev))
> -#ifdef CONFIG_ARCH_WANT_BATCHED_DMA_SYNC
>   			arch_sync_dma_for_device_batch_add(paddr, sg->length, dir);
> -#else
> -			arch_sync_dma_for_device(paddr, sg->length, dir);
> -#endif
>   	}
> -#ifdef CONFIG_ARCH_WANT_BATCHED_DMA_SYNC
>   	if (!dev_is_dma_coherent(dev))
>   		arch_sync_dma_batch_flush();
> -#endif
>   }
>   #endif
>   
> @@ -429,11 +423,7 @@ void dma_direct_sync_sg_for_cpu(struct device *dev,
>   		phys_addr_t paddr = dma_to_phys(dev, sg_dma_address(sg));
>   
>   		if (!dev_is_dma_coherent(dev))
> -#ifdef CONFIG_ARCH_WANT_BATCHED_DMA_SYNC
>   			arch_sync_dma_for_cpu_batch_add(paddr, sg->length, dir);
> -#else
> -			arch_sync_dma_for_cpu(paddr, sg->length, dir);
> -#endif
>   
>   		swiotlb_sync_single_for_cpu(dev, paddr, sg->length, dir);
>   
> @@ -443,9 +433,7 @@ void dma_direct_sync_sg_for_cpu(struct device *dev,
>   
>   	if (!dev_is_dma_coherent(dev)) {
>   		arch_sync_dma_for_cpu_all();
> -#ifdef CONFIG_ARCH_WANT_BATCHED_DMA_SYNC
>   		arch_sync_dma_batch_flush();
> -#endif
>   	}
>   }
>   
> @@ -458,29 +446,19 @@ void dma_direct_unmap_sg(struct device *dev, struct scatterlist *sgl,
>   {
>   	struct scatterlist *sg;
>   	int i;
> -#ifdef CONFIG_ARCH_WANT_BATCHED_DMA_SYNC
>   	bool need_sync = false;
> -#endif
>   
>   	for_each_sg(sgl,  sg, nents, i) {
>   		if (sg_dma_is_bus_address(sg)) {
>   			sg_dma_unmark_bus_address(sg);
>   		} else {
> -#ifdef CONFIG_ARCH_WANT_BATCHED_DMA_SYNC
>   			need_sync = true;
>   			dma_direct_unmap_phys_batch_add(dev, sg->dma_address,
>   					      sg_dma_len(sg), dir, attrs);
> -
> -#else
> -			dma_direct_unmap_phys(dev, sg->dma_address,
> -					      sg_dma_len(sg), dir, attrs);
> -#endif
>   		}
>   	}
> -#ifdef CONFIG_ARCH_WANT_BATCHED_DMA_SYNC
>   	if (need_sync && !dev_is_dma_coherent(dev))
>   		arch_sync_dma_batch_flush();
> -#endif
>   }
>   #endif
>   
> @@ -490,9 +468,7 @@ int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
>   	struct pci_p2pdma_map_state p2pdma_state = {};
>   	struct scatterlist *sg;
>   	int i, ret;
> -#ifdef CONFIG_ARCH_WANT_BATCHED_DMA_SYNC
>   	bool need_sync = false;
> -#endif
>   
>   	for_each_sg(sgl, sg, nents, i) {
>   		switch (pci_p2pdma_state(&p2pdma_state, dev, sg_page(sg))) {
> @@ -504,14 +480,9 @@ int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
>   			 */
>   			break;
>   		case PCI_P2PDMA_MAP_NONE:
> -#ifdef CONFIG_ARCH_WANT_BATCHED_DMA_SYNC
>   			need_sync = true;
>   			sg->dma_address = dma_direct_map_phys_batch_add(dev, sg_phys(sg),
>   					sg->length, dir, attrs);
> -#else
> -			sg->dma_address = dma_direct_map_phys(dev, sg_phys(sg),
> -					sg->length, dir, attrs);
> -#endif
>   			if (sg->dma_address == DMA_MAPPING_ERROR) {
>   				ret = -EIO;
>   				goto out_unmap;
> @@ -529,10 +500,8 @@ int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
>   		sg_dma_len(sg) = sg->length;
>   	}
>   
> -#ifdef CONFIG_ARCH_WANT_BATCHED_DMA_SYNC
>   	if (need_sync && !dev_is_dma_coherent(dev))
>   		arch_sync_dma_batch_flush();
> -#endif
>   	return nents;
>   
>   out_unmap:
>
>
This version looks a bit better to me. Similar batching could be added 
also to dma_iova_link()/dma_iova_sync() paths.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

