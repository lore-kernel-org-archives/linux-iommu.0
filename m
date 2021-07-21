Return-Path: <SRS0=85So=MN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 151CDC636CE
	for <iommu@archiver.kernel.org>; Wed, 21 Jul 2021 10:54:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD6CF6124C
	for <iommu@archiver.kernel.org>; Wed, 21 Jul 2021 10:54:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD6CF6124C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7F5B4401C9;
	Wed, 21 Jul 2021 10:54:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3Ei9tXatvjVS; Wed, 21 Jul 2021 10:54:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id BE01140303;
	Wed, 21 Jul 2021 10:53:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B004BC0027;
	Wed, 21 Jul 2021 10:53:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2760AC000E
 for <iommu@lists.linux-foundation.org>; Wed, 21 Jul 2021 10:44:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 15626606C6
 for <iommu@lists.linux-foundation.org>; Wed, 21 Jul 2021 10:44:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=chromium.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id B12Aflsjxpuz for <iommu@lists.linux-foundation.org>;
 Wed, 21 Jul 2021 10:44:49 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D78B1605DA
 for <iommu@lists.linux-foundation.org>; Wed, 21 Jul 2021 10:44:49 +0000 (UTC)
Received: by mail-pj1-x102a.google.com with SMTP id
 g4-20020a17090ace84b029017554809f35so3738582pju.5
 for <iommu@lists.linux-foundation.org>; Wed, 21 Jul 2021 03:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=m9KfU32Td3xB/wuWNhNbDVpIahkZHa5eXkr6/E8GaKE=;
 b=he/bvGRxDLSF7f0GBNdzXYHRkkjCsYcba5AlfCdmFGNOSPALoTInP/YKKXJkwF2DPu
 90L1sVjKnum25CXgGjAHi/E3U9XJXUxXyt6f2VlovfiI7NI4CGfsdLzyn12fuW0W5d4g
 xlb3wCH4NBfE83xkTJy7oGw7zBhZkEwfYc3Lw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=m9KfU32Td3xB/wuWNhNbDVpIahkZHa5eXkr6/E8GaKE=;
 b=py5q1ll9sANqDNOHRAyHQmtlY3Q+13OA7W22Fem0hQk6W+j1DQuBVDLwEu0v/EG5QU
 L8Be4QDF4LzJzfvI2G0byGxwfGobnbiymIlhWE0TVOzpiSQG4UchzSLKuu0h2HfETXmv
 +Q89yYyl0MwFfJG8+WglkM99DOG6c+evmJXNS/BGnMRHP0wrgNsYOwB561NeYQ0e1lG9
 S/oxv17Squugm0OPJYmhyHISRtGPEO9ftfGQ/kYuXHmc+zSll+jTXPFicN7yLyPc5BYg
 ck5/Qa0ZG+dCyg7B1BecITvgOSRfdZrmIsaYtzAm6sJ4y9g25BFdP8Sy1bO0TKfwBRJF
 yDHw==
X-Gm-Message-State: AOAM5321kILJde6Hrn1YsQ9Nfg/izyaFI85SQ3QLRzpqDPyK7laEVHgn
 Y9Ant4SpJBahFOR2TInrY7R5W/oa3jPM+tR0ZUduLg==
X-Google-Smtp-Source: ABdhPJwMQyEj40wDyMHpYAAPz6Zr7HtqGIr3IjYBKZh75hmdijcf7C1xGMIP2NE1ifwpN1NaVPhToI/+eV5K9Fo7Ztc=
X-Received: by 2002:a17:902:8c83:b029:129:17e5:a1cc with SMTP id
 t3-20020a1709028c83b029012917e5a1ccmr27210970plo.49.1626864289274; Wed, 21
 Jul 2021 03:44:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210715121209.31024-1-yong.wu@mediatek.com>
 <20210715121209.31024-6-yong.wu@mediatek.com>
