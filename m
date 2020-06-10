Return-Path: <SRS0=dvdy=7X=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB0B1C433E0
	for <iommu@archiver.kernel.org>; Wed, 10 Jun 2020 05:47:26 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1C5C207F9
	for <iommu@archiver.kernel.org>; Wed, 10 Jun 2020 05:47:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="NL4pbin7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1C5C207F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 6BA8E86F0F;
	Wed, 10 Jun 2020 05:47:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0RVv6GqlC6tW; Wed, 10 Jun 2020 05:47:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B4D01864C4;
	Wed, 10 Jun 2020 05:47:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 97F41C0863;
	Wed, 10 Jun 2020 05:47:25 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 84CF1C016F
 for <iommu@lists.linux-foundation.org>; Wed, 10 Jun 2020 05:47:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 7B05E876C0
 for <iommu@lists.linux-foundation.org>; Wed, 10 Jun 2020 05:47:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BraSAnZVxNTp for <iommu@lists.linux-foundation.org>;
 Wed, 10 Jun 2020 05:47:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mailgw01.mediatek.com (unknown [210.61.82.183])
 by whitealder.osuosl.org (Postfix) with ESMTP id 474408763C
 for <iommu@lists.linux-foundation.org>; Wed, 10 Jun 2020 05:47:23 +0000 (UTC)
X-UUID: 4df5e063d4354aa3ae61207f68479f05-20200610
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=R2nKHBp5Cvsj2AhiULL9paxjnUyMgPHkofrlWMrINHY=; 
 b=NL4pbin7KeDovszSfsOG3qB4M0CD3YS0FscB7IQtqlzpt0oYhA+X0ZBzEI04O5LwT2T5jp1dh4GaL2arl/v2SHASJCxdA0Aq3i8v65FOWd3gHqZomJ4KjRbm+To/crQV9J781b1ZFGM8vA/yfpSrTmF6S198eFFmWzSNhWXlhZE=;
