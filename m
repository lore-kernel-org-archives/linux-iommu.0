Return-Path: <SRS0=i+j8=MG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C95FC07E9A
	for <iommu@archiver.kernel.org>; Wed, 14 Jul 2021 08:29:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6346F613AF
	for <iommu@archiver.kernel.org>; Wed, 14 Jul 2021 08:29:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6346F613AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 358724053F;
	Wed, 14 Jul 2021 08:29:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tgkmMgqhWb0p; Wed, 14 Jul 2021 08:29:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B643F403B8;
	Wed, 14 Jul 2021 08:29:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 88311C001A;
	Wed, 14 Jul 2021 08:29:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 415FDC000E
 for <iommu@lists.linux-foundation.org>; Wed, 14 Jul 2021 08:29:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2279B83BAE
 for <iommu@lists.linux-foundation.org>; Wed, 14 Jul 2021 08:29:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 54J3MjNiTZzg for <iommu@lists.linux-foundation.org>;
 Wed, 14 Jul 2021 08:29:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 380D383B02
 for <iommu@lists.linux-foundation.org>; Wed, 14 Jul 2021 08:29:15 +0000 (UTC)
Received: from [IPv6:2a02:810a:880:f54:e49e:3ed0:1a77:5623] (unknown
 [IPv6:2a02:810a:880:f54:e49e:3ed0:1a77:5623])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: dafna)
 by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 3997C1F42822;
 Wed, 14 Jul 2021 09:29:12 +0100 (BST)
Subject: Re: [PATCH v6 05/11] media: mtk-mdp: Get rid of mtk_smi_larb_get/put
To: Yong Wu <yong.wu@mediatek.com>, Matthias Brugger
 <matthias.bgg@gmail.com>, Joerg Roedel <joro@8bytes.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
 David Airlie <airlied@linux.ie>, Mauro Carvalho Chehab <mchehab@kernel.org>
References: <20210714025626.5528-1-yong.wu@mediatek.com>
 <20210714025626.5528-6-yong.wu@mediatek.com>
From: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
Message-ID: <f8d2ecfa-d0e0-87ed-429a-cb2dfd4e0745@collabora.com>
Date: Wed, 14 Jul 2021 10:29:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210714025626.5528-6-yong.wu@mediatek.com>
Content-Language: en-US
Cc: Xia Jiang <xia.jiang@mediatek.com>,
 Minghsiu Tsai <minghsiu.tsai@mediatek.com>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>, Will Deacon <will.deacon@arm.com>,
 dri-devel@lists.freedesktop.org, anthony.huang@mediatek.com,
 youlin.pei@mediatek.com, Nicolas Boichat <drinkcat@chromium.org>,
 Evan Green <evgreen@chromium.org>, Eizan Miyamoto <eizan@chromium.org>,
 Matthias Kaehlcke <mka@chromium.org>, linux-media@vger.kernel.org,
 devicetree@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>,
 Houlong Wei <houlong.wei@mediatek.com>, yi.kuo@mediatek.com,
 linux-mediatek@lists.infradead.org, Hsin-Yi Wang <hsinyi@chromium.org>,
 ming-fan.chen@mediatek.com, Tiffany Lin <tiffany.lin@mediatek.com>,
 linux-arm-kernel@lists.infradead.org, anan.sun@mediatek.com,
 srv_heupstream@mediatek.com, acourbot@chromium.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Daniel Vetter <daniel@ffwll.ch>, Robin Murphy <robin.murphy@arm.com>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>



On 14.07.21 04:56, Yong Wu wrote:
> MediaTek IOMMU has already added the device_link between the consumer
> and smi-larb device. If the mdp device call the pm_runtime_get_sync,
> the smi-larb's pm_runtime_get_sync also be called automatically.
> 
> CC: Minghsiu Tsai <minghsiu.tsai@mediatek.com>
> CC: Houlong Wei <houlong.wei@mediatek.com>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> Reviewed-by: Evan Green <evgreen@chromium.org>
> Reviewed-by: Houlong Wei <houlong.wei@mediatek.com>

Reviewed-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>

