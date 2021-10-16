Return-Path: <SRS0=DCF7=PE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D8BDC433F5
	for <iommu@archiver.kernel.org>; Sat, 16 Oct 2021 02:23:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DF0460F46
	for <iommu@archiver.kernel.org>; Sat, 16 Oct 2021 02:23:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2DF0460F46
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id DFC08401C8;
	Sat, 16 Oct 2021 02:23:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RDL1tG1u5V-Y; Sat, 16 Oct 2021 02:23:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 55AD2400C6;
	Sat, 16 Oct 2021 02:23:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 25107C000F;
	Sat, 16 Oct 2021 02:23:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 47AE3C000D
 for <iommu@lists.linux-foundation.org>; Sat, 16 Oct 2021 02:23:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3DEDA83BE4
 for <iommu@lists.linux-foundation.org>; Sat, 16 Oct 2021 02:23:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=mediatek.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kWjS9G61_bpY for <iommu@lists.linux-foundation.org>;
 Sat, 16 Oct 2021 02:23:38 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 573A783BE2
 for <iommu@lists.linux-foundation.org>; Sat, 16 Oct 2021 02:23:38 +0000 (UTC)
X-UUID: 7a68abb896e64edbbeb56cd2c621ec1d-20211016
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=gpCAjs3PTP2pnFObJBoM1HpsrUqmuM8h33+4tQMr9Fg=; 
 b=f37Cri4kRTZnAg8vcCnQg3UJTmJ+wXWad9EI/peDZuGOd14fWPr96VujvlDDfYrxfTimhpVivvoVgZGg2Hm1ayFXlM14XZxF60gMtJ9zjcUJyv65OJSoGlgQfjzWuj6YrXmn7mM4vWYaXllHZNMnTYzutgaOOAtBG6Ttorzxbsw=;
X-UUID: 7a68abb896e64edbbeb56cd2c621ec1d-20211016
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 1174071897; Sat, 16 Oct 2021 10:23:30 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Sat, 16 Oct 2021 10:23:29 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 16 Oct 2021 10:23:27 +0800
Message-ID: <e4c98036dd73b91b8352a162f80240171e2b3f0f.camel@mediatek.com>
Subject: Re: [PATCH v8 04/12] iommu/mediatek: Add device_link between the
 consumer and the larb devices
From: Yong Wu <yong.wu@mediatek.com>
To: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>, Matthias Brugger
 <matthias.bgg@gmail.com>, Joerg Roedel <joro@8bytes.org>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski@canonical.com>, David Airlie <airlied@linux.ie>, "Mauro
 Carvalho Chehab" <mchehab@kernel.org>
Date: Sat, 16 Oct 2021 10:23:27 +0800
In-Reply-To: <e00b92db-0562-27ca-2f96-1f03ff824988@collabora.com>
References: <20210929013719.25120-1-yong.wu@mediatek.com>
 <20210929013719.25120-5-yong.wu@mediatek.com>
 <e00b92db-0562-27ca-2f96-1f03ff824988@collabora.com>
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-MTK: N
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>, Will Deacon <will.deacon@arm.com>,
 dri-devel@lists.freedesktop.org, anthony.huang@mediatek.com,
 youlin.pei@mediatek.com, Evan Green <evgreen@chromium.org>,
 Eizan Miyamoto <eizan@chromium.org>, Matthias Kaehlcke <mka@chromium.org>,
 linux-media@vger.kernel.org, devicetree@vger.kernel.org, Philipp
 Zabel <p.zabel@pengutronix.de>, Frank Wunderlich <frank-w@public-files.de>,
 yi.kuo@mediatek.com, linux-mediatek@lists.infradead.org,
 Hsin-Yi Wang <hsinyi@chromium.org>, Tiffany Lin <tiffany.lin@mediatek.com>,
 linux-arm-kernel@lists.infradead.org, anan.sun@mediatek.com,
 srv_heupstream@mediatek.com, acourbot@chromium.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, Daniel
 Vetter <daniel@ffwll.ch>, Robin Murphy <robin.murphy@arm.com>
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

