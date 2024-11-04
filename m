Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498D614B06C
	for <iommu@lists.linux.dev>; Mon,  4 Nov 2024 09:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730711745; cv=none; b=iyHRaHG8AIERq3rVZjG/YyrFLoyo/ED5C6AutlIe3ne1J8X/t8J2MzTZiSIOc4I+ZKEho3yK4xJFq/STwZJXndUQCHUPaDSFEjSxF0LGmDayvnTyU3z2C8vI0WQNME7v9n1F+9wrpKzWu2DoicJAMY5uSfSpckCM/35kGDuhvw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730711745; c=relaxed/simple;
	bh=whH3IYCWqcRqtcFRo50YtXAUZ1bpubiFNrKYl28nnMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BsRIPcx4a4+fctPioofszvbP1s7Zyg0UDZIKi8LmBe8wbVdz4gqhAeDhZbWbZUUeSxTTdC05TFms2MG02yhnz/lVFR3LLW0pIsBlau/X16bQHFaLNCPiHgZsH+Z2RSI61QVyTAq2m3ZW8eTlROP8uq/wll+ah+oo8/ankWegdXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 95A03227AAD; Mon,  4 Nov 2024 10:15:38 +0100 (CET)
Date: Mon, 4 Nov 2024 10:15:38 +0100
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Leon Romanovsky <leon@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Jason Gunthorpe <jgg@ziepe.ca>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Christoph Hellwig <hch@lst.de>,
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
	kvm@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v1 08/17] dma-mapping: add a dma_need_unmap helper
Message-ID: <20241104091538.GB25041@lst.de>
References: <cover.1730298502.git.leon@kernel.org> <00385b3557fa074865d37b0ac613d2cb28bcb741.1730298502.git.leon@kernel.org> <7e362d8b-c02a-4327-9c5d-af1c4725ddc7@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e362d8b-c02a-4327-9c5d-af1c4725ddc7@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Oct 31, 2024 at 09:18:11PM +0000, Robin Murphy wrote:
>>   +/**
>> + * dma_need_unmap - does this device need dma_unmap_* operations
>> + * @dev: device to check
>> + *
>> + * If this function returns %false, drivers can skip calling dma_unmap_* after
>> + * finishing an I/O.  This function must be called after all mappings that might
>> + * need to be unmapped have been performed.
>
> In terms of the unmap call itself, why don't we just use dma_skip_sync to 
> short-cut dma_direct_unmap_*() and make sure it's as cheap as possible?
>
> In terms of not having to unmap implying not having to store addresses at 
> all, it doesn't seem super-useful when you still have to store them for 
> long enough to find out that you don't :/

I don't fully understand the comment, mostly because the way I read the
two sentences appear to contradict each other.

Bypassing dma_direct_unmap_ is not the important part, because it already
is pretty cheap.  Storing the addresses is not.

That being said now that we never check need_unmap in the iova path
it might make sense to not have a separate helper, but it needs to
be exposed and documented.

