From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH 0/2] extend support for CMA CMA on x86
Date: Fri, 29 Nov 2013 20:59:00 +0100
Message-ID: <20131129195900.GC17656@two.firstfloor.org>
References: <1385736706-3147-1-git-send-email-akinobu.mita@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1385736706-3147-1-git-send-email-akinobu.mita@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org, Marek Szyprowski <m.szyprowski@samsung.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Andi Kleen <andi@firstfloor.org>, David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org

On Fri, Nov 29, 2013 at 11:51:44PM +0900, Akinobu Mita wrote:
> This patch set extends support for the DMA Contiguous Memory Allocator
> on x86.  Currently it is only supported on pci-nommu.  So this aims at
> enabling it on swiotlb and intel-iommu, too.
> 
> Regardless of which dma mapping implementation is actually used in the
> system, I would like to allocate big contiguous memory with
> dma_alloc_coherent() and tell the base address to the device that
> requires it.  This is why I need this change.

I think it's generally the right direction. CMA is much better
than the DMA zone (e.g. it can actually (mostly) share memory,
while lower zone protection keeps the DMA zone free)
Also it works for more than 16MB / 64MB.

So i hope longer term we can just kill GFP_DMA and replace
it with some CMA variant everywhere.

There are also other potential users that could make use of it,
but they need to interoperate with swiotlb, so something liike
this is needed.

-Andi
