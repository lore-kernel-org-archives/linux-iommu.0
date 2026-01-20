Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E4C34A77F;
	Tue, 20 Jan 2026 09:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768902607; cv=none; b=buPUIYU4FWy2QDh5zDURpgqLPqkjpYcsXd7VK2DxwGnzRoWSf/SwUZkMgzDxpO+S6QgH99V/Lhve5nMshiGcQbcpWGwkpHpUE2lxl8FIpbkJW1U9tZmPrvM09ZpZ4iBSO/GUzFMV0usAOnlvWXOB4evRWwrbzz4VxacMq/qvv2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768902607; c=relaxed/simple;
	bh=wK35c35gu+tBkwYBS533CiS2O+AHznWXGgIxYjxVurA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gzHmH8Ut2h94bhuE+WMVVYESXGaunZcPejAQlpCWxl47SSMAMBxVPFN0srPF4XAAQoPT+1tlHXLBs8Hb8kyHYDMuh8Ab9OKIDZ4lAaI4RAWzRfi55KCYuEyhWt0FwO9qfb73u8ALZ0+OCEjrSv/HuFfpQn2eEOyPidbEDGQRLYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bkWqG5VX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bkWqG5VX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B0D1C16AAE;
	Tue, 20 Jan 2026 09:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768902606;
	bh=wK35c35gu+tBkwYBS533CiS2O+AHznWXGgIxYjxVurA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=bkWqG5VXUnGSQK3L2AXbRkhfT5p0w8i65e/sJkXJd/l0iToOGSRXhUkukxHVJ0e8F
	 EvSsWY/X9R+tE5GW31BWTW/rFYUtN3671l37pw26hfZQ7xaF88CKlOsv0hW0wBVPNT
	 CWqIlQX9uvJaSpVS8WTRI4UxZ6COeGLKuLrayR8aD1y/LKiFtqO/y3AhScF9/FWmL/
	 qsHuRB0zAlKvH+6CPSU9Mf501b6OTDeosVDbELM30ERbycKgNVMNQshFdrqi+1S42t
	 d1b5yKxJ3bhH8nmYktOisxKlEkP546rTGlM/ymr9j1xaIfhQqamwiHB4OSrN7JJtdc
	 ZLzSc0koVbqLA==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@kernel.org>, Linus Walleij <linusw@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: Re: [PATCH] dma-direct: Skip cache prep for HighMem coherent
 allocations
In-Reply-To: <87dc0a06-5818-45f3-99c9-d1aef807873f@samsung.com>
References: <20260102155118.2551804-1-aneesh.kumar@kernel.org>
 <CGME20260108105031eucas1p2a3e8d0308ae6a5d43b5250ca8b14ecb9@eucas1p2.samsung.com>
 <9cbe49ae-6612-491d-8ac6-6a99a08d73e2@arm.com>
 <9f28b833-5813-4e5d-b705-eed9a2a31863@samsung.com>
 <1ada44db-63a9-43ac-81da-0bdd4e7b7363@arm.com>
 <yq5a4iov5vdn.fsf@kernel.org>
 <f827085f-0084-41d8-8ab5-a0ecfc0260d2@samsung.com>
 <yq5afr8bdnrj.fsf@kernel.org>
 <8a872e0c-f13e-4ff1-a939-bc6814b3ec3e@samsung.com>
 <yq5ams2akznl.fsf@kernel.org>
 <87dc0a06-5818-45f3-99c9-d1aef807873f@samsung.com>
Date: Tue, 20 Jan 2026 15:19:55 +0530
Message-ID: <yq5awm1ck3zw.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Marek Szyprowski <m.szyprowski@samsung.com> writes:

