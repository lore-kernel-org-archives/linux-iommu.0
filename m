Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C223246FE;
	Tue,  2 Jun 2026 20:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780431226; cv=none; b=LRrcEuA+kRyzaqx5YtMkOW5eEATKffTXNuWW5VjgSqcHIkdh8LwTmPUMV89E+3j4I4D2U5JzcJR5oOWPq7+RGR07lIqiEUUc/6u32r0XSoHpWT/A4aKMqeWUKVvvrwDDzEqG4BtGzflJMjOVD94VyEHyIJaWWSVkqp1KgYm6YbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780431226; c=relaxed/simple;
	bh=4gAukCpyrQFo8VTPmnrhVpITJSMNhMls9U2xD/Sj5A8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TvboBBPSGQPsrOsXzicg9TTzFEgA5OBiDqj/GkvoYoQ19mpBY1kMeKFsoYTdlO8W8xZjiYLK8r3G2twu7usW/snFG663ew3Ts638shvaNZPqhYfEsB2o6V9gV6HP2rYq1XmuyhJbTWL8IihWS9m0pCPMI3z6KawkkNvl/PRNOLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XGkUmtl7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XGkUmtl7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 356C11F00893;
	Tue,  2 Jun 2026 20:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780431225;
	bh=ib+9T4X2yh5YoVE1sAOpYN8KBkp47dokmYCpMBUL0BA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XGkUmtl7qa2HKhRZdd7lmc09JTZpZfmN5eioG5YRmvuLfRgu176rkIKto/0YREB50
	 iKn+E0LoFsPI0T/3fJYjrvsksMlvDhQisMbHtm6oxxc9fdFOcnvlUwXyHotVMXpAhw
	 +TCz9L4hjcfFx4zfbMM7kOV7s2wEejiS0GPnxbLVQSmPYHfPSC9kj14FgBVJo98/Y7
	 7G2BzuPHWBu9120hSodYVOBnYzKNB5xpIc9y1ewD4dL4edTrv9DG8AYp7HLwV4LuZn
	 AYvEIUxfq0oDGGh/BO1jtpHxEApGIpzJPZLLFheXXPpYrIY/48EXOxCZyr8e8VduL1
	 Qsftpm/ngEbzw==
Date: Tue, 2 Jun 2026 21:13:39 +0100
From: Will Deacon <will@kernel.org>
To: Ashish Mhetre <amhetre@nvidia.com>
Cc: robin.murphy@arm.com, joro@8bytes.org, jgg@ziepe.ca,
	nicolinc@nvidia.com, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH v3 2/3] iommu/arm-smmu-v3: Detect Tegra264 erratum
Message-ID: <ah85c4u011WNJQgE@willie-the-truck>
References: <20260601104845.995005-1-amhetre@nvidia.com>
 <20260601104845.995005-3-amhetre@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260601104845.995005-3-amhetre@nvidia.com>

On Mon, Jun 01, 2026 at 10:48:44AM +0000, Ashish Mhetre wrote:
> Tegra264 SMMU is affected by erratum where a TLB entry can survive an
> invalidation that races with concurrent traffic targeting the same
> entry. The hardware-recommended software workaround is to issue every
> CFGI/TLBI command (each followed by CMD_SYNC) twice. The second issue
> is guaranteed to evict the entry. ATC_INV is not affected and must not
> be doubled.
> 
> The erratum is not flagged by any SMMUv3 IDR/IIDR register, so it
> cannot be detected from hardware ID. Tegra264 boots from device tree
> only and has no ACPI/IORT support, so detection is through device
> tree only.

That seems odd to me -- whether the hardware has the erratum is
completely unrelated to whether it probes using DT or ACPI, so I find it
really weird to have the workaround enabled when booting with DT and not
when booting with ACPI. We should have consistent behaviour between the
two.

