Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0403E101E4
	for <iommu@lists.linux.dev>; Thu, 25 May 2023 13:59:41 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3A94068AFE; Thu, 25 May 2023 15:59:31 +0200 (CEST)
Date: Thu, 25 May 2023 15:59:31 +0200
From: Christoph Hellwig <hch@lst.de>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
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
Subject: Re: [PATCH v5 02/15] dma: Allow dma_get_cache_alignment() to be
 overridden by the arch code
Message-ID: <20230525135931.GA15012@lst.de>
References: <20230524171904.3967031-1-catalin.marinas@arm.com> <20230524171904.3967031-3-catalin.marinas@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230524171904.3967031-3-catalin.marinas@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, May 24, 2023 at 06:18:51PM +0100, Catalin Marinas wrote:
> On arm64, ARCH_DMA_MINALIGN is larger than most cache line size
> configurations deployed. Allow an architecture to override
> dma_get_cache_alignment() in order to return a run-time probed value
> (e.g. cache_line_size()).
> 
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Will Deacon <will@kernel.org>

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