On Mon, 2021-10-11 at 14:36 +0200, Dafna Hirschfeld wrote:
> 
> On 29.09.21 03:37, Yong Wu wrote:
> > MediaTek IOMMU-SMI diagram is like below. all the consumer connect
> > with
> > smi-larb, then connect with smi-common.
> > 
> >          M4U
> >           |
> >      smi-common
> >           |
> >    -------------
> >    |         |    ...
> >    |         |
> > larb1     larb2
> >    |         |
> > vdec       venc
> > 
> > When the consumer works, it should enable the smi-larb's power
> > which
> > also need enable the smi-common's power firstly.
> > 
> > Thus, First of all, use the device link connect the consumer and
> > the
> > smi-larbs. then add device link between the smi-larb and smi-
> > common.
> > 
> > This patch adds device_link between the consumer and the larbs.
> > 
> > When device_link_add, I add the flag DL_FLAG_STATELESS to avoid
> > calling
> > pm_runtime_xx to keep the original status of clocks. It can avoid
> > two
> > issues:
> > 1) Display HW show fastlogo abnormally reported in [1]. At the
> > beggining,
> > all the clocks are enabled before entering kernel, but the clocks
> > for
> > display HW(always in larb0) will be gated after clk_enable and
> > clk_disable
> > called from device_link_add(->pm_runtime_resume) and rpm_idle. The
> > clock
> > operation happened before display driver probe. At that time, the
> > display
> > HW will be abnormal.
> > 
> > 2) A deadlock issue reported in [2]. Use DL_FLAG_STATELESS to skip
> > pm_runtime_xx to avoid the deadlock.
> > 
> > Corresponding, DL_FLAG_AUTOREMOVE_CONSUMER can't be added, then
> > device_link_removed should be added explicitly.
> > 
> > [1] 
> > https://lore.kernel.org/linux-mediatek/1564213888.22908.4.camel@mhfsdcap03/
> > [2] https://lore.kernel.org/patchwork/patch/1086569/
> > 
> > Suggested-by: Tomasz Figa <tfiga@chromium.org>
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > Tested-by: Frank Wunderlich <frank-w@public-files.de> # BPI-
> > R2/MT7623
> > ---
> >   drivers/iommu/mtk_iommu.c    | 22 ++++++++++++++++++++++
> >   drivers/iommu/mtk_iommu_v1.c | 20 +++++++++++++++++++-
> >   2 files changed, 41 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> > index d5848f78a677..a2fa55899434 100644
> > --- a/drivers/iommu/mtk_iommu.c
> > +++ b/drivers/iommu/mtk_iommu.c
> > @@ -560,22 +560,44 @@ static struct iommu_device
> > *mtk_iommu_probe_device(struct device *dev)
> >   {
> >   	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
> >   	struct mtk_iommu_data *data;
> > +	struct device_link *link;
> > +	struct device *larbdev;
> > +	unsigned int larbid;
> >   
> >   	if (!fwspec || fwspec->ops != &mtk_iommu_ops)
> >   		return ERR_PTR(-ENODEV); /* Not a iommu client device
> > */
> >   
> >   	data = dev_iommu_priv_get(dev);
> >   
> > +	/*
> > +	 * Link the consumer device with the smi-larb device(supplier)
> > +	 * The device in each a larb is a independent HW. thus only
> > link
> > +	 * one larb here.
> > +	 */
> > +	larbid = MTK_M4U_TO_LARB(fwspec->ids[0]);
> 
> so larbid is always the same for all the ids of a device? 

Yes. For me, each a dtsi node should represent a HW unit which can only
connect one larb.

> If so maybe it worth testing it and return error if this is not the
> case.

Thanks for the suggestion. This is very helpful. I did see someone put
the different larbs in one node. I will check this, and add return
EINVAL for this case.

> 
> Thanks,
> Dafna
 
> > 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
