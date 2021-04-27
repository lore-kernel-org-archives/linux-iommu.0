Return-Path: <SRS0=GIAn=JY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 530E5C43470
	for <iommu@archiver.kernel.org>; Tue, 27 Apr 2021 22:56:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F31BC6100B
	for <iommu@archiver.kernel.org>; Tue, 27 Apr 2021 22:56:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F31BC6100B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C2A6960B5B;
	Tue, 27 Apr 2021 22:56:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QP2hOPR9h-R5; Tue, 27 Apr 2021 22:56:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id BBACE600CB;
	Tue, 27 Apr 2021 22:56:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A6E7BC001C;
	Tue, 27 Apr 2021 22:56:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 12540C001C
 for <iommu@lists.linux-foundation.org>; Tue, 27 Apr 2021 22:56:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id F38EB60A50
 for <iommu@lists.linux-foundation.org>; Tue, 27 Apr 2021 22:56:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id a_utT0uvTILe for <iommu@lists.linux-foundation.org>;
 Tue, 27 Apr 2021 22:56:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 713E2600CB
 for <iommu@lists.linux-foundation.org>; Tue, 27 Apr 2021 22:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:content-disposition;
 bh=wchQRjaAM+wKsrfBxsOPGilEcofAMBFmBR5ncEuDJho=; b=EZ9ht7CInMnHYcsaW5R8aYmMj8
 09YKECmF6J1dtTcoVOL5n2vPnyFNuRfpmprAgXcM6moL4NCgJapVcFrAT1GmK88ZLOtBdgfU20kW0
 RY5WUjwcQBwsrdUL/HEpU3IS5o0FdSpggofru2z8+77w/Q3RnCRgS0wmH1jea1qn6LdToqi4OZ/4X
 rrypsgRTfhC4D/uJIb+BWvm1Uqf3s8+RISCE2/zVjkKMttAX0hK4dVgX2qSTi/K1a5II8R6cm3X27
 wVPZcln5l7w31LXIB1N6D4Cr8zR08kHA3166WgpMkT/o5LCOPvawHT2vKIJITGvqFOCPEE8VRwxVk
 JkwiHqmg==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
 by ale.deltatee.com with esmtp (Exim 4.92)
 (envelope-from <logang@deltatee.com>)
 id 1lbWcl-0002mT-O1; Tue, 27 Apr 2021 16:56:12 -0600
To: Jason Gunthorpe <jgg@ziepe.ca>
References: <20210408170123.8788-1-logang@deltatee.com>
 <20210408170123.8788-10-logang@deltatee.com>
 <20210427193351.GR2047089@ziepe.ca> <20210427194013.GS2047089@ziepe.ca>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <9835b877-25ba-83f8-ed39-999cfc1ad415@deltatee.com>
Date: Tue, 27 Apr 2021 16:56:11 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210427194013.GS2047089@ziepe.ca>
Content-Language: en-CA
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: robin.murphy@arm.com, ira.weiny@intel.com,
 helgaas@kernel.org, jianxin.xiong@intel.com, dave.hansen@linux.intel.com,
 jason@jlekstrand.net, dave.b.minturn@intel.com, andrzej.jakowski@intel.com,
 daniel.vetter@ffwll.ch, willy@infradead.org, ddutile@redhat.com,
 jhubbard@nvidia.com, christian.koenig@amd.com, dan.j.williams@intel.com,
 hch@lst.de, sbates@raithlin.com, iommu@lists.linux-foundation.org,
 linux-mm@kvack.org, linux-pci@vger.kernel.org, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, jgg@ziepe.ca
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH 09/16] dma-direct: Support PCI P2PDMA pages in dma-direct
 map_sg
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Cc: linux-pci@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
 linux-nvme@lists.infradead.org, Stephen Bates <sbates@raithlin.com>,
 linux-mm@kvack.org, Jason Ekstrand <jason@jlekstrand.net>,
 Ira Weiny <ira.weiny@intel.com>, Christoph Hellwig <hch@lst.de>,
 Minturn Dave B <dave.b.minturn@intel.com>,
 Matthew Wilcox <willy@infradead.org>, Bjorn Helgaas <helgaas@kernel.org>,
 Daniel Vetter <daniel.vetter@ffwll.ch>, John Hubbard <jhubbard@nvidia.com>,
 linux-block@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
 Jakowski Andrzej <andrzej.jakowski@intel.com>,
 Xiong Jianxin <jianxin.xiong@intel.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>



On 2021-04-27 1:40 p.m., Jason Gunthorpe wrote:
> On Tue, Apr 27, 2021 at 04:33:51PM -0300, Jason Gunthorpe wrote:
>> On Thu, Apr 08, 2021 at 11:01:16AM -0600, Logan Gunthorpe wrote:
>>> Add PCI P2PDMA support for dma_direct_map_sg() so that it can map
>>> PCI P2PDMA pages directly without a hack in the callers. This allows
>>> for heterogeneous SGLs that contain both P2PDMA and regular pages.
>>>
>>> SGL segments that contain PCI bus addresses are marked with
>>> sg_mark_pci_p2pdma() and are ignored when unmapped.
>>>
>>> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
>>>  kernel/dma/direct.c | 25 ++++++++++++++++++++++---
>>>  1 file changed, 22 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
>>> index 002268262c9a..108dfb4ecbd5 100644
>>> +++ b/kernel/dma/direct.c
>>> @@ -13,6 +13,7 @@
>>>  #include <linux/vmalloc.h>
>>>  #include <linux/set_memory.h>
>>>  #include <linux/slab.h>
>>> +#include <linux/pci-p2pdma.h>
>>>  #include "direct.h"
>>>  
>>>  /*
>>> @@ -387,19 +388,37 @@ void dma_direct_unmap_sg(struct device *dev, struct scatterlist *sgl,
>>>  	struct scatterlist *sg;
>>>  	int i;
>>>  
>>> -	for_each_sg(sgl, sg, nents, i)
>>> +	for_each_sg(sgl, sg, nents, i) {
>>> +		if (sg_is_pci_p2pdma(sg)) {
>>> +			sg_unmark_pci_p2pdma(sg);
>>
>> This doesn't seem nice, the DMA layer should only alter the DMA
>> portion of the SG, not the other portions. Is it necessary?
> 
> Oh, I got it completely wrong what this is for.
> 
> This should be named sg_dma_mark_pci_p2p() and similar for other
> functions to make it clear it is part of the DMA side of the SG
> interface (eg it is like sg_dma_address, sg_dma_len, etc)

Fair point. Yes, I'll rename this for the next version.

Logan
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
