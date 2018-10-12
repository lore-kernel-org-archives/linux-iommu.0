From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 04/10] swiotlb: remove the overflow buffer
Date: Fri, 12 Oct 2018 18:04:12 +0100
Message-ID: <20181012170411.GB60150@arrakis.emea.arm.com>
References: <20181008080246.20543-1-hch@lst.de>
 <20181008080246.20543-5-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181008080246.20543-5-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Will Deacon <will.deacon@arm.com>, Robin Murphy <robin.murphy@arm.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

On Mon, Oct 08, 2018 at 10:02:40AM +0200, Christoph Hellwig wrote:
> Like all other dma mapping drivers just return an error code instead
> of an actual memory buffer.  The reason for the overflow buffer was
> that at the time swiotlb was invented there was no way to check for
> dma mapping errors, but this has long been fixed.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/arm64/mm/dma-mapping.c       |  2 +-
>  arch/powerpc/kernel/dma-swiotlb.c |  4 +--
>  include/linux/dma-direct.h        |  2 ++
>  include/linux/swiotlb.h           |  3 --
>  kernel/dma/direct.c               |  2 --
>  kernel/dma/swiotlb.c              | 59 ++-----------------------------
>  6 files changed, 8 insertions(+), 64 deletions(-)

I went through the patches and they look fine to me (with the vunmap
fix for the last patch). For the arm64 bits:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
