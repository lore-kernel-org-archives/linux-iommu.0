Return-Path: <SRS0=Vh7E=DH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BCEAC47426
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 09:07:51 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82D7720754
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 09:07:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="fAaNPtZY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82D7720754
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id E20A6866FB;
	Wed, 30 Sep 2020 09:07:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kVWQF2vA+GlF; Wed, 30 Sep 2020 09:07:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 94A0186750;
	Wed, 30 Sep 2020 09:07:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6B684C0890;
	Wed, 30 Sep 2020 09:07:48 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C1BF8C016F
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 09:07:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 94CC2871BF
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 09:07:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lOG+3Ev2x6o0 for <iommu@lists.linux-foundation.org>;
 Wed, 30 Sep 2020 09:07:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by hemlock.osuosl.org (Postfix) with ESMTPS id EF83D871AD
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 09:07:45 +0000 (UTC)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com
 [209.85.208.48])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 38C1D20719
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 09:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1601456865;
 bh=QoRVG2ebL4cYUkaDCdQ+XmLDYvdbkAU8qZxPoMO2OvA=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=fAaNPtZYczrVnTRPGPKuBg2P1dPhUVHEUL1d0LXPrJcOo267+aOR5jgZ/OFb2dXO+
 WmRQqT547I44Af3QcPadn9HEr18c4x+4bs8/rQGIyNCwBJVwlyxXRUIx3pfkrmYYEY
 HuTmfdLzO44aNkMdWbUGq2sp926bRQlqe4lC5mQk=
Received: by mail-ed1-f48.google.com with SMTP id c8so1004173edv.5
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 02:07:45 -0700 (PDT)
X-Gm-Message-State: AOAM5331UVdSXLuom2vrFTHOvPeGfB32kUAA8MI3ADxRCpExFpyNQ2Rb
 GEt3RxoDir+XxVNJPi15jFBXm8uCTHpeseBUGlU=
X-Google-Smtp-Source: ABdhPJy99itcN7QqkgpBPHPZKE/4+UE/c02bs+SRlW4UIgty1u286CHggezxKIpL5nZfYg2asdRVfKIYnaN7peEAvas=
X-Received: by 2002:aa7:da16:: with SMTP id r22mr1692538eds.132.1601456863786; 
 Wed, 30 Sep 2020 02:07:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200930084258.25493-1-nicoleotsuka@gmail.com>
 <20200930084258.25493-2-nicoleotsuka@gmail.com>
In-Reply-To: <20200930084258.25493-2-nicoleotsuka@gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Wed, 30 Sep 2020 11:07:32 +0200
X-Gmail-Original-Message-ID: <CAJKOXPd7XSAty_2_6i3bEcoRwJ9HdoE+TKGu1G6ozZ9xYC7M6Q@mail.gmail.com>
Message-ID: <CAJKOXPd7XSAty_2_6i3bEcoRwJ9HdoE+TKGu1G6ozZ9xYC7M6Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] memory: tegra: Add
 devm_tegra_get_memory_controller()
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

"On Wed, 30 Sep 2020 at 10:48, Nicolin Chen <nicoleotsuka@gmail.com> wrote:
>
> From: Dmitry Osipenko <digetx@gmail.com>
>
> Multiple Tegra drivers need to retrieve Memory Controller and hence there
> is quite some duplication of the retrieval code among the drivers. Let's
> add a new common helper for the retrieval of the MC.
>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> ---
>
> Changelog
> v2->v3:
>  * Replaced with Dimtry's devm_tegra_get_memory_controller()
> v1->v2:
>  * N/A
>
>  drivers/memory/tegra/mc.c | 39 +++++++++++++++++++++++++++++++++++++++
>  include/soc/tegra/mc.h    | 17 +++++++++++++++++
>  2 files changed, 56 insertions(+)
>
> diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
> index ec8403557ed4..dd691dc3738e 100644
> --- a/drivers/memory/tegra/mc.c
> +++ b/drivers/memory/tegra/mc.c
> @@ -42,6 +42,45 @@ static const struct of_device_id tegra_mc_of_match[] = {
>  };
>  MODULE_DEVICE_TABLE(of, tegra_mc_of_match);
>
> +static void tegra_mc_devm_action_put_device(void *data)

devm_tegra_memory_controller_put()

> +{
> +       struct tegra_mc *mc = data;
> +
> +       put_device(mc->dev);
> +}
> +
> +struct tegra_mc *devm_tegra_get_memory_controller(struct device *dev)

Usually 'get' is a suffix (e.g. clk, gpiod, iio, led), so:
devm_tegra_memory_controller_get()

> +{
> +       struct platform_device *pdev;
> +       struct device_node *np;
> +       struct tegra_mc *mc;
> +       int err;
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
> +       if (!mc) {
> +               put_device(mc->dev);
> +               return ERR_PTR(-EPROBE_DEFER);
> +       }
> +
> +       err = devm_add_action(dev, tegra_mc_devm_action_put_device, mc);
> +       if (err) {
> +               put_device(mc->dev);
> +               return ERR_PTR(err);
> +       }
> +
> +       return mc;
> +}
> +EXPORT_SYMBOL_GPL(devm_tegra_get_memory_controller);
> +
>  static int tegra_mc_block_dma_common(struct tegra_mc *mc,
>                                      const struct tegra_mc_reset *rst)
>  {
> diff --git a/include/soc/tegra/mc.h b/include/soc/tegra/mc.h
> index 1238e35653d1..c05142e3e244 100644
> --- a/include/soc/tegra/mc.h
> +++ b/include/soc/tegra/mc.h
> @@ -184,4 +184,21 @@ struct tegra_mc {
>  int tegra_mc_write_emem_configuration(struct tegra_mc *mc, unsigned long rate);
>  unsigned int tegra_mc_get_emem_device_count(struct tegra_mc *mc);
>
> +#ifdef CONFIG_TEGRA_MC
> +/**
> + * devm_tegra_get_memory_controller() - Get the tegra_mc pointer.
> + * @dev: Device that will be interacted with

This is not precise enough and there is no interaction with 'dev' in
devm_tegra_get_memory_controller(). Something like: "Device that owns
the pointer to tegra memory controller"

> + *
> + * Return: ERR_PTR() on error or a valid pointer to a struct tegra_mc.
> + *
> + * The mc->dev counter will be automatically put by the device management code.

1. s/mc/tegra_mc/ (it's the first occurence of word mc here)
2. "kerneldoc goes to the C file". Not to the header.

Best regards,
Krzysztof
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
