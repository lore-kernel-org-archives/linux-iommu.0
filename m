Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D497E0E9;
	Mon,  8 Jul 2024 11:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720438175; cv=none; b=agdfLQ90/cDoblvvIKdpLSyj1Vc4BP4G57TTq2pHCoy24NuUoldnPv25JJvywhBj2dn1mYQ9Um1JZ0CseByMCaE4tZsXGrCnF+psD3a/E8EheOwu+tFLCYltLfr1HRF9j+/GHmqh3+2z5mZHJUe8C++KGjo9QvAHViFdfpi/DWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720438175; c=relaxed/simple;
	bh=v4E8/lwbejDpaEpC/wq68LE/jQ6r1xobIe9EIBTwuWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tzwKVqs32g6P4W9Cd8ks1gZfG74xNhqmUrzGU+JC+gQJjmvKYdjMJSMZP3bzUtPHenLEtbN4n97YrmUPa0e+AJQHLo4wZFuUh+1Er+c1Lx4RMZw9SRNWmEld95ypLeBrHNoU/V31kEEzldqtnesT4CmrbZmACBF2ImSk/387EqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tg6KtiW1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tg6KtiW1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 615AFC116B1;
	Mon,  8 Jul 2024 11:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720438174;
	bh=v4E8/lwbejDpaEpC/wq68LE/jQ6r1xobIe9EIBTwuWU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tg6KtiW1r4oh4bhcLIXPgu++Qz0zTUs+0zYlScgKv/zml/y05EssquyEfaaGULhKa
	 jD5azOeTx2sDIe80rmJyCOP8+6lQudEUXrMkAYBiMETL5F8hPbee4hhYRH7SqyY+Bo
	 LvD1sl1w1TxKNfPslDZDwSGEJAwSlo1sWiKkHW7ODJ9u+SeYBYiqdJXfEYQ97MW4Kq
	 rE5KU9DrubcmTk3w+H9nT8fw3pcCrUpNB2ZP+crMQkGcS107MOLKt9iaNIp+RXZ1pa
	 F7JPrhoAKs6zwc5J24EdR0+gtqRldDIXRbMgMEgo7r+Air5VpyzrbUmeICj8oMFd4W
	 dj/lV0J1SWSfg==
Date: Mon, 8 Jul 2024 12:29:28 +0100
From: Will Deacon <will@kernel.org>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: robin.murphy@arm.com, joro@8bytes.org, jgg@nvidia.com,
	thierry.reding@gmail.com, vdumpa@nvidia.com, jonathanh@nvidia.com,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v9 4/6] iommu/arm-smmu-v3: Add CS_NONE quirk for
 CONFIG_TEGRA241_CMDQV
Message-ID: <20240708112928.GB11567@willie-the-truck>
References: <cover.1718228494.git.nicolinc@nvidia.com>
 <d20dc9939523fac490bc02e57d7836f680916a36.1718228494.git.nicolinc@nvidia.com>
 <20240702174307.GB4740@willie-the-truck>
 <ZoREzIAqzyamQBWL@Asurada-Nvidia>
 <20240702184942.GD5167@willie-the-truck>
 <ZoRZP4k1A3G7nH9q@Asurada-Nvidia>
 <ZoReq/kNi368x79q@Asurada-Nvidia>
 <20240705152721.GA9485@willie-the-truck>
 <Zog3IgdmYRU7VbJB@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zog3IgdmYRU7VbJB@Asurada-Nvidia>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Fri, Jul 05, 2024 at 11:10:42AM -0700, Nicolin Chen wrote:
> On Fri, Jul 05, 2024 at 04:27:21PM +0100, Will Deacon wrote:
> > On Tue, Jul 02, 2024 at 01:10:19PM -0700, Nicolin Chen wrote:
> > > On Tue, Jul 02, 2024 at 12:47:14PM -0700, Nicolin Chen wrote:
> > > > @@ -345,6 +345,11 @@ static void arm_smmu_cmdq_build_sync_cmd(u64 *cmd, struct arm_smmu_device *smmu,
> > > >             FIELD_PREP(CMDQ_SYNC_0_MSH, ARM_SMMU_SH_ISH) |
> > > >             FIELD_PREP(CMDQ_SYNC_0_MSIATTR, ARM_SMMU_MEMATTR_OIWB);
> > > >
> > > > +   if (cmdq->type == TEGRA241_VCMDQ) {
> > > > +           cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_CS, CMDQ_SYNC_0_CS_NONE);
> > > > +           return;
> > > > +   }
> > > > +
> > > >     if (!(smmu->options & ARM_SMMU_OPT_MSIPOLL)) {
> > > >             cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_CS, CMDQ_SYNC_0_CS_SEV);
> > > >             return;
> > > > @@ -690,7 +695,8 @@ static int arm_smmu_cmdq_poll_until_sync(struct arm_smmu_device *smmu,
> > > >                                     struct arm_smmu_cmdq *cmdq,
> > > >                                     struct arm_smmu_ll_queue *llq)
> > > >  {
> > > > -   if (smmu->options & ARM_SMMU_OPT_MSIPOLL)
> > > > +   if (smmu->options & ARM_SMMU_OPT_MSIPOLL &&
> > > > +       cmdq->type != TEGRA241_VCMDQ) {
> > > >             return __arm_smmu_cmdq_poll_until_msi(smmu, cmdq, llq);
> > > >
> > > > --------------------------------------------------------------
> > > >
> > > > Would you prefer this one? I feel CMDQ_QUIRK_SYNC_CS_NONE_ONLY
> > > > is more general looking though..
> > >
> > > And we would need some additional lines of comments for the two
> > > pieces above, explaining why TEGRA241_VCMDQ type needs the first
> > > one while bypasses the second one. Again, it feels even worse :(
> > 
> > I hacked the code around a bit this afternoon. Please can you see if:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git/log/?h=for-nicolin/grace-vcmdq-wip
> > 
> > does roughly what you need?
> 
> I appreciate the patch. Yet, we cannot use IORT's model field.
> This would need to go through IORT documentation, for A. And B,
> we had a very long discussion with ARM (Robin was there) years
> ago, and concluded that this CMDQV would not be a model in IORT
> but a DSDT node as an extension. So, this is firm...

Seems like a bad outcome given that you've clearly modified the IP, but
whatever. We can parse the DSDT when we detect whatever the model
actually is; I don't think that's a huge issue.

> With that, we cannot avoid an unconditional hard-coding tegra
> function call even if we switch to an impl design:
> 
> +static int acpi_smmu_impl_init(u32 model, struct arm_smmu_device *smmu)
> +{
> +	/*
> +	 * unconditional go through ACPI table to detect if there is a tegra241
> +	 * implementation that extends SMMU with a CMDQV. The probe() will fill
> +	 * the smmu->impl pointer upon success. Otherwise, fall back to regular
> +	 * SMMU CMDQ.
> +	 */
> +	tegra241_impl_acpi_probe(smmu);

In-line the minimal DSDT parsing to figure out if we're on a Tegra part.
If it's that bad, put it in a static inline in arm-smmu-v3.h.

> +	return 0;
> +}
> 
> As for arm_smmu_cmdq_needs_busy_polling, it doesn't really look
> very optimal to me.

"optimal" in what sense? In that you don't like how it smells, or that
it's measurably bad?

> But if you insist on having an smmu option, we still have to take in the
> PATCH-3 in this series, enforcing an arm_smmu_cmdq_build_sync_cmd() call
> in the IRQ handler too.  So, it would eventually look like [attachment].

With my hacks, I think you can just call arm_smmu_cmdq_build_sync_cmd()
from the irqhandler and it will work.

Will
