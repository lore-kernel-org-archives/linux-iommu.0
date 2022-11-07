Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8CBD51D
	for <iommu@lists.linux.dev>; Mon,  7 Nov 2022 14:38:55 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0FC9867373; Mon,  7 Nov 2022 15:38:50 +0100 (CET)
Date: Mon, 7 Nov 2022 15:38:49 +0100
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
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
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 13/13] dma: arm64: Add
 CONFIG_DMA_BOUNCE_UNALIGNED_KMALLOC and enable it for arm64
Message-ID: <20221107143849.GA27946@lst.de>
References: <20221106220143.2129263-1-catalin.marinas@arm.com> <20221106220143.2129263-14-catalin.marinas@arm.com> <6e846f75-b330-9523-4356-41d5f9e48f12@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e846f75-b330-9523-4356-41d5f9e48f12@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Nov 07, 2022 at 01:03:31PM +0000, Robin Murphy wrote:
> On 2022-11-06 22:01, Catalin Marinas wrote:
>> With all the infrastructure in place for bouncing small kmalloc()
>> buffers, add the corresponding Kconfig entry and select it for arm64.
>
> AFAICS we're missing the crucial part to ensure that SWIOTLB is available 
> even when max_pfn <= arm64_dma_phys_limit, which is very likely to be true 
> on low-memory systems that care most about kmalloc wastage. The only way to 
> override that currently is with "swiotlb=force", but bouncing *everything* 
> is not desirable either.

FYI, one of the reasons for the swiotlb_init refactor that passes
flags and a boolean a while ago is that we can trivially just either
pass another flag or check a condition in swiotlb_init to allocate the
buffer.  There's actually another case for which we need the
unconditional allocation, and that is the bouncing for untrusted
external devices with dma-iommu.
