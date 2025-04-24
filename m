Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F68E552
	for <iommu@lists.linux.dev>; Thu, 24 Apr 2025 08:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745482270; cv=none; b=SS2UPv/qf1DpQPrU2G3prUIvONJDBZZ+SIbnADs50UHjkqk+yJDICIUCAvu4e8SalfTTalQMcU9i9jZCAFzBzxo+OL4uYMA1CUKG7BQlA/duKOXGlIw4IkKi39hUvoUlD6PS7rm8m+fevAYVSlXGBY1ccg7U0JIvNoPSa8Z+rac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745482270; c=relaxed/simple;
	bh=JGL3psGtkPH2/js8ND1zwM6GdWFnAznTJQ556NVu1Dw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G8wv9OFH2SHHocTos16r6HQtbNYD5o/zgz6EeQiOpe1tRkxc/Pyk6o3sRj3xB7YDhN7P3ITvCPFgwxMZydps3BnwUfofenV2/z6qb1F2s+S2WAAut/vWZuKTYxdeJkhOj5T//Dp03kNfTsYAoA4/+n5bgk0YU53LYFatLZL4eFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2F45667373; Thu, 24 Apr 2025 10:11:01 +0200 (CEST)
Date: Thu, 24 Apr 2025 10:11:01 +0200
From: Christoph Hellwig <hch@lst.de>
To: Leon Romanovsky <leon@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	Mika =?iso-8859-1?Q?Penttil=E4?= <mpenttil@redhat.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>, Jake Edge <jake@lwn.net>,
	Jonathan Corbet <corbet@lwn.net>, Zhu Yanjun <zyjzyj2000@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	=?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
	iommu@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-pci@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH v9 10/24] mm/hmm: let users to tag specific PFN with
 DMA mapped bit
Message-ID: <20250424081101.GA22989@lst.de>
References: <cover.1745394536.git.leon@kernel.org> <0a7c1e06269eee12ff8912fe0da4b7692081fcde.1745394536.git.leon@kernel.org> <7185c055-fc9e-4510-a9bf-6245673f2f92@redhat.com> <20250423181706.GT1213339@ziepe.ca> <36891b0e-d5fa-4cf8-a181-599a20af1da3@redhat.com> <20250423233335.GW1213339@ziepe.ca> <20250424080744.GP48485@unreal>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250424080744.GP48485@unreal>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Apr 24, 2025 at 11:07:44AM +0300, Leon Romanovsky wrote:
> > I see, so yes order occupies 5 bits [-4,-5,-6,-7,-8] and the
> > DMA_MAPPED overlaps, it should be 9 not 7 because of the backwardness.
> 
> Thanks for the fix.

Maybe we can use the chance to make the scheme less fragile?  i.e.
put flags in the high bits and derive the first valid bit from the
pfn order?