> Add the ARM_SMMU_OPT_TLBI_TWICE option and set it on instances matching
> the existing "nvidia,tegra264-smmu" compatible. Also add a
> static-inline arm_smmu_cmd_needs_tlbi_twice() classifier in
> arm-smmu-v3.h so that subsequent changes wiring the workaround into the
> CMDQ submission and iommufd batching paths can share a single
> predicate.
> 
> No callers consume the option yet; a subsequent change will wire the
> workaround into the CMDQ issue paths.
> 
> Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |  4 ++-
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h | 40 +++++++++++++++++++++
>  2 files changed, 43 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 4d29bd343460..08684bd40a6d 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -5243,8 +5243,10 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev,
>  	if (of_dma_is_coherent(dev->of_node))
>  		smmu->features |= ARM_SMMU_FEAT_COHERENCY;
>  
> -	if (of_device_is_compatible(dev->of_node, "nvidia,tegra264-smmu"))
> +	if (of_device_is_compatible(dev->of_node, "nvidia,tegra264-smmu")) {
>  		tegra_cmdqv_dt_probe(dev->of_node, smmu);
> +		smmu->options |= ARM_SMMU_OPT_TLBI_TWICE;
> +	}
>  
>  	return ret;
>  }
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> index 16353596e08a..106034c348a1 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -928,6 +928,14 @@ struct arm_smmu_device {
>  #define ARM_SMMU_OPT_MSIPOLL		(1 << 2)
>  #define ARM_SMMU_OPT_CMDQ_FORCE_SYNC	(1 << 3)
>  #define ARM_SMMU_OPT_TEGRA241_CMDQV	(1 << 4)
> +/*
> + * Tegra264 erratum: a TLB entry can survive an invalidation that races
> + * with concurrent traffic targeting the same entry. The software
> + * workaround is to issue every CFGI/TLBI command twice, each followed
> + * by CMD_SYNC. The second issue is guaranteed to evict the entry.
> + * ATC_INV commands are not affected and must not be doubled.
> + */
> +#define ARM_SMMU_OPT_TLBI_TWICE		(1 << 5)

nit: I think this should be named slightly differently as it covers CFGI
as well. Maybe ARM_SMMU_OPT_REPEAT_TLBI_CFGI ?

The comment can be simpler too and avoid being specific to Tegra264. The
main things to say are that it repeats {CFGI,TLBI}; SYNC sequences and
does not apply to ATC_INV.

> +/*
> + * Returns true if @cmd is one of the CFGI_* or TLBI_* commands covered
> + * by the Tegra264 erratum (see ARM_SMMU_OPT_TLBI_TWICE) on an affected
> + * SMMU instance.
> + */

(remove the comment)

> +static inline bool arm_smmu_cmd_needs_tlbi_twice(struct arm_smmu_device *smmu,
> +						 struct arm_smmu_cmd *cmd)

Rename the function to something like arm_smmu_erratum_cmd_needs_repeating()?

> +{
> +	if (!(smmu->options & ARM_SMMU_OPT_TLBI_TWICE))
> +		return false;

Maybe we should make this a static key?

> +	switch (FIELD_GET(CMDQ_0_OP, cmd->data[0])) {
> +	case CMDQ_OP_CFGI_STE:
> +	case CMDQ_OP_CFGI_ALL:
> +	case CMDQ_OP_CFGI_CD:
> +	case CMDQ_OP_CFGI_CD_ALL:
> +	case CMDQ_OP_TLBI_NH_ALL:
> +	case CMDQ_OP_TLBI_NH_ASID:
> +	case CMDQ_OP_TLBI_NH_VA:
> +	case CMDQ_OP_TLBI_NH_VAA:
> +	case CMDQ_OP_TLBI_EL2_ALL:
> +	case CMDQ_OP_TLBI_EL2_ASID:
> +	case CMDQ_OP_TLBI_EL2_VA:
> +	case CMDQ_OP_TLBI_S12_VMALL:
> +	case CMDQ_OP_TLBI_S2_IPA:
> +	case CMDQ_OP_TLBI_NSNH_ALL:
> +		return true;

Isn't this just everything < ATC_INV || >= CFGI_STE? Seems better than
enumerating everything.

Will
