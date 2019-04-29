From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 14/26] iommu/dma: Refactor iommu_dma_free
Date: Mon, 29 Apr 2019 21:03:48 +0200
Message-ID: <20190429190348.GB5637@lst.de>
References: <20190422175942.18788-1-hch@lst.de> <20190422175942.18788-15-hch@lst.de> <8321a363-f448-3e48-48f6-58d2b44a2900@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <8321a363-f448-3e48-48f6-58d2b44a2900@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: Christoph Hellwig <hch@lst.de>, Joerg Roedel <joro@8bytes.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Tom Lendacky <thomas.lendacky@amd.com>, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Mon, Apr 29, 2019 at 02:59:43PM +0100, Robin Murphy wrote:
> Hmm, I do still prefer my original flow with the dma_common_free_remap() 
> call right out of the way at the end rather than being a special case in 
> the middle of all the page-freeing (which is the kind of existing 
> complexity I was trying to eliminate). I guess you've done this to avoid 
> having "if (!dma_release_from_contiguous(...))..." twice like I ended up 
> with, which is fair enough I suppose - once we manage to solve the new 
> dma_{alloc,free}_contiguous() interface that may tip the balance so I can 
> always revisit this then.

Ok, I'll try to accomodate that with a minor rework.
