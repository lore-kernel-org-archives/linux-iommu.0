Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A53364926
	for <iommu@lists.linux.dev>; Sun, 26 Jul 2026 12:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785067244; cv=none; b=RxvwW4hzuJhq4++SjS+Rbh0mfVpte7doNF+CpTxSCHvb969LwXHkutZLlftNK5wa2SwCz58VcKmiyAK9V6GW50ZphijH0bLd40dEd9EP3YjBLe1LNdRQphvy/6aXbI/EnFs9gYrKRr+VqAxqOHVJqMzUoXtsJ2A+vsn99cJO6pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785067244; c=relaxed/simple;
	bh=NJ2AaPCmEKK2Hx40ni0jApLwRDKXOInS/BBlt4+0yk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HqGBh/xuiAv+DImKfakHmEphbmsxcMEdYYuAt+uU2QTT7oG6y8KmeUzqC/i/T4ts69ldTUAsjhE1axBnYYBCK3j9rWNEQunqUo8a4iIVLbuBytxcp0QjIgsyfFOQmMXynRvi24OVU0ynJ7FhYkw9o7pnqN/yNBQb+lG1unvddWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QcI+gSjr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QcI+gSjr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8757B1F00A3D;
	Sun, 26 Jul 2026 12:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785067243;
	bh=PiosQTu8baA+WXCpacOsGlT6To8H67hjURXJziEm3mg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QcI+gSjrWnphZnhrzYSfQmSsBHbX+Iv9Zb5ccq+lmXibhlcIg9ce0RyEX/3oisCJr
	 RROrJvDeoCctBLrEGppGdG46XkJlAU2TBCaenMyDp1ovjXyNaylqxfdZ86REottiz1
	 lJ/Ib4QH4UBK4F+LT7PIiANe4zj6i1PfbF8OPb1tqkB4QFesDsmZTw52Rjo/ELBKLf
	 EbRXg8Rn2JHiImHNFNiIsRgrDqix5FOPhFyLiXbVefU9k9PvS13LKU3dt0J6Rlu2Ev
	 LtWIZ5SEc90Rpp5Sn7r5h4pH0eUtTpmrKnDQcgxzGIhwydc6o0XOyWeH6/nqS4Hld/
	 8TrCAxX/v2dvA==
Date: Sun, 26 Jul 2026 13:00:38 +0100
From: Will Deacon <will@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Robin Murphy <robin.murphy@arm.com>, catalin.marinas@arm.com,
	joro@8bytes.org, jpb@kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/2] iommu/arm-smmu-v3: Add HAFT support for SVA
Message-ID: <amX25rcF-ETdnUPj@willie-the-truck>
References: <cover.1784814923.git.robin.murphy@arm.com>
 <57ae366ec501a142bd20f2cc7d18b3eca8eeac25.1784814923.git.robin.murphy@arm.com>
 <amTH7xHBY2ol4LHw@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amTH7xHBY2ol4LHw@nvidia.com>

On Sat, Jul 25, 2026 at 11:27:59AM -0300, Jason Gunthorpe wrote:
> On Thu, Jul 23, 2026 at 03:19:44PM +0100, Robin Murphy wrote:
> > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> > @@ -102,6 +102,8 @@ void arm_smmu_make_sva_cd(struct arm_smmu_cd *target,
> >  			target->data[0] |= cpu_to_le64(CTXDESC_CD_0_TCR_HA);
> >  		if (master->smmu->features & ARM_SMMU_FEAT_HD)
> >  			target->data[0] |= cpu_to_le64(CTXDESC_CD_0_TCR_HD);
> > +		if (master->smmu->features & ARM_SMMU_FEAT_HAFT && system_supports_haft())
> > +			target->data[1] |= cpu_to_le64(CTXDESC_CD_1_HAFT);
> >  	} else {
> >  		target->data[0] |= cpu_to_le64(CTXDESC_CD_0_TCR_EPD0);
> 
> Based on the Sashiko remark and your note you should lift all the
> HA/HD/HAFT bits outside this if (mm) block.
> 
> AFAICT it is fine for HA/HD/HAFT to be set with EPD0, the HW won't
> process any PTEs so they won't have any effect.

I'm not sure about that. The spec says this about CD.HAFT:

| If CD.HA is 0 and not IGNORED, it is ILLEGAL to set this field to 1
| and this results in C_BAD_CD.

so the question is whether or not CD.HA is IGNORED when EPD0 is set, and
I couldn't find anything to suggest that is the case (which kinda makes
sense, given that there are two TTBs).

As a last resort, I tried to parse the pseudocode for C_BAD_CD (based on
CdIllegal() in "5.4.2 Validity of CD")...

It looks like EPD0 gets wrapped up in 'n_transl_cfg0', but that's not
used at all in the relevant check (you need to skip past the first few
bits, but I've included them for completeness):


// Check CD.HA, CD.HD, CD.HAFT
if !using_vmsa32 &&
    // The following conditions are ILLEGAL when VMSAv8-64 or
    // when VMSAv9-128 are used.
    // No flag updates supported, but CD wants to update flag
    (((CD.HA == '1' || CD.HD == '1') && (SMMU_IDR0.HTTU == '00')) ||

    // Only access flag update suppported, but CD updates dirty flag
    (CD.HD == '1' && SMMU_IDR0.HTTU == '01') ||

    ** LOOK HERE! This is the relevant part: **

    // Hardware update of AF in Table descriptors is supported and enabled,
    // but update of AF in leaf descriptors is not enabled
    (SMMU_IDR0.HTTU == '11' && CD.HAFT == '1' && CD.HA == '0')) then

  return TRUE; // Invalid


so I think your options are either:

1. Use the cmdline option that Robin is adding so that you can disable
   HAFT altogether.

- or -

2. We could disable HAFT first, and then do the hitless transition.

(2) means we can miss table AF updates during that window, but I think
that should be fine?

Will
