Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CDC17F8
	for <iommu@lists.linux.dev>; Sat, 20 May 2023 06:14:47 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2CC3A68CFE; Sat, 20 May 2023 08:14:42 +0200 (CEST)
Date: Sat, 20 May 2023 08:14:41 +0200
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
Message-ID: <20230520061441.GA1100@lst.de>
References: <20230518173403.1150549-1-catalin.marinas@arm.com> <20230518173403.1150549-3-catalin.marinas@arm.com> <20230520054209.GA319@lst.de>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230520054209.GA319@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Sat, May 20, 2023 at 07:42:09AM +0200, Christoph Hellwig wrote:
> yet another abstraction?  That might also be able to repace
> ARCH_DMA_MINALIGN in follow on cleanup.

Looking at the rest of the series, this part is obviously not going to
work..
