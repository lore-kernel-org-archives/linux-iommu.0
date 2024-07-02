Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950EC1BD02F;
	Tue,  2 Jul 2024 17:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719942193; cv=none; b=Pqry4XKupxFNUFZElA1XjMi0JXe2fGG/QuSSBKtEGvle4ECSCBGowm0ptwe/A6YyAUh6Gk2BqBFzjTNkIMQZP8FC+dpOQAifKQiLl7la1xLPoSGgUqYVlzQfZjhrKBE4Rb0gVXmXgnccjF6b0kSdbpSDeN4Ol3AN4zuNna0rKuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719942193; c=relaxed/simple;
	bh=p/qm+v26kUc0ox29i003KD+oPtYq1CDkFNO2ztKMjLg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fCc3XxOqtj8dT+MQRGavIJjuLJvyyrklHcWQPnJToaSsGdCH9mA2GMb1tWdczrAF/SHv/Aqbp7MAduzKmjh6BT7hhCMuk9J6fFSgVicqTVj/PKvg4sTKDJZsDw/xo7/G04KPevjCxQTgtTmTPaIBRJ3uODe9s8n7yfZArc/PJQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CYgbV/Gt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CYgbV/Gt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E96CC116B1;
	Tue,  2 Jul 2024 17:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719942193;
	bh=p/qm+v26kUc0ox29i003KD+oPtYq1CDkFNO2ztKMjLg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CYgbV/GtG/Vpr+Jh7kqIgc+8lKJ/2wgpckkLRxNHBEjVMZUiv5NMujQIOyUqUlpMQ
	 pgGzoHKhD1ouX44P2Ldpzm3nFGkr+uQG989vz3csXrpnUJyXe4Vj/Dqh8TL/bQkSrh
	 2t0KfLJEmmNtQxMmzhrNJrvjuQAeVjgONEXR4sHQ2oPIZwkXgtyehPRGz4cpAF8zRC
	 LXezH28PZorqTZygHzPE+otjgtjsYvOOqELjTkpkmPDPOBwJC1DC7M9R6/mVLpOdlt
	 ngSyDEg/8bDR9BnKRzNkcTDg9V3GGwiyzFDghLluaCg6yFqEpcG9n3lf8RBEPOti4c
	 sHvWsFivifZuA==
Date: Tue, 2 Jul 2024 18:43:07 +0100
From: Will Deacon <will@kernel.org>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: robin.murphy@arm.com, joro@8bytes.org, jgg@nvidia.com,
	thierry.reding@gmail.com, vdumpa@nvidia.com, jonathanh@nvidia.com,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v9 4/6] iommu/arm-smmu-v3: Add CS_NONE quirk for
 CONFIG_TEGRA241_CMDQV
Message-ID: <20240702174307.GB4740@willie-the-truck>
References: <cover.1718228494.git.nicolinc@nvidia.com>
 <d20dc9939523fac490bc02e57d7836f680916a36.1718228494.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d20dc9939523fac490bc02e57d7836f680916a36.1718228494.git.nicolinc@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Wed, Jun 12, 2024 at 02:45:31PM -0700, Nicolin Chen wrote:
> The CMDQV extension in NVIDIA Tegra241 SoC only supports CS_NONE in the
> CS field of CMD_SYNC. Add a quirk flag to accommodate that.
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 8 +++++++-
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h | 3 +++
>  2 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index c864c634cd23..ba0e24d5ffbf 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -345,6 +345,11 @@ static void arm_smmu_cmdq_build_sync_cmd(u64 *cmd, struct arm_smmu_device *smmu,
>  		 FIELD_PREP(CMDQ_SYNC_0_MSH, ARM_SMMU_SH_ISH) |
>  		 FIELD_PREP(CMDQ_SYNC_0_MSIATTR, ARM_SMMU_MEMATTR_OIWB);
>  
> +	if (q->quirks & CMDQ_QUIRK_SYNC_CS_NONE_ONLY) {
> +		cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_CS, CMDQ_SYNC_0_CS_NONE);
> +		return;
> +	}
> +
>  	if (!(smmu->options & ARM_SMMU_OPT_MSIPOLL)) {
>  		cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_CS, CMDQ_SYNC_0_CS_SEV);
>  		return;
> @@ -690,7 +695,8 @@ static int arm_smmu_cmdq_poll_until_sync(struct arm_smmu_device *smmu,
>  					 struct arm_smmu_cmdq *cmdq,
>  					 struct arm_smmu_ll_queue *llq)
>  {
> -	if (smmu->options & ARM_SMMU_OPT_MSIPOLL)
> +	if (smmu->options & ARM_SMMU_OPT_MSIPOLL &&
> +	    !(cmdq->q.quirks & CMDQ_QUIRK_SYNC_CS_NONE_ONLY))
>  		return __arm_smmu_cmdq_poll_until_msi(smmu, cmdq, llq);
>  
>  	return __arm_smmu_cmdq_poll_until_consumed(smmu, cmdq, llq);
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> index 180c0b1e0658..01227c0de290 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -543,6 +543,9 @@ struct arm_smmu_queue {
>  
>  	u32 __iomem			*prod_reg;
>  	u32 __iomem			*cons_reg;
> +
> +#define CMDQ_QUIRK_SYNC_CS_NONE_ONLY	BIT(0)	/* CMD_SYNC CS field supports CS_NONE only */
> +	u32				quirks;

Please can you use the existing smmu->options field instead of adding
another place to track quirks? Or do you need this only for some of the
queues for a given SMMU device?

Thanks,

Will
