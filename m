Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4C3DC433EF
	for <iommu@archiver.kernel.org>; Fri, 18 Feb 2022 08:41:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 31A8041DB9;
	Fri, 18 Feb 2022 08:41:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KCawCiv-3wzY; Fri, 18 Feb 2022 08:41:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B0AE141DB7;
	Fri, 18 Feb 2022 08:41:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 78DCCC0011;
	Fri, 18 Feb 2022 08:41:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E9A92C000B
 for <iommu@lists.linux-foundation.org>; Fri, 18 Feb 2022 08:41:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CE2A140184
 for <iommu@lists.linux-foundation.org>; Fri, 18 Feb 2022 08:41:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=collabora.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id siuwDvHnjZWe for <iommu@lists.linux-foundation.org>;
 Fri, 18 Feb 2022 08:41:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7C73D40147
 for <iommu@lists.linux-foundation.org>; Fri, 18 Feb 2022 08:41:44 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: kholk11) with ESMTPSA id 3F9AD1F4417B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1645173701;
 bh=y1MQQgamboxKWXR250aZ3v7J3tHKl044R2X9kxvJNdI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=hryznIMs6S1YAgP5BqLwjtosco6cTHMhj8+u3FKZgapd5mLfncU7NthBVXO5JlV/K
 uV3Y2xOjmgTMbN71Usw1XA6qLIlGbCLHg7Fb/4CxzQPdFGiVwcPLyhRRsp6xas6EoI
 rt0DZ24LBHflRQEkcdLvCH4JYZwN/yFYchX0c96GaOHzYoroYIwuzhc7JrEXdNR4xQ
 mqCZ1Ld8DDobZ6EniAvDXDGa6GjGor8eXqWhKJpOJi37BCg2wFuhw1lgfVW8BxIdr2
 ZBCDZUBjSN/xOmGmP9h8SO3jzWdulFseuCCj71qC4MnDJ8jv40LOK/caehosqx4iKM
 ZoQfCXpD9PUbQ==
Message-ID: <a4e66e61-35c4-adb5-fb65-e1f076bbe6ba@collabora.com>
Date: Fri, 18 Feb 2022 09:41:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH 2/2] iommu/mediatek: Add mt8186 iommu support
Content-Language: en-US
To: Yong Wu <yong.wu@mediatek.com>
References: <20220125093244.18230-1-yong.wu@mediatek.com>
 <20220125093244.18230-3-yong.wu@mediatek.com>
 <b52a1df8-58f4-baa2-cfb6-9c56244caa0f@collabora.com>
 <01cc69cdf7773962140c01fe37b12ab2c9491c25.camel@mediatek.com>
 <0e430d1e-ee25-1b3d-4a2c-8641db255adb@collabora.com>
 <8b63983222a4a304586a7b880379fcf4a7036c4a.camel@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <8b63983222a4a304586a7b880379fcf4a7036c4a.camel@mediatek.com>
Cc: yf.wang@mediatek.com, yen-chang.chen@mediatek.com,
 Will Deacon <will@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
 xueqi.zhang@mediatek.com, mingyuan.ma@mediatek.com, devicetree@vger.kernel.org,
 chengci.xu@mediatek.com, libo.kang@mediatek.com,
 Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org,
 Hsin-Yi Wang <hsinyi@chromium.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 linux-arm-kernel@lists.infradead.org, anan.sun@mediatek.com,
 srv_heupstream@mediatek.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>
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

Il 18/02/22 04:32, Yong Wu ha scritto:
> On Mon, 2022-01-31 at 10:25 +0100, AngeloGioacchino Del Regno wrote:
>> Il 28/01/22 10:39, Yong Wu ha scritto:
>>> On Thu, 2022-01-27 at 12:28 +0100, AngeloGioacchino Del Regno
>>> wrote:
>>>> Il 25/01/22 10:32, Yong Wu ha scritto:
>>>>> Add mt8186 iommu supports.
>>>>>
>>>>> Signed-off-by: Anan Sun <anan.sun@mediatek.com>
>>>>> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
>>>>> ---
>>>>>     drivers/iommu/mtk_iommu.c | 17 +++++++++++++++++
>>>>>     1 file changed, 17 insertions(+)
>>>
>>> [snip]
>>>
>>>>>     static const struct mtk_iommu_plat_data mt8192_data = {
>>>>>     	.m4u_plat       = M4U_MT8192,
>>>>>     	.flags          = HAS_BCLK | HAS_SUB_COMM_2BITS |
>>>>> OUT_ORDER_WR_EN |
>>>>> @@ -1470,6 +1486,7 @@ static const struct of_device_id
>>>>> mtk_iommu_of_ids[] = {
>>>>>     	{ .compatible = "mediatek,mt8167-m4u", .data =
>>>>> &mt8167_data},
>>>>>     	{ .compatible = "mediatek,mt8173-m4u", .data =
>>>>> &mt8173_data},
>>>>>     	{ .compatible = "mediatek,mt8183-m4u", .data =
>>>>> &mt8183_data},
>>>>> +	{ .compatible = "mediatek,mt8186-iommu-mm", .data =
>>>>> &mt8186_data_mm},
>>>>
>>>> Hello!
>>>>
>>>> Is there any particular reason why this compatible is not
>>>> "mediatek,mt8186-m4u"?
>>>
>>> There is no special reason. In the previous SoC, We only support MM
>>> IOMMU, it was called by "m4u". In the lastest SoC, We have the
>>> other
>>> types IOMMU, like for INFRA masters and APU, thus they are called
>>> "mm
>>> iommu", "infra iommu" and "apu iommu". Of course, "m4u" means "mm
>>> iommu".
>>>
>>
>> I suggest, at this point, to change it to "mediatek,mt8186-m4u" for
>> naming
>> consistency with the other bindings and to avoid any kind of
>> confusion.
> 
> Understand. But we don't call it "m4u" anymore. I'd not like to use a
> outdated name. For readable, I could add a comment like this:
> 
> { .compatible = "mediatek,mt8186-iommu-mm", xx}, /* iommu-mm: m4u */
> 
> Is this ok for you?
> Thanks.
> 

Ok, go on with that.

Cheers,
Angelo

>> Thank you!
>>
>>>>
>>>> Thanks,
>>>> Angelo
>>>>
>>>>>     	{ .compatible = "mediatek,mt8192-m4u", .data =
>>>>> &mt8192_data},
>>>>>     	{ .compatible = "mediatek,mt8195-iommu-infra", .data =
>>>>> &mt8195_data_infra},
>>>>>     	{ .compatible = "mediatek,mt8195-iommu-vdo",   .data =
>>>>> &mt8195_data_vdo},
>>>>
>>>> _______________________________________________
>>>> Linux-mediatek mailing list
>>>> Linux-mediatek@lists.infradead.org
>>>> http://lists.infradead.org/mailman/listinfo/linux-mediatek
>>
>>
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
