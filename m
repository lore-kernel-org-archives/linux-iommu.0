From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 3/5] dma-direct: refine dma_direct_alloc zone selection
Date: Thu, 27 Sep 2018 17:30:28 +0200
Message-ID: <20180927153028.GD10566@lst.de>
References: <20180920185247.20037-1-hch@lst.de> <20180920185247.20037-4-hch@lst.de> <fd524731-a0aa-b970-d320-fe209b9c68f6@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <fd524731-a0aa-b970-d320-fe209b9c68f6@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org, Marek Szyprowski <m.szyprowski@samsung.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Sep 27, 2018 at 03:30:20PM +0100, Robin Murphy wrote:
>>   +static gfp_t __dma_direct_optimal_gfp_mask(struct device *dev, u64 
>> dma_mask,
>> +		u64 *phys_mask)
>> +{
>> +	if (force_dma_unencrypted())
>> +		*phys_mask = __dma_to_phys(dev, dma_mask);
>> +	else
>> +		*phys_mask = dma_to_phys(dev, dma_mask);
>
> Maybe make phys_to_dma_direct() take u64 instead of phys_addr_t so we can 
> reuse it here?

This is a dma_to_phys and not a phys_to_dma.
