Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B467187F
	for <iommu@lists.linux.dev>; Wed, 17 Aug 2022 12:53:57 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0485237487;
	Wed, 17 Aug 2022 12:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1660740828; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+WuvfTK8c1FVF6/MpxQXRnNeGiouttEZs3FJd6uoXKY=;
	b=gFPUUy9Uf8YZK27yj+fKIlj82Eps9LN++0QVPMK+RGcPs/pyrv3v2+CFZKvqnbQMcki88D
	otW/laYQbJRVuL3WYQmS3yhNUXtwaaJ0flb3gj5HNnXo7LfyMPaWmJPBMFBZSWqfaKJh1k
	mfmRE88do4O9bgafeOFTHpm2/Pb7ZOE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DA25B13428;
	Wed, 17 Aug 2022 12:53:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id W97vMtvk/GJsSgAAMHmgww
	(envelope-from <mhocko@suse.com>); Wed, 17 Aug 2022 12:53:47 +0000
Date: Wed, 17 Aug 2022 14:53:47 +0200
From: Michal Hocko <mhocko@suse.com>
To: Christoph Hellwig <hch@lst.de>
Cc: iommu@lists.linux.dev, Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	David Rientjes <rientjes@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] dma-pool: limit DMA and DMA32 zone size pools
Message-ID: <Yvzk2wE7ta+zSZOQ@dhcp22.suse.cz>
References: <20220817060647.1032426-1-hch@lst.de>
 <20220817060647.1032426-4-hch@lst.de>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220817060647.1032426-4-hch@lst.de>

On Wed 17-08-22 08:06:47, Christoph Hellwig wrote:
> Limit the sizing of the atomic pools for allocations from
> ZONE_DMA and ZONE_DMA32 based on the number of pages actually
> present in those zones instead of the total memory.
> 
> Fixes: c84dc6e68a1d ("dma-pool: add additional coherent pools to map to gfp mask")
> Reported-by: Michal Hocko <mhocko@suse.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Yes this is much more reasonable estimation. Especially for the DMA
zone. I still believe some downscaling would make sense but as said
earlier nothing to really insist on. Also you likely want to have
pr_warn for non-poppulated DMA zone as pointed in other thread[1].

Other than that looks good to me. FWIW
Acked-by: Michal Hocko <mhocko@suse.com>

[1] https://lore.kernel.org/all/YvyN/vI7+cTv0geS@dhcp22.suse.cz/?q=http%3A%2F%2Flkml.kernel.org%2Fr%2FYvyN%2FvI7%2BcTv0geS%40dhcp22.suse.cz

> ---
>  kernel/dma/pool.c | 40 +++++++++++++++++++++++++++++-----------
>  1 file changed, 29 insertions(+), 11 deletions(-)
> 
> diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
> index 5b07b0379a501..f629c6dfd8555 100644
> --- a/kernel/dma/pool.c
> +++ b/kernel/dma/pool.c
> @@ -193,28 +193,46 @@ static unsigned long calculate_pool_size(unsigned long zone_pages)
>  	return max_t(unsigned long, nr_pages << PAGE_SHIFT, SZ_128K);
>  }
>  
> +#if defined(CONFIG_ZONE_DMA) || defined(CONFIG_ZONE_DMA32)
> +static unsigned long __init nr_managed_pages(int zone_idx)
> +{
> +	struct pglist_data *pgdat;
> +	unsigned long nr_pages = 0;
> +
> +	for_each_online_pgdat(pgdat)
> +		nr_pages += zone_managed_pages(&pgdat->node_zones[zone_idx]);
> +	return nr_pages;
> +}
> +#endif /* CONFIG_ZONE_DMA || CONFIG_ZONE_DMA32 */
> +
>  static int __init dma_atomic_pool_init(void)
>  {
> +	unsigned long nr_zone_dma_pages, nr_zone_dma32_pages;
> +
> +#ifdef CONFIG_ZONE_DMA
> +	nr_zone_dma_pages = nr_managed_pages(ZONE_DMA);
> +	if (nr_zone_dma_pages)
> +		atomic_pool_dma = __dma_atomic_pool_init(
> +				calculate_pool_size(nr_zone_dma_pages),
> +				GFP_DMA);
> +#endif
> +#ifdef CONFIG_ZONE_DMA32
> +	nr_zone_dma32_pages = nr_managed_pages(ZONE_DMA32);
> +	if (nr_zone_dma32_pages)
> +		atomic_pool_dma32 = __dma_atomic_pool_init(
> +				calculate_pool_size(nr_zone_dma32_pages),
> +				GFP_DMA32);
> +#endif
>  	/*
>  	 * If coherent_pool was not used on the command line, default the pool
>  	 * sizes to 128KB per 1GB of memory, min 128KB, max MAX_ORDER-1.
>  	 */
>  	if (!atomic_pool_size)
>  		atomic_pool_size = calculate_pool_size(totalram_pages());
> -
> -	INIT_WORK(&atomic_pool_work, atomic_pool_work_fn);
> -
>  	atomic_pool_kernel = __dma_atomic_pool_init(atomic_pool_size,
>  						    GFP_KERNEL);
> -	if (has_managed_dma()) {
> -		atomic_pool_dma = __dma_atomic_pool_init(atomic_pool_size,
> -						GFP_KERNEL | GFP_DMA);
> -	}
> -	if (IS_ENABLED(CONFIG_ZONE_DMA32)) {
> -		atomic_pool_dma32 = __dma_atomic_pool_init(atomic_pool_size,
> -						GFP_KERNEL | GFP_DMA32);
> -	}
>  
> +	INIT_WORK(&atomic_pool_work, atomic_pool_work_fn);
>  	dma_atomic_pool_debugfs_init();
>  	return 0;
>  }
> -- 
> 2.30.2

-- 
Michal Hocko
SUSE Labs
