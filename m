Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976DE259496
	for <iommu@lists.linux.dev>; Thu, 12 Dec 2024 08:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733992505; cv=none; b=r8kXxAYiYmBabR0brlNITjMa+XvtduFDeTcTeUnyqkxP0VmmbsLa+3CHtvmA3M9nNSVAD/EdKmLv+1znUa02sQI4SshfSo3JHsbxARinbbqHzVlQw4pNFWmzLCXVEZObkJSyc0Sv7PHSRcx+3BeoRbsD8rjYB6syziXRusaiRVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733992505; c=relaxed/simple;
	bh=rrBYBkbHZcn5I1aF3U8lL3NmmSK4aCBmuavcvGmQk1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n2JrAlf9ckt7U//gtOF/SOYEx7gUEwE7vBOepX1Jhq2NypDuQZLAZWnKqcUNAtwu6uSk2lXJPy4+ZnPTgV2RPF+3O7NzSLC9DEZO0l9KxZvY07JDV2igU4h4f4qRzt11khM4bcneImXDpt+2LG/hJm42otG9ui4ce1PIRRGSocs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id AE9AF68D12; Thu, 12 Dec 2024 09:34:59 +0100 (CET)
Date: Thu, 12 Dec 2024 09:34:59 +0100
From: Christoph Hellwig <hch@lst.de>
To: Leon Romanovsky <leon@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Jason Gunthorpe <jgg@ziepe.ca>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Leon Romanovsky <leonro@nvidia.com>,
	Keith Busch <kbusch@kernel.org>,
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
	kvm@vger.kernel.org, linux-mm@kvack.org,
	Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v4 05/18] dma-mapping: Add check if IOVA can be used
Message-ID: <20241212083459.GB9376@lst.de>
References: <cover.1733398913.git.leon@kernel.org> <b23a1e29f00f31f31641479c90f2471aee27fac5.1733398913.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b23a1e29f00f31f31641479c90f2471aee27fac5.1733398913.git.leon@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Dec 05, 2024 at 03:21:04PM +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> This patch adds a check if IOVA can be used for the specific
> transaction.
> 
> In the new API a DMA mapping transaction is identified by a
> struct dma_iova_state, which holds some recomputed information
> for the transaction which does not change for each page being
> mapped.

While the content of the patch here looks fine, the super fine
grained patch split look really odd and makes sensible review
hard.  Was this a request on one of the earlier versions?

