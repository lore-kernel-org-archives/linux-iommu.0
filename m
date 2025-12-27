Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01173B2BA;
	Sat, 27 Dec 2025 20:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766866606; cv=none; b=MTx2ih0UTe7foAVLZJg4ndhkvqJ3/bwVt3jNxRsYNVC6sx6pubyQ7VLd4YR0SSU0EXGnkDzmeviL5EgLU00MpKq/A3KT+E5DYZ/u6WRLQrFJFg+GmIC8GQBWHfxFvyTINHRyDDO3fR63b0GrJQBW64BjlaaiJ5H+/O5tZIRsMrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766866606; c=relaxed/simple;
	bh=YVbtQLZx9jfw9z6Q7qKoP3MRHyWD/+ZNiJGjIZfNTgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NOyDQU1TngPqIRmlwo12wYMRQA5/sSeuluHGi8gOTkIaXq0a/u9+gxEIpFdq18DYm0EweIL1i20ZV0jSr3g0SWtaK7IoRh4tl3l7PlYuNPDzIP4PMd+fTHWmb+TBPZqT6l5e82VVm3iErt6SDFUbIXzRttSBNehTH1EzA3/zmkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uwKZl8Kz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uwKZl8Kz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFEFAC4CEF1;
	Sat, 27 Dec 2025 20:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766866606;
	bh=YVbtQLZx9jfw9z6Q7qKoP3MRHyWD/+ZNiJGjIZfNTgg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uwKZl8KzwVtiip51+4heE0ashdbCeXp6U5OGLZVN5eA3XVOWJ7w0nu+JM1fdk1dvX
	 ZfbtAVStzxCNZU1JJKfXU2qcA4s2Zf/F+0PKbtzuf9B9+glwGNiVwxgC1bY3mVWDqt
	 x+OGDvSx4PZZI6McqMG+qakQtcWSE9+9tMu26q3QXTy1gMrTGcAo4CvA5PP9VpTn2Y
	 t+LQEj1YwktMsX15KqA9mAEHyv4WHQBDsuDqMqLw7BtRg6wMni6pYQYI3FZb8kWIWE
	 iFr0g/ZmzQ2XLCky+90/8NJrMcMB42KyHtG+QFBx2dI8aag00ktWTd4LyrTN8FnlYw
	 dWKdi+ikD9wGg==
Date: Sat, 27 Dec 2025 22:16:42 +0200
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
	Joerg Roedel <joro@8bytes.org>,
	Tangquan Zheng <zhengtangquan@oppo.com>
Subject: Re: [PATCH RFC v2 8/8] dma-iommu: Support DMA sync batch mode for
 iommu_dma_sync_sg_for_{cpu, device}
Message-ID: <20251227201642.GQ11869@unreal>
References: <20251226225254.46197-1-21cnbao@gmail.com>
 <20251226225254.46197-9-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251226225254.46197-9-21cnbao@gmail.com>

On Sat, Dec 27, 2025 at 11:52:48AM +1300, Barry Song wrote:
> From: Barry Song <baohua@kernel.org>
> 
> Apply batched DMA synchronization to iommu_dma_sync_sg_for_cpu() and
> iommu_dma_sync_sg_for_device(). For all buffers in an SG list, only
> a single flush operation is needed.
> 
> I do not have the hardware to test this, so the patch is marked as
> RFC. I would greatly appreciate any testing feedback.
> 
> Cc: Leon Romanovsky <leon@kernel.org>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Ada Couprie Diaz <ada.coupriediaz@arm.com>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Tangquan Zheng <zhengtangquan@oppo.com>
> Signed-off-by: Barry Song <baohua@kernel.org>
> ---
>  drivers/iommu/dma-iommu.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index ffa940bdbbaf..b68dbfcb7846 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -1131,10 +1131,9 @@ void iommu_dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sgl,
>  			iommu_dma_sync_single_for_cpu(dev, sg_dma_address(sg),
>  						      sg->length, dir);
>  	} else if (!dev_is_dma_coherent(dev)) {
> -		for_each_sg(sgl, sg, nelems, i) {
> +		for_each_sg(sgl, sg, nelems, i)
>  			arch_sync_dma_for_cpu(sg_phys(sg), sg->length, dir);
> -			arch_sync_dma_flush();
> -		}
> +		arch_sync_dma_flush();

This and previous patches should be squashed into the one which
introduced arch_sync_dma_flush().

Thanks
