Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0263A7F48;
	Tue, 28 Jul 2026 11:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785238062; cv=none; b=EmCabsCXtyxf+xaMeol0KRLY1bbHtoJyVYMKQK9k+fkezo2XQNfoWWo4UHtf5vMR3jKnHDQYjRLwwq/xgqmaCGT2PVObxeFSQRIvlTYaQRJA/IW23Rq9DyfG65gxaDHbAE41TW8DPIC6bbItw003hbvXh6NgWptVltEhHsNGhSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785238062; c=relaxed/simple;
	bh=dRS3JiYlxFIyATCelHBBro2B2v0jiRqmRjUJgH3Bv6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jp76ewXHW47c7PuH0eRke7Sdl4PTDa/EJuGsqJCH8NdJzG8dXjBeAWRO8RF+II4N+XanBQia6r12LE/IcOSSO0bUyaKbZCVcJgf84ABayunvZOtyNK8ecTi+m5Mf9Q7ZhxNm8wKhSfkd3+Ew9LbDJXI50/FfI9iZpteGPyBU61c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lEfr4B0W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lEfr4B0W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E92691F000E9;
	Tue, 28 Jul 2026 11:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785238061;
	bh=EPiIGPvKbEzVvkisuieRapAQMt4KNwjEh7oUsK+fLwI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lEfr4B0WyJmHDE6f576vwoF1R+Fs93uEOJRNAIM3bAFeQOb7iknCsaOIoHODPLN4Z
	 tWHUqSImCxe/aAWMrcldqp2Aeyg1ZTPTx9qZQ+GlgZfthH6bim526IVqAxWys/o5La
	 ytuNQeYeh/L0I7F4Bgf4jH7GyAQbIJG+zUqQZP0BCinM6lAPzFXcFjee0JimQf2VBJ
	 ftLuWJ8Nkq2lmu+b4u72LaizonsA0f1Ml62Te7ojYBM9Ga8UDmL0vC4gam/Essuh3q
	 cFt9Xtitgd9xbiE51hws/O8vgAsUrLqX7iCjmLZX2kwokKhn+j1wnghUVn9G8/DnD4
	 RhrCtUPj9Tf+g==
Date: Tue, 28 Jul 2026 12:27:36 +0100
From: Will Deacon <will@kernel.org>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
	Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Pranjal Shrivastava <praan@google.com>
Subject: Re: [PATCH v4 0/6] iommufd: Iterate the cache invalidation array in
 the core
Message-ID: <amiSKPx6-VXBxGBK@willie-the-truck>
References: <cover.1784054606.git.nicolinc@nvidia.com>
 <20260715201521.GL3775915@nvidia.com>
 <alft3llhZ79t17j8@nvidia.com>
 <20260716151845.GO3775915@nvidia.com>
 <alkE4iUQSWeD8Vyx@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alkE4iUQSWeD8Vyx@nvidia.com>

On Thu, Jul 16, 2026 at 09:20:50AM -0700, Nicolin Chen wrote:
> On Thu, Jul 16, 2026 at 12:18:45PM -0300, Jason Gunthorpe wrote:
> > On Wed, Jul 15, 2026 at 01:30:22PM -0700, Nicolin Chen wrote:
> > > On Wed, Jul 15, 2026 at 05:15:21PM -0300, Jason Gunthorpe wrote:
> > > > On Tue, Jul 14, 2026 at 11:48:46AM -0700, Nicolin Chen wrote:
> > > > > Nicolin Chen (6):
> > > > >   iommu/arm-smmu-v3: Support IDR5.DS and widen the TLBI SCALE field
> > > > >   iommu/arm-smmu-v3-iommufd: Reject unsupported bits in invalidation
> > > > >     commands
> > > > >   iommufd: Iterate the cache invalidation array in the core
> > > > >   iommufd/selftest: Convert cache invalidation mocks to the core array
> > > > >     loop
> > > > >   iommu/arm-smmu-v3-iommufd: Convert cache invalidation to the core
> > > > >     array loop
> > > > >   iommu/vt-d: Convert nested cache invalidation to the core array loop
> > > > 
> > > > I was tempted to take this through the iommufd tree, but Will, I think
> > > > the first two ought to go to -stable through iommu ?
> > > > 
> > > > If you do that then maybe I'll pick up the rest
> > > 
> > > PATCH-5 touches arm-smmu-v3-iommufd. Merging via the iommufd tree
> > > will conflict with the PATCH-2 in Ashish's series (via iommu):
> > > https://lore.kernel.org/all/20260714104202.1664187-1-amhetre@nvidia.com/
> > > 
> > > Maybe it needs a shared branch; and then, Ashish can rebase?
> > 
> > Urk this is a pain. I think Ashish's errata fix should go first so it
> > is easier to backport.
> 
> OK. I can rebase and send a v5 after Will takes Ashish's series.

I've now queued the workaround from Ashish.

Will
