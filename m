Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by smtp.subspace.kernel.org (Postfix) with SMTP id BE9E46A34F
	for <iommu@lists.linux.dev>; Tue,  5 Dec 2023 18:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netrider.rowland.org
Received: (qmail 425898 invoked by uid 1000); 5 Dec 2023 13:28:23 -0500
Date: Tue, 5 Dec 2023 13:28:23 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Ferry Toth <ferry.toth@elsinga.info>, Ferry Toth <fntoth@gmail.com>,
  Christoph Hellwig <hch@lst.de>, Hamza Mahfooz <someguy@effective-light.com>,
  Dan Williams <dan.j.williams@intel.com>,
  Marek Szyprowski <m.szyprowski@samsung.com>, Andrew <travneff@gmail.com>,
  Andy Shevchenko <andy.shevchenko@gmail.com>,
  Thorsten Leemhuis <regressions@leemhuis.info>, iommu@lists.linux.dev,
  Kernel development list <linux-kernel@vger.kernel.org>,
  USB mailing list <linux-usb@vger.kernel.org>,
  Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>
Subject: Re: Bug in add_dma_entry()'s debugging code
Message-ID: <e22ae13a-aafc-49da-8092-1a17f60ae420@rowland.harvard.edu>
References: <20231127160759.GA1668@lst.de>
 <637d6dff-de56-4815-a15a-1afccde073f0@rowland.harvard.edu>
 <20231128133702.GA9917@lst.de>
 <cb7dc5da-37cb-45ba-9846-5a085f55692e@rowland.harvard.edu>
 <ZWYnECPRKca5Dpqc@arm.com>
 <76e8def2-ff45-47d3-91ab-96876ea84079@gmail.com>
 <ZWm-u2kV1UP09M84@arm.com>
 <5425cf42-0f49-41b5-b26d-1e099d5bdcc2@elsinga.info>
 <5093ce37-047e-4aa8-a9e8-2978da9d734a@rowland.harvard.edu>
 <ZWobHJqBji80CTm-@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWobHJqBji80CTm-@arm.com>

On Fri, Dec 01, 2023 at 05:42:52PM +0000, Catalin Marinas wrote:
> Indeed, so to be sure we don't trip over other false alarms, we'd also
> need to force ARCH_DMA_MINALIGN to be at least a cache-line size. That's
> used in some structures to force a static alignment of various members
> that take DMA transfers. After that, anything reported might actually be
> a potential issue, not a false alarm.
> 
> However, I wonder whether we'd actually hide some genuine problems.
> Let's say x86 gets some DMA corruption when it tries to DMA 8 bytes
> into two adjacent buffers because of some DMA buffer overflow, nothing
> to do with cache lines. You enable the DMA API debugging to see if it
> reports anything and it suddenly starts working because of the forced
> minimum alignment.

In the long run, it may turn out that trying to detect memory usage 
patterns that could cause problems for architectures other than the one 
currently running is not workable.  Certainly it is a bad idea to have a 
debugging infrastructure that changes the behavior of other parts of the 
system -- particularly when those other parts may be the ones you're 
trying to debug.

You may end up needing to make a choice here.  Which evil is lesser?

Alan Stern

