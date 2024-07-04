Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9C81AEFD6;
	Thu,  4 Jul 2024 14:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720103655; cv=none; b=phTCen4CPIemgIBSN86mQKTMe24IrCQ8UvH5FkHYWaZMAXM4nmi20hDbwPth6njFCNVQ/lkyRIdy6UkxxooH6wJ8p9OE3lDmJr60HUflEvoydmd1RBo/rAjtOKLaYixLxap7zESKcM6Q1fJyv4ZJNMiqil/xU6bO++g6ohRXXkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720103655; c=relaxed/simple;
	bh=mQ26XuKNbwYsAasmtsn6uZeQsrB0KeCZEr54v5bxmwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PcG6njzu1FUVb0i4S2++gzAsb2ZCNcU1iZ2/WKOHnghI135r0JJ14YjAuUSHRw6azaxwxsO8mlKGZing4xVZWoHZQtubDaMkk75Z62lmT11aeIZBmVqBEfIhQe0b1+CwlykR3MAq2jGbEl5fO89yDvGJyrQNxazeFEG63sdDGq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IPESSHGT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IPESSHGT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3739DC3277B;
	Thu,  4 Jul 2024 14:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720103655;
	bh=mQ26XuKNbwYsAasmtsn6uZeQsrB0KeCZEr54v5bxmwk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IPESSHGT/s4FuGQk/uME6Qr6CIcUCFaXglWtxoxQhPNVROozdqJmGOJgv1gXNtAYw
	 anCv6CPGr3TK7rWm29/7pMqyXuSLyp3c9nW2PFi2lAxVULdnBDWXZxBCXnVshpPsGx
	 K8zEEK/uYH5boR7hO66R7bwcJ/9s+WjtFxAOtDaLC5OTJsfjcDDR+jhUNzbzlILahS
	 Bxb3wIq40PA1HUxutwJfUS/tlPiHFlPMDWuk2dn8efa5iG59EJUsQwX46gdTV4A/Qc
	 KCAAJtDkl2XLALvX2RvIvdFJw8kjBAY3xcw8WgH7VgDa1COJ+VWSJR+RcBjXtGbvA2
	 TvG6WoKAJCrhQ==
Date: Thu, 4 Jul 2024 15:34:07 +0100
From: Will Deacon <will@kernel.org>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
	catalin.marinas@arm.com, kernel-team@android.com,
	Yi Liu <yi.l.liu@intel.com>, David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>, Kalle Valo <kvalo@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Alex Williamson <alex.williamson@redhat.com>, mst@redhat.com,
	Jason Wang <jasowang@redhat.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	ath10k@lists.infradead.org, ath11k@lists.infradead.org,
	iommu@lists.linux.dev, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/21] iommu: Refactoring domain allocation interface
Message-ID: <20240704143407.GA8211@willie-the-truck>
References: <20240610085555.88197-1-baolu.lu@linux.intel.com>
 <172009858593.2049787.5200500337719932334.b4-ty@kernel.org>
 <f273615a-ebbd-488c-a301-e5cefc0715b1@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f273615a-ebbd-488c-a301-e5cefc0715b1@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Thu, Jul 04, 2024 at 10:24:52PM +0800, Baolu Lu wrote:
> On 2024/7/4 22:18, Will Deacon wrote:
> > On Mon, 10 Jun 2024 16:55:34 +0800, Lu Baolu wrote:
> > > The IOMMU subsystem has undergone some changes, including the removal
> > > of iommu_ops from the bus structure. Consequently, the existing domain
> > > allocation interface, which relies on a bus type argument, is no longer
> > > relevant:
> > > 
> > >      struct iommu_domain *iommu_domain_alloc(struct bus_type *bus)
> > > 
> > > [...]
> > Applied a few of these to iommu (iommufd/paging-domain-alloc), thanks!
> > 
> > [01/21] iommu: Add iommu_paging_domain_alloc() interface
> >          https://git.kernel.org/iommu/c/a27bf2743cb8
> > [02/21] iommufd: Use iommu_paging_domain_alloc()
> >          https://git.kernel.org/iommu/c/26a581606fab
> > [03/21] vfio/type1: Use iommu_paging_domain_alloc()
> >          https://git.kernel.org/iommu/c/60ffc4501722
> > [04/21] vhost-vdpa: Use iommu_paging_domain_alloc()
> >          https://git.kernel.org/iommu/c/9c159f6de1ae
> > [05/21] drm/msm: Use iommu_paging_domain_alloc()
> >          https://git.kernel.org/iommu/c/45acf35af200
> > 
> > [10/21] wifi: ath10k: Use iommu_paging_domain_alloc()
> >          https://git.kernel.org/iommu/c/d5b7485588df
> > [11/21] wifi: ath11k: Use iommu_paging_domain_alloc()
> >          https://git.kernel.org/iommu/c/ef50d41fbf1c
> > 
> > [14/21] RDMA/usnic: Use iommu_paging_domain_alloc()
> >          https://git.kernel.org/iommu/c/3b10f25704be
> > [15/21] iommu/vt-d: Add helper to allocate paging domain
> >          https://git.kernel.org/iommu/c/9e9ba576c259
> 
> Will, the patch [15/21] has already been included in my VT-d update pull
> request. I have also addressed Yi's comment in that patch. So can you
> please remove it from this branch?

Heh, was just about to say the same thing as I noticed when I was
re-creating 'next'. Yes, I'll drop it now. Since it's on the end, the
other SHAs will remain the same.

Sorry about that,

Will
