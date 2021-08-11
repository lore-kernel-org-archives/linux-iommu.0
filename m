Return-Path: <SRS0=mUms=NC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B53D4C4338F
	for <iommu@archiver.kernel.org>; Wed, 11 Aug 2021 18:22:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47CF060FE6
	for <iommu@archiver.kernel.org>; Wed, 11 Aug 2021 18:22:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 47CF060FE6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E6C4F4056B;
	Wed, 11 Aug 2021 18:22:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JX9zpx3cEBQQ; Wed, 11 Aug 2021 18:22:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id AD59D4056A;
	Wed, 11 Aug 2021 18:22:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5A45DC001A;
	Wed, 11 Aug 2021 18:22:33 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A383CC000E
 for <iommu@lists.linux-foundation.org>; Wed, 11 Aug 2021 18:22:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8A77640145
 for <iommu@lists.linux-foundation.org>; Wed, 11 Aug 2021 18:22:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HtLXJQyISXis for <iommu@lists.linux-foundation.org>;
 Wed, 11 Aug 2021 18:22:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id 524E7400F4
 for <iommu@lists.linux-foundation.org>; Wed, 11 Aug 2021 18:22:30 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 61D69D6E;
 Wed, 11 Aug 2021 11:22:29 -0700 (PDT)
Received: from [10.57.36.146] (unknown [10.57.36.146])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5A9E23F40C;
 Wed, 11 Aug 2021 11:22:28 -0700 (PDT)
Subject: Re: [PATCH v3 1/5] dma-iommu: fix sync_sg with swiotlb
To: Christoph Hellwig <hch@infradead.org>,
 David Stevens <stevensd@chromium.org>
References: <20210811024247.1144246-1-stevensd@google.com>
 <20210811024247.1144246-2-stevensd@google.com>
 <YRNmxU9Ou2OcvBq2@infradead.org>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <0340855f-def5-d5cf-0f2a-6d978df2c5c6@arm.com>
Date: Wed, 11 Aug 2021 19:22:22 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YRNmxU9Ou2OcvBq2@infradead.org>
Content-Language: en-GB
Cc: iommu@lists.linux-foundation.org, Will Deacon <will@kernel.org>,
 linux-kernel@vger.kernel.org, Tom Murphy <murphyt7@tcd.ie>
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

On 2021-08-11 06:57, Christoph Hellwig wrote:
> On Wed, Aug 11, 2021 at 11:42:43AM +0900, David Stevens wrote:
>> From: David Stevens <stevensd@chromium.org>
>>
>> The is_swiotlb_buffer function takes the physical address of the swiotlb
>> buffer, not the physical address of the original buffer. The sglist
>> contains the physical addresses of the original buffer, so for the
>> sync_sg functions to work properly when a bounce buffer might have been
>> used, we need to use iommu_iova_to_phys to look up the physical address.
>> This is what sync_single does, so call that function on each sglist
>> segment.
>>
>> The previous code mostly worked because swiotlb does the transfer on map
>> and unmap. However, any callers which use DMA_ATTR_SKIP_CPU_SYNC with
>> sglists or which call sync_sg would not have had anything copied to the
>> bounce buffer.
>>
>> Fixes: 82612d66d51d ("iommu: Allow the dma-iommu api to use bounce buffers")
>> Signed-off-by: David Stevens <stevensd@chromium.org>
>> ---
>>   drivers/iommu/dma-iommu.c | 27 +++++++++++++--------------
>>   1 file changed, 13 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
>> index 98ba927aee1a..54e103b989d9 100644
>> --- a/drivers/iommu/dma-iommu.c
>> +++ b/drivers/iommu/dma-iommu.c
>> @@ -813,14 +813,13 @@ static void iommu_dma_sync_sg_for_cpu(struct device *dev,
>>   	if (dev_is_dma_coherent(dev) && !dev_is_untrusted(dev))
>>   		return;
>>   
>> +	if (dev_is_untrusted(dev))
>> +		for_each_sg(sgl, sg, nelems, i)
>> +			iommu_dma_sync_single_for_cpu(dev, sg_dma_address(sg),
>> +						      sg->length, dir);
>> +	else
>> +		for_each_sg(sgl, sg, nelems, i)
>>   			arch_sync_dma_for_cpu(sg_phys(sg), sg->length, dir);
>>   }
> 
> I'd remove the above check and fold the if (!dev_is_dma_coherent(dev))
> into the else line.  Same for iommu_dma_sync_sg_for_device.

+1

With those also cleaned up,

Reviewed-by: Robin Murphy <robin.murphy@arm.com>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
