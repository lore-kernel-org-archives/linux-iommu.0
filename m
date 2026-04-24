Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08BE3783C7;
	Fri, 24 Apr 2026 23:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777073172; cv=none; b=h8pspQAbXxuxJCiEMbkD6Sr1ai4AUX25/jvCoIDmlEQd/S4ISp3yI2ZtwPtgg8p+/ARIygd8Wu/yLWE/WSKjfB7CeKTpckxdtuvfCbSRDF9/2CrosM6NOY7cGwHUmev92+ndMCaY9wuSYVtoUTXbDGb/zq/TMh3QjVFFbi6syFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777073172; c=relaxed/simple;
	bh=kyRqrvgm9QqjIN/vVRy0hj3rI8A+watg1fyfjslJQIM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=U2z3BZ6gZq9jBkpDkHG4GuG3JQhun47FeTNCLX5c8ouxuU0pxRSmk4IrrL17DXiiUSwMiDdEZScY6zAti5d3R6Y6mTmuP6zT3GkFF8yWtZV5ruD9sX/cPaXb3W6h49BsZYx13CtE42ZnOCHGzAG/RqMqa25mkGSAn9TUpaA1f8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UwwfIxM4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UwwfIxM4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21CDAC19425;
	Fri, 24 Apr 2026 23:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777073172;
	bh=kyRqrvgm9QqjIN/vVRy0hj3rI8A+watg1fyfjslJQIM=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=UwwfIxM4JV7wubgaeaYSQkjbGQNgnAwrfN/4+zeuwVqFMOA0LSHbOKzFln0vWgY0G
	 bTiMyd3Q10e9NYCZ3UyicG+k31XBupmLmYGtAsO7td/GNnFlQsspxbnwVXzZ+pKqdE
	 zo/Of9k44IjrCFYqr4wIBJq+oj/q+SXjdtLG1BQuG4rbL+cG7SwhouCa5FO9YiecFI
	 bbK5zj0gbiAy7TzPZILS8p7hCtGThM+owN4VxQwqb6UyJHlUWffG11Smcaiy7m+1Ed
	 lmeBvIX4Jvcr8aG3uOoa4h8iThbEMi9TIRzn/b963ZpF+40oQTde0yCyYn9/4HZANp
	 4aPZHgoN81vOw==
Date: Fri, 24 Apr 2026 16:26:11 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
cc: Juergen Gross <jgross@suse.com>, 
    Stefano Stabellini <sstabellini@kernel.org>, 
    Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, 
    xen-devel@lists.xenproject.org, iommu@lists.linux.dev, 
    linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>, 
    michal.orzel@amd.com
Subject: Re: [PATCH RFC] xen/swiotlb: avoid arch_sync_dma_* on per-device
 DMA memory
In-Reply-To: <20260415-xen-swiotlb-v1-1-de24eda3c0fd@nxp.com>
Message-ID: <alpine.DEB.2.22.394.2604241617450.6871@ubuntu-linux-20-04-desktop>
References: <20260415-xen-swiotlb-v1-1-de24eda3c0fd@nxp.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

+Michal

On Wed, 15 Apr 2026, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> On ARM64, arch_sync_dma_for_{cpu,device}() assumes that the
> physical address passed in refers to normal RAM that is part of the
> kernel linear(direct) mapping, as it unconditionally derives a CPU
> virtual address via phys_to_virt().
> 
> With Xen swiotlb, devices may use per-device coherent DMA memory,
> such as reserved-memory regions described by 'shared-dma-pool',
> which are assigned to dev->dma_mem. These regions may be marked
> no-map in DT and therefore are not part of the kernel linear map.
> In such cases, pfn_valid() still returns true, but phys_to_virt()
> is not valid and cache maintenance via arch_sync_dma_* will fault.
> 
> Prevent this by excluding devices with a private DMA memory pool
> (dev->dma_mem) from the arch_sync_dma_* fast path, and always
> fall back to xen_dma_sync_* for those devices to avoid invalid
> phys_to_virt() conversions for no-map DMA memory while preserving the
> existing fast path for normal, linear-mapped RAM.

