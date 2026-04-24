Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD353CFF65;
	Fri, 24 Apr 2026 16:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777046493; cv=none; b=BcUTGZn1Ip415v99qpPUW+NOYWl4mhzSKi3lznXM5qpsn1Bc4nJFmO7oAkhKUFpFd7mcm+mtNl4Pm2eoCyp5s8J2LezCpen3OvADkwJLHU0exHo4Gfn3Dn2KqQBUclbKnYTa3HgYrlCyE6QxktcM7XnO5UDQrEqNGeGzH2X9760=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777046493; c=relaxed/simple;
	bh=WOG+Fz92/zHztMNljeKjVYSh8yhdUV+2hZiJ4s0U7pw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MZe3X2/8uy/wN2HORO0pJ2BRyhYRZXHgQnmicR+3Ss2cr0yxHnMGIG4ct9ZjOhcqAtO93f2TPV/IBLRJYXTPa7gJA1D5lP7R2lqgQ47A+LDnMGZXcXbDsZ0l+P+sZMBz0Qn7km8ZAkAN1c2+a2z4LAefZUXsjK/aHxEtuovmLE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XMlr5elm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XMlr5elm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC45DC19425;
	Fri, 24 Apr 2026 16:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777046493;
	bh=WOG+Fz92/zHztMNljeKjVYSh8yhdUV+2hZiJ4s0U7pw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XMlr5elmIrCp2UsJN2f5fAr2iKdsMtc5nmCYtxgK8U2AmEcfWX1s6IR4hjV/434Ag
	 x9H2urDs6s0MfrvgL2QIxMxIdOnZX5a4s91bG4YTPZiXGHPI3gA+4vRuIGnQIJCXEt
	 q6q129bIux5Ssg45yiaeE6pYPiSv6hJTvW5F5OdVT15t8GPkHJFBzbBne4GzE5Me9S
	 obAqMJ5UrNV/nltVrTYYshkRi/Af4NsZJtOkqXbeluQ07xWmOV40zczK8OpTg81dnt
	 FYYfIqgQvuz8srm7jrj3vsUBOYSCbX0O4hxkVU6VX2ItzcTc1RKNgCq5xJ33wL5yz/
	 pL5JUDasBTECQ==
Date: Fri, 24 Apr 2026 17:01:27 +0100
From: Will Deacon <will@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Evangelos Petrongonas <epetron@amazon.de>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Pranjal Shrivastava <praan@google.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, nh-open-source@amazon.com,
	Zeev Zilberman <zeev@amazon.com>
Subject: Re: [PATCH] iommu/arm-smmu-v3: Allow disabling Stage 1 translation
Message-ID: <aeuT1-TB6dOT5ZQ2@willie-the-truck>
References: <20260420124032.GO2577880@ziepe.ca>
 <20260422064431.GA49867@dev-dsk-epetron-1c-1d4d9719.eu-west-1.amazon.com>
 <20260422162351.GK3611611@ziepe.ca>
 <aenp6FHzx9rtUQkZ@willie-the-truck>
 <aenqxasLJ8yKYqbT@willie-the-truck>
 <20260423142326.GP3611611@ziepe.ca>
 <aepRy7Gp7Ng85Zr7@willie-the-truck>
 <20260423223716.GS3611611@ziepe.ca>
 <aeuJQW8bGLY-O_vv@willie-the-truck>
 <20260424154256.GF3611611@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260424154256.GF3611611@ziepe.ca>

On Fri, Apr 24, 2026 at 12:42:56PM -0300, Jason Gunthorpe wrote:
> On Fri, Apr 24, 2026 at 04:16:17PM +0100, Will Deacon wrote:
> > > > > STE/CD is pretty simple now, there is only one place to put the CMO
> > > > > and the ordering is all handled with that shared code. We no longer
> > > > > care about ordering beyond all the writes must be visible to HW before
> > > > > issuing the CMDQ invalidation command - which is the same environment
> > > > > as the pagetable.
> > > > 
> > > > You presumably rely on 64-bit single-copy atomicity for hitless updates,
> > > > no?
> > > 
> > > Yes, just like the page table does..
> > > 
> > > I hope that's not a problem or we have a issue with the PTW :)
> > 
> > You trimmed the part from my reply where I think we _do_ have an issue
> > with the PTW. Here it is again:
> > 
> >   The non-coherent case looks more fragile, because I don't _think_ the
> >   architecture provides any ordering or atomicity guarantees about cache
> >   cleaning to the PoC. Presumably, the correct sequence would be to write
> >   the PTE with the valid bit clear, do the CMO (with completion barrier),
> >   *then* write the bottom byte with the valid bit set and do another CMO.
> 
> I wasn't sure if you are being serious.
> 
> CMO + barriers must provide an ordering guarentee about cache cleaning
> to POC otherwise the entire Linux DMA API is broken. dma_sync must
> order with following device DMA. IMHO that's not negotiable for Linux.

The problem is with concurrent DMA (from the page-table walker) and I
don't see anything that guarantees that in the CPU architecture. I don't
think the streaming DMA API pretends to handle that case, does it? It
relies on a pretty rigid ownership concept from what I understand.

> All ARM iommus rely on 64 bit atomic non tearing. No bugs reported?

It's hard to judge as I don't think SMMUs tend to perform a lot of
speculative address translation when DMA isn't active. 

> Any fix to that is going to have major performance downsides..
> 
> I also strongly suspect it is provided on real HW. It would be hard to
> even build HW where <= 64 bit quanta can tear.
> 
> Maybe this is something ARM should take a look at.

Yes, we should ask. Maybe I missed something in the Arm ARM, but I can
also seeing it being a pain to specify this behaviour all the way out to
the PoC and I wouldn't be so bold as to say that it's hard to build HW
that would exhibit problems here.

> > > And if Samiullah can tackle dma_alloc_coherent then maybe the whole
> > > question is moot.
> > 
> > Yes, that would be great, but we probably need to fix the page-table
> > code too.
> 
> You really want to deal with the likely perf regressions that would
> cause on Android/etc?

Of course I'd rather that the architecture said that our current code
is fine, but if it doesn't then I don't have much choice, really. At the
very least, we should minimise the number of places where we rely on
non-architected behaviour and so keeping the CDs and STEs non-cacheable
remains my preference.

Will
