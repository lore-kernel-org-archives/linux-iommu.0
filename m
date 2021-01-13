Return-Path: <SRS0=lzux=GQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AE58C433DB
	for <iommu@archiver.kernel.org>; Wed, 13 Jan 2021 18:27:44 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E0F823436
	for <iommu@archiver.kernel.org>; Wed, 13 Jan 2021 18:27:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E0F823436
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id F106E826AC;
	Wed, 13 Jan 2021 18:27:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aVAQOqFGT-U7; Wed, 13 Jan 2021 18:27:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id D5A0781F20;
	Wed, 13 Jan 2021 18:27:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AE5A1C088B;
	Wed, 13 Jan 2021 18:27:41 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 78B23C013A
 for <iommu@lists.linux-foundation.org>; Wed, 13 Jan 2021 18:27:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 61681204FD
 for <iommu@lists.linux-foundation.org>; Wed, 13 Jan 2021 18:27:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4CA2o21r1zbK for <iommu@lists.linux-foundation.org>;
 Wed, 13 Jan 2021 18:27:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by silver.osuosl.org (Postfix) with ESMTP id 54C49204FA
 for <iommu@lists.linux-foundation.org>; Wed, 13 Jan 2021 18:27:39 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 938921FB;
 Wed, 13 Jan 2021 10:27:38 -0800 (PST)
Received: from [10.57.56.43] (unknown [10.57.56.43])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 992EC3F66E;
 Wed, 13 Jan 2021 10:27:09 -0800 (PST)
Subject: Re: [RFC PATCH v3 4/6] swiotlb: Add restricted DMA alloc/free support.
To: Christoph Hellwig <hch@lst.de>, Claire Chang <tientzu@chromium.org>
References: <20210106034124.30560-1-tientzu@chromium.org>
 <20210106034124.30560-5-tientzu@chromium.org> <20210113124847.GC1383@lst.de>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <82bb75bc-11e6-ac94-9d24-7c896e3aae98@arm.com>
Date: Wed, 13 Jan 2021 18:27:08 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210113124847.GC1383@lst.de>
Content-Language: en-GB
Cc: heikki.krogerus@linux.intel.com, peterz@infradead.org,
 benh@kernel.crashing.org, grant.likely@arm.com, paulus@samba.org,
 frowand.list@gmail.com, mingo@kernel.org, sstabellini@kernel.org,
 saravanak@google.com, mpe@ellerman.id.au, rafael.j.wysocki@intel.com,
 bgolaszewski@baylibre.com, xen-devel@lists.xenproject.org, treding@nvidia.com,
 devicetree@vger.kernel.org, will@kernel.org, konrad.wilk@oracle.com,
 dan.j.williams@intel.com, robh+dt@kernel.org, boris.ostrovsky@oracle.com,
 andriy.shevchenko@linux.intel.com, jgross@suse.com, drinkcat@chromium.org,
 gregkh@linuxfoundation.org, rdunlap@infradead.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 xypron.glpk@gmx.de, linuxppc-dev@lists.ozlabs.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
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
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 2021-01-13 12:48, Christoph Hellwig wrote:
>> +#ifdef CONFIG_SWIOTLB
>> +	if (unlikely(dev->dma_io_tlb_mem))
>> +		return swiotlb_alloc(dev, size, dma_handle, attrs);
>> +#endif
> 
> Another place where the dma_io_tlb_mem is useful to avoid the ifdef.
> 
>> -phys_addr_t swiotlb_tbl_map_single(struct device *hwdev, phys_addr_t orig_addr,
>> -		size_t mapping_size, size_t alloc_size,
>> -		enum dma_data_direction dir, unsigned long attrs)
>> +static int swiotlb_tbl_find_free_region(struct device *hwdev,
>> +					dma_addr_t tbl_dma_addr,
>> +					size_t alloc_size,
>> +					unsigned long attrs)
> 
>> +static void swiotlb_tbl_release_region(struct device *hwdev, int index,
>> +				       size_t size)
> 
> This refactoring should be another prep patch.
> 
> 
>> +void *swiotlb_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
>> +		    unsigned long attrs)
> 
> I'd rather have the names convey there are for the per-device bounce
> buffer in some form.
> 
>> +	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
> 
> While we're at it I wonder if the io_tlb is something we could change
> while we're at it.  Maybe replace io_tlb_mem with struct swiotlb
> and rename the field in struct device to dev_swiotlb?
> 
>> +	int index;
>> +	void *vaddr;
>> +	phys_addr_t tlb_addr;
>> +
>> +	size = PAGE_ALIGN(size);
>> +	index = swiotlb_tbl_find_free_region(dev, mem->start, size, attrs);
>> +	if (index < 0)
>> +		return NULL;
>> +
>> +	tlb_addr = mem->start + (index << IO_TLB_SHIFT);
>> +	*dma_handle = phys_to_dma_unencrypted(dev, tlb_addr);
>> +
>> +	if (!dev_is_dma_coherent(dev)) {
>> +		unsigned long pfn = PFN_DOWN(tlb_addr);
>> +
>> +		/* remove any dirty cache lines on the kernel alias */
>> +		arch_dma_prep_coherent(pfn_to_page(pfn), size);
> 
> Can we hook in somewhat lower level in the dma-direct code so that all
> the remapping in dma-direct can be reused instead of duplicated?  That
> also becomes important if we want to use non-remapping uncached support,
> e.g. on mips or x86, or the direct changing of the attributes that Will
> planned to look into for arm64.

Indeed, AFAICS this ought to boil down to a direct equivalent of 
__dma_direct_alloc_pages() - other than the address there should be no 
conceptual difference between pages from the restricted pool and those 
from the regular page allocator, so this probably deserves to be plumbed 
in as an alternative to that.

Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
