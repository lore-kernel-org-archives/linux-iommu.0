Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E89A2798EA;
	Fri, 24 Apr 2026 15:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777043783; cv=none; b=ChmWO5NnJFBrYiMzo7JXSK1B3itim3edpLfJpx555oKAsgqgGsk3cPVAZ6s480aIdpSUm59rKbnhin7WlybuZCWhnvnjBMjKGm+KcNabGKvzJbrkX5poX5UgPlBKdnltp3GMfpn6p6Oxf/ivXhZuS5keyzAgO/HQsY9pQMzJqK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777043783; c=relaxed/simple;
	bh=nrM3UKcrO7tPwOt1LFMCFnX8PG4XqEiYfdua6M/CYZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iQWjshbf6gQutpK4I6FnkmBp+EKR5C2BdAS6W0/0pXg0wyeOY3OfDaYYgfIciePdLJyNtWtQpRO6jeP5NglNpxScRBhgeG92rJAnFIeM5xDCG2YvAl9ajgOi0Zwa9SRZD6HE59SCR2QeFI7VaeTb8wYzO8iyXXq1JjoyWepMJug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H6v7GrWs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H6v7GrWs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95047C19425;
	Fri, 24 Apr 2026 15:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777043782;
	bh=nrM3UKcrO7tPwOt1LFMCFnX8PG4XqEiYfdua6M/CYZI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H6v7GrWsEyBK2JTdhH44O/VJffVliTLN/jxYcPHtXzEA3iIKF1gnE3HGxGa9SKEQA
	 RS7yTV0uv7X/4/m3kSfAS4hKfKLkfs/T231MtXN7LZH4G6Oq5otf3NdFktwJTloTB/
	 AO/SVqd3Vzh3GyM8KS82GO1bSOmBWKyslzNbrFj80ipoaHN4HDTc14XqNe+SGZ+ymG
	 i2FQpB8i/+GN99DxFVUqc028G3/n7yltam8zR7wSeIQZRovjqGiOPyvFKHUR6HZFKC
	 niK8h5kYh3SfA4v1gs9iKh7L5JIC4yU5amMeESkf8nVxOeHry7hfqPBqTDutoLCpT8
	 +MFE/f+awrvyA==
Date: Fri, 24 Apr 2026 16:16:17 +0100
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
Message-ID: <aeuJQW8bGLY-O_vv@willie-the-truck>
References: <20260420123221.20801-1-epetron@amazon.de>
 <20260420124032.GO2577880@ziepe.ca>
 <20260422064431.GA49867@dev-dsk-epetron-1c-1d4d9719.eu-west-1.amazon.com>
 <20260422162351.GK3611611@ziepe.ca>
 <aenp6FHzx9rtUQkZ@willie-the-truck>
 <aenqxasLJ8yKYqbT@willie-the-truck>
 <20260423142326.GP3611611@ziepe.ca>
 <aepRy7Gp7Ng85Zr7@willie-the-truck>
 <20260423223716.GS3611611@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260423223716.GS3611611@ziepe.ca>

On Thu, Apr 23, 2026 at 07:37:16PM -0300, Jason Gunthorpe wrote:
> On Thu, Apr 23, 2026 at 06:07:23PM +0100, Will Deacon wrote:
> 
> > I don't think it's that odd given that the STE/CD entries are bigger
> > than PTEs and the SMMU permits a lot more relaxations about how they are
> > accessed and cached compared to the PTW.
> 
> Well I'm not sure bigger really matters, but I wasn't aware there was
> a spec relaxation here that would make the cachable path not viable
> for STE but not PTW...

Things like the SMMU being allowed to cache invalid structures and
loading structures using multiple, unordered accesses are the things
that worry me relative to the page-tables. But see below.

> > Having said that, the page-table code looks broken to me even in the
> > coherent case:
> > 
> > 	ptep[i] = pte | paddr_to_iopte(paddr + i * sz, data);
> > 
> > as the compiler can theoretically make a right mess of that.
> 
> Heh, great. The iommupt stuff does better.. It does a 64 bit cmpxchg
> to store a table pointer and a 64 bit WRITE_ONCE to store the pte,
> then a CMO through the DMA API.
> 
> DMA API has to guarentee the right ordering, so we only have the
> question below:
> 
> > > STE/CD is pretty simple now, there is only one place to put the CMO
> > > and the ordering is all handled with that shared code. We no longer
> > > care about ordering beyond all the writes must be visible to HW before
> > > issuing the CMDQ invalidation command - which is the same environment
> > > as the pagetable.
> > 
> > You presumably rely on 64-bit single-copy atomicity for hitless updates,
> > no?
> 
> Yes, just like the page table does..
> 
> I hope that's not a problem or we have a issue with the PTW :)

You trimmed the part from my reply where I think we _do_ have an issue
with the PTW. Here it is again:

  The non-coherent case looks more fragile, because I don't _think_ the
  architecture provides any ordering or atomicity guarantees about cache
  cleaning to the PoC. Presumably, the correct sequence would be to write
  the PTE with the valid bit clear, do the CMO (with completion barrier),
  *then* write the bottom byte with the valid bit set and do another CMO.

> > > I also don't like this "lot of systems thing". I don't want these
> > > powerful capabilities locked up in some giant CSP's proprietary
> > > kernel.  I want all the companies in the cloud market to have access
> > > to the same feature set. That's what open source is supposed to be
> > > driving toward. I have several interesting use cases for this
> > > functionality already.
> > 
> > Sorry, the point here was definitely _not_ about keeping this out of
> > tree, nor was I trying to say that this stuff isn't important. But the
> > mobile world doesn't give a hoot about KHO and _does_ tend to care about
> > the impact of CMO, so we have to find a way to balance the two worlds.
> 
> Yes, that make sense.
> 
> My argument is that the CMO on STE/CD shouldn't bother mobile, you
> could even view it as an micro-optimization because we do occasionally
> read-back the STE/CD fields.

I was against that read-back, iirc :)

> And if Samiullah can tackle dma_alloc_coherent then maybe the whole
> question is moot.

Yes, that would be great, but we probably need to fix the page-table
code too.

Will
