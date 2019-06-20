Return-Path: <SRS0=IV2l=UT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F32CEC43613
	for <iommu@archiver.kernel.org>; Thu, 20 Jun 2019 13:59:47 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD7422083B
	for <iommu@archiver.kernel.org>; Thu, 20 Jun 2019 13:59:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD7422083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 5F2B0CF3;
	Thu, 20 Jun 2019 13:59:47 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 517BBC90
	for <iommu@lists.linux-foundation.org>;
	Thu, 20 Jun 2019 13:59:46 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mailgw01.mediatek.com (unknown [1.203.163.78])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id E880AE6
	for <iommu@lists.linux-foundation.org>;
	Thu, 20 Jun 2019 13:59:43 +0000 (UTC)
X-UUID: 3ec89478192847369c3196d30ab18a5d-20190620
X-UUID: 3ec89478192847369c3196d30ab18a5d-20190620
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
	(envelope-from <yong.wu@mediatek.com>)
	(mailgw01.mediatek.com ESMTP with TLS)
	with ESMTP id 1290995149; Thu, 20 Jun 2019 21:59:39 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31DR.mediatek.inc
	(172.27.6.102) with Microsoft SMTP Server (TLS) id 15.0.1395.4;
	Thu, 20 Jun 2019 21:59:37 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS36.mediatek.inc
	(172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
	Transport; Thu, 20 Jun 2019 21:59:36 +0800
Message-ID: <1561039176.4021.21.camel@mhfsdcap03>
Subject: Re: [PATCH v7 17/21] memory: mtk-smi: Get rid of need_larbid
From: Yong Wu <yong.wu@mediatek.com>
To: Matthias Brugger <matthias.bgg@gmail.com>
Date: Thu, 20 Jun 2019 21:59:36 +0800
In-Reply-To: <1af7b67a-b73a-efb9-e1f8-5701f05a4af0@gmail.com>
References: <1560169080-27134-1-git-send-email-yong.wu@mediatek.com>
	<1560169080-27134-18-git-send-email-yong.wu@mediatek.com>
	<1af7b67a-b73a-efb9-e1f8-5701f05a4af0@gmail.com>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 2CA6D34368F87003217514E1A5818323AB156BC86301E5B7347A400EECEBE2612000:8
X-MTK: N
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
	Nicolas Boichat <drinkcat@chromium.org>,
	srv_heupstream@mediatek.com, Will Deacon <will.deacon@arm.com>,
	linux-kernel@vger.kernel.org, Evan Green <evgreen@chromium.org>, Tomasz
	Figa <tfiga@google.com>, iommu@lists.linux-foundation.org, Rob
	Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org,
	yingjoe.chen@mediatek.com, anan.sun@mediatek.com,
	Robin Murphy <robin.murphy@arm.com>, Matthias Kaehlcke <mka@chromium.org>,
	linux-arm-kernel@lists.infradead.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On Tue, 2019-06-18 at 15:45 +0200, Matthias Brugger wrote:
> 
> On 10/06/2019 14:17, Yong Wu wrote:
> > The "mediatek,larb-id" has already been parsed in MTK IOMMU driver.
> > It's no need to parse it again in SMI driver. Only clean some codes.
> > This patch is fit for all the current mt2701, mt2712, mt7623, mt8173
> > and mt8183.
> > 
> > After this patch, the "mediatek,larb-id" only be needed for mt2712
> > which have 2 M4Us. In the other SoCs, we can get the larb-id from M4U
> > in which the larbs in the "mediatek,larbs" always are ordered.
> > 
> > Correspondingly, the larb_nr in the "struct mtk_smi_iommu" could also
> > be deleted.
> > 
> 
> I think we can get rid of struct mtk_smi_iommu and just add the
> struct mtk_smi_larb_iommu larb_imu[MTK_LARB_NR_MAX] directly to mtk_iommu_data,
> passing just that array to the components bind function.

Thanks. I will try this in a new patch.

> 
> Never the less this patch looks fine:
> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

Really appreciate for reviewing so many patches.

> 
> > CC: Matthias Brugger <matthias.bgg@gmail.com>
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > Reviewed-by: Evan Green <evgreen@chromium.org>
> > ---
> >  drivers/iommu/mtk_iommu.c    |  1 -
> >  drivers/iommu/mtk_iommu_v1.c |  2 --
> >  drivers/memory/mtk-smi.c     | 26 ++------------------------
> >  include/soc/mediatek/smi.h   |  1 -
> >  4 files changed, 2 insertions(+), 28 deletions(-)
> > 
> > diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> > index ec4ce74..6053b8b 100644
> > --- a/drivers/iommu/mtk_iommu.c
> > +++ b/drivers/iommu/mtk_iommu.c
> > @@ -634,7 +634,6 @@ static int mtk_iommu_probe(struct platform_device *pdev)
> >  					     "mediatek,larbs", NULL);
> >  	if (larb_nr < 0)
> >  		return larb_nr;
> > -	data->smi_imu.larb_nr = larb_nr;
> >  
> >  	for (i = 0; i < larb_nr; i++) {
> >  		struct device_node *larbnode;
> > diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
> > index 52b01e3..73308ad 100644
> > --- a/drivers/iommu/mtk_iommu_v1.c
> > +++ b/drivers/iommu/mtk_iommu_v1.c
> > @@ -624,8 +624,6 @@ static int mtk_iommu_probe(struct platform_device *pdev)
> >  		larb_nr++;
> >  	}
> >  
> > -	data->smi_imu.larb_nr = larb_nr;
> > -
> >  	platform_set_drvdata(pdev, data);
> >  
> >  	ret = mtk_iommu_hw_init(data);
> > diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
> > index 08cf40d..10e6493 100644
> > --- a/drivers/memory/mtk-smi.c
> > +++ b/drivers/memory/mtk-smi.c
> > @@ -67,7 +67,6 @@ struct mtk_smi_common_plat {
> >  };
> >  
> >  struct mtk_smi_larb_gen {
> > -	bool need_larbid;
> >  	int port_in_larb[MTK_LARB_NR_MAX + 1];
> >  	void (*config_port)(struct device *);
> >  	unsigned int larb_direct_to_common_mask;
> > @@ -153,18 +152,9 @@ void mtk_smi_larb_put(struct device *larbdev)
> >  	struct mtk_smi_iommu *smi_iommu = data;
> >  	unsigned int         i;
> >  
> > -	if (larb->larb_gen->need_larbid) {
> > -		larb->mmu = &smi_iommu->larb_imu[larb->larbid].mmu;
> > -		return 0;
> > -	}
> > -
> > -	/*
> > -	 * If there is no larbid property, Loop to find the corresponding
> > -	 * iommu information.
> > -	 */
> > -	for (i = 0; i < smi_iommu->larb_nr; i++) {
> > +	for (i = 0; i < MTK_LARB_NR_MAX; i++) {
> >  		if (dev == smi_iommu->larb_imu[i].dev) {
> > -			/* The 'mmu' may be updated in iommu-attach/detach. */
> > +			larb->larbid = i;
> >  			larb->mmu = &smi_iommu->larb_imu[i].mmu;
> >  			return 0;
> >  		}
> > @@ -243,7 +233,6 @@ static void mtk_smi_larb_config_port_gen1(struct device *dev)
> >  };
> >  
> >  static const struct mtk_smi_larb_gen mtk_smi_larb_mt2701 = {
> > -	.need_larbid = true,
> >  	.port_in_larb = {
> >  		LARB0_PORT_OFFSET, LARB1_PORT_OFFSET,
> >  		LARB2_PORT_OFFSET, LARB3_PORT_OFFSET
> > @@ -252,7 +241,6 @@ static void mtk_smi_larb_config_port_gen1(struct device *dev)
> >  };
> >  
> >  static const struct mtk_smi_larb_gen mtk_smi_larb_mt2712 = {
> > -	.need_larbid = true,
> >  	.config_port                = mtk_smi_larb_config_port_gen2_general,
> >  	.larb_direct_to_common_mask = BIT(8) | BIT(9),      /* bdpsys */
> >  };
> > @@ -291,7 +279,6 @@ static int mtk_smi_larb_probe(struct platform_device *pdev)
> >  	struct device *dev = &pdev->dev;
> >  	struct device_node *smi_node;
> >  	struct platform_device *smi_pdev;
> > -	int err;
> >  
> >  	larb = devm_kzalloc(dev, sizeof(*larb), GFP_KERNEL);
> >  	if (!larb)
> > @@ -321,15 +308,6 @@ static int mtk_smi_larb_probe(struct platform_device *pdev)
> >  	}
> >  	larb->smi.dev = dev;
> >  
> > -	if (larb->larb_gen->need_larbid) {
> > -		err = of_property_read_u32(dev->of_node, "mediatek,larb-id",
> > -					   &larb->larbid);
> > -		if (err) {
> > -			dev_err(dev, "missing larbid property\n");
> > -			return err;
> > -		}
> > -	}
> > -
> >  	smi_node = of_parse_phandle(dev->of_node, "mediatek,smi", 0);
> >  	if (!smi_node)
> >  		return -EINVAL;
> > diff --git a/include/soc/mediatek/smi.h b/include/soc/mediatek/smi.h
> > index 5201e90..a65324d 100644
> > --- a/include/soc/mediatek/smi.h
> > +++ b/include/soc/mediatek/smi.h
> > @@ -29,7 +29,6 @@ struct mtk_smi_larb_iommu {
> >  };
> >  
> >  struct mtk_smi_iommu {
> > -	unsigned int larb_nr;
> >  	struct mtk_smi_larb_iommu larb_imu[MTK_LARB_NR_MAX];
> >  };
> >  
> > 


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
