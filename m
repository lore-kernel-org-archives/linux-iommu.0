From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/9] dma-direct: provide page based alloc/free helpers
Date: Sat, 1 Dec 2018 17:56:10 +0100
Message-ID: <20181201165610.GA20912@lst.de>
References: <20181105121931.13481-1-hch@lst.de> <20181105121931.13481-2-hch@lst.de> <3b6439f3-fb7e-aaf7-01b9-b0fb03a27a69@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3b6439f3-fb7e-aaf7-01b9-b0fb03a27a69@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Guo Ren <ren_guo@c-sky.com>, Laura Abbott <labbott@redhat.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Fri, Nov 30, 2018 at 07:04:41PM +0000, Robin Murphy wrote:
> On 05/11/2018 12:19, Christoph Hellwig wrote:
>> Some architectures support remapping highmem into DMA coherent
>> allocations.  To use the common code for them we need variants of
>> dma_direct_{alloc,free}_pages that do not use kernel virtual addresses.
>
> FWIW it's as much about non-cacheable remapping of lowmem as it is about 
> highmem. Regardless, the diff looks OK to me.

Yes, but as long as you remap lowmem the current interface work ok,
but once you have highmem a kernel virtual address doesn't cut it,
and we need a page struct or physical address.
