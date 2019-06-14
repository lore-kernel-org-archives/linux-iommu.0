Return-Path: <SRS0=ZdmF=UN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CA38C31E4C
	for <iommu@archiver.kernel.org>; Fri, 14 Jun 2019 10:42:59 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 474E9208CA
	for <iommu@archiver.kernel.org>; Fri, 14 Jun 2019 10:42:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 474E9208CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 1837E11DB;
	Fri, 14 Jun 2019 10:42:59 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id D98721088
	for <iommu@lists.linux-foundation.org>;
	Fri, 14 Jun 2019 10:42:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 5AB28E5
	for <iommu@lists.linux-foundation.org>;
	Fri, 14 Jun 2019 10:42:57 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E6D64A78;
	Fri, 14 Jun 2019 03:42:56 -0700 (PDT)
Received: from [10.1.197.57] (e110467-lin.cambridge.arm.com [10.1.197.57])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 168853F246;
	Fri, 14 Jun 2019 03:44:39 -0700 (PDT)
Subject: Re: [PATCH] iommu/dma: Apply dma_{alloc,free}_contiguous functions
To: Christoph Hellwig <hch@lst.de>, Nicolin Chen <nicoleotsuka@gmail.com>
References: <20190603225259.21994-1-nicoleotsuka@gmail.com>
	<20190606062840.GD26745@lst.de>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <67324adb-d9bc-03f6-6ec7-1463a2f35474@arm.com>
Date: Fri, 14 Jun 2019 11:42:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190606062840.GD26745@lst.de>
Content-Language: en-GB
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
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

On 06/06/2019 07:28, Christoph Hellwig wrote:
> Looks fine to me.  Robin, any comments?

AFAICS this looks like the obvious conversion, so... no? :)

> On Mon, Jun 03, 2019 at 03:52:59PM -0700, Nicolin Chen wrote:
>> This patch replaces dma_{alloc,release}_from_contiguous() with
>> dma_{alloc,free}_contiguous() to simplify those function calls.

Acked-by: Robin Murphy <robin.murphy@arm.com>

>> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
>> ---
>>   drivers/iommu/dma-iommu.c | 14 ++++----------
>>   1 file changed, 4 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
>> index 0cd49c2d3770..cc3d39dbbe1a 100644
>> --- a/drivers/iommu/dma-iommu.c
>> +++ b/drivers/iommu/dma-iommu.c
>> @@ -951,8 +951,8 @@ static void __iommu_dma_free(struct device *dev, size_t size, void *cpu_addr)
>>   
>>   	if (pages)
>>   		__iommu_dma_free_pages(pages, count);
>> -	if (page && !dma_release_from_contiguous(dev, page, count))
>> -		__free_pages(page, get_order(alloc_size));
>> +	if (page)
>> +		dma_free_contiguous(dev, page, alloc_size);
>>   }
>>   
>>   static void iommu_dma_free(struct device *dev, size_t size, void *cpu_addr,
>> @@ -970,12 +970,7 @@ static void *iommu_dma_alloc_pages(struct device *dev, size_t size,
>>   	struct page *page = NULL;
>>   	void *cpu_addr;
>>   
>> -	if (gfpflags_allow_blocking(gfp))
>> -		page = dma_alloc_from_contiguous(dev, alloc_size >> PAGE_SHIFT,
>> -						 get_order(alloc_size),
>> -						 gfp & __GFP_NOWARN);
>> -	if (!page)
>> -		page = alloc_pages(gfp, get_order(alloc_size));
>> +	page = dma_alloc_contiguous(dev, alloc_size, gfp);
>>   	if (!page)
>>   		return NULL;
>>   
>> @@ -997,8 +992,7 @@ static void *iommu_dma_alloc_pages(struct device *dev, size_t size,
>>   	memset(cpu_addr, 0, alloc_size);
>>   	return cpu_addr;
>>   out_free_pages:
>> -	if (!dma_release_from_contiguous(dev, page, alloc_size >> PAGE_SHIFT))
>> -		__free_pages(page, get_order(alloc_size));
>> +	dma_free_contiguous(dev, page, alloc_size);
>>   	return NULL;
>>   }
>>   
>> -- 
>> 2.17.1
> ---end quoted text---
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
