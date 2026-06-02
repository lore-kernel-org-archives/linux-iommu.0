Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5F52DCF55;
	Tue,  2 Jun 2026 19:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780430118; cv=none; b=R6jt0yvNg2IAGoPHtdGQicCYiDUzyZgsRBwsS2AVuJbsP5u5xNqv0GkIgEKuhE+g2nZvtHrRBcbxkR9ogPI7o1YTfGSDXQ4hK1D7EOYN4YxJrkZ0p77vyXCd/UmPi7/YeelFp5eREp2CrNdRysNhFLE80KnhqluLAcua+XhxpMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780430118; c=relaxed/simple;
	bh=b4YeU9QgP4KINmACbxRLdcc2G0YEIxlXTdEweqpKAn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iRYUB3rh3xPsFS3wpSMkKuZDeq5eCGgG4OpRgKwsgyYPE04fDC2c8o+fsfqKOTuvPUvv6IHvWwoiIdACCMKXFMc0NReykt+xZtN+MThKokXqLPfJe6gvopRK+X9xsJ46RZ54St8Ldk11QlTair56lUuFIWuJY6s0x4vsGR+s3c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bGOerLGi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bGOerLGi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 461E91F00893;
	Tue,  2 Jun 2026 19:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780430116;
	bh=ftOIpII2o5BHlSrpYjdtnSczjR8NYdTjJYRnMSN/BTM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bGOerLGi9R5hKth9QMPVvN8b5Ds4rpn8aJMi2p2Qe5KjZxinm0fUynTnZXzRaMUDC
	 r9pNx4zbJ6VuFllwfLUpJyxEGxBxdyXiggpPSW1hCVsVFJfiueOVZfdfSw1jR8Hgia
	 Bpy7b609LIotTjG0zVmaAEP74TXkqY7nj1E/g444K9C+K45X2zPMamz8lCQtiUfYPY
	 51O85iXZumK49wtOfL5+ONJtxWAQWaTwwOaakRVdpiJAFxIXPr7paXH+xqfnEJDGNA
	 TWFt+s0rnkr/ibIForY/iVSaCNdZu3eLSGbZh/3LxrovMEP+rsfM/Yp07S0FPwoq58
	 ApUDj+6WcAFOA==
Date: Tue, 2 Jun 2026 20:55:10 +0100
From: Will Deacon <will@kernel.org>
To: Ashish Mhetre <amhetre@nvidia.com>
Cc: robin.murphy@arm.com, joro@8bytes.org, jgg@ziepe.ca,
	nicolinc@nvidia.com, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH v3 1/3] iommu/arm-smmu-v3: Factor out CMDQ batch
 force-sync conditions
Message-ID: <ah81HhVW7_h9xyDM@willie-the-truck>
References: <20260601104845.995005-1-amhetre@nvidia.com>
 <20260601104845.995005-2-amhetre@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260601104845.995005-2-amhetre@nvidia.com>

On Mon, Jun 01, 2026 at 10:48:43AM +0000, Ashish Mhetre wrote:
> From: Nicolin Chen <nicolinc@nvidia.com>
> 
> arm_smmu_cmdq_batch_add_cmd_p() carries two distinct reasons for
> flushing the current batch with a CMD_SYNC before appending the
> new command:
> 
>   - The batch's pre-assigned cmdq does not support the new command.
>   - The Arm erratum 2812531 workaround (ARM_SMMU_OPT_CMDQ_FORCE_SYNC)
>     forces a SYNC at one entry before the batch is full.
> 
> Lift those checks into a new arm_smmu_cmdq_batch_force_sync() helper
> so that adding another force-sync condition becomes a one-line
> addition. No functional change.
> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 26 ++++++++++++++++-----
>  1 file changed, 20 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 9be589d14a3b..4d29bd343460 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -847,16 +847,30 @@ static void arm_smmu_cmdq_batch_init_cmd(struct arm_smmu_device *smmu,
>  	cmds->cmdq = arm_smmu_get_cmdq(smmu, cmd);
>  }
>  
> +static bool arm_smmu_cmdq_batch_force_sync(struct arm_smmu_device *smmu,
> +					   struct arm_smmu_cmdq_batch *cmds,
> +					   struct arm_smmu_cmd *cmd)
> +{
> +	if (!cmds->num)
> +		return false;

This check seems new?

Will
