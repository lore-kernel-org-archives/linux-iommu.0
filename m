From: Julien Grall <julien.grall@arm.com>
Subject: Re: [Xen-devel] [PATCH] Revert "swiotlb: remove SWIOTLB_MAP_ERROR"
Date: Tue, 5 Mar 2019 09:41:46 +0000
Message-ID: <957e168a-2589-89c7-3a72-5071a7b6c65a@arm.com>
References: <20190304195951.1118807-1-arnd@arndb.de>
 <b0b995a1-3211-870f-01af-ce837c18e8f9@arm.com>
 <CAK8P3a2KQKTDQCQcFR7ZTFJ+_XhfKpy9W27r+YV=iD6hLVu2xg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK8P3a2KQKTDQCQcFR7ZTFJ+_XhfKpy9W27r+YV=iD6hLVu2xg@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Robin Murphy <robin.murphy@arm.com>
Cc: Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mike Rapoport <rppt@linux.ibm.com>, "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>, Joerg Roedel <jroedel@suse.de>, xen-devel <xen-devel@lists.xenproject.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: iommu@lists.linux-foundation.org

Hi Arnd,

On 3/5/19 8:16 AM, Arnd Bergmann wrote:
> On Tue, Mar 5, 2019 at 12:56 AM Robin Murphy <robin.murphy@arm.com> wrote:
>> On 2019-03-04 7:59 pm, Arnd Bergmann wrote:
>>> This reverts commit b907e20508d0 ("swiotlb: remove SWIOTLB_MAP_ERROR"), which
>>> introduced an overflow warning in configurations that have a larger
>>> dma_addr_t than phys_addr_t:
>>>
>>> In file included from include/linux/dma-direct.h:5,
>>>                    from kernel/dma/swiotlb.c:23:
>>> kernel/dma/swiotlb.c: In function 'swiotlb_tbl_map_single':
>>> include/linux/dma-mapping.h:136:28: error: conversion from 'long long unsigned int' to 'phys_addr_t' {aka 'unsigned int'} changes value from '18446744073709551615' to '4294967295' [-Werror=overflow]
>>>    #define DMA_MAPPING_ERROR  (~(dma_addr_t)0)
>>>                               ^
>>> kernel/dma/swiotlb.c:544:9: note: in expansion of macro 'DMA_MAPPING_ERROR'
>>>     return DMA_MAPPING_ERROR;
>>>
>>> The configuration that caused this is on 32-bit ARM, where the DMA address
>>> space depends on the enabled hardware platforms, while the physical
>>> address space depends on the type of MMU chosen (classic vs LPAE).
>>
>> Are these real platforms, or random configs? Realistically I don't see a
>> great deal of need to support DMA_ADDR_T_64BIT for non-LPAE.
>> Particularly in this case since AFAIK the only selector of SWIOTLB on
>> Arm is Xen, and that by definition is never going to be useful on
>> non-LPAE hardware.
> ...
> On Mon, Mar 4, 2019 at 11:00 PM Konrad Rzeszutek Wilk
> <konrad.wilk@oracle.com> wrote:
>> What about making the phys_addr_t and dma_addr_t have the same
>> width with some magic #ifdef hackery?
> 
> As far as I can tell, only randconfig builds see this problem, in
> real systems phys_addr_t is normally the same as dma_addr_t,
> and you could reasonably have a machine with a larger phys_addr_t
> than dma_addr_t but wouldn't need to bother.

On Xen, dma_addr_t will always be 64-bit while the phys_addr_t will 
depend on the MMU type. So we may have phys_addr_t smaller than 
dma_addr_t from the kernel point of view.

Cheers,

-- 
Julien Grall
