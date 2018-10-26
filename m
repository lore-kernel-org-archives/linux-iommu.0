From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 09/10] swiotlb: add support for non-coherent DMA
Date: Fri, 26 Oct 2018 10:04:21 +0200
Message-ID: <20181026080421.GA6100@lst.de>
References: <20181008080246.20543-1-hch@lst.de> <20181008080246.20543-10-hch@lst.de> <9ea28547-dd1a-b4bd-2e91-f71e70417e7d@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <9ea28547-dd1a-b4bd-2e91-f71e70417e7d@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: Christoph Hellwig <hch@lst.de>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Mon, Oct 22, 2018 at 06:11:04PM +0100, Robin Murphy wrote:
>>   +	if (!dev_is_dma_coherent(dev) &&
>> +	    (attrs & DMA_ATTR_SKIP_CPU_SYNC) == 0)
>
> Nit: other parts of the file are already using the "!(...)" style rather 
> than "(...) == 0".

Indeed.  Probably some kind of copy and past error..

> I had a quick play at moving the cache maintenance here out into the 
> callers, which comes out arguably looking perhaps a little cleaner (only +1 
> source line overall, and actually reduces text size by 32 bytes for my 
> build), but sadly I can't really see any way of doing the equivalent for 
> map/unmap short of duplicating the whole 3-line arch_sync_*() block, which 
> just makes for a different readability problem. As you mentioned on patch 
> #7, I guess this really is just one of those things which has no nice 
> solution, so cosmetics aside,

It looks pretty ok, but given that I want to send this version to
Linus for the merge window I don't really dare to touch it.

The master plan for 4.21 is to actually merge swiotlb into dma-direct
and to allow direct calls to dma-direct given how expensive indirect
calls are with spectre, and dma mappings show up badly in various
benchmarks.  I'll see if I can do that in a way following what you've
done.
