Return-Path: <SRS0=CJHf=KH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AECCC433ED
	for <iommu@archiver.kernel.org>; Wed, 12 May 2021 09:26:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71358611C9
	for <iommu@archiver.kernel.org>; Wed, 12 May 2021 09:26:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71358611C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2AC0E60A3B;
	Wed, 12 May 2021 09:26:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dImy-1qDVMxX; Wed, 12 May 2021 09:26:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id BA165608E4;
	Wed, 12 May 2021 09:26:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8E3CAC000E;
	Wed, 12 May 2021 09:26:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8EF58C0001
 for <iommu@lists.linux-foundation.org>; Wed, 12 May 2021 09:20:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7C9FD83B72
 for <iommu@lists.linux-foundation.org>; Wed, 12 May 2021 09:20:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=chromium.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3vSafPRHTWXG for <iommu@lists.linux-foundation.org>;
 Wed, 12 May 2021 09:20:30 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com
 [IPv6:2607:f8b0:4864:20::d2f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 81C4C83B66
 for <iommu@lists.linux-foundation.org>; Wed, 12 May 2021 09:20:30 +0000 (UTC)
Received: by mail-io1-xd2f.google.com with SMTP id l21so20975240iob.1
 for <iommu@lists.linux-foundation.org>; Wed, 12 May 2021 02:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Rw5bi1SAPL1hZNfoVXmGUyA3xV1P1F1OYsNK09HU+a0=;
 b=gqYpnE/lrAatuhlH0xLuX+Ye+d+UxsP6NP14t+2gblbyF65xPmr1mYDmqPtUIsIL8Z
 NGqT2siml8zsT/+GjnMinVr2ht+4InfIycF46nZ481jEqCxSMP3FE3k8hVRTkZ2fA2Ih
 Zpp3c+EoX6nY//nNe6CT2pzwKdFA+JivEzM40=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Rw5bi1SAPL1hZNfoVXmGUyA3xV1P1F1OYsNK09HU+a0=;
 b=W3w/3uC+6/ZpmaYzvcqlLHmPEpWDRos8GPC3u+kSWsdOZKRbvrx9XQdD/FNYYTNp4q
 kfq2cOj9N0LjXnKZPlRT0gWE5nuQcbodQzYLPtXoQ91bKbUDmB0vGzhwMI5YlU7qWb8F
 ExGAWQQjYOAZqCvr9726UsyZOv47LqC+ID+ToW31WufK9vgMT77H+c/IH/1TjfWQz1Lr
 CWTpXWGW0LhTokDS+pRMIvlGGr0JDHsG1k2SWMEtUrlrFehRt5/dHySjawNbCX6ZghqO
 F9SpVXgnlgnp20gZ2vhbV0d0IDqO+gREfyZFlMIRgxb3DjXMK4fUzwr6KtMDYSbyK5pU
 JZWw==
X-Gm-Message-State: AOAM530+bvyAmzEwmrZjW5sTr3rKNp7eKWmOQMgEiCs0gINt17v0gsJE
 CmpWYwDQ8P1ZyG6LdQQuTbmgS71jb+aEoymMPkfEcw==
X-Google-Smtp-Source: ABdhPJz4D4taavm63iD2SKLxbMnILL72N/Np1EaOYKVanFw2BuKIj5CwmD6/ksD8F9i292URXw+KTxWjgrqcMFmbXfE=
X-Received: by 2002:a6b:f815:: with SMTP id o21mr24594979ioh.0.1620811229435; 
 Wed, 12 May 2021 02:20:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210410091128.31823-1-yong.wu@mediatek.com>
 <20210410091128.31823-14-yong.wu@mediatek.com>
In-Reply-To: <20210410091128.31823-14-yong.wu@mediatek.com>
From: Hsin-Yi Wang <hsinyi@chromium.org>
Date: Wed, 12 May 2021 17:20:03 +0800
Message-ID: <CAJMQK-iTrQRDDm_=LNqSpvXFd431LYRxXMasJHUpN+K8rJ=Qpg@mail.gmail.com>
Subject: Re: [PATCH v5 13/16] media: mtk-vcodec: Get rid of
 mtk_smi_larb_get/put
To: Yong Wu <yong.wu@mediatek.com>
X-Mailman-Approved-At: Wed, 12 May 2021 09:26:31 +0000
Cc: Will Deacon <will.deacon@arm.com>, Krzysztof Kozlowski <krzk@kernel.org>,
 youlin.pei@mediatek.com, Irui Wang <irui.wang@mediatek.com>,
 Nicolas Boichat <drinkcat@chromium.org>, Evan Green <evgreen@chromium.org>,
 eizan@chromium.org, Matthias Kaehlcke <mka@chromium.org>,
 Devicetree List <devicetree@vger.kernel.org>, yi.kuo@mediatek.com,
 Rob Herring <robh+dt@kernel.org>,
 "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, ming-fan.chen@mediatek.com,
 Tiffany Lin <tiffany.lin@mediatek.com>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>, anan.sun@mediatek.com,
 Alexandre Courbot <acourbot@chromium.org>, srv_heupstream@mediatek.com,
 lkml <linux-kernel@vger.kernel.org>, chao.hao@mediatek.com,
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

On Sat, Apr 10, 2021 at 5:14 PM Yong Wu <yong.wu@mediatek.com> wrote:
>
> MediaTek IOMMU has already added the device_link between the consumer
> and smi-larb device. If the vcodec device call the pm_runtime_get_sync,
> the smi-larb's pm_runtime_get_sync also be called automatically.
>
> CC: Tiffany Lin <tiffany.lin@mediatek.com>
> CC: Irui Wang <irui.wang@mediatek.com>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> Reviewed-by: Evan Green <evgreen@chromium.org>
> Acked-by: Tiffany Lin <tiffany.lin@mediatek.com>
> ---
>  .../platform/mtk-vcodec/mtk_vcodec_dec_pm.c   | 37 ++-------------
>  .../platform/mtk-vcodec/mtk_vcodec_drv.h      |  3 --
>  .../platform/mtk-vcodec/mtk_vcodec_enc.c      |  1 -
>  .../platform/mtk-vcodec/mtk_vcodec_enc_pm.c   | 46 ++-----------------
>  4 files changed, 10 insertions(+), 77 deletions(-)
>
> diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_pm.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_pm.c
> index 32e1858e9f1d..2b3562e47f4f 100644
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
> -       struct device_node *node;
>         struct platform_device *pdev;
>         struct mtk_vcodec_pm *pm;
>         struct mtk_vcodec_clk *dec_clk;
> @@ -26,18 +24,7 @@ int mtk_vcodec_init_dec_pm(struct mtk_vcodec_dev *mtkdev)
>         pm = &mtkdev->pm;
>         pm->mtkdev = mtkdev;
>         dec_clk = &pm->vdec_clk;
> -       node = of_parse_phandle(pdev->dev.of_node, "mediatek,larb", 0);
> -       if (!node) {
> -               mtk_v4l2_err("of_parse_phandle mediatek,larb fail!");
> -               return -1;
> -       }
>
> -       pdev = of_find_device_by_node(node);
> -       of_node_put(node);
> -       if (WARN_ON(!pdev)) {
> -               return -1;
> -       }
> -       pm->larbvdec = &pdev->dev;
>         pdev = mtkdev->plat_dev;
>         pm->dev = &pdev->dev;
>
> @@ -47,14 +34,11 @@ int mtk_vcodec_init_dec_pm(struct mtk_vcodec_dev *mtkdev)
>                 dec_clk->clk_info = devm_kcalloc(&pdev->dev,
>                         dec_clk->clk_num, sizeof(*clk_info),
>                         GFP_KERNEL);
> -               if (!dec_clk->clk_info) {
> -                       ret = -ENOMEM;
> -                       goto put_device;
> -               }
> +               if (!dec_clk->clk_info)
> +                       return -ENOMEM;
>         } else {
>                 mtk_v4l2_err("Failed to get vdec clock count");
> -               ret = -EINVAL;
> -               goto put_device;
> +               return -EINVAL;
>         }
>
>         for (i = 0; i < dec_clk->clk_num; i++) {
> @@ -63,29 +47,24 @@ int mtk_vcodec_init_dec_pm(struct mtk_vcodec_dev *mtkdev)
>                         "clock-names", i, &clk_info->clk_name);
>                 if (ret) {
>                         mtk_v4l2_err("Failed to get clock name id = %d", i);
> -                       goto put_device;
> +                       return ret;
>                 }
>                 clk_info->vcodec_clk = devm_clk_get(&pdev->dev,
>                         clk_info->clk_name);
>                 if (IS_ERR(clk_info->vcodec_clk)) {
>                         mtk_v4l2_err("devm_clk_get (%d)%s fail", i,
>                                 clk_info->clk_name);
> -                       ret = PTR_ERR(clk_info->vcodec_clk);
> -                       goto put_device;
> +                       return PTR_ERR(clk_info->vcodec_clk);
>                 }
>         }
>
>         pm_runtime_enable(&pdev->dev);
>         return 0;
> -put_device:
> -       put_device(pm->larbvdec);
> -       return ret;
>  }
>
>  void mtk_vcodec_release_dec_pm(struct mtk_vcodec_dev *dev)
>  {
>         pm_runtime_disable(dev->pm.dev);
> -       put_device(dev->pm.larbvdec);
>  }
>
>  void mtk_vcodec_dec_pw_on(struct mtk_vcodec_pm *pm)
> @@ -121,11 +100,6 @@ void mtk_vcodec_dec_clock_on(struct mtk_vcodec_pm *pm)
>                 }
>         }
>
> -       ret = mtk_smi_larb_get(pm->larbvdec);
> -       if (ret) {
> -               mtk_v4l2_err("mtk_smi_larb_get larbvdec fail %d", ret);
> -               goto error;
> -       }
>         return;
>
>  error:
> @@ -138,7 +112,6 @@ void mtk_vcodec_dec_clock_off(struct mtk_vcodec_pm *pm)
>         struct mtk_vcodec_clk *dec_clk = &pm->vdec_clk;
>         int i = 0;
>
> -       mtk_smi_larb_put(pm->larbvdec);
>         for (i = dec_clk->clk_num - 1; i >= 0; i--)
>                 clk_disable_unprepare(dec_clk->clk_info[i].vcodec_clk);
>  }
> diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_drv.h b/drivers/media/platform/mtk-vcodec/mtk_vcodec_drv.h
> index 869d958d2b99..659790398809 100644
> --- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_drv.h
> +++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_drv.h
> @@ -189,10 +189,7 @@ struct mtk_vcodec_clk {
>   */
>  struct mtk_vcodec_pm {
>         struct mtk_vcodec_clk   vdec_clk;
> -       struct device   *larbvdec;
> -
>         struct mtk_vcodec_clk   venc_clk;
> -       struct device   *larbvenc;
>         struct device   *dev;
>         struct mtk_vcodec_dev   *mtkdev;
>  };
> diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c
> index 4831052f475d..59816981735b 100644
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
> index 1b2e4930ed27..78b99ff882ae 100644
> --- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_pm.c
> +++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_pm.c
> @@ -8,58 +8,36 @@
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
> -       struct device_node *node;
>         struct platform_device *pdev;
>         struct mtk_vcodec_pm *pm;
>         struct mtk_vcodec_clk *enc_clk;
>         struct mtk_vcodec_clk_info *clk_info;
>         int ret = 0, i = 0;
> -       struct device *dev;
>
>         pdev = mtkdev->plat_dev;
>         pm = &mtkdev->pm;
>         memset(pm, 0, sizeof(struct mtk_vcodec_pm));
>         pm->mtkdev = mtkdev;
>         pm->dev = &pdev->dev;
> -       dev = &pdev->dev;
>         enc_clk = &pm->venc_clk;
>
> -       node = of_parse_phandle(dev->of_node, "mediatek,larb", 0);
> -       if (!node) {
> -               mtk_v4l2_err("no mediatek,larb found");
> -               return -ENODEV;
> -       }
> -       pdev = of_find_device_by_node(node);
> -       of_node_put(node);
> -       if (!pdev) {
> -               mtk_v4l2_err("no mediatek,larb device found");
> -               return -ENODEV;
> -       }
> -       pm->larbvenc = &pdev->dev;
> -       pdev = mtkdev->plat_dev;
> -       pm->dev = &pdev->dev;
> -
>         enc_clk->clk_num = of_property_count_strings(pdev->dev.of_node,
>                 "clock-names");
>         if (enc_clk->clk_num > 0) {
>                 enc_clk->clk_info = devm_kcalloc(&pdev->dev,
>                         enc_clk->clk_num, sizeof(*clk_info),
>                         GFP_KERNEL);
> -               if (!enc_clk->clk_info) {
> -                       ret = -ENOMEM;
> -                       goto put_larbvenc;
> -               }
> +               if (!enc_clk->clk_info)
> +                       return -ENOMEM;
>         } else {
>                 mtk_v4l2_err("Failed to get venc clock count");
> -               ret = -EINVAL;
> -               goto put_larbvenc;
> +               return -EINVAL;
>         }
>
>         for (i = 0; i < enc_clk->clk_num; i++) {
> @@ -68,29 +46,23 @@ int mtk_vcodec_init_enc_pm(struct mtk_vcodec_dev *mtkdev)
>                         "clock-names", i, &clk_info->clk_name);
>                 if (ret) {
>                         mtk_v4l2_err("venc failed to get clk name %d", i);
> -                       goto put_larbvenc;
> +                       return ret;
>                 }
>                 clk_info->vcodec_clk = devm_clk_get(&pdev->dev,
>                         clk_info->clk_name);
>                 if (IS_ERR(clk_info->vcodec_clk)) {
>                         mtk_v4l2_err("venc devm_clk_get (%d)%s fail", i,
>                                 clk_info->clk_name);
> -                       ret = PTR_ERR(clk_info->vcodec_clk);
> -                       goto put_larbvenc;
> +                       return PTR_ERR(clk_info->vcodec_clk);
>                 }
>         }
>
>         return 0;
> -
> -put_larbvenc:
> -       put_device(pm->larbvenc);
> -       return ret;
>  }
>
>  void mtk_vcodec_release_enc_pm(struct mtk_vcodec_dev *mtkdev)
>  {
>         pm_runtime_disable(mtkdev->pm.dev);
> -       put_device(mtkdev->pm.larbvenc);
>  }
>
>
> @@ -108,13 +80,6 @@ void mtk_vcodec_enc_clock_on(struct mtk_vcodec_pm *pm)
>                 }
>         }
>
> -       ret = mtk_smi_larb_get(pm->larbvenc);
> -       if (ret) {
> -               mtk_v4l2_err("mtk_smi_larb_get larb3 fail %d", ret);
> -               goto clkerr;
> -       }
> -       return;

You can't delete the return; here, otherwise vcodec_clk will be turned
off immediately after they are turned on.

> -
>  clkerr:
>         for (i -= 1; i >= 0; i--)
>                 clk_disable_unprepare(enc_clk->clk_info[i].vcodec_clk);
> @@ -125,7 +90,6 @@ void mtk_vcodec_enc_clock_off(struct mtk_vcodec_pm *pm)
>         struct mtk_vcodec_clk *enc_clk = &pm->venc_clk;
>         int i = 0;
>
> -       mtk_smi_larb_put(pm->larbvenc);
>         for (i = enc_clk->clk_num - 1; i >= 0; i--)
>                 clk_disable_unprepare(enc_clk->clk_info[i].vcodec_clk);
>  }
> --
> 2.18.0
>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
