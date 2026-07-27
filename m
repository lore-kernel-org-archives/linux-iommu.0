Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F9F368D42
	for <iommu@lists.linux.dev>; Mon, 27 Jul 2026 08:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785139981; cv=none; b=oMg2HWgtYjb7tF3l395+RDNKHtgQzlZhLXUN64pKMMV12btz0t8dENMgWpKL6gtB0TCPh78nU/K8augjTMBdB4ZsHqwobEi36rRPHukR3SudD1t297T2v2NV/TpAIb7ruNdArNYkQjv3syr1kz9VS48wHYODgpQ6cB+ReBgvHn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785139981; c=relaxed/simple;
	bh=kbHJIPJ7x9nRjIym1XHLFNhbMagzeFzaEueO/Wygejw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=groGhGgIoTbFz1EMsQWKZIx/DoZj8JAWIfKUqARr0187ctv0xx0ttHzQHvSC8UH+VmK9dPeaDHv8oTQ5/dN/qwwjsRRFIjYdKmJIiIE9uuV7UnnhpP7npglFy3DdLO3PNUM6crTikpQcg5ruMpDOfhT7TiCTdhzS936QPV9s+wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=He1e+qXx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="He1e+qXx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A3621F000E9;
	Mon, 27 Jul 2026 08:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785139979;
	bh=OqVw4hn9qYQIGv2zQRg01CGwV4FIX3vH2ne+HmEOylA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=He1e+qXxG78Mw62hrMKR8jcgC9E9ssqW84dJxLuuSAv3qeEybPnW/d41RnvjZfoY6
	 UIz8SQXAtd3ePejXZdLJs3Bb4/dcfdmABQwALQEFqRu1dJUMkvXQKp6RlmVP1CUl3h
	 3mm9byXkbnhPGu8/H0Vxo8u9LQ+8POYboTHGK0GVDBQKpAJLL+aT40cbX/FFtGK3GV
	 V8TwASDhXKeTy4VAdM/UnnDgJixTtvaAcj4ftV1vrG8lj0KDHRslFCN7ynrWOv+05w
	 Ivt9rvwEa29xBs1WaOn4Rv12YxHRZiJcpXjo8KIC0yLEP37BBqngmhsSQIf4V80AGM
	 L1vH5wRJ9yzxQ==
Date: Mon, 27 Jul 2026 09:12:54 +0100
From: Will Deacon <will@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Robin Murphy <robin.murphy@arm.com>, catalin.marinas@arm.com,
	joro@8bytes.org, jpb@kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/2] iommu/arm-smmu-v3: Add HAFT support for SVA
Message-ID: <amcTBlw16RKuZC8y@willie-the-truck>
References: <cover.1784814923.git.robin.murphy@arm.com>
 <57ae366ec501a142bd20f2cc7d18b3eca8eeac25.1784814923.git.robin.murphy@arm.com>
 <amTH7xHBY2ol4LHw@nvidia.com>
 <amX25rcF-ETdnUPj@willie-the-truck>
 <amYxa51b2j/Cdw/6@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amYxa51b2j/Cdw/6@nvidia.com>

On Sun, Jul 26, 2026 at 01:10:19PM -0300, Jason Gunthorpe wrote:
> On Sun, Jul 26, 2026 at 01:00:38PM +0100, Will Deacon wrote:
> > On Sat, Jul 25, 2026 at 11:27:59AM -0300, Jason Gunthorpe wrote:
> > > On Thu, Jul 23, 2026 at 03:19:44PM +0100, Robin Murphy wrote:
> > > > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> > > > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> > > > @@ -102,6 +102,8 @@ void arm_smmu_make_sva_cd(struct arm_smmu_cd *target,
> > > >  			target->data[0] |= cpu_to_le64(CTXDESC_CD_0_TCR_HA);
> > > >  		if (master->smmu->features & ARM_SMMU_FEAT_HD)
> > > >  			target->data[0] |= cpu_to_le64(CTXDESC_CD_0_TCR_HD);
> > > > +		if (master->smmu->features & ARM_SMMU_FEAT_HAFT && system_supports_haft())
> > > > +			target->data[1] |= cpu_to_le64(CTXDESC_CD_1_HAFT);
> > > >  	} else {
> > > >  		target->data[0] |= cpu_to_le64(CTXDESC_CD_0_TCR_EPD0);
> > > 
> > > Based on the Sashiko remark and your note you should lift all the
> > > HA/HD/HAFT bits outside this if (mm) block.
> > > 
> > > AFAICT it is fine for HA/HD/HAFT to be set with EPD0, the HW won't
> > > process any PTEs so they won't have any effect.
> > 
> > I'm not sure about that. The spec says this about CD.HAFT:
> 
> Sorry I see this was unclear
> 
> I ment to move all *three* bits outside the if.
> 
> There is no reason for EPD0 to also require setting any of those three
> bits to zero, AFAICT.

Ah, gotcha! And even if we did want to get to that configuration, I
guess you could set EPD0, then clear HAFT, then clear HA+HD?

Will