X-UUID: 4df5e063d4354aa3ae61207f68479f05-20200610
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by
 mailgw01.mediatek.com (envelope-from <ck.hu@mediatek.com>)
 (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
 with ESMTP id 445095560; Wed, 10 Jun 2020 13:47:19 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 10 Jun 2020 13:47:17 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 10 Jun 2020 13:47:17 +0800
Message-ID: <1591768038.527.6.camel@mtksdaap41>
Subject: Re: [PATCH v4 09/17] media: mtk-vcodec: Get rid of
 mtk_smi_larb_get/put
From: CK Hu <ck.hu@mediatek.com>
To: Yong Wu <yong.wu@mediatek.com>, Tiffany Lin <tiffany.lin@mediatek.com>,
 Maoguang Meng <Maoguang.Meng@mediatek.com>
Date: Wed, 10 Jun 2020 13:47:18 +0800
In-Reply-To: <1590826218-23653-10-git-send-email-yong.wu@mediatek.com>
References: <1590826218-23653-1-git-send-email-yong.wu@mediatek.com>
 <1590826218-23653-10-git-send-email-yong.wu@mediatek.com>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK: N
Cc: Will Deacon <will.deacon@arm.com>, youlin.pei@mediatek.com,
 Nicolas Boichat <drinkcat@chromium.org>, Evan Green <evgreen@chromium.org>,
 eizan@chromium.org, Matthias Kaehlcke <mka@chromium.org>,
 devicetree@vger.kernel.org, cui.zhang@mediatek.com,
 Tomasz Figa <tfiga@google.com>, Rob Herring <robh+dt@kernel.org>,
 linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>,
 ming-fan.chen@mediatek.com, Tiffany Lin <tiffany.lin@mediatek.com>,
 linux-arm-kernel@lists.infradead.org, anan.sun@mediatek.com,
 srv_heupstream@mediatek.com, acourbot@chromium.org,
 linux-kernel@vger.kernel.org, chao.hao@mediatek.com,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

+ Tiffany & Maoguang.

On Sat, 2020-05-30 at 16:10 +0800, Yong Wu wrote:
> MediaTek IOMMU has already added the device_link between the consumer
> and smi-larb device. If the vcodec device call the pm_runtime_get_sync,
> the smi-larb's pm_runtime_get_sync also be called automatically.
> 
> CC: Tiffany Lin <tiffany.lin@mediatek.com>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> Reviewed-by: Evan Green <evgreen@chromium.org>
> ---
>  .../media/platform/mtk-vcodec/mtk_vcodec_dec_pm.c  | 19 ---------------
>  drivers/media/platform/mtk-vcodec/mtk_vcodec_drv.h |  3 ---
>  drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c |  1 -
>  .../media/platform/mtk-vcodec/mtk_vcodec_enc_pm.c  | 27 ----------------------
>  4 files changed, 50 deletions(-)
> 
> diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_pm.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_pm.c
> index 36dfe3f..1d7d14d 100644
> --- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_pm.c
> +++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_pm.c
> @@ -8,14 +8,12 @@
>  #include <linux/of_address.h>
>  #include <linux/of_platform.h>
>  #include <linux/pm_runtime.h>
> -#include <soc/mediatek/smi.h>
>  
>  #include "mtk_vcodec_dec_pm.h"
>  #include "mtk_vcodec_util.h"
>  
>  int mtk_vcodec_init_dec_pm(struct mtk_vcodec_dev *mtkdev)
>  {
> -	struct device_node *node;
>  	struct platform_device *pdev;
>  	struct mtk_vcodec_pm *pm;
>  	struct mtk_vcodec_clk *dec_clk;
> @@ -26,18 +24,7 @@ int mtk_vcodec_init_dec_pm(struct mtk_vcodec_dev *mtkdev)
>  	pm = &mtkdev->pm;
>  	pm->mtkdev = mtkdev;
>  	dec_clk = &pm->vdec_clk;
> -	node = of_parse_phandle(pdev->dev.of_node, "mediatek,larb", 0);
> -	if (!node) {
> -		mtk_v4l2_err("of_parse_phandle mediatek,larb fail!");
> -		return -1;
> -	}
>  
> -	pdev = of_find_device_by_node(node);
> -	of_node_put(node);
> -	if (WARN_ON(!pdev)) {
> -		return -1;
> -	}
> -	pm->larbvdec = &pdev->dev;
>  	pdev = mtkdev->plat_dev;
>  	pm->dev = &pdev->dev;
>  
> @@ -113,11 +100,6 @@ void mtk_vcodec_dec_clock_on(struct mtk_vcodec_pm *pm)
>  		}
>  	}
>  
> -	ret = mtk_smi_larb_get(pm->larbvdec);
> -	if (ret) {
> -		mtk_v4l2_err("mtk_smi_larb_get larbvdec fail %d", ret);
> -		goto error;
> -	}
>  	return;
>  
>  error:
> @@ -130,7 +112,6 @@ void mtk_vcodec_dec_clock_off(struct mtk_vcodec_pm *pm)
>  	struct mtk_vcodec_clk *dec_clk = &pm->vdec_clk;
>  	int i = 0;
>  
> -	mtk_smi_larb_put(pm->larbvdec);
>  	for (i = dec_clk->clk_num - 1; i >= 0; i--)
>  		clk_disable_unprepare(dec_clk->clk_info[i].vcodec_clk);
>  }
> diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_drv.h b/drivers/media/platform/mtk-vcodec/mtk_vcodec_drv.h
> index 52d1ce1..7d3966a 100644
> --- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_drv.h
> +++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_drv.h
> @@ -190,10 +190,7 @@ struct mtk_vcodec_clk {
>   */
>  struct mtk_vcodec_pm {
>  	struct mtk_vcodec_clk	vdec_clk;
> -	struct device	*larbvdec;
> -
>  	struct mtk_vcodec_clk	venc_clk;
> -	struct device	*larbvenc;
>  	struct device	*dev;
>  	struct mtk_vcodec_dev	*mtkdev;
>  };
> diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c
> index 5301dca..18025f7 100644
> --- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c
> +++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c
> @@ -8,7 +8,6 @@
>  #include <media/v4l2-event.h>
>  #include <media/v4l2-mem2mem.h>
>  #include <media/videobuf2-dma-contig.h>
> -#include <soc/mediatek/smi.h>
>  #include <linux/pm_runtime.h>
>  
>  #include "mtk_vcodec_drv.h"
> diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_pm.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_pm.c
> index 01c6a55..047919e 100644
> --- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_pm.c
> +++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_pm.c
> @@ -8,44 +8,25 @@
>  #include <linux/of_address.h>
>  #include <linux/of_platform.h>
>  #include <linux/pm_runtime.h>
> -#include <soc/mediatek/smi.h>
>  
>  #include "mtk_vcodec_enc_pm.h"
>  #include "mtk_vcodec_util.h"
>  
>  int mtk_vcodec_init_enc_pm(struct mtk_vcodec_dev *mtkdev)
>  {
> -	struct device_node *node;
>  	struct platform_device *pdev;
>  	struct mtk_vcodec_pm *pm;
>  	struct mtk_vcodec_clk *enc_clk;
>  	struct mtk_vcodec_clk_info *clk_info;
>  	int ret = 0, i = 0;
> -	struct device *dev;
>  
>  	pdev = mtkdev->plat_dev;
>  	pm = &mtkdev->pm;
>  	memset(pm, 0, sizeof(struct mtk_vcodec_pm));
>  	pm->mtkdev = mtkdev;
>  	pm->dev = &pdev->dev;
> -	dev = &pdev->dev;
>  	enc_clk = &pm->venc_clk;
>  
> -	node = of_parse_phandle(dev->of_node, "mediatek,larb", 0);
> -	if (!node) {
> -		mtk_v4l2_err("no mediatek,larb found");
> -		return -ENODEV;
> -	}
> -	pdev = of_find_device_by_node(node);
> -	of_node_put(node);
> -	if (!pdev) {
> -		mtk_v4l2_err("no mediatek,larb device found");
> -		return -ENODEV;
> -	}
> -	pm->larbvenc = &pdev->dev;
> -	pdev = mtkdev->plat_dev;
> -	pm->dev = &pdev->dev;
> -
>  	enc_clk->clk_num = of_property_count_strings(pdev->dev.of_node,
>  		"clock-names");
>  	if (enc_clk->clk_num > 0) {
> @@ -93,13 +74,6 @@ void mtk_vcodec_enc_clock_on(struct mtk_vcodec_pm *pm)
>  		}
>  	}
>  
> -	ret = mtk_smi_larb_get(pm->larbvenc);
> -	if (ret) {
> -		mtk_v4l2_err("mtk_smi_larb_get larb3 fail %d", ret);
> -		goto clkerr;
> -	}
> -	return;
> -
>  clkerr:
>  	for (i -= 1; i >= 0; i--)
>  		clk_disable_unprepare(enc_clk->clk_info[i].vcodec_clk);
> @@ -110,7 +84,6 @@ void mtk_vcodec_enc_clock_off(struct mtk_vcodec_pm *pm)
>  	struct mtk_vcodec_clk *enc_clk = &pm->venc_clk;
>  	int i = 0;
>  
> -	mtk_smi_larb_put(pm->larbvenc);
>  	for (i = enc_clk->clk_num - 1; i >= 0; i--)
>  		clk_disable_unprepare(enc_clk->clk_info[i].vcodec_clk);
>  }

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
