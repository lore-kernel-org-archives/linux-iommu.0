Return-Path: <SRS0=Eb89=SH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A71E0C282CE
	for <iommu@archiver.kernel.org>; Fri,  5 Apr 2019 17:17:22 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B7CE2175B
	for <iommu@archiver.kernel.org>; Fri,  5 Apr 2019 17:17:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B7CE2175B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 0D5A325B4;
	Fri,  5 Apr 2019 17:17:22 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id C6ED125B2
	for <iommu@lists.linux-foundation.org>;
	Fri,  5 Apr 2019 17:16:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 540927F8
	for <iommu@lists.linux-foundation.org>;
	Fri,  5 Apr 2019 17:16:34 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1987A168F;
	Fri,  5 Apr 2019 10:16:34 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AFF173F557;
	Fri,  5 Apr 2019 10:16:32 -0700 (PDT)
Subject: Re: [PATCH 01/21] arm64/iommu: handle non-remapped addresses in
	->mmap and ->get_sgtable
To: Christoph Hellwig <hch@lst.de>
References: <20190327080448.5500-1-hch@lst.de>
	<20190327080448.5500-2-hch@lst.de>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <6b54f022-ca2e-b596-efcc-41a8de3d2544@arm.com>
Date: Fri, 5 Apr 2019 18:16:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190327080448.5500-2-hch@lst.de>
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
Message-ID: <20190405171631.xzx2wNP82iOGtybBFM-kFmDMS7VyPJG9f9Y995ppBOo@z>

On 27/03/2019 08:04, Christoph Hellwig wrote:
> DMA allocations that can't sleep may return non-remapped addresses, but
> we do not properly handle them in the mmap and get_sgtable methods.
> Resolve non-vmalloc addresses using virt_to_page to handle this corner
> case.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   arch/arm64/mm/dma-mapping.c | 12 +++++++++++-
>   1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
> index 78c0a72f822c..be88beb2e377 100644
> --- a/arch/arm64/mm/dma-mapping.c
> +++ b/arch/arm64/mm/dma-mapping.c
> @@ -249,6 +249,11 @@ static int __iommu_mmap_attrs(struct device *dev, struct vm_area_struct *vma,
>   	if (dma_mmap_from_dev_coherent(dev, vma, cpu_addr, size, &ret))
>   		return ret;
>   
> +	if (!is_vmalloc_addr(cpu_addr)) {
> +		unsigned long pfn = page_to_pfn(virt_to_page(cpu_addr));
> +		return __swiotlb_mmap_pfn(vma, pfn, size);
> +	}
> +
>   	if (attrs & DMA_ATTR_FORCE_CONTIGUOUS) {
>   		/*
>   		 * DMA_ATTR_FORCE_CONTIGUOUS allocations are always remapped,
> @@ -272,10 +277,15 @@ static int __iommu_get_sgtable(struct device *dev, struct sg_table *sgt,
>   	unsigned int count = PAGE_ALIGN(size) >> PAGE_SHIFT;
>   	struct vm_struct *area = find_vm_area(cpu_addr);
>   
> +	if (!is_vmalloc_addr(cpu_addr)) {
> +		struct page *page = virt_to_page(cpu_addr);
> +		return __swiotlb_get_sgtable_page(sgt, page, size);
> +	}
> +
>   	if (attrs & DMA_ATTR_FORCE_CONTIGUOUS) {
>   		/*
>   		 * DMA_ATTR_FORCE_CONTIGUOUS allocations are always remapped,
> -		 * hence in the vmalloc space.
> +		 *  hence in the vmalloc space.

Without this bit ^^,

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

>   		 */
>   		struct page *page = vmalloc_to_page(cpu_addr);
>   		return __swiotlb_get_sgtable_page(sgt, page, size);
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
