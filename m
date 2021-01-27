Return-Path: <SRS0=KfvE=G6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33249C433DB
	for <iommu@archiver.kernel.org>; Wed, 27 Jan 2021 13:13:32 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0999207A0
	for <iommu@archiver.kernel.org>; Wed, 27 Jan 2021 13:13:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0999207A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 04E45866F4;
	Wed, 27 Jan 2021 13:13:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jggA69I4tNO8; Wed, 27 Jan 2021 13:13:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 6B667864E0;
	Wed, 27 Jan 2021 13:13:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 617A9C08A1;
	Wed, 27 Jan 2021 13:13:29 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1EC8EC013A
 for <iommu@lists.linux-foundation.org>; Wed, 27 Jan 2021 13:13:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 0CC30866E2
 for <iommu@lists.linux-foundation.org>; Wed, 27 Jan 2021 13:13:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id P-V5nar7bxkn for <iommu@lists.linux-foundation.org>;
 Wed, 27 Jan 2021 13:13:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by whitealder.osuosl.org (Postfix) with ESMTP id 86C2A864E0
 for <iommu@lists.linux-foundation.org>; Wed, 27 Jan 2021 13:13:26 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D135D1FB;
 Wed, 27 Jan 2021 05:13:25 -0800 (PST)
Received: from [10.57.47.135] (unknown [10.57.47.135])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 42E953F68F;
 Wed, 27 Jan 2021 05:13:23 -0800 (PST)
Subject: Re: [PATCH v2] of/device: Update dma_range_map only when dev has
 valid dma-ranges
To: Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>,
 Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>
References: <20210119105203.15530-1-yong.wu@mediatek.com>
 <YBFj9whLvqlV2erm@aptenodytes>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <159d4486-bb7e-249d-2bad-f5bba839041d@arm.com>
Date: Wed, 27 Jan 2021 13:13:22 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <YBFj9whLvqlV2erm@aptenodytes>
Content-Language: en-GB
Cc: devicetree@vger.kernel.org, Nicolas Boichat <drinkcat@chromium.org>,
 srv_heupstream@mediatek.com, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
 Tomasz Figa <tfiga@google.com>, iommu@lists.linux-foundation.org,
 linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>,
 Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org
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

[ + Christoph, Marek ]

On 2021-01-27 13:00, Paul Kocialkowski wrote:
> Hi,
> 
> On Tue 19 Jan 21, 18:52, Yong Wu wrote:
>> The commit e0d072782c73 ("dma-mapping: introduce DMA range map,
>> supplanting dma_pfn_offset") always update dma_range_map even though it was
>> already set, like in the sunxi_mbus driver. the issue is reported at [1].
>> This patch avoid this(Updating it only when dev has valid dma-ranges).
>>
>> Meanwhile, dma_range_map contains the devices' dma_ranges information,
>> This patch moves dma_range_map before of_iommu_configure. The iommu
>> driver may need to know the dma_address requirements of its iommu
>> consumer devices.
> 
> Just a gentle ping on this issue, it would be nice to have this fix merged
> ASAP, in the next RC :)

Ack to that - Rob, Frank, do you want to take this through the OF tree, 
or shall we take it through the DMA-mapping tree like the original culprit?

Thanks,
Robin.

> 
> Cheers,
> 
> Paul
> 
>> [1] https://lore.kernel.org/linux-arm-kernel/5c7946f3-b56e-da00-a750-be097c7ceb32@arm.com/
>>
>> CC: Rob Herring <robh+dt@kernel.org>
>> CC: Frank Rowand <frowand.list@gmail.com>
>> Fixes: e0d072782c73 ("dma-mapping: introduce DMA range map, supplanting dma_pfn_offset"),
>> Suggested-by: Robin Murphy <robin.murphy@arm.com>
>> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
>> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
>> Reviewed-by: Rob Herring <robh@kernel.org>
>> ---
>>   drivers/of/device.c | 10 +++++++---
>>   1 file changed, 7 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/of/device.c b/drivers/of/device.c
>> index aedfaaafd3e7..1122daa8e273 100644
>> --- a/drivers/of/device.c
>> +++ b/drivers/of/device.c
>> @@ -162,9 +162,11 @@ int of_dma_configure_id(struct device *dev, struct device_node *np,
>>   	mask = DMA_BIT_MASK(ilog2(end) + 1);
>>   	dev->coherent_dma_mask &= mask;
>>   	*dev->dma_mask &= mask;
>> -	/* ...but only set bus limit if we found valid dma-ranges earlier */
>> -	if (!ret)
>> +	/* ...but only set bus limit and range map if we found valid dma-ranges earlier */
>> +	if (!ret) {
>>   		dev->bus_dma_limit = end;
>> +		dev->dma_range_map = map;
>> +	}
>>   
>>   	coherent = of_dma_is_coherent(np);
>>   	dev_dbg(dev, "device is%sdma coherent\n",
>> @@ -172,6 +174,9 @@ int of_dma_configure_id(struct device *dev, struct device_node *np,
>>   
>>   	iommu = of_iommu_configure(dev, np, id);
>>   	if (PTR_ERR(iommu) == -EPROBE_DEFER) {
>> +		/* Don't touch range map if it wasn't set from a valid dma-ranges */
>> +		if (!ret)
>> +			dev->dma_range_map = NULL;
>>   		kfree(map);
>>   		return -EPROBE_DEFER;
>>   	}
>> @@ -181,7 +186,6 @@ int of_dma_configure_id(struct device *dev, struct device_node *np,
>>   
>>   	arch_setup_dma_ops(dev, dma_start, size, iommu, coherent);
>>   
>> -	dev->dma_range_map = map;
>>   	return 0;
>>   }
>>   EXPORT_SYMBOL_GPL(of_dma_configure_id);
>> -- 
>> 2.18.0
>>
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
