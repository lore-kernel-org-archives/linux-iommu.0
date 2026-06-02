Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59AF7175A98;
	Tue,  2 Jun 2026 20:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780431741; cv=none; b=oBmJw9xa1eUFIJJWdZ7PbRXuqXbS18stI+aF8mc8/8zGQ9b1+jxcmfikwx8hdZ58vNhdG34gEJlMgs64lof3+zqRgzCnb8S+1YtWaaAxcHPqWzb/XD/4eZr/gjoAusCE7iBFiXE5QuUMMowKLA3LFatxIcR/EBCxVz9AvkdV3qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780431741; c=relaxed/simple;
	bh=5sARm+QFoNipjki7mpm3mGne8xnn5obqH/6G0T/6III=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rq8vf4ZggvWQa36DAAPG3L0qjSCV4UkonbhMC+OEBj1XV7/lkzq0Qjy0zPir7xGubYXm0Jl9RtoF617jImfiJ9bib5+IvfariIg0FvSavqSN1IU7nHmCESra/I3csIXgASVRrFkli/6PFDqfu77K9IEmsiehfWLUEvjUAnyFtyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YwSdXW7c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YwSdXW7c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36E481F00893;
	Tue,  2 Jun 2026 20:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780431740;
	bh=9bNLFBK1Y83+hE+EiqlLfrxOTlslRiR1hkYndMhTlvg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YwSdXW7cgnumKHsL2ls94fDm0wGSWGzWSpmU2MLe5+MQFCIAkhvHQyWNTs1p39mel
	 y0vHjbwfzuduF1D9kPwsnrlD6ImBpsNO1kFgUV2QJSMVOCOeEI3w/SyuKDY04vrskB
	 rpgJOepJv3JLAXXXNucWh3++hSreJMAWapJ348o5EVLLCJcix0nPNdvVg482BkPQij
	 X3alDB6kCkon9Ga07H8LCUpFT8FkOmchDx1nqNmUS088fUT9A45ionY00LUKO5/vw/
	 bxN+JhCzsIWhxxZ24z6enT4/5JcG/g7xfng9ffpoG047duBPVviWNwoKyDHnrgRkgm
	 d4rHqDr562sbw==
Date: Tue, 2 Jun 2026 21:22:15 +0100
From: Will Deacon <will@kernel.org>
To: Ashish Mhetre <amhetre@nvidia.com>
Cc: robin.murphy@arm.com, joro@8bytes.org, jgg@ziepe.ca,
	nicolinc@nvidia.com, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH v3 3/3] iommu/arm-smmu-v3: Issue CFGI/TLBI twice on
 Tegra264
Message-ID: <ah87dzHOOTNGBBmt@willie-the-truck>
References: <20260601104845.995005-1-amhetre@nvidia.com>
 <20260601104845.995005-4-amhetre@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260601104845.995005-4-amhetre@nvidia.com>

On Mon, Jun 01, 2026 at 10:48:45AM +0000, Ashish Mhetre wrote:
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> index 1e9f7d2de344..78c96a2b652b 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> @@ -350,6 +350,26 @@ static int arm_vsmmu_convert_user_cmd(struct arm_vsmmu *vsmmu,
>  	return 0;
>  }
>  
> +/*
> + * On Tegra264, arm_smmu_cmdq_issue_cmdlist() doubles every CFGI/TLBI
> + * submission (see ARM_SMMU_OPT_TLBI_TWICE). The doubling decision is
> + * taken once per cmdlist based on the first command, so a single
> + * batch must not mix commands that need doubling with commands that
> + * do not. Split the iommufd batch whenever the next user command
> + * crosses that boundary.
> + */

Again, I wouldn't bother with this comment. You probably _should_ update
Documentation/arch/arm64/silicon-errata.rst, however.

