From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: Re: [PATCH 08/21] dma-iommu: refactor iommu_dma_mmap
Date: Tue, 9 Apr 2019 19:25:20 +0200
Message-ID: <20190409172520.GE14679@lst.de>
References: <20190327080448.5500-1-hch@lst.de>
	<20190327080448.5500-9-hch@lst.de>
	<adf139e2-a595-fa08-e287-f358c06d7e91@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <adf139e2-a595-fa08-e287-f358c06d7e91-5wv7dgnIgG8@public.gmane.org>
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
Cc: Tom Lendacky <thomas.lendacky-5C7GfCeVMHo@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Apr 09, 2019 at 04:29:07PM +0100, Robin Murphy wrote:
> On 27/03/2019 08:04, Christoph Hellwig wrote:
>> Move the vm_area handling into __iommu_dma_mmap, which is renamed
>> to iommu_dma_mmap_remap.
>>
>> Inline __iommu_dma_mmap_pfn into the main function to simplify the code
>> flow a bit.
>>
>> Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
>> ---
>>   drivers/iommu/dma-iommu.c | 50 ++++++++++++++-------------------------
>>   1 file changed, 18 insertions(+), 32 deletions(-)
>>
>> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
>> index d14fe9f8c692..43bd3c7e0f6b 100644
>> --- a/drivers/iommu/dma-iommu.c
>> +++ b/drivers/iommu/dma-iommu.c
>> @@ -597,23 +597,27 @@ static struct page **__iommu_dma_alloc(struct device *dev, size_t size,
>>   }
>>     /**
>> - * __iommu_dma_mmap - Map a buffer into provided user VMA
>> - * @pages: Array representing buffer from __iommu_dma_alloc()
>> + * iommu_dma_mmap_remap - Map a remapped page array into provided user VMA
>> + * @cpu_addr: virtual address of the memory to be remapped
>>    * @size: Size of buffer in bytes
>>    * @vma: VMA describing requested userspace mapping
>>    *
>> - * Maps the pages of the buffer in @pages into @vma. The caller is responsible
>> + * Maps the pages pointed to by @cpu_addr into @vma. The caller is responsible
>>    * for verifying the correct size and protection of @vma beforehand.
>>    */
>> -static int __iommu_dma_mmap(struct page **pages, size_t size,
>> +static int iommu_dma_mmap_remap(void *cpu_addr, size_t size,
>>   		struct vm_area_struct *vma)
>>   {
>> +	struct vm_struct *area = find_vm_area(cpu_addr);
>>   	unsigned long uaddr = vma->vm_start;
>>   	unsigned int i, count = PAGE_ALIGN(size) >> PAGE_SHIFT;
>>   	int ret = -ENXIO;
>>   +	if (WARN_ON(!area || !area->pages))
>> +		return -ENXIO;
>> +
>>   	for (i = vma->vm_pgoff; i < count && uaddr < vma->vm_end; i++) {
>> -		ret = vm_insert_page(vma, uaddr, pages[i]);
>> +		ret = vm_insert_page(vma, uaddr, area->pages[i]);
>>   		if (ret)
>>   			break;
>>   		uaddr += PAGE_SIZE;
>> @@ -1052,21 +1056,13 @@ static void iommu_dma_free(struct device *dev, size_t size, void *cpu_addr,
>>   	}
>>   }
>>   -static int __iommu_dma_mmap_pfn(struct vm_area_struct *vma,
>> -			      unsigned long pfn, size_t size)
>> -{
>> -	return remap_pfn_range(vma, vma->vm_start, pfn + vma->vm_pgoff,
>> -			       vma->vm_end - vma->vm_start,
>> -			       vma->vm_page_prot);
>> -}
>> -
>>   static int iommu_dma_mmap(struct device *dev, struct vm_area_struct *vma,
>>   		void *cpu_addr, dma_addr_t dma_addr, size_t size,
>>   		unsigned long attrs)
>>   {
>>   	unsigned long nr_pages = PAGE_ALIGN(size) >> PAGE_SHIFT;
>>   	unsigned long off = vma->vm_pgoff;
>> -	struct vm_struct *area;
>> +	unsigned long pfn;
>>   	int ret;
>>     	vma->vm_page_prot = arch_dma_mmap_pgprot(dev, vma->vm_page_prot, 
>> attrs);
>> @@ -1077,25 +1073,15 @@ static int iommu_dma_mmap(struct device *dev, struct vm_area_struct *vma,
>>   	if (off >= nr_pages || vma_pages(vma) > nr_pages - off)
>>   		return -ENXIO;
>>   -	if (!is_vmalloc_addr(cpu_addr)) {
>> -		unsigned long pfn = page_to_pfn(virt_to_page(cpu_addr));
>> -		return __iommu_dma_mmap_pfn(vma, pfn, size);
>> -	}
>> +	if (is_vmalloc_addr(cpu_addr)) {
>> +		if (!(attrs & DMA_ATTR_FORCE_CONTIGUOUS))
>> +			return iommu_dma_mmap_remap(cpu_addr, size, vma);
>> +		pfn = vmalloc_to_pfn(cpu_addr);
>> +	} else
>> +		pfn = page_to_pfn(virt_to_page(cpu_addr));
>
> Nit: braces around the else clause for correct style.

So I generally prefer that style too.  But in this case one of the
later patches will add an ifdef around the if { ... } else, and
adding braces would make that a lot more awkware.  There is another
occurance or two of this patter in this series elsewhere as well.
