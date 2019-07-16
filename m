Return-Path: <SRS0=AIpH=VN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EADBAC76188
	for <iommu@archiver.kernel.org>; Tue, 16 Jul 2019 12:02:23 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CABE22145D
	for <iommu@archiver.kernel.org>; Tue, 16 Jul 2019 12:02:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CABE22145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id A2ACDC8B;
	Tue, 16 Jul 2019 12:02:23 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 3BC669F0
	for <iommu@lists.linux-foundation.org>;
	Tue, 16 Jul 2019 12:02:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id BB84E63D
	for <iommu@lists.linux-foundation.org>;
	Tue, 16 Jul 2019 12:02:22 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EA1762B;
	Tue, 16 Jul 2019 05:02:21 -0700 (PDT)
Received: from [10.1.197.57] (e110467-lin.cambridge.arm.com [10.1.197.57])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 80CF63F71A;
	Tue, 16 Jul 2019 05:02:20 -0700 (PDT)
Subject: Re: cma_remap when using dma_alloc_attr :- DMA_ATTR_NO_KERNEL_MAPPING
To: Pankaj Suryawanshi <pankajssuryawanshi@gmail.com>
References: <CACDBo56EoKca9FJCnbztWZAARdUQs+B=dmCs+UxW27yHNu5pzQ@mail.gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <57f8aa35-d460-9933-a547-fbf578ea42d3@arm.com>
Date: Tue, 16 Jul 2019 13:02:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CACDBo56EoKca9FJCnbztWZAARdUQs+B=dmCs+UxW27yHNu5pzQ@mail.gmail.com>
Content-Language: en-GB
Cc: pankaj.suryawanshi@einfochips.com, minchan@kernel.org,
	linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
	linux-mm@kvack.org, iommu@lists.linux-foundation.org,
	minchan.kim@gmail.com, Christoph Hellwig <hch@lst.de>,
	Vlastimil Babka <vbabka@suse.cz>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On 12/07/2019 19:30, Pankaj Suryawanshi wrote:
> Hello,
> 
> When we allocate cma memory using dma_alloc_attr using
> DMA_ATTR_NO_KERNEL_MAPPING attribute. It will return physical address
> without virtual mapping and thats the use case of this attribute. but lets
> say some vpu/gpu drivers required virtual mapping of some part of the
> allocation. then we dont have anything to remap that allocated memory to
> virtual memory. and in 32-bit system it difficult for devices like android
> to work all the time with virtual mapping, it degrade the performance.
> 
> For Example :
> 
> Lets say 4k video allocation required 300MB cma memory but not required
> virtual mapping for all the 300MB, its require only 20MB virtually mapped
> at some specific use case/point of video, and unmap virtual mapping after
> uses, at that time this functions will be useful, it works like ioremap()
> for cma_alloc() using dma apis.

Hmm, is there any significant reason that this case couldn't be handled 
with just get_vm_area() plus dma_mmap_attrs(). I know it's only 
*intended* for userspace mappings, but since the basic machinery is there...

Robin.

> /*
>           * function call(s) to create virtual map of given physical memory
>           * range [base, base+size) of CMA memory.
> */
> void *cma_remap(__u32 base, __u32 size)
> {
>          struct page *page = phys_to_page(base);
>          void *virt;
> 
>          pr_debug("cma: request to map 0x%08x for size 0x%08x\n",
>                          base, size);
> 
>          size = PAGE_ALIGN(size);
> 
>          pgprot_t prot = get_dma_pgprot(DMA_ATTR, PAGE_KERNEL);
> 
>          if (PageHighMem(page)){
>                  virt = dma_alloc_remap(page, size, GFP_KERNEL, prot,
> __builtin_return_address(0));
>          }
>          else
>          {
>                  dma_remap(page, size, prot);
>                  virt = page_address(page);
>          }
> 
>          if (!virt)
>                  pr_err("\x1b[31m" " cma: failed to map 0x%08x" "\x1b[0m\n",
>                                  base);
>          else
>                  pr_debug("cma: 0x%08x is virtually mapped to 0x%08x\n",
>                                  base, (__u32) virt);
> 
>          return virt;
> }
> 
> /*
>           * function call(s) to remove virtual map of given virtual memory
>           * range [virt, virt+size) of CMA memory.
> */
> 
> void cma_unmap(void *virt, __u32 size)
> {
>          size = PAGE_ALIGN(size);
>          unsigned long pfn = virt_to_pfn(virt);
>          struct page *page = pfn_to_page(pfn);
> 
>                  if (PageHighMem(page))
>                          dma_free_remap(virt, size);
>                  else
>                          dma_remap(page, size, PAGE_KERNEL);
> 
>          pr_debug(" cma: virtual address 0x%08x is unmapped\n",
>                          (__u32) virt);
> }
> 
> This functions should be added in arch/arm/mm/dma-mapping.c file.
> 
> Please let me know if i am missing anything.
> 
> Regards,
> Pankaj
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
