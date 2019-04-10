From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 12/21] dma-iommu: factor atomic pool allocations into
 helpers
Date: Wed, 10 Apr 2019 08:11:58 +0200
Message-ID: <20190410061157.GA5278@lst.de>
References: <20190327080448.5500-1-hch@lst.de> <20190327080448.5500-13-hch@lst.de> <b3f80a11-1504-e8f9-4438-92bcd5f3df7f@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <b3f80a11-1504-e8f9-4438-92bcd5f3df7f@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: Christoph Hellwig <hch@lst.de>, Joerg Roedel <joro@8bytes.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Tom Lendacky <thomas.lendacky@amd.com>, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Apr 09, 2019 at 06:59:32PM +0100, Robin Murphy wrote:
> On 27/03/2019 08:04, Christoph Hellwig wrote:
>> This keeps the code together and will simplify compiling the code
>> out on architectures that are always dma coherent.
>
> And this is where things take a turn in the direction I just can't get on 
> with - I'm looking at the final result and the twisty maze of little 
> disjoint helpers all overlapping each other in functionality is really 
> difficult to follow. And I would *much* rather have things rely on 
> compile-time constant optimisation than spend the future having to fix the 
> #ifdefed parts for arm64 whenever x86-centric changes fail to test them.

Can you draft up a patch on top of my series to show me what you
want?  I can take care of finishing it up and moving the changes
into the right patches in the series.

> Conceptually, everything except the iommu_dma_alloc_remap() case is more or 
> less just dma_direct_alloc() with an IOMMU mapping on top - if we could 
> pass that an internal flag to say "don't fail or bounce because of masks" 
> it seems like that approach could end up being quite a bit simpler (I did 
> once have lofty plans to refactor the old arm64 code in such a way...)

I've been wanting to share more code between DMA direct and the iommu
allocators.  But this series already is huge and has been pending
far too long.  I'll eventually get to it..
