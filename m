Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E712701D9;
	Fri, 19 Jun 2026 14:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781879916; cv=none; b=i9Ok3szQRScm5tKK9rOAFgn/1x2JVdP8WnvRmtx6m7UF7lLIW9wjxnEvF1b/YxBiZVD4GCxbnqT+31ddY1y8S8TcB++DzVG6lkrRIAkaln2Di4ulqR1g4K/YnBfe97uIa7I1fSJ9KZcky+5FNx5pQqDKiJ48c96KxnKq37oEcLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781879916; c=relaxed/simple;
	bh=mvRGZgocdBi/2k+MJjQecLcBBZnJzA2cYHGX3/T1Q9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YzmJZ7jQGG01+QZW3fUrRbcw5xhnjfa76N9wo3zrh1Ai5kDim8TMs/PpTmS/+yYVXelE1faA8LLDte1zstq7kF4eONTp2aN321w4kdVmIYOUBOpToA0disuTlxYhakzo4WJRnRMM6IzhKEzM2kMdyIYJtE6pFlfjQgrEmAgD9HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=isBuugKc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="isBuugKc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00F481F000E9;
	Fri, 19 Jun 2026 14:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781879915;
	bh=4VTiiOQPPFZ1ZED+8W3L25wQImaP/t6mbZOaw33wpzs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=isBuugKc25Pd/ADQQ0fzwHiZh3E/l5Ebf3ulcZefIjWau/xFLL5tBScIkwLAEJZ5g
	 gerrDg225TCLgSZBAmObbhBvrVhdSfFeAark0ldlRwlnbZucqSuKS59QY1Rrjjhm17
	 yQ2ZCTIk9LvcSh8FAKv4VuaOWxUtjlfactb38NwbFfw0zsyOkNvuZs+a1u8Sd9o31p
	 mplFQo6nsc2BxEbgr31NzFqSCnFr7TkZbY3P0vcZOR/XfgMW/t0xx8V9mf2r2h7Qh4
	 +87oMQgUVQinRuIouPkNm5eFcNzdRfkJXJqlu7cAmEHcFIpDsnD7ry3uzvROxfbgW1
	 TQyPHv2ENuK1A==
Date: Fri, 19 Jun 2026 15:38:30 +0100
From: Will Deacon <will@kernel.org>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org,
	Jason Gunthorpe <jgg@nvidia.com>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/arm-smmu-v3: Declare eats_s1chk and eats_trans as
 host-endian u64
Message-ID: <ajVUZkHcGp-PHkmO@willie-the-truck>
References: <20260615194533.3290010-1-nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615194533.3290010-1-nicolinc@nvidia.com>

On Mon, Jun 15, 2026 at 12:45:33PM -0700, Nicolin Chen wrote:
> arm_smmu_get_ste_update_safe() declares the eats_s1chk and eats_trans
> locals as __le64, but initializes them from FIELD_PREP(), which returns a
> host-endian value, and passes them through cpu_to_le64() at the use sites.
> 
> Sparse reports the following warnings:
> 
> >> drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:1122:38: sparse: sparse: cast from restricted __le64
>    drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:1124:33: sparse: sparse: cast from restricted __le64
> 
> Declare both locals as u64 so the type matches FIELD_PREP() and the
> existing cpu_to_le64() at the use sites performs the host-to-little-endian
> conversion. No functional change.
> 
> Fixes: 7cad80048595 ("iommu/arm-smmu-v3: Mark EATS_TRANS safe when computing the update sequence")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/all/202606151017.QU0evpH9-lkp@intel.com/
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 8ce3e801eda3b..4c0f7b17b1f37 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -1240,9 +1240,9 @@ VISIBLE_IF_KUNIT
>  void arm_smmu_get_ste_update_safe(const __le64 *cur, const __le64 *target,
>  				  __le64 *safe_bits)
>  {
> -	const __le64 eats_s1chk =
> +	const u64 eats_s1chk =
>  		FIELD_PREP(STRTAB_STE_1_EATS, STRTAB_STE_1_EATS_S1CHK);
> -	const __le64 eats_trans =
> +	const u64 eats_trans =
>  		FIELD_PREP(STRTAB_STE_1_EATS, STRTAB_STE_1_EATS_TRANS);

Aha, this is the fix for that sparse report from the kbuild robot. Thanks!

Will
