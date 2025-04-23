Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025371A08A4
	for <iommu@lists.linux.dev>; Wed, 23 Apr 2025 15:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745423239; cv=none; b=QIhcAXJzjoGjjFCUXlVtTr/bKpKitZ9tuJxEYHlQZzzlNpLyztIH/QwRad+81qurvTvsrPTdFBJMhDpNI+QbWUhBy1de6nrjNR2uvBRwwlpQJLFNNMazx30C2RcKUHqKz8+IYjNoFKzgKXm3LO885WFtzLlCLeTqhMttdbhYP9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745423239; c=relaxed/simple;
	bh=d0E+HtNmdn/LhlxxF/h1C5SJbuFpS6D0hMGAOAoU4xM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W6ibrVmvf2RzVzp4nVU7FHfTv1g1wdi5u2CyTXYA66CNhLzGWojEqNkZtTbjt1GJf8WcG2MP6geXjTsl7nJEktegv8QuD4sEiWT9NucAFoMgGsoAYCzIUZkhvn8FYNh5gBFPGLUxZ9eODOItspiIU04vz9prPo3Pmd2X9VjIoYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8A79D68C4E; Wed, 23 Apr 2025 17:47:12 +0200 (CEST)
Date: Wed, 23 Apr 2025 17:47:12 +0200
From: Christoph Hellwig <hch@lst.de>
To: Leon Romanovsky <leon@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Jens Axboe <axboe@kernel.dk>, Jake Edge <jake@lwn.net>,
	Jonathan Corbet <corbet@lwn.net>, Jason Gunthorpe <jgg@ziepe.ca>,
	Zhu Yanjun <zyjzyj2000@gmail.com>,
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
	Chaitanya Kulkarni <kch@nvidia.com>,
	Nitesh Shetty <nj.shetty@samsung.com>
Subject: Re: [PATCH v9 23/24] nvme-pci: convert to blk_rq_dma_map
Message-ID: <20250423154712.GA32009@lst.de>
References: <cover.1745394536.git.leon@kernel.org> <7c5c5267cba2c03f6650444d4879ba0d13004584.1745394536.git.leon@kernel.org> <20250423092437.GA1895@lst.de> <20250423100314.GH48485@unreal>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250423100314.GH48485@unreal>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Apr 23, 2025 at 01:03:14PM +0300, Leon Romanovsky wrote:
> On Wed, Apr 23, 2025 at 11:24:37AM +0200, Christoph Hellwig wrote:
> > I don't think the meta SGL handling is quite right yet, and the
> > single segment data handling also regressed.  Totally untested
> > patch below, I'll try to allocate some testing time later today.
> 
> Christoph,
> 
> Can we please progress with the DMA patches and leave NVMe for later?
> NVMe is one the users for new DMA API, let's merge API first.

We'll need to merge the block/nvme patches through the block tree
anyway to avoid merges from hell, so yes.

