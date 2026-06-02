Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3099F367B90;
	Tue,  2 Jun 2026 20:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780431818; cv=none; b=bQtwvALxj75JZfLdQGtSIsgjZFjtHd/60wzsDOJI0pANigCiCPAb+Ihvg9564Pob7DFo86es2+n6OKfVts98aZ+AMozsqnp/oEijNH6RcZ/fyhsR04Ot7A9e9FEsouJ5xz5FsuEf2qaY+d10iS9HBwaHCNGGfL/vQmeFD9bjtAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780431818; c=relaxed/simple;
	bh=1Q/CJx+HN9o4vejMqyfpH525L8Fw4nW4v6e421T9FPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n+mNt+KzGOmgtKsWZsp06DGMtyarVGz+PbNJhniA9Vm16KE7OJW/lxE56Dd/zhVUhZE4Tm8Z/dECVsSLqXhKTlTpJbY0wccoB+oUe23hWmuCaN4kCsKYIPJ3EIrtdYSYz7CLCNgY4P7sZ//jJ5UztH0oCrPh/uVVGY0h1vXOmqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X05LjxQZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X05LjxQZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 118331F00893;
	Tue,  2 Jun 2026 20:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780431816;
	bh=8T+bPLMZWoqhL8S/EBPqCG3UpNlA+kQUaLqUC5F3zUc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=X05LjxQZt769CS8tATWOEckjc8NphbYyYX4uGe6WyqVEo+3s6MVlyIM4imZZL1qNR
	 ceg0IIsFvj4wyTQaeNQVN2SvJqIeNVtnftNTcos9M80cQocLwR4TE6dRDBbGqAEpbo
	 RIojHgU2XwPYBLGAHzgX9qzdOmKF3yIzvffInNeUOmPSTJLODYvIm9Vs7lzHRNCaag
	 WwcjVCefOP+M6EdM8PkYvzHQgJt54lObbGkYuv5aV57cMDRhaE30et5CYlC7S3ZLdp
	 HJOuwHvOnPsBTXaBDTk2cyz1scPJ34iKAhKbzMzbKisTJvGLTueoSlmYXARsFFK6Jz
	 gz8iUSM/muFtw==
Date: Tue, 2 Jun 2026 21:23:32 +0100
From: Will Deacon <will@kernel.org>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Ashish Mhetre <amhetre@nvidia.com>, robin.murphy@arm.com,
	joro@8bytes.org, jgg@ziepe.ca, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH v3 1/3] iommu/arm-smmu-v3: Factor out CMDQ batch
 force-sync conditions
Message-ID: <ah87xDqLJ9bU5f1u@willie-the-truck>
References: <20260601104845.995005-1-amhetre@nvidia.com>
 <20260601104845.995005-2-amhetre@nvidia.com>
 <ah81HhVW7_h9xyDM@willie-the-truck>
 <ah84OmisAm8805FT@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ah84OmisAm8805FT@Asurada-Nvidia>

On Tue, Jun 02, 2026 at 01:08:26PM -0700, Nicolin Chen wrote:
> On Tue, Jun 02, 2026 at 08:55:10PM +0100, Will Deacon wrote:
> > On Mon, Jun 01, 2026 at 10:48:43AM +0000, Ashish Mhetre wrote:
> > > From: Nicolin Chen <nicolinc@nvidia.com>
> > > 
> > > arm_smmu_cmdq_batch_add_cmd_p() carries two distinct reasons for
> > > flushing the current batch with a CMD_SYNC before appending the
> > > new command:
> > > 
> > >   - The batch's pre-assigned cmdq does not support the new command.
> > >   - The Arm erratum 2812531 workaround (ARM_SMMU_OPT_CMDQ_FORCE_SYNC)
> > >     forces a SYNC at one entry before the batch is full.
> > > 
> > > Lift those checks into a new arm_smmu_cmdq_batch_force_sync() helper
> > > so that adding another force-sync condition becomes a one-line
> > > addition. No functional change.
> > > 
> > > Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> > > Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
> > > ---
> > >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 26 ++++++++++++++++-----
> > >  1 file changed, 20 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > > index 9be589d14a3b..4d29bd343460 100644
> > > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > > @@ -847,16 +847,30 @@ static void arm_smmu_cmdq_batch_init_cmd(struct arm_smmu_device *smmu,
> > >  	cmds->cmdq = arm_smmu_get_cmdq(smmu, cmd);
> > >  }
> > >  
> > > +static bool arm_smmu_cmdq_batch_force_sync(struct arm_smmu_device *smmu,
> > > +					   struct arm_smmu_cmdq_batch *cmds,
> > > +					   struct arm_smmu_cmd *cmd)
> > > +{
> > > +	if (!cmds->num)
> > > +		return false;
> > 
> > This check seems new?
> 
> You are right. Maybe the commit message should have mentioned that
> there is a slight behavior change to the unsupported_cmd path:
> 
>  - Before: if cmds->num = 0 && unsupported_cmd, it would issue an
>            empty batch (one CMD_SYNC)
>  - After : if cmds->num = 0, no issue on the empty batch
> 
> With that, I think it's good to have?

It just shouldn't be part of the refactoring patch with "no functional
change". Do it in the patch that needs it and explain why it's needed.

Will
