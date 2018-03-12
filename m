From: Tom Lendacky <thomas.lendacky-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 11/13] dma-direct: handle the memory encryption bit in
	common code
Date: Mon, 12 Mar 2018 14:48:51 -0500
Message-ID: <0c9d3e4a-8407-282a-73eb-21d28047e0e3@amd.com>
References: <20180305174655.9878-1-hch@lst.de>
	<20180305174655.9878-12-hch@lst.de>
	<114e27be-5814-4258-4985-af08763c8a74@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <114e27be-5814-4258-4985-af08763c8a74-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Muli Ben-Yehuda <mulix-BzGcCpaT2IbYtjvyW6yDsg@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 3/12/2018 1:29 PM, Tom Lendacky wrote:
> On 3/5/2018 11:46 AM, Christoph Hellwig wrote:
>> Give the basic phys_to_dma and dma_to_phys helpers a __-prefix and add
>> the memory encryption mask to the non-prefixed versions.  Use the
>> __-prefixed versions directly instead of clearing the mask again in
>> various places.
>>
>> With that in place the generic dma-direct routines can be used to
>> allocate non-encrypted bounce buffers, and the x86 SEV case can use
>> the generic swiotlb ops.
>>
>> Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
> 
> So this patch results in my system failing to boot when SME is active.
> I'm investigating further to see why.  I'll follow up with more details
> as I find them.

Ok, I found one issue that allows this to work when the IOMMU isn't
enabled (see below).

But the bigger issue is when the IOMMU is enabled.  The IOMMU code uses
a common mapping routine to create the I/O page tables.  This routine
assumes that all memory being mapped is encrypted and therefore sets the
encryption bit in the I/O page tables.  With this patch, the call to
dma_alloc_direct() now returns un-encrypted memory which results in an
encryption mis-match.  I think keeping dma_alloc_direct() as it was prior
to this patch is the way to go.  It allows SME DMA allocations to remain
encrypted and avoids added complexity in the amd_iommu.c file.  This
would mean that SEV would still have special DMA operations (so that the
alloc/free can change the memory to un-encrypted).

What do you think?

> 
> Additionally, when running with SME (not SEV), this is forcing all DMA
> coherent allocations to be decrypted, when that isn't required with SME
> (as long as the device can perform 48-bit or greater DMA).  So it may
> be worth looking at only doing the decrypted allocations for SEV.
> 
> Thanks,
> Tom
> 
>> ---
>>  arch/arm/include/asm/dma-direct.h                  |  4 +-
>>  arch/mips/cavium-octeon/dma-octeon.c               | 10 +--
>>  .../include/asm/mach-cavium-octeon/dma-coherence.h |  4 +-
>>  .../include/asm/mach-loongson64/dma-coherence.h    | 10 +--
>>  arch/mips/loongson64/common/dma-swiotlb.c          |  4 +-
>>  arch/powerpc/include/asm/dma-direct.h              |  4 +-
>>  arch/x86/Kconfig                                   |  2 +-
>>  arch/x86/include/asm/dma-direct.h                  | 25 +-------
>>  arch/x86/mm/mem_encrypt.c                          | 73 +---------------------
>>  arch/x86/pci/sta2x11-fixup.c                       |  6 +-
>>  include/linux/dma-direct.h                         | 21 ++++++-
>>  lib/dma-direct.c                                   | 21 +++++--
>>  lib/swiotlb.c                                      | 25 +++-----
>>  13 files changed, 70 insertions(+), 139 deletions(-)
>>

< ... SNIP ... >

