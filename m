From: Christoph Hellwig <hch@lst.de>
Subject: Re: move the arm arch_dma_alloc implementation to common code
Date: Fri, 9 Nov 2018 08:52:38 +0100
Message-ID: <20181109075238.GA27578@lst.de>
References: <20181105121931.13481-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181105121931.13481-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, Guo Ren <ren_guo@c-sky.com>, Laura Abbott <labbott@redhat.com>, Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

Can I get a quick review from the arm64 folks?  I think it should
be fine there as it basically is a code move, but an additional pair
or two of eyes always helps to weed out bugs.

On Mon, Nov 05, 2018 at 01:19:22PM +0100, Christoph Hellwig wrote:
> Hi all,
> 
> this series moves the existing arm64 implementation of arch_dma_alloc and
> arch_dma_free to common code given that it is not arm64-specific, and
> then also uses it for csky.  Given how many architectures remap memory
> for the DMA coherent implementation it should be usable for many more,
> and the new cache flushing hook and the generic atomic pool are also
> enablers for implementing the IOMMU API dma ops in common code in a
> follow on series.
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
---end quoted text---
