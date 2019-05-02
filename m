From: Christoph Hellwig <hch@lst.de>
Subject: Re: implement generic dma_map_ops for IOMMUs v4
Date: Thu, 2 May 2019 15:22:08 +0200
Message-ID: <20190502132208.GA3069@lst.de>
References: <20190430105214.24628-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190430105214.24628-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>, Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

Hi Catalin and Will,

can you quickly look over the arm64 parts?  I'd really like to still
get this series in for this merge window as it would conflict with
a lot of dma-mapping work for next merge window, and we also have
the amd and possibly intel iommu conversions to use it waiting.

On Tue, Apr 30, 2019 at 06:51:49AM -0400, Christoph Hellwig wrote:
> Hi Robin,
> 
> please take a look at this series, which implements a completely generic
> set of dma_map_ops for IOMMU drivers.  This is done by taking the
> existing arm64 code, moving it to drivers/iommu and then massaging it
> so that it can also work for architectures with DMA remapping.  This
> should help future ports to support IOMMUs more easily, and also allow
> to remove various custom IOMMU dma_map_ops implementations, like Tom
> was planning to for the AMD one.
> 
> A git tree is also available at:
> 
>     git://git.infradead.org/users/hch/misc.git dma-iommu-ops.3
> 
> Gitweb:
> 
>     http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/dma-iommu-ops.3
> 
> Changes since v3:
>  - fold the separate patch to refactor mmap bounds checking
>  - don't warn on not finding a vm_area
>  - improve a commit log
>  - refactor __dma_iommu_free a little differently
>  - remove a minor MSI map cleanup to avoid a conflict with the
>    "Split iommu_dma_map_msi_msg" series
> 
> Changes since v2:
>  - address various review comments and include patches from Robin
> 
> Changes since v1:
>  - only include other headers in dma-iommu.h if CONFIG_DMA_IOMMU is enabled
>  - keep using a scatterlist in iommu_dma_alloc
>  - split out mmap/sgtable fixes and move them early in the series
>  - updated a few commit logs
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
---end quoted text---
