Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E47DC3A3833
	for <iommu@lists.linux.dev>; Tue, 10 Mar 2026 13:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773149775; cv=none; b=tQcaix1fR9NHN5ObVBlaPXAk+5GjNAO+8yA5HPGf4kmPWLUMKpAp0ZGYnwGSjFkuTyY1UEbpP2XCl8Xa1UJq/AHOK/Np8W8pDxt0mCO0SF/jZcFvQvPU2T1APwwrPD0Ghv495I5aD3JUdCObjxy9pkSSHUPDw5nDpR72R6uxfnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773149775; c=relaxed/simple;
	bh=60eeanxdowZD7zyO7QeXvIRXUSiRgiL/8FvNbm6gdbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hfZzKVss+Ua/TWMqvbuuLtjlicQ68cnSc6j4G2U2tTmvAbUqG8m6yLMsKg3LhUvefVW2aiX+5B6s3sNZ0z2j1kSwTEVZt1y02O6jL0I86tmeX3uBwfaZ8b6XfEx/2X9EKKw7AUWqGE4P1lOuXdH0UORraOWuvmR0vlJINedK8Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 38603169C;
	Tue, 10 Mar 2026 06:36:06 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 394CF3F73B;
	Tue, 10 Mar 2026 06:36:11 -0700 (PDT)
Date: Tue, 10 Mar 2026 13:36:08 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Mostafa Saleh <smostafa@google.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	robin.murphy@arm.com, m.szyprowski@samsung.com, will@kernel.org,
	maz@kernel.org, suzuki.poulose@arm.com
Subject: Re: [RFC PATCH 1/2] dma-mapping: Avoid double decrypting with
 DMA_RESTRICTED_POOL
Message-ID: <abAeSML-7ziLeIvv@arm.com>
References: <20260305170335.963568-1-smostafa@google.com>
 <20260305170335.963568-2-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260305170335.963568-2-smostafa@google.com>

On Thu, Mar 05, 2026 at 05:03:34PM +0000, Mostafa Saleh wrote:
> In case a device have a restricted DMA pool, it will be decrypted.
> However, in the path of dma_direct_alloc() memory can be allocated
> from this pool using, __dma_direct_alloc_pages() =>
> dma_direct_alloc_swiotlb()
> 
> After that from the same function, it will attempt to decrypt it
> using dma_set_decrypted() if force_dma_unencrypted().
> 
> Which results in the memory being decrypted twice.
> 
> It's not clear how the does realm world/hypervisors deal with that,
> for example:
> - Clear a bit in the page table and call realm IPA_STATE_SET
> - TDX: Seems to issue a hypercall also.
> - pKVM: Which doesn't implement force_dma_unencrypted() at the moment,
>   uses a share hypercall which is definitely not Idempotent.
> 
> This patch will only encrypt/decrypt memory that are not allocated
> form the restricted dma pools.
> 
> Signed-off-by: Mostafa Saleh <smostafa@google.com>
> ---
>  kernel/dma/direct.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index 8f43a930716d..27d804f0473f 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -79,7 +79,7 @@ bool dma_coherent_ok(struct device *dev, phys_addr_t phys, size_t size)
>  
>  static int dma_set_decrypted(struct device *dev, void *vaddr, size_t size)
>  {
> -	if (!force_dma_unencrypted(dev))
> +	if (!force_dma_unencrypted(dev) || is_swiotlb_for_alloc(dev))
>  		return 0;
>  	return set_memory_decrypted((unsigned long)vaddr, PFN_UP(size));
>  }
> @@ -88,7 +88,7 @@ static int dma_set_encrypted(struct device *dev, void *vaddr, size_t size)
>  {
>  	int ret;
>  
> -	if (!force_dma_unencrypted(dev))
> +	if (!force_dma_unencrypted(dev) || is_swiotlb_for_alloc(dev))
>  		return 0;
>  	ret = set_memory_encrypted((unsigned long)vaddr, PFN_UP(size));
>  	if (ret)

I think that's functionally correct for rmem buffers. Normally I'd have
moved the is_swiotlb_for_alloc() condition in the caller but even
dma_direct_alloc() doesn't know where the buffer came from, it's hidden
in __dma_direct_alloc_pages().

However, it's unclear to me whether we can get encrypted pages when
is_swiotlb_for_alloc() == false, remap == true and
force_dma_unencrypted() == true in dma_direct_alloc().
dma_set_decrypted() is only called on the !remap path.

-- 
Catalin
