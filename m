From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] MIPS: Fix `dma_alloc_coherent' returning a
 non-coherent allocation
Date: Thu, 1 Nov 2018 09:33:46 +0100
Message-ID: <20181101083346.GA7136@lst.de>
References: <20180914095808.22202-1-hch@lst.de> <20180914095808.22202-5-hch@lst.de> <alpine.LFD.2.21.1810311414200.20378@eddie.linux-mips.org> <alpine.LFD.2.21.1810311559590.20378@eddie.linux-mips.org> <20181031203206.GA28337@lst.de> <alpine.LFD.2.21.1810312043250.20378@eddie.linux-mips.org> <20181101051359.GA4164@lst.de> <alpine.LFD.2.21.1811010523440.20378@eddie.linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.21.1811010523440.20378@eddie.linux-mips.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: Christoph Hellwig <hch@lst.de>, Paul Burton <paul.burton@mips.com>, iommu@lists.linux-foundation.org, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-mips@linux-mips.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Nov 01, 2018 at 07:54:24AM +0000, Maciej W. Rozycki wrote:
> Fix a MIPS `dma_alloc_coherent' regression from commit bc3ec75de545 
> ("dma-mapping: merge direct and noncoherent ops") that causes a cached 
> allocation to be returned on noncoherent cache systems.
> 
> This is due to an inverted check now used in the MIPS implementation of 
> `arch_dma_alloc' on the result from `dma_direct_alloc_pages' before 
> doing the cached-to-uncached mapping of the allocation address obtained.  
> The mapping has to be done for a non-NULL rather than NULL result, 
> because a NULL result means the allocation has failed.
> 
> Invert the check for correct operation then.
> 
> Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
> Fixes: bc3ec75de545 ("dma-mapping: merge direct and noncoherent ops")
> Cc: stable@vger.kernel.org # 4.19+

Oops, yes this looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
