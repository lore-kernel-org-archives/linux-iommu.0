Return-Path: <SRS0=Ni9g=YC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D512ECE58D
	for <iommu@archiver.kernel.org>; Wed,  9 Oct 2019 08:22:18 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 399662190F
	for <iommu@archiver.kernel.org>; Wed,  9 Oct 2019 08:22:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cdi+f4aC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 399662190F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 08D98C2C;
	Wed,  9 Oct 2019 08:22:18 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 5F529C03
	for <iommu@lists.linux-foundation.org>;
	Wed,  9 Oct 2019 08:22:17 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-qk1-f196.google.com (mail-qk1-f196.google.com
	[209.85.222.196])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 5B61614D
	for <iommu@lists.linux-foundation.org>;
	Wed,  9 Oct 2019 08:22:15 +0000 (UTC)
Received: by mail-qk1-f196.google.com with SMTP id w2so1426377qkf.2
	for <iommu@lists.linux-foundation.org>;
	Wed, 09 Oct 2019 01:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=2vS6ftWv38t6sGsCONON8A/FlGoTEEeUhyw2u38Psys=;
	b=Cdi+f4aCoQax6/k08emQ2lJLcJma2WQWPj2sDWaUAIyNxc1z4FKB8BqfKmJ9Z5SarE
	DE3N/4o2O2mNISHES1onvLTvuRpQiyEXHitSlBua8rinA6JART4GoBf7vdEvu+n7rN9U
	XvCz6sm2vxFbnosUIiTDnUCTP07dZZ94GVayWBBS7bbGQdwhuhTe2jwZepH8sWdDtNgP
	G5SCwFbB+xNM+G2nK1s/aU9B2cvG+KpT0+/ggvOzIUE441IEmQK1CKPgRbnFUH/5+41b
	b45CSPFkm3mrlWBB2+nVpXXqESBNOTSmaanoB4L6eg4BXILbn5BcpREj3YdWgO9VnM0i
	6Obg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=2vS6ftWv38t6sGsCONON8A/FlGoTEEeUhyw2u38Psys=;
	b=sGA8zrNbtRbTAe7PHBhgbtmjFrnTIrCN7CwSfa6m74wOqAf1EcwPOcwWNxJYquR6Wf
	rxAYnTn9obizrMf4vQQZBjLzhjYMghksx796VPySAH83T8w5KXuGrjs1qLjRaNOcCW7A
	AEnE9ga8S8QtMfm+yKCYiwKZQzzmZ2+IPNABfnYQNP8A6888mnmWnP/0QoypLf2i2SRA
	gc+CHQtOZJskSnIZhpW3bRppkZ+P8AJiyYOiOepOQM1g89ljMbFNIEzViYss/G19TGoC
	WWqgEalsgfl8qU1I0LUAvV/EC+WIyNyoYo9xxhiH28su1UrTM8QDSWGHeHBZeR6opyMr
	aSSw==
X-Gm-Message-State: APjAAAWcacSWajNJ2xd0L5EiqLkh8JmtdciciO+dRohcYq4bADmWeDmQ
	bMhObAIZYGPbvT0XUD/5V+QumPX68lsVOtHjpGc=
X-Google-Smtp-Source: APXvYqxsOXmemHID6heONiV8vI+KimCDKqoQrtNjmYG58JhuwE01IW+RdWPgGIjDI48XZ9ZREJZcjouZaIm3zI7sOfA=
X-Received: by 2002:a05:620a:a55:: with SMTP id
	j21mr2361419qka.402.1570609334042; 
	Wed, 09 Oct 2019 01:22:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190925184346.14121-1-heiko@sntech.de>
In-Reply-To: <20190925184346.14121-1-heiko@sntech.de>
From: Enric Balletbo Serra <eballetbo@gmail.com>
Date: Wed, 9 Oct 2019 10:22:02 +0200
Message-ID: <CAFqH_53xE7fH-Mf0_qokamUCBNDedadSLQa=uxiP_v7TW7DPfw@mail.gmail.com>
Subject: Re: [PATCH] iommu/rockchip: don't use platform_get_irq to implicitly
	count irqs
