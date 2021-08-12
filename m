Return-Path: <SRS0=jPbF=ND=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EB8BC4338F
	for <iommu@archiver.kernel.org>; Thu, 12 Aug 2021 10:38:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC55B60C3F
	for <iommu@archiver.kernel.org>; Thu, 12 Aug 2021 10:38:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AC55B60C3F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 646F5405F7;
	Thu, 12 Aug 2021 10:38:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VouSM98KUDwc; Thu, 12 Aug 2021 10:38:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 4A52A40732;
	Thu, 12 Aug 2021 10:38:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1E676C0010;
	Thu, 12 Aug 2021 10:38:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 556DAC000E
 for <iommu@lists.linux-foundation.org>; Thu, 12 Aug 2021 10:38:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4493040758
 for <iommu@lists.linux-foundation.org>; Thu, 12 Aug 2021 10:38:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9XwJeSDktIDc for <iommu@lists.linux-foundation.org>;
 Thu, 12 Aug 2021 10:38:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id A3A3B400E8
 for <iommu@lists.linux-foundation.org>; Thu, 12 Aug 2021 10:38:10 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9E3761042;
 Thu, 12 Aug 2021 03:38:09 -0700 (PDT)
Received: from [10.57.36.146] (unknown [10.57.36.146])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 828633F718;
 Thu, 12 Aug 2021 03:38:08 -0700 (PDT)
Subject: Re: [PATCH v3 2/5] dma-iommu: fix arch_sync_dma for map
To: David Stevens <stevensd@chromium.org>
References: <20210811024247.1144246-1-stevensd@google.com>
 <20210811024247.1144246-3-stevensd@google.com>
 <5b4fd891-a86a-42cd-5b69-bc08d351dd3a@arm.com>
 <CAD=HUj7RLtRkKwRHOAeuJXiiLp9WujOysYAoU0s2Nx5qR1_B7g@mail.gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <f13552b1-b582-8134-a87d-c3fca494a86d@arm.com>
Date: Thu, 12 Aug 2021 11:38:02 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAD=HUj7RLtRkKwRHOAeuJXiiLp9WujOysYAoU0s2Nx5qR1_B7g@mail.gmail.com>
Content-Language: en-GB
Cc: open list <linux-kernel@vger.kernel.org>, Tom Murphy <murphyt7@tcd.ie>,
 iommu@lists.linux-foundation.org, Will Deacon <will@kernel.org>
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

On 2021-08-12 10:21, David Stevens wrote:
> On Thu, Aug 12, 2021 at 3:47 AM Robin Murphy <robin.murphy@arm.com> wrote:
>>
>> On 2021-08-11 03:42, David Stevens wrote:
>>> From: David Stevens <stevensd@chromium.org>
>>>
>>> When calling arch_sync_dma, we need to pass it the memory that's
>>> actually being used for dma. When using swiotlb bounce buffers, this is
>>> the bounce buffer. Move arch_sync_dma into the __iommu_dma_map_swiotlb
>>> helper, so it can use the bounce buffer address if necessary. This also
>>> means it is no longer necessary to call iommu_dma_sync_sg_for_device in
>>> iommu_dma_map_sg for untrusted devices.
>>>
>>> Fixes: 82612d66d51d ("iommu: Allow the dma-iommu api to use bounce buffers")
>>> Signed-off-by: David Stevens <stevensd@chromium.org>
>>> ---
>>>    drivers/iommu/dma-iommu.c | 16 +++++++---------
>>>    1 file changed, 7 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
>>> index 54e103b989d9..4f0cc4a0a61f 100644
>>> --- a/drivers/iommu/dma-iommu.c
>>> +++ b/drivers/iommu/dma-iommu.c
>>> @@ -576,6 +576,9 @@ static dma_addr_t __iommu_dma_map_swiotlb(struct device *dev, phys_addr_t phys,
>>>                memset(padding_start, 0, padding_size);
>>>        }
>>>
>>> +     if (!coherent && !(attrs & DMA_ATTR_SKIP_CPU_SYNC))
>>
>> Make that an "else if" - otherwise you're just reintroducing the same
>> thing that the third hunk is trying to clean up.
> 
> swiotlb_tbl_map_single only copies into the swiotlb buffer, it doesn't
> do any architectural syncing. So this block is necessary in the
> swiotlb case as well, for iommu_dma_map_page to work properly.

Urgh, apologies again - I had a mental short-circuit and was convinced 
that the SWIOTLB call already did its own cache maintenance. I really 
should have learned by now not to review fiddly patches like these while 
tired...
> The third chunk is a separate optimization, so I'll split it out into
> its own patch.

It's still a logical part of this change - cleaning up the potentially 
wrong sync while you make sure the right one happens. Even more so if 
you make the fix the better way by having iommu_dma_map_sg_swiotlb() 
call iommu_dma_map_page().

Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
