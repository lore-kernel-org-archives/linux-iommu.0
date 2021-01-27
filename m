Return-Path: <SRS0=KfvE=G6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD185C433DB
	for <iommu@archiver.kernel.org>; Wed, 27 Jan 2021 19:31:27 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B1B064DC1
	for <iommu@archiver.kernel.org>; Wed, 27 Jan 2021 19:31:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B1B064DC1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 640042309D;
	Wed, 27 Jan 2021 19:31:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KWih0mvikVU7; Wed, 27 Jan 2021 19:31:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id EC62922902;
	Wed, 27 Jan 2021 19:31:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B6134C08A1;
	Wed, 27 Jan 2021 19:31:24 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D7C08C013A
 for <iommu@lists.linux-foundation.org>; Wed, 27 Jan 2021 19:31:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id CB66887335
 for <iommu@lists.linux-foundation.org>; Wed, 27 Jan 2021 19:31:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vw1eO4+3Wj1i for <iommu@lists.linux-foundation.org>;
 Wed, 27 Jan 2021 19:31:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by hemlock.osuosl.org (Postfix) with ESMTP id 55BF587246
 for <iommu@lists.linux-foundation.org>; Wed, 27 Jan 2021 19:31:22 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 66C20106F;
 Wed, 27 Jan 2021 11:31:21 -0800 (PST)
Received: from [10.57.47.135] (unknown [10.57.47.135])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2B7D03F68F;
 Wed, 27 Jan 2021 11:31:19 -0800 (PST)
Subject: Re: [PATCH v2] of/device: Update dma_range_map only when dev has
 valid dma-ranges
To: Rob Herring <robh+dt@kernel.org>, Yong Wu <yong.wu@mediatek.com>
References: <20210119105203.15530-1-yong.wu@mediatek.com>
 <CAL_JsqJB=MMeMobznBiAUihJLBt5aeiiL+AtDWh6tajePu=Now@mail.gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <9fb4c940-32e9-2da3-6e6a-eff5d1cd73ac@arm.com>
Date: Wed, 27 Jan 2021 19:31:17 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <CAL_JsqJB=MMeMobznBiAUihJLBt5aeiiL+AtDWh6tajePu=Now@mail.gmail.com>
Content-Language: en-GB
Cc: devicetree@vger.kernel.org, Nicolas Boichat <drinkcat@chromium.org>,
 srv_heupstream <srv_heupstream@mediatek.com>,
 Frank Rowand <frowand.list@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
 Tomasz Figa <tfiga@google.com>, Linux IOMMU <iommu@lists.linux-foundation.org>,
 "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, Will Deacon <will@kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
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

On 2021-01-27 19:07, Rob Herring wrote:
> On Tue, Jan 19, 2021 at 4:52 AM Yong Wu <yong.wu@mediatek.com> wrote:
>>
>> The commit e0d072782c73 ("dma-mapping: introduce DMA range map,
>> supplanting dma_pfn_offset") always update dma_range_map even though it was
>> already set, like in the sunxi_mbus driver. the issue is reported at [1].
>> This patch avoid this(Updating it only when dev has valid dma-ranges).
> 
> only when dev *doesn't* have valid dma-ranges?

I believe the intent is to mean when a valid "dma-ranges" property is 
specified in DT. The implementation allows DT to take precedence even if 
platform code *has* already installed a dma_range_map, although we 
shouldn't expect that to ever happen (except perhaps in the wild early 
days of platform bringup).

Robin.

>> Meanwhile, dma_range_map contains the devices' dma_ranges information,
>> This patch moves dma_range_map before of_iommu_configure. The iommu
>> driver may need to know the dma_address requirements of its iommu
>> consumer devices.
>>
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
>>          mask = DMA_BIT_MASK(ilog2(end) + 1);
>>          dev->coherent_dma_mask &= mask;
>>          *dev->dma_mask &= mask;
>> -       /* ...but only set bus limit if we found valid dma-ranges earlier */
>> -       if (!ret)
>> +       /* ...but only set bus limit and range map if we found valid dma-ranges earlier */
>> +       if (!ret) {
>>                  dev->bus_dma_limit = end;
>> +               dev->dma_range_map = map;
>> +       }
>>
>>          coherent = of_dma_is_coherent(np);
>>          dev_dbg(dev, "device is%sdma coherent\n",
>> @@ -172,6 +174,9 @@ int of_dma_configure_id(struct device *dev, struct device_node *np,
>>
>>          iommu = of_iommu_configure(dev, np, id);
>>          if (PTR_ERR(iommu) == -EPROBE_DEFER) {
>> +               /* Don't touch range map if it wasn't set from a valid dma-ranges */
>> +               if (!ret)
>> +                       dev->dma_range_map = NULL;
>>                  kfree(map);
>>                  return -EPROBE_DEFER;
>>          }
>> @@ -181,7 +186,6 @@ int of_dma_configure_id(struct device *dev, struct device_node *np,
>>
>>          arch_setup_dma_ops(dev, dma_start, size, iommu, coherent);
>>
>> -       dev->dma_range_map = map;
>>          return 0;
>>   }
>>   EXPORT_SYMBOL_GPL(of_dma_configure_id);
>> --
>> 2.18.0
>>
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
