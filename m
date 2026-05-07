Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C773EC2E0
	for <iommu@lists.linux.dev>; Thu,  7 May 2026 13:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778159888; cv=none; b=HgIVxGOrXgFuhjy6gr5pXQbaKhD+ZAA/ou+ac25BZqGLnzDIThYndJDwFvw1y1sYnlzb6Mkz9gIzwHeeUB0jsiTsUFGiI900LGH3PDpSpWEWnEGoKmIGFWe/CmrDo2wnxdQiKGWB7iqw0nvH/vfdIJa/iMc076Fv3cuvC6wv1Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778159888; c=relaxed/simple;
	bh=bSPF52eNifvCAHZxfZvtkKjG0swEVvBNGQH1Scuf1Kw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QTSGHhVBwP90fWaZv8X9iRG5EihuZ4YZxv1xZ/7YVGL6h2neqcv8T47LBCHU5d9FuXbRMkwVsVfD51b/owIiCSoTpoYnvO05qDDZWYAsq50tAb2t1cZ7ecPXuDdYe+bWBVMO/lC/foaGZrL+JtFvbJEpWx4SS+XHNl41WLefRRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=KZCvQnR2; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="KZCvQnR2"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 16F111688;
	Thu,  7 May 2026 06:18:01 -0700 (PDT)
Received: from [10.1.196.85] (e121345-lin.cambridge.arm.com [10.1.196.85])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3BC1C3F763;
	Thu,  7 May 2026 06:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1778159886; bh=bSPF52eNifvCAHZxfZvtkKjG0swEVvBNGQH1Scuf1Kw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KZCvQnR2+BlMABWo8vx46G/eowjA6P/JPbcz3P9JhFnkZ6hXbEXTUxI85JBnr6oY8
	 ElrYNQmZDy4eOLmYJ5HIIpuQj30tt9OFcYbsmqQV/we26crhbdtCrB+IL8QLoFt7gf
	 LiQ0Y1FlTjnJqOTSpIP7uoqhlQ7s9aIz7tsEhu5o=
Message-ID: <2dcc29d6-a4a9-4fdf-861d-312941ab0f07@arm.com>
Date: Thu, 7 May 2026 14:18:01 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dma-mapping: remove bogus test for pfn_valid from
 dma_map_resource
To: Jianpeng Chang <jianpeng.chang.cn@windriver.com>, m.szyprowski@samsung.com
Cc: leon@kernel.org, kbusch@kernel.org, jgg@ziepe.ca, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260507032120.4072283-1-jianpeng.chang.cn@windriver.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260507032120.4072283-1-jianpeng.chang.cn@windriver.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07/05/2026 4:21 am, Jianpeng Chang wrote:
> dma_map_resource() uses pfn_valid() to ensure the range is not RAM.
> However, pfn_valid() only checks for availability of the memory map for a
> PFN but it does not ensure that the PFN is actually backed by RAM. On
> ARM64 with SPARSEMEM (128MB section granularity), MMIO addresses that
> share a section with RAM will falsely trigger the WARN_ON_ONCE.
> 
> This causes a WARNING on Raspberry Pi 4 during spi_bcm2835 probe because
> the SPI FIFO register (0xfe204004) falls in the same sparsemem section as
> the end of RAM (0xf8000000-0xfbffffff), both in section 31
> (0xf8000000-0xffffffff).
> 
> The pfn_valid() check was originally removed by commit a9c38c5d267c
> ("dma-mapping: remove bogus test for pfn_valid from dma_map_resource")
> but was accidentally re-introduced by commit f7326196a781
> ("dma-mapping: export new dma_*map_phys() interface") during the
> refactoring of dma_map_resource() into a wrapper around dma_map_phys().
> 
> Drop the pfn_valid() test from dma_map_resource() again.

As I said last time, I think pfn_valid() && !PageReserved(pfn_to_page()) 
would be enough for what we want here, although now it's strictly under 
CONFIG_DMA_API_DEBUG, perhaps the overhead of memblock_is_map_memory() 
might be less of an issue. Either way though, now that it's all 
channelled through the single dma_map_phys() path, it would probably 
make sense to consolidate any MMIO sanity-checking into 
dma_debug_map_phys() anyway :/

Thanks,
Robin.

> Fixes: f7326196a781 ("dma-mapping: export new dma_*map_phys() interface")
> Signed-off-by: Jianpeng Chang <jianpeng.chang.cn@windriver.com>
> ---
> Hi,
> 
> I found the WARNING in dma_map_resource() on Raspberry Pi 4 when using the
> downstream kernel from https://github.com/raspberrypi/linux, which calls
> dma_map_resource() in bcm2835-dma.c (mainline uses the physical address
> directly instead).
> 
> Although mainline bcm2835-dma does not call dma_map_resource(), the bogus
> pfn_valid() check can still affect any other driver that does, so it
> should be removed again.
> 
> Thanks,
> Jianpeng
> 
>   kernel/dma/mapping.c | 4 ----
>   1 file changed, 4 deletions(-)
> 
> diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
> index 23ed8eb9233e..e6b07f160d20 100644
> --- a/kernel/dma/mapping.c
> +++ b/kernel/dma/mapping.c
> @@ -365,10 +365,6 @@ EXPORT_SYMBOL(dma_unmap_sg_attrs);
>   dma_addr_t dma_map_resource(struct device *dev, phys_addr_t phys_addr,
>   		size_t size, enum dma_data_direction dir, unsigned long attrs)
>   {
> -	if (IS_ENABLED(CONFIG_DMA_API_DEBUG) &&
> -	    WARN_ON_ONCE(pfn_valid(PHYS_PFN(phys_addr))))
> -		return DMA_MAPPING_ERROR;
> -
>   	return dma_map_phys(dev, phys_addr, size, dir, attrs | DMA_ATTR_MMIO);
>   }
>   EXPORT_SYMBOL(dma_map_resource);

