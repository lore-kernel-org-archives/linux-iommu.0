Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137FEB641
	for <iommu@lists.linux.dev>; Mon,  9 Sep 2024 14:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725893112; cv=none; b=nIWrrffFxHK4sH/Etmn0djNmakbkwqvapYpnncuf27+wGwPDiaNPVVyQqCt9uUiXlv14comgCpsLVoxDpva8AfLb9uWd7kM7P5MjJ6LkDX6qY9rs2+gzfIoIVluvb2LFUrwpEZA429y/Px7SSAaE34S/mDjKcKy1cYOeBgnn490=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725893112; c=relaxed/simple;
	bh=G/KTMWEURwXGUcqOZTqmqBbKI3W+RI6EpqQBqFoIhj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YDoaUrN3igKujKpMpmRHAnmXRLxuCo3Q2a8Hw+WFkkV5DWOaxkEbpBUfxr/KtTyXnxZmrCluo5uczhyKzvnVyTXC0LbHd6/KClEmc5qcV4671qY3n/E3s7pRvlymowTh2nsxRMHCwHWSugl2uFxX1/69W6WfRgflxkxfWhsVfaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tMjQli2d; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tMjQli2d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A879C4CEC5;
	Mon,  9 Sep 2024 14:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725893111;
	bh=G/KTMWEURwXGUcqOZTqmqBbKI3W+RI6EpqQBqFoIhj0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tMjQli2dUD5KrgFKq6Z0TAQHQAeFqCsFcsOUzgh5LpsPUCdU8ydMxx1jIhqXYOx1f
	 BeJXEy4S2LRz2CG/I3i2f9oCGHYU1kyLrcv9Zix0+9uvNlGe8FN9P4jy0Rn52o+e1d
	 51TwtNESSVriu4KrAvR0Ixh1oxta/TKSyw0lusgt9FgglYM9eg9quHMAnMGcvJ8MS8
	 uhSGBZF75bmPUlZM9h400rnHxgn0IAwtsQmmLmOEM41ryccJRapX0k8ecS+RBsVXy2
	 XdfAq8+EKwEYWpKPa9x3PPHaICyw3xz0qHxcsW9yaMDoSc78sBSTmUiYBOz/u46KML
	 yHLE3jZopYGeQ==
Date: Mon, 9 Sep 2024 15:45:06 +0100
From: Will Deacon <will@kernel.org>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Robin Murphy <robin.murphy@arm.com>,
	Pranjal Shrivastava <praan@google.com>,
	Joerg Roedel <joro@8bytes.org>, Mostafa Saleh <smostafa@google.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Daniel Mentz <danielmentz@google.com>
Subject: Re: [PATCH v2 1/2] iommu/arm-smmu-v3: Print better events records
Message-ID: <20240909144506.GA19863@willie-the-truck>
References: <ZtAW0hVPFD6JbLTL@Asurada-Nvidia>
 <ZtEKMknbGaD9q170@google.com>
 <ZtEkUQ7tI3Nb0NOc@Asurada-Nvidia>
 <ZtV1-IL8AZu--jGp@google.com>
 <ZtZEFKnKasX6433r@Asurada-Nvidia>
 <ZtnXADX3b6qdqVs0@google.com>
 <ZtphFYr1jUhHOSnC@nvidia.com>
 <20240906125524.GA16773@willie-the-truck>
 <392451a1-784c-4c35-9924-1a1f4cba9120@arm.com>
 <ZttNF5qcc+jH/3yE@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZttNF5qcc+jH/3yE@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Fri, Sep 06, 2024 at 11:42:31AM -0700, Nicolin Chen wrote:
> On Fri, Sep 06, 2024 at 05:39:03PM +0100, Robin Murphy wrote:
> > On 06/09/2024 1:55 pm, Will Deacon wrote:
> > > > > > > +struct arm_smmu_event {
> > > > > > > +       union {
> > > > > > > +       u64 raw_evt[4];
> > > > > > > +       struct {
> > > > > > > +               /* "Good stuff" fields */
> > > > > > > +       };
> > > > > > > +};
> > > > > > > 
> > > > > > > and then based on the fault type we can use the "good stuff" or raw_evt?
> > > > > > > So, basically just add a union between raw_evt and the other fields to
> > > > > > > improve struct arm_smmu_event present in v2?
> > > > > > 
> > > > > > Yea, I attached a test code at the EOM for your reference. Please
> > > > > > feel free to drop fields if they aren't common enough, and confirm
> > > > > > those bits are correctly written too.
> > > > > > 
> > > > > 
> > > > > Hmm, so you're suggesting to make the event a union instead of a struct
> > > > > thus, making reading event fields easy.
> > > > > 
> > > > > The only thing I'm slightly worried about is if the bitfields don't
> > > > > remain constant if more events are added in the future.
> > > > > 
> > > > > For example, the "IPA" field is in dword[3] for now, but if it changes
> > > > > in the future, it may get difficult to scale the union for future events
> > > > > If we can guarantee that it doesn't happen then I think union is better.
> > > > 
> > > > I believe HW has its own reason to put those fields constantly
> > > > following the same pattern, and must have its tendency to keep
> > > > in that way.
> > > > 
> > > > The "union { u64 raw; struct {} }" way isn't that uncommon in
> > > > the kernel, here are a few existing examples:
> > > >      drivers/crypto/marvell/octeontx2/otx2_cpt_hw_types.h
> > > >      drivers/crypto/cavium/nitrox/nitrox_req.h
> > > >      include/asm-generic/hyperv-tlfs.h
> > > > 
> > > > Taking a step back, if one field in a new event in the future
> > > > happens to be odd, we could still fetch field in its own way:
> > > > event->evt[4] is still available to extract via FIELD_GET; or
> > > > just define another union exclusively for that event, neither
> > > > of which sounds like the end of world.
> > > > 
> > > > Having said that, I'd defer to Will. So, here is just my two
> > > > cents.
> > > 
> > > My only real concern is the fragility of using bitfields. I don't _think_
> > > the compiler is obliged to lay them out in the obvious way and I can't
> > > think of anything worse than being given a bad pretty-print when debugging
> > > a real driver issue!
> 
> Well, if compiler is going to be an issue, I can't disagree with
> your point.
> 
> Any reference to some existing issue with compiler failing to lay
> out properly? I wonder how other headers could define their unions
> using bitfields and stay safe..

It's not so much about buggy compilers, but more that I don't think the
C standard defines the order and so relying on it can be fragile. If you
fancy going to the effort of ensuring that LLVM and GCC will agree on
the "obvious" layout forever more, then don't let me stop you ;)

Will
