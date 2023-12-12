Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5532E58137
	for <iommu@lists.linux.dev>; Tue, 12 Dec 2023 13:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KuDnY4sE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95214C433C9;
	Tue, 12 Dec 2023 13:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702387616;
	bh=MTJA9nOqanOoR/ftnPdykQUlIJ/hV7qeVCff8ipL5ys=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KuDnY4sE50WXsmAzi4nARfS/uzdyeK9fUQyJ05WnrhkjWwNHattF/XVuABlEFzOco
	 H9hdrrEd52kGu+mGHYcays1JUy/+V2JUp2/uXpoduhSqnQj9VM9p858uQrQDo29JDF
	 kKycwjmQGTjPd4ldAJxnu0/zwBrwrC1Aq5p+YjG9b/DWYFjeHZBe8Iak9u+3yEnOhN
	 PHrn9ippavR6jP4C80p3Nohwfqenu1MvJvu1zxynqNtL4/rG9o/Yih3Z+KuA/MoT0F
	 lrE+50B48x0/upyFIe7zxY6riCZpkrk9T6CXyGn1v7b29bJE51bzAqKlr/WVNrrj6o
	 rNDf9E/DXt2OQ==
Date: Tue, 12 Dec 2023 13:26:51 +0000
From: Will Deacon <will@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH v2 5/5] iommu/arm-smmu: Convert to domain_alloc_paging()
Message-ID: <20231212132651.GA29569@willie-the-truck>
References: <0-v2-c86cc8c2230e+160bb-smmu_newapi_jgg@nvidia.com>
 <5-v2-c86cc8c2230e+160bb-smmu_newapi_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5-v2-c86cc8c2230e+160bb-smmu_newapi_jgg@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Tue, Oct 17, 2023 at 03:11:44PM -0300, Jason Gunthorpe wrote:
> Now that the BLOCKED and IDENTITY behaviors are managed with their own
> domains change to the domain_alloc_paging() op.
> 
> The check for using_legacy_binding is now redundant,
> arm_smmu_def_domain_type() always returns IOMMU_DOMAIN_IDENTITY for this
> mode, so the core code will never attempt to create a DMA domain in the
> first place.
> 
> Since commit a4fdd9762272 ("iommu: Use flush queue capability") the core
> code only passes in IDENTITY/BLOCKED/UNMANAGED/DMA domain types. It will
> not pass in IDENTITY or BLOCKED if the global statics exist, so the test
> for DMA is also redundant now too.
> 
> Call arm_smmu_init_domain_context() early if a dev is available.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu/arm-smmu.c | 21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> index 6340ee8ab7c482..cea25afe9e49db 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> @@ -842,14 +842,11 @@ static void arm_smmu_destroy_domain_context(struct arm_smmu_domain *smmu_domain)
>  	arm_smmu_rpm_put(smmu);
>  }
>  
> -static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
> +static struct iommu_domain *arm_smmu_domain_alloc_paging(struct device *dev)
>  {
> +	struct arm_smmu_master_cfg *cfg = NULL;
>  	struct arm_smmu_domain *smmu_domain;
>  
> -	if (type != IOMMU_DOMAIN_UNMANAGED) {
> -		if (using_legacy_binding || type != IOMMU_DOMAIN_DMA)
> -			return NULL;
> -	}
>  	/*
>  	 * Allocate the domain and initialise some of its data structures.
>  	 * We can't really do anything meaningful until we've added a
> @@ -862,6 +859,18 @@ static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
>  	mutex_init(&smmu_domain->init_mutex);
>  	spin_lock_init(&smmu_domain->cb_lock);
>  
> +	if (dev)
> +		cfg = dev_iommu_priv_get(dev);
> +	if (cfg) {
> +		int ret;
> +
> +		ret = arm_smmu_init_domain_context(smmu_domain, cfg->smmu, dev);
> +		if (ret) {
> +			kfree(smmu_domain);
> +			return NULL;

If we're just returning NULL, can we drop 'ret'?

> +		}
> +	}
> +
>  	return &smmu_domain->domain;

Why do we need to handle the 'dev && !cfg' case here, instead of just
returning NULL?

Will
