Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EDCB4085E
	for <iommu@lists.linux.dev>; Sat,  9 Mar 2024 16:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710000872; cv=none; b=hhpMJXDZoJMe8NMIewbR/wWQm/L84j+h91mMP5SBWpRooKLjrQmsI6vUiAJGWIUlmhvcuG2IRP6469JwFw0z5rqCweTN7m3Fme+tcM9xT4Lqim7QDVfoNrq1X3nFAjJ2vDTs8dFIzBqgdgraBb6ymlulhz/KfaAGbGES5SD0cjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710000872; c=relaxed/simple;
	bh=I+7esQ6+7JWFVXLFfl3zXTTqxKwmpRLYFXlpXXMY+wg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bydErx1FjhNEW08KJUDgKOmIGCQzl/Yk79gOMLRyfFTcuiQ1KoIaMYcQt37K16jGD3zaQcdkYWns1D6ERIUJWaUxejm/6367cd5FWvSCS+HkEsXDpDdo5Ub6GBA8SNvBSTY+ZQ18j3RWNMnvHrfpKf7KWdLpgtZIekz+5+HBKTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id B0C9D68BFE; Sat,  9 Mar 2024 17:14:18 +0100 (CET)
Date: Sat, 9 Mar 2024 17:14:18 +0100
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
Message-ID: <20240309161418.GA27113@lst.de>
References: <20240306144416.GB19711@lst.de> <20240306154328.GM9225@ziepe.ca> <20240306162022.GB28427@lst.de> <20240306174456.GO9225@ziepe.ca> <20240306221400.GA8663@lst.de> <20240307000036.GP9225@ziepe.ca> <20240307150505.GA28978@lst.de> <20240307210116.GQ9225@ziepe.ca> <20240308164920.GA17991@lst.de> <20240308202342.GZ9225@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240308202342.GZ9225@ziepe.ca>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Mar 08, 2024 at 04:23:42PM -0400, Jason Gunthorpe wrote:
> > The DMA API callers really need to know what is P2P or not for
> > various reasons.  And they should generally have that information
> > available, either from pin_user_pages that needs to special case
> > it or from the in-kernel I/O submitter that build it from P2P and
> > normal memory.
> 
> I think that is a BIO thing. RDMA just calls with FOLL_PCI_P2PDMA and
> shoves the resulting page list into in a scattertable. It never checks
> if any returned page is P2P - it has no reason to care. dma_map_sg()
> does all the work.

Right now it does, but that's not really a good interface.  If we have
a pin_user_pages variant that only pins until the next relevant P2P
boundary and tells you about we can significantly simplify the overall
interface.
