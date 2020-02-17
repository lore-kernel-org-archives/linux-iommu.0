Return-Path: <SRS0=vxCL=4F=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 499D1C35254
	for <iommu@archiver.kernel.org>; Mon, 17 Feb 2020 11:35:28 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F74520836
	for <iommu@archiver.kernel.org>; Mon, 17 Feb 2020 11:35:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="PxgkLckJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F74520836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id CA1B485D57;
	Mon, 17 Feb 2020 11:35:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5V3P+hQu5y8N; Mon, 17 Feb 2020 11:35:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 24EB3841DA;
	Mon, 17 Feb 2020 11:35:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 14BC5C08A0;
	Mon, 17 Feb 2020 11:35:27 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D9453C013E
 for <iommu@lists.linux-foundation.org>; Mon, 17 Feb 2020 11:35:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id C35AB85D57
 for <iommu@lists.linux-foundation.org>; Mon, 17 Feb 2020 11:35:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iEFqZ6bAKX6Q for <iommu@lists.linux-foundation.org>;
 Mon, 17 Feb 2020 11:35:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mailgw01.mediatek.com (unknown [210.61.82.183])
 by whitealder.osuosl.org (Postfix) with ESMTP id 8EF62841DA
 for <iommu@lists.linux-foundation.org>; Mon, 17 Feb 2020 11:35:23 +0000 (UTC)
X-UUID: 3d255e9f271344ebb1ffecef37e7560d-20200217
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=eP5l76kC+wYQ1SgKc3IwEHH0X8lfLQiaEbwRojJdv0w=; 
 b=PxgkLckJECq3POl9lr7b11FiX6J7VBJhpW9lzfhfyaeC8bClzLDomAHJJNbS0AGFXgqS3lT7bRVr/0XoIUCMxYVG6uTnEwRgFURys9PNNNS1h0ZfwzfIKjaNCvsn6+sMuCkpOKLdJdA5NuyTsBr1JQgK52yKnRv5goDgA1i82tY=;
X-UUID: 3d255e9f271344ebb1ffecef37e7560d-20200217
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by
 mailgw01.mediatek.com (envelope-from <yong.wu@mediatek.com>)
 (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
 with ESMTP id 2131103376; Mon, 17 Feb 2020 19:35:20 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by mtkmbs05n1.mediatek.inc
 (172.21.101.15) with Microsoft SMTP Server (TLS) id 15.0.1395.4;
 Mon, 17 Feb 2020 19:34:24 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 17 Feb 2020 19:35:55 +0800
Message-ID: <1581939298.4784.12.camel@mhfsdcap03>
Subject: Re: [PATCH 2/2] iommu/mediatek: add support for MT8167
From: Yong Wu <yong.wu@mediatek.com>
To: Fabien Parent <fparent@baylibre.com>
Date: Mon, 17 Feb 2020 19:34:58 +0800
In-Reply-To: <1581902146.28283.0.camel@mtksdaap41>
References: <20200103162632.109553-1-fparent@baylibre.com>
 <20200103162632.109553-2-fparent@baylibre.com>
 <1581902146.28283.0.camel@mtksdaap41>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK: N
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, CK Hu <ck.hu@mediatek.com>,
 iommu@lists.linux-foundation.org, robh+dt@kernel.org,
 linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com,
 linux-arm-kernel@lists.infradead.org
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

Hi Fabien,

Thanks very much for your patch.

On Mon, 2020-02-17 at 09:15 +0800, CK Hu wrote:
> +Yong.Wu.
> 
> On Fri, 2020-01-03 at 17:26 +0100, Fabien Parent wrote:
> > Add support for the IOMMU on MT8167
> > 
> > Signed-off-by: Fabien Parent <fparent@baylibre.com>
> > ---
> >  drivers/iommu/mtk_iommu.c | 11 ++++++++++-
> >  drivers/iommu/mtk_iommu.h |  1 +
> >  2 files changed, 11 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> > index 6fc1f5ecf91e..5fc6178a82dc 100644
> > --- a/drivers/iommu/mtk_iommu.c
> > +++ b/drivers/iommu/mtk_iommu.c
> > @@ -569,7 +569,8 @@ static int mtk_iommu_hw_init(const struct mtk_iommu_data *data)
> >  		F_INT_PRETETCH_TRANSATION_FIFO_FAULT;
> >  	writel_relaxed(regval, data->base + REG_MMU_INT_MAIN_CONTROL);
> >  
> > -	if (data->plat_data->m4u_plat == M4U_MT8173)
> > +	if (data->plat_data->m4u_plat == M4U_MT8173 ||
> > +	    data->plat_data->m4u_plat == M4U_MT8167)

I didn't know mt8167 will do upstream. In my original thought, there is
only mt8173 use this setting and the later SoC won't use this, So I used
the "m4u_plat" directly here.

If we also need support mt8167, then CK's suggestion is reasonable. we
could add a new variable like "legacy_ivrp_paddr" from its register name
in a seperated patch, then support mt8167 in a new patch.

> >  		regval = (data->protect_base >> 1) | (data->enable_4GB << 31);
> >  	else
> >  		regval = lower_32_bits(data->protect_base) |
> > @@ -782,6 +783,13 @@ static const struct mtk_iommu_plat_data mt2712_data = {
> >  	.larbid_remap = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9},
> >  };
> >  
> > +static const struct mtk_iommu_plat_data mt8167_data = {
> > +	.m4u_plat     = M4U_MT8167,
> > +	.has_4gb_mode = true,
> > +	.reset_axi    = true,
> > +	.larbid_remap = {0, 1, 2, 3, 4, 5}, /* Linear mapping. */
> > +};
> > +
> >  static const struct mtk_iommu_plat_data mt8173_data = {
> >  	.m4u_plat     = M4U_MT8173,
> >  	.has_4gb_mode = true,
> > @@ -798,6 +806,7 @@ static const struct mtk_iommu_plat_data mt8183_data = {
> >  
> >  static const struct of_device_id mtk_iommu_of_ids[] = {
> >  	{ .compatible = "mediatek,mt2712-m4u", .data = &mt2712_data},
> > +	{ .compatible = "mediatek,mt8167-m4u", .data = &mt8167_data},
> >  	{ .compatible = "mediatek,mt8173-m4u", .data = &mt8173_data},
> >  	{ .compatible = "mediatek,mt8183-m4u", .data = &mt8183_data},
> >  	{}
> > diff --git a/drivers/iommu/mtk_iommu.h b/drivers/iommu/mtk_iommu.h
> > index ea949a324e33..cb8fd5970cd4 100644
> > --- a/drivers/iommu/mtk_iommu.h
> > +++ b/drivers/iommu/mtk_iommu.h
> > @@ -30,6 +30,7 @@ struct mtk_iommu_suspend_reg {
> >  enum mtk_iommu_plat {
> >  	M4U_MT2701,
> >  	M4U_MT2712,
> > +	M4U_MT8167,
> >  	M4U_MT8173,
> >  	M4U_MT8183,
> >  };
> 
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
