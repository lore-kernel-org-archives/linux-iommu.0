Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855D727A462;
	Mon, 18 May 2026 11:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779103925; cv=none; b=manIwEQkdcclYtWA/RgDxG2KpUu8gfukmkEBzft/TL0zPcT2NaTZUupvopCpnHygtFpevXOA36IZBB3bz0nmlaV3KmL7jfjrUxFmtoqbX/KUDTTk9xeckOyvkBB9X4eTTeKAP9gMEU5/jY9MaKZ/MUHDYG7WDI6G/GW8tszdBnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779103925; c=relaxed/simple;
	bh=4Dbmj7XhRnrMXjWakuzlqq5ER5EFk8GBHXt3PKmJPcc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LM1MBgZ26rq9qQegi80O07oafMOZmZuq3ZXtJntxJ2ZJbbZjxyfidJr0ioqdPySfLh5TJFFNLlQTB0u/oTnIa/3mt5ezC4BOwt12y7eIeNMxbbwKOe2z+SMro+hVNFdlNfXF3w1C6rXn0zlnkWQwDkYe6G9HfxF5Mcnzk7URb4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rt4H7mJw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rt4H7mJw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEE4FC2BCB7;
	Mon, 18 May 2026 11:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779103925;
	bh=4Dbmj7XhRnrMXjWakuzlqq5ER5EFk8GBHXt3PKmJPcc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rt4H7mJwTCY2kijkHD3vwzln5hyWpXYfmycGEkrAbkFMLwAYn0eJ52t5lOATXWOfK
	 ss3DkxoGzkltND3qdUZfiNh2yIJsiRaNvegheRTKQAbqge7N1IjGoEv2Sfo/nZgcYz
	 b2mtdQoV/bDXeBivJomYRkXIHeGAIDasT4WC1chUTkM50SHGr1Bqs5UuV1mByZo24L
	 nw31wS/hXIQevdfOhCbhti7sXrHgHvonOtMX8jHBLwFjy6wx2Souzcr5NGLiFXRGvq
	 a89CgXms6lTnp17nlNhNxQvqop2z8XskKkFQtNRYiLLE3q5RZaWJUO+Z4zT/2VdG+r
	 MO6mewh+9CC9A==
Date: Mon, 18 May 2026 14:32:01 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: iommu@lists.linux.dev, Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dma-direct: Clear pages before coherent remap
Message-ID: <20260518113201.GN33515@unreal>
References: <20260517042955.2218649-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260517042955.2218649-1-rosenp@gmail.com>

On Sat, May 16, 2026 at 09:29:55PM -0700, Rosen Penev wrote:
> Clear pages through their page mapping before creating a coherent
> remap for dma-direct allocations. Some architectures implement the
> coherent remap as uncached memory, where the generic memset() path may
> use cache-only zeroing instructions that are not valid for the returned
> CPU mapping.
> 
> Keep the existing memset() for non-remapped allocations, but avoid
> normal memset() on the remapped coherent allocation path.
> 
> Assisted-by: Codex:GPT-5.5
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  kernel/dma/direct.c | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index 583c5922bca2..76f7bf43bd28 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -8,6 +8,7 @@
>  #include <linux/export.h>
>  #include <linux/mm.h>
>  #include <linux/dma-map-ops.h>
> +#include <linux/highmem.h>
>  #include <linux/scatterlist.h>
>  #include <linux/pfn.h>
>  #include <linux/vmalloc.h>
> @@ -104,6 +105,15 @@ static void __dma_direct_free_pages(struct device *dev, struct page *page,
>  	dma_free_contiguous(dev, page, size);
>  }
>  
> +static void dma_direct_zero_pages(struct page *page, size_t size)
> +{
> +	unsigned long count = PAGE_ALIGN(size) >> PAGE_SHIFT;
> +	unsigned long i;
> +
> +	for (i = 0; i < count; i++)
> +		clear_highpage(page + i);
> +}
> +
>  static struct page *dma_direct_alloc_swiotlb(struct device *dev, size_t size)
>  {
>  	struct page *page = swiotlb_alloc(dev, size);
> @@ -268,6 +278,13 @@ void *dma_direct_alloc(struct device *dev, size_t size,
>  	if (remap) {
>  		pgprot_t prot = dma_pgprot(dev, PAGE_KERNEL, attrs);
>  
> +		/*
> +		 * Zero via the page mapping before creating a potentially
> +		 * uncached remap.  Some architectures cannot safely run normal
> +		 * memset on uncached memory.
> +		 */

I can't say whether this description is accurate, but if it is, I'd expect
all memset callers on such architectures to be affected, not only the remap
path. If this holds, we will need a safe memset() implementation.

Thanks
