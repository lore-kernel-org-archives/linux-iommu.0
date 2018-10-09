From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: fix up nowarn confusion in the dma mapping layer
Date: Tue, 9 Oct 2018 13:55:03 +0100
Message-ID: <8da56b4f-0625-cb44-fa21-d7c1c04a56b0@arm.com>
References: <20181001201257.366-1-hch@lst.de> <20181008070358.GA3182@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181008070358.GA3182@lst.de>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On 08/10/18 08:03, Christoph Hellwig wrote:
> Any comments on these rather trivial patches?

Nope ;)

For both,
Acked-by: Robin Murphy <robin.murphy@arm.com>

> On Mon, Oct 01, 2018 at 01:12:55PM -0700, Christoph Hellwig wrote:
>> Hi all,
>>
>> this series sorts out how we deal with the nowarn flags in the dma
>> mapping code.  We still support __GFP_NOWARN for the legacy APIs that
>> don't support passing the dma specific flags, but we generally want
>> every implementation to actually check DMA_ATTR_NO_WARN instead.
>> _______________________________________________
>> iommu mailing list
>> iommu@lists.linux-foundation.org
>> https://lists.linuxfoundation.org/mailman/listinfo/iommu
> ---end quoted text---
> 
