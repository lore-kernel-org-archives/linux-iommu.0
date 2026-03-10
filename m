Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623CB3A3806
	for <iommu@lists.linux.dev>; Tue, 10 Mar 2026 13:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773148087; cv=none; b=m4oQjehgzIoTybEHJBFjIUUFNlbGEld0zpKDY6TB/cI66I5uB8HOeGqbdxiypVYag+sPGwadIDuEt2NWcm66Jf4aecFtk1c2AjdxIBOLM4Hzz5lRTpFuIch5b7nnzRpiN2ui1Bl0eCNoGYArGemjzR8kiMGJsF5NsnOjDZcMWE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773148087; c=relaxed/simple;
	bh=wDcsQFQGcqgHWNkU5BUCPLGrOdeOMyOh4sWtc8pyfoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jfP20Vo5PH4lqN3HAjtM24VtA/ZAEhkmmUnwJQmlemyD9nXQW5H2ZvwJ7eU9+aSU3s9dJ+RDS/3pXvMrC3mRNP1uHFforWzD7KDvB/JPFE2SpiVxFgS0a2VNi04fdBNPYr8dwqLc1xAtTw4bBcYU364Hfqk2Vf/dTxzB4DUr8xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 46EFC169C;
	Tue, 10 Mar 2026 06:07:58 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 47C4B3F73B;
	Tue, 10 Mar 2026 06:08:03 -0700 (PDT)
Date: Tue, 10 Mar 2026 13:08:00 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Mostafa Saleh <smostafa@google.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	robin.murphy@arm.com, m.szyprowski@samsung.com, will@kernel.org,
	maz@kernel.org, suzuki.poulose@arm.com
Subject: Re: [RFC PATCH 2/2] dma-mapping: Use the correct phys_to_dma() for
 DMA_RESTRICTED_POOL
Message-ID: <abAXsK6XE6119g09@arm.com>
References: <20260305170335.963568-1-smostafa@google.com>
 <20260305170335.963568-3-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260305170335.963568-3-smostafa@google.com>

On Thu, Mar 05, 2026 at 05:03:35PM +0000, Mostafa Saleh wrote:
> As restricted dma pools are always decrypted, in swiotlb.c it uses
> phys_to_dma_unencrypted() for address conversion.
> 
> However, in DMA-direct, calls to phys_to_dma_direct() with
> force_dma_unencrypted() returning false, will fallback to
> phys_to_dma() which is inconsistent for memory allocated from
> restricted dma pools.
> 
> Signed-off-by: Mostafa Saleh <smostafa@google.com>
> ---
>  kernel/dma/direct.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index 27d804f0473f..1a402bb956d9 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -26,7 +26,7 @@ u64 zone_dma_limit __ro_after_init = DMA_BIT_MASK(24);
>  static inline dma_addr_t phys_to_dma_direct(struct device *dev,
>  		phys_addr_t phys)
>  {
> -	if (force_dma_unencrypted(dev))
> +	if (force_dma_unencrypted(dev) || is_swiotlb_for_alloc(dev))
>  		return phys_to_dma_unencrypted(dev, phys);
>  	return phys_to_dma(dev, phys);
>  }

I couldn't fully get my head around the DMA API but I think all the
pools and bounce buffers are decrypted and protected guests (or realms
for Arm CCA) should always return true for force_dma_unencrypted(). If
that's the case, the above change wouldn't be necessary. I can see that
arm64 only does this for CCA and not pKVM guests.

Device assignment is another story that requires reworking those DMA
pools to support encrypted buffers.

-- 
Catalin
