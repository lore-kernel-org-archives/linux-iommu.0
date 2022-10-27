Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0728646A9
	for <iommu@lists.linux.dev>; Thu, 27 Oct 2022 16:55:03 +0000 (UTC)
Received: from quatroqueijos.cascardo.eti.br (1.general.cascardo.us.vpn [10.172.70.58])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id B9873431D9;
	Thu, 27 Oct 2022 16:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1666889198;
	bh=3dws5278xfOz0tuQBXMylmzota9MblVhmPDKk/4eevY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=vB9jh2iMmUZpIG5wJ2UWh8XTs+L53CMfKSmoMK1qgjYTlNnUKN5f0v2gOdzGBd78Q
	 A+UQxNRXV51g5pdbYX761i5hSCW2ORCS6gv01ydbPPfdd9SWg7iXj7zkAIBD0Ovlup
	 qwhigHvT+53w6Mtu+7AZ1i+r5uwsbPILFmD1V49NY4esyS4Ng9uAEs6WTVqkmxQZO7
	 DLETm1aSpre3EnO4Qhttdgutys7egxfNFzY1SymYx1YdCJjnqWobjx9iwjimFYejDW
	 om090fvXPbkUtbN4c7LDD5dlHaeN1KZhm8ClXLBZ+HjXcxOGJ9Y/y9XmtH9YCM1z77
	 dcw3JuHEdea2g==
Date: Thu, 27 Oct 2022 13:46:32 -0300
From: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
To: Alexey Kardashevskiy <aik@amd.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, Ashish Kalra <ashish.kalra@amd.com>,
	Pankaj Gupta <pankaj.gupta@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH kernel] x86/swiotlb/amd: Half the size if allocation
 failed
Message-ID: <Y1q16MQvzP8LobHx@quatroqueijos.cascardo.eti.br>
References: <20221027052607.260234-1-aik@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221027052607.260234-1-aik@amd.com>

On Thu, Oct 27, 2022 at 04:26:07PM +1100, Alexey Kardashevskiy wrote:
> At the moment the AMD encrypted platform reserves 6% of RAM for SWIOTLB
> or 1GB, whichever is less. However it is possible that there is no block
> big enough in the low memory which make SWIOTLB allocation fail and
> the kernel continues without DMA. In such case a VM hangs on DMA.
> 
> This divides the size in half and tries again reusing the existing
> remapping logic.
> 
> This updates default_nslabs on successful allocation which looks like
> an oversight as not doing so should have broken callers of
> swiotlb_size_or_default().
> 
> Signed-off-by: Alexey Kardashevskiy <aik@amd.com>

Should this have a
Fixes: e998879d4fb7 ("x86,swiotlb: Adjust SWIOTLB bounce buffer size for SEV guests")
?

Cascardo.

> --
> 
> I hit the problem with
> QEMU's "-m 16819M" where SWIOTLB was adjusted to
> 0x7e200 == 1,058,013,184 (slightly less than 1GB) while
> 0x7e180 still worked.
> 
> With guest errors enabled, there are many unassigned accesses from
> virtio.
> 
> ---
>  kernel/dma/swiotlb.c | 20 +++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 339a990554e7..d28c294320fd 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -338,21 +338,27 @@ void __init swiotlb_init_remap(bool addressing_limit, unsigned int flags,
>  	else
>  		tlb = memblock_alloc_low(bytes, PAGE_SIZE);
>  	if (!tlb) {
> -		pr_warn("%s: failed to allocate tlb structure\n", __func__);
> -		return;
> -	}
> -
> -	if (remap && remap(tlb, nslabs) < 0) {
> +		pr_warn("%s: Failed to allocate %zu bytes tlb structure\n",
> +			__func__, bytes);
> +	} else if (remap && remap(tlb, nslabs) < 0) {
>  		memblock_free(tlb, PAGE_ALIGN(bytes));
> +		tlb = NULL;
> +		pr_warn("%s: Failed to remap %zu bytes\n", __func__, bytes);
> +	}
>  
> +	if (!tlb) {
>  		nslabs = ALIGN(nslabs >> 1, IO_TLB_SEGSIZE);
>  		if (nslabs >= IO_TLB_MIN_SLABS)
>  			goto retry;
> -
> -		pr_warn("%s: Failed to remap %zu bytes\n", __func__, bytes);
>  		return;
>  	}
>  
> +	if (default_nslabs != nslabs) {
> +		pr_info("SWIOTLB bounce buffer size adjusted %lu -> %lu slabs",
> +			default_nslabs, nslabs);
> +		default_nslabs = nslabs;
> +	}
> +
>  	alloc_size = PAGE_ALIGN(array_size(sizeof(*mem->slots), nslabs));
>  	mem->slots = memblock_alloc(alloc_size, PAGE_SIZE);
>  	if (!mem->slots) {
> -- 
> 2.37.3
> 
