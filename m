From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: implement generic dma_map_ops for IOMMUs v3
Date: Mon, 29 Apr 2019 16:03:29 +0100
Message-ID: <9ae8ce99-65a8-711d-b17d-165df7e280d4@arm.com>
References: <20190422175942.18788-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190422175942.18788-1-hch@lst.de>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>, Tom Lendacky <thomas.lendacky@amd.com>, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On 22/04/2019 18:59, Christoph Hellwig wrote:
> Hi Robin,
> 
> please take a look at this series, which implements a completely generic
> set of dma_map_ops for IOMMU drivers.  This is done by taking the
> existing arm64 code, moving it to drivers/iommu and then massaging it
> so that it can also work for architectures with DMA remapping.  This
> should help future ports to support IOMMUs more easily, and also allow
> to remove various custom IOMMU dma_map_ops implementations, like Tom
> was planning to for the AMD one.

Modulo a few nits, I think this looks pretty much good to go, and it 
would certainly be good to get as much as reasonable queued soon for the 
sake of progress elsewhere.

Catalin, Will, I think the arm64 parts are all OK but please take a look 
to confirm.

Thanks,
Robin.

> 
> A git tree is also available at:
> 
>      git://git.infradead.org/users/hch/misc.git dma-iommu-ops.3
> 
> Gitweb:
> 
>      http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/dma-iommu-ops.3
> 
> Changes since v2:
>   - address various review comments and include patches from Robin
> 
> Changes since v1:
>   - only include other headers in dma-iommu.h if CONFIG_DMA_IOMMU is enabled
>   - keep using a scatterlist in iommu_dma_alloc
>   - split out mmap/sgtable fixes and move them early in the series
>   - updated a few commit logs
> 
