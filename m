Return-Path: <SRS0=42j6=W7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1E75C3A5A7
	for <iommu@archiver.kernel.org>; Wed,  4 Sep 2019 06:41:23 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E90822CF5
	for <iommu@archiver.kernel.org>; Wed,  4 Sep 2019 06:41:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E90822CF5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 650F71080;
	Wed,  4 Sep 2019 06:41:01 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 8ED14F31
	for <iommu@lists.linux-foundation.org>;
	Wed,  4 Sep 2019 04:13:09 +0000 (UTC)
X-Greylist: delayed 00:05:01 by SQLgrey-1.7.6
Received: from mailgw01.mediatek.com (unknown [1.203.163.78])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id D0330709
	for <iommu@lists.linux-foundation.org>;
	Wed,  4 Sep 2019 04:13:07 +0000 (UTC)
X-UUID: c8c948f33d2047f3bdfa7905ae66264b-20190904
X-UUID: c8c948f33d2047f3bdfa7905ae66264b-20190904
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
	(envelope-from <houlong.wei@mediatek.com>)
	(mailgw01.mediatek.com ESMTP with TLS)
	with ESMTP id 561403735; Wed, 04 Sep 2019 12:07:57 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N2.mediatek.inc
	(172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1395.4;
	Wed, 4 Sep 2019 12:07:54 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS32.mediatek.inc
	(172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
	Transport; Wed, 4 Sep 2019 12:07:53 +0800
Message-ID: <1567570074.31301.19.camel@mhfsdcap03>
Subject: Re: [PATCH v3 06/14] media: mtk-mdp: Get rid of mtk_smi_larb_get/put
From: houlong wei <houlong.wei@mediatek.com>
To: Yong Wu <yong.wu@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
	Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>
Date: Wed, 4 Sep 2019 12:07:54 +0800
In-Reply-To: <mailman.21807.1567503573.19300.linux-mediatek@lists.infradead.org>
References: <mailman.21807.1567503573.19300.linux-mediatek@lists.infradead.org>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 500850E9C33D38436DBF3DA1D3DC54035EACB51BDE85BE19A0327058E6BBD5A42000:8
X-MTK: N
X-Mailman-Approved-At: Wed, 04 Sep 2019 06:41:00 +0000
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
	Nicolas Boichat <drinkcat@chromium.org>, cui.zhang@mediatek.com,
	srv_heupstream@mediatek.com, chao.hao@mediatek.com,
	Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
	Evan Green <evgreen@chromium.org>, houlong.wei@mediatek.com,
	Tomasz Figa <tfiga@google.com>, iommu@lists.linux-foundation.org,
	Matthias Kaehlcke <mka@chromium.org>,
	linux-mediatek@lists.infradead.org, minghsiu.tsai@mediatek.com,
	ming-fan.chen@mediatek.com, anan.sun@mediatek.com,
	Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
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

Hi, Yong,

I have inline comment below.

> MediaTek IOMMU has already added the device_link between the consumer
> and smi-larb device. If the mdp device call the pm_runtime_get_sync,
> the smi-larb's pm_runtime_get_sync also be called automatically.
> 
> CC: Minghsiu Tsai <minghsiu.tsai@mediatek.com>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> Reviewed-by: Evan Green <evgreen@chromium.org>
> ---
>  drivers/media/platform/mtk-mdp/mtk_mdp_comp.c | 38 ---------------------------
>  drivers/media/platform/mtk-mdp/mtk_mdp_comp.h |  2 --
>  drivers/media/platform/mtk-mdp/mtk_mdp_core.c |  1 -
>  3 files changed, 41 deletions(-)
> 
> diff --git a/drivers/media/platform/mtk-mdp/mtk_mdp_comp.c b/drivers/media/platform/mtk-mdp/mtk_mdp_comp.c
> index 9afe816..5985a9b 100644
> --- a/drivers/media/platform/mtk-mdp/mtk_mdp_comp.c
> +++ b/drivers/media/platform/mtk-mdp/mtk_mdp_comp.c
> @@ -9,7 +9,6 @@
>  #include <linux/of.h>
>  #include <linux/of_address.h>
>  #include <linux/of_platform.h>
> -#include <soc/mediatek/smi.h>
>  
>  #include "mtk_mdp_comp.h"
>  
> @@ -58,14 +57,6 @@ void mtk_mdp_comp_clock_on(struct device *dev, struct mtk_mdp_comp *comp)
>  {
>  	int i, err;
>  
> -	if (comp->larb_dev) {
> -		err = mtk_smi_larb_get(comp->larb_dev);
> -		if (err)
> -			dev_err(dev,
> -				"failed to get larb, err %d. type:%d id:%d\n",
> -				err, comp->type, comp->id);
> -	}

In previous design,mtk_mdp_comp_clock_on() is called by each MDP
hardware component, and mtk_smi_larb_get() is also called for each MDP
hardware component which accesses DRAM via SMI larb.

Since mdp device only contains mdp_rdma component, so
pm_runtime_get_sync() will ignore other smi-larb clock. We need consider
how to enable clocks of other smi-larb associated with other mdp
component, e.g. mdp_wdma, mdp_wrot.


>  	for (i = 0; i < ARRAY_SIZE(comp->clk); i++) {
>  		if (IS_ERR(comp->clk[i]))
>  			continue;
> @@ -86,16 +77,11 @@ void mtk_mdp_comp_clock_off(struct device *dev, struct mtk_mdp_comp *comp)
>  			continue;
>  		clk_disable_unprepare(comp->clk[i]);
>  	}
> -
> -	if (comp->larb_dev)
> -		mtk_smi_larb_put(comp->larb_dev);
>  }
>  
>  int mtk_mdp_comp_init(struct device *dev, struct device_node *node,
>  		      struct mtk_mdp_comp *comp, enum mtk_mdp_comp_id comp_id)
>  {
> -	struct device_node *larb_node;
> -	struct platform_device *larb_pdev;
>  	int i;
>  
>  	if (comp_id < 0 || comp_id >= MTK_MDP_COMP_ID_MAX) {
> @@ -116,30 +102,6 @@ int mtk_mdp_comp_init(struct device *dev, struct device_node *node,
>  			break;
>  	}
>  
> -	/* Only DMA capable components need the LARB property */
> -	comp->larb_dev = NULL;
> -	if (comp->type != MTK_MDP_RDMA &&
> -	    comp->type != MTK_MDP_WDMA &&
> -	    comp->type != MTK_MDP_WROT)
> -		return 0;
> -
> -	larb_node = of_parse_phandle(node, "mediatek,larb", 0);
> -	if (!larb_node) {
> -		dev_err(dev,
> -			"Missing mediadek,larb phandle in %pOF node\n", node);
> -		return -EINVAL;
> -	}
> -
> -	larb_pdev = of_find_device_by_node(larb_node);
> -	if (!larb_pdev) {
> -		dev_warn(dev, "Waiting for larb device %pOF\n", larb_node);
> -		of_node_put(larb_node);
> -		return -EPROBE_DEFER;
> -	}
> -	of_node_put(larb_node);
> -
> -	comp->larb_dev = &larb_pdev->dev;
> -
>  	return 0;
>  }
>  
> diff --git a/drivers/media/platform/mtk-mdp/mtk_mdp_comp.h b/drivers/media/platform/mtk-mdp/mtk_mdp_comp.h
> index 998a4b9..a2da8df 100644
> --- a/drivers/media/platform/mtk-mdp/mtk_mdp_comp.h
> +++ b/drivers/media/platform/mtk-mdp/mtk_mdp_comp.h
> @@ -39,7 +39,6 @@ enum mtk_mdp_comp_id {
>   * @dev_node:	component device node
>   * @clk:	clocks required for component
>   * @regs:	Mapped address of component registers.
> - * @larb_dev:	SMI device required for component
>   * @type:	component type
>   * @id:		component ID
>   */
> @@ -47,7 +46,6 @@ struct mtk_mdp_comp {
>  	struct device_node	*dev_node;
>  	struct clk		*clk[2];
>  	void __iomem		*regs;
> -	struct device		*larb_dev;
>  	enum mtk_mdp_comp_type	type;
>  	enum mtk_mdp_comp_id	id;
>  };
> diff --git a/drivers/media/platform/mtk-mdp/mtk_mdp_core.c b/drivers/media/platform/mtk-mdp/mtk_mdp_core.c
> index fc9faec..c237ed9 100644
> --- a/drivers/media/platform/mtk-mdp/mtk_mdp_core.c
> +++ b/drivers/media/platform/mtk-mdp/mtk_mdp_core.c
> @@ -17,7 +17,6 @@
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/workqueue.h>
> -#include <soc/mediatek/smi.h>
>  
>  #include "mtk_mdp_core.h"
>  #include "mtk_mdp_m2m.h"



_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
