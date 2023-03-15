Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD40F28E2
	for <iommu@lists.linux.dev>; Wed, 15 Mar 2023 08:37:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7222EC433D2;
	Wed, 15 Mar 2023 08:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1678869456;
	bh=4pZA2ch6tMZtoAsHJihB4/kMMVTpVXQpbWpqS2cZx94=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dckC4qvEYe3d7uEI7SeBTortKL1SkyXl6Szt0jwi0qyH5aPBKI4flbehgZDlSWSPf
	 FC8UKmXkvaQ27GSdofKGrsy3goJX4sa6FnC63Om4YlKwOB9nCpuIECrPodW9Gla4L8
	 txYeO4rufnFt9jb/Bfo4FMcBf6QVxu3iiRsQjRDYJir67sLi0uzm5t1vOFyNt5pnX8
	 MHJCU+jg63wkFgc/+MePU9u2ekkwciplsw1VZHsCYacT2JCioJd/hYXdTHpJyIDw/p
	 +5li/y8sNHWl5beB4OCvYcepMuybRmwz8E0OZ7HByoGPoKa7T6pqqh7dwZ4JZanInv
	 ujEuV0+1nr0Kw==
Received: from johan by xi.lan with local (Exim 4.94.2)
	(envelope-from <johan@kernel.org>)
	id 1pcMeg-0004rI-98; Wed, 15 Mar 2023 09:38:42 +0100
Date: Wed, 15 Mar 2023 09:38:42 +0100
From: Johan Hovold <johan@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: will@kernel.org, joro@8bytes.org, robin.murphy@arm.com,
	andersson@kernel.org, johan+linaro@kernel.org, steev@kali.org,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iommu/arm-smmu-qcom: Rework the logic finding the
 bypass quirk
Message-ID: <ZBGEEk1d1WtNq4lT@hovoldconsulting.com>
References: <20230314184659.176473-1-manivannan.sadhasivam@linaro.org>
 <ZBF1vFBWKXhHeD2v@hovoldconsulting.com>
 <20230315075958.GC25575@thinkpad>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230315075958.GC25575@thinkpad>

On Wed, Mar 15, 2023 at 01:29:58PM +0530, Manivannan Sadhasivam wrote:
> On Wed, Mar 15, 2023 at 08:37:32AM +0100, Johan Hovold wrote:

> > > +static int qcom_smmu_cfg_probe(struct arm_smmu_device *smmu)
> > > +{
> > > +	u32 smr;
> > > +	int i;
> > > +
> > > +	/*
> > > +	 * Limit the number of stream matching groups to 128 as the ARM SMMU architecture
> > > +	 * specification defines NUMSMRG (Number of Stream Mapping Register Groups) in the
> > > +	 * range of 0-127, but some Qcom platforms emulate more stream mapping groups. And
> > > +	 * those groups don't exhibit the same behavior as the architecture supported ones.
> > > +	 */
> > 
> > Please fix your editor so that it wraps lines at 80 columns, which is
> > still the preferred (soft) limit.
> > 
> 
> If exceeding 80 columns end up making the comment more readable (fewer lines),
> then why should we limit ourselves?

Exceeding 80 column for comments does generally not improve readability.

That part of the coding standard has do to with not adding excessive
line breaks to *code*, where it can sometimes impact readability.

> > > +	if (smmu->num_mapping_groups > 128) {
> > > +		dev_warn(smmu->dev, "\tLimiting the stream matching groups to 128\n");
> > 
> > dev_notice() should do since there's nothing a user can do about this.
> > 
> 
> Ok.
> 
> > > +		smmu->num_mapping_groups = 128;
> > > +	}
> > 
> > So this hunk is really all that is needed to make the current quirk
> > detection work on sc8280xp. Why not simply stick with the current logic
> > and use the last group until there is a need for anything more?
> > 
> 
> No! What if the bootloader had set up mapping for 128 groups? In that case
> we'll overwrite the last group. It is still required to find the valid group
> and use it for quirk detection. If no group is available, we'll skip it.

Yes, but that's also entirely hypothetical (and could perhaps also be
handled by adding a warning for now).

If you want to rework the quirk handling for this you should at least do
so in a separate patch as it is arguably a separate change from fixing
the current quirk detection for newer SoCs by capping the number of
groups (a minimal fix that could be backported).

Johan
