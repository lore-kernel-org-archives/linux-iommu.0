Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2E12071F8
	for <iommu@lists.linux.dev>; Fri,  8 Nov 2024 15:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731079805; cv=none; b=P3BAPih/ZT6f9UCH1xHaEFhxSQ7TEROKb0HIF6VAirM5jvpGqLDysW0fnYOfNIHWpgw32K75ZTQA19/O9I0TXK6TA7WN9n1z/Hsf38EBqG7zyfn7OtdaS2qRtXYlRKa9tXbQlaxh8+gjJseO2DJXRc73t6Q8lBGkm1A10it7PwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731079805; c=relaxed/simple;
	bh=D3sALsRkAmAqZzFBs4iIErHrW6jNVaQSA4lkqKn1bSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lx6Ly/0/b3qiNgTfk5WGgIfyBMndIRLW2NC08hnz0kW5qgbyLnqa68qArKfwXoK+vQ+tsnp8RelaHDUYf3iloCqNKteB4e+zSNRs0gO5H64HZtLon95RMZrp9VdM/TzP3da1Q6mkVzlr7o7/6u8LOwMIfV/uFABr/x3nu+FwUr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id DD28568B05; Fri,  8 Nov 2024 16:29:56 +0100 (CET)
Date: Fri, 8 Nov 2024 16:29:56 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>,
	Leon Romanovsky <leon@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	=?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-rdma@vger.kernel.org, iommu@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
	kvm@vger.kernel.org, linux-mm@kvack.org, matthew.brost@intel.com,
	Thomas.Hellstrom@linux.intel.com, brian.welty@intel.com,
	himal.prasad.ghimiray@intel.com, krishnaiah.bommu@intel.com,
	niranjana.vishwanathapura@intel.com
Subject: Re: [PATCH v1 00/17] Provide a new two step DMA mapping API
Message-ID: <20241108152956.GA12130@lst.de>
References: <cover.1730298502.git.leon@kernel.org> <3567312e-5942-4037-93dc-587f25f0778c@arm.com> <20241104095831.GA28751@lst.de> <20241105195357.GI35848@ziepe.ca> <20241107083256.GA9071@lst.de> <20241107132808.GK35848@ziepe.ca> <20241107135025.GA14996@lst.de> <20241108150226.GM35848@ziepe.ca> <20241108150500.GA10102@lst.de> <20241108152537.GN35848@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241108152537.GN35848@ziepe.ca>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Nov 08, 2024 at 11:25:37AM -0400, Jason Gunthorpe wrote:
> I'm asking how it will work if you change the struct page argument to
> physical, because today dma_direct_map_page() has:
> 
> 		if (is_pci_p2pdma_page(page))
> 			return DMA_MAPPING_ERROR;
> 
> Which is exactly the sorts of things I'm looking at when when I say to
> get rid of struct page.

It will have to look up the page from the physical address obviously.
But at least only in the error path.

> What I'm thinking about is replacing code like the above with something like:
> 
> 		if (p2p_provider)
> 			return DMA_MAPPING_ERROR;
> 
> And the caller is the one that would have done is_pci_p2pdma_page()
> and either passes p2p_provider=NULL or page->pgmap->p2p_provider.

And where do you get that one from?

