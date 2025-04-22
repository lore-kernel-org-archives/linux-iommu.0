Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27074196
	for <iommu@lists.linux.dev>; Tue, 22 Apr 2025 04:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745296055; cv=none; b=lrO/RHhtJrQGtq78/exKGaJxyK6rnU3V9APrWo/YXn/D5RvMXnyP+paHDEaE5hnjljkZj6cRO7XFEbx5MFgGr4MiA7MTlN3ASA719E+3+VpsvjA8mx/GHNWpSEQJawF0O3Pi3jK3Sjrt3P185ed38gv2jj5NUQOP7k1DqRQOxeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745296055; c=relaxed/simple;
	bh=PLSm/GNxIQKdFcbfEfmuNrKOANZViQEJeLI7/wm2bbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fln3cN+wQnxbCYVVKwYOZk6QOMxq27DGofYnwF78ZQRp6iyecMw0QMGhEax7hGDHHwAvgQt1x6WbCvDY0htW7zjdjNxIjAzrNVck6AkOF53/ys0Pn6sblzM2lJfsfTowl5MtyZ75GssQ09HvnybwWMNewG1GvWL3d/Lct9Djqdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 17A2568C4E; Tue, 22 Apr 2025 06:27:28 +0200 (CEST)
Date: Tue, 22 Apr 2025 06:27:27 +0200
From: Christoph Hellwig <hch@lst.de>
To: Leon Romanovsky <leon@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>, Jake Edge <jake@lwn.net>,
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
	Leon Romanovsky <leonro@nvidia.com>
Subject: Re: [PATCH v8 20/24] blk-mq: add scatterlist-less DMA mapping
 helpers
Message-ID: <20250422042727.GC27723@lst.de>
References: <cover.1744825142.git.leon@kernel.org> <87b151a3791d71e58ec6f1b42bcf5fe06304cf80.1744825142.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87b151a3791d71e58ec6f1b42bcf5fe06304cf80.1744825142.git.leon@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Apr 18, 2025 at 09:47:50AM +0300, Leon Romanovsky wrote:
> +#define blk_phys_to_page(_paddr) \
> + 	(pfn_to_page(__phys_to_pfn(_paddr)))

The code can use phys_to_page now that that is provided kernel-wide
instead this temporary helper.

