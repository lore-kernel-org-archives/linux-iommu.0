Return-Path: <SRS0=Vh7E=DH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFF66C2D0A8
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 07:21:57 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4441B2075F
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 07:21:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Czho7Hwz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4441B2075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 04751204B5;
	Wed, 30 Sep 2020 07:21:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VTqrCV-7eZkB; Wed, 30 Sep 2020 07:21:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 9F23320396;
	Wed, 30 Sep 2020 07:21:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 88385C016F;
	Wed, 30 Sep 2020 07:21:55 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A6720C0051
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 07:21:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 57DDD20446
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 07:21:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9v57FUAXuqIF for <iommu@lists.linux-foundation.org>;
 Wed, 30 Sep 2020 07:21:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by silver.osuosl.org (Postfix) with ESMTPS id B727120396
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 07:21:53 +0000 (UTC)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com
 [209.85.218.46])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2A4B9207C3
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 07:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1601450513;
 bh=4a1eMMEYAX2Q7JPaPum/diACL5G6etmpf/ER/kUFzFc=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=Czho7HwzyRF7Mi48JpASgGht5fus9HLOx2UtQvXNOkPDnaSEBx+TWZ+wFvlgJs1iu
 Cgi7EgdS10NBr4lKOTxku/InGl1nIa4iKqgOvtLqu/FoZroJZiDCeS+7+qA7K2a+h/
 p9Hyi7SAimqApMkz3cieHJAvh6ankpC/7KaoolxY=
Received: by mail-ej1-f46.google.com with SMTP id i26so1255560ejb.12
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 00:21:53 -0700 (PDT)
X-Gm-Message-State: AOAM532ydfZSyM1+fDUhBAsM2t/QKFvRlqVJaJ0VgLzVnV5xvbKgGT8d
 mkd2ifY2i4yjbArbTbY896CeolT6SgaExN69gOU=
X-Google-Smtp-Source: ABdhPJyETPcYXIqZ2N+Xzy7w6ZTbtg26NVcWQiK3ImgKAugFHBNnmA6vP/uftFY/WRGJMfqhGWRbK3gSMphJ2OgouGE=
X-Received: by 2002:a17:906:1984:: with SMTP id
 g4mr1410359ejd.119.1601450511650; 
 Wed, 30 Sep 2020 00:21:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200930003013.31289-1-nicoleotsuka@gmail.com>
 <20200930003013.31289-2-nicoleotsuka@gmail.com>
In-Reply-To: <20200930003013.31289-2-nicoleotsuka@gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Wed, 30 Sep 2020 09:21:39 +0200
X-Gmail-Original-Message-ID: <CAJKOXPeye7b0j1oB21JmBwc277_1RYWQ0SC0Otf+F62HK=sjjA@mail.gmail.com>
Message-ID: <CAJKOXPeye7b0j1oB21JmBwc277_1RYWQ0SC0Otf+F62HK=sjjA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] memory: tegra: Add helper function
 tegra_get_memory_controller
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 iommu@lists.linux-foundation.org, jonathanh@nvidia.com,
 thierry.reding@gmail.com, linux-tegra@vger.kernel.org, digetx@gmail.com
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

On Wed, 30 Sep 2020 at 02:35, Nicolin Chen <nicoleotsuka@gmail.com> wrote:
>
> This can be used by both tegra-smmu and tegra20-devfreq drivers.
>
> Suggested-by: Dmitry Osipenko <digetx@gmail.com>
> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> ---
>
> Changelog
> v1->v2
>  * N/A
>
>  drivers/memory/tegra/mc.c | 23 +++++++++++++++++++++++
>  include/soc/tegra/mc.h    |  1 +
>  2 files changed, 24 insertions(+)
>
> diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
> index ec8403557ed4..09352ad66dcc 100644
> --- a/drivers/memory/tegra/mc.c
> +++ b/drivers/memory/tegra/mc.c
> @@ -42,6 +42,29 @@ static const struct of_device_id tegra_mc_of_match[] = {
>  };
>  MODULE_DEVICE_TABLE(of, tegra_mc_of_match);

> +struct tegra_mc *tegra_get_memory_controller(void)
> +{

Add kerneldoc and mention dropping of reference to the device after use.

Best regards,
Krzysztof

> +       struct platform_device *pdev;
> +       struct device_node *np;
> +       struct tegra_mc *mc;
> +
> +       np = of_find_matching_node_and_match(NULL, tegra_mc_of_match, NULL);
> +       if (!np)
> +               return ERR_PTR(-ENOENT);
> +
> +       pdev = of_find_device_by_node(np);
> +       of_node_put(np);
> +       if (!pdev)
> +               return ERR_PTR(-ENODEV);
> +
> +       mc = platform_get_drvdata(pdev);
> +       if (!mc)
> +               return ERR_PTR(-EPROBE_DEFER);
> +
> +       return mc;
> +}
> +EXPORT_SYMBOL_GPL(tegra_get_memory_controller);
> +
>  static int tegra_mc_block_dma_common(struct tegra_mc *mc,
>                                      const struct tegra_mc_reset *rst)
>  {
> diff --git a/include/soc/tegra/mc.h b/include/soc/tegra/mc.h
> index 1238e35653d1..c72718fd589f 100644
> --- a/include/soc/tegra/mc.h
> +++ b/include/soc/tegra/mc.h
> @@ -183,5 +183,6 @@ struct tegra_mc {
>
>  int tegra_mc_write_emem_configuration(struct tegra_mc *mc, unsigned long rate);
>  unsigned int tegra_mc_get_emem_device_count(struct tegra_mc *mc);
> +struct tegra_mc *tegra_get_memory_controller(void);
>
>  #endif /* __SOC_TEGRA_MC_H__ */
> --
> 2.17.1
>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