>> diff --git a/lib/dma-direct.c b/lib/dma-direct.c
>> index c9e8e21cb334..84f50b5982fc 100644
>> --- a/lib/dma-direct.c
>> +++ b/lib/dma-direct.c
>> @@ -9,6 +9,7 @@
>>  #include <linux/scatterlist.h>
>>  #include <linux/dma-contiguous.h>
>>  #include <linux/pfn.h>
>> +#include <linux/set_memory.h>
>>  
>>  #define DIRECT_MAPPING_ERROR		0
>>  
>> @@ -35,9 +36,13 @@ check_addr(struct device *dev, dma_addr_t dma_addr, size_t size,
>>  	return true;
>>  }
>>  
>> +/*
>> + * Since we will be clearing the encryption bit, check the mask with it already
>> + * cleared.
>> + */
>>  static bool dma_coherent_ok(struct device *dev, phys_addr_t phys, size_t size)
>>  {
>> -	return phys_to_dma(dev, phys) + size - 1 <= dev->coherent_dma_mask;
>> +	return __phys_to_dma(dev, phys) + size - 1 <= dev->coherent_dma_mask;
>>  }
>>  
>>  void *dma_direct_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
>> @@ -46,6 +51,7 @@ void *dma_direct_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
>>  	unsigned int count = PAGE_ALIGN(size) >> PAGE_SHIFT;
>>  	int page_order = get_order(size);
>>  	struct page *page = NULL;
>> +	void *ret;
>>  
>>  	/* GFP_DMA32 and GFP_DMA are no ops without the corresponding zones: */
>>  	if (dev->coherent_dma_mask <= DMA_BIT_MASK(ARCH_ZONE_DMA_BITS))
>> @@ -78,10 +84,11 @@ void *dma_direct_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
>>  
>>  	if (!page)
>>  		return NULL;
>> -
>> -	*dma_handle = phys_to_dma(dev, page_to_phys(page));
>> -	memset(page_address(page), 0, size);
>> -	return page_address(page);
>> +	*dma_handle = __phys_to_dma(dev, page_to_phys(page));
>> +	ret = page_address(page);
>> +	set_memory_decrypted((unsigned long)ret, page_order);

The second parameter should be 1 << page_order to get the number of
pages.

Thanks,
Tom

