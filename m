Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E225E225DA
	for <iommu@lists.linux.dev>; Thu, 19 Oct 2023 16:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 892062F4;
	Thu, 19 Oct 2023 09:43:55 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0AD7E3F762;
	Thu, 19 Oct 2023 09:43:12 -0700 (PDT)
Message-ID: <3f5d24f0-5e06-42d5-8e73-d874dd5ffa3d@arm.com>
Date: Thu, 19 Oct 2023 17:43:11 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/9] Exploring biovec support in (R)DMA API
Content-Language: en-GB
To: Chuck Lever <cel@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
 Chuck Lever <chuck.lever@oracle.com>, Alexander Potapenko
 <glider@google.com>, linux-mm@kvack.org, linux-rdma@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>, kasan-dev@googlegroups.com,
 David Howells <dhowells@redhat.com>, iommu@lists.linux.dev,
 Christoph Hellwig <hch@lst.de>, Jason Gunthorpe <jgg@nvidia.com>
References: <169772852492.5232.17148564580779995849.stgit@klimt.1015granger.net>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <169772852492.5232.17148564580779995849.stgit@klimt.1015granger.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19/10/2023 4:25 pm, Chuck Lever wrote:
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
> 
> Are there other upper layer API consumers, besides SunRPC, who might
> prefer the use of biovec over scatterlist?
> 
> Besides handling folios as well as single pages in bv_page, what
> other work might be needed in the DMA layer?

Eww, please no. It's already well established that the scatterlist 
design is horrible and we want to move to something sane and actually 
suitable for modern DMA scenarios. Something where callers can pass a 
set of pages/physical address ranges in, and get a (separate) set of DMA 
ranges out. Without any bonkers packing of different-length lists into 
the same list structure. IIRC Jason did a bit of prototyping a while 
back, but it may be looking for someone else to pick up the idea and 
give it some more attention.

What we definitely don't what at this point is a copy-paste of the same 
bad design with all the same problems. I would have to NAK patch 8 on 
principle, because the existing iommu_dma_map_sg() stuff has always been 
utterly mad, but it had to be to work around the limitations of the 
existing scatterlist design while bridging between two other established 
APIs; there's no good excuse for having *two* copies of all that to 
maintain if one doesn't have an existing precedent to fit into.

Thanks,
Robin.

> What RDMA core APIs should be converted? IMO a DMA mapping and
> registration API for biovecs would be needed. Maybe RDMA Read and
> Write too?
> 
> ---
> 
> Chuck Lever (9):
>        dma-debug: Fix a typo in a debugging eye-catcher
>        bvec: Add bio_vec fields to manage DMA mapping
>        dma-debug: Add dma_debug_ helpers for mapping bio_vec arrays
>        mm: kmsan: Add support for DMA mapping bio_vec arrays
>        dma-direct: Support direct mapping bio_vec arrays
>        DMA-API: Add dma_sync_bvecs_for_cpu() and dma_sync_bvecs_for_device()
>        DMA: Add dma_map_bvecs_attrs()
>        iommu/dma: Support DMA-mapping a bio_vec array
>        RDMA: Add helpers for DMA-mapping an array of bio_vecs
> 
> 
>   drivers/iommu/dma-iommu.c   | 368 ++++++++++++++++++++++++++++++++++++
>   drivers/iommu/iommu.c       |  58 ++++++
>   include/linux/bvec.h        | 143 ++++++++++++++
>   include/linux/dma-map-ops.h |   8 +
>   include/linux/dma-mapping.h |   9 +
>   include/linux/iommu.h       |   4 +
>   include/linux/kmsan.h       |  20 ++
>   include/rdma/ib_verbs.h     |  29 +++
>   kernel/dma/debug.c          | 165 +++++++++++++++-
>   kernel/dma/debug.h          |  38 ++++
>   kernel/dma/direct.c         |  92 +++++++++
>   kernel/dma/direct.h         |  17 ++
>   kernel/dma/mapping.c        |  93 +++++++++
>   mm/kmsan/hooks.c            |  13 ++
>   14 files changed, 1056 insertions(+), 1 deletion(-)
> 
> --
> Chuck Lever
> 