To: Heiko Stuebner <heiko@sntech.de>
Cc: "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
	iommu@lists.linux-foundation.org,
	Linux ARM <linux-arm-kernel@lists.infradead.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Hi,

Missatge de Heiko Stuebner <heiko@sntech.de> del dia dc., 25 de set.
2019 a les 20:44:
>
> Till now the Rockchip iommu driver walked through the irq list via
> platform_get_irq() until it encountered an ENXIO error. With the
> recent change to add a central error message, this always results
> in such an error for each iommu on probe and shutdown.
>
> To not confuse people, switch to platform_count_irqs() to get the
> actual number of interrupts before walking through them.
>
> Fixes: 7723f4c5ecdb ("driver core: platform: Add an error message to platform_get_irq*()")
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---

This patch definitely removes the annoying messages on my Samsung
Chromebook Plus like:

 rk_iommu ff924000.iommu: IRQ index 1 not found
 rk_iommu ff914000.iommu: IRQ index 1 not found
 rk_iommu ff903f00.iommu: IRQ index 1 not found
 rk_iommu ff8f3f00.iommu: IRQ index 1 not found
 rk_iommu ff650800.iommu: IRQ index 1 not found

FWIW, I sent a similar patch [1] to fix this, but can be rejected in
favour of the Heiko's patch. So,

Tested-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Thanks,
 Enric

[1] https://lkml.org/lkml/2019/10/8/551

>  drivers/iommu/rockchip-iommu.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
> index 26290f310f90..4dcbf68dfda4 100644
> --- a/drivers/iommu/rockchip-iommu.c
> +++ b/drivers/iommu/rockchip-iommu.c
> @@ -100,6 +100,7 @@ struct rk_iommu {
>         struct device *dev;
>         void __iomem **bases;
>         int num_mmu;
> +       int num_irq;
>         struct clk_bulk_data *clocks;
>         int num_clocks;
>         bool reset_disabled;
> @@ -1136,7 +1137,7 @@ static int rk_iommu_probe(struct platform_device *pdev)
>         struct rk_iommu *iommu;
>         struct resource *res;
>         int num_res = pdev->num_resources;
> -       int err, i, irq;
> +       int err, i;
>
>         iommu = devm_kzalloc(dev, sizeof(*iommu), GFP_KERNEL);
>         if (!iommu)
> @@ -1163,6 +1164,10 @@ static int rk_iommu_probe(struct platform_device *pdev)
>         if (iommu->num_mmu == 0)
>                 return PTR_ERR(iommu->bases[0]);
>
> +       iommu->num_irq = platform_irq_count(pdev);
> +       if (iommu->num_irq < 0)
> +               return iommu->num_irq;
> +
>         iommu->reset_disabled = device_property_read_bool(dev,
>                                         "rockchip,disable-mmu-reset");
>
> @@ -1219,8 +1224,9 @@ static int rk_iommu_probe(struct platform_device *pdev)
>
>         pm_runtime_enable(dev);
>
> -       i = 0;
> -       while ((irq = platform_get_irq(pdev, i++)) != -ENXIO) {
> +       for (i = 0; i < iommu->num_irq; i++) {
> +               int irq = platform_get_irq(pdev, i);
> +
>                 if (irq < 0)
>                         return irq;
>
> @@ -1245,10 +1251,13 @@ static int rk_iommu_probe(struct platform_device *pdev)
>  static void rk_iommu_shutdown(struct platform_device *pdev)
>  {
>         struct rk_iommu *iommu = platform_get_drvdata(pdev);
> -       int i = 0, irq;
> +       int i;
> +
> +       for (i = 0; i < iommu->num_irq; i++) {
> +               int irq = platform_get_irq(pdev, i);
>
> -       while ((irq = platform_get_irq(pdev, i++)) != -ENXIO)
>                 devm_free_irq(iommu->dev, irq, iommu);
> +       }
>
>         pm_runtime_force_suspend(&pdev->dev);
>  }
> --
> 2.23.0
>
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