> +static bool arm_vsmmu_can_batch_cmd(struct arm_smmu_device *smmu,
> +				    struct arm_vsmmu_invalidation_cmd *last,
> +				    struct arm_vsmmu_invalidation_cmd *next)
> +{
> +	struct arm_smmu_cmd next_cmd = {
> +		.data[0] = le64_to_cpu(next->ucmd.cmd[0]),
> +	};
> +
> +	return arm_smmu_cmd_needs_tlbi_twice(smmu, &last->cmd) ==
> +	       arm_smmu_cmd_needs_tlbi_twice(smmu, &next_cmd);
> +}
> +
>  int arm_vsmmu_cache_invalidate(struct iommufd_viommu *viommu,
>  			       struct iommu_user_data_array *array)
>  {
> @@ -382,7 +402,8 @@ int arm_vsmmu_cache_invalidate(struct iommufd_viommu *viommu,
>  
>  		/* FIXME work in blocks of CMDQ_BATCH_ENTRIES and copy each block? */
>  		cur++;
> -		if (cur != end && (cur - last) != CMDQ_BATCH_ENTRIES - 1)
> +		if (cur != end && (cur - last) != CMDQ_BATCH_ENTRIES - 1 &&
> +		    arm_vsmmu_can_batch_cmd(smmu, last, cur))
>  			continue;

FYI: Sashiko is unhappy with the existing code here, so somebody should
check that out:

https://sashiko.dev/#/patchset/20260601104845.995005-2-amhetre@nvidia.com

>  		/* FIXME always uses the main cmdq rather than trying to group by type */
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 08684bd40a6d..f38c21b56f28 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -698,10 +698,10 @@ static void arm_smmu_cmdq_write_entries(struct arm_smmu_cmdq *cmdq,
>   *   insert their own list of commands then all of the commands from one
>   *   CPU will appear before any of the commands from the other CPU.
>   */
> -int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
> -				struct arm_smmu_cmdq *cmdq,
> -				struct arm_smmu_cmd *cmds, int n,
> -				bool sync)
> +static int __arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
> +					 struct arm_smmu_cmdq *cmdq,
> +					 struct arm_smmu_cmd *cmds, int n,
> +					 bool sync)
>  {
>  	struct arm_smmu_cmd cmd_sync;
>  	u32 prod;
> @@ -820,6 +820,26 @@ int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
>  	return ret;
>  }
>  
> +int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
> +				struct arm_smmu_cmdq *cmdq,
> +				struct arm_smmu_cmd *cmds, int n,
> +				bool sync)
> +{
> +	int ret = __arm_smmu_cmdq_issue_cmdlist(smmu, cmdq, cmds, n, sync);
> +
> +	/*
> +	 * On Tegra264 (see ARM_SMMU_OPT_TLBI_TWICE) re-issue the same
> +	 * cmdlist with another CMD_SYNC to satisfy the erratum.
> +	 * Callers must ensure the batch carries a uniform opcode class
> +	 * so that checking the first command is enough; the iommufd
> +	 * VSMMU path enforces this with arm_vsmmu_can_batch_cmd().
> +	 */
> +	if (!ret && sync && arm_smmu_cmd_needs_tlbi_twice(smmu, &cmds[0]))

Can you move the arm_smmu_cmd_... part to the start of the conjunction,
please? If you make it a static key as I mentioned previously, then
hopefully that should mean everything else is moved out of line.

> +		ret = __arm_smmu_cmdq_issue_cmdlist(smmu, cmdq, cmds, n, sync);

Sashiko is also unhappy here if n == 0 because we probably shouldn't
be inspecting the command array in that case. Generally, it's a pity
that we can't handle this all a bit further up in the stack when we know
exactly what operationg we're trying to perform, but I suppose with all
the different users of the invalidation commands that's hard to catch in
one place?

> +
> +	return ret;
> +}
> +
>  static int arm_smmu_cmdq_issue_cmd_p(struct arm_smmu_device *smmu,
>  				     struct arm_smmu_cmd *cmd, bool sync)
>  {
> @@ -863,6 +883,14 @@ static bool arm_smmu_cmdq_batch_force_sync(struct arm_smmu_device *smmu,
>  	    (smmu->options & ARM_SMMU_OPT_CMDQ_FORCE_SYNC))
>  		return true;
>  
> +	/*
> +	 * Tegra264 erratum (see ARM_SMMU_OPT_TLBI_TWICE). The batch holds
> +	 * a uniform opcode class, so checking the first command is enough.
> +	 */

Again, please drop the Tegra264 mention and just refer to the option.

Will
