Return-Path: <SRS0=5yIV=F3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0A44C433DB
	for <iommu@archiver.kernel.org>; Wed, 23 Dec 2020 08:32:18 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B3FF20E65
	for <iommu@archiver.kernel.org>; Wed, 23 Dec 2020 08:32:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B3FF20E65
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 958F185C77;
	Wed, 23 Dec 2020 08:32:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id U-AFQjTM9YSq; Wed, 23 Dec 2020 08:32:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 04BF185C43;
	Wed, 23 Dec 2020 08:32:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CE0A1C1787;
	Wed, 23 Dec 2020 08:32:16 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AF6DCC0893
 for <iommu@lists.linux-foundation.org>; Wed, 23 Dec 2020 08:32:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id A2B7F866CE
 for <iommu@lists.linux-foundation.org>; Wed, 23 Dec 2020 08:32:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pN-XroY6iful for <iommu@lists.linux-foundation.org>;
 Wed, 23 Dec 2020 08:32:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com
 [209.85.215.172])
 by whitealder.osuosl.org (Postfix) with ESMTPS id D29848669F
 for <iommu@lists.linux-foundation.org>; Wed, 23 Dec 2020 08:32:14 +0000 (UTC)
Received: by mail-pg1-f172.google.com with SMTP id v19so334579pgj.12
 for <iommu@lists.linux-foundation.org>; Wed, 23 Dec 2020 00:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=f6z2jHWOUsdwvkW1sMAfQ+uPvAPsBSWtcQYM5UeGKOQ=;
 b=R1Dtuprupk5qqiUMugbruG8tuTkprsynKgHI6FENUZDJPwteKI/RPbhP1u7CXwuf4u
 L2eZUc5xoe1egZtRKXhxLNCysC2nfWPgQ798UT68SUdKJM28lGqsh3znYrwyyn9m3a/x
 4vpCIEXdsq/TxF/e/vNFR3MLDzRxVnPS19Kls=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=f6z2jHWOUsdwvkW1sMAfQ+uPvAPsBSWtcQYM5UeGKOQ=;
 b=Dy/zMaFtQsfEQMgMoEHu8ipOV42dIagsCySg/SMZ7w7OGkhlKVmhC+ZJK1gmibniOv
 TKLIr8zS1h6df+qAgcGpLglEKBl6VUK6VmgH8EPnuWf4q1yJHlWlgjPEDgAZdOjfBnb+
 1H2Y7SNrhIM1ufaeDf6CpxssFkJAxldoaiyuzNVOVlShq6IASVQ88RZ5UFTerIGA5Tk6
 SiyVA9IgfOQcHdJPJ6r/WN/ZH5i1iYiwS2uKuTSLZW0tjfC0KoucNqcZ/vsQc0xiGK+f
 Npfde/cFDFNE/IrdBwvbEhOap+EIYnpBtBnaJLePslKBYTH/yJyhlB/dVivcvpYXmuc4
 g92g==
X-Gm-Message-State: AOAM533/PnwpCRqbch/P3wX8AyyPo407ZdCVHnuhZvEsQZ8vAS35B4hj
 lwgjheea2dOCea6quFq6KRW2KA==
X-Google-Smtp-Source: ABdhPJxRY0t2ecrt0qdbX6wNZyK5FMit7yNVCixLg3SFVanvhZuz5z5iGFCyfF9mG3ZV++F089pKQw==
X-Received: by 2002:a62:9208:0:b029:19e:a15f:169e with SMTP id
 o8-20020a6292080000b029019ea15f169emr23179186pfd.71.1608712334434; 
 Wed, 23 Dec 2020 00:32:14 -0800 (PST)
Received: from chromium.org ([2401:fa00:8f:2:a28c:fdff:fef0:43bf])
 by smtp.gmail.com with ESMTPSA id p187sm21556047pfp.60.2020.12.23.00.32.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Dec 2020 00:32:13 -0800 (PST)
