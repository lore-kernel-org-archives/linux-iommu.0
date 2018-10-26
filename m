From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 09/10] swiotlb: add support for non-coherent DMA
Date: Fri, 26 Oct 2018 10:59:52 +0100
Message-ID: <f8910e6d-d864-07cd-12f2-551149a66d42@arm.com>
References: <20181008080246.20543-1-hch@lst.de>
	<20181008080246.20543-10-hch@lst.de>
	<9ea28547-dd1a-b4bd-2e91-f71e70417e7d@arm.com>
	<20181026080421.GA6100@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20181026080421.GA6100-jcswGhMUV9g@public.gmane.org>
Content-Language: en-GB
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Cc: Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 2018-10-26 9:04 am, Christoph Hellwig wrote:
> On Mon, Oct 22, 2018 at 06:11:04PM +0100, Robin Murphy wrote:
>>>    +	if (!dev_is_dma_coherent(dev) &&
>>> +	    (attrs & DMA_ATTR_SKIP_CPU_SYNC) == 0)
>>
>> Nit: other parts of the file are already using the "!(...)" style rather
>> than "(...) == 0".
> 
> Indeed.  Probably some kind of copy and past error..
> 
>> I had a quick play at moving the cache maintenance here out into the
>> callers, which comes out arguably looking perhaps a little cleaner (only +1
>> source line overall, and actually reduces text size by 32 bytes for my
>> build), but sadly I can't really see any way of doing the equivalent for
>> map/unmap short of duplicating the whole 3-line arch_sync_*() block, which
>> just makes for a different readability problem. As you mentioned on patch
>> #7, I guess this really is just one of those things which has no nice
>> solution, so cosmetics aside,
> 
> It looks pretty ok, but given that I want to send this version to
> Linus for the merge window I don't really dare to touch it.
> 
> The master plan for 4.21 is to actually merge swiotlb into dma-direct
> and to allow direct calls to dma-direct given how expensive indirect
> calls are with spectre, and dma mappings show up badly in various
> benchmarks.  I'll see if I can do that in a way following what you've
> done.

Right, if we're going to be coming back here soon to make it efficient, 
there's even less need to worry about how beautiful it is at this point 
when we're just making it functional. I'll save up all my optimisation 
urges for the next round :)

Robin.
