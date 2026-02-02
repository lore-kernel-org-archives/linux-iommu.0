Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E69304BB8
	for <iommu@lists.linux.dev>; Mon,  2 Feb 2026 17:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770053961; cv=none; b=GCBumalw+pKmnW0CJSwcH9L2D2BFSohFrZTQilSAgx+at3hfACZP/Eh5tjQSPJ7x8PZU8GH0fjEX0ePLF92QhpV+S49wmN+PbU7gZhaOkI0Na0MfpLGma0ivcLODWhgptaoAP6qG/Xr2MMW0ObBdPlT8jL7nx4UAkML+6EBQCPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770053961; c=relaxed/simple;
	bh=c1tq6DYGe7xwvlzWNJgKVRkafRQQGCmT2KYMmEYguIA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j0rZt7M288Q7OS2JelW2NudCHX8iJcudM2Wtxh8788uFJu2PiSUuLW42E/8J+CGifAdlFMfWPo5DFz6vtTyfv8gg0pJvMwHEhEoHFemrhzP9pGh7duNpj3v9M+430riGwEI7D/GG6fkv3jbdtZxh4NNNJdKkX3UKDO+qrnKmdwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 87B45339;
	Mon,  2 Feb 2026 09:39:12 -0800 (PST)
Received: from [10.57.54.50] (unknown [10.57.54.50])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E95413F740;
	Mon,  2 Feb 2026 09:39:16 -0800 (PST)
Message-ID: <5a3f03e8-89bc-4b46-b125-e08f8297647f@arm.com>
Date: Mon, 2 Feb 2026 17:39:14 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1] nvme-pci: Fix NULL pointer dereference in
 nvme_pci_prp_iter_next
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>,
 Pradeep P V K <pradeep.pragallapati@oss.qualcomm.com>, axboe@kernel.dk,
 sagi@grimberg.me, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, nitin.rawat@oss.qualcomm.com,
 Leon Romanovsky <leon@kernel.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>, iommu@lists.linux.dev
References: <20260202143548.GA19313@lst.de>
 <dc34c246-d6ba-4c2e-8593-6fe32a616174@arm.com> <aYDbNC1z81D3lZ2r@kbusch-mbp>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <aYDbNC1z81D3lZ2r@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-02-02 5:13 pm, Keith Busch wrote:
> On Mon, Feb 02, 2026 at 03:16:50PM +0000, Robin Murphy wrote:
>> On 2026-02-02 2:35 pm, Christoph Hellwig wrote:
>>> On Mon, Feb 02, 2026 at 06:27:38PM +0530, Pradeep P V K wrote:
>>>> Fix a NULL pointer dereference that occurs in nvme_pci_prp_iter_next()
>>>> when SWIOTLB bounce buffering becomes active during runtime.
>>>>
>>>> The issue occurs when SWIOTLB activation changes the device's DMA
>>>> mapping requirements at runtime,
>>>>
>>>> creating a mismatch between
>>>> iod->dma_vecs allocation and access logic.
>>>>
>>>> The problem manifests when:
>>>> 1. Device initially operates with dma_skip_sync=true
>>>>      (coherent DMA assumed)
>>>> 2. First SWIOTLB mapping occurs due to DMA address limitations,
>>>>      memory encryption, or IOMMU bounce buffering requirements
>>>> 3. SWIOTLB calls dma_reset_need_sync(), permanently setting
>>>>      dma_skip_sync=false
>>>> 4. Subsequent I/Os now have dma_need_unmap()=true, requiring
>>>>      iod->dma_vecs
>>>
>>> I think this patch just papers over the bug.  If dma_need_unmap
>>> can't be trusted before the dma_map_* call, we've not saved
>>> the unmap information and the unmap won't work properly.
>>
>> The dma_need_unmap() kerneldoc says:
>>
>> "This function must be called after all mappings that might
>>   need to be unmapped have been performed."
>>
>> Trying to infer anything from it beforehand is definitely a bug in the
>> caller.
> 
> Well that doesn't really make sense. No matter how many mappings the
> driver has done, there will always be more. ?

But equally the fact that none of the mappings made so far happened to 
not need bouncing still doesn't mean that future ones won't. This is not 
guaranteed to be a static property of the device, but nor is it really a 
property of the *device* at all; it's a property of a set of one or more 
DMA mappings with the same lifetime, there's just no suitable generic 
notion of that temporal context in the DMA API to carry around and pass 
as an explicit argument, so it's left implicit in the usage model.

Whatever higher-level thing it's doing, the driver must have some 
context, so within "operation A" it makes some DMA mappings, checks 
dma_need_unmap() and sees it's false, so can conclude that "operation A" 
does not need to preserve DMA unmap state. However it may then start 
"operation B", do some more mappings, check dma_need_unmap() and see 
it's now returned true, so "operation B" *does* need to keep the DMA 
data and explicitly unmap it when it finishes.

This is essentially the point I made at the time about it not 
necessarily being as useful a thing as it seems, since if an "operation" 
involves multiple mappings, it must still store the full state of those 
mappings for at least long enough to finish them all and then call 
dma_need_unmap(), to only then see if it might be OK to throw that state 
away again.

Thanks,
Robin.