In-Reply-To: <20210715121209.31024-6-yong.wu@mediatek.com>
From: Ikjoon Jang <ikjn@chromium.org>
Date: Wed, 21 Jul 2021 18:44:37 +0800
Message-ID: <CAATdQgB4P=7Wvhc_SBxy1tGKRXD7qukc95bGNJJ=ECyVm_dgHQ@mail.gmail.com>
Subject: Re: [PATCH v2 05/11] memory: mtk-smi: Adjust some code position
To: Yong Wu <yong.wu@mediatek.com>
X-Mailman-Approved-At: Wed, 21 Jul 2021 10:53:57 +0000
Cc: youlin.pei@mediatek.com,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, yi.kuo@mediatek.com,
 srv_heupstream <srv_heupstream@mediatek.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
 Robin Murphy <robin.murphy@arm.com>, open list <linux-kernel@vger.kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>, iommu@lists.linux-foundation.org,
 Rob Herring <robh+dt@kernel.org>,
 "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, anthony.huang@mediatek.com,
 ming-fan.chen@mediatek.com, anan.sun@mediatek.com,
 Will Deacon <will@kernel.org>, "moderated list:ARM/Mediatek SoC support"
 <linux-arm-kernel@lists.infradead.org>
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

Hi,

On Thu, Jul 15, 2021 at 8:23 PM Yong Wu <yong.wu@mediatek.com> wrote:
>
> No functional change. Only move the code position to make the code more
> readable.
> 1. Put the register smi-common above smi-larb. Prepare to add some others
>    register setting.
> 2. Put mtk_smi_larb_unbind around larb_bind.
> 3. Sort the SoC data alphabetically. and put them in one line as the
>    current kernel allow it.
>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>

Reviewed-by: Ikjoon Jang <ikjn@chromium.org>

