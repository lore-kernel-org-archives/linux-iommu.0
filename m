Received: from bee.tesarici.cz (bee.tesarici.cz [77.93.223.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C91F4408
	for <iommu@lists.linux.dev>; Fri,  8 Sep 2023 12:44:28 +0000 (UTC)
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id 2032E18D453;
	Fri,  8 Sep 2023 14:44:20 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=none dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tesarici.cz; s=mail;
	t=1694177060; bh=gDywMu6moeIwATviknj1VKAXOH6PihbQyh9NdGo0/cA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=B/wGdFzqdyD8VJjJWa2B8hjTsiaeJL23RDScj0CriFJ9VIylzJCjYxPpPS6/MPInP
	 2RxbXRD4uBvqtSn5A7h/gkjX9enxmG4g7TrD1ygzBfxWqUmAt6HJSA8KF6tGqnSEPI
	 VSkEfGtZ/IBkk5bEhd/2zpZJ8yHS9BkJoCJHElOTmi7fJd7ZlwRxrcQRjtOaz0p2my
	 UCHCsCLvoephi2WKRe+dyMps4TfZMZmga/d8a29edlPoUjUFJLm7lFGV5WvJjVDqzU
	 tTDb3oCUAtuGFX9sFcC+PgggMmgVvbc0wblbMFGHh3uC1T0aP2mpn/H7dzbLSM77Ad
	 HyeNpqU9AHlBw==
Date: Fri, 8 Sep 2023 14:44:18 +0200
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Christoph Hellwig <hch@lst.de>
Cc: m.szyprowski@samsung.com, robin.murphy@arm.com,
 petr.tesarik.ext@huawei.com, iommu@lists.linux.dev, Jonathan Corbet
 <corbet@lwn.net>
Subject: Re: [PATCH] swiotlb: add the missing dynamic swiotlb check in
 is_swiotlb_buffer
Message-ID: <20230908144418.3f078dea@meshulam.tesarici.cz>
In-Reply-To: <20230905064441.127588-1-hch@lst.de>
References: <20230905064441.127588-1-hch@lst.de>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  5 Sep 2023 08:44:41 +0200
Christoph Hellwig <hch@lst.de> wrote:

> Commit 1395706a1490 ("swiotlb: search the software IO TLB only if the
> device makes use of it") claims to avoid the dynamic swiotlb lookup
> unless dynamic allocations are actually used.  And while it adds all
> the infrastructure for doing that, it misses the final bit of actually
> checking the flag.  Actually add the check for this functionality to
> work.
> 
> Fixes: 1395706a1490 ("swiotlb: search the software IO TLB only if the device makes use of it")
> Reported-by: Jonathan Corbet <corbet@lwn.net>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  include/linux/swiotlb.h | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
> index b4536626f8ff35..a188025389836b 100644
> --- a/include/linux/swiotlb.h
> +++ b/include/linux/swiotlb.h
> @@ -172,13 +172,17 @@ static inline bool is_swiotlb_buffer(struct device *dev, phys_addr_t paddr)
>  	if (!mem)
>  		return false;
>  
> -	if (IS_ENABLED(CONFIG_SWIOTLB_DYNAMIC)) {
> -		/* Pairs with smp_wmb() in swiotlb_find_slots() and
> +#ifdef CONFIG_SWIOTLB_DYNAMIC
> +	if (dev->dma_uses_io_tlb) {
> +		/*
> +		 * Pairs with smp_wmb() in swiotlb_find_slots() and
>  		 * swiotlb_dyn_alloc(), which modify the RCU lists.
>  		 */
>  		smp_rmb();
>  		return swiotlb_find_pool(dev, paddr);
>  	}
> +#endif
> +

Not quite. This code is not SMP safe. I believe that:

1. the value must be read with a READ_ONCE(),
2. the memory barrier must precede the read operation.

Do you want to send a v2, or should I send my version instead?

Petr T
