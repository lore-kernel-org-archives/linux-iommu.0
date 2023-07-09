Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DA7ECA;
	Sun,  9 Jul 2023 03:27:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 836CCC433C7;
	Sun,  9 Jul 2023 03:27:17 +0000 (UTC)
Date: Sun, 9 Jul 2023 04:27:16 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Amit Pundir <amit.pundir@linaro.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Ard Biesheuvel <ardb@kernel.org>,
	Isaac Manjarres <isaacmanjarres@google.com>,
	Saravana Kannan <saravanak@google.com>,
	Alasdair Kergon <agk@redhat.com>, Daniel Vetter <daniel@ffwll.ch>,
	Joerg Roedel <joro@8bytes.org>, Mark Brown <broonie@kernel.org>,
	Mike Snitzer <snitzer@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: [PATCH v7 00/17] mm, dma, arm64: Reduce ARCH_KMALLOC_MINALIGN to
 8
Message-ID: <ZKopFDtT6g4n+Kma@arm.com>
References: <20230612153201.554742-1-catalin.marinas@arm.com>
 <CAMi1Hd04mu6JojT3y6wyN2YeVkPR5R3qnkKJ8iR8if_YByCn4w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMi1Hd04mu6JojT3y6wyN2YeVkPR5R3qnkKJ8iR8if_YByCn4w@mail.gmail.com>

Hi Amit,

On Wed, Jul 05, 2023 at 07:10:02PM +0530, Amit Pundir wrote:
> On Wed, 5 Jul 2023 at 18:17, Catalin Marinas <catalin.marinas@arm.com> wrote:
> > That's v7 of the series reducing the kmalloc() minimum alignment on
> > arm64 to 8 (from 128). There's no new/different functionality, mostly
> > cosmetic changes and acks/tested-bys.
> >
> > Andrew, if there are no further comments or objections to this version,
> > are you ok to take the series through the mm tree? The arm64 changes are
> > fairly small. Alternatively, I can push it into linux-next now to give
> > it some wider exposure and decide whether to upstream it when the
> > merging window opens. Thanks.
> 
> This patch series broke Dragonboard 845c (SDM845) running AOSP.
> With this series I run into random oops at __kmem_cache_alloc_node().
> Here is one such boot log https://bugs.linaro.org/attachment.cgi?id=1146
> 
> Reverting "arm64: Enable ARCH_WANT_KMALLOC_DMA_BOUNCE for arm64"
> fixes it for the time being.

I'm on holiday until the 24th, away from my computer and I don't have
much time to dig into this. Are the DMA-capable devices on this platform
non-coherent? We'd need to check whether the bouncing logic somehow
overflows and corrupts adjacent memory. If the devices are coherent,
maybe the DMA spills over the kmalloc() boundaries, now that we
allocate buffers smaller than a cacheline even for DMA (no bouncing if
the DMA is coherent). Also, are these devices behind an IOMMU?

Yet another possibility is a not fully transparent system level cache
with a line size larger than what's reported by the CTR_EL0.CWG. If you
boot the platform with "swiotlb=noforce", do you still see issues? Or
there's no swiotlb buffer allocated anyway.

In addition to what Isaac suggests on slab debugging, it may be worth
enabling DMA debugging as well (I don't remember the config name).

-- 
Catalin