> ---
>  drivers/memory/mtk-smi.c | 185 +++++++++++++++------------------------
>  1 file changed, 73 insertions(+), 112 deletions(-)
>
> diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
> index ff07b14bcd66..6f8e582bace5 100644
> --- a/drivers/memory/mtk-smi.c
> +++ b/drivers/memory/mtk-smi.c
> @@ -17,12 +17,15 @@
>  #include <dt-bindings/memory/mt2701-larb-port.h>
>  #include <dt-bindings/memory/mtk-memory-port.h>
>
> -/* mt8173 */
> -#define SMI_LARB_MMU_EN                0xf00
> +/* SMI COMMON */
> +#define SMI_BUS_SEL                    0x220
> +#define SMI_BUS_LARB_SHIFT(larbid)     ((larbid) << 1)
> +/* All are MMU0 defaultly. Only specialize mmu1 here. */
> +#define F_MMU1_LARB(larbid)            (0x1 << SMI_BUS_LARB_SHIFT(larbid))
>
> -/* mt8167 */
> -#define MT8167_SMI_LARB_MMU_EN 0xfc0
> +/* SMI LARB */
>
> +/* Below are about mmu enable registers, they are different in SoCs */
>  /* mt2701 */
>  #define REG_SMI_SECUR_CON_BASE         0x5c0
>
> @@ -41,20 +44,20 @@
>  /* mt2701 domain should be set to 3 */
>  #define SMI_SECUR_CON_VAL_DOMAIN(id)   (0x3 << ((((id) & 0x7) << 2) + 1))
>
> -/* mt2712 */
> -#define SMI_LARB_NONSEC_CON(id)        (0x380 + ((id) * 4))
> -#define F_MMU_EN               BIT(0)
> -#define BANK_SEL(id)           ({                      \
> +/* mt8167 */
> +#define MT8167_SMI_LARB_MMU_EN         0xfc0
> +
> +/* mt8173 */
> +#define MT8173_SMI_LARB_MMU_EN         0xf00
> +
> +/* larb gen2 */
> +#define SMI_LARB_NONSEC_CON(id)                (0x380 + ((id) * 4))
> +#define F_MMU_EN                       BIT(0)
> +#define BANK_SEL(id)                   ({              \
>         u32 _id = (id) & 0x3;                           \
>         (_id << 8 | _id << 10 | _id << 12 | _id << 14); \
>  })
>
> -/* SMI COMMON */
> -#define SMI_BUS_SEL                    0x220
> -#define SMI_BUS_LARB_SHIFT(larbid)     ((larbid) << 1)
> -/* All are MMU0 defaultly. Only specialize mmu1 here. */
> -#define F_MMU1_LARB(larbid)            (0x1 << SMI_BUS_LARB_SHIFT(larbid))
> -
>  enum mtk_smi_type {
>         MTK_SMI_GEN1,
>         MTK_SMI_GEN2
> @@ -132,36 +135,16 @@ mtk_smi_larb_bind(struct device *dev, struct device *master, void *data)
>         return -ENODEV;
>  }
>
> -static void mtk_smi_larb_config_port_gen2_general(struct device *dev)
> -{
> -       struct mtk_smi_larb *larb = dev_get_drvdata(dev);
> -       u32 reg;
> -       int i;
> -
> -       if (BIT(larb->larbid) & larb->larb_gen->larb_direct_to_common_mask)
> -               return;
> -
> -       for_each_set_bit(i, (unsigned long *)larb->mmu, 32) {
> -               reg = readl_relaxed(larb->base + SMI_LARB_NONSEC_CON(i));
> -               reg |= F_MMU_EN;
> -               reg |= BANK_SEL(larb->bank[i]);
> -               writel(reg, larb->base + SMI_LARB_NONSEC_CON(i));
> -       }
> -}
> -
> -static void mtk_smi_larb_config_port_mt8173(struct device *dev)
> +static void
> +mtk_smi_larb_unbind(struct device *dev, struct device *master, void *data)
>  {
> -       struct mtk_smi_larb *larb = dev_get_drvdata(dev);
> -
> -       writel(*larb->mmu, larb->base + SMI_LARB_MMU_EN);
> +       /* Do nothing as the iommu is always enabled. */
>  }
>
> -static void mtk_smi_larb_config_port_mt8167(struct device *dev)
> -{
> -       struct mtk_smi_larb *larb = dev_get_drvdata(dev);
> -
> -       writel(*larb->mmu, larb->base + MT8167_SMI_LARB_MMU_EN);
> -}
> +static const struct component_ops mtk_smi_larb_component_ops = {
> +       .bind = mtk_smi_larb_bind,
> +       .unbind = mtk_smi_larb_unbind,
> +};
>
>  static void mtk_smi_larb_config_port_gen1(struct device *dev)
>  {
> @@ -194,26 +177,36 @@ static void mtk_smi_larb_config_port_gen1(struct device *dev)
>         }
>  }
>
> -static void
> -mtk_smi_larb_unbind(struct device *dev, struct device *master, void *data)
> +static void mtk_smi_larb_config_port_mt8167(struct device *dev)
>  {
> -       /* Do nothing as the iommu is always enabled. */
> +       struct mtk_smi_larb *larb = dev_get_drvdata(dev);
> +
> +       writel(*larb->mmu, larb->base + MT8167_SMI_LARB_MMU_EN);
>  }
>
> -static const struct component_ops mtk_smi_larb_component_ops = {
> -       .bind = mtk_smi_larb_bind,
> -       .unbind = mtk_smi_larb_unbind,
> -};
> +static void mtk_smi_larb_config_port_mt8173(struct device *dev)
> +{
> +       struct mtk_smi_larb *larb = dev_get_drvdata(dev);
>
> -static const struct mtk_smi_larb_gen mtk_smi_larb_mt8173 = {
> -       /* mt8173 do not need the port in larb */
> -       .config_port = mtk_smi_larb_config_port_mt8173,
> -};
> +       writel(*larb->mmu, larb->base + MT8173_SMI_LARB_MMU_EN);
> +}
>
> -static const struct mtk_smi_larb_gen mtk_smi_larb_mt8167 = {
> -       /* mt8167 do not need the port in larb */
> -       .config_port = mtk_smi_larb_config_port_mt8167,
> -};
> +static void mtk_smi_larb_config_port_gen2_general(struct device *dev)
> +{
> +       struct mtk_smi_larb *larb = dev_get_drvdata(dev);
> +       u32 reg;
> +       int i;
> +
> +       if (BIT(larb->larbid) & larb->larb_gen->larb_direct_to_common_mask)
> +               return;
> +
> +       for_each_set_bit(i, (unsigned long *)larb->mmu, 32) {
> +               reg = readl_relaxed(larb->base + SMI_LARB_NONSEC_CON(i));
> +               reg |= F_MMU_EN;
> +               reg |= BANK_SEL(larb->bank[i]);
> +               writel(reg, larb->base + SMI_LARB_NONSEC_CON(i));
> +       }
> +}
>
>  static const struct mtk_smi_larb_gen mtk_smi_larb_mt2701 = {
>         .port_in_larb = {
> @@ -235,6 +228,16 @@ static const struct mtk_smi_larb_gen mtk_smi_larb_mt6779 = {
>                 /* DUMMY | IPU0 | IPU1 | CCU | MDLA */
>  };
>
> +static const struct mtk_smi_larb_gen mtk_smi_larb_mt8167 = {
> +       /* mt8167 do not need the port in larb */
> +       .config_port = mtk_smi_larb_config_port_mt8167,
> +};
> +
> +static const struct mtk_smi_larb_gen mtk_smi_larb_mt8173 = {
> +       /* mt8173 do not need the port in larb */
> +       .config_port = mtk_smi_larb_config_port_mt8173,
> +};
> +
>  static const struct mtk_smi_larb_gen mtk_smi_larb_mt8183 = {
>         .config_port                = mtk_smi_larb_config_port_gen2_general,
>         .larb_direct_to_common_mask = BIT(2) | BIT(3) | BIT(7),
> @@ -246,34 +249,13 @@ static const struct mtk_smi_larb_gen mtk_smi_larb_mt8192 = {
>  };
>
>  static const struct of_device_id mtk_smi_larb_of_ids[] = {
> -       {
> -               .compatible = "mediatek,mt8167-smi-larb",
> -               .data = &mtk_smi_larb_mt8167
> -       },
> -       {
> -               .compatible = "mediatek,mt8173-smi-larb",
> -               .data = &mtk_smi_larb_mt8173
> -       },
> -       {
> -               .compatible = "mediatek,mt2701-smi-larb",
> -               .data = &mtk_smi_larb_mt2701
> -       },
> -       {
> -               .compatible = "mediatek,mt2712-smi-larb",
> -               .data = &mtk_smi_larb_mt2712
> -       },
> -       {
> -               .compatible = "mediatek,mt6779-smi-larb",
> -               .data = &mtk_smi_larb_mt6779
> -       },
> -       {
> -               .compatible = "mediatek,mt8183-smi-larb",
> -               .data = &mtk_smi_larb_mt8183
> -       },
> -       {
> -               .compatible = "mediatek,mt8192-smi-larb",
> -               .data = &mtk_smi_larb_mt8192
> -       },
> +       {.compatible = "mediatek,mt2701-smi-larb", .data = &mtk_smi_larb_mt2701},
> +       {.compatible = "mediatek,mt2712-smi-larb", .data = &mtk_smi_larb_mt2712},
> +       {.compatible = "mediatek,mt6779-smi-larb", .data = &mtk_smi_larb_mt6779},
> +       {.compatible = "mediatek,mt8167-smi-larb", .data = &mtk_smi_larb_mt8167},
> +       {.compatible = "mediatek,mt8173-smi-larb", .data = &mtk_smi_larb_mt8173},
> +       {.compatible = "mediatek,mt8183-smi-larb", .data = &mtk_smi_larb_mt8183},
> +       {.compatible = "mediatek,mt8192-smi-larb", .data = &mtk_smi_larb_mt8192},
>         {}
>  };
>
> @@ -428,34 +410,13 @@ static const struct mtk_smi_common_plat mtk_smi_common_mt8192 = {
>  };
>
>  static const struct of_device_id mtk_smi_common_of_ids[] = {
> -       {
> -               .compatible = "mediatek,mt8173-smi-common",
> -               .data = &mtk_smi_common_gen2,
> -       },
> -       {
> -               .compatible = "mediatek,mt8167-smi-common",
> -               .data = &mtk_smi_common_gen2,
> -       },
> -       {
> -               .compatible = "mediatek,mt2701-smi-common",
> -               .data = &mtk_smi_common_gen1,
> -       },
> -       {
> -               .compatible = "mediatek,mt2712-smi-common",
> -               .data = &mtk_smi_common_gen2,
> -       },
> -       {
> -               .compatible = "mediatek,mt6779-smi-common",
> -               .data = &mtk_smi_common_mt6779,
> -       },
> -       {
> -               .compatible = "mediatek,mt8183-smi-common",
> -               .data = &mtk_smi_common_mt8183,
> -       },
> -       {
> -               .compatible = "mediatek,mt8192-smi-common",
> -               .data = &mtk_smi_common_mt8192,
> -       },
> +       {.compatible = "mediatek,mt2701-smi-common", .data = &mtk_smi_common_gen1},
> +       {.compatible = "mediatek,mt2712-smi-common", .data = &mtk_smi_common_gen2},
> +       {.compatible = "mediatek,mt6779-smi-common", .data = &mtk_smi_common_mt6779},
> +       {.compatible = "mediatek,mt8167-smi-common", .data = &mtk_smi_common_gen2},
> +       {.compatible = "mediatek,mt8173-smi-common", .data = &mtk_smi_common_gen2},
> +       {.compatible = "mediatek,mt8183-smi-common", .data = &mtk_smi_common_mt8183},
> +       {.compatible = "mediatek,mt8192-smi-common", .data = &mtk_smi_common_mt8192},
>         {}
>  };
>
> --
> 2.18.0
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
