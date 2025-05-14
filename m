Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EBB81FDD;
	Wed, 14 May 2025 00:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747181664; cv=none; b=fFWewQhez5K7IyoZ9U+oq2HAAVJ6qAiswMMtS0UNDsqDdVkwCd9mZckk1sl12pFX91vXo/Fbl/IbxQUgLouXadsdKd5ARld1VTY9u7WUZQc5UsugwH6nXFHHDN/km4MJ62yf2QhCeOeWMXmZbB36ML++ejogGMeS2d7l0aZTpAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747181664; c=relaxed/simple;
	bh=jDk0BvPdBOsudd297pGyGFep8goSpk+trsNoQeXfyGQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=QdiEfvv0/4LRUh/AoK418c3VVZMDPdAMzJvD/jvXpmV/XzsnYXniwjCGcwkzxyJ1Uu5OptGNh7YAVU0Z1FjKdieZn94/8vDyyi2JK43d4E5n24cmHyM+5+OTRcRadBbzfAl//KN6HqE9GvN4May4cmWKwSMUrW0JKuc0oBdlFF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PqKGWCg8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PqKGWCg8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB457C4CEE4;
	Wed, 14 May 2025 00:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747181664;
	bh=jDk0BvPdBOsudd297pGyGFep8goSpk+trsNoQeXfyGQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=PqKGWCg8dh3loYFuR0jSEDNpWVH6sczf9s2k3j6fH+99wPEjDU5mG84IBYH5MbgD6
	 bjR2nxsM3pC2s89muWEUGZTb5OpRY+NhJX4YTbeneW+NCPR0lCE+BFYg5zPy8Yv0vs
	 8RLxEJgzLKFwjZ6k9OyVd8HdRr+7o1BoJNcRiFq1GVK8wBC3J5GLJscsFxtzpbNeaR
	 5o7g2Tedq+gTAJ8DP6FhEoyUi8KqEgjQeehOQg9wJepzLb2012iEcqacZ+iTAFaRtW
	 MsXRcMgbsLAI8UZlKD9z2Nytq530gIRICfeorKFZ+sL0L4v+WL7V0rsSewojSI0eoA
	 J4dtDhDgnN/Rw==
Date: Tue, 13 May 2025 17:14:22 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: John Ernberg <john.ernberg@actia.se>
cc: Juergen Gross <jgross@suse.com>, 
    Stefano Stabellini <sstabellini@kernel.org>, 
    Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, 
    "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, 
    "iommu@lists.linux.dev" <iommu@lists.linux.dev>, 
    "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
    Christoph Hellwig <hch@infradead.org>, 
    "imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: Re: [PATCH v2] xen: swiotlb: Wire up map_resource callback
In-Reply-To: <20250512071440.3726697-1-john.ernberg@actia.se>
Message-ID: <alpine.DEB.2.22.394.2505131714100.368682@ubuntu-linux-20-04-desktop>
References: <20250512071440.3726697-1-john.ernberg@actia.se>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 12 May 2025, John Ernberg wrote:
> When running Xen on iMX8QXP, an Arm SoC without IOMMU, DMA performed via
> its eDMA v3 DMA engine fail with a mapping error.
> 
> The eDMA performs DMA between RAM and MMIO space, and it's the MMIO side
> that cannot be mapped.
> 
> MMIO->RAM DMA access cannot be bounce buffered if it would straddle a page
> boundary and on Xen the MMIO space is 1:1 mapped for Arm, and x86 PV Dom0.
> Cases where MMIO space is not 1:1 mapped, such as x86 PVH Dom0, requires an
> IOMMU present to deal with the mapping.
> 
> Considering the above the map_resource callback can just be wired to the
> existing dma_direct_map_resource() function.
> 
> There is nothing to do for unmap so the unmap callback is not needed.
> 
> Signed-off-by: John Ernberg <john.ernberg@actia.se>

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>


> ---
> 
> v2:
>  - Just use dma_direct_map_resource() directly (Stefano Stabellini)
>  - Incorporate some of the discussion and explanations from v1 into the
>     commit message (Stefano, Christoph)
>  - General English improvements in the commit message.
>  - Just this patch now, 1/2 in the previous set was applied
> 
> v1: (series) https://lore.kernel.org/xen-devel/20250502114043.1968976-1-john.ernberg@actia.se/
> ---
>  drivers/xen/swiotlb-xen.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
> index ef56a2500ed6..da1a7d3d377c 100644
> --- a/drivers/xen/swiotlb-xen.c
> +++ b/drivers/xen/swiotlb-xen.c
> @@ -426,4 +426,5 @@ const struct dma_map_ops xen_swiotlb_dma_ops = {
>  	.alloc_pages_op = dma_common_alloc_pages,
>  	.free_pages = dma_common_free_pages,
>  	.max_mapping_size = swiotlb_max_mapping_size,
> +	.map_resource = dma_direct_map_resource,
>  };
> -- 
> 2.49.0
> 
