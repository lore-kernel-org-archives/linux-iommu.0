Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6D15236
	for <iommu@lists.linux.dev>; Mon, 23 Oct 2023 05:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2FE7368AA6; Mon, 23 Oct 2023 07:59:52 +0200 (CEST)
Date: Mon, 23 Oct 2023 07:59:51 +0200
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Christoph Hellwig <hch@lst.de>, Matthew Wilcox <willy@infradead.org>,
	Chuck Lever <cel@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Alexander Potapenko <glider@google.com>, linux-mm@kvack.org,
	linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	kasan-dev@googlegroups.com, David Howells <dhowells@redhat.com>,
	iommu@lists.linux.dev
Subject: Re: [PATCH RFC 0/9] Exploring biovec support in (R)DMA API
Message-ID: <20231023055951.GB11569@lst.de>
References: <169772852492.5232.17148564580779995849.stgit@klimt.1015granger.net> <ZTFRBxVFQIjtQEsP@casper.infradead.org> <20231020045849.GA12269@lst.de> <41218260-1e5f-4d36-8287-fc6f50f3ec00@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41218260-1e5f-4d36-8287-fc6f50f3ec00@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Oct 20, 2023 at 11:30:06AM +0100, Robin Murphy wrote:
>> Well, we can stage this.  I wish I could find my old proposal about the
>> dma_batch API (I remember Robin commented on it, my he is better at
>> finding it than me).
>
> Heh, the dirty secret is that Office 365 is surprisingly effective at 
> searching 9 years worth of email I haven't deleted :)
>
> https://lore.kernel.org/linux-iommu/79926b59-0eb9-2b88-b1bb-1bd472b10370@arm.com/

Perfect, thanks!

> The other thing that's clear by now is that I think we definitely want 
> distinct APIs for "please map this bunch of disjoint things" for true 
> scatter-gather cases like biovecs where it's largely just convenient to 
> keep them grouped together (but opportunistic merging might still be a 
> bonus), vs. "please give me a linearised DMA mapping of these pages (and 
> fail if you can't)" for the dma-buf style cases.

Hmm, I'm not sure I agree.  For both the iommu and swiotlb case we
get the linear mapping for free with small limitations:

 - for the iommu case the alignment needs to be a multiple of the iommu
   page size
 - for swiotlb the size of each mapping is very limited

If these conditions are matched we can linearize for free, if they aren't
we can't linearize at all.

But maybe I'm missing something?

