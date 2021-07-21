Return-Path: <SRS0=85So=MN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72D0BC636C9
	for <iommu@archiver.kernel.org>; Wed, 21 Jul 2021 11:44:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F08B610D2
	for <iommu@archiver.kernel.org>; Wed, 21 Jul 2021 11:44:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F08B610D2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EE9FC828A5;
	Wed, 21 Jul 2021 11:44:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ifHjgcFK6bT8; Wed, 21 Jul 2021 11:44:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D4CB782CD4;
	Wed, 21 Jul 2021 11:44:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8E289C001A;
	Wed, 21 Jul 2021 11:44:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EA3DEC000E
 for <iommu@lists.linux-foundation.org>; Wed, 21 Jul 2021 11:44:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E66526074A
 for <iommu@lists.linux-foundation.org>; Wed, 21 Jul 2021 11:44:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=chromium.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rMcaGKJoYxGP for <iommu@lists.linux-foundation.org>;
 Wed, 21 Jul 2021 11:44:34 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com
 [IPv6:2607:f8b0:4864:20::52b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 23CEE6062A
 for <iommu@lists.linux-foundation.org>; Wed, 21 Jul 2021 11:44:34 +0000 (UTC)
Received: by mail-pg1-x52b.google.com with SMTP id k20so1606334pgg.7
 for <iommu@lists.linux-foundation.org>; Wed, 21 Jul 2021 04:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=1e5owWDxMUbIBJfKFii6zS+/7R0v2+enWtZrIJ8w5gE=;
 b=oOMBLoLdDZUmJwKPMItYIv30/3dAnF/IjyteNCMVTgAl7Vs00+i0xC49Mg4KcYCRQH
 XDCA6ws6TiC9cYmziRd03GZESG5nW9Bi3IhSWJlzkL5ZjyknmAtZS/ryG5jgI5P56sJ0
 IAFknBfWisrvP3CVkp8BV9frTdmNt/tX2auDQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=1e5owWDxMUbIBJfKFii6zS+/7R0v2+enWtZrIJ8w5gE=;
 b=YEE84GOG4A+rephlW1/5kL/VN6xz/EhNLeCTByAI77h0ZMLq0QF7Cc0iI6FVpoKq6E
 E1ix6tTRZDkx4y11m+W8dS3oVDr3SoSax/2CLhstlKCyQWTE/2uextkHY/SrKnM9GMFV
 aGHCIB+hPQF8nu6LxRKx868GHM3/snA9+jyfW3BgS3/xv2c3MaTV/3J17jpdLjj69gVX
 9hlyqdaTxwPm3jJiSWQO2X2+JkGB7wwul/SKYcmbuE5L700hVXn9ZUi0L7+tCY6JVwGI
 O7mI77iMBxYY20bjc5vMOGvL/ENNNy9uC6T8kOBdhtH5gO1PHNgRA8xJMXRd8ClmqjXB
 jTiw==
X-Gm-Message-State: AOAM530o2Nw9o6oQYCo+AjaNg5KbU/dRkWLer+JBPrXW+iRaWfKo/DJ/
 lmJqe9YrL7NWlqDJ78Z0FOR7jsAG8xXB4rdUlcgktA==
X-Google-Smtp-Source: ABdhPJzDuuXuFsg+sEvfAF7SzXJ4MRUYLPDA9Vj5ACSar4H9upnFwBC/H+/Y7qoK7WoFI+0/zLdVgr5TPKu1KmiiWMI=
X-Received: by 2002:a63:3601:: with SMTP id d1mr6530858pga.299.1626867873570; 
 Wed, 21 Jul 2021 04:44:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210715121209.31024-1-yong.wu@mediatek.com>
 <20210715121209.31024-9-yong.wu@mediatek.com>
In-Reply-To: <20210715121209.31024-9-yong.wu@mediatek.com>
From: Ikjoon Jang <ikjn@chromium.org>
Date: Wed, 21 Jul 2021 19:44:22 +0800
Message-ID: <CAATdQgAnj2B=js44O8LQ6ALqEr9r_UhiwMnLX+wqxJkQ5Lw=Ew@mail.gmail.com>
Subject: Re: [PATCH v2 08/11] memory: mtk-smi: Use
 devm_platform_ioremap_resource
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

On Thu, Jul 15, 2021 at 8:24 PM Yong Wu <yong.wu@mediatek.com> wrote:
>
> No functional change. Simplify probing code.
>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>

Reviewed-by: Ikjoon Jang <ikjn@chromium.org>

> ---
>  drivers/memory/mtk-smi.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
> index ee49bb50f5f5..e5a34b3952a0 100644
> --- a/drivers/memory/mtk-smi.c
> +++ b/drivers/memory/mtk-smi.c
> @@ -317,7 +317,6 @@ static int mtk_smi_dts_clk_init(struct device *dev, struct mtk_smi *smi,
>  static int mtk_smi_larb_probe(struct platform_device *pdev)
>  {
>         struct mtk_smi_larb *larb;
> -       struct resource *res;
>         struct device *dev = &pdev->dev;
>         int ret;
>
> @@ -326,8 +325,7 @@ static int mtk_smi_larb_probe(struct platform_device *pdev)
>                 return -ENOMEM;
>
>         larb->larb_gen = of_device_get_match_data(dev);
> -       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -       larb->base = devm_ioremap_resource(dev, res);
> +       larb->base = devm_platform_ioremap_resource(pdev, 0);
>         if (IS_ERR(larb->base))
>                 return PTR_ERR(larb->base);
>
> @@ -447,7 +445,6 @@ static int mtk_smi_common_probe(struct platform_device *pdev)
>  {
>         struct device *dev = &pdev->dev;
>         struct mtk_smi *common;
> -       struct resource *res;
>         int ret;
>
>         common = devm_kzalloc(dev, sizeof(*common), GFP_KERNEL);
> @@ -468,8 +465,7 @@ static int mtk_smi_common_probe(struct platform_device *pdev)
>          * base.
>          */
>         if (common->plat->type == MTK_SMI_GEN1) {
> -               res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -               common->smi_ao_base = devm_ioremap_resource(dev, res);
> +               common->smi_ao_base = devm_platform_ioremap_resource(pdev, 0);
>                 if (IS_ERR(common->smi_ao_base))
>                         return PTR_ERR(common->smi_ao_base);
>
> @@ -481,8 +477,7 @@ static int mtk_smi_common_probe(struct platform_device *pdev)
>                 if (ret)
>                         return ret;
>         } else {
> -               res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -               common->base = devm_ioremap_resource(dev, res);
> +               common->base = devm_platform_ioremap_resource(pdev, 0);
>                 if (IS_ERR(common->base))
>                         return PTR_ERR(common->base);
>         }
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