> On 19.01.2026 05:13, Aneesh Kumar K.V wrote:
>> Marek Szyprowski <m.szyprowski@samsung.com> writes:
>>> On 12.01.2026 13:22, Aneesh Kumar K.V wrote:
>>>> Marek Szyprowski <m.szyprowski@samsung.com> writes:
>>>>> On 09.01.2026 04:15, Aneesh Kumar K.V wrote:
>>>>>> Robin Murphy <robin.murphy@arm.com> writes:
>>>>>>> On 2026-01-08 12:41 pm, Marek Szyprowski wrote:
>>>>>>>> On 08.01.2026 11:50, Robin Murphy wrote:
>>>>>>>>> On 2026-01-02 3:51 pm, Aneesh Kumar K.V (Arm) wrote:
>>>>>>>>>> dma_direct_alloc() calls arch_dma_prep_coherent() to clean any dirty
>>>>>>>>>> cache lines from the kernel linear alias before creating a coherent
>>>>>>>>>> remapping.
>>>>>>>>>>
>>>>>>>>>> HighMem pages have no kernel alias mapping, so there are no alias cache
>>>>>>>>>> lines to clean. Skip arch_dma_prep_coherent() for HighMem allocations.
>>>>>>>>> This is assuming that caches are always cleaned when unmapping
>>>>>>>>> highmem, and no still-mapped highmem pages are dirty - how is that
>>>>>>>>> guaranteed? The fact that they're not in the linear map doesn't mean
>>>>>>>>> they don't necessarily have kernel aliases in either vmalloc
>>>>>>>>> pagetables or caches.
>>>>>>>> Right, so it is better to keep this unconditional
>>>>>>>> arch_dma_prep_coherent() call. I will drop it from dma-mapping-fixes then.
>>>>>>> Yeah, I think the confusing thing here is that there are architectures
>>>>>>> with CONFIG_HIGHMEM that don't actually check for and handle it in their
>>>>>>> arch_dma_prep_coherent() as they seemingly should, however I'm not sure
>>>>>>> off-hand whether they also support/use highmem CMA in the manner that
>>>>>>> could end up being an issue in practice (the lack of any reports of
>>>>>>> crashes or DMA corruption over the last however many years suggests not...)
>>>>>>>
>>>>>> Should we then remove the PageHighMem() check with DMA_ATTR_NO_KERNEL_MAPPING?
>>>>> Right, this has to be unified.
>>>> I had a related question, how do we handle cache flushes required for
>>>> architectures that don't implement CONFIG_ARCH_HAS_DMA_PREP_COHERENT (arch/arm)?
>>> ARM 32bit architecture provides arch_dma_alloc(), which handles cache
>>> management internally.
>>>
>> But dma_direct_alloc does the below
>>
>> 	if ((attrs & DMA_ATTR_NO_KERNEL_MAPPING) &&
>> 	    !force_dma_unencrypted(dev) && !is_swiotlb_for_alloc(dev))
>> 		return dma_direct_alloc_no_mapping(dev, size, dma_handle, gfp);
>>
>> 	if (!dev_is_dma_coherent(dev)) {
>> 		if (IS_ENABLED(CONFIG_ARCH_HAS_DMA_ALLOC) &&
>> 		    !is_swiotlb_for_alloc(dev))
>> 			return arch_dma_alloc(dev, size, dma_handle, gfp,
>> 					      attrs);
>>
>> IIUC, this implies we won't call arch_dma_alloc for
>> DMA_ATTR_NO_KERNEL_MAPPING ?
>
> It looks that commit 849facea92fa ("dma-direct: simplify the 
> DMA_ATTR_NO_KERNEL_MAPPING handling") changed this. Before that 
> arch_dma_alloc() was called regardless of the provided DMA attrs. 
> Indeed, this should be fixed. Frankly speaking this probably means that 
> there are no active users of this combination (arch/arm, 
> DMA_ATTR_NO_KERNEL_MAPPING and dma-direct) or nobody cares.
>

Before that commit we did

	if (!IS_ENABLED(CONFIG_ARCH_HAS_DMA_SET_UNCACHED) &&
	    !IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) &&
	    dma_alloc_need_uncached(dev, attrs))
		return arch_dma_alloc(dev, size, dma_handle, gfp, attrs);

dma_alloc_need_uncached() returned false for DMA_ATTR_NO_KERNEL_MAPPING

static __always_inline bool dma_alloc_need_uncached(struct device *dev,
		unsigned long attrs)
{
	if (dev_is_dma_coherent(dev))
		return false;
	if (attrs & DMA_ATTR_NO_KERNEL_MAPPING)
		return false;
	return true;
}

It looks like for DMA_ATTR_NO_KERNEL_MAPPING, we never called into arch_dma_alloc()?

>
> The DMA_ATTR_NO_KERNEL_MAPPING attribute was initially introduced for 
> the DMA-IOMMU based implementation, where it saves significant amount of 
> resources.
>


-aneesh
