Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C85C8F4A
	for <iommu@lists.linux.dev>; Tue,  8 Nov 2022 10:03:43 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 473A268AFE; Tue,  8 Nov 2022 11:03:31 +0100 (CET)
Date: Tue, 8 Nov 2022 11:03:31 +0100
From: Christoph Hellwig <hch@lst.de>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Robin Murphy <robin.murphy@arm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
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
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	agraf@csgraf.de
Subject: Re: [PATCH v3 13/13] dma: arm64: Add
 CONFIG_DMA_BOUNCE_UNALIGNED_KMALLOC and enable it for arm64
Message-ID: <20221108100331.GA31944@lst.de>
References: <20221106220143.2129263-1-catalin.marinas@arm.com> <20221106220143.2129263-14-catalin.marinas@arm.com> <6e846f75-b330-9523-4356-41d5f9e48f12@arm.com> <Y2omz6pibSUNPtHu@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2omz6pibSUNPtHu@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Nov 08, 2022 at 09:52:15AM +0000, Catalin Marinas wrote:
> Since it's hard to guess the optimal swiotlb buffer for such platforms,
> I think a follow-up step would be to use the DMA coherent pool for
> bouncing if no swiotlb buffer is available. At least the pool can grow
> dynamically. Yet another option would be to increase the swiotlb buffer
> at run-time but it has an overhead for is_swiotlb_buffer().

Alex said he wanted to look into growing the swiotlb buffer on demand
for other reason, so adding him to Cc to check if there has been any
progress on that.
