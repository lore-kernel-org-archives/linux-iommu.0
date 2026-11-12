Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794500515;
	b=vXVdkORBpLw7XxNkv/Iu7axQHBGkKeu6VQypN/SMljGj/JcFQl/5Sp5CYP74tEO91Csz
	 +ws65lx+aaWUh5bbPp4UvBIKtNp0+8FXqm+S+XDADU0GNpg38CATkNQH7vRckjch5C1Z/
	 racTcGcy61UI/yYcP6D1innGQigCT8f5AaTtjvIYJUPYeCR9/3PZlebZ8OlDtfV5M3oD/
	 ay98F8vbcC96AnE1gioVkoZUE9eEOZovKkiM1s8EzWUg9YnGaGarmMgsfkAxchKIp5K7z
	 RY3JYhjdBEDAcQd345nAySA6htmai6U1cWQ/ES58h47O/RJytcp3gOuTYogRr2XHyuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794500515;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=MThHrrAgO+4uPmzlybRs1Z4U0Fzgwcz7pOBq89o/DUE=;
	b=QLdsl3nXBCaNr/s7F25WI0nFPP8cTlNTdJ1eimh7yPwKtMWEXsFg5oAc3JGc/y+i06l5
	 nuuYPa85aZBoaCLS/bJXP5wSErUSsR7znVb4jA8iSIERMLs4ClQMGZICcowuBU31Jc154
	 lR4UglIhfKG5qmlPJHI+/HeyVCXUcbyfpXhh+Tobh4mAgaahqe8jcgnSXdxAo6vIDqu7M
	 /g89U8DNqPy89jCD0J1voEWJoO6Kpwwnr+7pDJR5PXo60FXLibRTgBwWzwnTsIvn42Cl5
	 8jh7ClTaf+OBiEqn9q6C4PsN785DeMRe/gDxBJ2+OR7JPNucZ2ABGYLYywydsylzwLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=MomroVmx;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34617606A32A
	for <iommu@lists.linux.dev>; Thu, 12 Nov 2026 16:21:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 34617606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=MomroVmx
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4C4FE339;
	Thu, 12 Nov 2026 08:21:50 -0800 (PST)
Received: from [10.57.89.53] (unknown [10.57.89.53])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 18A6B3F959;
	Thu, 12 Nov 2026 08:21:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794500513; bh=jedXPPvr7jZuVhdrhq32oHINCmvOzuYPpr5X/Ba4uXE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MomroVmxYPw12QBT+rgCGPZ3lttH/nPhsgCEMyYJ/gtn+dAH250P+mP+4Cm5pZJb9
	 uaEF2O/7Lqogifa/0OkPooXeRmSM173RFZNowVYGh5RtZtb1c1DR60ozD0RVqVLWfJ
	 dbsJsDkgTGmp7taZz7dZsWT8WvTniKgxPANxrjhQ=
Message-ID: <ca3d6077-651c-4882-af5b-15fa01242c35@arm.com>
Date: Thu, 12 Nov 2026 16:21:49 +0000
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/11] dma-contiguous: pass the NUMA node to
 dma_alloc_contiguous()
To: Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 m.szyprowski@samsung.com
Cc: netdev@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
 will@kernel.org, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
References: <20261106184433.761422-1-kuba@kernel.org>
 <20261106184433.761422-5-kuba@kernel.org>
 <c83426a5-d21c-4f0d-b13e-099b6f96df6f@redhat.com>
 <d00d3435-fcce-4c0f-8ed5-a672b5b85dfb@arm.com>
 <c014414f-fdd2-4a79-b133-44671c0e4475@redhat.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <c014414f-fdd2-4a79-b133-44671c0e4475@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2026-11-12 3:43 pm, Paolo Abeni wrote:
> On 11/12/26 14:28, Robin Murphy wrote:
>> On 2026-11-12 9:53 am, Paolo Abeni wrote:
>>> On 11/6/26 19:44, Jakub Kicinski wrote:
>>>> --- a/kernel/dma/mapping.c
>>>> +++ b/kernel/dma/mapping.c
>>>> @@ -642,6 +642,13 @@ EXPORT_SYMBOL_GPL(dma_get_required_mask);
>>>>    * Same as dma_alloc_attrs() but places the memory on @node rather 
>>>> than on the
>>>>    * node of @dev. Like with kmalloc_node() the node is only a 
>>>> preference,
>>>>    * the page allocator may fall back to other nodes if @node is out 
>>>> of memory.
>>>> + * The contiguous memory allocator (CMA) does not: only the CMA 
>>>> area of @node
>>>> + * and the global CMA area are tried. The allocation may fail even 
>>>> though the
>>>> + * CMA area of another node, e.g. that of @dev, still has free space.
>>>> + *
>>>> + * Allocations served from per-device or global coherent pools, 
>>>> per- device CMA
>>>> + * areas, restricted or atomic pools, arch_dma_alloc() or dma_map_ops
>>>> + * implementations do not take @node into account.
>>> I'm possibly over-thinking here, but AFAICS there are a bunch of 
>>> dma_map_ops that
>>> are using dev_to_node():
>>>
>>> dma_iommu_alloc_coherent() in arch/powerpc/kernel/dma-iommu.c
>>> vio_dma_iommu_alloc_coherent() in arch/powerpc/platforms/pseries/vio.c
>>> gart_alloc_coherent() in arch/x86/kernel/amd_gart_64.c
>>>
>>> With this series they will stop using the driver provided numa node.
>>> Probably not a blocker but possibly worth to call out?
>>
>> Nothing "stops" - this series adds a *new* interface by which drivers 
>> can now indicate a specific preferred node, but DMA API backends are 
>> still free to ignore the caller-provided hint and continue doing 
>> whatever they want. This is already called out all over the series in 
>> commit messages, documentation and comments including the one above.
> I mean: the series also replaces the old hacks with the new APIs usage
> in a few drivers, and in the above cases there could be actual regressions.
> 
> But I guess we could handle them if and when they will surface.

Ah, sorry, I was confused by the comment being made in the context of 
this patch - what you mean is that in patches 6-11, the new API isn't 
guaranteed to give the same result as the set_dev_node() hacks being 
removed? To be fair, the new API itself still does not change any 
behaviour, removing the hacks changes the behaviour ;)

I guess it could be worth a note in those commit messages if we think 
there's a chance that anyone is using these NICs on POWER systems that 
might conceivably observe a performance blip.

Cheers,
Robin.
