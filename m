Return-Path: <SRS0=85So=MN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 779D3C636C9
	for <iommu@archiver.kernel.org>; Wed, 21 Jul 2021 12:39:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F19ED6121E
	for <iommu@archiver.kernel.org>; Wed, 21 Jul 2021 12:39:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F19ED6121E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id AABBA40163;
	Wed, 21 Jul 2021 12:39:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 86E5-BF33dbG; Wed, 21 Jul 2021 12:39:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 55316400F7;
	Wed, 21 Jul 2021 12:39:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0C052C0010;
	Wed, 21 Jul 2021 12:39:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B76F5C000E
 for <iommu@lists.linux-foundation.org>; Wed, 21 Jul 2021 12:39:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A5F9960783
 for <iommu@lists.linux-foundation.org>; Wed, 21 Jul 2021 12:39:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=chromium.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id S5EwYWPbS2Mm for <iommu@lists.linux-foundation.org>;
 Wed, 21 Jul 2021 12:39:42 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 79989605DD
 for <iommu@lists.linux-foundation.org>; Wed, 21 Jul 2021 12:39:42 +0000 (UTC)
Received: by mail-pj1-x1034.google.com with SMTP id
 me13-20020a17090b17cdb0290173bac8b9c9so3922768pjb.3
 for <iommu@lists.linux-foundation.org>; Wed, 21 Jul 2021 05:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=QEkEthW7CKgy/or0VKIC3NeiSwizxj3OuVxfIG0VkUM=;
 b=HSwP1Zll/dPKdP3vrbbcEcVkhx/jcMPX3H7ajHXoSwKOPW+SuuBbZWuMjK5d0IvNt6
 bUWR+IarJUShSq8/4Y4ZqPCNqV+Nb9C/YIRUJqW2jpOs8ycmClELT6yzWkawxONQWZYG
 NDq/jPElYJ19nDgdHBtVsnlcLc+P6LA8juEuE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=QEkEthW7CKgy/or0VKIC3NeiSwizxj3OuVxfIG0VkUM=;
 b=e9bwmcnMnlZVbGMrMVdaLGOmR49z3Uq3s+A+VRTziX/TZahQ05i9oR/YjmSwTUFggl
 uz1sOIgTIe1grQ4LgTZ2bncPoIxeNkjzEBZEK8Y3YG2PWDTRRWcUIIs+sfKJ+4mbx+nG
 4jOarHhDRiDKkDxDovN26cHdKndr69iqMz+ufIcKnWIA+jS+hEQWOUA/SXUhuKGO2APS
 6rb1NQxFeEdScBqyty1nISicN5+ZPHQwVOOCGVIyzZxlDTnONb8lUnXzHFGe73eMUepS
 gRu3rxacz23whkTsoJ3GBMQ2WvT2NTykbBtZ2RJxXZHbXbPbBYJ70lMYnLBm3rHTcXMG
 jYvA==
X-Gm-Message-State: AOAM531JPHYE1bz53Q8mTh5I2+Rp6s1MYEdCKdIawgU6RyFEBEMTukvt
 Qbl47xuaZCtkJT77PxIJQTYUW0qk9aLr3mqqgts8wA==
X-Google-Smtp-Source: ABdhPJyTnNfx5pORTNjVkzxDDgtUXvJakKiVASRPKj5kfSEKa5DHdCM0Rau3Ti5Cohe2pje9E1RCRyGbz9nE8qdnWDg=
X-Received: by 2002:a17:903:22d0:b029:12b:1215:5e73 with SMTP id
 y16-20020a17090322d0b029012b12155e73mr27536794plg.60.1626871181882; Wed, 21
 Jul 2021 05:39:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210715121209.31024-1-yong.wu@mediatek.com>
 <20210715121209.31024-10-yong.wu@mediatek.com>
In-Reply-To: <20210715121209.31024-10-yong.wu@mediatek.com>
From: Ikjoon Jang <ikjn@chromium.org>
Date: Wed, 21 Jul 2021 20:39:31 +0800
Message-ID: <CAATdQgCwWDp9D-aFHNGVvOuojJeYH=yAq+tce4vUbQ=kiYa59w@mail.gmail.com>
Subject: Re: [PATCH v2 09/11] memory: mtk-smi: mt8195: Add smi support
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

