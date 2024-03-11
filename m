Received: from bee.tesarici.cz (bee.tesarici.cz [37.205.15.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2424A4206B
	for <iommu@lists.linux.dev>; Mon, 11 Mar 2024 20:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.15.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710187513; cv=none; b=QOSsTZ2GeN6AmaNuB8BCtobX2EYSdUTQ1L+OzkoZQVbF9uvE+g0I7fziuqsoRoZIK9gjK+6NVQh/6oFuMwT5/oMvIObsn/mmXKDmcIO+scFq3MBlR/6fsD3SsSpnOHy3hu+jr3gHaKX42B6DABs/wMdIhXMUk9hWUA9MuGljjFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710187513; c=relaxed/simple;
	bh=Dd3L8MnUZbt3XNG7D95vnVqMzNTpKO7da/OXJzhdrJY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B7LLaKAfSHch9ilFEic5qX7gPEDnq+pRMYJB/octnospFAfehhpIrv0OQlk2ExhvrYxWf+CZSLce8oau/xHX73r2PLX+FlV/XtKYX/quUHY0Rdav6IJC6XNgurFXYxTRRvX7FsnSt4jEj8ePK9ZaLmOV9HO3HpkpHs6+WjCIQ6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz; spf=pass smtp.mailfrom=tesarici.cz; dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b=wyEKgURJ; arc=none smtp.client-ip=37.205.15.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="wyEKgURJ"
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id C4DE01CFAE6;
	Mon, 11 Mar 2024 21:05:08 +0100 (CET)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesarici.cz; s=mail;
	t=1710187509; bh=UR9/fHtF3ylhFb+vQrKq2FopW5DRuWNRssvKZI8ZonY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=wyEKgURJ/lwuVhrDSJ9tPWRN7winKNNaRknwXJWxewn2lpx4cAtHvgJs6XzuZc9vo
	 6iX4aBnh3QizG7IyItjoQqmj1Uuz7zyTUDcIlEhiYP1iTTk7MV8m9O+yZZ8nZD7sjI
	 Jlsvq3IsJaOuCWgX+yRbAGwnA+jNnno69KDEpJ5hjY4nwdSD46calyYGhDtlz82aia
	 JyvClztpcOJYNRLHUUR9oN3Z/J6n/0+p8YP+Gb73meFyME9cVtiajKOcmwHIyDLGgA
	 dlRY+OOfeCBWrU8nCdPTp+NHfgx8VMxJJp1x7IPyS1juHZwMhY/8L7iDDqTKop9M6e
	 MArHNeOxOk1kA==
Date: Mon, 11 Mar 2024 21:05:07 +0100
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Will Deacon <will@kernel.org>, Nicolin Chen <nicolinc@nvidia.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com,
 iommu@lists.linux.dev, Christoph Hellwig <hch@lst.de>, Marek Szyprowski
 <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Petr
 Tesarik <petr.tesarik1@huawei-partners.com>, Dexuan Cui
 <decui@microsoft.com>, Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH v6 4/6] swiotlb: Fix alignment checks when both
 allocation and DMA masks are present
Message-ID: <20240311210507.217daf8b@meshulam.tesarici.cz>
In-Reply-To: <20240308152829.25754-5-will@kernel.org>
References: <20240308152829.25754-1-will@kernel.org>
	<20240308152829.25754-5-will@kernel.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  8 Mar 2024 15:28:27 +0000
Will Deacon <will@kernel.org> wrote:

> Nicolin reports that swiotlb buffer allocations fail for an NVME device
> behind an IOMMU using 64KiB pages. This is because we end up with a
> minimum allocation alignment of 64KiB (for the IOMMU to map the buffer
> safely) but a minimum DMA alignment mask corresponding to a 4KiB NVME
> page (i.e. preserving the 4KiB page offset from the original allocation).
> If the original address is not 4KiB-aligned, the allocation will fail
> because swiotlb_search_pool_area() erroneously compares these unmasked
> bits with the 64KiB-aligned candidate allocation.
> 
> Tweak swiotlb_search_pool_area() so that the DMA alignment mask is
> reduced based on the required alignment of the allocation.
> 
> Fixes: 82612d66d51d ("iommu: Allow the dma-iommu api to use bounce buffers")
> Reported-by: Nicolin Chen <nicolinc@nvidia.com>
> Link: https://lore.kernel.org/r/cover.1707851466.git.nicolinc@nvidia.com
> Tested-by: Nicolin Chen <nicolinc@nvidia.com>
> Reviewed-by: Michael Kelley <mhklinux@outlook.com>
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>  kernel/dma/swiotlb.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index c20324fba814..c381a7ed718f 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -981,8 +981,7 @@ static int swiotlb_search_pool_area(struct device *dev, struct io_tlb_pool *pool
>  	dma_addr_t tbl_dma_addr =
>  		phys_to_dma_unencrypted(dev, pool->start) & boundary_mask;
>  	unsigned long max_slots = get_max_slots(boundary_mask);
> -	unsigned int iotlb_align_mask =
> -		dma_get_min_align_mask(dev) & ~(IO_TLB_SIZE - 1);
> +	unsigned int iotlb_align_mask = dma_get_min_align_mask(dev);
>  	unsigned int nslots = nr_slots(alloc_size), stride;
>  	unsigned int offset = swiotlb_align_offset(dev, orig_addr);
>  	unsigned int index, slots_checked, count = 0, i;
> @@ -993,6 +992,14 @@ static int swiotlb_search_pool_area(struct device *dev, struct io_tlb_pool *pool
>  	BUG_ON(!nslots);
>  	BUG_ON(area_index >= pool->nareas);
>  
> +	/*
> +	 * Ensure that the allocation is at least slot-aligned and update
> +	 * 'iotlb_align_mask' to ignore bits that will be preserved when
> +	 * offsetting into the allocation.
> +	 */
> +	alloc_align_mask |= (IO_TLB_SIZE - 1);
> +	iotlb_align_mask &= ~alloc_align_mask;
> +

I have started writing the KUnit test suite, and the results look
incorrect to me for this case.

I'm calling swiotlb_tbl_map_single() with:

* alloc_align_mask = 0xfff
* a device with min_align_mask = 0xfff
* the 12 lowest bits of orig_addr are 0xfa0

The min_align_mask becomes zero after the masking added by this patch,
and the 12 lowest bits of the returned address are 0x7a0, i.e. not
equal to 0xfa0.

In other words, the min_align_mask constraint is not honored. Of course,
given the above values, it is not possible to honor both min_align_mask
and alloc_align_mask. I find it somewhat surprising that NVMe does not
in fact require that the NVME_CTRL_PAGE_SHIFT low bits are preserved,
as suggested by Nicolin's successful testing.

Why is that?

Does IOMMU do some additional post-processing of the bounce buffer
address to restore the value of bit 11?

Or is this bit always zero in all real-world scenarios?

Petr T
