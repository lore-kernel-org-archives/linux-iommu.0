From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 06/19] dma-iommu: fix and refactor iommu_dma_mmap
Date: Mon, 11 Feb 2019 17:03:25 +0100
Message-ID: <20190211160325.GC27745@lst.de>
References: <20190114094159.27326-1-hch@lst.de> <20190114094159.27326-7-hch@lst.de> <7c2b6aaa-3a19-a411-1d40-0c787205b0fc@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7c2b6aaa-3a19-a411-1d40-0c787205b0fc@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: Christoph Hellwig <hch@lst.de>, Joerg Roedel <joro@8bytes.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Tom Lendacky <thomas.lendacky@amd.com>, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Feb 05, 2019 at 03:02:23PM +0000, Robin Murphy wrote:
> On 14/01/2019 09:41, Christoph Hellwig wrote:
>> The current iommu_dma_mmap code does not properly handle memory from the
>> page allocator that hasn't been remapped, which can happen in the rare
>> case of allocations for a coherent device that aren't allowed to block.
>>
>> Fix this by replacing iommu_dma_mmap with a slightly tweaked copy of
>> dma_common_mmap with special handling for the remapped array of
>> pages allocated from __iommu_dma_alloc.
>
> If there's an actual bugfix here, can we make that before all of the other 
> code movement? If it's at all related to other reports of weird mmap 
> behaviour it might warrant backporting, and either way I'm finding it 
> needlessly tough to follow what's going on in this patch :(

The bug fix is to handle non-vmalloc pages.  I'll see if I can do
a smaller and more bandaid-y fix first.
