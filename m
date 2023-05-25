Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABB11D2B8
	for <iommu@lists.linux.dev>; Thu, 25 May 2023 17:08:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCE86C433D2;
	Thu, 25 May 2023 17:08:30 +0000 (UTC)
Date: Thu, 25 May 2023 18:08:27 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>,
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
Subject: Re: [PATCH v5 15/15] arm64: Enable ARCH_WANT_KMALLOC_DMA_BOUNCE for
 arm64
Message-ID: <ZG+WC9ovq62CUav3@arm.com>
References: <20230524171904.3967031-1-catalin.marinas@arm.com>
 <20230524171904.3967031-16-catalin.marinas@arm.com>
 <ac8e86ba-fd2c-3816-8156-86af7ac8327c@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac8e86ba-fd2c-3816-8156-86af7ac8327c@arm.com>

On Thu, May 25, 2023 at 05:12:37PM +0100, Robin Murphy wrote:
> On 24/05/2023 6:19 pm, Catalin Marinas wrote:
> > With the DMA bouncing of unaligned kmalloc() buffers now in place,
> > enable it for arm64 to allow the kmalloc-{8,16,32,48,96} caches. In
> > addition, always create the swiotlb buffer even when the end of RAM is
> > within the 32-bit physical address range (the swiotlb buffer can still
> > be disabled on the kernel command line).
> > 
> > Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will@kernel.org>
> > ---
> >   arch/arm64/Kconfig   | 1 +
> >   arch/arm64/mm/init.c | 7 ++++++-
> >   2 files changed, 7 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > index b1201d25a8a4..af42871431c0 100644
> > --- a/arch/arm64/Kconfig
> > +++ b/arch/arm64/Kconfig
> > @@ -120,6 +120,7 @@ config ARM64
> >   	select CRC32
> >   	select DCACHE_WORD_ACCESS
> >   	select DYNAMIC_FTRACE if FUNCTION_TRACER
> > +	select DMA_BOUNCE_UNALIGNED_KMALLOC
> 
> We may want to give the embedded folks an easier way of turning this off,
> since IIRC one of the reasons for the existing automatic behaviour was
> people not wanting to have to depend on the command line. Things with 256MB
> or so of RAM seem unlikely to get enough memory efficiency back from the
> smaller kmem caches to pay off the SWIOTLB allocation :)

I thought about this initially and that's why I had two options
(ARCH_WANT_* and this one). But we already select SWIOTLB on arm64, so
for the embedded folk the only option is swiotlb=noforce on the cmdline
which, in turn, limits the kmalloc caches to kmalloc-64 (or whatever the
cache line size is) irrespective of this new select.

-- 
Catalin
