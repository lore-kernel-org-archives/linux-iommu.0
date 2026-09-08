Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E65E548579;
	Tue,  8 Sep 2026 19:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788897398; cv=none; b=CpY8iogyAuRY7zaVO68WBiH1p0naML+hfir3yu9dZAitoubPu+pY7weBeN9nTKUdGt/d4gtJvwkbjoxIG2gtZc2JKtvMaj7AXyus0jv9t2345//PzSnPk+6Hy5mf8hB+/ALwDZTuxdYZrCz8noJB1BRuaWs98o0aN2UC00JRewI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788897398; c=relaxed/simple;
	bh=dhRmcjWikcj4PTT48pa64UM3Z3XiVBej7nBKNxMNLSk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=g+44SO6A6hT6AfdP2k6ILSlAzRWK9PC9Lxam1hSUQlwhoJhSCR7ayQnmyUqNwvR2+LRpN5XVZ4uR/mgKFxihNCWggDqtpAonTwzwTegjJO8YTVcWFObPdqG3kAJCk6CEeYcYzMyKcyIzB1Jg/hi8TZYgbNPj/sjAp0JXSJlOB4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ei5MZjQh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ei5MZjQh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7725C1F00A3A;
	Tue,  8 Sep 2026 19:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788897397;
	bh=vXhWQw22vhXAQ2gomRzDVD1jyGqiKml9QCCpuAJzC6k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=ei5MZjQhnv1BJZ4J4jb+4yGVs4QfDIeXmSd/v+LcQAbS04thRvfCeILdLXHdDOo5l
	 cB1cEzL4ZurUh5asediffjsprVN3X6WBt7/6JezEycGc5SvgBN5ywWYRCYJAobIwGR
	 EvwzGcSvoLr74k8E3DDlGgJ9Ys+xyEBEfTdRxVEnBoz+H5WdPhhL8ID5XsK4kGv4XS
	 p3f1JVoI+nWUkaHlynnHrITNae9llhsy44HndAPOvYcwjMWk221vRFffnsFXDEvoG7
	 UEgpkq7u2iC6Lhz6GkyhOJYm2R66XREDjqkp6y6YLdWa0RuKxJPfKmX2S/sK3OkxxB
	 ggHUaEijiRGYg==
From: Thomas Gleixner <tglx@kernel.org>
To: Pranjal Shrivastava <praan@google.com>, iommu@lists.linux.dev
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, Robin
 Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Mostafa
 Saleh <smostafa@google.com>, Nicolin Chen <nicolinc@nvidia.com>, Daniel
 Mentz <danielmentz@google.com>, Ashish Mhetre <amhetre@nvidia.com>,
 linux-arm-kernel@lists.infradead.org, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, rafael@kernel.org, Danilo Krummrich
 <dakr@kernel.org>, driver-core@lists.linux.dev, Pranjal Shrivastava
 <praan@google.com>
Subject: Re: [PATCH v10 08/15] iommu/arm-smmu-v3: Cache and restore MSI config
In-Reply-To: <20260908171712.356645-9-praan@google.com>
References: <20260908171712.356645-1-praan@google.com>
 <20260908171712.356645-9-praan@google.com>
Date: Tue, 08 Sep 2026 21:56:33 +0200
Message-ID: <87pkyn1pqm.ffs@fw13>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Sep 08 2026 at 17:17, Pranjal Shrivastava wrote:
> +static void __maybe_unused arm_smmu_resume_msis(struct arm_smmu_device *smmu)
> +{
> +	/* Clear the MSI address regs as they reset to unknown value */
> +	writeq_relaxed(0, smmu->base + ARM_SMMU_GERROR_IRQ_CFG0);
> +	writeq_relaxed(0, smmu->base + ARM_SMMU_EVTQ_IRQ_CFG0);
> +
> +	if (smmu->features & ARM_SMMU_FEAT_PRI)
> +		writeq_relaxed(0, smmu->base + ARM_SMMU_PRIQ_IRQ_CFG0);
> +
> +	if (!(smmu->features & ARM_SMMU_FEAT_MSI))
> +		return;
> +
> +	if (!smmu->dev->msi.domain) {
> +		dev_err(smmu->dev, "msi_domain absent during resume\n");
> +		smmu->features &= ~ARM_SMMU_FEAT_MSI;
> +		return;

If dev->msi.domain == NULL then arm_smmu_setup_msis() already cleared
the MSI feature bit. Has it magically been set again or does resume run
before init or does dev->msi.domain magically disappear during suspend?

I'm all for defensive programming, but this is voodoo and not structured
defense.

Aside of that dev->msi.domain is the patently wrong condition. For
devices which instantiate a MSI device domain dev->msi.domain points to
the MSI parent domain and not to the actual relevant device domain.

You can't query that easily by chasing pointers (for a reason), but
there is no point to do so. See below and the patch I sent you.

> +	platform_device_msi_rewrite(smmu->dev, smmu->gerr_irq, arm_smmu_write_msi_msg);
> +	platform_device_msi_rewrite(smmu->dev, smmu->evtq.q.irq, arm_smmu_write_msi_msg);
> +
> +	if (smmu->features & ARM_SMMU_FEAT_PRI)
> +		platform_device_msi_rewrite(smmu->dev, smmu->priq.q.irq, arm_smmu_write_msi_msg);

And that's exactly the point I made about sprinkling this stuff all over
the place and thereby violating all layering rules.

Done correctly this whole function boils down to:

static void __maybe_unused arm_smmu_resume_msis(struct arm_smmu_device *smmu)
{
	/* Clear the MSI address regs as they reset to unknown value */
	writeq_relaxed(0, smmu->base + ARM_SMMU_GERROR_IRQ_CFG0);
	writeq_relaxed(0, smmu->base + ARM_SMMU_EVTQ_IRQ_CFG0);

	if (smmu->features & ARM_SMMU_FEAT_PRI)
		writeq_relaxed(0, smmu->base + ARM_SMMU_PRIQ_IRQ_CFG0);

        msi_device_domain_restore_msi_msgs(smmu->dev, 0);
}

It just works simply because the function returns early when there is no
domain or the domain is not a MSI device domain, which is correct
because there is nothing to do when nothing is set up.

But that results in too comprehensible code I fear.

Thanks,

        tglx
