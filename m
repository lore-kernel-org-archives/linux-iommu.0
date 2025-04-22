Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4FC8828
	for <iommu@lists.linux.dev>; Tue, 22 Apr 2025 04:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745296805; cv=none; b=SoX7pBE50IcnO8nR49MViy90To4nn5K1MIuLqG9bLZQGrr7AvbaXm43TxRHSUKyhAVdTtEIKLkOsOY4wEVtXz5/+vzEHoEbbF0HkWo1pRzFZb4DFfMtRTp6lKOnLgJp198agh1/iX3uDEPX48NUoDpbXya0/hkfd/Ib75zjogu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745296805; c=relaxed/simple;
	bh=CpQQRZuyWfvKRbSY9l+oYTtKKd/SUjT2q+YM4GZSr6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eRFGBx9t6Y4eTwpaRhv1vDy+4Sg0u+nRaG0ka3MRkXrjTfJ5nOUkSWOWh+ACHX7xUoZ2FsqYDnOlh4z9IADtoxJ68ebugXVxKOlaUcqb8x8uzKwwyNoi3UzKs1Yl/7xsm9bdymejGbx/0I3kUO9H6s6XFkiHlZsr3Oq0mrI3kIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 89EBF68BFE; Tue, 22 Apr 2025 06:39:56 +0200 (CEST)
Date: Tue, 22 Apr 2025 06:39:56 +0200
From: Christoph Hellwig <hch@lst.de>
To: Leon Romanovsky <leon@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Kanchan Joshi <joshi.k@samsung.com>, Jake Edge <jake@lwn.net>,
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
	Chaitanya Kulkarni <kch@nvidia.com>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: Re: [PATCH v8 24/24] nvme-pci: optimize single-segment handling
Message-ID: <20250422043955.GA28077@lst.de>
References: <cover.1744825142.git.leon@kernel.org> <670389227a033bd5b7c5aa55191aac9943244028.1744825142.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <670389227a033bd5b7c5aa55191aac9943244028.1744825142.git.leon@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Apr 18, 2025 at 09:47:54AM +0300, Leon Romanovsky wrote:
> From: Kanchan Joshi <joshi.k@samsung.com>
> 
> blk_rq_dma_map API is costly for single-segment requests.
> Avoid using it and map the bio_vec directly.

This needs to be folded into the earlier patches or split prep patches
instead of undoing work done earlier, preferably combined with a bit
of code movement so that the new nvme_try_setup_prp_simple stays in
the same place as before and the diff shows it reusing code.

E.g. change

"nvme-pci: use a better encoding for small prp pool allocations" to
already use the flags instead of my boolean, and maybe include 
abort in the flags instead of using a separate bool so that we
don't increase hte iod size.

Slot in a new patch after that that dropping the single SGL segment
fastpath if we think we don't need that, although if we need the PRP
one I suspect that one would still be very helpful as well.

Add a patch if we want the try_ version of, although when keeping
the optimization for SGLs as well that are will look a bit different.

I'm happy to give away my patch authorship credits if that helps with
the folding.
