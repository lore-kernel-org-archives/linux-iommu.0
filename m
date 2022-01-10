Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2837C433F5
	for <iommu@archiver.kernel.org>; Mon, 10 Jan 2022 09:16:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 936466059D;
	Mon, 10 Jan 2022 09:16:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id d6T53piD2To8; Mon, 10 Jan 2022 09:16:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 601BC6077D;
	Mon, 10 Jan 2022 09:16:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4326EC002F;
	Mon, 10 Jan 2022 09:16:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 41412C001E
 for <iommu@lists.linux-foundation.org>; Mon, 10 Jan 2022 09:16:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 20F536059D
 for <iommu@lists.linux-foundation.org>; Mon, 10 Jan 2022 09:16:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QfO962QjIxV4 for <iommu@lists.linux-foundation.org>;
 Mon, 10 Jan 2022 09:16:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 349D56077D
 for <iommu@lists.linux-foundation.org>; Mon, 10 Jan 2022 09:16:10 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: kholk11) with ESMTPSA id 6778E1F42A0E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1641806167;
 bh=ko9PyfHfXUQ54uvKK91bDlr12CFlcFrh5rboB/iLW/Q=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=cSzB3wZAcUpfPmzVKbwslpGBvZ95MYxp22jFv/6Y2kPIZv65Sp8v5ge/qEg/CSu+0
 syDIEP1z3tqZnvjmCBNsgzxZyMTwmrKcgdLBK9D/tsU4OKCgnragTgUkMmiwZOtypn
 EfKcH46Q9M+zYYEk2NcBW4eu4cwdn9t65yYFzF0BnjvAVpaHkHXVGo+Pn1nZTJHhIl
 9gX9AueyH/bMF+Vq8mah2ZA3HxwgfnXW6xC4DYNjCsjCqMBbHn3cQTmr2Wu3OpLdEN
 mpBEFAKDR4K1X5CUXlZWn0UCYJUp5h+Ht086VJAbvJrx1cVnmwwdJC3hno93cfYaX8
 SJA1uw4s7DiBQ==
Subject: Re: [PATCH v3 09/33] iommu/mediatek: Remove for_each_m4u in
 tlb_sync_all
To: Yong Wu <yong.wu@mediatek.com>
References: <20210923115840.17813-1-yong.wu@mediatek.com>
 <20210923115840.17813-10-yong.wu@mediatek.com>
 <bfa33e94-c2e5-5dab-c9af-b674e1669daa@collabora.com>
 <22faee018a36a49e4a507b69d087432c8cd689ec.camel@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Message-ID: <85987e9a-dfb0-c241-1dde-43c050a78b51@collabora.com>
Date: Mon, 10 Jan 2022 10:16:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <22faee018a36a49e4a507b69d087432c8cd689ec.camel@mediatek.com>
Content-Language: en-US
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
 srv_heupstream@mediatek.com,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
 Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
 yen-chang.chen@mediatek.com, chao.hao@mediatek.com,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 linux-mediatek@lists.infradead.org, Hsin-Yi Wang <hsinyi@chromium.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, anan.sun@mediatek.com,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
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

Il 09/01/22 03:48, Yong Wu ha scritto:
> On Tue, 2022-01-04 at 16:55 +0100, AngeloGioacchino Del Regno wrote:
>> Il 23/09/21 13:58, Yong Wu ha scritto:
>>> The tlb_sync_all is called from these three functions:
>>> a) flush_iotlb_all: it will be called for each a iommu HW.
>>> b) tlb_flush_range_sync: it already has for_each_m4u.
>>> c) in irq: When IOMMU HW translation fault, Only need flush itself.
>>>
>>> Thus, No need for_each_m4u in this tlb_sync_all. Remove it.
>>>
>>> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
>>> ---
>>>    drivers/iommu/mtk_iommu.c | 18 +++++++-----------
>>>    1 file changed, 7 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
>>> index 6f4f6624e3ac..0b4c30baa864 100644
>>> --- a/drivers/iommu/mtk_iommu.c
>>> +++ b/drivers/iommu/mtk_iommu.c
>>> @@ -206,19 +206,15 @@ static struct mtk_iommu_domain
>>> *to_mtk_domain(struct iommu_domain *dom)
>>>    
>>>    static void mtk_iommu_tlb_flush_all(struct mtk_iommu_data *data)
>>>    {
>>> -	struct list_head *head = data->hw_list;
>>> -
>>> -	for_each_m4u(data, head) {
>>> -		if (pm_runtime_get_if_in_use(data->dev) <= 0)
>>> -			continue;
>>> +	if (pm_runtime_get_if_in_use(data->dev) <= 0)
>>> +		return;
>>>    
>>> -		writel_relaxed(F_INVLD_EN1 | F_INVLD_EN0,
>>> -			       data->base + data->plat_data-
>>>> inv_sel_reg);
>>> -		writel_relaxed(F_ALL_INVLD, data->base +
>>> REG_MMU_INVALIDATE);
>>> -		wmb(); /* Make sure the tlb flush all done */
>>> +	writel_relaxed(F_INVLD_EN1 | F_INVLD_EN0,
>>> +		       data->base + data->plat_data->inv_sel_reg);
>>> +	writel_relaxed(F_ALL_INVLD, data->base + REG_MMU_INVALIDATE);
>>> +	wmb(); /* Make sure the tlb flush all done */
>>
>> There aren't a lot of writes here - not anymore, since you are no
>> longer doing
>> this for_each_m4u()...
>> ...so, please change writel_relaxed() to writel() calls, allowing you
>> to also
>> remove the write barrier at the end (since in the non relaxed
>> version, order is already ensured).
> 
> In the "writel", the "__iowmb()" runs before "write_relaxed". Then how
> to guarantee the last register was wrote into the HW. Here the flush
> all don't have sync(waiting it complete)
> 

That's right, I'm sorry for the invalid proposal.

Though, there's something else to mention here... if writing
(F_INVLD_EN1 | F_INVLD_EN0) to inv_sel_reg is *required* to happen before
writing F_ALL_INVLD to REG_MMU_INVALIDATE (which I think is exactly the
case here), then, in order to ensure write ordering, you should still use
writel() instead of the relaxed accessor; after which, since (as you mentioned)
there is no sync readback loop, you can keep that wmb() at the end.

>>
>>>    
>>> -		pm_runtime_put(data->dev);
>>> -	}
>>> +	pm_runtime_put(data->dev);
>>>    }
>>>    
>>>    static void mtk_iommu_tlb_flush_range_sync(unsigned long iova,
>>> size_t size,
>>>
> 


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
