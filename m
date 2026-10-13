Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90C51184
	for <iommu@lists.linux.dev>; Tue, 13 Oct 2026 12:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791895443; cv=none; b=cRxrzud8vk9nbdcWFiLRX2O0NAlfUQ0W7FxH3owr00spkkQDjduW58H8JcxaeoHpCXf8UhbHuaFfuNN+bUrr+SG3s9mY7wi67YkgRq/xq9xW+v7iL9keWx1eZoUCvjrYkBnubhbXhNs07aCENnZz60OHkfrjdjOwrXRfJZE8ykk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791895443; c=relaxed/simple;
	bh=7nLXDgVjqrePKb7nbBeVACkcTllKFH4WmHA0OYhVz+4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bAy3Zh2biVVXNSeHfnA82KopC3x9+hu7thw9ZhnYI/wlY2cqHoZjaJKiuv7EV/e2pjUCTMnjAIkn9BafpjgyxUg0blQRXJ/wdew8M4YkEW1eTSzcA50A0hDQFDhGDkxnvl51Nv+2v32Lll1xY5cwSIRkYbBoKg/igpiKF71Br14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=IWG1Xee+; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="IWG1Xee+"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8DBC2169C;
	Tue, 13 Oct 2026 05:43:56 -0700 (PDT)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CBA633F7B4;
	Tue, 13 Oct 2026 05:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1791895439; bh=7nLXDgVjqrePKb7nbBeVACkcTllKFH4WmHA0OYhVz+4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IWG1Xee+jUdb3DdoHLKB03WzcdKGcCjsFZw4HKmQ9X6v0YKD+YrhiBX88p9wyTr7Y
	 KGwMryiKgox7uyTZnRoVgzba9gpGqTnLFT6C+/xvacSeExFusXeDvxWxvxdh0iLb7C
	 i1iNyeYooTb4HqF2qaiUx9dDrjG9FM8PFIeXQfiA=
Message-ID: <e7b6e74a-4ec9-4146-a6b0-9183a9fb7933@arm.com>
Date: Tue, 13 Oct 2026 13:43:56 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dma-debug: Skip cacheline tracking for MMIO mappings
To: Leon Romanovsky <leon@kernel.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
 Arnd Bergmann <arnd@arndb.de>, Vinod Koul <vkoul@kernel.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20261013-dma-debug-fixes-v1-1-1ad1f471cc61@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20261013-dma-debug-fixes-v1-1-1ad1f471cc61@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/10/2026 12:44 pm, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Mapping one MMIO dma-buf for many RDMA importers overflows dma-debug's
> cacheline overlap counter and triggers a warning. DMA_ATTR_MMIO mappings
> must never be CPU-cacheable, so CPU cacheline overlap tracking does not
> apply to them.
> 
> Skip MMIO entries in both cacheline insertion and removal. Keep them in
> the DMA entry hash so mapping and unmapping checks still run.

Seems fair;

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

[...]
> 
> Fixes: 0e74b34dfc33 ("dma-debug: add support for resource mappings")

Although it would be a challenge to backport _that_ far, so more 
realistically I'd probably say:

Fixes: 3aa31a8bb11e ("dma-buf: provide phys_vec to scatter-gather 
mapping routine")

since regular dma_map_resource() users are still never going to hit this 
making their one-off mapping of a UART FIFO or whatever.

Thanks,
Robin.

> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>   kernel/dma/debug.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
> index 026d50de340e..36c1f7cbb2ae 100644
> --- a/kernel/dma/debug.c
> +++ b/kernel/dma/debug.c
> @@ -489,8 +489,10 @@ static int active_cacheline_insert(struct dma_debug_entry *entry,
>   	/* If the device is not writing memory then we don't have any
>   	 * concerns about the cpu consuming stale data.  This mitigates
>   	 * legitimate usages of overlapping mappings.
> +	 * MMIO mappings are never CPU-cacheable and do not need tracking either.
>   	 */
> -	if (entry->direction == DMA_TO_DEVICE)
> +	if (entry->direction == DMA_TO_DEVICE ||
> +	    entry->attrs & DMA_ATTR_MMIO)
>   		return 0;
>   
>   	spin_lock_irqsave(&radix_lock, flags);
> @@ -519,7 +521,8 @@ static void active_cacheline_remove(struct dma_debug_entry *entry)
>   	unsigned long flags;
>   
>   	/* ...mirror the insert case */
> -	if (entry->direction == DMA_TO_DEVICE)
> +	if (entry->direction == DMA_TO_DEVICE ||
> +	    entry->attrs & DMA_ATTR_MMIO)
>   		return;
>   
>   	spin_lock_irqsave(&radix_lock, flags);
> 
> ---
> base-commit: 39d3758108bb0ef9da484062d65288bbe9cada0e
> change-id: 20261013-dma-debug-fixes-5aaf1bb17544
> 
> Best regards,
> --
> Leon Romanovsky <leonro@nvidia.com>
> 