> ---
>   drivers/media/platform/mtk-mdp/mtk_mdp_comp.c | 46 +------------------
>   drivers/media/platform/mtk-mdp/mtk_mdp_comp.h |  2 -
>   drivers/media/platform/mtk-mdp/mtk_mdp_core.c |  1 -
>   3 files changed, 1 insertion(+), 48 deletions(-)
> 
> diff --git a/drivers/media/platform/mtk-mdp/mtk_mdp_comp.c b/drivers/media/platform/mtk-mdp/mtk_mdp_comp.c
> index de2d425efdd1..5e0ea83a9f7f 100644
> --- a/drivers/media/platform/mtk-mdp/mtk_mdp_comp.c
> +++ b/drivers/media/platform/mtk-mdp/mtk_mdp_comp.c
> @@ -13,7 +13,6 @@
>   #include <linux/of.h>
>   #include <linux/of_irq.h>
>   #include <linux/of_platform.h>
> -#include <soc/mediatek/smi.h>
>   #include <linux/pm_runtime.h>
>   
>   #include "mtk_mdp_comp.h"
> @@ -57,13 +56,6 @@ int mtk_mdp_comp_power_on(struct mtk_mdp_comp *comp)
>   {
>   	int status, err;
>   
> -	if (comp->larb_dev) {
> -		err = mtk_smi_larb_get(comp->larb_dev);
> -		if (err)
> -			dev_err(comp->dev,
> -				"failed to get larb, err %d.\n", err);
> -	}
> -
>   	err = pm_runtime_get_sync(comp->dev);
>   	if (err < 0) {
>   		dev_err(comp->dev, "failed to runtime get, err %d.\n", err);
> @@ -146,9 +138,6 @@ void mtk_mdp_comp_clock_off(struct mtk_mdp_comp *comp)
>   			continue;
>   		clk_disable_unprepare(comp->clk[i]);
>   	}
> -
> -	if (comp->larb_dev)
> -		mtk_smi_larb_put(comp->larb_dev);
>   }
>   
>   /*
> @@ -236,9 +225,6 @@ static const struct component_ops mtk_mdp_component_ops = {
>   
>   int mtk_mdp_comp_init(struct mtk_mdp_comp *comp, struct device *dev)
>   {
> -	struct device_node *larb_node;
> -	struct platform_device *larb_pdev;
> -	int ret;
>   	int i;
>   	struct device_node *node = dev->of_node;
>   	enum mtk_mdp_comp_type comp_type =
> @@ -252,8 +238,7 @@ int mtk_mdp_comp_init(struct mtk_mdp_comp *comp, struct device *dev)
>   		if (IS_ERR(comp->clk[i])) {
>   			if (PTR_ERR(comp->clk[i]) != -EPROBE_DEFER)
>   				dev_err(dev, "Failed to get clock\n");
> -			ret = PTR_ERR(comp->clk[i]);
> -			goto err;
> +			return PTR_ERR(comp->clk[i]);
>   		}
>   
>   		/* Only RDMA needs two clocks */
> @@ -261,36 +246,7 @@ int mtk_mdp_comp_init(struct mtk_mdp_comp *comp, struct device *dev)
>   			break;
>   	}
>   
> -	/* Only DMA capable components need the LARB property */
> -	comp->larb_dev = NULL;
> -	if (comp_type != MTK_MDP_RDMA &&
> -	    comp_type != MTK_MDP_WDMA &&
> -	    comp_type != MTK_MDP_WROT)
> -		return 0;
> -
> -	larb_node = of_parse_phandle(node, "mediatek,larb", 0);
> -	if (!larb_node) {
> -		dev_err(dev,
> -			"Missing mediadek,larb phandle in %pOF node\n", node);
> -		ret = -EINVAL;
> -		goto err;
> -	}
> -
> -	larb_pdev = of_find_device_by_node(larb_node);
> -	if (!larb_pdev) {
> -		dev_warn(dev, "Waiting for larb device %pOF\n", larb_node);
> -		of_node_put(larb_node);
> -		ret = -EPROBE_DEFER;
> -		goto err;
> -	}
> -	of_node_put(larb_node);
> -
> -	comp->larb_dev = &larb_pdev->dev;
> -
>   	return 0;
> -
> -err:
> -	return ret;
>   }
>   
>   static int mtk_mdp_comp_probe(struct platform_device *pdev)
> diff --git a/drivers/media/platform/mtk-mdp/mtk_mdp_comp.h b/drivers/media/platform/mtk-mdp/mtk_mdp_comp.h
> index 5201c47f7baa..2bd229cc7eae 100644
> --- a/drivers/media/platform/mtk-mdp/mtk_mdp_comp.h
> +++ b/drivers/media/platform/mtk-mdp/mtk_mdp_comp.h
> @@ -11,13 +11,11 @@
>    * struct mtk_mdp_comp - the MDP's function component data
>    * @node:	list node to track sibing MDP components
>    * @clk:	clocks required for component
> - * @larb_dev:	SMI device required for component
>    * @dev:	component's device
>    */
>   struct mtk_mdp_comp {
>   	struct list_head	node;
>   	struct clk		*clk[2];
> -	struct device           *larb_dev;
>   	struct device		*dev;
>   };
>   
> diff --git a/drivers/media/platform/mtk-mdp/mtk_mdp_core.c b/drivers/media/platform/mtk-mdp/mtk_mdp_core.c
> index e1fb39231248..be7d35b3e3ff 100644
> --- a/drivers/media/platform/mtk-mdp/mtk_mdp_core.c
> +++ b/drivers/media/platform/mtk-mdp/mtk_mdp_core.c
> @@ -18,7 +18,6 @@
>   #include <linux/platform_device.h>
>   #include <linux/pm_runtime.h>
>   #include <linux/workqueue.h>
> -#include <soc/mediatek/smi.h>
>   
>   #include "mtk_mdp_comp.h"
>   #include "mtk_mdp_core.h"
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
