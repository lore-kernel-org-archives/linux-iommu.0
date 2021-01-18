Return-Path: <SRS0=rNTl=GV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA41AC433DB
	for <iommu@archiver.kernel.org>; Mon, 18 Jan 2021 15:49:16 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FAB522AAA
	for <iommu@archiver.kernel.org>; Mon, 18 Jan 2021 15:49:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FAB522AAA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id BF4302049E;
	Mon, 18 Jan 2021 15:49:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cm7g8N+2ADX8; Mon, 18 Jan 2021 15:49:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id C9C7820485;
	Mon, 18 Jan 2021 15:49:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9FB36C08A1;
	Mon, 18 Jan 2021 15:49:13 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 20A92C013A
 for <iommu@lists.linux-foundation.org>; Mon, 18 Jan 2021 15:49:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id E21462049E
 for <iommu@lists.linux-foundation.org>; Mon, 18 Jan 2021 15:49:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ul+WJ7n+FzXe for <iommu@lists.linux-foundation.org>;
 Mon, 18 Jan 2021 15:49:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by silver.osuosl.org (Postfix) with ESMTP id 1056120485
 for <iommu@lists.linux-foundation.org>; Mon, 18 Jan 2021 15:49:09 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2B7641FB;
 Mon, 18 Jan 2021 07:49:09 -0800 (PST)
Received: from [10.57.39.58] (unknown [10.57.39.58])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 559E53F68F;
 Mon, 18 Jan 2021 07:49:06 -0800 (PST)
Subject: Re: [PATCH v6 06/33] of/device: Move dma_range_map before
 of_iommu_configure
To: Yong Wu <yong.wu@mediatek.com>, Rob Herring <robh@kernel.org>
References: <20210111111914.22211-1-yong.wu@mediatek.com>
 <20210111111914.22211-7-yong.wu@mediatek.com>
 <20210114192732.GA3401278@robh.at.kernel.org>
 <1610688626.4578.1.camel@mhfsdcap03>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <1853732d-0efd-171e-9e1f-7ee7ed72a98f@arm.com>
Date: Mon, 18 Jan 2021 15:49:06 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <1610688626.4578.1.camel@mhfsdcap03>
Content-Language: en-GB
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
 Nicolas Boichat <drinkcat@chromium.org>, srv_heupstream@mediatek.com,
 Tomasz Figa <tfiga@google.com>, Frank Rowand <frowand.list@gmail.com>,
 linux-kernel@vger.kernel.org, Evan Green <evgreen@chromium.org>,
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>, chao.hao@mediatek.com,
 iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, anan.sun@mediatek.com,
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

On 2021-01-15 05:30, Yong Wu wrote:
> On Thu, 2021-01-14 at 13:27 -0600, Rob Herring wrote:
>> On Mon, Jan 11, 2021 at 07:18:47PM +0800, Yong Wu wrote:
>>> "dev->dma_range_map" contains the devices' dma_ranges information,
>>> This patch moves dma_range_map before of_iommu_configure. The iommu
>>> driver may need to know the dma_address requirements of its iommu
>>> consumer devices.
>>>
>>> CC: Rob Herring <robh+dt@kernel.org>
>>> CC: Frank Rowand <frowand.list@gmail.com>
>>> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
>>> ---
>>>   drivers/of/device.c | 3 ++-
>>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/of/device.c b/drivers/of/device.c
>>> index aedfaaafd3e7..1d84636149df 100644
>>> --- a/drivers/of/device.c
>>> +++ b/drivers/of/device.c
>>> @@ -170,9 +170,11 @@ int of_dma_configure_id(struct device *dev, struct device_node *np,
>>>   	dev_dbg(dev, "device is%sdma coherent\n",
>>>   		coherent ? " " : " not ");
>>>   
>>> +	dev->dma_range_map = map;
>>>   	iommu = of_iommu_configure(dev, np, id);
>>>   	if (PTR_ERR(iommu) == -EPROBE_DEFER) {
>>>   		kfree(map);
>>> +		dev->dma_range_map = NULL;
>>
>> Not really going to matter, but you should probably clear dma_range_map
>> before what it points to is freed.
>>
>> With that,
>>
>> Reviewed-by: Rob Herring <robh@kernel.org>
> 
> Thanks for the review. I will move it before "kfree(map)" in next
> version.

Paul noticed that we already have a bug in assigning to this 
unconditionally[1] - I'd totally forgotten about this series when I 
theorised about IOMMU drivers wanting the information earlier, but 
sweeping my inbox now only goes to show I was right to think of it :)

We should really get something in as a fix independent of this series, 
taking both angles into account.

Robin.

[1] 
https://lore.kernel.org/linux-arm-kernel/5c7946f3-b56e-da00-a750-be097c7ceb32@arm.com/

>>
>>>   		return -EPROBE_DEFER;
>>>   	}
>>>   
>>> @@ -181,7 +183,6 @@ int of_dma_configure_id(struct device *dev, struct device_node *np,
>>>   
>>>   	arch_setup_dma_ops(dev, dma_start, size, iommu, coherent);
>>>   
>>> -	dev->dma_range_map = map;
>>>   	return 0;
>>>   }
>>>   EXPORT_SYMBOL_GPL(of_dma_configure_id);
>>> -- 
>>> 2.18.0
>>>
> 
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
