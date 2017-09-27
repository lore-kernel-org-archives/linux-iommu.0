From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v5 0/6] Optimise 64-bit IOVA allocations
Date: Wed, 27 Sep 2017 17:11:33 +0200
Message-ID: <20170927151133.bsdalf67br3p3hj2@8bytes.org>
References: <cover.1506007392.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cover.1506007392.git.robin.murphy@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux-foundation.org, thunder.leizhen@huawei.com, nwatters@codeaurora.org, tomasz.nowicki@caviumnetworks.com, dwoods@mellanox.com, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Sep 21, 2017 at 04:52:41PM +0100, Robin Murphy wrote:
> v4: https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1493704.html
> 
> Right, this is hopefully the last version - I've put things back in a
> sensible order with the new additions at the end, so if they prove
> contentious the first 4 previously-tested patches can still get their
> time in -next. Patch #3 is updated to fix the bug brought to light by
> Tomasz, patch #6 includes the cleanup afterthought from v4, and I've
> nobbled one or two rogue whitespace changes I'd missed before.
> 
> And the diffstat is still even more negative than before, hooray! For
> the whole series, the total code size reduction of alloc_iova() comes
> to just over 26% (AArch64 GCC 6.3.1).
> 
> Robin.
> 
> 
> Robin Murphy (3):
>   iommu/iova: Extend rbtree node caching
>   iommu/iova: Add rbtree anchor node
>   iommu/iova: Simplify cached node logic
> 
> Zhen Lei (3):
>   iommu/iova: Optimise rbtree searching
>   iommu/iova: Optimise the padding calculation
>   iommu/iova: Make dma_32bit_pfn implicit

Applied, thanks Robin.
