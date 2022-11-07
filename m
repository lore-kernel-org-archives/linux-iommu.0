Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71F37F
	for <iommu@lists.linux.dev>; Mon,  7 Nov 2022 09:44:06 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id E953767373; Mon,  7 Nov 2022 10:43:55 +0100 (CET)
Date: Mon, 7 Nov 2022 10:43:55 +0100
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
Subject: Re: [PATCH v3 02/13] dma-mapping: Force bouncing if the kmalloc()
 size is not cacheline-aligned
Message-ID: <20221107094355.GA6055@lst.de>
References: <20221106220143.2129263-1-catalin.marinas@arm.com> <20221106220143.2129263-3-catalin.marinas@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221106220143.2129263-3-catalin.marinas@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

> +/*
> + * Check whether the given size, assuming it is for a kmalloc()'ed object, is
> + * safe for non-coherent DMA or needs bouncing.
> + */
> +static inline bool dma_kmalloc_needs_bounce(struct device *dev, size_t size,
> +					    enum dma_data_direction dir)
> +{
> +	/*
> +	 * No need for bouncing if coherent DMA or the direction is
> +	 * DMA_TO_DEVICE.
> +	 */
> +	if (!IS_ENABLED(CONFIG_DMA_BOUNCE_UNALIGNED_KMALLOC) ||
> +	    dir == DMA_TO_DEVICE || dev_is_dma_coherent(dev))

Minor nit, but for clarify I'd preper to split the generaly availabily
checks from the direction one, i.e.:

	if (dev_is_dma_coherent(dev) ||
	    !IS_ENABLED(CONFIG_DMA_BOUNCE_UNALIGNED_KMALLOC))
		return false;

	if (dir == DMA_TO_DEVICE)
		return false;
