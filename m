Return-Path: <SRS0=H1gU=UV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8457C43613
	for <iommu@archiver.kernel.org>; Sat, 22 Jun 2019 02:43:00 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8391220821
	for <iommu@archiver.kernel.org>; Sat, 22 Jun 2019 02:43:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8391220821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 67D0C142A;
	Sat, 22 Jun 2019 02:42:59 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 0D5B413F6
	for <iommu@lists.linux-foundation.org>;
	Sat, 22 Jun 2019 02:42:56 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mailgw01.mediatek.com (unknown [1.203.163.78])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 0CE2D224
	for <iommu@lists.linux-foundation.org>;
	Sat, 22 Jun 2019 02:42:54 +0000 (UTC)
X-UUID: d6cd0e2e4bbc4284bbdc8a37dd63a604-20190622
X-UUID: d6cd0e2e4bbc4284bbdc8a37dd63a604-20190622
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
	(envelope-from <yong.wu@mediatek.com>)
	(mailgw01.mediatek.com ESMTP with TLS)
	with ESMTP id 1360281704; Sat, 22 Jun 2019 10:42:46 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31DR.mediatek.inc
	(172.27.6.102) with Microsoft SMTP Server (TLS) id 15.0.1395.4;
	Sat, 22 Jun 2019 10:42:36 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS32.mediatek.inc
	(172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
	Transport; Sat, 22 Jun 2019 10:42:35 +0800
Message-ID: <1561171355.4850.7.camel@mhfsdcap03>
Subject: Re: [PATCH v2 05/12] media: mtk-jpeg: Get rid of mtk_smi_larb_get/put
From: Yong Wu <yong.wu@mediatek.com>
To: Matthias Brugger <matthias.bgg@gmail.com>
Date: Sat, 22 Jun 2019 10:42:35 +0800
In-Reply-To: <6539751d-1751-f309-1c51-b3f9576c1b99@gmail.com>
References: <1560171313-28299-1-git-send-email-yong.wu@mediatek.com>
	<1560171313-28299-6-git-send-email-yong.wu@mediatek.com>
	<6539751d-1751-f309-1c51-b3f9576c1b99@gmail.com>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 2A30C6EFC43BFC5A9239BAECC619A787D0115E0887011AB5A837AB732B8DB5C02000:8
X-MTK: N
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
	Nicolas Boichat <drinkcat@chromium.org>,
	Rick Chang <rick.chang@mediatek.com>,
	srv_heupstream@mediatek.com, Will Deacon <will.deacon@arm.com>,
	linux-kernel@vger.kernel.org, Evan Green <evgreen@chromium.org>, Tomasz
	Figa <tfiga@google.com>, iommu@lists.linux-foundation.org,
	Rob Herring <robh+dt@kernel.org>,
	linux-mediatek@lists.infradead.org, yingjoe.chen@mediatek.com,
	anan.sun@mediatek.com, Robin Murphy <robin.murphy@arm.com>,
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

On Thu, 2019-06-20 at 17:20 +0200, Matthias Brugger wrote:
> 
> On 10/06/2019 14:55, Yong Wu wrote:
> > MediaTek IOMMU has already added device_link between the consumer
> > and smi-larb device. If the jpg device call the pm_runtime_get_sync,
> > the smi-larb's pm_runtime_get_sync also be called automatically.
> 
> Please help me out find this relation. I seem to miss something basic, because I
> can't find any between the jpeg IP and the iommu.

JPEG also is a multimedia consumer. It also access memory via IOMMU. All
the current SoC have the JPG smi ports. 

grep -r JPG include/dt-bindings/memory/mt*

> 
> Regards,
> Matthias
> 
> > 
> > CC: Rick Chang <rick.chang@mediatek.com>
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > Reviewed-by: Evan Green <evgreen@chromium.org>
> > ---
> >  drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c | 22 ----------------------
> >  drivers/media/platform/mtk-jpeg/mtk_jpeg_core.h |  2 --
> >  2 files changed, 24 deletions(-)
> > 
> > diff --git a/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c b/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c
> > index f761e4d..2f37538 100644
> > --- a/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c
> > +++ b/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c
> > @@ -29,7 +29,6 @@
> >  #include <media/v4l2-ioctl.h>
> >  #include <media/videobuf2-core.h>
> >  #include <media/videobuf2-dma-contig.h>
> > -#include <soc/mediatek/smi.h>
> >  
> >  #include "mtk_jpeg_hw.h"
> >  #include "mtk_jpeg_core.h"
> > @@ -901,11 +900,6 @@ static int mtk_jpeg_queue_init(void *priv, struct vb2_queue *src_vq,
> >  
> >  static void mtk_jpeg_clk_on(struct mtk_jpeg_dev *jpeg)
> >  {
> > -	int ret;
> > -
> > -	ret = mtk_smi_larb_get(jpeg->larb);
> > -	if (ret)
> > -		dev_err(jpeg->dev, "mtk_smi_larb_get larbvdec fail %d\n", ret);
> >  	clk_prepare_enable(jpeg->clk_jdec_smi);
> >  	clk_prepare_enable(jpeg->clk_jdec);
> >  }
> > @@ -914,7 +908,6 @@ static void mtk_jpeg_clk_off(struct mtk_jpeg_dev *jpeg)
> >  {
> >  	clk_disable_unprepare(jpeg->clk_jdec);
> >  	clk_disable_unprepare(jpeg->clk_jdec_smi);
> > -	mtk_smi_larb_put(jpeg->larb);
> >  }
> >  
> >  static irqreturn_t mtk_jpeg_dec_irq(int irq, void *priv)
> > @@ -1059,21 +1052,6 @@ static int mtk_jpeg_release(struct file *file)
> >  
> >  static int mtk_jpeg_clk_init(struct mtk_jpeg_dev *jpeg)
> >  {
> > -	struct device_node *node;
> > -	struct platform_device *pdev;
> > -
> > -	node = of_parse_phandle(jpeg->dev->of_node, "mediatek,larb", 0);
> > -	if (!node)
> > -		return -EINVAL;
> > -	pdev = of_find_device_by_node(node);
> > -	if (WARN_ON(!pdev)) {
> > -		of_node_put(node);
> > -		return -EINVAL;
> > -	}
> > -	of_node_put(node);
> > -
> > -	jpeg->larb = &pdev->dev;
> > -
> >  	jpeg->clk_jdec = devm_clk_get(jpeg->dev, "jpgdec");
> >  	if (IS_ERR(jpeg->clk_jdec))
> >  		return PTR_ERR(jpeg->clk_jdec);
> > diff --git a/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.h b/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.h
> > index 1a6cdfd..e35fb79 100644
> > --- a/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.h
> > +++ b/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.h
> > @@ -55,7 +55,6 @@ enum mtk_jpeg_ctx_state {
> >   * @dec_reg_base:	JPEG registers mapping
> >   * @clk_jdec:		JPEG hw working clock
> >   * @clk_jdec_smi:	JPEG SMI bus clock
> > - * @larb:		SMI device
> >   */
> >  struct mtk_jpeg_dev {
> >  	struct mutex		lock;
> > @@ -69,7 +68,6 @@ struct mtk_jpeg_dev {
> >  	void __iomem		*dec_reg_base;
> >  	struct clk		*clk_jdec;
> >  	struct clk		*clk_jdec_smi;
> > -	struct device		*larb;
> >  };
> >  
> >  /**
> > 


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
