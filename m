Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B424C354AFC
	for <iommu@lists.linux.dev>; Mon, 19 Jan 2026 09:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768814306; cv=none; b=bxCwu1qZpLizdQwcU1ri6UcAnht+oQ4IHU46YOAzrGU72A4FYNLPsxMbrkxszbK6zCM4X9aEymFUia9Lzg+BHUOL76GwjcKFPw55xM6gPa/OmJsHZVm4mu2yl/kuxjgkqc/8nXxrm9KN3eVTdr/xZDrra0Hs+rIwtNmIh1VyNfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768814306; c=relaxed/simple;
	bh=ztIhpomjChWShk8OfIZQb2LSJsV9jPEaot4Nj/EGIH4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=BemjuRqcSKHzk1hL/AJMLNjprdRES8YFfZMTP6Paml2feGhBOUrumoqwq7+5bTaTTjRVKWrqegRKSpJ/blibaD+QzUgn0lZcWe5434Y1pUnStkjeEJsMWiMyhjzpD6fqOtLmrJsXsWO6kEYTxaDHfvuyAKOIM6yQcBqTDoLg05I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=ZaejkwD7; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ZaejkwD7"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20260119091816euoutp0176bd4673b72ec13989c87a901d75296a~MFzsi9mVR2540725407euoutp01Y
	for <iommu@lists.linux.dev>; Mon, 19 Jan 2026 09:18:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20260119091816euoutp0176bd4673b72ec13989c87a901d75296a~MFzsi9mVR2540725407euoutp01Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1768814296;
	bh=lxGLr1Ztr/uaHK5KMbPiWvA4LnSBtPKF+TnAksXTpbs=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=ZaejkwD7XI5dNNint+Z7m301UwM/RQWhxpXY/B1vEUQyuzwh/YXoMqt5VtGVvHBPZ
	 WBOlMBRkaG4DGznCFzkBRE/ug9klxZK7KnqyjN2uSh2Now0Rz7RoN2+VcUxoGJdOMh
	 tPQBIAapawnFsslcqnk/VTF3mLOKwPoW7JSRlfyU=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260119091816eucas1p1d6ee1dccf9de95e35efcc2893c403aca~MFzsTbcYT2567925679eucas1p1j;
	Mon, 19 Jan 2026 09:18:16 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260119091815eusmtip2722ac516a576729143f8c048bd1eef8a~MFzrf8RFa2724127241eusmtip2y;
	Mon, 19 Jan 2026 09:18:15 +0000 (GMT)
Message-ID: <87dc0a06-5818-45f3-99c9-d1aef807873f@samsung.com>
Date: Mon, 19 Jan 2026 10:18:13 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH] dma-direct: Skip cache prep for HighMem coherent
 allocations
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@kernel.org>, Linus Walleij <linusw@kernel.org>,
	Matthew Wilcox <willy@infradead.org>, Suzuki K Poulose
	<suzuki.poulose@arm.com>
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <yq5ams2akznl.fsf@kernel.org>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20260119091816eucas1p1d6ee1dccf9de95e35efcc2893c403aca
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260108105031eucas1p2a3e8d0308ae6a5d43b5250ca8b14ecb9
X-EPHeader: CA
X-CMS-RootMailID: 20260108105031eucas1p2a3e8d0308ae6a5d43b5250ca8b14ecb9
References: <20260102155118.2551804-1-aneesh.kumar@kernel.org>
	<CGME20260108105031eucas1p2a3e8d0308ae6a5d43b5250ca8b14ecb9@eucas1p2.samsung.com>
	<9cbe49ae-6612-491d-8ac6-6a99a08d73e2@arm.com>
	<9f28b833-5813-4e5d-b705-eed9a2a31863@samsung.com>
	<1ada44db-63a9-43ac-81da-0bdd4e7b7363@arm.com> <yq5a4iov5vdn.fsf@kernel.org>
	<f827085f-0084-41d8-8ab5-a0ecfc0260d2@samsung.com>
	<yq5afr8bdnrj.fsf@kernel.org>
	<8a872e0c-f13e-4ff1-a939-bc6814b3ec3e@samsung.com>
	<yq5ams2akznl.fsf@kernel.org>

