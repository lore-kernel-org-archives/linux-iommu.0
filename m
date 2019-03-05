From: Julien Grall <julien.grall@arm.com>
Subject: Re: [Xen-devel] [PATCH] Revert "swiotlb: remove SWIOTLB_MAP_ERROR"
Date: Tue, 5 Mar 2019 09:36:53 +0000
Message-ID: <c1bf689e-63b0-24a1-14ad-4c026017f12c@arm.com>
References: <20190304195951.1118807-1-arnd@arndb.de>
 <b0b995a1-3211-870f-01af-ce837c18e8f9@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <b0b995a1-3211-870f-01af-ce837c18e8f9@arm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>, Arnd Bergmann <arnd@arndb.de>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Juergen Gross <jgross@suse.com>, Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>, linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>, iommu@lists.linux-foundation.org, Joerg Roedel <jroedel@suse.de>, xen-devel@lists.xenproject.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: iommu@lists.linux-foundation.org

Hi Robin,

On 3/4/19 11:56 PM, Robin Murphy wrote:
> On 2019-03-04 7:59 pm, Arnd Bergmann wrote:
>> This reverts commit b907e20508d0 ("swiotlb: remove 
>> SWIOTLB_MAP_ERROR"), which
>> introduced an overflow warning in configurations that have a larger
>> dma_addr_t than phys_addr_t:
>>
>> In file included from include/linux/dma-direct.h:5,
>>                   from kernel/dma/swiotlb.c:23:
>> kernel/dma/swiotlb.c: In function 'swiotlb_tbl_map_single':
>> include/linux/dma-mapping.h:136:28: error: conversion from 'long long 
>> unsigned int' to 'phys_addr_t' {aka 'unsigned int'} changes value from 
>> '18446744073709551615' to '4294967295' [-Werror=overflow]
>>   #define DMA_MAPPING_ERROR  (~(dma_addr_t)0)
>>                              ^
>> kernel/dma/swiotlb.c:544:9: note: in expansion of macro 
>> 'DMA_MAPPING_ERROR'
>>    return DMA_MAPPING_ERROR;
>>
>> The configuration that caused this is on 32-bit ARM, where the DMA 
>> address
>> space depends on the enabled hardware platforms, while the physical
>> address space depends on the type of MMU chosen (classic vs LPAE).
> 
> Are these real platforms, or random configs? Realistically I don't see a 
> great deal of need to support DMA_ADDR_T_64BIT for non-LPAE. 

This is selected by CONFIG_XEN no matter the type of MMU chosen (see 
more below).

> Particularly in this case since AFAIK the only selector of SWIOTLB on 
> Arm is Xen, and that by definition is never going to be useful on 
> non-LPAE hardware.

While Xen itself requires LPAE, it is still possible to run a non-LPAE 
kernel in the guest. For instance, last time I checked, Debian was 
shipping only non-LPAE kernel for Arm32.

On Arm, swiotlb is only used by the hardware domain (aka Dom0) to allow 
DMA in memory mapped from other guest. So the returned DMA address may 
be 64-bit. Hence why we select DMA_ADDR_T_64BIT above.

Cheers,

-- 
Julien Grall
