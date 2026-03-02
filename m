Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582BD314B8C;
	Mon,  2 Mar 2026 19:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772481216; cv=none; b=eVqHgZAVKRIaaGdECR3cyljQRzvUwqSMy3M1cn2d5D1zL8LujP5/79tEH2koVP3jeSAF1LSeR8fxFTf3M3JaX8RCSJgRnIVVf16zK1Ku4iG34Sf+VoL11IuJsEYWzWQX7iLoEoFv3fRQrixfKdmvnB+aMeVPKac2GcNmF2G/k14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772481216; c=relaxed/simple;
	bh=iHd9xTb08uobwrAOBK6bO4QNR4IAuCt806zIdYOX5us=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lmhjq9l5R72AAhikoAJmllG5P1yw0jz1lDYXdXqeAvZhqVDJd2/AUtneQB0LzrJV/z3JBy+F73z5vGixHeB03cRBLRuuejPPC+REt/BjxTdVPnvr0vKyLRbRpOObr/sMlGJixjU6A/BYWE2stq0g/Kakr1vRTLihp63+TElY43Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S/dJT0zy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S/dJT0zy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 633BEC19423;
	Mon,  2 Mar 2026 19:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772481216;
	bh=iHd9xTb08uobwrAOBK6bO4QNR4IAuCt806zIdYOX5us=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S/dJT0zySAqwi8FaZNed1bZHgZoUCgkvtEoN8t/qyxZFp4cdB5l4QCVShqLeQMGVe
	 rRPW0Y3cs4dBSlhGNTkgQg/LYvrMJYcaWCCWfoOUveyHYK9JvZQGSYvyb702arb/ea
	 mbb3qgrBoqHQHfWLA8bq5WvBMzRmeNSQ8woJOAhXYpaXIvvhpUM1npi9Clw4oTIdA0
	 YcoCj5pjyU5NRwaWwqatyon0UBxknUprtI9HCyltId6WEljYAa6ne6Sr5pLHyPMo3q
	 khGXgG+xXggQ6qmt1ilyq3HDMADuB/j+MgYxCkEX2+8kWdr8QjQM9CzSEetoFBMZa2
	 LUQYeASDCnoZg==
Date: Mon, 2 Mar 2026 21:53:32 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Barry Song <21cnbao@gmail.com>
Cc: catalin.marinas@arm.com, m.szyprowski@samsung.com, robin.murphy@arm.com,
	will@kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Barry Song <baohua@kernel.org>,
	Ada Couprie Diaz <ada.coupriediaz@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Joerg Roedel <joro@8bytes.org>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Tangquan Zheng <zhengtangquan@oppo.com>,
	Juergen Gross <jgross@suse.com>,
	Xueyuan Chen <xueyuan.chen21@gmail.com>
Subject: Re: [PATCH v3 4/5] dma-mapping: Separate DMA sync issuing and
 completion waiting
Message-ID: <20260302195332.GV12611@unreal>
References: <20260228221316.59934-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260228221316.59934-1-21cnbao@gmail.com>

On Sun, Mar 01, 2026 at 06:13:16AM +0800, Barry Song wrote:
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
> To address this, arch_sync_dma_for_* now batches DMA operations
> and performs a flush afterward. On ARM64, the flush is implemented
> with a dsb instruction in arch_sync_dma_flush(). On other
> architectures, arch_sync_dma_flush() is currently a nop.
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
> Cc: Stefano Stabellini <sstabellini@kernel.org>
> Cc: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
> Cc: Tangquan Zheng <zhengtangquan@oppo.com>
> Reviewed-by: Juergen Gross <jgross@suse.com> # drivers/xen/swiotlb-xen.c
> Tested-by: Xueyuan Chen <xueyuan.chen21@gmail.com>
> Signed-off-by: Barry Song <baohua@kernel.org>
> ---
>  arch/arm64/Kconfig             |  1 +
>  arch/arm64/include/asm/cache.h |  5 +++++
>  arch/arm64/mm/dma-mapping.c    |  4 ++--
>  drivers/iommu/dma-iommu.c      | 35 ++++++++++++++++++++++++++--------
>  drivers/xen/swiotlb-xen.c      | 24 +++++++++++++++--------
>  include/linux/dma-map-ops.h    |  6 ++++++
>  kernel/dma/Kconfig             |  3 +++
>  kernel/dma/direct.c            |  6 +++++-
>  kernel/dma/direct.h            |  9 +++++++--
>  kernel/dma/swiotlb.c           |  7 ++++++-
>  10 files changed, 78 insertions(+), 22 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