>> +	memset(ret, 0, size);
>> +	return ret;
>>  }
>>  
>>  /*
>> @@ -92,9 +99,11 @@ void dma_direct_free(struct device *dev, size_t size, void *cpu_addr,
>>  		dma_addr_t dma_addr, unsigned long attrs)
>>  {
>>  	unsigned int count = PAGE_ALIGN(size) >> PAGE_SHIFT;
>> +	unsigned int page_order = get_order(size);
>>  
>> +	set_memory_encrypted((unsigned long)cpu_addr, 1 << page_order);
>>  	if (!dma_release_from_contiguous(dev, virt_to_page(cpu_addr), count))
>> -		free_pages((unsigned long)cpu_addr, get_order(size));
>> +		free_pages((unsigned long)cpu_addr, page_order);
>>  }
>>  
>>  static dma_addr_t dma_direct_map_page(struct device *dev, struct page *page,
>> diff --git a/lib/swiotlb.c b/lib/swiotlb.c
>> index c43ec2271469..ca8eeaead925 100644
>> --- a/lib/swiotlb.c
>> +++ b/lib/swiotlb.c
>> @@ -158,13 +158,6 @@ unsigned long swiotlb_size_or_default(void)
>>  
>>  void __weak swiotlb_set_mem_attributes(void *vaddr, unsigned long size) { }
>>  
>> -/* For swiotlb, clear memory encryption mask from dma addresses */
>> -static dma_addr_t swiotlb_phys_to_dma(struct device *hwdev,
>> -				      phys_addr_t address)
>> -{
>> -	return __sme_clr(phys_to_dma(hwdev, address));
>> -}
>> -
>>  /* Note that this doesn't work with highmem page */
>>  static dma_addr_t swiotlb_virt_to_bus(struct device *hwdev,
>>  				      volatile void *address)
>> @@ -622,7 +615,7 @@ map_single(struct device *hwdev, phys_addr_t phys, size_t size,
>>  		return SWIOTLB_MAP_ERROR;
>>  	}
>>  
>> -	start_dma_addr = swiotlb_phys_to_dma(hwdev, io_tlb_start);
>> +	start_dma_addr = __phys_to_dma(hwdev, io_tlb_start);
>>  	return swiotlb_tbl_map_single(hwdev, start_dma_addr, phys, size,
>>  				      dir, attrs);
>>  }
>> @@ -726,12 +719,12 @@ swiotlb_alloc_buffer(struct device *dev, size_t size, dma_addr_t *dma_handle,
>>  		goto out_warn;
>>  
>>  	phys_addr = swiotlb_tbl_map_single(dev,
>> -			swiotlb_phys_to_dma(dev, io_tlb_start),
>> +			__phys_to_dma(dev, io_tlb_start),
>>  			0, size, DMA_FROM_DEVICE, 0);
>>  	if (phys_addr == SWIOTLB_MAP_ERROR)
>>  		goto out_warn;
>>  
>> -	*dma_handle = swiotlb_phys_to_dma(dev, phys_addr);
>> +	*dma_handle = __phys_to_dma(dev, phys_addr);
>>  	if (dma_coherent_ok(dev, *dma_handle, size))
>>  		goto out_unmap;
>>  
>> @@ -867,10 +860,10 @@ dma_addr_t swiotlb_map_page(struct device *dev, struct page *page,
>>  	map = map_single(dev, phys, size, dir, attrs);
>>  	if (map == SWIOTLB_MAP_ERROR) {
>>  		swiotlb_full(dev, size, dir, 1);
>> -		return swiotlb_phys_to_dma(dev, io_tlb_overflow_buffer);
>> +		return __phys_to_dma(dev, io_tlb_overflow_buffer);
>>  	}
>>  
>> -	dev_addr = swiotlb_phys_to_dma(dev, map);
>> +	dev_addr = __phys_to_dma(dev, map);
>>  
>>  	/* Ensure that the address returned is DMA'ble */
>>  	if (dma_capable(dev, dev_addr, size))
>> @@ -879,7 +872,7 @@ dma_addr_t swiotlb_map_page(struct device *dev, struct page *page,
>>  	attrs |= DMA_ATTR_SKIP_CPU_SYNC;
>>  	swiotlb_tbl_unmap_single(dev, map, size, dir, attrs);
>>  
>> -	return swiotlb_phys_to_dma(dev, io_tlb_overflow_buffer);
>> +	return __phys_to_dma(dev, io_tlb_overflow_buffer);
>>  }
>>  
>>  /*
>> @@ -1009,7 +1002,7 @@ swiotlb_map_sg_attrs(struct device *hwdev, struct scatterlist *sgl, int nelems,
>>  				sg_dma_len(sgl) = 0;
>>  				return 0;
>>  			}
>> -			sg->dma_address = swiotlb_phys_to_dma(hwdev, map);
>> +			sg->dma_address = __phys_to_dma(hwdev, map);
>>  		} else
>>  			sg->dma_address = dev_addr;
>>  		sg_dma_len(sg) = sg->length;
>> @@ -1073,7 +1066,7 @@ swiotlb_sync_sg_for_device(struct device *hwdev, struct scatterlist *sg,
>>  int
>>  swiotlb_dma_mapping_error(struct device *hwdev, dma_addr_t dma_addr)
>>  {
>> -	return (dma_addr == swiotlb_phys_to_dma(hwdev, io_tlb_overflow_buffer));
>> +	return (dma_addr == __phys_to_dma(hwdev, io_tlb_overflow_buffer));
>>  }
>>  
>>  /*
>> @@ -1085,7 +1078,7 @@ swiotlb_dma_mapping_error(struct device *hwdev, dma_addr_t dma_addr)
>>  int
>>  swiotlb_dma_supported(struct device *hwdev, u64 mask)
>>  {
>> -	return swiotlb_phys_to_dma(hwdev, io_tlb_end - 1) <= mask;
>> +	return __phys_to_dma(hwdev, io_tlb_end - 1) <= mask;
>>  }
>>  
>>  #ifdef CONFIG_DMA_DIRECT_OPS
>>
