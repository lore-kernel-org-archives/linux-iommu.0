Return-Path: <SRS0=69++=LC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C935C4743D
	for <iommu@archiver.kernel.org>; Tue,  8 Jun 2021 09:41:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5A1B61263
	for <iommu@archiver.kernel.org>; Tue,  8 Jun 2021 09:41:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5A1B61263
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6B5ED40401;
	Tue,  8 Jun 2021 09:41:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rKIRsDsuCM8a; Tue,  8 Jun 2021 09:41:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id BD9604041C;
	Tue,  8 Jun 2021 09:41:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 88DBDC000B;
	Tue,  8 Jun 2021 09:41:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5592DC0001
 for <iommu@lists.linux-foundation.org>; Tue,  8 Jun 2021 09:41:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 51C1840299
 for <iommu@lists.linux-foundation.org>; Tue,  8 Jun 2021 09:41:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=mediatek.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fiT2EumCrT39 for <iommu@lists.linux-foundation.org>;
 Tue,  8 Jun 2021 09:41:08 +0000 (UTC)
X-Greylist: delayed 00:05:01 by SQLgrey-1.8.0
Received: from mailgw01.mediatek.com (unknown [1.203.163.78])
 by smtp2.osuosl.org (Postfix) with ESMTP id E14D340291
 for <iommu@lists.linux-foundation.org>; Tue,  8 Jun 2021 09:41:07 +0000 (UTC)
X-UUID: 3e9002f43fa04a4f8ece9a742ed08a52-20210608
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=+B2QImP6/+3dV4dUubTd73D2XzItTeRR9Dm1MA2u5aE=; 
 b=lTgFCwz2jqS7rYdq8AlB3TCHlmdYVfQ0e5K23qnsgpDL/GfE9uYxvDarwe84n/tdOqc+4pPW3ggd/TMZXjTqj47PX3Wzzsc7rlxFRLi19BQJ1Ur5t7c/FUfbzxPH4cRKNLijkMFxkct2KhXzDc4C3DjU99jpcG29T8yzotJNs2I=;
