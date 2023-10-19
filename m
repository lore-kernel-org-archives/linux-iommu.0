Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F9730FB0
	for <iommu@lists.linux.dev>; Thu, 19 Oct 2023 15:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Bn7c8NCn"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=F6/o8Z2i9JKu0badnkbxfHnQMRLlqY5LsHFDEapT+28=; b=Bn7c8NCnrwcQo+noH2OfISTeA8
	aqUXazCmB5GvGk0CcmE32SJCRThvwDB1QTSQF5MMjRHD5Yf8g+hTFjkKmFUOuEhkpZuJDOxw2WVps
	EMxWY4mdYr6Y4asGY7Kea7ytQwabrEXmq6YE/pHQD/lk8GcWRUvNYJHqrOzuAf2gDm2mClSSHBVRJ
	ydO7nqQpSJcwhjey3LYzd8Y8rxzAyKGrRphz5mpD0X2egoJukybHXdMwnv2PJmyJuLFWdFdrQPeNF
	YPfM5h0SYw0QnmWab3l03QI4Uupp+Xc9vBWeWCYpMiIo7gHGbJ6hBOozZy5+NkKvqSL6uvXkIJhTZ
	7ltrLYTw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1qtVLD-007u7P-Tf; Thu, 19 Oct 2023 15:53:43 +0000
Date: Thu, 19 Oct 2023 16:53:43 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Chuck Lever <cel@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Alexander Potapenko <glider@google.com>, linux-mm@kvack.org,
	linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	kasan-dev@googlegroups.com, David Howells <dhowells@redhat.com>,
	iommu@lists.linux.dev, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH RFC 0/9] Exploring biovec support in (R)DMA API
Message-ID: <ZTFRBxVFQIjtQEsP@casper.infradead.org>
References: <169772852492.5232.17148564580779995849.stgit@klimt.1015granger.net>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <169772852492.5232.17148564580779995849.stgit@klimt.1015granger.net>

On Thu, Oct 19, 2023 at 11:25:31AM -0400, Chuck Lever wrote:
> The SunRPC stack manages pages (and eventually, folios) via an
> array of struct biovec items within struct xdr_buf. We have not
> fully committed to replacing the struct page array in xdr_buf
> because, although the socket API supports biovec arrays, the RDMA
> stack uses struct scatterlist rather than struct biovec.
> 
> This (incomplete) series explores what it might look like if the
> RDMA core API could support struct biovec array arguments. The
> series compiles on x86, but I haven't tested it further. I'm posting
> early in hopes of starting further discussion.

Good call, because I think patch 2/9 is a complete non-starter.

The fundamental problem with scatterlist is that it is both input
and output for the mapping operation.  You're replicating this mistake
in a different data structure.

My vision for the future is that we have phyr as our input structure.
That looks something like:

struct phyr {
	phys_addr_t start;
	size_t len;
};

On 32-bit, that's 8 or 12 bytes; on 64-bit it's 16 bytes.  This is
better than biovec because biovec is sometimes larger than that, and
it allows specifying IO to memory that does not have a struct page.

Our output structure can continue being called the scatterlist, but
it needs to go on a diet and look more like:

struct scatterlist {
	dma_addr_t dma_address;
	size_t dma_length;
};

Getting to this point is going to be a huge amount of work, and I need
to finish folios first.  Or somebody else can work on it ;-)
