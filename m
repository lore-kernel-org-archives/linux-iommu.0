Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4B224A887
	for <iommu@lists.linux.dev>; Sun, 24 Mar 2024 23:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322544; cv=none; b=Elgpk4sRNNqEVf91biUgW0hNnVoVKrjc0KuCmt8q9ggI9qfVX1vlHyhG3A5+1X3SghcmrN2zi2MYS3WvCXw2pHhD4hyYV2ukkYOcFa92FQyFuSrRJUXzFAiSKBL2J57BYfikUPInViilGbt3SKBgBWOmDiuXf+Yj7MBh88HR2nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322544; c=relaxed/simple;
	bh=QD2J7s+PbQMl/4TLX0Q9/+FJg4j9efgCpQRUHwRCQyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gb1myotSpjoCGx4CMmtCWx++AN5XWxxh9W2rckZU5Qzgr/5V/d7UR4N2H5dmytnhsDVpgICCaDV14rf41cKc6jdzVjxge1h/hajw+BCNaY3aVFyoOQWSJdzSybyKwC2yS+ZDhGj9PsZ7Qowu470j+B3riPQCqW50+BolkhpHvto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 08B4F68D0F; Mon, 25 Mar 2024 00:22:16 +0100 (CET)
Date: Mon, 25 Mar 2024 00:22:15 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Christoph Hellwig <hch@lst.de>, Leon Romanovsky <leon@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Jonathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	=?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
	iommu@lists.linux.dev, linux-nvme@lists.infradead.org,
	kvm@vger.kernel.org, linux-mm@kvack.org,
	Bart Van Assche <bvanassche@acm.org>,
	Damien Le Moal <damien.lemoal@opensource.wdc.com>,
	Amir Goldstein <amir73il@gmail.com>,
	"josef@toxicpanda.com" <josef@toxicpanda.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>,
	Dan Williams <dan.j.williams@intel.com>,
	"jack@suse.com" <jack@suse.com>, Zhu Yanjun <zyjzyj2000@gmail.com>
Subject: Re: [RFC RESEND 00/16] Split IOMMU DMA mapping operation to two
 steps
Message-ID: <20240324232215.GC20765@lst.de>
References: <20240306221400.GA8663@lst.de> <20240307000036.GP9225@ziepe.ca> <20240307150505.GA28978@lst.de> <20240307210116.GQ9225@ziepe.ca> <20240308164920.GA17991@lst.de> <20240308202342.GZ9225@ziepe.ca> <20240309161418.GA27113@lst.de> <20240319153620.GB66976@ziepe.ca> <20240321223910.GA22663@lst.de> <20240322184330.GL66976@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240322184330.GL66976@ziepe.ca>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Mar 22, 2024 at 03:43:30PM -0300, Jason Gunthorpe wrote:
> If we are going to make caller provided uniformity a requirement, lets
> imagine a formal memory type idea to help keep this a little
> abstracted?
> 
>  DMA_MEMORY_TYPE_NORMAL
>  DMA_MEMORY_TYPE_P2P_NOT_ACS
>  DMA_MEMORY_TYPE_ENCRYPTED
>  DMA_MEMORY_TYPE_BOUNCE_BUFFER  // ??
> 
> Then maybe the driver flow looks like:
> 
> 	if (transaction.memory_type == DMA_MEMORY_TYPE_NORMAL && dma_api_has_iommu(dev)) {

Add a nice helper to make this somewhat readable, but yes.

> 	} else if (transaction.memory_type == DMA_MEMORY_TYPE_P2P_NOT_ACS) {
> 		num_hwsgls = transcation.num_sgls;
> 		for_each_range(transaction, range) {
> 			hwsgl[i].addr = dma_api_p2p_not_acs_map(range.start_physical, range.length, p2p_memory_provider);
> 			hwsgl[i].len = range.size;
> 		}
> 	} else {
> 		/* Must be DMA_MEMORY_TYPE_NORMAL, DMA_MEMORY_TYPE_ENCRYPTED, DMA_MEMORY_TYPE_BOUNCE_BUFFER? */
> 		num_hwsgls = transcation.num_sgls;
> 		for_each_range(transaction, range) {
> 			hwsgl[i].addr = dma_api_map_cpu_page(range.start_page, range.length);
> 			hwsgl[i].len = range.size;
> 		}
>

And these two are really the same except that we call a different map
helper underneath.  So I think as far as the driver is concerned
they should be the same, the DMA API just needs to key off the
memory tap.

> And the hmm_range_fault case is sort of like:
> 
> 		struct dma_api_iommu_state state;
> 		dma_api_iommu_start(&state, mr.num_pages);
> 
> 		[..]
> 		hmm_range_fault(...)
> 		if (present)
> 			dma_link_page(&state, faulting_address_offset, page);
> 		else
> 			dma_unlink_page(&state, faulting_address_offset, page);
> 
> Is this looking closer?

Yes.

> > > So I take it as a requirement that RDMA MUST make single MR's out of a
> > > hodgepodge of page types. RDMA MRs cannot be split. Multiple MR's are
> > > not a functional replacement for a single MR.
> > 
> > But MRs consolidate multiple dma addresses anyway.
> 
> I'm not sure I understand this?

The RDMA MRs take a a list of PFNish address, (or SGLs with the
enhanced MRs from Mellanox) and give you back a single rkey/lkey.

> To go back to my main thesis - I would like a high performance low
> level DMA API that is capable enough that it could implement
> scatterlist dma_map_sg() and thus also implement any future
> scatterlist_v2, bio, hmm_range_fault or any other thing we come up
> with on top of it. This is broadly what I thought we agreed to at LSF
> last year.

I think the biggest underlying problem of the scatterlist based
DMA implementation for IOMMUs is that it's trying to handle to much,
that is magic coalescing even if the segments boundaries don't align
with the IOMMU page size.  If we can get rid of that misfeature I
think we'd greatly simply the API and implementation.
