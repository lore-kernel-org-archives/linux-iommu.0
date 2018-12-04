From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH 5/9] dma-mapping: support highmem in the generic remap
 allocator
Date: Tue, 4 Dec 2018 09:38:02 +0100
Message-ID: <e1567e0d-4724-fb6b-cc22-3a723eec5e0f@samsung.com>
References: <20181105121931.13481-1-hch@lst.de>
        <20181105121931.13481-6-hch@lst.de>
        <CGME20181130190639epcas3p2c9a23f5788b7f8eea26ce8d305b5e6f7@epcas3p2.samsung.com>
        <449e0631-aa32-d4a8-9fa9-07234ae1e533@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <449e0631-aa32-d4a8-9fa9-07234ae1e533@arm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, Guo Ren <ren_guo@c-sky.com>, Laura Abbott <labbott@redhat.com>, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

Hi All,

On 2018-11-30 20:05, Robin Murphy wrote:
> On 05/11/2018 12:19, Christoph Hellwig wrote:
>> By using __dma_direct_alloc_pages we can deal entirely with struct page
>> instead of having to derive a kernel virtual address.
>
> Simple enough :)
>
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>

This patch has landed linux-next yesterday and I've noticed that it
breaks operation of many drivers. The change looked simple, but a stupid
bug managed to slip into the code. After a short investigation I've
noticed that __dma_direct_alloc_pages() doesn't set dma_handle and zero
allocated memory, while dma_direct_alloc_pages() did. The other
difference is the lack of set_memory_decrypted() handling.

Following patch fixes the issue, but maybe it would be better to fix it
in kernel/dma/direct.c:

diff --git a/kernel/dma/remap.c b/kernel/dma/remap.c
index dcc82dd668f8..7765ddc56e4e 100644
--- a/kernel/dma/remap.c
+++ b/kernel/dma/remap.c
@@ -219,8 +219,14 @@ void *arch_dma_alloc(struct device *dev, size_t
size, dma_addr_t *dma_handle,
        ret = dma_common_contiguous_remap(page, size, VM_USERMAP,
                        arch_dma_mmap_pgprot(dev, PAGE_KERNEL, attrs),
                        __builtin_return_address(0));
-       if (!ret)
+       if (!ret) {
                __dma_direct_free_pages(dev, size, page);
+               return ret;
+       }
+
+       *dma_handle = phys_to_dma(dev, page_to_phys(page));
+       memset(ret, 0, size);
+
        return ret;
 }

>
>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>> ---
>>   kernel/dma/remap.c | 14 +++++++-------
>>   1 file changed, 7 insertions(+), 7 deletions(-)
>>
>> diff --git a/kernel/dma/remap.c b/kernel/dma/remap.c
>> index bc42766f52df..8f1fca34b894 100644
>> --- a/kernel/dma/remap.c
>> +++ b/kernel/dma/remap.c
>> @@ -196,7 +196,7 @@ void *arch_dma_alloc(struct device *dev, size_t
>> size, dma_addr_t *dma_handle,
>>           gfp_t flags, unsigned long attrs)
>>   {
>>       struct page *page = NULL;
>> -    void *ret, *kaddr;
>> +    void *ret;
>>         size = PAGE_ALIGN(size);
>>   @@ -208,10 +208,9 @@ void *arch_dma_alloc(struct device *dev,
>> size_t size, dma_addr_t *dma_handle,
>>           return ret;
>>       }
>>   -    kaddr = dma_direct_alloc_pages(dev, size, dma_handle, flags,
>> attrs);
>> -    if (!kaddr)
>> +    page = __dma_direct_alloc_pages(dev, size, dma_handle, flags,
>> attrs);
>> +    if (!page)
>>           return NULL;
>> -    page = virt_to_page(kaddr);
>>         /* remove any dirty cache lines on the kernel alias */
>>       arch_dma_prep_coherent(page, size);
>> @@ -221,7 +220,7 @@ void *arch_dma_alloc(struct device *dev, size_t
>> size, dma_addr_t *dma_handle,
>>               arch_dma_mmap_pgprot(dev, PAGE_KERNEL, attrs),
>>               __builtin_return_address(0));
>>       if (!ret)
>> -        dma_direct_free_pages(dev, size, kaddr, *dma_handle, attrs);
>> +        __dma_direct_free_pages(dev, size, page);
>>       return ret;
>>   }
>>   @@ -229,10 +228,11 @@ void arch_dma_free(struct device *dev, size_t
>> size, void *vaddr,
>>           dma_addr_t dma_handle, unsigned long attrs)
>>   {
>>       if (!dma_free_from_pool(vaddr, PAGE_ALIGN(size))) {
>> -        void *kaddr = phys_to_virt(dma_to_phys(dev, dma_handle));
>> +        phys_addr_t phys = dma_to_phys(dev, dma_handle);
>> +        struct page *page = pfn_to_page(__phys_to_pfn(phys));
>>             vunmap(vaddr);
>> -        dma_direct_free_pages(dev, size, kaddr, dma_handle, attrs);
>> +        __dma_direct_free_pages(dev, size, page);
>>       }
>>   }
>>  
>
Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
