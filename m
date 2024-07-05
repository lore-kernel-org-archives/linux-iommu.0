Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60FC316A94F;
	Fri,  5 Jul 2024 15:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720193247; cv=none; b=nlItAr2rroZROK1h7YQ+y2LgaqN8oZGOhyWiZGY/PQDh82VM86XxD9E4E+TATWpj4D7cHUSv25Y588Ss7o+F2N+hsCqO1D7HDHc6EeBeinQXjE52m4rdap4ZYQPJhrpycxko+6oOKiph3K0m1sZQY92JqHnPKNmT1CBXPdMiDe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720193247; c=relaxed/simple;
	bh=293ScHg6dX/n+ot2SYdQNqDyAVHAPFtaqM2zrDuwcv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B3aT8IAlJ8tdChowqH7CEuTWWGYMu0unoIPyIegHM8nscTQpE9BAtvqVghgCa84JKhAksjGSimadRnJ6d2UdDBAEU9yBYCRx/rtvD+mM1Fm9vE6p5GKiOpmZ2C38L4WEGm2Vew/dfaiF58zb1ftHtpV1410JqoBkfORUluSt0N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u9FP9MSA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u9FP9MSA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7C35C116B1;
	Fri,  5 Jul 2024 15:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720193246;
	bh=293ScHg6dX/n+ot2SYdQNqDyAVHAPFtaqM2zrDuwcv8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u9FP9MSA3B0NehidQL4z1aVZ6ykOFX706cXsvFxi3vnOFdxwvaWcdaBm8XYb00mJE
	 CB8+5rLVm2/7sFIxoKSCzQdwuYig8ozO2UVOU1Z7iVl3iL1Vx1mSa3kREGAEmFAy1s
	 ENoEKat0IgjUGHjGzUCWE2ZGaDlDrzpVxpUDhJWD03UvPJ5luubcbS/GpzKw6gzWit
	 O9WeswdkP+YwBYH3eG497P7yqcFiPYXjhhC+o0IBtWOnONz+z/oa3YYiXR/+xfEujv
	 kaKra6NC4TfBJWTs8U9yA12L3y2xEfDeL4+BNC5uURk1s9zZxBH7W8y63OhVksJfGb
	 cpTzvXfgb44ig==
Date: Fri, 5 Jul 2024 16:27:21 +0100
From: Will Deacon <will@kernel.org>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: robin.murphy@arm.com, joro@8bytes.org, jgg@nvidia.com,
	thierry.reding@gmail.com, vdumpa@nvidia.com, jonathanh@nvidia.com,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v9 4/6] iommu/arm-smmu-v3: Add CS_NONE quirk for
 CONFIG_TEGRA241_CMDQV
Message-ID: <20240705152721.GA9485@willie-the-truck>
References: <cover.1718228494.git.nicolinc@nvidia.com>
 <d20dc9939523fac490bc02e57d7836f680916a36.1718228494.git.nicolinc@nvidia.com>
 <20240702174307.GB4740@willie-the-truck>
 <ZoREzIAqzyamQBWL@Asurada-Nvidia>
 <20240702184942.GD5167@willie-the-truck>
 <ZoRZP4k1A3G7nH9q@Asurada-Nvidia>
 <ZoReq/kNi368x79q@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZoReq/kNi368x79q@Asurada-Nvidia>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Tue, Jul 02, 2024 at 01:10:19PM -0700, Nicolin Chen wrote:
> On Tue, Jul 02, 2024 at 12:47:14PM -0700, Nicolin Chen wrote:
> > @@ -345,6 +345,11 @@ static void arm_smmu_cmdq_build_sync_cmd(u64 *cmd, struct arm_smmu_device *smmu,
> >  		FIELD_PREP(CMDQ_SYNC_0_MSH, ARM_SMMU_SH_ISH) |
> >  		FIELD_PREP(CMDQ_SYNC_0_MSIATTR, ARM_SMMU_MEMATTR_OIWB);
> >  
> > +	if (cmdq->type == TEGRA241_VCMDQ) {
> > +		cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_CS, CMDQ_SYNC_0_CS_NONE);
> > +		return;
> > +	}
> > +
> > 	if (!(smmu->options & ARM_SMMU_OPT_MSIPOLL)) {
> > 		cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_CS, CMDQ_SYNC_0_CS_SEV);
> > 		return;
> > @@ -690,7 +695,8 @@ static int arm_smmu_cmdq_poll_until_sync(struct arm_smmu_device *smmu,
> >  					struct arm_smmu_cmdq *cmdq,
> >  					struct arm_smmu_ll_queue *llq)
> >  {
> > -	if (smmu->options & ARM_SMMU_OPT_MSIPOLL)
> > +	if (smmu->options & ARM_SMMU_OPT_MSIPOLL &&
> > +	    cmdq->type != TEGRA241_VCMDQ) {
> >  		return __arm_smmu_cmdq_poll_until_msi(smmu, cmdq, llq);
> >  
> > --------------------------------------------------------------
> > 
> > Would you prefer this one? I feel CMDQ_QUIRK_SYNC_CS_NONE_ONLY
> > is more general looking though..
> 
> And we would need some additional lines of comments for the two
> pieces above, explaining why TEGRA241_VCMDQ type needs the first
> one while bypasses the second one. Again, it feels even worse :(

I hacked the code around a bit this afternoon. Please can you see if:

https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git/log/?h=for-nicolin/grace-vcmdq-wip

does roughly what you need?

Will