Date: Wed, 23 Dec 2020 17:32:07 +0900
From: Tomasz Figa <tfiga@chromium.org>
To: Yong Wu <yong.wu@mediatek.com>
Subject: Re: [PATCH v5 17/27] iommu/mediatek: Add pm runtime callback
Message-ID: <X+MAh87dFsY2p8vF@chromium.org>
References: <20201209080102.26626-1-yong.wu@mediatek.com>
 <20201209080102.26626-18-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201209080102.26626-18-yong.wu@mediatek.com>
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
 Nicolas Boichat <drinkcat@chromium.org>, srv_heupstream@mediatek.com,
 Tomasz Figa <tfiga@google.com>, Will Deacon <will@kernel.org>,
 linux-kernel@vger.kernel.org, Evan Green <evgreen@chromium.org>,
 chao.hao@mediatek.com, iommu@lists.linux-foundation.org,
 Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, anan.sun@mediatek.com,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
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

On Wed, Dec 09, 2020 at 04:00:52PM +0800, Yong Wu wrote:
> This patch adds pm runtime callback.
> 
> In pm runtime case, all the registers backup/restore and bclk are
> controlled in the pm_runtime callback, then pm_suspend is not needed in
> this case.
> 
> runtime PM is disabled when suspend, thus we call
> pm_runtime_status_suspended instead of pm_runtime_suspended.
> 
> And, m4u doesn't have its special pm runtime domain in previous SoC, in
> this case dev->power.runtime_status is RPM_SUSPENDED defaultly,

This sounds wrong and could lead to hard to debug errors when the driver
is changed in the future. Would it be possible to make the behavior
consistent across the SoCs instead, so that runtime PM status is ACTIVE
when needed, even on SoCs without an IOMMU PM domain?

> thus add
> a "dev->pm_domain" checking for the SoC that has pm runtime domain.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  drivers/iommu/mtk_iommu.c | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index 5614015e5b96..6fe3ee2b2bf5 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -808,7 +808,7 @@ static int mtk_iommu_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -static int __maybe_unused mtk_iommu_suspend(struct device *dev)
> +static int __maybe_unused mtk_iommu_runtime_suspend(struct device *dev)
>  {
>  	struct mtk_iommu_data *data = dev_get_drvdata(dev);
>  	struct mtk_iommu_suspend_reg *reg = &data->reg;
> @@ -826,7 +826,7 @@ static int __maybe_unused mtk_iommu_suspend(struct device *dev)
>  	return 0;
>  }
>  
> -static int __maybe_unused mtk_iommu_resume(struct device *dev)
> +static int __maybe_unused mtk_iommu_runtime_resume(struct device *dev)
>  {
>  	struct mtk_iommu_data *data = dev_get_drvdata(dev);
>  	struct mtk_iommu_suspend_reg *reg = &data->reg;
> @@ -853,7 +853,25 @@ static int __maybe_unused mtk_iommu_resume(struct device *dev)
>  	return 0;
>  }
>  
> +static int __maybe_unused mtk_iommu_suspend(struct device *dev)
> +{
> +	/* runtime PM is disabled when suspend in pm_runtime case. */
> +	if (dev->pm_domain && pm_runtime_status_suspended(dev))
> +		return 0;
> +
> +	return mtk_iommu_runtime_suspend(dev);
> +}
> +
> +static int __maybe_unused mtk_iommu_resume(struct device *dev)
> +{
> +	if (dev->pm_domain && pm_runtime_status_suspended(dev))
> +		return 0;
> +
> +	return mtk_iommu_runtime_resume(dev);
> +}

Wouldn't it be enough to just use pm_runtime_force_suspend() and
pm_runtime_force_resume() as system sleep ops?

> +
>  static const struct dev_pm_ops mtk_iommu_pm_ops = {
> +	SET_RUNTIME_PM_OPS(mtk_iommu_runtime_suspend, mtk_iommu_runtime_resume, NULL)
>  	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(mtk_iommu_suspend, mtk_iommu_resume)
>  };
>  
> -- 
> 2.18.0
> 
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
