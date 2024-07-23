Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45AA2156F40;
	Tue, 23 Jul 2024 16:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721751103; cv=none; b=iHhCKhqJJJsvml29upPREiaV7MJRDnltC8+F77bHC37ZzouDnRBUtbdyTo+PPzQUvJ4r8M/pbJpeAnidNXgvGrc86hLMOB5VzEnNk/FQgnAGWDjDMt3t/FuSA1RMcJkPnjcufI03Di7lSjnv7gbqBjrKgMI0GTVgt2Uyi9ILeIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721751103; c=relaxed/simple;
	bh=Rg5CipCPIHQRoPzpjEq0aFBHW+/3CFYbxXP82VdhUmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l6USISr6n0KAvNTlV4Ieh8GoE4Sp5hgo+FfB/MsyKIOlTFMIrWQCdqBlQwXSEwbujaemm+ZOLDJbEqv9WK/51+N/P2NJcLcSBUDy9+NlTsw2QkCplZSJers264paART52KeQnc+mkGXqqvSSYix2Lec8RJpEcc1uzKxg/KPZLsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uHalo0AW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uHalo0AW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39FC3C4AF0C;
	Tue, 23 Jul 2024 16:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721751102;
	bh=Rg5CipCPIHQRoPzpjEq0aFBHW+/3CFYbxXP82VdhUmE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uHalo0AWSgLrfxFvHvIWkCCyxOfeqgHTeD7LqZrZpXOGPWTXpe/DEM7ebNK1Eveem
	 1BxggTpRhDyaSw6FVUpZ85yd0IVsPzt94ttvdgvbRghDbuzOACqUjda8Kv/6S1ErI9
	 oBFTCoDSpjY0WqVLdCKgRyvT7kW/MNl3kMZq0+U94syAEHhLUJZQvkbXzC4NDwdzH+
	 /7IuxITIq15RcIJQCVa2eNnaCnZWBGkzHGIlyjspr0AYU+e8AF8/JtcNTeGJFCFm9k
	 jpyAhXoAASFmdtxCH+aL3GFanh2hmuvtvIwNwdkOkBQcy8PCNCVtIpLwi8haESvH/v
	 zrqXxMaJfzXbw==
Date: Tue, 23 Jul 2024 17:11:37 +0100
From: Will Deacon <will@kernel.org>
To: Ashish Mhetre <amhetre@nvidia.com>
Cc: thierry.reding@gmail.com, vdumpa@nvidia.com, robin.murphy@arm.com,
	joro@8bytes.org, linux-tegra@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu: arm-smmu: Fix Tegra workaround for PAGE_SIZE
 mappings
Message-ID: <20240723161137.GB26546@willie-the-truck>
References: <20240717072145.107412-1-amhetre@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240717072145.107412-1-amhetre@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Wed, Jul 17, 2024 at 07:21:45AM +0000, Ashish Mhetre wrote:
> PAGE_SIZE can be 16KB for Tegra which is not supported by MMU-500 on
> both Tegra194 and Tegra234. So, use 4KB mappings when PAGE_SIZE is 16KB.
> 
> Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c b/drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c
> index 4b2994b6126d..bb621a94f6fe 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c
> @@ -273,11 +273,12 @@ static int nvidia_smmu_init_context(struct arm_smmu_domain *smmu_domain,
>  	 * release of PMD entry and avoid translations seeing stale PMD entry in
>  	 * walk cache.
>  	 * Fix this by limiting the page mappings to PAGE_SIZE on Tegra194 and
> -	 * Tegra234.
> +	 * Tegra234. Use 4K page mappings if PAGE_SIZE is 16K as MMU500 doesn't
> +	 * support it.
>  	 */
>  	if (of_device_is_compatible(np, "nvidia,tegra234-smmu") ||
>  	    of_device_is_compatible(np, "nvidia,tegra194-smmu")) {
> -		smmu->pgsize_bitmap = PAGE_SIZE;
> +		smmu->pgsize_bitmap = (PAGE_SIZE == SZ_16K) ? SZ_4K : PAGE_SIZE;

Perhaps it would be more robust to do a read-modify-write of the
pgsize_bitmap, preserving all the page-sizes that are <= PAGE_SIZE (i.e.
and it with something like GENMASK(PAGE_SHIFT, 0)?

Will
