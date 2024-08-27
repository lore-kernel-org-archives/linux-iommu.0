Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8E819EED3;
	Tue, 27 Aug 2024 13:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724763760; cv=none; b=esF7CbDn9wKs7AuSJjigWgBDWFi2gMSxyfh/bpet4/roDZ5EY/nUz9ZDrgIB/QN/XT9deZJjhcxVnj3H9mHTHHcgMrtH7NYHdF2yp9bVCI3a703N+pU4lKozoGpynu3Diefhg6tX3jEphz1NksqWQydsKukgwDakxWa4mlA0lCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724763760; c=relaxed/simple;
	bh=2cH48CeKweIa6Il0vytWOeXd373y5p9pQgTadJZeWak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Am10o9b9X5AYzYH3+tbULI5cLzN1I+5nsfEZ8IaNqoTxL3UBj6uytMz4GqrlL102FvG26ltdi3yhXdR1Psu09uXOxqVG+HX7mSo4IKmdT/nH9YDX+0FZZUdxlPjNH2Anx5Q88oJQl8eLd+x38ykY99LxWHTG59HdaYIB/BT+LP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sUHAfuRQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sUHAfuRQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C142C4E677;
	Tue, 27 Aug 2024 13:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724763759;
	bh=2cH48CeKweIa6Il0vytWOeXd373y5p9pQgTadJZeWak=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sUHAfuRQQuWC0D0kxcnHrk1+9OQBRN3Eu+Hz5pam8SAGEMWKPHYbUo2km69hf4nSR
	 b/b3qjYBQZC8eZkLF9+Fw44IfQmBJRX9eIlKdnJPqcU2DGh1DXcFVR493ASgv+pNtM
	 ug7egLXUkynEUrJFlHiCiXV/vjCwcbVx1agAwkKAeCx2RQLUFZmZof+0OHI55kf0XD
	 iTGJarE1EItpBR1teHm0tYQzW4tMvgpd0zCPhIU2QXDdePmoSJiONCs7NZl2sJQ6mY
	 e2HyJBkO9RFzxEjRB52F8RevQWKlE8QMoolJnpq+QqF2qwfKliBhe03P9e62d6qve8
	 6vPdKIc4WmEaw==
Date: Tue, 27 Aug 2024 14:02:34 +0100
From: Will Deacon <will@kernel.org>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: robin.murphy@arm.com, joro@8bytes.org, jgg@nvidia.com,
	thierry.reding@gmail.com, vdumpa@nvidia.com, jonathanh@nvidia.com,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v13 06/10] iommu/arm-smmu-v3: Add
 acpi_smmu_acpi_probe_model for impl
Message-ID: <20240827130233.GF4772@willie-the-truck>
References: <cover.1724453781.git.nicolinc@nvidia.com>
 <8a2629bb98cabb1be72b32c120bb5ed0114b21bc.1724453781.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a2629bb98cabb1be72b32c120bb5ed0114b21bc.1724453781.git.nicolinc@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Fri, Aug 23, 2024 at 05:10:40PM -0700, Nicolin Chen wrote:
> For model-specific implementation, repurpose the acpi_smmu_get_options()
> to a wider acpi_smmu_acpi_probe_model(). A new model can add to the list
> in this new function.
> 
> Suggested-by: Will Deacon <will@kernel.org>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index afdb8a76a72a..ceb31d63f79b 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -4341,18 +4341,28 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
>  }
>  
>  #ifdef CONFIG_ACPI
> -static void acpi_smmu_get_options(u32 model, struct arm_smmu_device *smmu)
> +static int acpi_smmu_iort_probe_model(struct acpi_iort_node *node,
> +				      struct arm_smmu_device *smmu)
>  {
> -	switch (model) {
> +	struct acpi_iort_smmu_v3 *iort_smmu =
> +		(struct acpi_iort_smmu_v3 *)node->node_data;
> +
> +	switch (iort_smmu->model) {
>  	case ACPI_IORT_SMMU_V3_CAVIUM_CN99XX:
>  		smmu->options |= ARM_SMMU_OPT_PAGE0_REGS_ONLY;
>  		break;
>  	case ACPI_IORT_SMMU_V3_HISILICON_HI161X:
>  		smmu->options |= ARM_SMMU_OPT_SKIP_PREFETCH;
>  		break;
> +	case ACPI_IORT_SMMU_V3_GENERIC:
> +		break;
> +	default:
> +		dev_err(smmu->dev, "Unknown/unsupported IORT model!\n");
> +		return -ENXIO;

We probably don't want this 'default' case, otherwise the driver will
need to be updated every time there's a new model.

If you agree, then I can just drop this bit when applying.

Will
