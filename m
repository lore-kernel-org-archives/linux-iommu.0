Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E452C3F7A86;
	Wed, 13 May 2026 11:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778672573; cv=none; b=Zcc1CH5wO0WBnjlJLCfN1QEbERcL/qLmDMzxE8I0Q/W57Tucu0b0TBkxHyZdIwXyx6Nbug27PxO7bz5iURJkKi202+dA5Hn3ozJjIqrijgMnStUZlun+/MYb/ceYa0HWIQHSYD44xRYaul+NhE26b2mI7N5A0rZIzvZ423QX5/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778672573; c=relaxed/simple;
	bh=T/hMoqdB3DpsRaIFxt+BsXP6bpACkEz0kdhTLtsGWEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TOLHdoCR5JN/kCKsUk2TawL1z1ZPDx2rGpiA6+G11ynLPfJIIF72kggonJajHliZtJo4np5tFGbyZ0AhmjqaLbxFpKSrnjPOuj0bqfHxoirWUQX6seSXPwA7EQUYMMDBF3vftpMgLJu32IRQn5Q3C851YpqtzqM3CgHVycgZVZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=esWEyxyl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="esWEyxyl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6188BC2BCB7;
	Wed, 13 May 2026 11:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778672572;
	bh=T/hMoqdB3DpsRaIFxt+BsXP6bpACkEz0kdhTLtsGWEA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=esWEyxylzWvSk9kCrla2ZTeFYMPizGk/9rcmhaTaCaxOUN1V6DOuS06X7f29fb8Zg
	 gcJgiopDKI2041w+ccO/ID00lfQhSylGIaBoFYqSI/csKLXUx+NUb96ItfDA4NKMyP
	 AF6kkhwwrnf2iUY+yDSukq7/ezyyej8mO/NtWrbtXMhmLhNwr9XboavgZGx9DoTiS7
	 gxc1jatxQNiqzzPI0ZSWpv8INKn+DfIYmjG4aR3fgFPSJbWxeVMqy8lA9fVtCMfbBY
	 1U5UUwtshZI1ccxJyd/c1e+jzu/6Aq6aIBPJdh+/XJ65iE7l8hCK955YIm28TJYF/a
	 0BxTpGTAvSjuw==
Date: Wed, 13 May 2026 12:42:47 +0100
From: Will Deacon <will@kernel.org>
To: Pranjal Shrivastava <praan@google.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Joerg Roedel <joro@8bytes.org>,
	Jean-Philippe Brucker <jpb@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	=?utf-8?Q?Miko=C5=82aj?= Lenczewski <miko.lenczewski@arm.com>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/arm-smmu-v3-sva: Enable Hardware Access and
 Hardware Dirty bits
Message-ID: <agRjt9XpN66ktdk9@willie-the-truck>
References: <20260503135413.1108138-1-nicolinc@nvidia.com>
 <af0SdkjQOZxnnaQb@google.com>
 <20260508123550.GB9254@nvidia.com>
 <af3hWGp3etGOIdEn@google.com>
 <f31043cc-45dd-457f-8031-0cef51c9470e@arm.com>
 <af3ryl7G58D2GeWr@google.com>
 <4e129891-2f52-4bac-8e33-1fdde42fd29a@arm.com>
 <af7oyeleKFXpcIKu@nvidia.com>
 <agHYDxuYyqzmAfy5@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agHYDxuYyqzmAfy5@google.com>

On Mon, May 11, 2026 at 01:22:23PM +0000, Pranjal Shrivastava wrote:
> On Sat, May 09, 2026 at 12:56:57AM -0700, Nicolin Chen wrote:
> > On Fri, May 08, 2026 at 03:24:32PM +0100, Robin Murphy wrote:
> > > On 2026-05-08 2:57 pm, Pranjal Shrivastava wrote:
> > > > I see, so IIUC, you mean if IS_ENABLED(CONFIG_ARM64_HW_AFDBM) but CPU
> > > > doesn't enable HTTU, it is perfectly safe to let the SMMU do HTT updates,
> > > > Since the fault handlers are already expecting HW-triggered updates?
> > > > 
> > > > Which means our check would be something like:
> > > > 
> > > >     if (IS_ENABLED(CONFIG_ARM64_HW_AFDBM) {
> > > >     	if (smmu->features & FEAT_HA)
> > > > 	 ...
> > > >     }
> > > > 
> > > > instead of cpu_has_hw_af()?
> > > 
> > > Hmm, looking closer, cpu_has_hw_af() is the thing which actually influences
> > > mm behaviour (via arch_has_hw_pte_young and arch_wants_old_prefaulted_pte),
> > > and that can still be false at runtime if ARM64_HW_AFDBM is enabled but any
> > > CPU doesn't support HAFDBS, so perhaps you were right the first time :)
> > 
> > IIUIC, v2 should be:
> > 
> > +		/*
> > +		 * Enable Hardware Access and Dirty updates (DBM) if supported by
> > +		 * both the SMMU and the CPU. It is unsafe to enable SMMU's HTTU,
> > +		 * if the CPU does not support it as it bypasses mm page aging.
> > +		 */
> > +		if (cpu_has_hw_af()) {
> 
> Ack, yes. IMO, this is the correct system-wide gate.

Hmm, I'm not so sure :/

cpu_has_hw_af() doesn't take into account CPUs with broken DBM and, in
fact, ID_AA64MMFR1_EL1.HAFDBS allows support for AF to be advertised
without support for DBM.

Having said that, I don't understand why we need to care about the CPU
support. The comment above states:

  "It is unsafe to enable SMMU's HTTU, if the CPU does not support it as
   it bypasses mm page aging."

but I don't understand what that "bypassing" means. vmscan should still
pick up the correct state from the page-table, so what's the problem?

Will
