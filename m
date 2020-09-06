Return-Path: <SRS0=6KmI=CP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94625C43461
	for <iommu@archiver.kernel.org>; Sun,  6 Sep 2020 16:30:52 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE00920709
	for <iommu@archiver.kernel.org>; Sun,  6 Sep 2020 16:30:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="hyT1PpOw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE00920709
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 4C115203F2;
	Sun,  6 Sep 2020 16:30:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mMcuPfqx+oVf; Sun,  6 Sep 2020 16:30:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 06134203C9;
	Sun,  6 Sep 2020 16:30:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EBF21C0859;
	Sun,  6 Sep 2020 16:30:48 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0E98CC0051
 for <iommu@lists.linux-foundation.org>; Sun,  6 Sep 2020 16:30:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id EB8B7855CF
 for <iommu@lists.linux-foundation.org>; Sun,  6 Sep 2020 16:30:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id J1ag6HZ9BqdN for <iommu@lists.linux-foundation.org>;
 Sun,  6 Sep 2020 16:30:44 +0000 (UTC)
X-Greylist: delayed 01:01:01 by SQLgrey-1.7.6
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com
 [209.85.210.194])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id AF418854DB
 for <iommu@lists.linux-foundation.org>; Sun,  6 Sep 2020 16:30:44 +0000 (UTC)
Received: by mail-pf1-f194.google.com with SMTP id d6so273322pfn.9
 for <iommu@lists.linux-foundation.org>; Sun, 06 Sep 2020 09:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=JwN/BVu2qRKl2g6ZpjOhiQKz73AB4SfyAtuVoOPIeRA=;
 b=hyT1PpOwkbC8e2AEOu/g9Z60NoTSWolqKqKILsHgaokzrv9DdzWF0iGZC3eIzCBK6D
 mjAV6ZT2C9Vxh1Ly7plpKR9in9PGAr0OEPu+GfdJwmNnPeW0Dd3/ZQzAc66HYh71aN5C
 VMfFGFfcDlIVIrRL1ePqttKFQ8qYgoqpHy8PXzMGR/gYqjK1Qpv8zkGw2kUyK/2HoiD2
 VwYvqKKAGM0Zf21f+GjMTO1todjKALyPIATfQQRalp63mcX01/Jwa3v1QyCeUgemW6VI
 XKlHKjJMx4dpYPWcKV5ts7aO03e7y9HLhoDz5h9FvJKcMQt7mUFEElQYlObrgEwpsp4N
 gXNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=JwN/BVu2qRKl2g6ZpjOhiQKz73AB4SfyAtuVoOPIeRA=;
 b=HPt0EKnul9m9BCghaut4iktJ+YET0Wdx/6iu4nQ1WaSWgmxPeqA4XYhiX+BN3ZfDZc
 9Pnz1JZmJwdUjHifjTqFnDa0hWP2hnTGIMvvFB1QOOh5/ZmsbiFfntJYsQBoKRe7aBYV
 exXUDPujaqZ9a+xQDPLYveVZ6nV90XNM3MgFKGIhmI4bEQw/MK1KZd1KQNaalkAV1mDm
 fK0INNENrz72Ql4q8SMxHAaiE63MNFPbHmKK8wc+mjynjxaqiXlz2tqCYOM48+ovPa8t
 8fEKX94vo4c47dupArIqKc1jXD3I+X/h8pr1tJRWfkAjzXM9DuWbsb+JQ0B5APDveQ7/
 ZHiw==
X-Gm-Message-State: AOAM532ry6RDRRSO63f4elmdy+uO11NLL7bLQhUJo7sFAeyjnZlzeTA1
 Zr+NNof4Z/W2ZX/+hZ3a8zGvn0X+c9IvCYNkUlhq/mKiJkwWZw==
X-Google-Smtp-Source: ABdhPJzKi00xRmsMGDFQSGHtnb/nykiYPK9LVtj52+aSMZYX3f63ZtwA74l54mZTa9IRhJphwOhsRh/ztDf7FIB2f5s=
X-Received: by 2002:a92:d8c2:: with SMTP id l2mr16266090ilo.301.1599405746941; 
 Sun, 06 Sep 2020 08:22:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200906151928.881209-1-fparent@baylibre.com>
 <20200906151928.881209-3-fparent@baylibre.com>
In-Reply-To: <20200906151928.881209-3-fparent@baylibre.com>
From: Fabien Parent <fparent@baylibre.com>
Date: Sun, 6 Sep 2020 17:22:16 +0200
Message-ID: <CAOwMV_xzeTXjvay32av9buJeJzSewnOGVWNdte8r-awiQr148g@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] iommu/mediatek: add support for MT8167
To: iommu@lists.linux-foundation.org, DTML <devicetree@vger.kernel.org>, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org
Cc: Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh+dt@kernel.org>
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

On Sun, Sep 6, 2020 at 5:19 PM Fabien Parent <fparent@baylibre.com> wrote:
>
> Add support for the IOMMU on MT8167
>
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
>
> V3:
>         * use LEGACY_IVRP_PADDR flag instead of using a platform data member

Forgot to mention a change here: .larbid_remap has been fixed to only
contain the number of larb present on MT8167

> V2:
>         * removed if based on m4u_plat, and using instead the new
>           has_legacy_ivrp_paddr member that was introduced in patch 2.
>
> ---
>  drivers/iommu/mtk_iommu.c | 8 ++++++++
>  drivers/iommu/mtk_iommu.h | 1 +
>  2 files changed, 9 insertions(+)
>
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index b1f85a7e9346..6079f6a23c74 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -817,6 +817,13 @@ static const struct mtk_iommu_plat_data mt6779_data = {
>         .larbid_remap  = {{0}, {1}, {2}, {3}, {5}, {7, 8}, {10}, {9}},
>  };
>
> +static const struct mtk_iommu_plat_data mt8167_data = {
> +       .m4u_plat     = M4U_MT8167,
> +       .flags        = HAS_4GB_MODE | RESET_AXI | HAS_LEGACY_IVRP_PADDR,
> +       .inv_sel_reg  = REG_MMU_INV_SEL_GEN1,
> +       .larbid_remap = {{0}, {1}, {2}}, /* Linear mapping. */
> +};
> +
>  static const struct mtk_iommu_plat_data mt8173_data = {
>         .m4u_plat     = M4U_MT8173,
>         .flags        = HAS_4GB_MODE | HAS_BCLK | RESET_AXI |
> @@ -835,6 +842,7 @@ static const struct mtk_iommu_plat_data mt8183_data = {
>  static const struct of_device_id mtk_iommu_of_ids[] = {
>         { .compatible = "mediatek,mt2712-m4u", .data = &mt2712_data},
>         { .compatible = "mediatek,mt6779-m4u", .data = &mt6779_data},
> +       { .compatible = "mediatek,mt8167-m4u", .data = &mt8167_data},
>         { .compatible = "mediatek,mt8173-m4u", .data = &mt8173_data},
>         { .compatible = "mediatek,mt8183-m4u", .data = &mt8183_data},
>         {}
> diff --git a/drivers/iommu/mtk_iommu.h b/drivers/iommu/mtk_iommu.h
> index 122925dbe547..df32b3e3408b 100644
> --- a/drivers/iommu/mtk_iommu.h
> +++ b/drivers/iommu/mtk_iommu.h
> @@ -39,6 +39,7 @@ enum mtk_iommu_plat {
>         M4U_MT2701,
>         M4U_MT2712,
>         M4U_MT6779,
> +       M4U_MT8167,
>         M4U_MT8173,
>         M4U_MT8183,
>  };
> --
> 2.28.0
>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
