Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F167F2E8B82
	for <iommu@lists.linux.dev>; Mon,  2 Feb 2026 15:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770045993; cv=none; b=p0e00wtK8ECya0BonZpA9QjRjuWMtkb9A/1mpol50VeDsNYwWNihsaDt5A39lKAXmY7a310QXVVB/dpKPInX1dxGh+UBGpK4qTwjOAYzFVIP6CqZGlTZjYEfORc3XK3aZGW9TiMG+mN7W/lJ20n3Q+HO1ejKT18zHzSfdxSkvAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770045993; c=relaxed/simple;
	bh=sXFJxOd4HRVn31jUX0evdy8WqMldP00MDs/+dhaWgtE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DdYSHTJsi8P5QuEAtCrSurGgh3WH+nYIXGo5ixj4AsxAWZizTnbP3BP9n/BfG5pzmSHB/m4pbOyNYMOl/DbgLMosR6fmVYIBYEX/2Uq5IS1DuQhK8iqAPCx8/AR4qVmsFruCfJKQJp05k/ktOk7YdJoRyusbSNeC87QEB3J+SYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 597E8339;
	Mon,  2 Feb 2026 07:26:23 -0800 (PST)
Received: from [10.57.54.50] (unknown [10.57.54.50])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EE12F3F740;
	Mon,  2 Feb 2026 07:26:27 -0800 (PST)
Message-ID: <d82514f1-4c9b-490c-b4db-e259337cd16f@arm.com>
Date: Mon, 2 Feb 2026 15:26:25 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1] nvme-pci: Fix NULL pointer dereference in
 nvme_pci_prp_iter_next
To: Leon Romanovsky <leon@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Pradeep P V K <pradeep.pragallapati@oss.qualcomm.com>, kbusch@kernel.org,
 axboe@kernel.dk, sagi@grimberg.me, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, nitin.rawat@oss.qualcomm.com,
 Marek Szyprowski <m.szyprowski@samsung.com>, iommu@lists.linux.dev
References: <20260202125738.1194899-1-pradeep.pragallapati@oss.qualcomm.com>
 <20260202143548.GA19313@lst.de> <20260202152252.GM34749@unreal>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260202152252.GM34749@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-02-02 3:22 pm, Leon Romanovsky wrote:
> On Mon, Feb 02, 2026 at 03:35:48PM +0100, Christoph Hellwig wrote:
>> On Mon, Feb 02, 2026 at 06:27:38PM +0530, Pradeep P V K wrote:
>>> Fix a NULL pointer dereference that occurs in nvme_pci_prp_iter_next()
>>> when SWIOTLB bounce buffering becomes active during runtime.
>>>
>>> The issue occurs when SWIOTLB activation changes the device's DMA
>>> mapping requirements at runtime,
>>>
>>> creating a mismatch between
>>> iod->dma_vecs allocation and access logic.
>>>
>>> The problem manifests when:
>>> 1. Device initially operates with dma_skip_sync=true
>>>     (coherent DMA assumed)
>>> 2. First SWIOTLB mapping occurs due to DMA address limitations,
>>>     memory encryption, or IOMMU bounce buffering requirements
>>> 3. SWIOTLB calls dma_reset_need_sync(), permanently setting
>>>     dma_skip_sync=false
>>> 4. Subsequent I/Os now have dma_need_unmap()=true, requiring
>>>     iod->dma_vecs
>>
>> I think this patch just papers over the bug.
> 
> Agree
> 
>> If dma_need_unmap can't be trusted before the dma_map_* call, we've not saved
>> the unmap information and the unmap won't work properly.
>>
>> So we'll need to extend the core code to tell if a mapping
>> will set dma_skip_sync=false before doing the mapping.
> 
> There are two paths that lead to SWIOTLB in dma_direct_map_phys().
> The first is is_swiotlb_force_bounce(dev), which dma_need_unmap() can
> easily evaluate. The second is more problematic, as it depends on
> dma_addr and size, neither of which is available in dma_need_unmap():
> 
>    102                 if (unlikely(!dma_capable(dev, dma_addr, size, true)) ||
>    103                     dma_kmalloc_needs_bounce(dev, size, dir)) {
>    104                         if (is_swiotlb_active(dev))
> 
> What about the following change?
> 
> diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
> index 37163eb49f9f..1510b93a8791 100644
> --- a/kernel/dma/mapping.c
> +++ b/kernel/dma/mapping.c
> @@ -461,6 +461,8 @@ bool dma_need_unmap(struct device *dev)
>   {
>          if (!dma_map_direct(dev, get_dma_ops(dev)))
>                  return true;
> +       if (is_swiotlb_force_bounce(dev) || is_swiotlb_active(dev))
> +               return true;

This will always be true if a default SWIOTLB buffer exists at all, and 
thus pretty much defeat the point of whatever optimisation the caller is 
trying to make.

Thanks,
Robin.

>          if (!dev->dma_skip_sync)
>                  return true;
>          return IS_ENABLED(CONFIG_DMA_API_DEBUG);
> 

