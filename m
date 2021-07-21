Return-Path: <SRS0=85So=MN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17188C636CE
	for <iommu@archiver.kernel.org>; Wed, 21 Jul 2021 12:54:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3A3561285
	for <iommu@archiver.kernel.org>; Wed, 21 Jul 2021 12:54:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3A3561285
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 72AC04027F;
	Wed, 21 Jul 2021 12:54:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IwoU-sfFdRK0; Wed, 21 Jul 2021 12:54:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D8D0840280;
	Wed, 21 Jul 2021 12:54:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 97F86C0010;
	Wed, 21 Jul 2021 12:54:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2B159C000E
 for <iommu@lists.linux-foundation.org>; Wed, 21 Jul 2021 12:54:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0A4FC82977
 for <iommu@lists.linux-foundation.org>; Wed, 21 Jul 2021 12:54:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=chromium.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DZLs7WPooJeZ for <iommu@lists.linux-foundation.org>;
 Wed, 21 Jul 2021 12:54:12 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 23432828A5
 for <iommu@lists.linux-foundation.org>; Wed, 21 Jul 2021 12:54:12 +0000 (UTC)
Received: by mail-pl1-x62d.google.com with SMTP id d1so922482plg.0
 for <iommu@lists.linux-foundation.org>; Wed, 21 Jul 2021 05:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=iP4NUt/V0t1FXR1pars3ssyFHqsgxDoI/nyz3Is/Xqk=;
 b=gRk9/ILWwpLwl4zdj87BtAXrrYFGzkeVH6ObYfiKFfNQFmCyQIL6FYk80hsfm3asvB
 uGHNMJG+I/w9nTSOu1Yc/BAJFqRn1GkWPWM4/O1D8l2XKi6HSqHgNZzU3FokU5Idm1Tr
 ujF3MsuBvEb42eOWep8HcPBgTmsXD5KOQBb3k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=iP4NUt/V0t1FXR1pars3ssyFHqsgxDoI/nyz3Is/Xqk=;
 b=j0pHUcTwHCuusng3Mllgn62Yd1rMkr9gT3i+NyubPGsraOcsZi9g3FLsVdBsxJhIuN
 ATaqryN08e8xdzNDrZoTIxabjE2LiQAbxECBfCgKAFc1wzCKs/mv330wd3bRflYjihhv
 QYYurkBjVyiJNEoebtvpZ7HyFTCYiI5yNjz/LgiCKKz/WpM1WMhMrbGVlYXo1onbNAeS
 crgTbweQpSqPhS9wnVO4SJN/WXUgA+YdiN4BOLT96DLp1ivj5r/HTvzqnO8nn2Eyo7Ci
 JFZGIDM3ryusvZXbm3vKk46Ug6+sIHNPDtZPGclg961a70Uq77IARhUaEre0h7t1M3rw
 B4AQ==
X-Gm-Message-State: AOAM533RR5zL2DBR3l1S7SvSw9C6jEyAjrEc9ReonyWi7VXCd6B+cy6s
 T86xM25/5c9/00I1nxd6jivFvwmKLRK1UANYjctrfQ==
X-Google-Smtp-Source: ABdhPJxsmHAT2BjdepvDkN94Ybs5nzq1uHhKtiM33GLd1tM4ZQBT6B0+xAjq7jQtTwOBEoILmIvJdMTSXTVC8Sch6dI=
X-Received: by 2002:a17:902:8c83:b029:129:17e5:a1cc with SMTP id
 t3-20020a1709028c83b029012917e5a1ccmr27602827plo.49.1626872051386; Wed, 21
 Jul 2021 05:54:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210715121209.31024-1-yong.wu@mediatek.com>
 <20210715121209.31024-11-yong.wu@mediatek.com>
In-Reply-To: <20210715121209.31024-11-yong.wu@mediatek.com>
From: Ikjoon Jang <ikjn@chromium.org>
Date: Wed, 21 Jul 2021 20:54:00 +0800
Message-ID: <CAATdQgDOGW7nudDoR5UPbax+d3e9omhPstrNd_FCPLd+96ZC9w@mail.gmail.com>
Subject: Re: [PATCH v2 10/11] memory: mtk-smi: mt8195: Add initial setting for
 smi-common
To: Yong Wu <yong.wu@mediatek.com>
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

