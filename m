Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F3C38DD6
	for <iommu@lists.linux.dev>; Tue, 26 Sep 2023 18:17:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BE77C433C9;
	Tue, 26 Sep 2023 18:17:31 +0000 (UTC)
Date: Tue, 26 Sep 2023 19:17:29 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Petr Tesarik <petr@tesarici.cz>
Cc: Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	"open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>,
	Roberto Sassu <roberto.sassu@huaweicloud.com>,
	Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v2] swiotlb: fix the check whether a device has used
 software IO TLB
Message-ID: <ZRMgObTMkfq8Bjbe@arm.com>
References: <20230926162339.12940-1-petr@tesarici.cz>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230926162339.12940-1-petr@tesarici.cz>

On Tue, Sep 26, 2023 at 06:23:39PM +0200, Petr Tesarik wrote:
> When CONFIG_SWIOTLB_DYNAMIC=y, devices which do not use the software IO TLB
> can avoid swiotlb lookup. A flag is added by commit 1395706a1490 ("swiotlb:
> search the software IO TLB only if the device makes use of it"), the flag
> is correctly set, but it is then never checked. Add the actual check here.
> 
> Note that this code is an alternative to the default pool check, not an
> additional check, because:
> 
> 1. swiotlb_find_pool() also searches the default pool;
> 2. if dma_uses_io_tlb is false, the default swiotlb pool is not used.
> 
> Tested in a KVM guest against a QEMU RAM-backed SATA disk over virtio and
> *not* using software IO TLB, this patch increases IOPS by approx 2% for
> 4-way parallel I/O.
> 
> The write memory barrier in swiotlb_dyn_alloc() is not needed, because a
> newly allocated pool must always be observed by swiotlb_find_slots() before
> an address from that pool is passed to is_swiotlb_buffer().
> 
> Correctness was verified using the following litmus test:
[...]
> Fixes: 1395706a1490 ("swiotlb: search the software IO TLB only if the device makes use of it")
> Reported-by: Jonathan Corbet <corbet@lwn.net>
> Closes: https://lore.kernel.org/linux-iommu/87a5uz3ob8.fsf@meer.lwn.net/
> Signed-off-by: Petr Tesarik <petr@tesarici.cz>

Thanks for the update.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

> diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
> index b4536626f8ff..93b400d9be91 100644
> --- a/include/linux/swiotlb.h
> +++ b/include/linux/swiotlb.h
> @@ -172,14 +172,22 @@ static inline bool is_swiotlb_buffer(struct device *dev, phys_addr_t paddr)
>  	if (!mem)
>  		return false;
>  
> -	if (IS_ENABLED(CONFIG_SWIOTLB_DYNAMIC)) {
> -		/* Pairs with smp_wmb() in swiotlb_find_slots() and
> -		 * swiotlb_dyn_alloc(), which modify the RCU lists.
> -		 */
> -		smp_rmb();
> -		return swiotlb_find_pool(dev, paddr);
> -	}
> +#ifdef CONFIG_SWIOTLB_DYNAMIC
> +	/* All SWIOTLB buffer addresses must have been returned by
> +	 * swiotlb_tbl_map_single() and passed to a device driver.
> +	 * If a SWIOTLB address is checked on another CPU, then it was
> +	 * presumably loaded by the device driver from an unspecified private
> +	 * data structure. Make sure that this load is ordered before reading
> +	 * dev->dma_uses_io_tlb here and mem->pools in swiotlb_find_pool().
> +	 *
> +	 * This barrier pairs with smp_mb() in swiotlb_find_slots().
> +	 */

Nitpick. The official multi-line comment style is:

	/*
	 * Text.
	 */

i.e. it starts with an empty /* line.

> @@ -1152,9 +1149,25 @@ static int swiotlb_find_slots(struct device *dev, phys_addr_t orig_addr,
>  	spin_unlock_irqrestore(&dev->dma_io_tlb_lock, flags);
>  
>  found:
> -	dev->dma_uses_io_tlb = true;
> -	/* Pairs with smp_rmb() in is_swiotlb_buffer() */
> -	smp_wmb();
> +	WRITE_ONCE(dev->dma_uses_io_tlb, true);
> +
> +	/* The general barrier orders reads and writes against a presumed store
> +	 * of the SWIOTLB buffer address by a device driver (to a driver private
> +	 * data structure). It serves two purposes.

Same here.

-- 
Catalin
