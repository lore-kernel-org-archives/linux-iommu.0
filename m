Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3C733C7
	for <iommu@lists.linux.dev>; Fri,  5 Jul 2024 06:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720159214; cv=none; b=iXL1yoOAgbfSq9yf77JH7AffrO7CRRGyWAL1tH2FdLZvN+TX+QP0xxosOhXVfFm70iu9cg+H+4C9v6c2ds8O/kFJAmWQNTANwUhU+Ryn5Tcx7AWO2AYJK8x+PLEbGRF56rWPwKM5E20bVDtUEEGZRI7W/vhtv1zK6SxRbKYSwcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720159214; c=relaxed/simple;
	bh=bEiKWiIp+ak8oCw0ZIw72JufsSiXsBq+5pZdmrPzKzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pitMFY51n+YPB6D1WMyBvTrpN5RiZzqTi/FUvFM8OCXsrZ3dMXRaEkz8YHjLKYERN4K5RnINQqPpEo4Sn7SmdjuXD5EFY3gECoxF226Jcpi1wcARtZUQAjOa9LLH8KEWSHNUpJAAEFaAOOXT8pieMd0ar6JZSvpafIdRwX+LFzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id CC81268AA6; Fri,  5 Jul 2024 08:00:04 +0200 (CEST)
Date: Fri, 5 Jul 2024 08:00:03 +0200
From: Christoph Hellwig <hch@lst.de>
To: Leon Romanovsky <leon@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Jason Gunthorpe <jgg@ziepe.ca>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Keith Busch <kbusch@kernel.org>, "Zeng, Oak" <oak.zeng@intel.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	=?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, iommu@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
	kvm@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH v1 00/18] Provide a new two step DMA API mapping API
Message-ID: <20240705060003.GB11885@lst.de>
References: <cover.1719909395.git.leon@kernel.org> <20240703054238.GA25366@lst.de> <20240703105253.GA95824@unreal> <20240703143530.GA30857@lst.de> <20240703155114.GB95824@unreal> <20240704074855.GA26913@lst.de> <20240704131839.GD95824@unreal>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240704131839.GD95824@unreal>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Jul 04, 2024 at 04:18:39PM +0300, Leon Romanovsky wrote:
> > 2) The amount of seemingly unrelated global headers pulled into other
> > global headers.  Some of this might just be sloppiness, e.g. I can't
> > see why dma-mapping.h would actually need iommu.h to start with,
> > but pci.h in dma-map-ops.h is a no-go.
> 
> pci.h was pulled because I needed to call to pci_p2pdma_map_type()
> in dma_can_use_iova().

No, that's not the reason.  The reason is actually that whole
dev_use_swiotlb mess which shouldn't exist in this form.
