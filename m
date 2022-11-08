Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA4D612F
	for <iommu@lists.linux.dev>; Tue,  8 Nov 2022 07:50:18 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5820E68AFE; Tue,  8 Nov 2022 08:50:13 +0100 (CET)
Date: Tue, 8 Nov 2022 08:50:12 +0100
From: Christoph Hellwig <hch@lst.de>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Christoph Hellwig <hch@lst.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
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
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, linux-mm@kvack.org,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 03/13] iommu/dma: Force bouncing of the size is not
 cacheline-aligned
Message-ID: <20221108075012.GA22830@lst.de>
References: <20221106220143.2129263-1-catalin.marinas@arm.com> <20221106220143.2129263-4-catalin.marinas@arm.com> <20221107094603.GB6055@lst.de> <Y2jj7PlrIC6weDch@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2jj7PlrIC6weDch@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Nov 07, 2022 at 10:54:36AM +0000, Catalin Marinas wrote:
> An idea: we could add another member to struct scatterlist to track the
> bounced address. We can then do the bouncing in a similar way to
> iommu_dma_map_sg_swiotlb() but without the iova allocation. The latter
> would be a common path for both the bounced and non-bounced cases.

That would be a pretty massive memory overhead for an unusual case,
so I'd rather avoid it.  In addition to the long term plan of doing
DMA mappings without a scatterlist..
