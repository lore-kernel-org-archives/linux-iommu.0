From: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] arm: dma-mapping: fix off-by-one check in
	arm_setup_iommu_dma_ops
Date: Wed, 29 Apr 2015 08:46:06 +0200
Message-ID: <55407E2E.7060102@samsung.com>
References: <1430212089-5418-1-git-send-email-m.szyprowski@samsung.com>
	<553F9EA8.7030403@arm.com> <553FA2E3.30402@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-reply-to: <553FA2E3.30402-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Cc: Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Catalin Marinas <Catalin.Marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>, Inki Dae <inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hello,

On 2015-04-28 17:10, Robin Murphy wrote:
> On 28/04/15 15:52, Robin Murphy wrote:
>> Hi Marek,
>>
>> On 28/04/15 10:08, Marek Szyprowski wrote:
>>> Patch 22b3c181c6c324a46f71aae806d8ddbe61d25761 ("arm: dma-mapping: 
>>> limit
>>> IOMMU mapping size") added a check for IO address space size. However
>>> this patch broke IOMMU initialization for typical platforms initialized
>>> from device tree, which get the default IO address space size of 4GiB.
>>> This value doesn't fit into size_t and fails a check introduced by that
>>> commit resulting in failed dma-mapping/iommu initialization. This patch
>>> fixes this issue by adding proper support for full 4GiB address space
>>> size.
>>>
>>> Signed-off-by: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
>>
>> Much nicer than my hack of just passing in size-1, thanks! I'd offer a
>> tested-by for the default 32-bit case, however...
>>
>>> ---
>>>    arch/arm/include/asm/dma-iommu.h | 2 +-
>>>    arch/arm/mm/dma-mapping.c        | 9 +++------
>>>    2 files changed, 4 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/arch/arm/include/asm/dma-iommu.h 
>>> b/arch/arm/include/asm/dma-iommu.h
>>> index 8e3fcb924db6..2ef282f96651 100644
>>> --- a/arch/arm/include/asm/dma-iommu.h
>>> +++ b/arch/arm/include/asm/dma-iommu.h
>>> @@ -25,7 +25,7 @@ struct dma_iommu_mapping {
>>>    };
>>>
>>>    struct dma_iommu_mapping *
>>> -arm_iommu_create_mapping(struct bus_type *bus, dma_addr_t base, 
>>> size_t size);
>>> +arm_iommu_create_mapping(struct bus_type *bus, dma_addr_t base, u64 
>>> size);
>>>
>>>    void arm_iommu_release_mapping(struct dma_iommu_mapping *mapping);
>>>
>>> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
>>> index 09c5fe3d30c2..b43b762eebc1 100644
>>> --- a/arch/arm/mm/dma-mapping.c
>>> +++ b/arch/arm/mm/dma-mapping.c
>>> @@ -1878,7 +1878,7 @@ struct dma_map_ops iommu_coherent_ops = {
>>>     * arm_iommu_attach_device function.
>>>     */
>>>    struct dma_iommu_mapping *
>>> -arm_iommu_create_mapping(struct bus_type *bus, dma_addr_t base, 
>>> size_t size)
>>> +arm_iommu_create_mapping(struct bus_type *bus, dma_addr_t base, u64 
>>> size)
>>>    {
>>>        unsigned int bits = size >> PAGE_SHIFT;
>>
>> ...doesn't this u64->int conversion now have the potential to truncate
>> (if the device has a large enough DMA mask specified) and end up
>> generating a weirdly small mapping rather than failing outright?
>> Admittedly you'd have to have a 44-bit or larger DMA mask, and I'm not
>> sure what the practical likelihood of seeing that even on LPAE systems
>> is, but still I'm a little uneasy about it.
>
> ...by which I mean we should move the current size check into 
> arm_iommu_create_mapping itself, rather than relying on the caller, 
> because looking at dependent bits of code in isolation can be 
> confusing ;)

Okay, no problem. I will move this check to arm_iommu_create_mapping() 
and the
problem of potential truncating will be solved. This fix is really 
needed for
v4.1-rcX. For next releases this will be probably rewritten for common 
code with
arm64 anyway.

>
> Robin.
>
>>>        unsigned int bitmap_size = BITS_TO_LONGS(bits) * sizeof(long);
>>> @@ -2057,11 +2057,8 @@ static bool arm_setup_iommu_dma_ops(struct 
>>> device *dev, u64 dma_base, u64 size,
>>>        if (!iommu)
>>>            return false;
>>>
>>> -    /*
>>> -     * currently arm_iommu_create_mapping() takes a max of size_t
>>> -     * for size param. So check this limit for now.
>>> -     */
>>> -    if (size > SIZE_MAX)
>>> +    /* Only 32-bit DMA address space is supported for now */
>>> +    if (size > DMA_BIT_MASK(32) + 1)
>>>            return false;
>>>
>>>        mapping = arm_iommu_create_mapping(dev->bus, dma_base, size);
>>>
>>
>

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
