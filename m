Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18DDF361647
	for <iommu@lists.linux.dev>; Fri, 16 Jan 2026 10:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768559388; cv=none; b=Jn6xOy+2H9sRyc5ZSL/8nICMPh0Q0IlagwfcA+rmm9yUJtuKGD3nzsfrfbwxRkVKojansXfQ+23KPP54dPaq4c8SOeHssN/Is99AkYYDIyNTdU8S8Mq9tEA+EpDQcXzMi/2lPiK/4nujP1QZvDdTB7sClSse0NBd1sCU4PpvJKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768559388; c=relaxed/simple;
	bh=ri6n2FJjzjo4MlesnuPS2v2nLwbKMnFeTzAhfoVGV6A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=D0+jSe6iWeah1wjLJ4+bE2qwYWoV6Wiu5S0LV6k5MMBdd3m4lbjqwyyo0KaZDIPZLT7y4W9Sijcj5p43E7SaUxTLndAxCdLC+0vxxXB4NN4/pe/CIyjnW8yCDzZOoB2saBcsItHtatRPXz1bF7Uwbf23pk6iqETDCZtv4USJg/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=UUJ2GXx4; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="UUJ2GXx4"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20260116102939euoutp011afae805bd16cf4f03f72c4f0d86cebf~LL2KTtte80169501695euoutp01L
	for <iommu@lists.linux.dev>; Fri, 16 Jan 2026 10:29:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20260116102939euoutp011afae805bd16cf4f03f72c4f0d86cebf~LL2KTtte80169501695euoutp01L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1768559379;
	bh=Uq1ZZ4FhIYQqQu1RdtWRuRDWiMZMMg/77Oe2VQKcmjY=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=UUJ2GXx434F+ethg/HyjrmryfOaCARz6D9tfsdAXOHQQ5za9/lMAHxCoyW5uLYhbp
	 VzgJdtfRnUAZ1ExjkzuxkGLpJobMxmT3Z4SDi0R8JYdJL/LNVLc875X+HSs8YPvxHe
	 Lc7M9R4/hPrZKGBW49lN0o0KpfUHeJNaF6vZ69PI=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260116102938eucas1p1e60ec793ea515699dd6abd92b9da99ae~LL2KD_hbH0529605296eucas1p1j;
	Fri, 16 Jan 2026 10:29:38 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260116102937eusmtip2b794af29ef4c05016c35e39902696cdd~LL2JLVLVC1042410424eusmtip2P;
	Fri, 16 Jan 2026 10:29:37 +0000 (GMT)
Message-ID: <8a872e0c-f13e-4ff1-a939-bc6814b3ec3e@samsung.com>
Date: Fri, 16 Jan 2026 11:29:37 +0100
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
In-Reply-To: <yq5afr8bdnrj.fsf@kernel.org>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20260116102938eucas1p1e60ec793ea515699dd6abd92b9da99ae
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

On 12.01.2026 13:22, Aneesh Kumar K.V wrote:
> Marek Szyprowski <m.szyprowski@samsung.com> writes:
>> On 09.01.2026 04:15, Aneesh Kumar K.V wrote:
>>> Robin Murphy <robin.murphy@arm.com> writes:
>>>> On 2026-01-08 12:41 pm, Marek Szyprowski wrote:
>>>>> On 08.01.2026 11:50, Robin Murphy wrote:
>>>>>> On 2026-01-02 3:51 pm, Aneesh Kumar K.V (Arm) wrote:
>>>>>>> dma_direct_alloc() calls arch_dma_prep_coherent() to clean any dirty
>>>>>>> cache lines from the kernel linear alias before creating a coherent
>>>>>>> remapping.
>>>>>>>
>>>>>>> HighMem pages have no kernel alias mapping, so there are no alias cache
>>>>>>> lines to clean. Skip arch_dma_prep_coherent() for HighMem allocations.
>>>>>> This is assuming that caches are always cleaned when unmapping
>>>>>> highmem, and no still-mapped highmem pages are dirty - how is that
>>>>>> guaranteed? The fact that they're not in the linear map doesn't mean
>>>>>> they don't necessarily have kernel aliases in either vmalloc
>>>>>> pagetables or caches.
>>>>> Right, so it is better to keep this unconditional
>>>>> arch_dma_prep_coherent() call. I will drop it from dma-mapping-fixes then.
>>>> Yeah, I think the confusing thing here is that there are architectures
>>>> with CONFIG_HIGHMEM that don't actually check for and handle it in their
>>>> arch_dma_prep_coherent() as they seemingly should, however I'm not sure
>>>> off-hand whether they also support/use highmem CMA in the manner that
>>>> could end up being an issue in practice (the lack of any reports of
>>>> crashes or DMA corruption over the last however many years suggests not...)
>>>>
>>> Should we then remove the PageHighMem() check with DMA_ATTR_NO_KERNEL_MAPPING?
>> Right, this has to be unified.
> I had a related question, how do we handle cache flushes required for
> architectures that don't implement CONFIG_ARCH_HAS_DMA_PREP_COHERENT (arch/arm)?

ARM 32bit architecture provides arch_dma_alloc(), which handles cache 
management internally.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

