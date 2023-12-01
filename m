Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433DB22080;
	Fri,  1 Dec 2023 17:42:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2E47C433C7;
	Fri,  1 Dec 2023 17:42:54 +0000 (UTC)
Date: Fri, 1 Dec 2023 17:42:52 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Ferry Toth <ferry.toth@elsinga.info>, Ferry Toth <fntoth@gmail.com>,
	Christoph Hellwig <hch@lst.de>,
	Hamza Mahfooz <someguy@effective-light.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Andrew <travneff@gmail.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Thorsten Leemhuis <regressions@leemhuis.info>,
	iommu@lists.linux.dev,
	Kernel development list <linux-kernel@vger.kernel.org>,
	USB mailing list <linux-usb@vger.kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>
Subject: Re: Bug in add_dma_entry()'s debugging code
Message-ID: <ZWobHJqBji80CTm-@arm.com>
References: <736e584f-7d5f-41aa-a382-2f4881ba747f@rowland.harvard.edu>
 <20231127160759.GA1668@lst.de>
 <637d6dff-de56-4815-a15a-1afccde073f0@rowland.harvard.edu>
 <20231128133702.GA9917@lst.de>
 <cb7dc5da-37cb-45ba-9846-5a085f55692e@rowland.harvard.edu>
 <ZWYnECPRKca5Dpqc@arm.com>
 <76e8def2-ff45-47d3-91ab-96876ea84079@gmail.com>
 <ZWm-u2kV1UP09M84@arm.com>
 <5425cf42-0f49-41b5-b26d-1e099d5bdcc2@elsinga.info>
 <5093ce37-047e-4aa8-a9e8-2978da9d734a@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5093ce37-047e-4aa8-a9e8-2978da9d734a@rowland.harvard.edu>

Replying to both here.

On Fri, Dec 01, 2023 at 11:21:40AM -0500, Alan Stern wrote:
> On Fri, Dec 01, 2023 at 01:17:43PM +0100, Ferry Toth wrote:
> > > A non-cache coherent platform would either have the kmalloc()
> > > allocations aligned or it would bounce those small, unaligned buffers.
> > 
> > It would? Or it always has?

It depends on the configuration. arm64 does the bounce as it opted in to
CONFIG_DMA_BOUNCE_UNALIGNED_KMALLOC.

> > > So it doesn't seem right to issue a warning on x86 where kmalloc()
> > > minimum alignment is 8 and not getting the warning on a non-coherent
> > > platform which forces the kmalloc() alignment.
> > 
> > If *all*non-coherent platforms implement either correct alignment or bounce
> > buffer, and on (coherent) x86 we get an WARN, then it is a false alarm
> > right?
> > 
> > That is exactly my question (because I have no idea which platforms have
> > non-coherent caches).
> 
> Don't forget, not all DMA buffers are allocated by kmalloc().  A buffer 
> allocated by some other means might not be aligned properly and might 
> share a cache line with another buffer.
> 
> Or you might have a single data structure that was allocated by 
> kmalloc() and then create separate DMA mappings for two members of that 
> structure.  If the two members are in the same cache line, that would be 
> an error.

Indeed, so to be sure we don't trip over other false alarms, we'd also
need to force ARCH_DMA_MINALIGN to be at least a cache-line size. That's
used in some structures to force a static alignment of various members
that take DMA transfers. After that, anything reported might actually be
a potential issue, not a false alarm.

However, I wonder whether we'd actually hide some genuine problems.
Let's say x86 gets some DMA corruption when it tries to DMA 8 bytes
into two adjacent buffers because of some DMA buffer overflow, nothing
to do with cache lines. You enable the DMA API debugging to see if it
reports anything and it suddenly starts working because of the forced
minimum alignment.

-- 
Catalin
