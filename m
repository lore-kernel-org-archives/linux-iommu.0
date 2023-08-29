Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29AB514F6B
	for <iommu@lists.linux.dev>; Tue, 29 Aug 2023 15:20:14 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7405D6732D; Tue, 29 Aug 2023 17:12:16 +0200 (CEST)
Date: Tue, 29 Aug 2023 17:12:16 +0200
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Chunhui He <hchunhui@mail.ustc.edu.cn>, Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dma/pool: trivial: add semicolon after label
 attributes
Message-ID: <20230829151216.GA4211@lst.de>
References: <20230826085317.69713-1-hchunhui@mail.ustc.edu.cn> <6f936d6e-9f27-ba72-68de-0ed27c0dbbe1@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f936d6e-9f27-ba72-68de-0ed27c0dbbe1@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Aug 29, 2023 at 03:22:22PM +0100, Robin Murphy wrote:
> AFAICS, what that clearly says is that *C++* label attributes can be 
> ambiguous. This is not C++ code. Even in C11, declarations still cannot be 
> labelled, so it should still be the case that, per the same GCC 
> documentation, "the ambiguity does not arise". And even if the language did 
> allow it, an inline declaration at that point at the end of a function 
> would be downright weird and against the kernel coding style anyway.
>
> So, I don't really see what's "better" about cluttering up C code with 
> unnecessary C++isms; it's just weird noise to me. The only thing I think it 
> *does* achieve is introduce the chance that the static checker brigade 
> eventually identifies a redundant semicolon and we get more patches to 
> remove it again.

Agreed.  Even more importantly that attribute looks rather questionable
to start with as it can be dropped by just moving the #endif a little:

diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
index 1acec2e228273f..da03c4a57cebe3 100644
--- a/kernel/dma/pool.c
+++ b/kernel/dma/pool.c
@@ -135,8 +135,8 @@ static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
 remove_mapping:
 #ifdef CONFIG_DMA_DIRECT_REMAP
 	dma_common_free_remap(addr, pool_size);
+free_page:
 #endif
-free_page: __maybe_unused
 	__free_pages(page, order);
 out:
 	return ret;
