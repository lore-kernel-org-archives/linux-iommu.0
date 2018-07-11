From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [RFC PATCH 1/4] dma-mapping: Generalise dma_32bit_limit flag
Date: Wed, 11 Jul 2018 17:56:40 +0100
Message-ID: <868cead9-88a7-e58d-3452-a78e19be5f47@arm.com>
References: <cover.1531239284.git.robin.murphy@arm.com>
 <a85a5fe22fced65b2960251fc6e8d8f1e68f828a.1531239284.git.robin.murphy@arm.com>
 <20180710180433.GB26285@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180710180433.GB26285@lst.de>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: m.szyprowski@samsung.com, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, lorenzo.pieralisi@arm.com, hanjun.guo@linaro.org, sudeep.holla@arm.com, robh+dt@kernel.org, frowand.list@gmail.com, gregkh@linuxfoundation.org, joro@8bytes.org, x86@kernel.org
List-Id: iommu@lists.linux-foundation.org

On 10/07/18 19:04, Christoph Hellwig wrote:
> On Tue, Jul 10, 2018 at 06:17:16PM +0100, Robin Murphy wrote:
>> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
>> index 8be8106270c2..95e185347e34 100644
>> --- a/kernel/dma/direct.c
>> +++ b/kernel/dma/direct.c
>> @@ -183,7 +183,7 @@ int dma_direct_supported(struct device *dev, u64 mask)
>>   	 * Various PCI/PCIe bridges have broken support for > 32bit DMA even
>>   	 * if the device itself might support it.
>>   	 */
>> -	if (dev->dma_32bit_limit && mask > DMA_BIT_MASK(32))
>> +	if (dev->bus_dma_mask && mask > dev->bus_dma_mask)
>>   		return 0;
> 
> The comment above this check needs an updated (or just be removed).

Right, I'll give it a tweak. I could also do with actually getting the 
field name correct in via_no_dac_cb()...

> Also we still have a few architectures not using dma-direct. I guess
> most were doing fine without such limits anyway, but at least arm
> will probably need an equivalent check.

Indeed, once we've found an approach that everyone's happy with we can 
have a more thorough audit of exactly where else it needs to be applied. 
FWIW I'm not aware of any 32-bit Arm systems affected by this*, but if 
they do exist then at least there's no risk of regression since they've 
always been busted.

Robin.


* Not counting the somewhat-similar StrongArm DMA controller bug where 
one bit in the *middle* of the mask is unusable. Let's keep that 
confined to the Arm dmabounce code and never speak of it...