On Thu, Jul 15, 2021 at 8:25 PM Yong Wu <yong.wu@mediatek.com> wrote:
>
> To improve the performance, add initial setting for smi-common.
> some register use some fix setting(suggested from DE).
>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  drivers/memory/mtk-smi.c | 42 ++++++++++++++++++++++++++++++++++++----
>  1 file changed, 38 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
> index 3c288716a378..c52bf02458ff 100644
> --- a/drivers/memory/mtk-smi.c
> +++ b/drivers/memory/mtk-smi.c
> @@ -18,11 +18,19 @@
>  #include <dt-bindings/memory/mtk-memory-port.h>
>
>  /* SMI COMMON */
> +#define SMI_L1LEN                      0x100
> +
>  #define SMI_BUS_SEL                    0x220
>  #define SMI_BUS_LARB_SHIFT(larbid)     ((larbid) << 1)
>  /* All are MMU0 defaultly. Only specialize mmu1 here. */
>  #define F_MMU1_LARB(larbid)            (0x1 << SMI_BUS_LARB_SHIFT(larbid))
>
> +#define SMI_M4U_TH                     0x234
> +#define SMI_FIFO_TH1                   0x238
> +#define SMI_FIFO_TH2                   0x23c
> +#define SMI_DCM                                0x300
> +#define SMI_DUMMY                      0x444
> +
>  /* SMI LARB */
>
>  /* Below are about mmu enable registers, they are different in SoCs */
> @@ -58,6 +66,13 @@
>         (_id << 8 | _id << 10 | _id << 12 | _id << 14); \
>  })
>
> +#define SMI_COMMON_INIT_REGS_NR                6
> +
> +struct mtk_smi_reg_pair {
> +       unsigned int            offset;
> +       u32                     value;
> +};
> +
>  enum mtk_smi_type {
>         MTK_SMI_GEN1,
>         MTK_SMI_GEN2,           /* gen2 smi common */
> @@ -74,6 +89,8 @@ static const char * const mtk_smi_larb_clks_optional[] = {"gals"};
>  struct mtk_smi_common_plat {
>         enum mtk_smi_type       type;
>         u32                     bus_sel; /* Balance some larbs to enter mmu0 or mmu1 */
> +
> +       const struct mtk_smi_reg_pair   *init;
>  };
>
>  struct mtk_smi_larb_gen {
> @@ -409,6 +426,15 @@ static struct platform_driver mtk_smi_larb_driver = {
>         }
>  };
>
> +static const struct mtk_smi_reg_pair mtk_smi_common_mt8195_init[SMI_COMMON_INIT_REGS_NR] = {
> +       {SMI_L1LEN, 0xb},
> +       {SMI_M4U_TH, 0xe100e10},
> +       {SMI_FIFO_TH1, 0x506090a},
> +       {SMI_FIFO_TH2, 0x506090a},
> +       {SMI_DCM, 0x4f1},
> +       {SMI_DUMMY, 0x1},
> +};
> +
>  static const struct mtk_smi_common_plat mtk_smi_common_gen1 = {
>         .type     = MTK_SMI_GEN1,
>  };
> @@ -439,11 +465,13 @@ static const struct mtk_smi_common_plat mtk_smi_common_mt8195_vdo = {
>         .type     = MTK_SMI_GEN2,
>         .bus_sel  = F_MMU1_LARB(1) | F_MMU1_LARB(3) | F_MMU1_LARB(5) |
>                     F_MMU1_LARB(7),
> +       .init     = mtk_smi_common_mt8195_init,
>  };
>
>  static const struct mtk_smi_common_plat mtk_smi_common_mt8195_vpp = {
>         .type     = MTK_SMI_GEN2,
>         .bus_sel  = F_MMU1_LARB(1) | F_MMU1_LARB(2) | F_MMU1_LARB(7),
> +       .init     = mtk_smi_common_mt8195_init,
>  };
>
>  static const struct mtk_smi_common_plat mtk_smi_sub_common_mt8195 = {
> @@ -530,15 +558,21 @@ static int mtk_smi_common_remove(struct platform_device *pdev)
>  static int __maybe_unused mtk_smi_common_resume(struct device *dev)
>  {
>         struct mtk_smi *common = dev_get_drvdata(dev);
> -       u32 bus_sel = common->plat->bus_sel;
> -       int ret;
> +       const struct mtk_smi_reg_pair *init = common->plat->init;
> +       u32 bus_sel = common->plat->bus_sel; /* default is 0 */
> +       int ret, i;
>
>         ret = clk_bulk_prepare_enable(common->clk_num, common->clks);
>         if (ret)
>                 return ret;
>
> -       if (common->plat->type == MTK_SMI_GEN2 && bus_sel)
> -               writel(bus_sel, common->base + SMI_BUS_SEL);
> +       if (common->plat->type != MTK_SMI_GEN2)
> +               return 0;
> +
> +       for (i = 0; i < SMI_COMMON_INIT_REGS_NR && init && init[i].offset; i++)
> +               writel_relaxed(init[i].value, common->base + init[i].offset);

I'm not sure this array for register settings could be applied to other
platforms in future or only applied to mt8195. If it's only for mt8195,
I think taking callback function instead of mtk_smi_reg_pair[] as init member
would be better:

if (common->plat->init)
    common->plat->init(...);

> +
> +       writel(bus_sel, common->base + SMI_BUS_SEL);
>         return 0;
>  }
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
