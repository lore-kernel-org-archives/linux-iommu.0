Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E3427603F
	for <iommu@lists.linux.dev>; Mon, 27 Jan 2025 11:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737978652; cv=none; b=ECXYp77HzPxVFGmr7YVRfnfUrFbMIkuS1AzdxsDE/SqxrY+3eKlcGLa0GDv8A3pxqN6otXKpYguyprrVlBOR7LnpOFho9CNaLPme4KDhXYsTqjRxnYqhsIAqrFw0tTOTy5tldd6OrpBQD1jxo6yVIrBYuDzbFKrnGj9EMHw++HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737978652; c=relaxed/simple;
	bh=9Fblea8VNjbVS6kyikRdl98WSUQLiEvsEjx8H7dbUbk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=q+65RZWm8SzLOKaWofYD2s79GniN6h/msYyc8UCwhV0J3afsOzLAMRZA3AG28gfSxr6TnW83NOdK5lrYgk1Je3V4YdMXY0uj6AnWFD9X5EwzXenUrAX7iF4FGyrUbrzvsouffmRO2jSxFFsjxH15UpXbshv5af4Gp5hoHepLfRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6544E497;
	Mon, 27 Jan 2025 03:51:16 -0800 (PST)
Received: from [10.57.36.159] (unknown [10.57.36.159])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 999163F694;
	Mon, 27 Jan 2025 03:50:48 -0800 (PST)
Message-ID: <50b71ac2-b84f-4f09-8795-d1c89a7c56af@arm.com>
Date: Mon, 27 Jan 2025 11:50:41 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kernel/dma: dma_common_find_pages returns pages for
 requested address
To: Dima Stepanov <dstepanov.src@gmail.com>, Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <CAEHp+Gasm2ZuYPusn1ZsMuePpjV0atutVGTr9n3-DT=tQODYkQ@mail.gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <CAEHp+Gasm2ZuYPusn1ZsMuePpjV0atutVGTr9n3-DT=tQODYkQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-01-26 9:09 am, Dima Stepanov wrote:
> Recently hit an issue on an attempt to mmap allocated DMA memory to the
> user space. It isn't the case for any device, but only if dma_mmap_attrs
> call will use the iommu_dma_mmap() function as a backend.
> If the kernel address (cpu_addr) passed to the iommu_dma_mmap function
> is the same as returned by allocator (dma_alloc_coherent) then memory
> will be mapped correctly. But if the address passed is inside the
> allocated region, then the mapping in the user space will still refer
> to the start of the region and not to the middle of it.
> 
> The reason for it is the dma_common_find_pages() call, which returns the
> very first page of the vm structure regardless of the cpu_addr passed.
> 
> The idea for the fix is to return not the first page in the vm
> structure, but the page related to the requested cpu_addr.

No, that's a bug in the caller of dma_mmap_attrs(). As the kerneldoc 
says, cpu_addr/dma_addr/size must still represent the whole buffer as 
returned by the allocator - any offset for the mapping itself relative 
to the start of the buffer is expressed in vma->pgoff.

Thanks,
Robin.

> Signed-off-by: Dima Stepanov <dstepanov.src@gmail.com>
> ---
>   kernel/dma/remap.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/dma/remap.c b/kernel/dma/remap.c
> index 9e2afad1c615..238fbf2821a6 100644
> --- a/kernel/dma/remap.c
> +++ b/kernel/dma/remap.c
> @@ -9,12 +9,15 @@
>   struct page **dma_common_find_pages(void *cpu_addr)
>   {
>       struct vm_struct *area = find_vm_area(cpu_addr);
> +    int i;
> 
>       if (!area || !(area->flags & VM_DMA_COHERENT))
>           return NULL;
>       WARN(area->flags != VM_DMA_COHERENT,
>            "unexpected flags in area: %p\n", cpu_addr);
> -    return area->pages;
> +    i = (PAGE_ALIGN((uintptr_t)cpu_addr) - (uintptr_t)area->addr) >>
> PAGE_SHIFT;
> +
> +    return &area->pages[i];
>   }
> 
>   /*

