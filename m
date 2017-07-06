From: Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [RFC PATCH 4/5] iommu/dma: Export non-static functions to use in
	modules
Date: Thu, 6 Jul 2017 11:25:09 +0900
Message-ID: <CAAFQd5C3P7Rpohq=5xoBs1mUtbQ63FbQ80-Rm08JEY-iDyipYA@mail.gmail.com>
References: <20170705071215.17603-1-tfiga@chromium.org>
	<20170705071215.17603-5-tfiga@chromium.org>
	<d02d47f2-8e89-ddba-54d9-1d1f52ae394a@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <d02d47f2-8e89-ddba-54d9-1d1f52ae394a-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Krzysztof Kozlowski <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "open list:IOMMU DRIVERS" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Vineet Gupta <vgupta-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, Hans-Christian Noren Egtvedt <egtvedt-BrfabpQBY5qlHtIdYg32fQ@public.gmane.org>, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, Jul 6, 2017 at 1:22 AM, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org> wrote:
> On 05/07/17 08:12, Tomasz Figa wrote:
>> There is nothing wrong in having a loadable module implementing DMA API,
>> for example to be used for sub-devices registered by the module. However,
>> most of the functions from dma-iommu do not have their symbols exported,
>> making it impossible to use them from loadable modules.
>>
>> Export all the non-static functions in the file, so that loadable modules
>> can benefit from them. Use EXPORT_SYMBOL() for consistency with other
>> exports in the file.
>
> To echo what Christoph said, everything not already exported here
> shouldn't in any way be considered a driver-facing API in the general
> sense, it's horrible glue code to sit behind an arch-specific DMA
> mapping implementation (and frankly I'd consider even the current
> exports more of an unfortunate abstraction leakage).

Well, if I remember correctly, we agreed that the IPU3 driver would
benefit from using all the iommu_dma_*() helpers in its DMA ops,
similarly to ARM64. This is IMHO much better than re-implementing them
again internally just for this driver. However almost none of
necessary helpers are currently exported...

>
>> Signed-off-by: Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
>> ---
>
> [...]
>
>> @@ -829,17 +838,20 @@ dma_addr_t iommu_dma_map_resource(struct device *dev, phys_addr_t phys,
>>       return __iommu_dma_map(dev, phys, size,
>>                       dma_info_to_prot(dir, false, attrs) | IOMMU_MMIO);
>>  }
>> +EXPORT_SYMBOL(iommu_dma_map_resource);
>>
>>  void iommu_dma_unmap_resource(struct device *dev, dma_addr_t handle,
>>               size_t size, enum dma_data_direction dir, unsigned long attrs)
>>  {
>>       __iommu_dma_unmap(iommu_get_domain_for_dev(dev), handle, size);
>>  }
>> +EXPORT_SYMBOL(iommu_dma_unmap_resource);
>
> Do you need these two? Unless your custom DMA ops really have to support
> slave DMA or other peer-to-peer traffic through their IOMMU, I'd be more
> inclined to implement dma_map_resource as "return 0;" and ignore
> dma_unmap_resource.

I don't need them. Getting an idea what is desirable to export and
what not is actually one of the goals of this RFC.

>
>> @@ -913,3 +925,4 @@ void iommu_dma_map_msi_msg(int irq, struct msi_msg *msg)
>>               msg->address_lo += lower_32_bits(msi_page->iova);
>>       }
>>  }
>> +EXPORT_SYMBOL(iommu_dma_map_msi_msg);
>
> Given the nature of the kind of irqchip drivers this exists for, the
> chances of one ever being modular seem vanishingly small.

Agreed. The IPU3 driver does not need it either.

Let me list the (not yet exported) helpers it requires:

dma-iommu.c
 - iommu_dma_init,
 - dma_info_to_prot,
 - iommu_dma_free,
 - iommu_dma_alloc,
 - iommu_dma_mmap,
 - iommu_dma_map_page,
 - iommu_dma_unmap_page,
 - iommu_dma_map_sg,
 - iommu_dma_unmap_sg,
 - iommu_dma_mapping_error,
(added by my patch) iommu_dma_cleanup,

iommu.c
 - iommu_group_get_for_dev,

base/dma-mapping.c
 - dma_common_pages_remap,
 - dma_common_free_remap,
(added by my patch) dma_common_get_mapped_pages (OR find_vm_area),

Best regards,
Tomasz
