Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D950A33F398;
	Thu, 13 Nov 2025 18:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763057961; cv=none; b=ajeGYoo85eWzA+6LgLmzT7YOR3naqDoimiODycvx2EKt1T4RokW546x6eZqH+XX32gS/GyrgviIOnVYIebqoInPCu7TJp4oUF3zDsx7j6HpNbUrjuZ/TfR6tTZU9rVChosIpt68rmrsJDCgXWJmPuiXUEObDQBXDPhivvVrmjuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763057961; c=relaxed/simple;
	bh=yN6sALucFTZuvtSo5sQx4ZmhE8wZdfzxliY0lfji8Kg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O2xA3RyxAFOSMJDCyCWaDpY6yfDr2kahqXcdD887H55xSRF/GA3Q7lo0Boxd3BOrpIAvtFEVOkqoM3zQYStwd7rLz7uWvvwggngEgkT1N3mxhtyREQXb2r7kLW1bw5pxu8/FvkmoMyNpGii5IwAdpifxyapDVI+GztiQddj6kk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D39FAC4CEF1;
	Thu, 13 Nov 2025 18:19:18 +0000 (UTC)
Date: Thu, 13 Nov 2025 18:19:16 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Barry Song <21cnbao@gmail.com>
Cc: Will Deacon <will@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Barry Song <v-songbaohua@oppo.com>,
	Ada Couprie Diaz <ada.coupriediaz@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Tangquan Zheng <zhengtangquan@oppo.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Subject: Re: [RFC PATCH 5/5] dma-mapping: Allow batched DMA sync operations
 if supported by the arch
Message-ID: <aRYhJO9_eR9W-EnZ@arm.com>
References: <20251029023115.22809-1-21cnbao@gmail.com>
 <20251029023115.22809-6-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029023115.22809-6-21cnbao@gmail.com>

On Wed, Oct 29, 2025 at 10:31:15AM +0800, Barry Song wrote:
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index 1f9ee9759426..a0b45f84a91f 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -403,9 +403,16 @@ void dma_direct_sync_sg_for_device(struct device *dev,
>  		swiotlb_sync_single_for_device(dev, paddr, sg->length, dir);
>  
>  		if (!dev_is_dma_coherent(dev))
> -			arch_sync_dma_for_device(paddr, sg->length,
> -					dir);
> +#ifdef CONFIG_ARCH_WANT_BATCHED_DMA_SYNC
> +			arch_sync_dma_for_device_batch_add(paddr, sg->length, dir);
> +#else
> +			arch_sync_dma_for_device(paddr, sg->length, dir);
> +#endif
>  	}
> +#ifdef CONFIG_ARCH_WANT_BATCHED_DMA_SYNC
> +	if (!dev_is_dma_coherent(dev))
> +		arch_sync_dma_batch_flush();
> +#endif
>  }
>  #endif

Just a high-level comment for now. I'm not opposed to the idea of
batching the DSB barriers, we do this for ptes. However, the way it's
implemented in the generic files, with lots of #ifdefs, makes the code
pretty unreadable.

Can we have something like arch_sync_dma_begin/end() and let the arch
code handle the barriers as they see fit?

-- 
Catalin
