Return-Path: <SRS0=Eb89=SH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B6B1C282CE
	for <iommu@archiver.kernel.org>; Fri,  5 Apr 2019 17:31:45 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 636C320651
	for <iommu@archiver.kernel.org>; Fri,  5 Apr 2019 17:31:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 636C320651
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 4509D25BC;
	Fri,  5 Apr 2019 17:31:45 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id CD3F92365
	for <iommu@lists.linux-foundation.org>;
	Fri,  5 Apr 2019 17:30:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 838B383A
	for <iommu@lists.linux-foundation.org>;
	Fri,  5 Apr 2019 17:30:56 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4D237168F;
	Fri,  5 Apr 2019 10:30:56 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B107B3F557;
	Fri,  5 Apr 2019 10:30:53 -0700 (PDT)
Subject: Re: [PATCH 02/21] arm64/iommu: improve mmap bounds checking
To: Christoph Hellwig <hch@lst.de>
References: <20190327080448.5500-1-hch@lst.de>
	<20190327080448.5500-3-hch@lst.de>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <3629087c-a8cb-d66e-840b-cfee125bdf4c@arm.com>
Date: Fri, 5 Apr 2019 18:30:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190327080448.5500-3-hch@lst.de>
Content-Language: en-GB
Cc: Tom Lendacky <thomas.lendacky@amd.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
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
Content-Type: text/plain; charset="UTF-8"; format="flowed"
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190405173052.jrkhMpDyvC5az5Vyw4ydid63kN77DV-ToSwBFen2U38@z>

On 27/03/2019 08:04, Christoph Hellwig wrote:
> The nr_pages checks should be done for all mmap requests, not just those
> using remap_pfn_range.

Hmm, the logic in iommu_dma_mmap() inherently returns an error for the 
"off >= nr_pages" case already. It's also supposed to be robust against 
the "vma_pages(vma) > nr_pages - off" condition, although by making the 
partial mapping and treating it as a success, rather than doing nothing 
and returning an error. What's the exact motivation here?

Robin.

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   arch/arm64/mm/dma-mapping.c | 21 ++++++++-------------
>   1 file changed, 8 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
> index be88beb2e377..e54288921e72 100644
> --- a/arch/arm64/mm/dma-mapping.c
> +++ b/arch/arm64/mm/dma-mapping.c
> @@ -73,19 +73,9 @@ static int __swiotlb_get_sgtable_page(struct sg_table *sgt,
>   static int __swiotlb_mmap_pfn(struct vm_area_struct *vma,
>   			      unsigned long pfn, size_t size)
>   {
> -	int ret = -ENXIO;
> -	unsigned long nr_vma_pages = vma_pages(vma);
> -	unsigned long nr_pages = PAGE_ALIGN(size) >> PAGE_SHIFT;
> -	unsigned long off = vma->vm_pgoff;
> -
> -	if (off < nr_pages && nr_vma_pages <= (nr_pages - off)) {
> -		ret = remap_pfn_range(vma, vma->vm_start,
> -				      pfn + off,
> -				      vma->vm_end - vma->vm_start,
> -				      vma->vm_page_prot);
> -	}
> -
> -	return ret;
> +	return remap_pfn_range(vma, vma->vm_start, pfn + vma->vm_pgoff,
> +			      vma->vm_end - vma->vm_start,
> +			      vma->vm_page_prot);
>   }
>   #endif /* CONFIG_IOMMU_DMA */
>   
> @@ -241,6 +231,8 @@ static int __iommu_mmap_attrs(struct device *dev, struct vm_area_struct *vma,
>   			      void *cpu_addr, dma_addr_t dma_addr, size_t size,
>   			      unsigned long attrs)
>   {
> +	unsigned long nr_pages = PAGE_ALIGN(size) >> PAGE_SHIFT;
> +	unsigned long off = vma->vm_pgoff;
>   	struct vm_struct *area;
>   	int ret;
>   
> @@ -249,6 +241,9 @@ static int __iommu_mmap_attrs(struct device *dev, struct vm_area_struct *vma,
>   	if (dma_mmap_from_dev_coherent(dev, vma, cpu_addr, size, &ret))
>   		return ret;
>   
> +	if (off >= nr_pages || vma_pages(vma) > nr_pages - off)
> +		return -ENXIO;
> +
>   	if (!is_vmalloc_addr(cpu_addr)) {
>   		unsigned long pfn = page_to_pfn(virt_to_page(cpu_addr));
>   		return __swiotlb_mmap_pfn(vma, pfn, size);
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
