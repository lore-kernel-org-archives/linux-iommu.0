Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984E6305079;
	Tue, 19 Aug 2025 12:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755606520; cv=none; b=dSNzd8rAKC0T3O5skro5QNhE/CZOwNbQkTVv8jOiTh+OAWMI8NBJTb/IA8HvCdtfCqVBcexmXHfsI4VzmlwTep2aqJGTguOrPjUFuL81KQHbOtkv6IHdJtopqVhALtQAaZ3rQf+4TMt22D+MN6AN5f1NnRnGEsRmgNGs0prrbHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755606520; c=relaxed/simple;
	bh=Qlxvo8QfEWO0eSzqwnopVLERilYWkNqoXFxKLMekt5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TMussmHjR+/+293wPOThE8gvfKrIt8lT1UonAsFsHnuABaMESuNQ8sAjKwScBUgVGI6Zx8yyCJybm5diTQ7JNTrWzi24QZG+SvhFybgnUk1u1Wt4PfukbNedHkTapI7Mo6+So12Xc7rcKnCebbzPIdAr952ldEYKx8LXU8abIwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a0UOCYXx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a0UOCYXx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4BAFC4CEF1;
	Tue, 19 Aug 2025 12:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755606519;
	bh=Qlxvo8QfEWO0eSzqwnopVLERilYWkNqoXFxKLMekt5A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a0UOCYXxrQI6myqYnaZ9Cw0ODQ+PlZkp2KwgIjS6XmMtVccmO0w+JDqfqYSul2GnW
	 ZRofUo2eiHpf64xPvb4q3hhuT01l1YiOVmf+FQXDHgO7RliVkCLpLxJfsSHay3yWwi
	 aKFUlT1sEk5oiVFzuO7xoq3lrmLw2jGEGBbc39J3cQDC6qtGxsheEie7yst6/+BSSU
	 S+dEOhP2sGV/GHrs/zbpU+7fOxu1Dl0PL/9N30OtCDHAGN3ZLZ+v8gVizmFX01MCWd
	 ooWbeogqTk+oQnCQoC+ZugRTA6fu3nUiJ3P/UjecO7uXkMOABbDBo7CksDYxJJkUdF
	 zYztPrFkXaYWA==
Date: Tue, 19 Aug 2025 13:28:34 +0100
From: Will Deacon <will@kernel.org>
To: Nicolin Chen <nicolinc@nvidia.com>, joro@8bytes.org
Cc: jgg@nvidia.com, robin.murphy@arm.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH rc] iommu/arm-smmu-v3: Fix smmu_domain->nr_ats_masters
 decrement
Message-ID: <aKRt8gJVUPZ_VTrA@willie-the-truck>
References: <20250801030127.2006979-1-nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250801030127.2006979-1-nicolinc@nvidia.com>

On Thu, Jul 31, 2025 at 08:01:27PM -0700, Nicolin Chen wrote:
> The arm_smmu_attach_commit() updates master->ats_enabled before calling
> arm_smmu_remove_master_domain() that is supposed to clean up everything
> in the old domain, including the old domain's nr_ats_masters. So, it is
> supposed to use the old ats_enabled state of the device, not an updated
> state.
> 
> This isn't a problem if switching between two domains where:
>  - old ats_enabled = false; new ats_enabled = false
>  - old ats_enabled = true;  new ats_enabled = true
> but can fail cases where:
>  - old ats_enabled = false; new ats_enabled = true
>    (old domain should keep the counter but incorrectly decreased it)
>  - old ats_enabled = true;  new ats_enabled = false
>    (old domain needed to decrease the counter but incorrectly missed it)
> 
> Update master->ats_enabled after arm_smmu_remove_master_domain() to fix
> this.
> 
> Fixes: 7497f4211f4f ("iommu/arm-smmu-v3: Make changing domains be hitless for ATS")
> Cc: stable@vger.kernel.org
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 312bc31d7e8eb..3c81139faecae 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -2997,9 +2997,9 @@ void arm_smmu_attach_commit(struct arm_smmu_attach_state *state)
>  		/* ATS is being switched off, invalidate the entire ATC */
>  		arm_smmu_atc_inv_master(master, IOMMU_NO_PASID);
>  	}
> -	master->ats_enabled = state->ats_enabled;
>  
>  	arm_smmu_remove_master_domain(master, state->old_domain, state->ssid);
> +	master->ats_enabled = state->ats_enabled;
>  }
>  
>  static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
> -- 
> 2.43.0

Acked-by: Will Deacon <will@kernel.org>

Joerg -- please can you pick this up as a fix?

Thanks,

Will
