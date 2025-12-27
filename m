Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7C61DA23;
	Sat, 27 Dec 2025 20:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766866032; cv=none; b=Xhh+jp76oAQOLu80HveUY435dv+Vsx30yfAkW6rTI1D9++B6I7ICo5VI9DmnOAPOyRYbcV8nYMgRBT0fbU4WCWRnNP9n5jnMYTS4TRxiPARhYf3PNBKTUl8teZmQqW3SNumLXjIPrKSSGV6JQE1zLnVu3VUAXx7TAnN3F0i3/J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766866032; c=relaxed/simple;
	bh=lH6Wqea3wfifSQZGhdMqsJ7bOl+AJwlkVM2iS90xz1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FUVEHOBNsR2WyD5HfsQ49DScXPqzdNirA9MEWND52SFeHrx2UhO8Lmi9WbJz/ofo8ylBItGBEFFV4fk0rha0LskQ85ciA+3eRm8UObfbKwjlu74CACwBLnVNmk7ayueVNlO2hhpGW6OOXc2dOk/jXVwNARk1bMuAduFgxtBJ3dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S07xCoEA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S07xCoEA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8DB3C4CEF1;
	Sat, 27 Dec 2025 20:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766866031;
	bh=lH6Wqea3wfifSQZGhdMqsJ7bOl+AJwlkVM2iS90xz1k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S07xCoEAxobIYaBiV02L02bERdk0nmuGN+hFMXu5vrWuTP0EPXqj8aOiLirY/XSdI
	 hUxIfJKJxQwjEDf0cGJIE06esOvlyDzQZ6VVCU/XpJsQ+cPWzdco1dnfE+T0l6+FTy
	 Z2/1CSf3BiRqj8dt9aICAM5XJ05mm2CcfJWEP0XBNvwwasMfQqxa7wnz+aNmb4d5in
	 BrpW1mFFc8LnJZ2BxbHSkZt6MmcWRZfo9YGSkyb+kpl/KFt04NW0Tpiwp6VdFNnp6U
	 FdejPb3ayq/IL4kPtLQVDuEHA5EEs/rnzDON++8ec2joqb9vADZmaIG04lvTKhRmDr
	 059bfB7LX6s1A==
Date: Sat, 27 Dec 2025 22:07:06 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Barry Song <21cnbao@gmail.com>
Cc: catalin.marinas@arm.com, m.szyprowski@samsung.com, robin.murphy@arm.com,
	will@kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	xen-devel@lists.xenproject.org, Barry Song <baohua@kernel.org>,
	Ada Couprie Diaz <ada.coupriediaz@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Joerg Roedel <joro@8bytes.org>, Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Tangquan Zheng <zhengtangquan@oppo.com>
Subject: Re: [PATCH v2 4/8] dma-mapping: Separate DMA sync issuing and
 completion waiting
Message-ID: <20251227200706.GN11869@unreal>
References: <20251226225254.46197-1-21cnbao@gmail.com>
 <20251226225254.46197-5-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251226225254.46197-5-21cnbao@gmail.com>

On Sat, Dec 27, 2025 at 11:52:44AM +1300, Barry Song wrote:
> From: Barry Song <baohua@kernel.org>
> 
> Currently, arch_sync_dma_for_cpu and arch_sync_dma_for_device
> always wait for the completion of each DMA buffer. That is,
> issuing the DMA sync and waiting for completion is done in a
> single API call.
> 
> For scatter-gather lists with multiple entries, this means
> issuing and waiting is repeated for each entry, which can hurt
> performance. Architectures like ARM64 may be able to issue all
> DMA sync operations for all entries first and then wait for
> completion together.
> 
> To address this, arch_sync_dma_for_* now issues DMA operations in
> batch, followed by a flush. On ARM64, the flush is implemented
> using a dsb instruction within arch_sync_dma_flush().
> 
> For now, add arch_sync_dma_flush() after each
> arch_sync_dma_for_*() call. arch_sync_dma_flush() is defined as a
> no-op on all architectures except arm64, so this patch does not
> change existing behavior. Subsequent patches will introduce true
> batching for SG DMA buffers.
> 
> Cc: Leon Romanovsky <leon@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Ada Couprie Diaz <ada.coupriediaz@arm.com>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Juergen Gross <jgross@suse.com>
> Cc: Stefano Stabellini <sstabellini@kernel.org>
> Cc: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
> Cc: Tangquan Zheng <zhengtangquan@oppo.com>
> Signed-off-by: Barry Song <baohua@kernel.org>
> ---
>  arch/arm64/include/asm/cache.h |  6 ++++++
>  arch/arm64/mm/dma-mapping.c    |  4 ++--
>  drivers/iommu/dma-iommu.c      | 37 +++++++++++++++++++++++++---------
>  drivers/xen/swiotlb-xen.c      | 24 ++++++++++++++--------
>  include/linux/dma-map-ops.h    |  6 ++++++
>  kernel/dma/direct.c            |  8 ++++++--
>  kernel/dma/direct.h            |  9 +++++++--
>  kernel/dma/swiotlb.c           |  4 +++-
>  8 files changed, 73 insertions(+), 25 deletions(-)

<...>

> +#ifndef arch_sync_dma_flush
> +static inline void arch_sync_dma_flush(void)
> +{
> +}
> +#endif

Over the weekend I realized a useful advantage of the ARCH_HAVE_* config
options: they make it straightforward to inspect the entire DMA path simply
by looking at the .config.

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
