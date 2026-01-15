Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0654C81;
	Thu, 15 Jan 2026 17:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768498786; cv=none; b=M4ppo+xZWCLOTf6m4ZvE9BehLumgc66N8tFN6wKQJRgjVF64CCZMYjsyZkCAiQU/rsHPju0qhW8Ss11OAa5WRauWBpBYnMF+IkdvzCwuyJ8a45AUcZKqy+Ie5zzTDJCHzveEH0b06G1z2qRJE0Ho5GSOz2KIH+JA3/jHUnZu/78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768498786; c=relaxed/simple;
	bh=a6/X1t8L0qNQd5yg44gvVji3t1zPDsjlgcQE1oWRzPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uKaAJyO4Fwn01gw1RISWCPwkYYqn9GoZ9hJdwDcAIVdSRRfa8QGBUnfAtJ0oOVr+/AX8sN/cnyQpReksQEx6q0jgXELwNkcdLcOUjsBm8Hp642FTdhvlJI13ss6SxPEoorjePUBFaj5F95h0s7pO8OEaFePVNko7QUKcSrJykws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=insltMEp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="insltMEp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F44AC16AAE;
	Thu, 15 Jan 2026 17:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768498785;
	bh=a6/X1t8L0qNQd5yg44gvVji3t1zPDsjlgcQE1oWRzPI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=insltMEpWD6PLV8h8pViaGhH1c14y2bvOlACnYGLmDNzxsVGB9oPiTg3wd1c9zveL
	 ClmFMJlW2V7hUF0Ci3DV22lK+ndP60Bk9/Uv6u3ucj1PSrPZVyY2+vnnI6PIJwBTHj
	 VJ/EahRk84rF2jr0bFP2YUFJzBnX9LUv/HfisDZIVlcppoEbUHl/FI/zpAQcZjpa+u
	 JHjGdCDLAamVp3jF0AKiaWYPVadUK2oAjbJF7uWd24t0PiRLy99c623fZkLxUDEkz4
	 aPhnH12YLAHczc0tdG57myQCmLl9UZt6ms2m/DQkw30GDOa7jXqTXLCfl1zz3IATov
	 YlVGESyPjRs+Q==
Date: Thu, 15 Jan 2026 17:39:40 +0000
From: Will Deacon <will@kernel.org>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, robin.murphy@arm.com, joro@8bytes.org,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, skolothumtho@nvidia.com,
	praan@google.com, xueshuai@linux.alibaba.com, smostafa@google.com
Subject: Re: [PATCH rc v5 1/4] iommu/arm-smmu-v3: Add update_safe bits to fix
 STE update sequence
Message-ID: <aWkmXO2GBj00AVwy@willie-the-truck>
References: <20260112161010.GC812923@nvidia.com>
 <aWVETpwlx9Rhs8Kw@Asurada-Nvidia>
 <aWZfUNXEka3GBf9s@willie-the-truck>
 <20260113161253.GG812923@nvidia.com>
 <aWarF90zBqxD0Gef@Asurada-Nvidia>
 <20260113205112.GJ812923@nvidia.com>
 <20260115131151.GA1081267@nvidia.com>
 <aWkU4a1wj5jsWFev@Asurada-Nvidia>
 <20260115162919.GG961588@nvidia.com>
 <aWkXIyvmPiJoyRtf@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aWkXIyvmPiJoyRtf@Asurada-Nvidia>

On Thu, Jan 15, 2026 at 08:34:43AM -0800, Nicolin Chen wrote:
> On Thu, Jan 15, 2026 at 12:29:19PM -0400, Jason Gunthorpe wrote:
> > On Thu, Jan 15, 2026 at 08:25:05AM -0800, Nicolin Chen wrote:
> > > On Thu, Jan 15, 2026 at 09:11:51AM -0400, Jason Gunthorpe wrote:
> > > > On Tue, Jan 13, 2026 at 04:51:12PM -0400, Jason Gunthorpe wrote:
> > > > > > -       safe_bits[1] |= cpu_to_le64(STRTAB_STE_1_EATS);
> > > > > > +       if (!((cur[2] | target[2]) & cpu_to_le64(STRTAB_STE_2_S2S)))
> > > > > > +               safe_bits[1] |= cpu_to_le64(
> > > > > > +                       FIELD_PREP(STRTAB_STE_1_EATS, STRTAB_STE_1_EATS_TRANS));
> > > > > > --------------------------------------------------------------------------
> > > > > > 
> > > > > > @will, does this look good to you? I can send a v7 with this.
> > > > > 
> > > > > That is an easy way to address Will's observation, makes sense to me.
> > > > 
> > > > Ah, but it looks like it can generate an errant view of a EATS that is
> > > > neither old or new. Ie value 3, reserved.
> > > > 
> > > > I think you should just check if old or new has EATS bit 1 set:
> > > > 
> > > > if (!((cur[2] | target[2]) & cpu_to_le64(STRTAB_STE_2_S2S)) &&
> > > >     !((cur[1] | target[1]) & cpu_to_le64(FIELD_PREP(STRTAB_STE_1_EATS, 2))))
> > > > 
> > > > Which the current driver never does..
> > > 
> > > The EATS field is completely controlled by the driver. So, we are
> > > safe for now, right?
> > > 
> > > Should we add this when the driver has the actual support for the
> > > split stage thing?
> > 
> > If we have figured it out now I would add it because it would be a big
> > leap to think the next person will remember about this detail..
> > 
> > But yes, this and the S2S thing don't effect the driver as it is now,
> > it is just doing work to help future people.
> 
> OK. Let's add that.
> 
> I will send the v7 by the end of the day. Hopefully, Will is okay
> with all of these..

Sounds about right but I'll wait and see what you post.

Will
