Return-Path: <SRS0=UFM6=SZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43085C282DD
	for <iommu@archiver.kernel.org>; Tue, 23 Apr 2019 10:01:51 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D41D206A3
	for <iommu@archiver.kernel.org>; Tue, 23 Apr 2019 10:01:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D41D206A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id C4E38F0D;
	Tue, 23 Apr 2019 10:01:50 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id A28B1F09
	for <iommu@lists.linux-foundation.org>;
	Tue, 23 Apr 2019 10:01:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 84042F4
	for <iommu@lists.linux-foundation.org>;
	Tue, 23 Apr 2019 10:01:48 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4B2A0374;
	Tue, 23 Apr 2019 03:01:48 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E75913F557;
	Tue, 23 Apr 2019 03:01:46 -0700 (PDT)
Subject: Re: [PATCH 12/21] dma-iommu: factor atomic pool allocations into
	helpers
To: Christoph Hellwig <hch@lst.de>
References: <20190327080448.5500-1-hch@lst.de>
	<20190327080448.5500-13-hch@lst.de>
	<b3f80a11-1504-e8f9-4438-92bcd5f3df7f@arm.com>
	<20190410061157.GA5278@lst.de> <20190417063358.GA24139@lst.de>
	<83615173-a8b4-e0eb-bac3-1a58d61ea4ef@arm.com>
	<20190418163512.GA25347@lst.de>
	<228ee57a-d7b2-48e0-a34e-81d5fba0a090@arm.com>
	<20190419082348.GA22299@lst.de>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <0a6b3f53-79e5-af83-be39-f04c9acd8384@arm.com>
Date: Tue, 23 Apr 2019 11:01:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190419082348.GA22299@lst.de>
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
Message-ID: <20190423100144.vssiL9aH4xPWWJua4044_KXplH-Fk8VhiCVbGK9Exu0@z>

On 19/04/2019 09:23, Christoph Hellwig wrote:
> On Thu, Apr 18, 2019 at 07:15:00PM +0100, Robin Murphy wrote:
>> Still, I've worked in the vm_map_pages() stuff pending in MM and given them
>> the same treatment to finish the picture. Both x86_64_defconfig and
>> i386_defconfig do indeed compile and link fine as I expected, so I really
>> would like to understand the concern around #ifdefs better.
> 
> This looks generally fine to me.  One thing I'd like to do is to
> generally make use of the fact that __iommu_dma_get_pages returns NULL
> for the force contigous case as that cleans up a few things.  Also
> for the !DMA_REMAP case we need to try the page allocator when
> dma_alloc_from_contiguous does not return a page.  What do you thing
> of the following incremental diff?  If that is fine with you I can
> fold that in and add back in the remaining patches from my series
> not obsoleted by your patches and resend.

Wouldn't this suffice? Since we also use alloc_pages() in the coherent 
atomic case, the free path should already be able to deal with it.

Let me take a proper look at v3 and see how it all looks in context.

Robin.

----->8-----
diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 1bc8d1de1a1d..0a02ddc27862 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -944,6 +944,8 @@ static void *iommu_dma_alloc(struct device *dev, 
size_t size,
  		   (attrs & DMA_ATTR_FORCE_CONTIGUOUS)) {
  		page = dma_alloc_from_contiguous(dev, count, page_order,
  						 gfp & __GFP_NOWARN);
+		if (!page)
+			page = alloc_pages(gfp, page_order);
  	} else {
  		return iommu_dma_alloc_remap(dev, size, handle, gfp, attrs);
  	}
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
