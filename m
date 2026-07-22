Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765DD367B7E;
	Wed, 22 Jul 2026 21:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784756563; cv=none; b=RAsqBjEy5ApsLA52bhwoEyiWevOWp/3V2aka/Kw3pEFqG8jmJ29yLlutcYeHKIQVXQgIeTvU9/QcsMIv4xPPK2jW2PiwLYxGrJpCZnZ42fDj4DJ8l4dzn8pLRhk/7NAODu6rP4BqtfxxGD1ZbR0W/INGYsCg6ItKPclkTaj6+CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784756563; c=relaxed/simple;
	bh=LWEs48QXpuNXuL4poANcBKLLN+cPyhQFQENq70XY1y8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QcpyDT3J8TEAy6MyPj86Itc2x9VQgN4zUpYWr109LbFGRh8SG3pCbIhSqJlx7uhcoxkm3cgFuIpyN5F1xDsORwg01P7wMaZBTjJrzw/hyg+4K1p+oGIvPyfvwnmmLE+HfaphtaEcnYUm8U8q1uQuTMRkisJ7DSREcv46uBehdC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fPEv5Xfy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fPEv5Xfy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9076A1F000E9;
	Wed, 22 Jul 2026 21:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784756562;
	bh=ed4T4xJjlrAZXH7SdCvLneLF0/yxPPXnPkh3K7AaOfQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fPEv5XfyolxPMevnNfBaZ2im8pSAn8nujZnXszBTCkjPI/wA4aVny7vmXgl5FpNLk
	 2irJA1dPwd6QC+Yy913E/1FGFUdUIo5FxZWlojrG0O9nkIJQ4DqIqylbaaxPnNzqe0
	 RpXOrSb/Mttb55HnoMZblGXLGTpU5vbryBFw06bhlM4bgNe9rKDNEWSaIz7yijbljV
	 vTstFZl6fOw9fIOFUaHx1w5JTBWBhEtnOSZNKYCDy78t8JsfFKiMpfcoEHkwfBqqn/
	 l89ugTCLvx+Km3cADcP9eB5XBUJm2cmYU2OnU+xtGDgmOo7Pc98eVWgm4/MQW/EikI
	 r8H5/c514C2Zw==
Date: Wed, 22 Jul 2026 22:42:37 +0100
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>,
	Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Prakash Gupta <prakash.gupta@oss.qualcomm.com>
Subject: Re: [PATCH] iommu/io-pgtable-arm: Add support for contiguous hint bit
Message-ID: <amE5TRcSscM4iuGi@willie-the-truck>
References: <20260618-iommu_contig_hint-v1-1-4502a59e6388@oss.qualcomm.com>
 <20260703161228.GA1948451@nvidia.com>
 <b7224dff-7e51-49cb-8421-14d090492dfc@oss.qualcomm.com>
 <20260715113913.GA3775915@nvidia.com>
 <ald3CuddY6I7gml1@willie-the-truck>
 <2ce09e84-c57f-4087-9dda-07245fadfc02@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ce09e84-c57f-4087-9dda-07245fadfc02@arm.com>

On Wed, Jul 15, 2026 at 01:14:18PM +0100, Robin Murphy wrote:
> On 15/07/2026 1:03 pm, Will Deacon wrote:
> > On Wed, Jul 15, 2026 at 08:39:13AM -0300, Jason Gunthorpe wrote:
> > > On Wed, Jul 15, 2026 at 11:25:42AM +0530, Vijayanand Jitta wrote:
> > > > On 7/3/2026 9:42 PM, Jason Gunthorpe wrote:
> > > > > On Thu, Jun 18, 2026 at 02:32:09PM +0530, Vijayanand Jitta wrote:
> > > > > > From: Prakash Gupta <prakash.gupta@oss.qualcomm.com>
> > > > > > 
> > > > > > Add support for the contiguous hint (CONT) bit in ARM LPAE page tables.
> > > > > > When a set of consecutive PTEs map a naturally-aligned contiguous block
> > > > > > of memory, the CONT bit can be set on all entries in the group to allow
> > > > > > the hardware to combine them into a single TLB entry, improving TLB
> > > > > > utilization.
> > > > > > 
> > > > > > The contiguous hint sizes per granule are:
> > > > > > 
> > > > > >    Page Size | CONT PTE |  PMD  | CONT PMD
> > > > > >    ----------+----------+-------+---------
> > > > > >        4K    |   64K    |   2M  |   32M
> > > > > >       16K    |    2M    |  32M  |    1G
> > > > > >       64K    |    2M    | 512M  |   16G
> > > > > 
> > > > > My series to convert smmuv3 to the iommupt takes care of this and
> > > > > supports all the orders too. I'd rather we move forward with that then
> > > > > try to patch up this.
> > > > 
> > > > Thanks for details, I have gone through your series. As this patch
> > > > targets io-pgtable-arm.c directly and would benefit all its users (SMMUv2,
> > > > Apple DART, etc.), not just SMMUv3. I think there will still be value in
> > > > this patch for the other users.
> > > 
> > > If other users care they should also be converted to iommupt, there
> > > are many benefits to this besides just cont support.
> > 
> > I really have no interest in maintaining two copies of the page-table
> > code, so I agree that we should convert users of the architectural (long
> > descriptor) page-table format over to iommupt with a view to removing
> > the io-pgtable implementation eventually. If you want two parallel
> > implementations, then one should really be in rust :)
> > 
> >  From what I can tell, the fiddly parts for iommupt will be:
> > 
> >    1. Hardware bugs / quirks. Some of the simpler ones could probably be
> >       handled but for the more invasive stuff like the Mali format
> >       format, io-pgtable will probably need to hang around. Perhaps
> >       it becomes io-pgtable-mali.c?
> > 
> >    2. The pKVM work from Mostafa. We'll probably end up with something
> >       separate at EL2 for this (ideally, just reusing the CPU page-table
> >       code when it learns about BBML3).
> > 
> >    3. Non-coherent walkers, although I think this might actually be fine
> >       because x86 needs it anyway?
> > 
> > So, for now, I wouldn't require new drivers to use iommupt but I'm not
> > particularly keen about teaching io-pgtable new architectural tricks
> > either.
> 
> Conversely though, I really wouldn't want to have to maintain arm-smmu
> supporting two completely different pagetable APIs simultaneously either :/

Yeah, we'll have to see how it pans out. I suppose the first step is for
somebody to go through Jason's iommupt series for SMMUv3 and get that
driver converted. Once we've got that working, we should have a better
idea about what to do with arm-smmu.

If we can't get to a point where drivers are no longer using the long
descriptor io-pgtable implementation, then we'll obviously not get rid
of it, but I think it will become "fixes only" or something like that.

Will
