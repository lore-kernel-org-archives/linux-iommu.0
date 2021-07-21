Return-Path: <SRS0=85So=MN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CBADC07E9B
	for <iommu@archiver.kernel.org>; Wed, 21 Jul 2021 10:54:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AA036124C
	for <iommu@archiver.kernel.org>; Wed, 21 Jul 2021 10:54:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AA036124C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3E2FC82F37;
	Wed, 21 Jul 2021 10:54:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZuqCxy8s0pcE; Wed, 21 Jul 2021 10:53:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1771382F06;
	Wed, 21 Jul 2021 10:53:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 70A8CC000E;
	Wed, 21 Jul 2021 10:53:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 35323C000E
 for <iommu@lists.linux-foundation.org>; Wed, 21 Jul 2021 10:44:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2296F40237
 for <iommu@lists.linux-foundation.org>; Wed, 21 Jul 2021 10:44:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=chromium.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Xc5MX53HXhK7 for <iommu@lists.linux-foundation.org>;
 Wed, 21 Jul 2021 10:44:25 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com
 [IPv6:2607:f8b0:4864:20::42f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 12BC9401B6
 for <iommu@lists.linux-foundation.org>; Wed, 21 Jul 2021 10:44:24 +0000 (UTC)
Received: by mail-pf1-x42f.google.com with SMTP id m83so1965457pfd.0
 for <iommu@lists.linux-foundation.org>; Wed, 21 Jul 2021 03:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=GXWcsJDXb1A/72l7a2R8Yfuydt9sw0KVY6gwcccRtzw=;
 b=HwJuai+igbPwD/LYxLesQ/+WpH5n2+B+lybbPQ2LEXAm0JuXXBDvz2QkL3Zi60jNPF
 Iz1WTkpHaPPD4gDA1DzM8+gosf00VczPuJVTpssHvQCa486ckwFxLNuyv1D4ngSEZWVv
 QIidHytZ+Q2tnIPpURlojfRB2zmtoJdrBau4w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=GXWcsJDXb1A/72l7a2R8Yfuydt9sw0KVY6gwcccRtzw=;
 b=BJEnX6qpSoJEY5BVojBPi3ua/2PuQ7I5PbHb8Uw5RmUDR8IbxbZlEnqNayh+yq9RSY
 46Qd8I3RiqX1OheTvJevNV9IY7+Om+ivuVBIZEYnEz+rIPAceBWybUlN6uodV+NHxe16
 euacB+qh7BlRyrE9hkNtq8gPb2rh5JyGJl4Josv+dre5lOkj7PO03ip8LOZ7XZfbuVKW
 eUFKap9/MP5ndL+PFAKrZF7luZv8iYLsIHn4Xp7TcJQBPHPY+pDH+LREbr/qeJsUVZl9
 gmJ5tWMaC2I3v7vNfktUPy7zirZ6bvu4mWKx08il7igD3fWBsbYQLlkEEAx4jLhaUO3x
 xutQ==
X-Gm-Message-State: AOAM531kAkDks9d4Qjc5wcxXNmp7ah+vO2dvdOV521MG+MJkCiwsxnGy
 wHs3dTSy2ZQBuPS6bnHPPQ84L8DnXUZFXCSNTaFFJQ==
X-Google-Smtp-Source: ABdhPJyqyEkC7KsAlOheOaxaV+RUgvQXOkoIrX81SdGZGtmk+ga72QNgvkh/B2ekHAnq9tVQ9sgHLy2LM1SGELsGw6s=
X-Received: by 2002:a63:8f04:: with SMTP id n4mr34564903pgd.317.1626864264477; 
 Wed, 21 Jul 2021 03:44:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210715121209.31024-1-yong.wu@mediatek.com>
 <20210715121209.31024-5-yong.wu@mediatek.com>
In-Reply-To: <20210715121209.31024-5-yong.wu@mediatek.com>
From: Ikjoon Jang <ikjn@chromium.org>
Date: Wed, 21 Jul 2021 18:44:13 +0800
Message-ID: <CAATdQgB9eKCBvxV8R8jgkAa8Hqdbu4=nc9frMA024PvMnWWTaw@mail.gmail.com>
Subject: Re: [PATCH v2 04/11] memory: mtk-smi: Rename smi_gen to smi_type
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

On Thu, Jul 15, 2021 at 8:14 PM Yong Wu <yong.wu@mediatek.com> wrote:
>
> Prepare for adding smi sub common. Only rename from smi_gen to smi_type.
> No functional change.
>
> About the current "smi_gen", we have gen1/gen2 that stand for the
> generation number for HW. I plan to add a new type(sub_common), then the
> name "gen" is not prober.
>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>

Reviewed-by: Ikjoon Jang <ikjn@chromium.org>

> ---
>  drivers/memory/mtk-smi.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
> index a2213452059d..ff07b14bcd66 100644
> --- a/drivers/memory/mtk-smi.c
> +++ b/drivers/memory/mtk-smi.c
> @@ -55,7 +55,7 @@
>  /* All are MMU0 defaultly. Only specialize mmu1 here. */
>  #define F_MMU1_LARB(larbid)            (0x1 << SMI_BUS_LARB_SHIFT(larbid))
>
> -enum mtk_smi_gen {
> +enum mtk_smi_type {
>         MTK_SMI_GEN1,
>         MTK_SMI_GEN2
>  };
> @@ -68,8 +68,8 @@ static const char * const mtk_smi_common_clks_optional[] = {"gals0", "gals1"};
>  static const char * const mtk_smi_larb_clks_optional[] = {"gals"};
>
>  struct mtk_smi_common_plat {
> -       enum mtk_smi_gen gen;
> -       u32              bus_sel; /* Balance some larbs to enter mmu0 or mmu1 */
> +       enum mtk_smi_type       type;
> +       u32                     bus_sel; /* Balance some larbs to enter mmu0 or mmu1 */
>  };
>
>  struct mtk_smi_larb_gen {
> @@ -402,27 +402,27 @@ static struct platform_driver mtk_smi_larb_driver = {
>  };
>
>  static const struct mtk_smi_common_plat mtk_smi_common_gen1 = {
> -       .gen = MTK_SMI_GEN1,
> +       .type     = MTK_SMI_GEN1,
>  };
>
>  static const struct mtk_smi_common_plat mtk_smi_common_gen2 = {
> -       .gen = MTK_SMI_GEN2,
> +       .type     = MTK_SMI_GEN2,
>  };
>
>  static const struct mtk_smi_common_plat mtk_smi_common_mt6779 = {
> -       .gen            = MTK_SMI_GEN2,
> -       .bus_sel        = F_MMU1_LARB(1) | F_MMU1_LARB(2) | F_MMU1_LARB(4) |
> -                         F_MMU1_LARB(5) | F_MMU1_LARB(6) | F_MMU1_LARB(7),
> +       .type     = MTK_SMI_GEN2,
> +       .bus_sel  = F_MMU1_LARB(1) | F_MMU1_LARB(2) | F_MMU1_LARB(4) |
> +                   F_MMU1_LARB(5) | F_MMU1_LARB(6) | F_MMU1_LARB(7),
>  };
>
>  static const struct mtk_smi_common_plat mtk_smi_common_mt8183 = {
> -       .gen      = MTK_SMI_GEN2,
> +       .type     = MTK_SMI_GEN2,
>         .bus_sel  = F_MMU1_LARB(1) | F_MMU1_LARB(2) | F_MMU1_LARB(5) |
>                     F_MMU1_LARB(7),
>  };
>
>  static const struct mtk_smi_common_plat mtk_smi_common_mt8192 = {
> -       .gen      = MTK_SMI_GEN2,
> +       .type     = MTK_SMI_GEN2,
>         .bus_sel  = F_MMU1_LARB(1) | F_MMU1_LARB(2) | F_MMU1_LARB(5) |
>                     F_MMU1_LARB(6),
>  };
> @@ -483,7 +483,7 @@ static int mtk_smi_common_probe(struct platform_device *pdev)
>          * clock into emi clock domain, but for mtk smi gen2, there's no smi ao
>          * base.
>          */
> -       if (common->plat->gen == MTK_SMI_GEN1) {
> +       if (common->plat->type == MTK_SMI_GEN1) {
>                 res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>                 common->smi_ao_base = devm_ioremap_resource(dev, res);
>                 if (IS_ERR(common->smi_ao_base))
> @@ -523,7 +523,7 @@ static int __maybe_unused mtk_smi_common_resume(struct device *dev)
>         if (ret)
>                 return ret;
>
> -       if (common->plat->gen == MTK_SMI_GEN2 && bus_sel)
> +       if (common->plat->type == MTK_SMI_GEN2 && bus_sel)
>                 writel(bus_sel, common->base + SMI_BUS_SEL);
>         return 0;
>  }
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
