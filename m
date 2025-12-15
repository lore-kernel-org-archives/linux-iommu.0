Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0643629AB02
	for <iommu@lists.linux.dev>; Mon, 15 Dec 2025 10:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765795972; cv=none; b=DWa7sAFBdOC8quKuimo9h86MwMmX4PuVDA0h3XfArESoSVlWhDjrQYP1VDWcEVVrcTWPWOfVsr5A0kq1Awc8syYEXRJanpafip2LiYXNEI1dy0COzYDOxxZSrHpru/LQhGdIoM/eIlg7EB1X4uq1595MIWq4Ri2m/FNpWj2IxZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765795972; c=relaxed/simple;
	bh=crVd/EWxLmyuSrXMNXHMsD8ze5TtkyIFHGxqybEdT1A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kz9oSZvVGd8OZaDGzoyWfWzvnjbVuZ0sLkiz07b9hGtGwOCAGGohRQP0OZly0tsA9j3cl2Re1g/sO8lwWEnVNcDV7xwehpHTnYTmTI6pA6zoFvl9pOKfy/sOcaoM4wb5xKiQ8OadwLc6SOEEntAfBvZKfDYbwMj8GJ/gzZUgOoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 143C6497;
	Mon, 15 Dec 2025 02:52:41 -0800 (PST)
Received: from [10.57.44.191] (unknown [10.57.44.191])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 798A93F73B;
	Mon, 15 Dec 2025 02:52:47 -0800 (PST)
Message-ID: <60c8fd07-96f6-442d-9415-0e1226f1e0e6@arm.com>
Date: Mon, 15 Dec 2025 10:52:40 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dma-remap: fix dma_common_find_pages() page lookup for
 offsets
To: Andrei-Edward Popa <andrei.popa105@yahoo.com>, m.szyprowski@samsung.com
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20251212200914.138310-1-andrei.popa105.ref@yahoo.com>
 <20251212200914.138310-1-andrei.popa105@yahoo.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20251212200914.138310-1-andrei.popa105@yahoo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-12-12 8:09 pm, Andrei-Edward Popa wrote:
> dma_common_find_pages() previously assumed that the CPU virtual address
> always pointed to the start of a DMA-coherent allocation. This fails when
> memory is allocated via dma_alloc_attrs() without DMA_ATTR_FORCE_CONTIGUOUS
> and then subdivided into smaller blocks using a gen_pool, relevant only
> when an IOMMU is enabled.
> 
> In such cases, userspace may request a mapping via dma_mmap_attrs()
> for a CPU address that is offset inside the original allocation. The
> previous code could return the wrong struct page pointer.
> 
> Example scenario:
> 
>    - Allocate a large DMA buffer with dma_alloc_attrs() (non-contiguous)
>    - Create a gen_pool using this buffer
>    - Take sub-allocations from the gen_pool
>    - Map the sub-allocations to userspace via dma_mmap_attrs()

That's where the bug is. If a driver wants to subdivide an allocation 
then it needs to keep track of what it's done, and handle mmap properly 
to offset the VMA relative to the original allocation before passing the 
request through. See the kerneldoc for dma_mmap_attrs():

  * @cpu_addr: kernel CPU-view address returned from dma_alloc_attrs
  * @dma_addr: device-view address returned from dma_alloc_attrs
  * @size: size of memory originally requested in dma_alloc_attrs

"address returned from dma_alloc_attrs" does not mean "any arbitrary 
address within the bounds of the original address/size", it means 
exactly what it says, i.e. the original address.

Thanks
Robin.

>    - dma_common_find_pages() must return the correct struct page for the offset
> 
> This patch computes the page index relative to the vm_struct backing
> the DMA allocation:
> 
>      page_index = (vaddr - area->addr) >> PAGE_SHIFT
> 
> Bounds checks ensure the CPU address is within the vm_struct and
> page_index < area->nr_pages.
> 
> This ensures correct behavior for sub-allocated regions from gen_pool,
> without affecting allocations starting at the base address or allocations
> with DMA_ATTR_FORCE_CONTIGUOUS.
> 
> Signed-off-by: Andrei-Edward Popa <andrei.popa105@yahoo.com>
> ---
>   kernel/dma/remap.c | 15 ++++++++++++++-
>   1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/dma/remap.c b/kernel/dma/remap.c
> index b7c1c0c92d0c..d27477e32ed8 100644
> --- a/kernel/dma/remap.c
> +++ b/kernel/dma/remap.c
> @@ -9,12 +9,25 @@
>   struct page **dma_common_find_pages(void *cpu_addr)
>   {
>   	struct vm_struct *area = find_vm_area(cpu_addr);
> +	unsigned long vaddr, area_vaddr;
> +	size_t page_index;
>   
>   	if (!area || !(area->flags & VM_DMA_COHERENT))
>   		return NULL;
>   	WARN(area->flags != VM_DMA_COHERENT,
>   	     "unexpected flags in area: %p\n", cpu_addr);
> -	return area->pages;
> +
> +	vaddr = (unsigned long)cpu_addr;
> +	area_vaddr = (unsigned long)area->addr;
> +	if (unlikely(vaddr < area_vaddr ||
> +		     vaddr >= area_vaddr + area->size))
> +		return NULL;
> +
> +	page_index = (vaddr - area_vaddr) >> PAGE_SHIFT;
> +	if (unlikely(page_index >= area->nr_pages))
> +		return NULL;
> +
> +	return &area->pages[page_index];
>   }
>   
>   /*

