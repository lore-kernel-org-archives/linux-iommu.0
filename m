Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4CD1799F
	for <iommu@lists.linux.dev>; Tue, 29 Jul 2025 10:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753785668; cv=none; b=r943OlqJwtSgCdX/v7BlntsSavM4lEaNx47D4n7BzZwNJIJrp2WYuVbHOqYYofz/CPr0Tc/STSJQABXi04gF0KcA/o84pnb/iDp3ZDhLBcXMLEuDmGpHG9bTcmXaCpM6NwZut3qxUknAZw/x16zIx+MAxTeUsfSPuIyJXUqfrTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753785668; c=relaxed/simple;
	bh=hB810dymkUE8vn2hoLlDxLRpBGl/LHNWTNB6ohp4T7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Il3At8ediF8Z5RtjmNUQ5ZWkTU4eOiOQNHEFy2sSTSr0Uv+AY/4snvU31+83FuaM1cgGRZgAuMokBvzuG9+Lw6O4T3rL11oTAFCnRICk2WkOrbymVPATj5Xqw7uv+pP7H3PmTly2M0URx+g6JNK4EoOBqpa3gyGcp7VAMF5cRvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id DDC6668AFE; Tue, 29 Jul 2025 12:41:00 +0200 (CEST)
Date: Tue, 29 Jul 2025 12:41:00 +0200
From: Christoph Hellwig <hch@lst.de>
To: Leon Romanovsky <leon@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jason Gunthorpe <jgg@nvidia.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	dri-devel@lists.freedesktop.org, iommu@lists.linux.dev,
	Jens Axboe <axboe@kernel.dk>,
	=?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
	Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
	linaro-mm-sig@lists.linaro.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
	linux-mm@kvack.org, linux-pci@vger.kernel.org,
	Logan Gunthorpe <logang@deltatee.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH 02/10] PCI/P2PDMA: Introduce p2pdma_provider structure
 for cleaner abstraction
Message-ID: <20250729104100.GA29053@lst.de>
References: <cover.1753274085.git.leonro@nvidia.com> <c2307cb4c3f1af46da138f3410738754691fbb3d.1753274085.git.leonro@nvidia.com> <20250724075145.GB30590@lst.de> <20250724075533.GR402218@unreal> <20250724075922.GD30590@lst.de> <20250727185158.GE7551@nvidia.com> <20250729075209.GA23823@lst.de> <20250729085336.GG402218@unreal>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250729085336.GG402218@unreal>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Jul 29, 2025 at 11:53:36AM +0300, Leon Romanovsky wrote:
> > Because the struct page is the only thing that:
> > 
> >  a) dma-mapping works on
> >  b) is the only place we can discover the routing information, but also
> >     more importantly ensure that the underlying page is still present
> >     and the device is not hot unplugged, or in a very theoretical worst
> >     case replaced by something else.
> 
> It is correct in general case, but here we are talking about MMIO
> memory, which is "connected" to device X and routing information is
> stable.

MMIO is literally the only thing we support to P2P to/from as that is
how PCIe P2P is defined.  And not, it's not stable - devices can be
unplugged, and BARs can be reenumerated.

