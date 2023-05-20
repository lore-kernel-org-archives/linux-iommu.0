Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5C77F8
	for <iommu@lists.linux.dev>; Sat, 20 May 2023 05:42:22 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id AA2AC68CFE; Sat, 20 May 2023 07:42:09 +0200 (CEST)
Date: Sat, 20 May 2023 07:42:09 +0200
From: Christoph Hellwig <hch@lst.de>
To: Catalin Marinas <catalin.marinas@arm.com>
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
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, linux-mm@kvack.org,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 02/15] dma: Allow dma_get_cache_alignment() to
 return the smaller cache_line_size()
Message-ID: <20230520054209.GA319@lst.de>
References: <20230518173403.1150549-1-catalin.marinas@arm.com> <20230518173403.1150549-3-catalin.marinas@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230518173403.1150549-3-catalin.marinas@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, May 18, 2023 at 06:33:50PM +0100, Catalin Marinas wrote:
> On architectures like arm64, ARCH_DMA_MINALIGN is larger than most cache
> line size configurations deployed. However, the single kernel binary
> requirement doesn't allow the smaller ARCH_DMA_MINALIGN. Permit an
> architecture to opt in to dma_get_cache_alignment() returning
> cache_line_size() which can be probed at run-time.
> 
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Will Deacon <will@kernel.org>
> ---
>  include/linux/dma-mapping.h | 2 ++
>  kernel/dma/Kconfig          | 7 +++++++
>  2 files changed, 9 insertions(+)
> 
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index 3288a1339271..b29124341317 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -545,6 +545,8 @@ static inline int dma_set_min_align_mask(struct device *dev,
>  
>  static inline int dma_get_cache_alignment(void)
>  {
> +	if (IS_ENABLED(CONFIG_ARCH_HAS_DMA_CACHE_LINE_SIZE))
> +		return cache_line_size();
>  #ifdef ARCH_HAS_DMA_MINALIGN
>  	return ARCH_DMA_MINALIGN;
>  #endif

Maybe allowing architectures to simply override
dma_get_cache_alignment would be a little cleaner rather than adding
yet another abstraction?  That might also be able to repace
ARCH_DMA_MINALIGN in follow on cleanup.

