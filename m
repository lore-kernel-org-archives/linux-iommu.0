Return-Path: <SRS0=1kRO=GO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B714C433E0
	for <iommu@archiver.kernel.org>; Mon, 11 Jan 2021 20:39:44 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF33122CE3
	for <iommu@archiver.kernel.org>; Mon, 11 Jan 2021 20:39:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF33122CE3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 8A76F85CA8;
	Mon, 11 Jan 2021 20:39:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xVKPaVwL8c2Q; Mon, 11 Jan 2021 20:39:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id CD00085CA3;
	Mon, 11 Jan 2021 20:39:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A1609C088B;
	Mon, 11 Jan 2021 20:39:41 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C1738C013A
 for <iommu@lists.linux-foundation.org>; Mon, 11 Jan 2021 20:39:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id B46DD85C28
 for <iommu@lists.linux-foundation.org>; Mon, 11 Jan 2021 20:39:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ed2YCzWl5Tih for <iommu@lists.linux-foundation.org>;
 Mon, 11 Jan 2021 20:39:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by whitealder.osuosl.org (Postfix) with ESMTP id 60BB385BCC
 for <iommu@lists.linux-foundation.org>; Mon, 11 Jan 2021 20:39:39 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A1B9A101E;
 Mon, 11 Jan 2021 12:39:38 -0800 (PST)
Received: from [10.57.56.43] (unknown [10.57.56.43])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ADDC73F66E;
 Mon, 11 Jan 2021 12:39:37 -0800 (PST)
Subject: Re: [PATCH] dma: mark unmapped DMA scatter/gather invalid
To: Marc Orr <marcorr@google.com>
References: <20210111154335.23388-1-marcorr@google.com>
 <dc6db6b4-88f1-4762-bd3b-edf3dd410366@arm.com>
 <CAA03e5HLN_iPzXRTJ_Dvx5h8KP-Qi+=6u+9mHnaoB9oBMMWs7Q@mail.gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <bbf6f07c-369b-e470-78ff-815cfb4dbf92@arm.com>
Date: Mon, 11 Jan 2021 20:39:35 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAA03e5HLN_iPzXRTJ_Dvx5h8KP-Qi+=6u+9mHnaoB9oBMMWs7Q@mail.gmail.com>
Content-Language: en-GB
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Jianxiong Gao <jxgao@google.com>, hch@lst.de
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

On 2021-01-11 18:03, Marc Orr wrote:
>> On 2021-01-11 15:43, Marc Orr wrote:
> 
> minus stable@vger.kernel.org, per gregkh@'s email.
> 
>>> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
>>> index 0a4881e59aa7..3d9b17fe5771 100644
>>> --- a/kernel/dma/direct.c
>>> +++ b/kernel/dma/direct.c
>>> @@ -374,9 +374,11 @@ void dma_direct_unmap_sg(struct device *dev, struct scatterlist *sgl,
>>>        struct scatterlist *sg;
>>>        int i;
>>>
>>> -     for_each_sg(sgl, sg, nents, i)
>>> +     for_each_sg(sgl, sg, nents, i) {
>>>                dma_direct_unmap_page(dev, sg->dma_address, sg_dma_len(sg), dir,
>>>                             attrs);
>>> +             sg->dma_address = DMA_MAPPING_ERROR;
>>
>> There are more DMA API backends than just dma-direct, so while this
>> might help paper over bugs when SWIOTLB is in use, it's not going to
>> have any effect when those same bugs are hit under other circumstances.
>> Once again, the moral of the story is that effort is better spent just
>> fixing the bugs ;)
> 
> Thanks for the quick feedback. What is the correct fix? I understand
> the first half. The NVMe driver should be updated to not call unmap on
> an address that has already been unmapped within the DMA direct code.
> Where I'm less certain is how to communicate to the NVMe driver that
> the mapping failed. In particular, the NVMe code explicitly checks if
> the first DMA address in the scatter/gather list is set to
> DMA_MAPPING_ERROR. Thus, don't we need to update the DMA direct code
> to propagate DMA_MAPPING_ERROR back up to the driver, via the
> scatter/gather struct?

Erm, you check the return value of dma_map_sg(). If it's zero, the 
request failed; if it's nonzero, that's how many DMA segments you now 
have to process. See Documentation/core-api/dma-api.rst.

The only guarantee offered about the state of the scatterlist itself is 
that if it is successfully mapped, then the dma_address and dma_length 
fields are valid for that many segments, and if that is fewer than the 
total number of physical segments then the next one after the final DMA 
segment will have a dma_length of 0. In particular there are no 
guarantees at all about the state if the mapping was unsuccessful.

If a driver is failing to keep track of the success/failure status and 
later down the line trying to guess what to do with a list that may or 
may not have been mapped, then frankly that driver should be redesigned 
because that is a terrible anti-pattern. At the very very least it 
should explicitly encode its own "known bad" state upon failure that it 
can then reliably recognise later.

Robin.

> I skimmed arch/arm/mm/dma-mapping.c, just now. I can see that this
> code sets the address within the scatter/gather struct to
> DMA_MAPPING_ERROR before trying to map an IO address and write it into
> the struct. Is this a good example to follow?
> 
> Thanks,
> Marc
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
