Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 341CCC433EF
	for <iommu@archiver.kernel.org>; Mon, 17 Jan 2022 09:41:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BDCDA80B50;
	Mon, 17 Jan 2022 09:41:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DNBASA7Bh3Xp; Mon, 17 Jan 2022 09:41:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 7E14A80B60;
	Mon, 17 Jan 2022 09:41:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 51AA7C0039;
	Mon, 17 Jan 2022 09:41:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BED6CC002F
 for <iommu@lists.linux-foundation.org>; Mon, 17 Jan 2022 09:41:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 98B3E402C9
 for <iommu@lists.linux-foundation.org>; Mon, 17 Jan 2022 09:41:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nj4xaT4f7071 for <iommu@lists.linux-foundation.org>;
 Mon, 17 Jan 2022 09:41:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5DDEC402C3
 for <iommu@lists.linux-foundation.org>; Mon, 17 Jan 2022 09:41:26 +0000 (UTC)
X-UUID: dd2a1725b31d4dfe9851067031719254-20220117
X-UUID: dd2a1725b31d4dfe9851067031719254-20220117
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by
 mailgw02.mediatek.com (envelope-from <yong.wu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 476358148; Mon, 17 Jan 2022 17:41:22 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3; 
 Mon, 17 Jan 2022 17:41:20 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 17 Jan 2022 17:41:19 +0800
Message-ID: <ebbe29162688b230aec208a45762f795c850e396.camel@mediatek.com>
Subject: Re: [PATCH v9 12/15] media: mtk-vcodec: enc: Remove
 mtk_vcodec_release_enc_pm
From: Yong Wu <yong.wu@mediatek.com>
To: Matthias Brugger <matthias.bgg@gmail.com>, Hans Verkuil
 <hverkuil@xs4all.nl>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>
Date: Mon, 17 Jan 2022 17:41:18 +0800
In-Reply-To: <e940d705-2057-4d5e-0a21-8464ca04caaf@gmail.com>
References: <20211112105509.12010-1-yong.wu@mediatek.com>
 <20211112105509.12010-13-yong.wu@mediatek.com>
 <68c3a573-8453-38e9-93b2-2067bedcd06f@collabora.com>
 <4bd9e849-96dd-6f1c-2841-979459366ee5@collabora.com>
 <fa9b2b73-c6bb-5737-93ac-ba2ab6b3b771@xs4all.nl>
 <e940d705-2057-4d5e-0a21-8464ca04caaf@gmail.com>
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-MTK: N
Cc: devicetree@vger.kernel.org, David Airlie <airlied@linux.ie>,
 Will Deacon <will.deacon@arm.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, anthony.huang@mediatek.com,
 youlin.pei@mediatek.com, Irui Wang <irui.wang@mediatek.com>,
 Tiffany Lin <tiffany.lin@mediatek.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
 Evan Green <evgreen@chromium.org>, Eizan Miyamoto <eizan@chromium.org>,
 Matthias Kaehlcke <mka@chromium.org>, mingyuan.ma@mediatek.com,
 linux-media@vger.kernel.org, Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Daniel Vetter <daniel@ffwll.ch>, libo.kang@mediatek.com, yi.kuo@mediatek.com,
 Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org,
 Hsin-Yi Wang <hsinyi@chromium.org>, Mauro Carvalho Chehab <mchehab@kernel.org>,
 linux-arm-kernel@lists.infradead.org, anan.sun@mediatek.com,
 acourbot@chromium.org, srv_heupstream@mediatek.com, yf.wang@mediatek.com,
 iommu@lists.linux-foundation.org, Philipp Zabel <p.zabel@pengutronix.de>,
 Robin Murphy <robin.murphy@arm.com>
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

On Thu, 2022-01-13 at 17:10 +0100, Matthias Brugger wrote:
> Hi Hans,
> 
> On 13/01/2022 11:15, Hans Verkuil wrote:
> > On 13/01/2022 11:11, AngeloGioacchino Del Regno wrote:
> > > Il 11/01/22 11:57, AngeloGioacchino Del Regno ha scritto:
> > > > Il 12/11/21 11:55, Yong Wu ha scritto:
> > > > > After this patchset, mtk_vcodec_release_enc_pm has only one
> > > > > line.
> > > > > then remove that function, use pm_runtime_disable instead.
> > > > > 
> > > > > meanwhile, mtk_vcodec_init_enc_pm only operate for the
> > > > > clocks,
> > > > > rename it from the _pm to _clk.
> > > > > 
> > > > > No functional change.
> > > > > 
> > > > > CC: Tiffany Lin <tiffany.lin@mediatek.com>
> > > > > CC: Irui Wang <irui.wang@mediatek.com>
> > > > > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > > > 
> > > > Reviewed-by: AngeloGioacchino Del Regno <
> > > > angelogioacchino.delregno@collabora.com>
> > > > 
> > > 
> > > Hello Yong,
> > > the mtk-vcodec patches were merged in Yunfei's vcodec patch
> > > series and Hans has
> > > scheduled that for v5.18.
> > > 
> > > Can you please send a v10 and drop patches 10/15, 11/15, 12/15
> > > (all of the
> > > media: mtk-vcodec: *) from this series?

Hi Angelo,

   I have dropped 11/15 and 12/15 in v10 and rebase 10/15 on media tree
manually, thus I didn't keep your A-y for that one.

   Please take a look at that one.
 
   Thanks.

> > > 
> > > For the records, I think that after sending v10 this series is
> > > ready to be merged,
> > > as it was well reviewed and also tested on many MTK platforms.
> > 
> > Good to know. When I have the v10 I'll try to prioritize reviewing
> > it and running
> > my usual tests.

Hi Hans/Matthias,

v10: 
https://patchwork.linuxtv.org/project/linux-media/list/?series=7130

Please help take a look that one.

> > 
> > Yong, please make sure you run 'checkpatch.pl --strict' over the
> > v10 patches and fix
> > any issues (using common sense).

   Have run this on v10.

Thanks.
> > 
> 
> Can you please take me in the look when you take the patches. I'll
> take the DTS 
> related as soon as you queue up the others.
> 
> Thanks!
> Matthias
> 
> > Regards,
> > 
> > 	Hans
> > 
> > > 
> > > Thank you,
> > > - Angelo

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
