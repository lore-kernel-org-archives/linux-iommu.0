Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95202424D76;
	Thu, 10 Sep 2026 13:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789045435; cv=none; b=WrR/preTjISa2TeBF/f8Y+Ci/6R02I7u+H8Qk3egeWoUIk/V8C818lYyuYU1QK9XhuQyKd3FFi0pCw2y4eJoibmXfWNy2MCaXwOXLgG1hSWMioZaKO0QVzk82xgu+Q8joatdRZfVwjlhtHZldprNL/8yrBnna+Bn0KIuTz9PDEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789045435; c=relaxed/simple;
	bh=8vbrxyk8QgfjJxIanOGBIOBFPTuckTL5rE5O7frqejc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B4/f0gT6YP/YETAoSuDo2DtH0zQhMPOvJBY4iBatk9G79zA7c8KFQapxjDLNac5dQy8jirkiTN+LpSX8T4aQ4HCEQ2v+G0Xz4cz88wk1o4GYvUYXPTbTHTrnMkb4lr8KFMisFEOJachmsrOTqZY14tHIKobNn8EPmbVvi2H/5+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L4RxqsBU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L4RxqsBU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 230771F000FF;
	Thu, 10 Sep 2026 13:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789045434;
	bh=OqcFvD1oHRf3CUmqeRwBVe/Vdci4v9WF/u/pqTn5yLY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=L4RxqsBUHTVxjSuPWc45IGy/B74umFjvmOW9asWW3od5itQxQtL7xMlZovDPny9Fb
	 KEdGDtmIL7pdE/LoHU1DskTR32BIH5cPHgB81uBvyVaJUsnNLiATeoxK8n+i75skXs
	 NrSVKSubGuhlWmW3Lb2DmqI814P00DbQH6S57flQ2a41cA/7M4iOBHzPLBvkdfWEd2
	 ZChSiTirWrzp2QviAqgv30HntCUPbM44od62Z8JwOLn8HVnjM41nzr0oz9VheKbSVd
	 ln+h8yja8EWIdLvs5UjAFDabadqV1mvvy+kcYqqcOpjcsJ5fQXdc48gkTGTG5ArPnZ
	 /kmoeljNtnaag==
Date: Thu, 10 Sep 2026 14:03:48 +0100
From: Will Deacon <will@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, Robin Murphy <robin.murphy@arm.com>,
	joro@8bytes.org, Kevin Tian <kevin.tian@intel.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Pranjal Shrivastava <praan@google.com>
Subject: Re: [PATCH v6 0/5] iommufd: Iterate the cache invalidation array in
 the core
Message-ID: <aqKqtJguAfzDSiZE@willie-the-truck>
References: <cover.1788127877.git.nicolinc@nvidia.com>
 <20260909164107.GA4147563@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909164107.GA4147563@nvidia.com>

On Wed, Sep 09, 2026 at 01:41:07PM -0300, Jason Gunthorpe wrote:
> On Sun, Aug 30, 2026 at 03:26:37PM -0700, Nicolin Chen wrote:
> > The vIOMMU cache_invalidate() and the nested-HWPT cache_invalidate_user()
> > ops are each handed the full user invalidation array and must report, via
> > array->entry_num, how many of its entries they handled. That makes every
> > driver open-code the same array walk, with real downsides:
> [..]
> > Nicolin Chen (5):
> >   iommu/arm-smmu-v3-iommufd: Reject unsupported bits in invalidation
> >     commands
> >   iommufd: Iterate the cache invalidation array in the core
> >   iommufd/selftest: Convert cache invalidation mocks to the core array
> >     loop
> >   iommu/arm-smmu-v3-iommufd: Convert cache invalidation to the core
> >     array loop
> >   iommu/vt-d: Convert nested cache invalidation to the core array loop
> > 
> >  include/linux/iommu.h                         |   6 +-
> >  include/linux/iommufd.h                       |   2 +
> >  include/uapi/linux/iommufd.h                  |   4 +-
> >  .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     | 197 ++++++++++++++----
> >  drivers/iommu/intel/nested.c                  |  54 ++---
> >  drivers/iommu/iommufd/hw_pagetable.c          |  25 ++-
> >  drivers/iommu/iommufd/selftest.c              | 147 +++++++------
> >  7 files changed, 282 insertions(+), 153 deletions(-)
> 
> Will, can I pick this up, or did you want a branch or something?

All yours!

Will
