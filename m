Return-Path: <SRS0=TfAO=UR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D047FC31E51
	for <iommu@archiver.kernel.org>; Tue, 18 Jun 2019 12:16:11 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF8FE2085A
	for <iommu@archiver.kernel.org>; Tue, 18 Jun 2019 12:16:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF8FE2085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 75277E04;
	Tue, 18 Jun 2019 12:16:11 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 07056DCE
	for <iommu@lists.linux-foundation.org>;
	Tue, 18 Jun 2019 12:16:10 +0000 (UTC)
X-Greylist: delayed 00:05:02 by SQLgrey-1.7.6
Received: from mailgw02.mediatek.com (unknown [1.203.163.81])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 09065886
	for <iommu@lists.linux-foundation.org>;
	Tue, 18 Jun 2019 12:16:03 +0000 (UTC)
X-UUID: a61a4d68c17546f1a3aba41ba7520d0d-20190618
X-UUID: a61a4d68c17546f1a3aba41ba7520d0d-20190618
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
	(envelope-from <yong.wu@mediatek.com>)
	(mailgw01.mediatek.com ESMTP with TLS)
	with ESMTP id 439604230; Tue, 18 Jun 2019 20:10:58 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N1.mediatek.inc
	(172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1395.4;
	Tue, 18 Jun 2019 20:10:56 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS36.mediatek.inc
	(172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
	Transport; Tue, 18 Jun 2019 20:10:55 +0800
Message-ID: <1560859855.8082.24.camel@mhfsdcap03>
Subject: Re: [PATCH v7 16/21] memory: mtk-smi: Add bus_sel for mt8183
From: Yong Wu <yong.wu@mediatek.com>
To: Matthias Brugger <matthias.bgg@gmail.com>
Date: Tue, 18 Jun 2019 20:10:55 +0800
In-Reply-To: <0205e43a-8677-c194-d118-6c199c03306c@gmail.com>
References: <1560169080-27134-1-git-send-email-yong.wu@mediatek.com>
	<1560169080-27134-17-git-send-email-yong.wu@mediatek.com>
	<0205e43a-8677-c194-d118-6c199c03306c@gmail.com>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
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

On Mon, 2019-06-17 at 18:23 +0200, Matthias Brugger wrote:
> 
> On 10/06/2019 14:17, Yong Wu wrote:
> > There are 2 mmu cells in a M4U HW. we could adjust some larbs entering
> > mmu0 or mmu1 to balance the bandwidth via the smi-common register
> > SMI_BUS_SEL(0x220)(Each larb occupy 2 bits).
> > 
> > In mt8183, For better performance, we switch larb1/2/5/7 to enter
> > mmu1 while the others still keep enter mmu0.
> > 
> > In mt8173 and mt2712, we don't get the performance issue,
> > Keep its default value(0x0), that means all the larbs enter mmu0.
> > 
> > Note: smi gen1(mt2701/mt7623) don't have this bus_sel.
> > 
> > And, the base of smi-common is completely different with smi_ao_base
> > of gen1, thus I add new variable for that.
> > 
> > CC: Matthias Brugger <matthias.bgg@gmail.com>
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > Reviewed-by: Evan Green <evgreen@chromium.org>
> > ---
> >  drivers/memory/mtk-smi.c | 22 ++++++++++++++++++++--
> >  1 file changed, 20 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
> > index 9790801..08cf40d 100644
> > --- a/drivers/memory/mtk-smi.c
> > +++ b/drivers/memory/mtk-smi.c
> > @@ -49,6 +49,12 @@
> >  #define SMI_LARB_NONSEC_CON(id)	(0x380 + ((id) * 4))
> >  #define F_MMU_EN		BIT(0)
> >  
> > +/* SMI COMMON */
> > +#define SMI_BUS_SEL			0x220
> > +#define SMI_BUS_LARB_SHIFT(larbid)	((larbid) << 1)
> > +/* All are MMU0 defaultly. Only specialize mmu1 here. */
> > +#define F_MMU1_LARB(larbid)		(0x1 << SMI_BUS_LARB_SHIFT(larbid))
> > +
> >  enum mtk_smi_gen {
> >  	MTK_SMI_GEN1,
> >  	MTK_SMI_GEN2
> > @@ -57,6 +63,7 @@ enum mtk_smi_gen {
> >  struct mtk_smi_common_plat {
> >  	enum mtk_smi_gen gen;
> >  	bool             has_gals;
> > +	u32              bus_sel; /* Balance some larbs to enter mmu0 or mmu1 */
> >  };
> >  
> >  struct mtk_smi_larb_gen {
> > @@ -72,8 +79,8 @@ struct mtk_smi {
> >  	struct clk			*clk_apb, *clk_smi;
> >  	struct clk			*clk_gals0, *clk_gals1;
> >  	struct clk			*clk_async; /*only needed by mt2701*/
> > -	void __iomem			*smi_ao_base;
> > -
> > +	void __iomem			*smi_ao_base; /* only for gen1 */
> > +	void __iomem			*base;	      /* only for gen2 */
> 
> union {} maybe?

Yes. Thanks.

I will add it.

> 
> >  	const struct mtk_smi_common_plat *plat;
> >  };
> >  
> > @@ -410,6 +417,8 @@ static int __maybe_unused mtk_smi_larb_suspend(struct device *dev)
> >  static const struct mtk_smi_common_plat mtk_smi_common_mt8183 = {
> >  	.gen      = MTK_SMI_GEN2,
> >  	.has_gals = true,
> > +	.bus_sel  = F_MMU1_LARB(1) | F_MMU1_LARB(2) | F_MMU1_LARB(5) |
> > +		    F_MMU1_LARB(7),
> >  };
> >  
> >  static const struct of_device_id mtk_smi_common_of_ids[] = {
> > @@ -482,6 +491,11 @@ static int mtk_smi_common_probe(struct platform_device *pdev)
> >  		ret = clk_prepare_enable(common->clk_async);
> >  		if (ret)
> >  			return ret;
> > +	} else {
> > +		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +		common->base = devm_ioremap_resource(dev, res);
> > +		if (IS_ERR(common->base))
> > +			return PTR_ERR(common->base);
> 
> We must be backwards compatible with DT which does not have the base defined.

The smi-common node in the previous mt2712 and mt8173 also have the
"reg" property even though they didn't use this base, Thus, It looks ok
for all the cases.

> 
> Regards,
> Matthias
> 
> >  	}
> >  	pm_runtime_enable(dev);
> >  	platform_set_drvdata(pdev, common);
> > @@ -497,6 +511,7 @@ static int mtk_smi_common_remove(struct platform_device *pdev)
> >  static int __maybe_unused mtk_smi_common_resume(struct device *dev)
> >  {
> >  	struct mtk_smi *common = dev_get_drvdata(dev);
> > +	u32 bus_sel = common->plat->bus_sel;
> >  	int ret;
> >  
> >  	ret = mtk_smi_clk_enable(common);
> > @@ -504,6 +519,9 @@ static int __maybe_unused mtk_smi_common_resume(struct device *dev)
> >  		dev_err(common->dev, "Failed to enable clock(%d).\n", ret);
> >  		return ret;
> >  	}
> > +
> > +	if (common->plat->gen == MTK_SMI_GEN2 && bus_sel)
> > +		writel(bus_sel, common->base + SMI_BUS_SEL);
> >  	return 0;
> >  }
> >  
> > 


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
