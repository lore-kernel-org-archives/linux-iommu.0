Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AD48C433F5
	for <iommu@archiver.kernel.org>; Sun,  1 May 2022 02:33:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EC34840866;
	Sun,  1 May 2022 02:33:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id T4Ua06tGwYoU; Sun,  1 May 2022 02:33:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 607684056A;
	Sun,  1 May 2022 02:33:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 06353C0032;
	Sun,  1 May 2022 02:33:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4598AC002D
 for <iommu@lists.linux-foundation.org>; Sun,  1 May 2022 02:33:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 38ECC827C5
 for <iommu@lists.linux-foundation.org>; Sun,  1 May 2022 02:33:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id znb0WgVug3Gu for <iommu@lists.linux-foundation.org>;
 Sun,  1 May 2022 02:33:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 202EE827BB
 for <iommu@lists.linux-foundation.org>; Sun,  1 May 2022 02:33:39 +0000 (UTC)
X-UUID: 2e9c20c5999a4152b8eeaa71899e396d-20220501
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4, REQID:050d0d68-fa53-43fd-864b-3c9a7c6b227d, OB:0,
 LO
 B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:51,FILE:0,RULE:Release_Ham,ACT
 ION:release,TS:51
X-CID-INFO: VERSION:1.1.4, REQID:050d0d68-fa53-43fd-864b-3c9a7c6b227d, OB:0,
 LOB:
 0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:51,FILE:0,RULE:Release_Ham,ACTIO
 N:release,TS:51
X-CID-META: VersionHash:faefae9, CLOUDID:01dc4c2f-6199-437e-8ab4-9920b4bc5b76,
 C
 OID:a2a59d27761f,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,File:nil
 ,QS:0,BEC:nil
X-UUID: 2e9c20c5999a4152b8eeaa71899e396d-20220501
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by
 mailgw01.mediatek.com (envelope-from <yong.wu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 369075166; Sun, 01 May 2022 10:33:32 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3; 
 Sun, 1 May 2022 10:33:31 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 1 May 2022 10:33:30 +0800
Message-ID: <7a1dd83d191a843b0e4276bcf1790b697d2deebd.camel@mediatek.com>
Subject: Re: [PATCH v6 31/34] iommu/mediatek: Get the proper bankid for
 multi banks
To: Matthias Brugger <matthias.bgg@gmail.com>, Joerg Roedel <joro@8bytes.org>, 
 Rob Herring <robh+dt@kernel.org>, Will Deacon <will@kernel.org>
Date: Sun, 1 May 2022 10:33:30 +0800
In-Reply-To: <cc7cc7a8-c7a2-56a1-47bf-6c553c200b33@gmail.com>
References: <20220407075726.17771-1-yong.wu@mediatek.com>
 <20220407075726.17771-32-yong.wu@mediatek.com>
 <cc7cc7a8-c7a2-56a1-47bf-6c553c200b33@gmail.com>
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-MTK: N
Cc: devicetree@vger.kernel.org, srv_heupstream@mediatek.com,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
 chengci.xu@mediatek.com, xueqi.zhang@mediatek.com,
 linux-kernel@vger.kernel.org, libo.kang@mediatek.com,
 yen-chang.chen@mediatek.com, iommu@lists.linux-foundation.org,
 yf.wang@mediatek.com, linux-mediatek@lists.infradead.org,
 Hsin-Yi Wang <hsinyi@chromium.org>, anan.sun@mediatek.com,
 Robin Murphy <robin.murphy@arm.com>, mingyuan.ma@mediatek.com,
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

Hi Matthias,

Thanks very much for reviewing.

On Thu, 2022-04-28 at 16:14 +0200, Matthias Brugger wrote:
> 
> On 07/04/2022 09:57, Yong Wu wrote:
> > We preassign some ports in a special bank via the new defined
> > banks_portmsk. Put it in the plat_data means it is not expected to
> > be
> > adjusted dynamically.
> > 
> > If the iommu id in the iommu consumer's dtsi node is inside this
> > banks_portmsk, then we switch it to this special iommu bank, and
> > initialise the IOMMU bank HW.
> > 
> > Each a bank has the independent pgtable(4GB iova range). Each a
> > bank
> > is a independent iommu domain/group. Currently we don't separate
> > different
> > iova ranges inside a bank.
> > 
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > Reviewed-by: AngeloGioacchino Del Regno <
> > angelogioacchino.delregno@collabora.com>
> > ---
> >   drivers/iommu/mtk_iommu.c | 39
> > ++++++++++++++++++++++++++++++++++++---
> >   1 file changed, 36 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> > index 0828cff97625..d42b3d35a36e 100644
> > --- a/drivers/iommu/mtk_iommu.c
> > +++ b/drivers/iommu/mtk_iommu.c

[snip]

> > @@ -802,6 +828,7 @@ static struct iommu_group
> > *mtk_iommu_device_group(struct device *dev)
> >   	struct mtk_iommu_data *c_data = dev_iommu_priv_get(dev), *data;
> >   	struct list_head *hw_list = c_data->hw_list;
> >   	struct iommu_group *group;
> > +	unsigned int bankid, groupid;
> >   	int regionid;
> >   
> >   	data = mtk_iommu_get_frst_data(hw_list);
> > @@ -812,12 +839,18 @@ static struct iommu_group
> > *mtk_iommu_device_group(struct device *dev)
> >   	if (regionid < 0)
> >   		return ERR_PTR(regionid);
> >   
> > +	bankid = mtk_iommu_get_bank_id(dev, data->plat_data);
> 
> I think code readability would be improved if we add a new function
> like 
> mtk_iommu_get_id which call mtk_iommu_get_bankid and if necessary 
> mtk_iommu_get_regionid.

OK, I will define a new function, like mtk_iommu_get_group_id for the
readability.

> 
> >   	mutex_lock(&data->mutex);
> > -	group = data->m4u_group[regionid];
> > +	/*
> > +	 * If the bank function is enabled, each a bank is a iommu
> > group/domain.
> > +	 * otherwise, each a iova region is a iommu group/domain.
> 
> While at it:
> "If the bank function is enabled, each bank is a iommu group/domain.
> Otherwise, 
> each iova region is a iommu group/domain."

And move this comment into the new funtion.

Also of course, I will fix the other two comments and send v7.

Thanks.

> 
> Regards,
> Matthias
> 
> > +	 */
> > +	groupid = bankid ? bankid : regionid;
> > +	group = data->m4u_group[groupid];
> >   	if (!group) {
> >   		group = iommu_group_alloc();
> >   		if (!IS_ERR(group))
> > -			data->m4u_group[regionid] = group;
> > +			data->m4u_group[groupid] = group;
> >   	} else {
> >   		iommu_group_ref_get(group);
> >   	}

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
