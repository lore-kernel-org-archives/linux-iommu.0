Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67F2DC433EF
	for <iommu@archiver.kernel.org>; Mon, 31 Jan 2022 09:25:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E483082656;
	Mon, 31 Jan 2022 09:25:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5BCvxK8J_KFw; Mon, 31 Jan 2022 09:25:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id BC5D481CA0;
	Mon, 31 Jan 2022 09:25:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 823D6C001A;
	Mon, 31 Jan 2022 09:25:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4FEEAC000B
 for <iommu@lists.linux-foundation.org>; Mon, 31 Jan 2022 09:25:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3841B4092F
 for <iommu@lists.linux-foundation.org>; Mon, 31 Jan 2022 09:25:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=collabora.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qghkmWuHfj5q for <iommu@lists.linux-foundation.org>;
 Mon, 31 Jan 2022 09:25:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3D1764092E
 for <iommu@lists.linux-foundation.org>; Mon, 31 Jan 2022 09:25:19 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: kholk11) with ESMTPSA id 9E96B1F42DBC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1643621116;
 bh=fbIVeyjQyhAhoLY74piWBq3+1URHLKGzFfERXylZibQ=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=G+n3SkiadJcTl8Uqq2gHU6UPyYTCJCZe7c+k6nTg+Y+oZCIgkdqmSAHWpY8W0EiF6
 pwJ3msh30uXexOLmgW47/hr852Sm3Vw4+/yofQhItYYCZrnECur6u/fmN6PaGZwCHQ
 8eEauqSR4Pnd4VMg1PS3+j86GNhxWxjb9HSawRcZGw+YjGmMEEOO8Fkt9nORMLDVK6
 46CeNecPN4m3tA8FfYAuf0mf70jC0f4ouz92sU4Tgp4Da4UAPXpbijXvjDyq2ju9Q5
 mzWXxm5QVDoAioUeUE/hA3KfUBIQxowARZVsfux8Yqbz7P6kpN7cvAgYFEQF713KJ3
 e9qABAggpKHAQ==
Message-ID: <0e430d1e-ee25-1b3d-4a2c-8641db255adb@collabora.com>
Date: Mon, 31 Jan 2022 10:25:13 +0100
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
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <01cc69cdf7773962140c01fe37b12ab2c9491c25.camel@mediatek.com>
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

Il 28/01/22 10:39, Yong Wu ha scritto:
> On Thu, 2022-01-27 at 12:28 +0100, AngeloGioacchino Del Regno wrote:
>> Il 25/01/22 10:32, Yong Wu ha scritto:
>>> Add mt8186 iommu supports.
>>>
>>> Signed-off-by: Anan Sun <anan.sun@mediatek.com>
>>> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
>>> ---
>>>    drivers/iommu/mtk_iommu.c | 17 +++++++++++++++++
>>>    1 file changed, 17 insertions(+)
> 
> [snip]
> 
>>>    static const struct mtk_iommu_plat_data mt8192_data = {
>>>    	.m4u_plat       = M4U_MT8192,
>>>    	.flags          = HAS_BCLK | HAS_SUB_COMM_2BITS |
>>> OUT_ORDER_WR_EN |
>>> @@ -1470,6 +1486,7 @@ static const struct of_device_id
>>> mtk_iommu_of_ids[] = {
>>>    	{ .compatible = "mediatek,mt8167-m4u", .data = &mt8167_data},
>>>    	{ .compatible = "mediatek,mt8173-m4u", .data = &mt8173_data},
>>>    	{ .compatible = "mediatek,mt8183-m4u", .data = &mt8183_data},
>>> +	{ .compatible = "mediatek,mt8186-iommu-mm", .data =
>>> &mt8186_data_mm},
>>
>> Hello!
>>
>> Is there any particular reason why this compatible is not
>> "mediatek,mt8186-m4u"?
> 
> There is no special reason. In the previous SoC, We only support MM
> IOMMU, it was called by "m4u". In the lastest SoC, We have the other
> types IOMMU, like for INFRA masters and APU, thus they are called "mm
> iommu", "infra iommu" and "apu iommu". Of course, "m4u" means "mm
> iommu".
> 

I suggest, at this point, to change it to "mediatek,mt8186-m4u" for naming
consistency with the other bindings and to avoid any kind of confusion.

Thank you!

>>
>> Thanks,
>> Angelo
>>
>>>    	{ .compatible = "mediatek,mt8192-m4u", .data = &mt8192_data},
>>>    	{ .compatible = "mediatek,mt8195-iommu-infra", .data =
>>> &mt8195_data_infra},
>>>    	{ .compatible = "mediatek,mt8195-iommu-vdo",   .data =
>>> &mt8195_data_vdo},
>>
>> _______________________________________________
>> Linux-mediatek mailing list
>> Linux-mediatek@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-mediatek
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
