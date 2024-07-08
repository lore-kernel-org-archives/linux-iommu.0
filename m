Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6E178C71;
	Mon,  8 Jul 2024 11:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720438280; cv=none; b=PA8C+difrYRV8d/p+ClfiC0GOn89ke8fbHBFfChi3X9wLoPmjTyT7wfuzXpDGj87cmI/ZeOyMPKvvZoVP2oGiCO9ZRnX4BPURMC0DBQy1uVs3pydeU7d99bgnPbS1OjP1znrZieu45ydRyGOKxdJoUCORGN20ccV9Ovo1sUOOjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720438280; c=relaxed/simple;
	bh=Z/MuRSblSTgcI7qRqzl4/F+9kPtk6TkbWjAojUxsU7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XeL8+ciZ57ZWi2vXA9OTwbvhb+/7yHO4RTTZeF5ibfaLkw5zT8RP6JCq0sUeSc5hVS5uEVaOJyl2rctlw9MbfEg63eJbWswui0fhhV9pOwdxd3Y0uDIvasauUugsglT6+lm5T10poolrcCcqjvGQgKB6GbRbAXte5KFAGoInIPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rGJaxqFo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rGJaxqFo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E5CDC116B1;
	Mon,  8 Jul 2024 11:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720438280;
	bh=Z/MuRSblSTgcI7qRqzl4/F+9kPtk6TkbWjAojUxsU7A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rGJaxqFocUpFlr5A3jEvthl5GOtTqRGBRuWZUiUxYV8vNxn2p7HrGPVcdQjK6F6OE
	 b7jy9uH5BuggtZelKj1vf3FHyTMUc53/Hrrbo2QnAR7Se6uvwIm7YPvlsR1wJZe2Lp
	 ZQTcLjHPDpShytlvdeEPtu6g12f3JQTnePFVImqd48JtIksRwBLWFCDW4BlSbcAiJJ
	 S8C0OQ2w6KwonaLalYdG5fxzxcCIUtiiHLHOUtCHVe9ncf+D28HY7Y4YPlUC/WSeIb
	 nBgVIg3uXg/0cXQH3MnEjRxxG75eInJQ1obqGyE5B1CLR0T3n9wLPdhYg1hPWP8Jwb
	 hou8gugSScGcA==
Date: Mon, 8 Jul 2024 12:31:15 +0100
From: Will Deacon <will@kernel.org>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: robin.murphy@arm.com, joro@8bytes.org, jgg@nvidia.com,
	thierry.reding@gmail.com, vdumpa@nvidia.com, jonathanh@nvidia.com,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v9 4/6] iommu/arm-smmu-v3: Add CS_NONE quirk for
 CONFIG_TEGRA241_CMDQV
Message-ID: <20240708113115.GC11567@willie-the-truck>
References: <cover.1718228494.git.nicolinc@nvidia.com>
 <d20dc9939523fac490bc02e57d7836f680916a36.1718228494.git.nicolinc@nvidia.com>
 <20240702174307.GB4740@willie-the-truck>
 <ZoREzIAqzyamQBWL@Asurada-Nvidia>
 <20240702184942.GD5167@willie-the-truck>
 <ZoRZP4k1A3G7nH9q@Asurada-Nvidia>
 <ZoReq/kNi368x79q@Asurada-Nvidia>
 <20240705152721.GA9485@willie-the-truck>
 <Zog3IgdmYRU7VbJB@Asurada-Nvidia>
 <ZoiQmAszSQbP18lQ@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZoiQmAszSQbP18lQ@Asurada-Nvidia>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Fri, Jul 05, 2024 at 05:32:24PM -0700, Nicolin Chen wrote:
> On Fri, Jul 05, 2024 at 11:10:47AM -0700, Nicolin Chen wrote:
> > On Fri, Jul 05, 2024 at 04:27:21PM +0100, Will Deacon wrote:
> > > On Tue, Jul 02, 2024 at 01:10:19PM -0700, Nicolin Chen wrote:
> > > > On Tue, Jul 02, 2024 at 12:47:14PM -0700, Nicolin Chen wrote:
> > > > > @@ -345,6 +345,11 @@ static void arm_smmu_cmdq_build_sync_cmd(u64 *cmd, struct arm_smmu_device *smmu,
> > > > >             FIELD_PREP(CMDQ_SYNC_0_MSH, ARM_SMMU_SH_ISH) |
> > > > >             FIELD_PREP(CMDQ_SYNC_0_MSIATTR, ARM_SMMU_MEMATTR_OIWB);
> > > > >
> > > > > +   if (cmdq->type == TEGRA241_VCMDQ) {
> > > > > +           cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_CS, CMDQ_SYNC_0_CS_NONE);
> > > > > +           return;
> > > > > +   }
> > > > > +
> > > > >     if (!(smmu->options & ARM_SMMU_OPT_MSIPOLL)) {
> > > > >             cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_CS, CMDQ_SYNC_0_CS_SEV);
> > > > >             return;
> > > > > @@ -690,7 +695,8 @@ static int arm_smmu_cmdq_poll_until_sync(struct arm_smmu_device *smmu,
> > > > >                                     struct arm_smmu_cmdq *cmdq,
> > > > >                                     struct arm_smmu_ll_queue *llq)
> > > > >  {
> > > > > -   if (smmu->options & ARM_SMMU_OPT_MSIPOLL)
> > > > > +   if (smmu->options & ARM_SMMU_OPT_MSIPOLL &&
> > > > > +       cmdq->type != TEGRA241_VCMDQ) {
> > > > >             return __arm_smmu_cmdq_poll_until_msi(smmu, cmdq, llq);
> > > > >
> > > > > --------------------------------------------------------------
> > > > >
> > > > > Would you prefer this one? I feel CMDQ_QUIRK_SYNC_CS_NONE_ONLY
> > > > > is more general looking though..
> > > >
> > > > And we would need some additional lines of comments for the two
> > > > pieces above, explaining why TEGRA241_VCMDQ type needs the first
> > > > one while bypasses the second one. Again, it feels even worse :(
> > > 
> > > I hacked the code around a bit this afternoon. Please can you see if:
> > > 
> > > https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git/log/?h=for-nicolin/grace-vcmdq-wip
> > > 
> > > does roughly what you need?
> > 
> > I appreciate the patch. Yet, we cannot use IORT's model field.
> > This would need to go through IORT documentation, for A. And B,
> > we had a very long discussion with ARM (Robin was there) years
> > ago, and concluded that this CMDQV would not be a model in IORT
> > but a DSDT node as an extension. So, this is firm...
> > 
> > With that, we cannot avoid an unconditional hard-coding tegra
> > function call even if we switch to an impl design:
> > 
> > +static int acpi_smmu_impl_init(u32 model, struct arm_smmu_device *smmu)
> > +{
> > +	/*
> > +	 * unconditional go through ACPI table to detect if there is a tegra241
> > +	 * implementation that extends SMMU with a CMDQV. The probe() will fill
> > +	 * the smmu->impl pointer upon success. Otherwise, fall back to regular
> > +	 * SMMU CMDQ.
> > +	 */
> > +	tegra241_impl_acpi_probe(smmu);
> > +	return 0;
> > +}
> > 
> > As for arm_smmu_cmdq_needs_busy_polling, it doesn't really look
> > very optimal to me. But if you insist on having an smmu option,
> > we still have to take in the PATCH-3 in this series, enforcing
> > an arm_smmu_cmdq_build_sync_cmd() call in the IRQ handler too.
> > So, it would eventually look like [attachment].
> 
> Please ignore the attachment. Since we are adding arm_smmu_impl,
> I figure that we could add an arm_smmu_cmdq_impl too. There's an
> another small feature that I didn't implement in this v9, while
> being able to benefit from a cmdq impl now.
> 
> The impl can also hold a boolean busy_polling, so we won't need
> a global smmu option.

So /that/ might be overkill. Architectural queues can use polling, so I
don't mind having that option in the driver and it should keep the number
of impl hooks to a minimum.

> I will send a new version asap, though I am not sure if we can
> still make it to this cycle that we hoped for :-/

I'm in fixes-only mode at this point, especially since we've not had a
linux-next for a while.

Will
