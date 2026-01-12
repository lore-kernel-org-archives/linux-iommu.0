Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8AC930BF60
	for <iommu@lists.linux.dev>; Mon, 12 Jan 2026 09:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768208909; cv=none; b=Orf7zo9Pubu0axibOjo8NC8VtnMUNqVjTLSZXmF4X32iLRKsUAOlFHqr8c3EyUKP48axaIn7rUi1MWgjSlQuyBd1nD6TajMDVXqjBuymDGwk8K3AtqdOKgzBvd4oHpZLs795Cfbf3YBSAwueBgyDGtB6lNQxyNp/IYOnq2MHToA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768208909; c=relaxed/simple;
	bh=NIKG/fWWZUQJ9nKmE4csAQFxa+ccfhenJvvFFyXhAIA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=sAYrfos5xdN8LrSJJJEfCMJSn05/vEDsTa3jGxBTq4mPz0EpWvNktTNU+iFcn3pMSzlILqIQJrjNa/Ar1h9+2raEuWoUDtxEDYTcFZds08IzqMQ3waaJ/DaBhnZ2MpE5ODfnm8QoOcLjjqOUAK6gA8obiaSAp2h/aDBl4Ec6w74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=lyXGYjTJ; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="lyXGYjTJ"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20260112090819euoutp0103f8b07e387e30e05927e86ad25cc7be~J8KAgBS9d2752527525euoutp01b
	for <iommu@lists.linux.dev>; Mon, 12 Jan 2026 09:08:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20260112090819euoutp0103f8b07e387e30e05927e86ad25cc7be~J8KAgBS9d2752527525euoutp01b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1768208899;
	bh=BSCp3hWgL5gu7IC9MwOIrAojHPTgVZm1FS4frjal49Q=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=lyXGYjTJkodlJidrV4cceT5P4sbQURmiv6XXImQYsi49L+vouPFWbBQIZsBmWB3bM
	 GcOM0pxeAAqnx+zqGjmvHrvmQHs3TDWOGfTPw04nL2KRraNDMnxsLe62bRGHvOxkky
	 MDK38BrJPza2iSxxqlIK1f+TVa3GRO9Tcgi2B7y0=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20260112090818eucas1p23a3171f74868eaa99e9d2450d94dc4a7~J8KARG2060114901149eucas1p2y;
	Mon, 12 Jan 2026 09:08:18 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260112090818eusmtip2d28cc9d01ecf149feb316cfac63644e0~J8J-xE04w0071800718eusmtip2T;
	Mon, 12 Jan 2026 09:08:18 +0000 (GMT)
Message-ID: <f827085f-0084-41d8-8ab5-a0ecfc0260d2@samsung.com>
Date: Mon, 12 Jan 2026 10:08:18 +0100
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
In-Reply-To: <yq5a4iov5vdn.fsf@kernel.org>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20260112090818eucas1p23a3171f74868eaa99e9d2450d94dc4a7
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

On 09.01.2026 04:15, Aneesh Kumar K.V wrote:
> Robin Murphy <robin.murphy@arm.com> writes:
>> On 2026-01-08 12:41 pm, Marek Szyprowski wrote:
>>> On 08.01.2026 11:50, Robin Murphy wrote:
>>>> On 2026-01-02 3:51 pm, Aneesh Kumar K.V (Arm) wrote:
>>>>> dma_direct_alloc() calls arch_dma_prep_coherent() to clean any dirty
>>>>> cache lines from the kernel linear alias before creating a coherent
>>>>> remapping.
>>>>>
>>>>> HighMem pages have no kernel alias mapping, so there are no alias cache
>>>>> lines to clean. Skip arch_dma_prep_coherent() for HighMem allocations.
>>>> This is assuming that caches are always cleaned when unmapping
>>>> highmem, and no still-mapped highmem pages are dirty - how is that
>>>> guaranteed? The fact that they're not in the linear map doesn't mean
>>>> they don't necessarily have kernel aliases in either vmalloc
>>>> pagetables or caches.
>>> Right, so it is better to keep this unconditional
>>> arch_dma_prep_coherent() call. I will drop it from dma-mapping-fixes then.
>> Yeah, I think the confusing thing here is that there are architectures
>> with CONFIG_HIGHMEM that don't actually check for and handle it in their
>> arch_dma_prep_coherent() as they seemingly should, however I'm not sure
>> off-hand whether they also support/use highmem CMA in the manner that
>> could end up being an issue in practice (the lack of any reports of
>> crashes or DMA corruption over the last however many years suggests not...)
>>
> Should we then remove the PageHighMem() check with DMA_ATTR_NO_KERNEL_MAPPING?

Right, this has to be unified.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