X-UUID: 3e9002f43fa04a4f8ece9a742ed08a52-20210608
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
 (envelope-from <houlong.wei@mediatek.com>)
 (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 1596794492; Tue, 08 Jun 2021 17:35:59 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Tue, 8 Jun 2021 17:35:54 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 8 Jun 2021 17:35:52 +0800
Message-ID: <1623144943.7079.1.camel@mhfsdcap03>
Subject: Re: [PATCH v5 08/16] media: mtk-mdp: Get rid of mtk_smi_larb_get/put
From: houlong wei <houlong.wei@mediatek.com>
To: Yong Wu <yong.wu@mediatek.com>
Date: Tue, 8 Jun 2021 17:35:43 +0800
In-Reply-To: <20210410091128.31823-9-yong.wu@mediatek.com>
References: <20210410091128.31823-1-yong.wu@mediatek.com>
 <20210410091128.31823-9-yong.wu@mediatek.com>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 73160F7F9D6C1295E7F9E9F7A0C989361B8103D51415275D79DD2191FBD6D2842000:8
X-MTK: N
Cc: Minghsiu Tsai =?UTF-8?Q?=28=E8=94=A1=E6=98=8E=E4=BF=AE=29?=
 <Minghsiu.Tsai@mediatek.com>, Will Deacon <will.deacon@arm.com>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Youlin Pei =?UTF-8?Q?=28=E8=A3=B4=E5=8F=8B=E6=9E=97=29?=
 <youlin.pei@mediatek.com>, Nicolas Boichat <drinkcat@chromium.org>,
 Evan Green <evgreen@chromium.org>, "eizan@chromium.org" <eizan@chromium.org>,
 Matthias Kaehlcke <mka@chromium.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Yi Kuo =?UTF-8?Q?=28=E9=83=AD=E6=87=BF=29?= <Yi.Kuo@mediatek.com>,
 Rob Herring <robh+dt@kernel.org>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Ming-Fan Chen =?UTF-8?Q?=28=E9=99=B3=E6=98=8E=E6=B1=8E=29?=
 <Ming-Fan.Chen@mediatek.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Anan Sun =?UTF-8?Q?=28=E5=AD=99=E5=AE=89=E5=AE=89=29?= <Anan.Sun@mediatek.com>,
 "acourbot@chromium.org" <acourbot@chromium.org>,
 srv_heupstream <srv_heupstream@mediatek.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Chao Hao =?UTF-8?Q?=28=E9=83=9D=E8=B6=85=29?= <Chao.Hao@mediatek.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
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

On Sat, 2021-04-10 at 17:11 +0800, Yong Wu wrote:
> MediaTek IOMMU has already added the device_link between the consumer
> and smi-larb device. If the mdp device call the pm_runtime_get_sync,
> the smi-larb's pm_runtime_get_sync also be called automatically.
> 
> CC: Minghsiu Tsai <minghsiu.tsai@mediatek.com>
> CC: Houlong Wei <houlong.wei@mediatek.com>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> Reviewed-by: Evan Green <evgreen@chromium.org>
> ---
>  drivers/media/platform/mtk-mdp/mtk_mdp_comp.c | 40 -------------------
>  drivers/media/platform/mtk-mdp/mtk_mdp_comp.h |  2 -
>  drivers/media/platform/mtk-mdp/mtk_mdp_core.c |  1 -
>  3 files changed, 43 deletions(-)
> 
> diff --git a/drivers/media/platform/mtk-mdp/mtk_mdp_comp.c b/drivers/media/platform/mtk-mdp/mtk_mdp_comp.c
> index b3426a551bea..1e3833f1c9ae 100644
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
> @@ -18,14 +17,6 @@ void mtk_mdp_comp_clock_on(struct device *dev, struct mtk_mdp_comp *comp)
>  {
>  	int i, err;
>  
> -	if (comp->larb_dev) {
> -		err = mtk_smi_larb_get(comp->larb_dev);
> -		if (err)
> -			dev_err(dev,
> -				"failed to get larb, err %d. type:%d\n",
> -				err, comp->type);
> -	}
> -
>  	for (i = 0; i < ARRAY_SIZE(comp->clk); i++) {
>  		if (IS_ERR(comp->clk[i]))
>  			continue;
> @@ -46,17 +37,12 @@ void mtk_mdp_comp_clock_off(struct device *dev, struct mtk_mdp_comp *comp)
>  			continue;
>  		clk_disable_unprepare(comp->clk[i]);
>  	}
> -
> -	if (comp->larb_dev)
> -		mtk_smi_larb_put(comp->larb_dev);
>  }
>  
>  int mtk_mdp_comp_init(struct device *dev, struct device_node *node,
>  		      struct mtk_mdp_comp *comp,
>  		      enum mtk_mdp_comp_type comp_type)
>  {
> -	struct device_node *larb_node;
> -	struct platform_device *larb_pdev;
>  	int ret;
>  	int i;
>  
> @@ -77,32 +63,6 @@ int mtk_mdp_comp_init(struct device *dev, struct device_node *node,
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
> -		ret = -EINVAL;
> -		goto put_dev;
> -	}
> -
> -	larb_pdev = of_find_device_by_node(larb_node);
> -	if (!larb_pdev) {
> -		dev_warn(dev, "Waiting for larb device %pOF\n", larb_node);
> -		of_node_put(larb_node);
> -		ret = -EPROBE_DEFER;
> -		goto put_dev;
> -	}
> -	of_node_put(larb_node);
> -
> -	comp->larb_dev = &larb_pdev->dev;
> -
>  	return 0;
>  
>  put_dev:
> diff --git a/drivers/media/platform/mtk-mdp/mtk_mdp_comp.h b/drivers/media/platform/mtk-mdp/mtk_mdp_comp.h
> index 1bf0242cce46..36bc1b8f6222 100644
> --- a/drivers/media/platform/mtk-mdp/mtk_mdp_comp.h
> +++ b/drivers/media/platform/mtk-mdp/mtk_mdp_comp.h
> @@ -27,14 +27,12 @@ enum mtk_mdp_comp_type {
>   * @node:	list node to track sibing MDP components
>   * @dev_node:	component device node
>   * @clk:	clocks required for component
> - * @larb_dev:	SMI device required for component
>   * @type:	component type
>   */
>  struct mtk_mdp_comp {
>  	struct list_head	node;
>  	struct device_node	*dev_node;
>  	struct clk		*clk[2];
> -	struct device		*larb_dev;
>  	enum mtk_mdp_comp_type	type;
>  };
>  
> diff --git a/drivers/media/platform/mtk-mdp/mtk_mdp_core.c b/drivers/media/platform/mtk-mdp/mtk_mdp_core.c
> index 976aa1f4829b..70a8eab16863 100644
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

Reviewed-by: Houlong Wei <houlong.wei@mediatek.com>

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
