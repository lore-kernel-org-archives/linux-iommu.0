Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CFDD58137
	for <iommu@lists.linux.dev>; Tue, 12 Dec 2023 13:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t6YP7+1W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BE1BC433C7;
	Tue, 12 Dec 2023 13:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702387633;
	bh=FJ+f5Hz51goA35vrwB/jJQQYvvFGAKDUWVUA8SmXYDQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t6YP7+1Wnoj2K+v+b0z0z2Sx32GH+KauEz3WXTPIArfHm8xEHhn5YIwjHwyu5mpFp
	 g9D5x5XTOcNB8HgEm/Q+6LvNRpSId/s/K/B47qfFcTUYP0jjD0MW/1Vm2WwyEaCu84
	 8f8oWYIq+tUB/IzdMCoLsd7bspihdCck/Lilse+JeFpQQ+yh2hPDa5u0Mf9Yu5ij4b
	 M0wnt8AxNPsyxGhLk7vF4IlsXnORo+hhWYFmEdUHEkWsL5w5Y9NJbZoWt70MVV6EDO
	 R11uYOvUxCVSCQNPQwHnhG7F3e28e+7GZj9fzxjPjOI1U1is9Xbq1aqp8dh+biB3yI
	 1DVkyQLNDAZSw==
Date: Tue, 12 Dec 2023 13:27:08 +0000
From: Will Deacon <will@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH v2 2/5] iommu/arm-smmu: Convert to a global static
 identity domain
Message-ID: <20231212132708.GB29569@willie-the-truck>
References: <0-v2-c86cc8c2230e+160bb-smmu_newapi_jgg@nvidia.com>
 <2-v2-c86cc8c2230e+160bb-smmu_newapi_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2-v2-c86cc8c2230e+160bb-smmu_newapi_jgg@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Tue, Oct 17, 2023 at 03:11:41PM -0300, Jason Gunthorpe wrote:
> Create a global static identity domain with it's own
> arm_smmu_attach_dev_identity() that simply calls
> arm_smmu_master_install_s2crs() with the identity parameters.
> 
> This is done by giving the attach path for identity its own unique
> implementation that simply calls arm_smmu_master_install_s2crs().
> 
> Remove ARM_SMMU_DOMAIN_BYPASS and all checks of IOMMU_DOMAIN_IDENTITY.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu/arm-smmu.c | 50 ++++++++++++++++++++-------
>  drivers/iommu/arm/arm-smmu/arm-smmu.h |  1 -
>  2 files changed, 37 insertions(+), 14 deletions(-)

[...]

> +static int arm_smmu_attach_dev_identity(struct iommu_domain *domain,
> +					struct device *dev)
> +{
> +	struct arm_smmu_master_cfg *cfg = dev_iommu_priv_get(dev);
> +	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
> +	struct arm_smmu_device *smmu;
> +	int ret;
> +
> +	if (!cfg)
> +		return -ENODEV;
> +	smmu = cfg->smmu;
> +
> +	ret = arm_smmu_rpm_get(smmu);
> +	if (ret < 0)
> +		return ret;
> +
> +	arm_smmu_master_install_s2crs(cfg, S2CR_TYPE_BYPASS, 0, fwspec);
> +
> +	pm_runtime_set_autosuspend_delay(smmu->dev, 20);
> +	pm_runtime_use_autosuspend(smmu->dev);

This is cargo-culted from arm_smmu_attach_dev() with the comments dropped
and it's not clear at all to me that the autosuspend delay makes any sense
for the identity domain.

So I think it would be better to either drop the call to
pm_runtime_set_autosuspend_delay() or move the two autosuspend calls into
a helper which is used by both of the attach routines so that the comment
is maintained.

Will
