From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 11/26] iommu/dma: Factor out remapped pages lookup
Date: Mon, 29 Apr 2019 21:10:40 +0200
Message-ID: <20190429191040.GC5637@lst.de>
References: <20190422175942.18788-1-hch@lst.de> <20190422175942.18788-12-hch@lst.de> <f8c04947-0ddb-17c5-8918-5859aabc220c@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <f8c04947-0ddb-17c5-8918-5859aabc220c@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: Christoph Hellwig <hch@lst.de>, Joerg Roedel <joro@8bytes.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Tom Lendacky <thomas.lendacky@amd.com>, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Mon, Apr 29, 2019 at 02:05:46PM +0100, Robin Murphy wrote:
> On 22/04/2019 18:59, Christoph Hellwig wrote:
>> From: Robin Murphy <robin.murphy@arm.com>
>>
>> Since we duplicate the find_vm_area() logic a few times in places where
>> we only care aboute the pages, factor out a helper to abstract it.
>>
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>> [hch: don't warn when not finding a region, as we'll rely on that later]
>
> Yeah, I did think about that and the things which it might make a little 
> easier, but preserved it as-is for the sake of keeping my modifications 
> quick and simple. TBH I'm now feeling more inclined to drop the WARNs 
> entirely at this point, since it's not like there's ever been any general 
> guarantee that freeing the wrong thing shouldn't just crash, but that's 
> something we can easily come back to later if need be.

Ok, I've dropped the warnings.
