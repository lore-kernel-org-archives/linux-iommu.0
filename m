Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BABD422C659
	for <iommu@lists.linux.dev>; Sun, 24 Mar 2024 23:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322180; cv=none; b=KULK+AXSgIesUhTOeEEnOla+A8Fi7mBNG7Odh9JMYQU6vuxqJSHzURzjJRQioL0Toqi8NzLgZA7pWKczy8rb5DSE1A90OPvhRzjpRIeF+5kQWTtAXUqWCHtWBnfHhsM8dCOYElpd5HETwOD64tpPvcMUrDd5dBvg+c1OKdhByS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322180; c=relaxed/simple;
	bh=Y+++sfCOOqMd/jN8jYmvU8/LoJkxzD+F97Ejdpsn/YE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kQ1mYCN1+nxjDV0kogGz0CKPygAoOyzPFebTRn+1Hg112ftt041T5vs3Rmk+LIu5UHrvT933lfzJVcDu6+l7/ysIg2yl+YZuniHW/uKsn9qdjmz/6q683tqfpvMKQjM0AK4J5hUnmGsiqvJKswaVIr8pE3gtb4EeXKDepO/HpIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 38CAF68D13; Mon, 25 Mar 2024 00:16:12 +0100 (CET)
Date: Mon, 25 Mar 2024 00:16:11 +0100
From: Christoph Hellwig <hch@lst.de>
To: Leon Romanovsky <leon@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jason Gunthorpe <jgg@ziepe.ca>,
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
Message-ID: <20240324231611.GB20765@lst.de>
References: <20240307000036.GP9225@ziepe.ca> <20240307150505.GA28978@lst.de> <20240307210116.GQ9225@ziepe.ca> <20240308164920.GA17991@lst.de> <20240308202342.GZ9225@ziepe.ca> <20240309161418.GA27113@lst.de> <20240319153620.GB66976@ziepe.ca> <20240320085536.GA14887@unreal> <20240321224013.GB22663@lst.de> <20240322174617.GD14887@unreal>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240322174617.GD14887@unreal>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Mar 22, 2024 at 07:46:17PM +0200, Leon Romanovsky wrote:
> > As far as I can tell it totally misses the point.  Which is not to never
> > return non-P2P if the flag is set, but to return either all P2P or non-P2
> > P and not create a boundary in the single call.
> 
> You are treating FOLL_PCI_P2PDMA as a hint, but in iov_iter_extract_user_pages()
> you set it only for p2p queues. I was under impression that you want only p2p pages
> in these queues.

FOLL_PCI_P2PDMA is an indicator that the caller can cope with P2P
pages.  Most callers simply can't.

