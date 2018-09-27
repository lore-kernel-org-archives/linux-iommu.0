From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/5] dma-direct: add an explicit
 dma_direct_get_required_mask
Date: Thu, 27 Sep 2018 17:28:18 +0200
Message-ID: <20180927152818.GC10566@lst.de>
References: <20180920185247.20037-1-hch@lst.de> <20180920185247.20037-3-hch@lst.de> <02ce2ecc-281d-7b7f-6d30-8d246acd1eaa@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <02ce2ecc-281d-7b7f-6d30-8d246acd1eaa@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org, Marek Szyprowski <m.szyprowski@samsung.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Sep 27, 2018 at 03:12:25PM +0100, Robin Murphy wrote:
>> +u64 dma_direct_get_required_mask(struct device *dev)
>> +{
>> +	u64 max_dma = phys_to_dma_direct(dev, (max_pfn - 1) << PAGE_SHIFT);
>> +
>> +	return (1ULL << (fls64(max_dma) - 1)) * 2 - 1;
>
> I think that may as well just use __fls64() - it seems reasonable to assume 
> max_dma > 0. Otherwise,

Is there any good reason to micro-optimize given that this isn't
a fast path?
