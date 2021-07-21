Return-Path: <SRS0=85So=MN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA31AC636C9
	for <iommu@archiver.kernel.org>; Wed, 21 Jul 2021 10:54:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 887006127C
	for <iommu@archiver.kernel.org>; Wed, 21 Jul 2021 10:54:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 887006127C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1D1DF40142;
	Wed, 21 Jul 2021 10:54:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oDe3qwrAc4Eo; Wed, 21 Jul 2021 10:54:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C1529404CB;
	Wed, 21 Jul 2021 10:53:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 07D92C0029;
	Wed, 21 Jul 2021 10:53:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 68C01C000E
 for <iommu@lists.linux-foundation.org>; Wed, 21 Jul 2021 10:45:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 56E5460716
 for <iommu@lists.linux-foundation.org>; Wed, 21 Jul 2021 10:45:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=chromium.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4v6-2h8sQaSV for <iommu@lists.linux-foundation.org>;
 Wed, 21 Jul 2021 10:45:35 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9C5BA606C6
 for <iommu@lists.linux-foundation.org>; Wed, 21 Jul 2021 10:45:35 +0000 (UTC)
Received: by mail-pj1-x1032.google.com with SMTP id gx2so1399080pjb.5
 for <iommu@lists.linux-foundation.org>; Wed, 21 Jul 2021 03:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=3lABi16nL4MQbRpp+EfVh/1lUieQouz0Mt1Eq3+g03o=;
 b=e1Kye+SB7N4WedVaQMXh+r+XKa4tTEZMwHQLriWWLC4r29k6eiqa6TbO3ygi1pNDw/
 KPESXu1ee6k4rudQCQ4a16OyvOBhEPMAWpvD1pwyncIeyJx+5+Q2MIyDjKLI2HAJ0DR2
 OTMAk4Hr+4D+jMX8+ll/bSXIJHTyOuqNsX2Q8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=3lABi16nL4MQbRpp+EfVh/1lUieQouz0Mt1Eq3+g03o=;
 b=PQXEHBMpVRJyJ6WR0p1THkIo7GI7/jNptGNTTpolJgtfW6wPTA5MA3h/JYP3gIPCRX
 cIRyzdyDMcXvVSn7pEBgEZ5JI8mvHrIkoQas56ccGiMpm2SkrqjlCRExktsQoerkwZsj
 jlZtKInEmir5W86BFsHw3R/Zk0JiIGWXvYekkl9XjhTm86ChV06JyiRMblNWYOA84n4y
 48GEFmB17Il82umv3aVsMC/hgv1Mc0w+S31Qou9zgt/IO3TzIhoXuDUA/w8EPoM9s84n
 BSFy9kFisxdCOYr6GyOicy9zBBxWxW427mck46jWL/q8RiVJTtaG/ELLmxEwnRjMryk8
 eNnA==
X-Gm-Message-State: AOAM533GlFJn47Bd1ru5J7c/IQ1HHXjugyiDiNE6peAn26OIbUhaDueB
 B679zvbET0+BcPxbJGPLozSmOod67tuGH2CFQ6Yb4A==
X-Google-Smtp-Source: ABdhPJwseMcBhtA89/xVOfkSjI8Er/1b+WzAHYlvJAI5MGItY7qPIiQanSoTGq6Tkh3CF9f6U0apmV9yj3pMNUucrsU=
X-Received: by 2002:a17:90a:f3cb:: with SMTP id
 ha11mr3173568pjb.144.1626864335082; 
 Wed, 21 Jul 2021 03:45:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210715121209.31024-1-yong.wu@mediatek.com>
 <20210715121209.31024-7-yong.wu@mediatek.com>
In-Reply-To: <20210715121209.31024-7-yong.wu@mediatek.com>
From: Ikjoon Jang <ikjn@chromium.org>
Date: Wed, 21 Jul 2021 18:45:23 +0800
Message-ID: <CAATdQgCPunSYpxCE4ZfMBtbmyGik-AbxX+yh+F4m9EYDnCMObg@mail.gmail.com>
Subject: Re: [PATCH v2 06/11] memory: mtk-smi: Add error handle for smi_probe
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

On Thu, Jul 15, 2021 at 8:23 PM Yong Wu <yong.wu@mediatek.com> wrote:
>
> Add error handle while component_add fail.
>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>

Reviewed-by: Ikjoon Jang <ikjn@chromium.org>

> ---
> It don't have the error handle when v1. it is not a fatal error.
> thus don't add fix tags.
> ---
>  drivers/memory/mtk-smi.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
> index 6f8e582bace5..e68cbb51dd12 100644
> --- a/drivers/memory/mtk-smi.c
> +++ b/drivers/memory/mtk-smi.c
> @@ -330,7 +330,15 @@ static int mtk_smi_larb_probe(struct platform_device *pdev)
>
>         pm_runtime_enable(dev);
>         platform_set_drvdata(pdev, larb);
> -       return component_add(dev, &mtk_smi_larb_component_ops);
> +       ret = component_add(dev, &mtk_smi_larb_component_ops);
> +       if (ret)
> +               goto err_pm_disable;
> +       return 0;
> +
> +err_pm_disable:
> +       pm_runtime_disable(dev);
> +       device_link_remove(dev, larb->smi_common_dev);
> +       return ret;
>  }
>
>  static int mtk_smi_larb_remove(struct platform_device *pdev)
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
