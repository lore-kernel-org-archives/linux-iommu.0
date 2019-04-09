Return-Path: <SRS0=aFDh=SL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3CC7C282DA
	for <iommu@archiver.kernel.org>; Tue,  9 Apr 2019 17:25:35 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A19732084F
	for <iommu@archiver.kernel.org>; Tue,  9 Apr 2019 17:25:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A19732084F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 64C55DDC;
	Tue,  9 Apr 2019 17:25:35 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 68602DD2
	for <iommu@lists.linux-foundation.org>;
	Tue,  9 Apr 2019 17:25:34 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id AB26FF4
	for <iommu@lists.linux-foundation.org>;
	Tue,  9 Apr 2019 17:25:33 +0000 (UTC)
Received: by newverein.lst.de (Postfix, from userid 2407)
	id D799268B02; Tue,  9 Apr 2019 19:25:20 +0200 (CEST)
Date: Tue, 9 Apr 2019 19:25:20 +0200
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 08/21] dma-iommu: refactor iommu_dma_mmap
Message-ID: <20190409172520.GE14679@lst.de>
References: <20190327080448.5500-1-hch@lst.de>
	<20190327080448.5500-9-hch@lst.de>
	<adf139e2-a595-fa08-e287-f358c06d7e91@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <adf139e2-a595-fa08-e287-f358c06d7e91@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: Tom Lendacky <thomas.lendacky@amd.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org, Christoph Hellwig <hch@lst.de>,
	linux-arm-kernel@lists.infradead.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Development issues for Linux IOMMU support
	<iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190409172520.4Mh5lO4EoVI20FpFHAzyRpFgp6NOwr6CCwqc-rYg5c8@z>

On Tue, Apr 09, 2019 at 04:29:07PM +0100, Robin Murphy wrote:
> On 27/03/2019 08:04, Christoph Hellwig wrote:
>> Move the vm_area handling into __iommu_dma_mmap, which is renamed
>> to iommu_dma_mmap_remap.
>>
>> Inline __iommu_dma_mmap_pfn into the main function to simplify the code
>> flow a bit.
>>
>> Signed-off-by: Christoph Hellwig <hch@lst.de>
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
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