On Thu, Jul 15, 2021 at 8:22 PM Yong Wu <yong.wu@mediatek.com> wrote:
>
> MT8195 has two smi-common, their IP are the same. Only the larbs that
> connect with the smi-common are different. thus the bus_sel are different
> for the two smi-common.
>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>

Reviewed-by: Ikjoon Jang <ikjn@chromium.org>

> ---
>  drivers/memory/mtk-smi.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
> index e5a34b3952a0..3c288716a378 100644
> --- a/drivers/memory/mtk-smi.c
> +++ b/drivers/memory/mtk-smi.c
> @@ -250,6 +250,10 @@ static const struct mtk_smi_larb_gen mtk_smi_larb_mt8192 = {
>         .config_port                = mtk_smi_larb_config_port_gen2_general,
>  };
>
> +static const struct mtk_smi_larb_gen mtk_smi_larb_mt8195 = {
> +       .config_port                = mtk_smi_larb_config_port_gen2_general,
> +};
> +
>  static const struct of_device_id mtk_smi_larb_of_ids[] = {
>         {.compatible = "mediatek,mt2701-smi-larb", .data = &mtk_smi_larb_mt2701},
>         {.compatible = "mediatek,mt2712-smi-larb", .data = &mtk_smi_larb_mt2712},
> @@ -258,6 +262,7 @@ static const struct of_device_id mtk_smi_larb_of_ids[] = {
>         {.compatible = "mediatek,mt8173-smi-larb", .data = &mtk_smi_larb_mt8173},
>         {.compatible = "mediatek,mt8183-smi-larb", .data = &mtk_smi_larb_mt8183},
>         {.compatible = "mediatek,mt8192-smi-larb", .data = &mtk_smi_larb_mt8192},
> +       {.compatible = "mediatek,mt8195-smi-larb", .data = &mtk_smi_larb_mt8195},
>         {}
>  };
>
> @@ -430,6 +435,21 @@ static const struct mtk_smi_common_plat mtk_smi_common_mt8192 = {
>                     F_MMU1_LARB(6),
>  };
>
> +static const struct mtk_smi_common_plat mtk_smi_common_mt8195_vdo = {
> +       .type     = MTK_SMI_GEN2,
> +       .bus_sel  = F_MMU1_LARB(1) | F_MMU1_LARB(3) | F_MMU1_LARB(5) |
> +                   F_MMU1_LARB(7),
> +};
> +
> +static const struct mtk_smi_common_plat mtk_smi_common_mt8195_vpp = {
> +       .type     = MTK_SMI_GEN2,
> +       .bus_sel  = F_MMU1_LARB(1) | F_MMU1_LARB(2) | F_MMU1_LARB(7),
> +};
> +
> +static const struct mtk_smi_common_plat mtk_smi_sub_common_mt8195 = {
> +       .type     = MTK_SMI_GEN2_SUB_COMM,
> +};
> +
>  static const struct of_device_id mtk_smi_common_of_ids[] = {
>         {.compatible = "mediatek,mt2701-smi-common", .data = &mtk_smi_common_gen1},
>         {.compatible = "mediatek,mt2712-smi-common", .data = &mtk_smi_common_gen2},
> @@ -438,6 +458,9 @@ static const struct of_device_id mtk_smi_common_of_ids[] = {
>         {.compatible = "mediatek,mt8173-smi-common", .data = &mtk_smi_common_gen2},
>         {.compatible = "mediatek,mt8183-smi-common", .data = &mtk_smi_common_mt8183},
>         {.compatible = "mediatek,mt8192-smi-common", .data = &mtk_smi_common_mt8192},
> +       {.compatible = "mediatek,mt8195-smi-common-vdo", .data = &mtk_smi_common_mt8195_vdo},
> +       {.compatible = "mediatek,mt8195-smi-common-vpp", .data = &mtk_smi_common_mt8195_vpp},
> +       {.compatible = "mediatek,mt8195-smi-sub-common", .data = &mtk_smi_sub_common_mt8195},
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
