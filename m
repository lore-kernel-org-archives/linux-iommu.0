Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349C279DE
	for <iommu@lists.linux.dev>; Wed, 19 Apr 2023 16:06:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46F4AC4339B;
	Wed, 19 Apr 2023 16:06:07 +0000 (UTC)
Date: Wed, 19 Apr 2023 17:06:04 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Isaac Manjarres <isaacmanjarres@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Ard Biesheuvel <ardb@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Alasdair Kergon <agk@redhat.com>, Daniel Vetter <daniel@ffwll.ch>,
	Joerg Roedel <joro@8bytes.org>, Mark Brown <broonie@kernel.org>,
	Mike Snitzer <snitzer@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, linux-mm@kvack.org,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	Petr Tesarik <petrtesarik@huaweicloud.com>
Subject: Re: [PATCH v3 00/13] mm, dma, arm64: Reduce ARCH_KMALLOC_MINALIGN to
 8
Message-ID: <ZEARbKMfMS8KdkhJ@arm.com>
References: <20221106220143.2129263-1-catalin.marinas@arm.com>
 <ZBNiN9CR2F/fvUTh@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBNiN9CR2F/fvUTh@google.com>

On Thu, Mar 16, 2023 at 11:38:47AM -0700, Isaac Manjarres wrote:
> On Sun, Nov 06, 2022 at 10:01:30PM +0000, Catalin Marinas wrote:
> > Patches 7-12 change some ARCH_KMALLOC_MINALIGN uses to
> > ARCH_DMA_MINALIGN. The crypto changes have been rejected by Herbert
> > previously but I still included them here until the crypto code is
> > refactored.
> 
> Herbert merged the changes to the crypto code that were required to be
> able to safely lower the minimum alignment for kmalloc in [1].

Yes, I saw this.

> Given this, I don't think there's anything blocking this series from
> being merged. The requirement for SWIOTLB to get to the minimum
> kmalloc alignment down to 8 bytes shouldn't prevent this series from
> being merged, as the amount of memory that is allocated for SWIOTLB
> can be configured through the commandline to minimize the impact of
> having SWIOTLB memory. Additionally, even if no SWIOTLB is present,
> this series still offers memory savings on a lot of ARM64 platforms
> by using the cache line size as the minimum alignment for kmalloc.

Actually, there's some progress on the swiotlb front to allow dynamic
allocation. I haven't reviewed the series yet (I wasn't aware of it
until v2) but at a quick look, it limits the dynamic allocation to
bouncing buffers of at least a page size. Maybe this can be later
improved for buffers below ARCH_DMA_MINALIGN.

https://lore.kernel.org/r/cover.1681898595.git.petr.tesarik.ext@huawei.com

> Can you please rebase this series so that it can be merged?

I rebased it locally but the last stumbling block is sorting out the
iommu bouncing. I was hoping Robin Murphy can lend a hand but he's been
busy with other bits. I'll repost the series at 6.4-rc1.

-- 
Catalin
