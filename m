Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7C98C433F5
	for <iommu@archiver.kernel.org>; Wed, 11 May 2022 15:40:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8A592610EA;
	Wed, 11 May 2022 15:40:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zpG8BzCfAIjF; Wed, 11 May 2022 15:40:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 54029610E8;
	Wed, 11 May 2022 15:40:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2AB7DC0032;
	Wed, 11 May 2022 15:40:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 30E0DC0032
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 15:24:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0F8FD41725
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 15:24:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=google.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id igUii_L1wzAP for <iommu@lists.linux-foundation.org>;
 Wed, 11 May 2022 15:24:52 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B9A26416D4
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 15:24:52 +0000 (UTC)
Received: by mail-ej1-x62e.google.com with SMTP id bv19so4783013ejb.6
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 08:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=seaHCom44uiTs26SOVTHmO+d30N+urihbVnoa7jcBHU=;
 b=TAsFxKUwFUu/cfHGMVs7euuOOaHKgnj7ofjrXFjp8r9Snf7wiMSBmToMDbll08c4wB
 B4LGXeld//Q6hfxFtxBMvALlOyKkBrwRlXmA5HUoGvnBrbQ8Z0lf5TiNGHuyMrP5BR63
 n6ueMhr6dz49B7BTy3DGmj6ZgllDGug3NlmCJzP7cNvRG6GoVu5qS4C3KtiUZlgXFufh
 GrpfbUWWpQRQYDaaK9aKLJGsmkgEdTsj7LCUFYY8sOi2gz+5yjJCzJ/Cm21z7B6ydRD5
 Eb6frZ5RtEav3mlIuE5peSrbI9eRPdVtxJETEJRXmlpTKjxCb0r6y2Qp7SoSZumEhuWj
 rDBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=seaHCom44uiTs26SOVTHmO+d30N+urihbVnoa7jcBHU=;
 b=AeHf/f88cTQ+JLlvO/wjy2ZpG/rPAu3RecuHSMWJGFyi3QeuUqMTQQogwjKfPIeNxx
 RRsQyGXO2c+9c27nBZB+kLUBeDhWEvJ8GE4sSyAZyMAnezvuBLbTew09vMyDFUgnbbCs
 iStmpCwm2JiD2HkG3EjjM/9mRQJN+B9eDS1A/SMtUNkGIie4USVwuANKIVtpd7mNDOvQ
 umcYuAmat5djCBZ802vzItFVf6NClM5XKqDC9EHbyu4oOh5GhvFBYCzf/bCao7Zu/kzF
 4Tw3467bkXEtUxwfEN+BlseAkYtv68vblWex7CK3hgdrsaou9JDDlbdY6BplbHRgILfZ
 /qpA==
X-Gm-Message-State: AOAM532CSoOtEexlahUInHgarvC8opgEHSZncoj676X7I93XIoQ+OImL
 jmDWbs3AuU6Ei62XS5K3sq+QezJ27bfwzcMmyn9tOQ==
X-Google-Smtp-Source: ABdhPJw5lbZ3f5D9UUxJJpVm5HxR51LIMMyK1ge48NZ+6rLvEM9+7xdSTx82HwOKw4EXjm+P/qHF+QOQPr1ZncyweS8=
X-Received: by 2002:a17:907:162a:b0:6f4:c53b:fca7 with SMTP id
 hb42-20020a170907162a00b006f4c53bfca7mr25795243ejc.723.1652282690650; Wed, 11
 May 2022 08:24:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220511064920.18455-1-yong.wu@mediatek.com>
 <20220511064920.18455-2-yong.wu@mediatek.com>
In-Reply-To: <20220511064920.18455-2-yong.wu@mediatek.com>
Date: Wed, 11 May 2022 08:24:39 -0700
Message-ID: <CABXOdTcA1ERGTCMVDhz+cah6GwC3hsNR9W3PYyYZN6uGE5_Rsg@mail.gmail.com>
Subject: Re: [PATCH 1/4] iommu/mediatek: Use dev_err_probe to mute probe_defer
 err log
To: Yong Wu <yong.wu@mediatek.com>
X-Mailman-Approved-At: Wed, 11 May 2022 15:40:45 +0000
Cc: anan.sun@mediatek.com, chengci.xu@mediatek.com, xueqi.zhang@mediatek.com,
 linux-kernel <linux-kernel@vger.kernel.org>, libo.kang@mediatek.com,
 yf.wang@mediatek.com, Guenter Roeck <groeck@chromium.org>,
 iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
 Dan Carpenter <dan.carpenter@oracle.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, Will Deacon <will@kernel.org>,
 mingyuan.ma@mediatek.com,
 "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
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
From: Guenter Roeck via iommu <iommu@lists.linux-foundation.org>
Reply-To: Guenter Roeck <groeck@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Tue, May 10, 2022 at 11:49 PM Yong Wu <yong.wu@mediatek.com> wrote:
>
> Mute the probe defer log:
>
> [    2.654806] mtk-iommu 14018000.iommu: mm dts parse fail(-517).
> [    2.656168] mtk-iommu 1c01f000.iommu: mm dts parse fail(-517).
>
> Fixes: d2e9a1102cfc ("iommu/mediatek: Contain MM IOMMU flow with the MM TYPE")
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> ---
> The Fixes tag commit-id is from linux-next.
> ---
>  drivers/iommu/mtk_iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index 71b2ace74cd6..0f6ec4a4d9d4 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -1198,7 +1198,7 @@ static int mtk_iommu_probe(struct platform_device *pdev)
>         if (MTK_IOMMU_IS_TYPE(data->plat_data, MTK_IOMMU_TYPE_MM)) {
>                 ret = mtk_iommu_mm_dts_parse(dev, &match, data);
>                 if (ret) {
> -                       dev_err(dev, "mm dts parse fail(%d).", ret);
> +                       dev_err_probe(dev, ret, "mm dts parse fail.");
>                         goto out_runtime_disable;
>                 }
>         } else if (MTK_IOMMU_IS_TYPE(data->plat_data, MTK_IOMMU_TYPE_INFRA) &&
> --
> 2.18.0
>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