On 19.01.2026 05:13, Aneesh Kumar K.V wrote:
> Marek Szyprowski <m.szyprowski@samsung.com> writes:
>> On 12.01.2026 13:22, Aneesh Kumar K.V wrote:
>>> Marek Szyprowski <m.szyprowski@samsung.com> writes:
>>>> On 09.01.2026 04:15, Aneesh Kumar K.V wrote:
>>>>> Robin Murphy <robin.murphy@arm.com> writes:
>>>>>> On 2026-01-08 12:41 pm, Marek Szyprowski wrote:
>>>>>>> On 08.01.2026 11:50, Robin Murphy wrote:
>>>>>>>> On 2026-01-02 3:51 pm, Aneesh Kumar K.V (Arm) wrote:
>>>>>>>>> dma_direct_alloc() calls arch_dma_prep_coherent() to clean any dirty
>>>>>>>>> cache lines from the kernel linear alias before creating a coherent
>>>>>>>>> remapping.
>>>>>>>>>
>>>>>>>>> HighMem pages have no kernel alias mapping, so there are no alias cache
>>>>>>>>> lines to clean. Skip arch_dma_prep_coherent() for HighMem allocations.
>>>>>>>> This is assuming that caches are always cleaned when unmapping
>>>>>>>> highmem, and no still-mapped highmem pages are dirty - how is that
>>>>>>>> guaranteed? The fact that they're not in the linear map doesn't mean
>>>>>>>> they don't necessarily have kernel aliases in either vmalloc
>>>>>>>> pagetables or caches.
>>>>>>> Right, so it is better to keep this unconditional
>>>>>>> arch_dma_prep_coherent() call. I will drop it from dma-mapping-fixes then.
>>>>>> Yeah, I think the confusing thing here is that there are architectures
>>>>>> with CONFIG_HIGHMEM that don't actually check for and handle it in their
>>>>>> arch_dma_prep_coherent() as they seemingly should, however I'm not sure
>>>>>> off-hand whether they also support/use highmem CMA in the manner that
>>>>>> could end up being an issue in practice (the lack of any reports of
>>>>>> crashes or DMA corruption over the last however many years suggests not...)
>>>>>>
>>>>> Should we then remove the PageHighMem() check with DMA_ATTR_NO_KERNEL_MAPPING?
>>>> Right, this has to be unified.
>>> I had a related question, how do we handle cache flushes required for
>>> architectures that don't implement CONFIG_ARCH_HAS_DMA_PREP_COHERENT (arch/arm)?
>> ARM 32bit architecture provides arch_dma_alloc(), which handles cache
>> management internally.
>>
> But dma_direct_alloc does the below
>
> 	if ((attrs & DMA_ATTR_NO_KERNEL_MAPPING) &&
> 	    !force_dma_unencrypted(dev) && !is_swiotlb_for_alloc(dev))
> 		return dma_direct_alloc_no_mapping(dev, size, dma_handle, gfp);
>
> 	if (!dev_is_dma_coherent(dev)) {
> 		if (IS_ENABLED(CONFIG_ARCH_HAS_DMA_ALLOC) &&
> 		    !is_swiotlb_for_alloc(dev))
> 			return arch_dma_alloc(dev, size, dma_handle, gfp,
> 					      attrs);
>
> IIUC, this implies we won't call arch_dma_alloc for
> DMA_ATTR_NO_KERNEL_MAPPING ?

It looks that commit 849facea92fa ("dma-direct: simplify the 
DMA_ATTR_NO_KERNEL_MAPPING handling") changed this. Before that 
arch_dma_alloc() was called regardless of the provided DMA attrs. 
Indeed, this should be fixed. Frankly speaking this probably means that 
there are no active users of this combination (arch/arm, 
DMA_ATTR_NO_KERNEL_MAPPING and dma-direct) or nobody cares.

The DMA_ATTR_NO_KERNEL_MAPPING attribute was initially introduced for 
the DMA-IOMMU based implementation, where it saves significant amount of 
resources.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

