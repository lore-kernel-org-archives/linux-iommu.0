Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0862F6165;
	Sun, 21 Dec 2025 11:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766318127; cv=none; b=GUUl2beQhvp84YzV3UQbHJQyXa9FatJw/gDn+tHYriKOUWHBxAgHdvhFXFJ93OCYYOweHnBFR8XWCSKQ1IP5XJ16ohLfAQ0Dhig5q0gip52qZt1ZurN9lR1zaa8Xix3RSzxEgTz1myTeZlYCXVlg4cXhTDiU4tDNm1Ob7Dk98T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766318127; c=relaxed/simple;
	bh=cl0Pp9gIMy9qgGyo+31RVCvJ8tyH3yPUScmFvHzlmzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RjCFmqri88625zKijVbzmzm0tbb7CE34rB7o2XRbxpxVtPdzC5Uuny42NvMdtYClHL4ACtigigGcnmYCacma0uvLrUl6tROWU9cMmp7o8W8GIXxeiYE6y6JZR4hKFnIRhG1Tn+T5oQZIJTgG6lgI7mf72djUhTLg/CJMf8NqQI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m4PYcanK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m4PYcanK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4BB9C4CEFB;
	Sun, 21 Dec 2025 11:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766318127;
	bh=cl0Pp9gIMy9qgGyo+31RVCvJ8tyH3yPUScmFvHzlmzo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m4PYcanKwIXIAkG+coVrKkljBDifB1QabUlFnQ3ypVg0NVtQmBnB/6oN9x7PYRhIN
	 0sVLieQfV0c237oif8izgVL1JTccjIUrFLcqvp/rJkxoXihijgtCOoqM2wpqE+j1aA
	 4QHvF2jDFuv9hzwc824cIqpLcrP9LDmLWgBb4GY6bvymBDeY4DW131179tHLfTOKVe
	 CnyfUFUdje3+Tr0xR7jKzeHBVsptHeHCmcyUdYOSig3bJ8LweSk0ZGUOrmPz1VWPP6
	 y6PzTrm9GUKr2OhwTd9GLn0uRJbfLf0pr2+a/MwsAOClEIQwARj/A89uJ0ZJMJbyVC
	 rO7K1fA0KE4hg==
Date: Sun, 21 Dec 2025 13:55:23 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Barry Song <21cnbao@gmail.com>
Cc: catalin.marinas@arm.com, m.szyprowski@samsung.com, robin.murphy@arm.com,
	will@kernel.org, ada.coupriediaz@arm.com, anshuman.khandual@arm.com,
	ardb@kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	maz@kernel.org, ryan.roberts@arm.com, surenb@google.com,
	v-songbaohua@oppo.com, zhengtangquan@oppo.com
Subject: Re: [PATCH 5/6] dma-mapping: Allow batched DMA sync operations if
 supported by the arch
Message-ID: <20251221115523.GI13030@unreal>
References: <20251219053658.84978-1-21cnbao@gmail.com>
 <20251219053658.84978-6-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251219053658.84978-6-21cnbao@gmail.com>

On Fri, Dec 19, 2025 at 01:36:57PM +0800, Barry Song wrote:
> From: Barry Song <v-songbaohua@oppo.com>
> 
> This enables dma_direct_sync_sg_for_device, dma_direct_sync_sg_for_cpu,
> dma_direct_map_sg, and dma_direct_unmap_sg to use batched DMA sync
> operations when possible. This significantly improves performance on
> devices without hardware cache coherence.
> 
> Tangquan's initial results show that batched synchronization can reduce
> dma_map_sg() time by 64.61% and dma_unmap_sg() time by 66.60% on an MTK
> phone platform (MediaTek Dimensity 9500). The tests were performed by
> pinning the task to CPU7 and fixing the CPU frequency at 2.6 GHz,
> running dma_map_sg() and dma_unmap_sg() on 10 MB buffers (10 MB / 4 KB
> sg entries per buffer) for 200 iterations and then averaging the
> results.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Ada Couprie Diaz <ada.coupriediaz@arm.com>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: Tangquan Zheng <zhengtangquan@oppo.com>
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> ---
>  kernel/dma/direct.c | 28 ++++++++++-----
>  kernel/dma/direct.h | 86 +++++++++++++++++++++++++++++++++++++++------
>  2 files changed, 95 insertions(+), 19 deletions(-)

<...>

>  		if (!dev_is_dma_coherent(dev))
> -			arch_sync_dma_for_device(paddr, sg->length,
> -					dir);
> +			arch_sync_dma_for_device_batch_add(paddr, sg->length, dir);

<...>

> -static inline dma_addr_t dma_direct_map_phys(struct device *dev,
> +#ifdef CONFIG_ARCH_WANT_BATCHED_DMA_SYNC
> +static inline void dma_direct_sync_single_for_cpu_batch_add(struct device *dev,
> +		dma_addr_t addr, size_t size, enum dma_data_direction dir)
> +{
> +	phys_addr_t paddr = dma_to_phys(dev, addr);
> +
> +	if (!dev_is_dma_coherent(dev))
> +		arch_sync_dma_for_cpu_batch_add(paddr, size, dir);
> +
> +	__dma_direct_sync_single_for_cpu(dev, paddr, size, dir);
> +}
> +#endif
> +
> +static inline void dma_direct_sync_single_for_cpu(struct device *dev,
> +		dma_addr_t addr, size_t size, enum dma_data_direction dir)
> +{
> +	phys_addr_t paddr = dma_to_phys(dev, addr);
> +
> +	if (!dev_is_dma_coherent(dev))
> +		arch_sync_dma_for_cpu(paddr, size, dir);
> +
> +	__dma_direct_sync_single_for_cpu(dev, paddr, size, dir);
> +}
> +

I'm wondering why you don't implement this batch‑sync support inside the
arch_sync_dma_*() functions. Doing so would minimize changes to the generic
kernel/dma/* code and reduce the amount of #ifdef‑based spaghetti.

Thanks."
