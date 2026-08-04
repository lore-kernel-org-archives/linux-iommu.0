Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D033750D5;
	Tue,  4 Aug 2026 14:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785852173; cv=none; b=lpxWcajQCmneQOS2BWOaDsY+28OgnQklQ+a28UE19fs+5+fBCWoMdhsXRutxwg6LcYeg2rlmBnP5f7Y5AsAWZOY1P0tlfHe7jkmsHiOytgb7CSBDXFBzhJIRZ5cy+jOlJj6ixzcri/ZduHNyucd+T9mZ4hj/s/A2g02dvizyxzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785852173; c=relaxed/simple;
	bh=XfgdRca18paaSGjR3Lnw4EhntC0gm/JvcL/d6v8eGTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qFF8el9hPvhq7uigb/krCAQdsr3GUtWoom6VnkUueAF5ue+dpesHZXQs2jVbmyF+4HyszEZnr34uOZP69Pgz+815SF6zTbx1N509yD+4DYqTn4lhAXc2okPxw6ecuJ8PeNV+8w2VIcnHersMjHuF8De/28RWbiAz1hEuPLjwxng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QKVtny8Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QKVtny8Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3024A1F000E9;
	Tue,  4 Aug 2026 14:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785852172;
	bh=+MAienqrEAOlJhiD7pNemSKMb8ZQyWMo7b+Er1Ori+M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QKVtny8Q3EyVD2ltSB1VM7Ncg+d30b038SFRyzF7r/Q0yqw827h7ZZxYubnHUMOX7
	 3QX7QsNqNuSEKspJCuSAokLaCqy4+JZnZX8/1BM/Nv7EXYC9uun2UQA6NtF4IIxiku
	 Tgu3r/ajDa/6w1WP+uCUpDG2c9lQsCkpX1I+Qbsq3nBISsiexpcS7uqXEj0miD32mE
	 c2a94IBsXKdiveu9vpi4lF+rAjqxU/O/VhbWTRbUJA4J7qLoTUiQhEH5nRKKwPv1iG
	 kNVZT/NG06ZhC3ytiD+2n70iXRPbg0c5+ce1PWFSxNv9CyxUgh+Pl1dqAGH6nin6dz
	 WqRAY98ghRxrg==
Date: Tue, 4 Aug 2026 15:02:46 +0100
From: Will Deacon <will@kernel.org>
To: Kiryl Shutsemau <kas@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Pranjal Shrivastava <praan@google.com>,
	Breno Leitao <leitao@debian.org>, Kyle McMartin <jkkm@meta.com>,
	Usama Arif <usama.arif@linux.dev>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iommu/arm-smmu-v3: Shrink command/event/PRI queues in
 kdump kernel
Message-ID: <anHxBh-xGW9JXsa4@willie-the-truck>
References: <20260706084708.8072-1-kas@kernel.org>
 <amiBagGKn-Aym1DK@willie-the-truck>
 <amiz6GQZ-XGlH706@thinkstation>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amiz6GQZ-XGlH706@thinkstation>

On Tue, Jul 28, 2026 at 02:53:16PM +0100, Kiryl Shutsemau wrote:
> On Tue, Jul 28, 2026 at 11:16:10AM +0100, Will Deacon wrote:
> > On Mon, Jul 06, 2026 at 09:47:08AM +0100, Kiryl Shutsemau (Meta) wrote:
> > > All SMMU queues are sized from the maxima the hardware advertises in IDR1,
> > > which can be several megabytes each, and are allocated at probe. The kdump
> > > kernel already disables the event and PRI queues (arm_smmu_device_reset()
> > > drops CR0_EVTQEN/CR0_PRIQEN) but still allocates them at full size. On
> > > systems with many SMMUv3 instances that cost is paid per instance and adds
> > > up to tens of megabytes of coherent DMA in the capture kernel.
> > > 
> > > A kdump capture kernel runs from a small crashkernel reservation and only
> > > has to drive the few devices used to save the dump, so deep queues serve
> > > no purpose. The queues are not on the DMA data path, so dump throughput is
> > > unaffected; a shallower command queue only bounds how many commands may be
> > > in flight before a sync, which does not matter for the capture kernel's
> > > small device count and modest I/O.
> > > 
> > > Clamp every queue to a single page when is_kdump_kernel() is true. Doing
> > > it in arm_smmu_init_one_queue() covers the command, event and PRI queues
> > > in one place. The command queue still holds at least one batch plus a sync
> > > (256 entries on a 4K-page kernel, well above CMDQ_BATCH_ENTRIES), so
> > > command batching keeps working.
> > 
> > Wouldn't we be better of not allocating unused queues in the first place?
> > That's what this patch does:
> > 
> > https://lore.kernel.org/r/0b035c53cb401acde8244b805d4b6a0312b83708.1782799827.git.nicolinc@nvidia.com
> 
> Maybe I'm reading it wrong, but I couldn't find the allocation change in
> there. That patch seems to only touch arm_smmu_device_reset() -- skipping
> the EVTQ/PRIQ base/prod/cons writes and the CR0_EVTQEN/CR0_PRIQEN enables
> instead of the current enable-then-mask-out.
> 
> I went through the rest of the series too and didn't see
> arm_smmu_init_queues() or arm_smmu_init_one_queue() touched anywhere, so
> as far as I can tell the kdump kernel still allocates full-size
> evtq/priq, and the cmdq is not affected either.
> 
> Is the allocation side handled somewhere else that I've missed?

Sorry, yes, it would need extending to avoid allocating the queues now
that they're not used at all. I was hoping you and Nicolin could work
together on that.

> > If you want to reduce the cmdq size, I'd prefer a cmdline option rather
> > than special-casing kdump (as I've had other folks ask about configuring
> > the cmdq size for other reasons).
> 
> Fair enough for the cmdq. I'm less sure what to do about evtq/priq: they
> get disabled in the kdump kernel anyway, so I don't know what a size knob
> would mean for them, other than every kdump config having to pass it to
> get back the memory.
> 
> Would skipping their allocation when is_kdump_kernel() be acceptable on
> its own, or would you rather see it done differently?

With Nicolin's patch, we can just avoid allocating the priq and the evtq
entirely in the kdump case. We can then add a cmdline option to control
the maximum size of the cmdq, which is useful regardless of kdump.

Will
