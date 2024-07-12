Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE7368F58
	for <iommu@lists.linux.dev>; Fri, 12 Jul 2024 14:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720794120; cv=none; b=lYXeUVTSNJB0fBYD1uvDpHmDbQ+j/7fUGPaTVPdgyn45xKKoZ7bWmaqxWs8YryRbCxiMJW5ejCe57oMsCKtQDb45pk3RuzWpSCTpAujg9rueMRui1k8eIStsFbQX2b/fRV11heK62EvNKISxlRA8ocoHp6igzmx7AByKoCaXTEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720794120; c=relaxed/simple;
	bh=AOCTVOykXxp8O33pHLastWcGGS7kbEmCQtC6F8e5bfw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OCtCmSyVjpBq8ASKsAg5LOeAaWxlQqbR9xp/j98HrzjLR7yEdsjYphwutV1+w2mQMx0MdDrO+0ac9tmw5QI7vsrYdmfcZYl46KsaZr1GCDlz4cNJy/9nCIbx5Tt7odCQ2cAbSYKmNXFhatFsK9iSxVdcfqJsAe7iJG9EDFjrsP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9BBE61042;
	Fri, 12 Jul 2024 07:22:23 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 34BDC3F766;
	Fri, 12 Jul 2024 07:21:57 -0700 (PDT)
Message-ID: <7ba30992-78aa-49e5-98bb-75c6b7ae8ce9@arm.com>
Date: Fri, 12 Jul 2024 15:21:55 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] dma: Add IOMMU static calls with clear default ops
To: Leon Romanovsky <leon@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>,
 Jason Gunthorpe <jgg@nvidia.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev
References: <98d1821780028434ff55b5d2f1feea287409fbc4.1720693745.git.leon@kernel.org>
 <f2b699aea8fff5589a674da2a567fd593ed2d386.1720693745.git.leon@kernel.org>
 <28309b7f-9809-452f-95fe-3448c15bdf1b@arm.com>
 <20240711185741.GC1815706@unreal>
 <455ccc97-11bd-456d-92b3-b7c8fe4c8d9a@arm.com>
 <20240712055004.GE1815706@unreal>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20240712055004.GE1815706@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/07/2024 6:50 am, Leon Romanovsky wrote:
> On Thu, Jul 11, 2024 at 09:08:49PM +0100, Robin Murphy wrote:
>> On 2024-07-11 7:57 pm, Leon Romanovsky wrote:
>>> On Thu, Jul 11, 2024 at 07:23:20PM +0100, Robin Murphy wrote:
>>>> On 11/07/2024 11:38 am, Leon Romanovsky wrote:
>>>>> From: Leon Romanovsky <leonro@nvidia.com>
>>>>>
>>>>> Most of the IOMMU drivers are using the same DMA operations, which are
>>>>> default ones implemented in drivers/iomem/dma-iomem.c. So it makes sense
>>>>> to properly set them as a default with direct call without need to
>>>>> perform function pointer dereference.
>>>>>
>>>>> During system initialization, the IOMMU driver can set its own DMA and
>>>>> in such case, the default DMA operations will be overridden.
>>>>
>>>> I'm going to guess you don't actually mean "IOMMU drivers" in the usual
>>>> sense of drivers/iommu/, but rather "arch DMA ops (which often, but not
>>>> always, involve some sort of IOMMU)."
>>>
>>> Yes, you are right. I used word "drivers" as a general term to describe
>>> everything that implements their own ->map_page() callback.
>>>
>>>>
>>>> If so, I'd much rather see this done properly, i.e. hook everything up
>>>> similarly to dma-direct and be able to drop CONFIG_DMA_OPS for "modern"
>>>> dma-direct/iommu-dma architectures entirely. Furthermore the implementation
>>>> here isn't right - not only is it not conceptually appropriate to make
>>>> iommu-dma responsibile for proxying random arch DMA ops, but in practial
>>>> terms it's just plain broken, since the architectures which still have their
>>>> own DMA ops also don't use iommu-dma, so this is essentially disabling the
>>>> entire streaming DMA API on ARM/PowerPC/etc.
>>>
>>> Sorry but I'm not sure that I understood your reply. Can you please clarify
>>> what does it mean broken in this context?
>>>
>>> All archs have one of the following options:
>>> 1. No DMA ops -> for them dma_map_direct() will return True and they
>>> never will enter into IOMMU path.
>>> 2. Have DMA ops but without .map_page() -> they will use default IOMMU
>>> 3. Have DMA ops with .map_page() -> they will use their own implementation
>>
>> Urgh, sorry, let that instead be a lesson in not adding needless layers of
>> indirection that are named as confusingly as possible, then. Seems I saw
>> stubs plus static inline wrappers, managed to misread dma_iommu_* vs.
>> iommu_dma_*, and jump to the wrong conclusion of what was stubbed out, not
>> least since that was the only interpretation in which adding an extra layer
>> of inline wrappers would seem necessary in the first place. If these
>> dma_iommu_* functions serve no purpose other than to make the code even more
>> of a maze of twisty little passages, all alike, then please just feed them
>> to a grue instead.
> 
> This is done to keep layering similar to existing in DMA subsystem. We
> have special files and calls to dma-direct, it looks natural to have
> special files and call to dma-iommu. It is not nice to call to drivers/iommu
> from kernel/dma/mapping.c

That's where I firmly disagree. In the DMA API aspect, iommu-dma is 
exactly a peer of dma-direct, however it lives in drivers/iommu for 
practical reasons because it's more closely coupled to IOMMU API 
internals in all other aspects of its implementation. TBH what I'd 
really like is a private interface between mapping.c and dma-iommu.c 
which doesn't expose internal details via include/linux/ at all, but 
*that's* a level that I think people may rightfully start to object to.

Thanks,
Robin.
