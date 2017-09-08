From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] iommu/dma: limit the IOVA allocated to dma-ranges region
Date: Fri, 8 Sep 2017 15:12:53 +0100
Message-ID: <a4b09f0f-bde4-d999-b041-370c9bf26a38@arm.com>
References: <1504217301-17216-1-git-send-email-vdumpa@nvidia.com>
 <20170901092609.GL19533@8bytes.org>
 <3aeeb13e-045f-4cde-2cfb-62d4a879d207@arm.com>
 <385a0aa33013452fa7ac269cb6188b52@HQMAIL107.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <385a0aa33013452fa7ac269cb6188b52@HQMAIL107.nvidia.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Krishna Reddy <vdumpa@nvidia.com>, Joerg Roedel <joro@8bytes.org>
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

On 05/09/17 18:35, Krishna Reddy wrote:
> Robin,
>>> Why? IOVA allocation is already constrained as much as it should be - if the device's DMA mask is wrong that's another problem, and this isn't the right place to fix it.
> 
> This is because of following reasons.
> 1. Many of the HW modules in Tegra114 and Tegra30 can't access IOVA that overlap with MMIO. Even though these HW modules support 32-bit addressing, They can't access IOVA overlapping with range 0xff00:0000 to 0xffff:fffff, which is MMIO region for high vectors. These modules can only see 0x8000:0000 to 0xff00:0000 as IOVA. If dma mask is set to use 31-bit, the IOVA range reduces from ~2GB to 1GB.  The patch is to get most of IOVA range usable by using dma-ranges property. As we already use dma-ranges start as bottom on IOVA range, The patch is to restrict the IOVA top as well using dma-ranges range. 

OK, so that's really just another variant of the existing problem we
have with certain PCI root complexes with restrictive inbound windows.
The appropriate way to handle that is to reserve the unusable areas of
the IOVA space up-front. Since the support for the ACPI equivalent of
"dma-ranges" has just landed, this is now pretty much top of my
to-do-list for the upcoming cycle (there's various things still to fix
in the DT code, but that's essentially part of the same job).

> 2. Most of  the drivers in Linux Kernel are setting mask as either 32-bit or 64-bit.  Especially, I am referring to driver/mmc/host/sdhci.c (sdhci_set_dma_mask()) here.  In Tegra124/210/186, HW modules support 34-bit addressing.  But, sdhci only support setting mask as either 32-bit or 64-bit.  As you pointed, This can be fixed by changing mask in sdhci common code.  Or This patch can help here as well without changing the driver code. 1 is the main driving factor for this patch.

In the case of a 64-bit-capable IP block with only 34 bits of address
wired up externally, if that 34-bit interconnect is described by
"dma-ranges" then the device will already be created with an appropriate
34-bit DMA mask. The fact that the driver can stomp on that with a
64-bit mask later is entirely down to the implementations of
dma_set_mask() etc. (I've had a patch to restrict masks for arm64 for a
while, but I worry that it carries quite a high risk of breakage in
default cases).

Robin.

>>> dma_32bit_pfn means nothing more than an internal detail of IOVA allocator caching, which is subject to change[1]. As-is, on some platforms this patch will effectively force all allocations to fail already.
> 
> I see that your patches are removing specifying end of IOVA during init_iova_domain() and use mask as the end of IOVA range.  Do you have any suggestion on how to handle 1 in a way to use most of IOVA range supported by HW?  Can IOVA code look for dma-ranges on its own and limit the iova top to lowest of mask and dma-ranges, if it is present? or any other ways you can think of?
> 
> -KR
> 
> -----Original Message-----
> From: Robin Murphy [mailto:robin.murphy@arm.com] 
> Sent: Friday, September 1, 2017 2:43 AM
> To: Joerg Roedel <joro@8bytes.org>; Krishna Reddy <vdumpa@nvidia.com>
> Cc: iommu@lists.linux-foundation.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] iommu/dma: limit the IOVA allocated to dma-ranges region
> 
> On 01/09/17 10:26, Joerg Roedel wrote:
>> Adding Robin for review.
>>
>> On Thu, Aug 31, 2017 at 03:08:21PM -0700, Krishna Reddy wrote:
>>> Limit the IOVA allocated to dma-ranges specified for the device.
>>> This is necessary to ensure that IOVA allocated is addressable by 
>>> device.
> 
> Why? IOVA allocation is already constrained as much as it should be - if the device's DMA mask is wrong that's another problem, and this isn't the right place to fix it.
> 
> dma_32bit_pfn means nothing more than an internal detail of IOVA allocator caching, which is subject to change[1]. As-is, on some platforms this patch will effectively force all allocations to fail already.
> 
> Robin.
> 
> [1]:https://www.mail-archive.com/iommu@lists.linux-foundation.org/msg19694.html
>>> Signed-off-by: Krishna Reddy <vdumpa@nvidia.com>
>>> ---
>>>  drivers/iommu/dma-iommu.c | 5 +++++
>>>  1 file changed, 5 insertions(+)
>>>
>>> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c 
>>> index 9d1cebe7f6cb..e8a8320b571b 100644
>>> --- a/drivers/iommu/dma-iommu.c
>>> +++ b/drivers/iommu/dma-iommu.c
>>> @@ -364,6 +364,7 @@ static dma_addr_t iommu_dma_alloc_iova(struct iommu_domain *domain,
>>>  	struct iommu_dma_cookie *cookie = domain->iova_cookie;
>>>  	struct iova_domain *iovad = &cookie->iovad;
>>>  	unsigned long shift, iova_len, iova = 0;
>>> +	dma_addr_t dma_end_addr;
>>>  
>>>  	if (cookie->type == IOMMU_DMA_MSI_COOKIE) {
>>>  		cookie->msi_iova += size;
>>> @@ -381,6 +382,10 @@ static dma_addr_t iommu_dma_alloc_iova(struct iommu_domain *domain,
>>>  	if (iova_len < (1 << (IOVA_RANGE_CACHE_MAX_SIZE - 1)))
>>>  		iova_len = roundup_pow_of_two(iova_len);
>>>  
>>> +	/* Limit IOVA allocated to device addressable dma-ranges region. */
>>> +	dma_end_addr = (dma_addr_t)iovad->dma_32bit_pfn << shift;
>>> +	dma_limit = dma_limit > dma_end_addr ? dma_end_addr : dma_limit;
>>
>> This looks like a good use-case for min().
>>
>>> +
>>>  	if (domain->geometry.force_aperture)
>>>  		dma_limit = min(dma_limit, domain->geometry.aperture_end);
>>>  
>>> --
>>> 2.1.4
> 
