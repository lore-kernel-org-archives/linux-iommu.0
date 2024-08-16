Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1681AD9D6;
	Fri, 16 Aug 2024 14:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723817972; cv=none; b=k/Q9DYSacSaJjYw87/kxvl7zjCVntnixOoD9+SA4T4jhz1cmc8q0hRDPJrWq79sel/7vj3gQ/L0OZB1UHNXyTjzLO9SXjwoInUyXpVjZtcGnV1iICYkhPRtZ/Vh6UJg5tW6puUoJKSHXfNhDg/skk62q0eUeupc++FSxyu6c5jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723817972; c=relaxed/simple;
	bh=m91wiXNoBr6hhHKIFDdh37bRQg05EDSHZsMVwPiqzCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UXLaCXRMAJegVfaKjOozn7YZSucKTGCCvXZYSJxs2Etx6yOvyXTKOIo3RzshAJOSObJ04ZmtvlMtuC86EjYaRmd5A4tlH4HSx/m166MQn94nbhGDa3izK2UNmfMpyecTg/5cq7qoPcBLF46OEh6NtjdEeDjycFZbcPsYPlcfviM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KB0pqGez; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KB0pqGez"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A247C32782;
	Fri, 16 Aug 2024 14:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723817972;
	bh=m91wiXNoBr6hhHKIFDdh37bRQg05EDSHZsMVwPiqzCs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KB0pqGezWVzR8/+nqWelgCQXCSCJfB2kp04qOp4E5wuGnke2YJJ+hpSVGpfDzp7aj
	 Z0Ndf7jAJ8qcL+LAQrg5BtQ6XFRs1Jv9rYbrigX/28d1ekXMYA9HE8+SFqui5L8VOT
	 MrRnBrn0gRMYrWF1PhdPBXyFrHY8o1SwocKnOjyJFO0UPUhl4pYzILkIlzMEhhj+f0
	 sqexNlaqem4nkOLkBZv6B8wUCys1QgQcER10PJhDupl/aOl3b6QDSkmnCavuJZVvAg
	 TPRU176FF7Zix9eaPYWyuJvFPZwQ5WgbQ3Z09YVxXXYhALD38EFVIoo+P6wu96/7a0
	 JGE8z7tRYJJsA==
Date: Fri, 16 Aug 2024 15:19:26 +0100
From: Will Deacon <will@kernel.org>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: robin.murphy@arm.com, joro@8bytes.org, jgg@nvidia.com,
	thierry.reding@gmail.com, vdumpa@nvidia.com, jonathanh@nvidia.com,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v11 8/9] iommu/arm-smmu-v3: Add in-kernel support for
 NVIDIA Tegra241 (Grace) CMDQV
Message-ID: <20240816141926.GA24676@willie-the-truck>
References: <cover.1722993435.git.nicolinc@nvidia.com>
 <849c17b97ae0a38db1cee949db2488e4045666df.1722993435.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <849c17b97ae0a38db1cee949db2488e4045666df.1722993435.git.nicolinc@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Tue, Aug 06, 2024 at 07:11:53PM -0700, Nicolin Chen wrote:
> From: Nate Watterson <nwatterson@nvidia.com>
> 
> NVIDIA's Tegra241 Soc has a CMDQ-Virtualization (CMDQV) hardware, extending
> the standard ARM SMMU v3 IP to support multiple VCMDQs with virtualization
> capabilities. In terms of command queue, they are very like a standard SMMU
> CMDQ (or ECMDQs), but only support CS_NONE in the CS field of CMD_SYNC.
> 
> Add a new tegra241-cmdqv driver, and insert its structure pointer into the
> existing arm_smmu_device, and then add related function calls in the SMMUv3
> driver to interact with the CMDQV driver.
> 
> In the CMDQV driver, add a minimal part for the in-kernel support: reserve
> VINTF0 for in-kernel use, and assign some of the VCMDQs to the VINTF0, and
> select one VCMDQ based on the current CPU ID to execute supported commands.
> This multi-queue design for in-kernel use gives some limited improvements:
> up to 20% reduction of invalidation time was measured by a multi-threaded
> DMA unmap benchmark, compared to a single queue.
> 
> The other part of the CMDQV driver will be user-space support that gives a
> hypervisor running on the host OS to talk to the driver for virtualization
> use cases, allowing VMs to use VCMDQs without trappings, i.e. no VM Exits.
> This is designed based on IOMMUFD, and its RFC series is also under review.
> It will provide a guest OS a bigger improvement: 70% to 90% reductions of
> TLB invalidation time were measured by DMA unmap tests running in a guest,
> compared to nested SMMU CMDQ (with trappings).
> 
> As the initial version, the CMDQV driver only supports ACPI configurations.
> 
> Signed-off-by: Nate Watterson <nwatterson@nvidia.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Co-developed-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  MAINTAINERS                                   |   1 +
>  drivers/iommu/Kconfig                         |  11 +
>  drivers/iommu/arm/arm-smmu-v3/Makefile        |   1 +
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |   9 +
>  .../iommu/arm/arm-smmu-v3/tegra241-cmdqv.c    | 868 ++++++++++++++++++
>  5 files changed, 890 insertions(+)
>  create mode 100644 drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c

[...]

> +struct arm_smmu_device *
> +tegra241_cmdqv_acpi_dsdt_probe(struct arm_smmu_device *smmu,
> +			       struct acpi_iort_node *node)
> +{
> +	struct resource *res;
> +	int irq;
> +
> +	/* Keep the pointer smmu intact if !res */
> +	res = tegra241_cmdqv_find_acpi_resource(smmu, node, &irq);
> +	if (!res)
> +		return smmu;

Given that this probing code will end up running on non-tegra hardware
when CONFIG_TEGRA241_CMDQV is enabled, please can you move the common
part into the main driver?

Will
