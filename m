From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 07/21] dma-iommu: move the arm64 wrappers to common code
Date: Tue, 9 Apr 2019 19:15:11 +0200
Message-ID: <20190409171511.GC14679@lst.de>
References: <20190327080448.5500-1-hch@lst.de> <20190327080448.5500-8-hch@lst.de> <67573dd3-72c7-692d-bc1a-7edb49ff9551@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <67573dd3-72c7-692d-bc1a-7edb49ff9551@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: Christoph Hellwig <hch@lst.de>, Joerg Roedel <joro@8bytes.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Tom Lendacky <thomas.lendacky@amd.com>, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Apr 09, 2019 at 04:07:02PM +0100, Robin Murphy wrote:
>> +static void iommu_dma_unmap_page(struct device *dev, dma_addr_t dma_handle,
>> +		size_t size, enum dma_data_direction dir, unsigned long attrs)
>> +{
>> +	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
>> +		iommu_dma_sync_single_for_cpu(dev, dma_handle, size, dir);
>> +	__iommu_dma_unmap(iommu_get_domain_for_dev(dev), dma_handle, size);
>
> That wants to be iommu_get_dma_domain() there to minimise the overhead. In 
> fact, I guess this could now be streamlined a bit in the style of 
> iommu_dma_map_page() above - i.e. avoid doing a second domain lookup in the 
> sync case - but that can happen later (if indeed you haven't already).

Yes, this should be iommu_get_dma_domain - this got lost during
a rebase to the kernel version that changed to the iommu_get_dma_domain
calls.

I don't think I've optimized to remove the additional call, but
I can easily throw in another patch to do that.
