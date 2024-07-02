Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D187D3D978;
	Tue,  2 Jul 2024 17:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719942118; cv=none; b=mA0RS6Lf8+xghMNp3xAjueOaO0LdoJGDZjGV1GXM5XeNuYhIb9z1e48NfCxNfrYL1/gOvhO5ENKD3pTSJ1JW29nCV3ErPSV5MEujAYCVuuL7Or4gJ53EvdeAgow1PstXEAC+h9kjtnNWDtRVf2wVEZ99MAM4ooVkMoZYTDoAlNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719942118; c=relaxed/simple;
	bh=V1br44Suz4Wiyv69CA10ClMypjB26LNaQ5yMRsJPc48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X7mIa9hFm4jIV/o+WUW1+yOG517981NbgMkUpivfzR60KDJP6TZLzWR9QjJXYlsrFtMN4uwn8gDXY7P4ub2eRvd3ksJRiESLOrMCnH8/neTOFHTRqVQ1XwzYVmFRH15DtQ8op+9IGxhE11RWQ14k/miXBbWbWhL/qEqomdL1BFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=epCLP+YH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="epCLP+YH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AB19C116B1;
	Tue,  2 Jul 2024 17:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719942118;
	bh=V1br44Suz4Wiyv69CA10ClMypjB26LNaQ5yMRsJPc48=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=epCLP+YHoh28Xp9koK/so0cTTVZFe1iZfYFnoERH6CX1YHknZdN6Mk10gChe1aDzO
	 73/1uPwfyJN/Otm3uEZKqtSYL5vcXomG+Kjl7Vi5zWLpuNKAp2fdJuce4r3IO+7oEg
	 c5XIx+EPUQAcmilIWXFV5Mh/M8UhtmevEb4D7p1dD7IoyLAGGitIrLs1XPYPG/j0Xt
	 8XCDmHM8wixDLgKYka8J1+YVuPF00bKLdByBpZ5lmSsc1/hTkLm+LW3Q7ZbrFkbRlA
	 JK6Hso2PLvpV/8lAVholV08Af4ln1NcaC404pJ0IPPC3/X6h+bVgYlK23bW0eQCR85
	 +XDbu66xlnblQ==
Date: Tue, 2 Jul 2024 18:41:53 +0100
From: Will Deacon <will@kernel.org>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: robin.murphy@arm.com, joro@8bytes.org, jgg@nvidia.com,
	thierry.reding@gmail.com, vdumpa@nvidia.com, jonathanh@nvidia.com,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v9 5/6] iommu/arm-smmu-v3: Add in-kernel support for
 NVIDIA Tegra241 (Grace) CMDQV
Message-ID: <20240702174152.GA4740@willie-the-truck>
References: <cover.1718228494.git.nicolinc@nvidia.com>
 <d74b091a1216421ab8431f4c684242cd70ef0b77.1718228494.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d74b091a1216421ab8431f4c684242cd70ef0b77.1718228494.git.nicolinc@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Wed, Jun 12, 2024 at 02:45:32PM -0700, Nicolin Chen wrote:
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
> However, it is very important for this in-kernel support to get merged and
> installed to VMs running on Grace-powered servers as soon as possible. So,
> later those servers would only need to upgrade their host kernels for the
> user-space support.

^^^ This is a weird paragraph to put in the commit message.

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
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  52 +-
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  50 ++
>  .../iommu/arm/arm-smmu-v3/tegra241-cmdqv.c    | 842 ++++++++++++++++++
>  6 files changed, 945 insertions(+), 12 deletions(-)
>  create mode 100644 drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index aacccb376c28..ecf7af1b2df8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -22078,6 +22078,7 @@ M:	Thierry Reding <thierry.reding@gmail.com>
>  R:	Krishna Reddy <vdumpa@nvidia.com>
>  L:	linux-tegra@vger.kernel.org
>  S:	Supported
> +F:	drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
>  F:	drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c
>  F:	drivers/iommu/tegra*
>  
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index c04584be3089..e009387d3cba 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -423,6 +423,17 @@ config ARM_SMMU_V3_KUNIT_TEST
>  	  Enable this option to unit-test arm-smmu-v3 driver functions.
>  
>  	  If unsure, say N.
> +
> +config TEGRA241_CMDQV
> +	bool "NVIDIA Tegra241 CMDQ-V extension support for ARM SMMUv3"
> +	depends on ACPI
> +	help
> +	  Support for NVIDIA CMDQ-Virtualization extension for ARM SMMUv3. The
> +	  CMDQ-V extension is similar to v3.3 ECMDQ for multi command queues
> +	  support, except with virtualization capabilities.
> +
> +	  Say Y here if your system is NVIDIA Tegra241 (Grace) or it has the same
> +	  CMDQ-V extension.
>  endif
>  
>  config S390_IOMMU
> diff --git a/drivers/iommu/arm/arm-smmu-v3/Makefile b/drivers/iommu/arm/arm-smmu-v3/Makefile
> index 014a997753a8..55201fdd7007 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/Makefile
> +++ b/drivers/iommu/arm/arm-smmu-v3/Makefile
> @@ -2,6 +2,7 @@
>  obj-$(CONFIG_ARM_SMMU_V3) += arm_smmu_v3.o
>  arm_smmu_v3-objs-y += arm-smmu-v3.o
>  arm_smmu_v3-objs-$(CONFIG_ARM_SMMU_V3_SVA) += arm-smmu-v3-sva.o
> +arm_smmu_v3-objs-$(CONFIG_TEGRA241_CMDQV) += tegra241-cmdqv.o
>  arm_smmu_v3-objs := $(arm_smmu_v3-objs-y)
>  
>  obj-$(CONFIG_ARM_SMMU_V3_KUNIT_TEST) += arm-smmu-v3-test.o
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index ba0e24d5ffbf..430e84fe3679 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -334,6 +334,9 @@ static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
>  
>  static struct arm_smmu_cmdq *arm_smmu_get_cmdq(struct arm_smmu_device *smmu)
>  {
> +	if (arm_smmu_has_tegra241_cmdqv(smmu))
> +		return tegra241_cmdqv_get_cmdq(smmu);
> +
>  	return &smmu->cmdq;

Hardcoding all these tegra-specific checks in the core driver is pretty
horrible :/

Instead, please can we do something similar to the SMMUv2 driver? That
is, tweak the probe routine to call something akin to the
arm_smmu_impl_init() function, which looks at the 'model' field pulled
out of the IORT and can then dispatch directly to a tegra-specific init
function (see, e.g. nvidia_smmu_impl_init() for SMMUv2).

From there, you can both install function pointers into the
'arm_smmu_device' structure which can be used instead of having the the
'if (tegra)' checks in the main driver and you can also re-allocate the
structu to live inside a private structure instead of having the
backpointer.

Maybe those cmdq function pointers would be happy for other extensions
too (e.g. the ECMDQ stuff at [1]).

Will

[1] https://lore.kernel.org/r/20240425144152.52352-3-tanmay@marvell.com
