Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DACB5C433F5
	for <iommu@archiver.kernel.org>; Fri, 21 Jan 2022 11:56:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 654004163C;
	Fri, 21 Jan 2022 11:56:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UJIfwptm05qJ; Fri, 21 Jan 2022 11:56:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2BB9E415B6;
	Fri, 21 Jan 2022 11:56:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EB40EC0039;
	Fri, 21 Jan 2022 11:56:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E9097C002F
 for <iommu@lists.linux-foundation.org>; Fri, 21 Jan 2022 11:56:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DE55483E45
 for <iommu@lists.linux-foundation.org>; Fri, 21 Jan 2022 11:56:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wdStZtaU_ddo for <iommu@lists.linux-foundation.org>;
 Fri, 21 Jan 2022 11:56:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A540483E44
 for <iommu@lists.linux-foundation.org>; Fri, 21 Jan 2022 11:56:15 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 6792F61A88;
 Fri, 21 Jan 2022 11:56:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A35AC340E1;
 Fri, 21 Jan 2022 11:56:07 +0000 (UTC)
Message-ID: <8ae4a49a-4abf-be55-f6c8-9fc4ffd02fc8@xs4all.nl>
Date: Fri, 21 Jan 2022 12:56:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v9 12/15] media: mtk-vcodec: enc: Remove
 mtk_vcodec_release_enc_pm
Content-Language: en-US
To: Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
 David Airlie <airlied@linux.ie>, Mauro Carvalho Chehab <mchehab@kernel.org>
References: <20211112105509.12010-1-yong.wu@mediatek.com>
 <20211112105509.12010-13-yong.wu@mediatek.com>
 <68c3a573-8453-38e9-93b2-2067bedcd06f@collabora.com>
 <4bd9e849-96dd-6f1c-2841-979459366ee5@collabora.com>
 <fa9b2b73-c6bb-5737-93ac-ba2ab6b3b771@xs4all.nl>
 <e940d705-2057-4d5e-0a21-8464ca04caaf@gmail.com>
From: Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <e940d705-2057-4d5e-0a21-8464ca04caaf@gmail.com>
Cc: devicetree@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 anthony.huang@mediatek.com, youlin.pei@mediatek.com,
 Irui Wang <irui.wang@mediatek.com>, Evan Green <evgreen@chromium.org>,
 Eizan Miyamoto <eizan@chromium.org>, Matthias Kaehlcke <mka@chromium.org>,
 mingyuan.ma@mediatek.com, linux-media@vger.kernel.org,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
 libo.kang@mediatek.com, yi.kuo@mediatek.com,
 linux-mediatek@lists.infradead.org, Hsin-Yi Wang <hsinyi@chromium.org>,
 Tiffany Lin <tiffany.lin@mediatek.com>, linux-arm-kernel@lists.infradead.org,
 anan.sun@mediatek.com, acourbot@chromium.org, srv_heupstream@mediatek.com,
 yf.wang@mediatek.com, iommu@lists.linux-foundation.org,
 Philipp Zabel <p.zabel@pengutronix.de>, Robin Murphy <robin.murphy@arm.com>
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

Hi Matthias,

On 1/13/22 17:10, Matthias Brugger wrote:
> Hi Hans,
> 
> On 13/01/2022 11:15, Hans Verkuil wrote:
>> On 13/01/2022 11:11, AngeloGioacchino Del Regno wrote:
>>> Il 11/01/22 11:57, AngeloGioacchino Del Regno ha scritto:
>>>> Il 12/11/21 11:55, Yong Wu ha scritto:
>>>>> After this patchset, mtk_vcodec_release_enc_pm has only one line.
>>>>> then remove that function, use pm_runtime_disable instead.
>>>>>
>>>>> meanwhile, mtk_vcodec_init_enc_pm only operate for the clocks,
>>>>> rename it from the _pm to _clk.
>>>>>
>>>>> No functional change.
>>>>>
>>>>> CC: Tiffany Lin <tiffany.lin@mediatek.com>
>>>>> CC: Irui Wang <irui.wang@mediatek.com>
>>>>> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
>>>>
>>>> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>>>>
>>>
>>> Hello Yong,
>>> the mtk-vcodec patches were merged in Yunfei's vcodec patch series and Hans has
>>> scheduled that for v5.18.
>>>
>>> Can you please send a v10 and drop patches 10/15, 11/15, 12/15 (all of the
>>> media: mtk-vcodec: *) from this series?
>>>
>>> For the records, I think that after sending v10 this series is ready to be merged,
>>> as it was well reviewed and also tested on many MTK platforms.
>>
>> Good to know. When I have the v10 I'll try to prioritize reviewing it and running
>> my usual tests.
>>
>> Yong, please make sure you run 'checkpatch.pl --strict' over the v10 patches and fix
>> any issues (using common sense).
>>
> 
> Can you please take me in the look when you take the patches. I'll take the DTS related as soon as you queue up the others.

This just got merged into our tree.

Regards,

	Hans
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
