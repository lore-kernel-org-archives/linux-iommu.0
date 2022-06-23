Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AE5AC433EF
	for <iommu@archiver.kernel.org>; Thu, 23 Jun 2022 02:12:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CB97360E49;
	Thu, 23 Jun 2022 02:12:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CB97360E49
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XtnObKYHcsmu; Thu, 23 Jun 2022 02:12:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9D2C760B62;
	Thu, 23 Jun 2022 02:12:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9D2C760B62
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6DF02C0039;
	Thu, 23 Jun 2022 02:12:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3197DC002D
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 02:12:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 04C0D84523
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 02:12:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 04C0D84523
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id C9o3fw1FLIej for <iommu@lists.linux-foundation.org>;
 Thu, 23 Jun 2022 02:12:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 78BD98451E
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 78BD98451E
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 02:12:41 +0000 (UTC)
X-UUID: 5c88b84ab1e44ff8a0e15fee5939852a-20220623
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.6, REQID:5eb5f367-5a71-4b8e-8560-c83c262d8b7c, OB:0,
 LO
 B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
 ON:release,TS:0
X-CID-META: VersionHash:b14ad71, CLOUDID:0e6c3938-5e4b-44d7-80b2-bb618cb09d29,
 C
 OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
 ,QS:nil,BEC:nil,COL:0
X-UUID: 5c88b84ab1e44ff8a0e15fee5939852a-20220623
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by
 mailgw01.mediatek.com (envelope-from <yong.wu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1641060623; Thu, 23 Jun 2022 10:12:33 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Thu, 23 Jun 2022 10:12:32 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 23 Jun 2022 10:12:31 +0800
Message-ID: <561adc680c9af8e8813baf698f2f6ba67ce046e9.camel@mediatek.com>
Subject: Re: [PATCH v2 2/5] iommu/mediatek: Add error path for loop of
 mm_dts_parse
To: Matthias Brugger <matthias.bgg@gmail.com>
Date: Thu, 23 Jun 2022 10:12:31 +0800
In-Reply-To: <22c40a7f-d759-5b4a-f554-cf679102d91f@gmail.com>
References: <20220616054203.11365-1-yong.wu@mediatek.com>
 <20220616054203.11365-3-yong.wu@mediatek.com>
 <22c40a7f-d759-5b4a-f554-cf679102d91f@gmail.com>
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-MTK: N
Cc: anan.sun@mediatek.com, chengci.xu@mediatek.com, xueqi.zhang@mediatek.com,
 linux-kernel@vger.kernel.org, libo.kang@mediatek.com, yf.wang@mediatek.com,
 iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
 Dan Carpenter <dan.carpenter@oracle.com>, Guenter Roeck <groeck@chromium.org>,
 Will Deacon <will@kernel.org>, mingyuan.ma@mediatek.com,
 linux-arm-kernel@lists.infradead.org,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
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
From: Yong Wu via iommu <iommu@lists.linux-foundation.org>
Reply-To: Yong Wu <yong.wu@mediatek.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Thu, 2022-06-16 at 15:49 +0200, Matthias Brugger wrote:
> 
> On 16/06/2022 07:42, Yong Wu wrote:
> > The mtk_iommu_mm_dts_parse will parse the smi larbs nodes. if the
> > i+1
> > larb is parsed fail(return -EINVAL), we should of_node_put for the
> > 0..i
> > larbs. In the fail path, one of_node_put matches with
> > of_parse_phandle in
> > it.
> > 
> > Fixes: d2e9a1102cfc ("iommu/mediatek: Contain MM IOMMU flow with
> > the MM TYPE")
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > ---
> >   drivers/iommu/mtk_iommu.c | 21 ++++++++++++++++-----
> >   1 file changed, 16 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> > index 3b2489e8a6dd..ab24078938bf 100644
> > --- a/drivers/iommu/mtk_iommu.c
> > +++ b/drivers/iommu/mtk_iommu.c
> > @@ -1071,12 +1071,12 @@ static int mtk_iommu_mm_dts_parse(struct
> > device *dev, struct component_match **m
> >   
> 
> Don't we need to call the goto also on error case of:
> 
> larbnode = of_parse_phandle(dev->of_node, "mediatek,larbs", i);

Thanks very much.

exactly right. I will add in next version.

> Regards,
> Matthias

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
