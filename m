From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH] iommu/dma: Stop getting dma_32bit_pfn wrong
Date: Tue, 15 Nov 2016 16:22:39 +0000
Message-ID: <19c4f4fd-9d01-5408-546f-ba80cf280a0b@arm.com>
References: <f9c96106e6253f7033be8dd975392f0edb12e603.1478889045.git.robin.murphy@arm.com>
	<20161115114909.GC24857@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20161115114909.GC24857-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 15/11/16 11:49, Joerg Roedel wrote:
> On Fri, Nov 11, 2016 at 06:30:45PM +0000, Robin Murphy wrote:
>> iommu_dma_init_domain() was originally written under the misconception
>> that dma_32bit_pfn represented some sort of size limit for IOVA domains.
>> Since the truth is almost the exact opposite of that, rework the logic
>> and comments to reflect its real purpose of optimising lookups when
>> allocating from a subset of the available space.
>>
>> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
>> ---
>>  drivers/iommu/dma-iommu.c | 23 ++++++++++++++++++-----
>>  1 file changed, 18 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
>> index c5ab8667e6f2..ae045a14b530 100644
>> --- a/drivers/iommu/dma-iommu.c
>> +++ b/drivers/iommu/dma-iommu.c
>> @@ -139,6 +139,7 @@ int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
>>  {
>>  	struct iova_domain *iovad = cookie_iovad(domain);
>>  	unsigned long order, base_pfn, end_pfn;
>> +	bool pci = dev && dev_is_pci(dev);
>>  
>>  	if (!iovad)
>>  		return -ENODEV;
>> @@ -161,19 +162,31 @@ int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
>>  		end_pfn = min_t(unsigned long, end_pfn,
>>  				domain->geometry.aperture_end >> order);
>>  	}
>> +	/*
>> +	 * PCI devices may have larger DMA masks, but still prefer allocating
>> +	 * within a 32-bit mask to avoid DAC addressing. Such limitations don't
>> +	 * apply to the typical platform device, so for those we may as well
>> +	 * leave the cache limit at the top of the range they're likely to use.
>> +	 */
>> +	if (pci)
>> +		end_pfn = min_t(unsigned long, end_pfn,
>> +				DMA_BIT_MASK(32) >> order);
> 
> Question, does it actually hurt platform devices to follow the same
> allocation strategy as pci devices? I mean, does it hurt enough to
> special-case the code here?

It hurts them in the sense that they get absolutely no benefit from
trying a lower limit first (the device simply has as many address lines
wired to the interconnect as it needs/can drive), therefore there's
nothing to offset the cost of every allocation becoming
try-fail-and-try-again once <32-bits fills up with, say, big GPU
mappings. The maintenance cost of a couple of one-liner if statements
doesn't seem big enough to prevent a significant set of devices - bear
in mind that the first products really using this code in anger don't
have PCI at all (MT8173) - from having straightforward and optimal
allocation behaviour all the time, every time.

I suppose it might bear saying that as a Cambridge Water customer, I do
tend to view PCI in the same light as USB/I2C/etc. as "just another
external bus controller on the outside edge of 'the system'". From that
perspective, avoiding DAC overhead really does look like the minority
special case, although I appreciate that the view from the x86 angle is
rather different. I also suspect that, whether we want to or not, we may
continue to see more on-chip 'PCI' devices which don't really need this
either (because they're really just 'platform' devices talking directly
to whatever coherent interconnect with a config space bolted on somewhere).

Robin.
