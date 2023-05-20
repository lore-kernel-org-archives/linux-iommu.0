Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12664624
	for <iommu@lists.linux.dev>; Sat, 20 May 2023 10:34:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58CCAC433EF;
	Sat, 20 May 2023 10:34:35 +0000 (UTC)
Date: Sat, 20 May 2023 11:34:32 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
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
Subject: Re: [PATCH v4 02/15] dma: Allow dma_get_cache_alignment() to return
 the smaller cache_line_size()
Message-ID: <ZGiiOD+52qJ/FUM1@arm.com>
References: <20230518173403.1150549-1-catalin.marinas@arm.com>
 <20230518173403.1150549-3-catalin.marinas@arm.com>
 <20230520054209.GA319@lst.de>
 <20230520061441.GA1100@lst.de>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230520061441.GA1100@lst.de>

On Sat, May 20, 2023 at 08:14:41AM +0200, Christoph Hellwig wrote:
> On Sat, May 20, 2023 at 07:42:09AM +0200, Christoph Hellwig wrote:
> > yet another abstraction?  That might also be able to repace
> > ARCH_DMA_MINALIGN in follow on cleanup.
> 
> Looking at the rest of the series, this part is obviously not going to
> work..

ARCH_DMA_MINALIGN needs to remain a constant (taking over from the
original ARCH_KMALLOC_MINALIGN). But the dma_get_cache_alignment() can
indeed be overridden by the arch code, it's a good idea.

-- 
Catalin
