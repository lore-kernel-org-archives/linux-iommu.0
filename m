Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027A61DF272
	for <iommu@lists.linux.dev>; Tue,  8 Oct 2024 13:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728394598; cv=none; b=UVwIsFjM5j1RL/e/I4Fkln2v3FpX4AxjfhlSIqYZogCJKtjjwSA365R0gZ+jUz0hOCdNcvS7fWp+2MVWCh6D4ACujljekDAJ/H0W/J8UFKOgUjFBmrQ7Rm9en6M3Yr92eT0i2PM25vD+VZ5Rk7pgxHxG/0062jhmge2lOVbVHqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728394598; c=relaxed/simple;
	bh=PuIYzcysAfSHnSCThrVlJX4qjVPu9JSnwDtckBrbmjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WZoWNLYx1MvXF1Ckk9vPU7fjZIG7dqbLdLXutYJ6a97huRxI/7vCSF01BaLV+5lbH9fCMTm9piZDgQBTQAFHGQ2XcuwAstoQzOP0ZCFfoV6+odSNG5uXc4xMREinUIfHSoSOEA0Lxnhaf/KGbcPZ5PWnt+qQZRgCnTFkyWvljYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e8dwyEOm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e8dwyEOm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD646C4CECC;
	Tue,  8 Oct 2024 13:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728394597;
	bh=PuIYzcysAfSHnSCThrVlJX4qjVPu9JSnwDtckBrbmjU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e8dwyEOm6u2oJiFAMawRmQZwZVydXtiZIJpD9aHwZm7cJX0gEAq7T7Mj49TI4vVwI
	 p8GVTi8/4ZhgL0Y5EXlvGUK62rHO7JwUPynT1hgxH/4pLWh53r1yDmSU1Fo/IoGBFz
	 WzF3madCSfj8iIlRlLxMsmIEvWp2eSK42XaSC0zoZIyOHNs+wz0MbXnMzR1XuLaflB
	 ETFHAIOOrLR5HzE0kPkTiYOxaQkM0++t9zSUvGXklVzPS6UHUNEot+TWjbyzKSBm9r
	 Ztb4x+ikKl6Sy8umDNbiN8S7HvBVzL+pfFyOuutzsAuB+akO5AhRupNR2g/I+JbvXC
	 LofaRN7yO0YLw==
Date: Tue, 8 Oct 2024 14:36:33 +0100
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: joro@8bytes.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] iommu/arm-smmu: Clarify MMU-500 CPRE workaround
Message-ID: <20241008133633.GB10474@willie-the-truck>
References: <467590c40029ef0712b1fd38f2928fd4f08d09af.1726232138.git.robin.murphy@arm.com>
 <7c426dc0-4fde-4d1e-bb91-538984bd8b59@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c426dc0-4fde-4d1e-bb91-538984bd8b59@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Fri, Sep 13, 2024 at 04:13:29PM +0100, Robin Murphy wrote:
> On 2024-09-13 1:55 pm, Robin Murphy wrote:
> > CPRE workarounds are implicated in at least 5 MMU-500 errata, some of
> > which remain unfixed. The comment and warning message have proven to be
> > unhelpfully misleading about this scope, so reword them to get the point
> > across with less risk of going out of date or confusing users.
> > 
> > Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> > ---
> >   drivers/iommu/arm/arm-smmu/arm-smmu-impl.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c b/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c
> > index 9dc772f2cbb2..2edb1c1658ad 100644
> > --- a/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c
> > +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c
> > @@ -130,7 +130,7 @@ int arm_mmu500_reset(struct arm_smmu_device *smmu)
> >   	/*
> >   	 * Disable MMU-500's not-particularly-beneficial next-page
> > -	 * prefetcher for the sake of errata #841119 and #826419.
> > +	 * prefetcher for the sake of at least 5 known errata.
> >   	 */
> >   	for (i = 0; i < smmu->num_context_banks; ++i) {
> >   		reg = arm_smmu_cb_read(smmu, i, ARM_SMMU_CB_ACTLR);
> > @@ -138,7 +138,7 @@ int arm_mmu500_reset(struct arm_smmu_device *smmu)
> >   		arm_smmu_cb_write(smmu, i, ARM_SMMU_CB_ACTLR, reg);
> >   		reg = arm_smmu_cb_read(smmu, i, ARM_SMMU_CB_ACTLR);
> >   		if (reg & ARM_MMU500_ACTLR_CPRE)
> > -			dev_warn_once(smmu->dev, "Failed to disable prefetcher [errata #841119 and #826419], check ACR.CACHE_LOCK\n");
> > +			dev_warn_once(smmu->dev, "Failed to disable prefetcher for errata workarounds, check ACR.CACHE_LOCK\n");
> 
> Come to think of it, this should probably also refer to SACR rather than
> ACR, given that we already *have* attempted to program the Non-Secure
> side...

I'm happy to pick up a v2 with that change.

Cheers,

Will
