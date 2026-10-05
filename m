Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D2336494B;
	Mon,  5 Oct 2026 08:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791187823; cv=none; b=GwJxZMk/y6slwexFBUt56hD6KOHGXHu1ZAYkCgllukI7B8rlomO026mjQol5rUkOON774fzRhVnpPBEHyd4MdcU6TIWCFCIRAxjMIHHgdSV0uUlDNlocDhbQs1yY5jH89GQwodjcREany4VW81Njyywo/z06sxq/pqr67Ine6cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791187823; c=relaxed/simple;
	bh=ZMw6i41rO6iUxejWmQxYHn8MfPvI9BAjqA7hWaTUEGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CWKRRD3LIbsyDrByRXRZGKCqH9sH9vieE2TR9P3YMPs8coOm05m5egWmvWmyhAIp+pR+aKWyoidX4dpySoxWU8flC1koFYOYwffjfYXD803PlX2lKo6BJye8kuO6yWyIrwjUc1q2hCnx0pcU3tMv6PPHhsx076azb2RU683DVR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QM6ZpukN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QM6ZpukN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53BAE1F000FF;
	Mon,  5 Oct 2026 08:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791187821;
	bh=bmXtqj+1EA0qDhQoy1XIX6T58V/e4lq7osWmqeeZ2Hk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QM6ZpukNaBa0mMOKa2As+65ti10BFgYsZUzdYn4GwdAXeBa5+9hiN7+C7QCJ9VSf0
	 OAL7AvS2NvTbWJi6ro0XjPZAsSVPeyWC/MDDhuvtAPxSy7jfereEdIMEJIFoY6x15t
	 0TRNDEDcSxbNdqSmioVDHLCUCtY3lL9g70+WTE1ILG0e1ekpxeYpAKkHKaw3fod7ys
	 54FQt/WJqXoZtjjKoRU516OcXkmGAJ2Hqfo4lmq1iwOL24LGRRXxtxyxTqXLqSfP/8
	 xoA4SnFHq/jL0jMnSB0I6FGNwu1F41LFqREKy7wNPmkFeUcp6zGn3pAy7wvkboDiAz
	 QFAQphdWKHjLA==
Date: Mon, 5 Oct 2026 09:10:15 +0100
From: Will Deacon <will@kernel.org>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: robin.murphy@arm.com, jgg@nvidia.com, joro@8bytes.org, praan@google.com,
	kevin.tian@intel.com, smostafa@google.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, jamien@nvidia.com, kas@kernel.org
Subject: Re: [PATCH v10 06/13] iommu/arm-smmu-v3: Add
 ARM_SMMU_OPT_KDUMP_ADOPT for kdump kernel
Message-ID: <asNbZ93WrbGlm2c3@willie-the-truck>
References: <cover.1788130528.git.nicolinc@nvidia.com>
 <d661395d986d3aa78af200f55e43740996ee8a0f.1788130528.git.nicolinc@nvidia.com>
 <asJTsw-oWDlSqNa3@willie-the-truck>
 <asK7VILK4CgEFjdT@nvidia.com>
 <asNEmjxZ73ezL4I3@willie-the-truck>
 <asNYMpZfyMHakuZ6@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <asNYMpZfyMHakuZ6@nvidia.com>

On Mon, Oct 05, 2026 at 12:56:34AM -0700, Nicolin Chen wrote:
> On Mon, Oct 05, 2026 at 07:32:58AM +0100, Will Deacon wrote:
> > On Sun, Oct 04, 2026 at 01:47:16PM -0700, Nicolin Chen wrote:
> > > On Sun, Oct 04, 2026 at 02:25:07PM +0100, Will Deacon wrote:
> > > > On Sun, Aug 30, 2026 at 04:18:07PM -0700, Nicolin Chen wrote:
> > > > >  drivers/iommu/arm/arm-smmu-v3/Makefile        |   1 +
> > > > >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  21 ++
> > > > >  .../iommu/arm/arm-smmu-v3/arm-smmu-v3-kdump.c | 229 ++++++++++++++++++
> > > > 
> > > > Please don't put this here. The live update / handover stuff is going to
> > > > need very similar logic (see the RFC from Pranjal) and I don't fancy
> > > > having to rename or resplit this file when that comes along.
> > > > 
> > > > Maybe just stick all of arm-smmu-v3-kexec.c and arm-smmu-v3-kdump.c into
> > > > arm-smmu-v3-handover.c or something?
> > > 
> > > Hmm, Pranjal and I already aligned that cleanly. And there is no
> > > further rename/resplit in his series.
> > > 
> > > arm-smmu-v3-kexec: common helpers for both
> > > arm-smmu-v3-kdump: kdump specific (my series)
> > > arm-smmu-v3-liveupdate: liveupdate specific (Pranj's)
> > > 
> > > Each of them is built on a separate config:
> > >  arm_smmu_v3-$(CONFIG_ARM_SMMU_V3_KEXEC) += arm-smmu-v3-kexec.o
> > >  arm_smmu_v3-$(CONFIG_IOMMU_LIVEUPDATE) += arm-smmu-v3-liveupdate.o
> > >  arm_smmu_v3-$(CONFIG_CRASH_DUMP) += arm-smmu-v3-kdump.o
> > > 
> > > If we put everything into one big file, we'd add the two individual
> > > config guards internally, which isn't as clean as currently IMHO.
> > > 
> > > Note that the kdump file has a very long notes (kdump specific).
> > 
> > I dunno, three files seems way over the top for this imo. I'd rather have
> > one (even if it uses preprocessor guards internally) otherwise it just
> > seems inevitable that we'll have random internals exposed from one file
> > to the other, or duplication of logic or both. Even if we end up splitting
> > it eventually, I'd much rather start from a position where everything is
> > in one place.
> 
> OK. I'll merge them, maybe into arm-smmu-v3-kexec as Jason suggested?
> 
> Or do you still prefer handover?

I'm terrible at naming, so I don't mind :)

Will
