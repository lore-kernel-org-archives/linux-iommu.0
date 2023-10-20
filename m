Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFC2A41
	for <iommu@lists.linux.dev>; Fri, 20 Oct 2023 04:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: by verein.lst.de (Postfix, from userid 2407)
	id EA8CA67373; Fri, 20 Oct 2023 06:58:49 +0200 (CEST)
Date: Fri, 20 Oct 2023 06:58:49 +0200
From: Christoph Hellwig <hch@lst.de>
To: Matthew Wilcox <willy@infradead.org>
Cc: Chuck Lever <cel@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Alexander Potapenko <glider@google.com>, linux-mm@kvack.org,
	linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	kasan-dev@googlegroups.com, David Howells <dhowells@redhat.com>,
	iommu@lists.linux.dev, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH RFC 0/9] Exploring biovec support in (R)DMA API
Message-ID: <20231020045849.GA12269@lst.de>
References: <169772852492.5232.17148564580779995849.stgit@klimt.1015granger.net> <ZTFRBxVFQIjtQEsP@casper.infradead.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTFRBxVFQIjtQEsP@casper.infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Oct 19, 2023 at 04:53:43PM +0100, Matthew Wilcox wrote:
> > RDMA core API could support struct biovec array arguments. The
> > series compiles on x86, but I haven't tested it further. I'm posting
> > early in hopes of starting further discussion.
> 
> Good call, because I think patch 2/9 is a complete non-starter.
> 
> The fundamental problem with scatterlist is that it is both input
> and output for the mapping operation.  You're replicating this mistake
> in a different data structure.

Agreed.

> 
> My vision for the future is that we have phyr as our input structure.
> That looks something like:
> 
> struct phyr {
> 	phys_addr_t start;
> 	size_t len;
> };

So my plan was always to turn the bio_vec into that structure, since
before you came u wit hthe phyr name.  But that's really a separate
discussion as we might as well support multiple input formats if we
really have to.

> Our output structure can continue being called the scatterlist, but
> it needs to go on a diet and look more like:
> 
> struct scatterlist {
> 	dma_addr_t dma_address;
> 	size_t dma_length;
> };

I called it a dma_vec in my years old proposal I can't find any more.

> Getting to this point is going to be a huge amount of work, and I need
> to finish folios first.  Or somebody else can work on it ;-)

Well, we can stage this.  I wish I could find my old proposal about the
dma_batch API (I remember Robin commented on it, my he is better at
finding it than me).  I think that mostly still stands, independent
of the transformation of the input structure.  The basic idea is that
we add a dma batching API, where you start a batch with one call,
and then add new physically discontiguous vectors to add it until
it is full and finalized it.  Very similar to how the iommu API
works internally.  We'd then only use this API if we actually have
an iommu (or if we want to be fancy swiotlb that could do the same
linearization), for the direct map we'd still do the equivalent
of dma_map_page for each element as we need one output vector per
input vector anyway.

As Jason pointed out the only fancy implementation we need for now
is the IOMMU API.  arm32 and powerpc will need to do the work
to convert to it or do their own work.