This might not work either: the Xen side implementation is
xen/common/grant_table.c:_cache_flush.

Could you please check? From looking at the code,
page_get_owner_and_reference might return NULL for pages part of
reserved-memory regions marked as no-map.

In which case, the Xen hypercall should return -EPERM.



> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/xen/swiotlb-xen.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
> index 2cbf2b588f5b20cfbf9e83a8339dc22092c9559a..b1445df99d9a8f1d18a83b8c413bada6e5579209 100644
> --- a/drivers/xen/swiotlb-xen.c
> +++ b/drivers/xen/swiotlb-xen.c
> @@ -195,6 +195,11 @@ xen_swiotlb_free_coherent(struct device *dev, size_t size, void *vaddr,
>  }
>  #endif /* CONFIG_X86 */
>  
> +static inline bool dev_has_private_dma_pool(struct device *dev)
> +{
> +	return dev && dev->dma_mem;
> +}
> +
>  /*
>   * Map a single buffer of the indicated size for DMA in streaming mode.  The
>   * physical address to use is returned.
> @@ -262,7 +267,8 @@ static dma_addr_t xen_swiotlb_map_phys(struct device *dev, phys_addr_t phys,
>  
>  done:
>  	if (!dev_is_dma_coherent(dev) && !(attrs & DMA_ATTR_SKIP_CPU_SYNC)) {
> -		if (pfn_valid(PFN_DOWN(dma_to_phys(dev, dev_addr)))) {
> +		if (pfn_valid(PFN_DOWN(dma_to_phys(dev, dev_addr))) &&
> +		    !dev_has_private_dma_pool(dev)) {
>  			arch_sync_dma_for_device(phys, size, dir);
>  			arch_sync_dma_flush();
>  		} else {
> @@ -289,7 +295,8 @@ static void xen_swiotlb_unmap_phys(struct device *hwdev, dma_addr_t dev_addr,
>  	BUG_ON(dir == DMA_NONE);
>  
>  	if (!dev_is_dma_coherent(hwdev) && !(attrs & DMA_ATTR_SKIP_CPU_SYNC)) {
> -		if (pfn_valid(PFN_DOWN(dma_to_phys(hwdev, dev_addr)))) {
> +		if (pfn_valid(PFN_DOWN(dma_to_phys(hwdev, dev_addr))) &&
> +		    !dev_has_private_dma_pool(hwdev)) {
>  			arch_sync_dma_for_cpu(paddr, size, dir);
>  			arch_sync_dma_flush();
>  		} else {
> @@ -312,7 +319,8 @@ xen_swiotlb_sync_single_for_cpu(struct device *dev, dma_addr_t dma_addr,
>  	struct io_tlb_pool *pool;
>  
>  	if (!dev_is_dma_coherent(dev)) {
> -		if (pfn_valid(PFN_DOWN(dma_to_phys(dev, dma_addr)))) {
> +		if (pfn_valid(PFN_DOWN(dma_to_phys(dev, dma_addr))) &&
> +		    !dev_has_private_dma_pool(dev)) {
>  			arch_sync_dma_for_cpu(paddr, size, dir);
>  			arch_sync_dma_flush();
>  		} else {
> @@ -337,7 +345,8 @@ xen_swiotlb_sync_single_for_device(struct device *dev, dma_addr_t dma_addr,
>  		__swiotlb_sync_single_for_device(dev, paddr, size, dir, pool);
>  
>  	if (!dev_is_dma_coherent(dev)) {
> -		if (pfn_valid(PFN_DOWN(dma_to_phys(dev, dma_addr)))) {
> +		if (pfn_valid(PFN_DOWN(dma_to_phys(dev, dma_addr))) &&
> +		    !dev_has_private_dma_pool(dev)) {
>  			arch_sync_dma_for_device(paddr, size, dir);
>  			arch_sync_dma_flush();
>  		} else {
> 
> ---
> base-commit: 66672af7a095d89f082c5327f3b15bc2f93d558e
> change-id: 20260415-xen-swiotlb-34a198b6c1d6
> 
> Best regards,
> -- 
> Peng Fan <peng.fan@nxp.com>
> 
