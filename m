Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E4718B47D;
	Thu, 15 May 2025 15:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747321599; cv=none; b=tp01gozppDlHaSsPxpMRS7p2fs51Ny3O0Y/REFIyk537RNQGZkvunK7I7ZtRNmHD92hfkcq8jSSdgLOTABT+RAs9DOYO7mbmXKH8ggtHvG8hVGAXjsj9EK5rtzP/ooglDB5fjPguZVGqYXgeWqw7SRx6bltATgc6MltPWhukTDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747321599; c=relaxed/simple;
	bh=urKXtVF+8OQ4aIsSMiNubACGLVMonPp+yOm8unTAuRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DHFRhy+Wklw3U+p7cHrvvHz0sqQXfFDp/sLcxE0bltuCpgFn7ATNn0aTWoyfzZAYux3eHX8U9tbyeDN4vxDOl5wZXmnXXWGfl0TOEFevlSIfu2fCqYTKay9e9/u0Gbyhcjh6mvN6EuJby0TCNSOrG0U2hM+yNJzbjo0ol14jPZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fa2XDMuI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fa2XDMuI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53B3DC4CEE7;
	Thu, 15 May 2025 15:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747321598;
	bh=urKXtVF+8OQ4aIsSMiNubACGLVMonPp+yOm8unTAuRk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fa2XDMuI4w/GYS2stX9qIHl+35V28XFvu7nOBJp9mxJXYV1AFJiYvOrFcpP9SV+HF
	 FDlr+DdlQ9RYF/jAKrmEoWinAR3oY5m9uAE60GqvjJiXPQkjB0WB03wkuBin1KolUx
	 EmhBA2plJeO7bBikqw3fC3X9oSywbdpR4X3xPSM1VJUZyr8W/tzyBWnI+aIb+ZVmV4
	 bgb8Y160ka65deKyfWq+OGRAYUAFyGOx2j9SmLjPrgCnn5NTPx38OpurquG5mYWI+c
	 nUG4NAdUdncQtsRq0Az8JqiEGU5+wk5tABnHUasE+b9g8UvurDNIktXOxTk9b2N497
	 rQDgsbTwsksAw==
Date: Thu, 15 May 2025 16:06:32 +0100
From: Will Deacon <will@kernel.org>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: robin.murphy@arm.com, jgg@nvidia.com, joro@8bytes.org,
	kevin.tian@intel.com, praan@google.com, nathan@kernel.org,
	yi.l.liu@intel.com, peterz@infradead.org, mshavit@google.com,
	jsnitsel@redhat.com, smostafa@google.com,
	jeff.johnson@oss.qualcomm.com, zhangzekun11@huawei.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, shameerali.kolothum.thodi@huawei.com
Subject: Re: [PATCH v2 02/11] iommu/arm-smmu-v3: Pass in smmu/iommu_domain to
 __arm_smmu_tlb_inv_range()
Message-ID: <20250515150629.GD12165@willie-the-truck>
References: <cover.1744692494.git.nicolinc@nvidia.com>
 <ed8b2837e5ea63f6ee98663761d4f1ebe66a6d41.1744692494.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed8b2837e5ea63f6ee98663761d4f1ebe66a6d41.1744692494.git.nicolinc@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Mon, Apr 14, 2025 at 09:57:37PM -0700, Nicolin Chen wrote:
> What __arm_smmu_tlb_inv_range() really needs is the smmu and iommu_domain
> pointers from the smmu_domain.
> 
> For a nest_parent smmu_domain, it will no longer store an smmu pointer as
> it can be shared across vSMMU instances. A vSMMU structure sharing the S2
> smmu_domain instead would hold the smmu pointer.
> 
> Pass them in explicitly to fit both !nest_parent and nest_parent cases.
> 
> While changing it, share it in the header with arm-smmu-v3-iommmufd that
> will call it too.
> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  4 ++++
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 17 +++++++++--------
>  2 files changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> index d4837a33fb81..5dbdc61558a9 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -955,6 +955,10 @@ void arm_smmu_tlb_inv_range_asid(unsigned long iova, size_t size, int asid,
>  				 struct arm_smmu_domain *smmu_domain);
>  int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain,
>  			    unsigned long iova, size_t size);
> +void __arm_smmu_tlb_inv_range(struct arm_smmu_device *smmu,
> +			      struct arm_smmu_cmdq_ent *cmd, unsigned long iova,
> +			      size_t size, size_t granule,
> +			      struct iommu_domain *domain);

I don't think this function makes a particularly good "public" API --
the caller even sets the cmd opcode!

Can we expose some TLB invalidation helpers instead rather than the
low-level helpers?

Will
