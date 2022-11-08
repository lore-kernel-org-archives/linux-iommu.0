Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6198F4A
	for <iommu@lists.linux.dev>; Tue,  8 Nov 2022 09:52:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6129C433D6;
	Tue,  8 Nov 2022 09:52:18 +0000 (UTC)
Date: Tue, 8 Nov 2022 09:52:15 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Ard Biesheuvel <ardb@kernel.org>,
	Isaac Manjarres <isaacmanjarres@google.com>,
	Saravana Kannan <saravanak@google.com>,
	Alasdair Kergon <agk@redhat.com>, Daniel Vetter <daniel@ffwll.ch>,
	Joerg Roedel <joro@8bytes.org>, Mark Brown <broonie@kernel.org>,
	Mike Snitzer <snitzer@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>, linux-mm@kvack.org,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 13/13] dma: arm64: Add
 CONFIG_DMA_BOUNCE_UNALIGNED_KMALLOC and enable it for arm64
Message-ID: <Y2omz6pibSUNPtHu@arm.com>
References: <20221106220143.2129263-1-catalin.marinas@arm.com>
 <20221106220143.2129263-14-catalin.marinas@arm.com>
 <6e846f75-b330-9523-4356-41d5f9e48f12@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e846f75-b330-9523-4356-41d5f9e48f12@arm.com>

On Mon, Nov 07, 2022 at 01:03:31PM +0000, Robin Murphy wrote:
> On 2022-11-06 22:01, Catalin Marinas wrote:
> > With all the infrastructure in place for bouncing small kmalloc()
> > buffers, add the corresponding Kconfig entry and select it for arm64.
> 
> AFAICS we're missing the crucial part to ensure that SWIOTLB is available
> even when max_pfn <= arm64_dma_phys_limit, which is very likely to be true
> on low-memory systems that care most about kmalloc wastage.

This was a deliberate decision for this version. Patch 4 mitigates it a
bit by raising the kmalloc() minimum alignment to the cache line size
(typically 64). It's still an improvement from the current 128-byte
alignment.

Since it's hard to guess the optimal swiotlb buffer for such platforms,
I think a follow-up step would be to use the DMA coherent pool for
bouncing if no swiotlb buffer is available. At least the pool can grow
dynamically. Yet another option would be to increase the swiotlb buffer
at run-time but it has an overhead for is_swiotlb_buffer().

-- 
Catalin
