From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/9] dma-direct: reject highmem pages from
 dma_alloc_from_contiguous
Date: Sat, 1 Dec 2018 17:57:16 +0100
Message-ID: <20181201165716.GB20912@lst.de>
References: <20181105121931.13481-1-hch@lst.de> <20181105121931.13481-3-hch@lst.de> <e479a766-07c0-c319-0d91-318aaafdf7bc@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <e479a766-07c0-c319-0d91-318aaafdf7bc@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Guo Ren <ren_guo@c-sky.com>, Laura Abbott <labbott@redhat.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Fri, Nov 30, 2018 at 07:04:51PM +0000, Robin Murphy wrote:
> On 05/11/2018 12:19, Christoph Hellwig wrote:
>> dma_alloc_from_contiguous can return highmem pages depending on the
>> setup, which a plain non-remapping DMA allocator can't handle.  Detect
>> this case and try the normal page allocator instead.
>
> ...except the actual implementation is "Detect this case and fail the 
> entire allocation if so".

True, that actually changed from when I wrote the commit log due to
some layer issues.  I'll update the commit log.
