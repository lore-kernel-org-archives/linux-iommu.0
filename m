Return-Path: <SRS0=soV1=JQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC2E7C43461
	for <iommu@archiver.kernel.org>; Mon, 19 Apr 2021 07:07:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2183C6101D
	for <iommu@archiver.kernel.org>; Mon, 19 Apr 2021 07:07:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2183C6101D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atmark-techno.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 568A4403CD;
	Mon, 19 Apr 2021 07:07:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id K692AAUvaHvU; Mon, 19 Apr 2021 07:07:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8AE3B403A4;
	Mon, 19 Apr 2021 07:07:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 19E24C0019;
	Mon, 19 Apr 2021 07:07:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 20163C000B
 for <iommu@lists.linux-foundation.org>; Mon, 19 Apr 2021 05:03:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EFBA9607A4
 for <iommu@lists.linux-foundation.org>; Mon, 19 Apr 2021 05:03:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0qeFOTDDC2EN for <iommu@lists.linux-foundation.org>;
 Mon, 19 Apr 2021 05:03:13 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from gw.atmark-techno.com (gw.atmark-techno.com [13.115.124.170])
 by smtp3.osuosl.org (Postfix) with ESMTP id D4AB9607A2
 for <iommu@lists.linux-foundation.org>; Mon, 19 Apr 2021 05:03:12 +0000 (UTC)
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72])
 by gw.atmark-techno.com (Postfix) with ESMTPS id DC9D6804C6
 for <iommu@lists.linux-foundation.org>; Mon, 19 Apr 2021 14:03:11 +0900 (JST)
Received: by mail-ua1-f72.google.com with SMTP id
 o9-20020ab054490000b02901ec47f004b2so76382uaa.17
 for <iommu@lists.linux-foundation.org>; Sun, 18 Apr 2021 22:03:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=bLr973ENjFZQNNz5/z+BmoCFuTDVovYaAYguOO0YOc4=;
 b=toOQ4ntlG0GbVZ7MTmv4ERbe2jTSpygWx24eEj/MBvhE4yIwhirA3PsVMNiZwSrUeO
 uJPLYbCqciZ4YdL/2FdglqMtyLnpdeXiLg52BuC7SYjJAkX/3XabhBLT0Sxw4YTMRk/c
 AJjCCYKRm+4mCKHNcJtqyVfMqxspaDKVsFFz4odaieKk2yZwEnhOjXKj0icGH1cPQEFm
 OMibiunuHGYrpEApRQGe0sREH/cFuBpii/wDGYTwC0bFmRdqWKS4n3rEMr+Rm0tQn7CF
 6xUS19Jgs+lPxNgZE1mymiNkV8SdV9aYLgBms4jZiEwLh4NvP2qhoQP5fApInVjHr13s
 bYEg==
X-Gm-Message-State: AOAM531Od3lFnJXUb5UDuLq9NT08ZJNorYSCzYuLikCAUQ+cSn6rccEb
 F+wglXfF8sSXkubnYrffwwl/X3jxiuXEJ45673UtIUIfui25LaAQ1FufTkmYwyJjz3+xgJtqbGh
 pzPU8oZgJtl2bXpKX8410fd/+2Pds5GccHg==
X-Received: by 2002:a17:902:d645:b029:e8:ec90:d097 with SMTP id
 y5-20020a170902d645b02900e8ec90d097mr21074789plh.47.1618808579507; 
 Sun, 18 Apr 2021 22:02:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyI1MeNQhpXnytM5xmVsw3ZCkrTxMPyrxhKroAVtmGUaPe01xpWL31HOX4hl1pxmvtORo+KDQ==
X-Received: by 2002:a17:902:d645:b029:e8:ec90:d097 with SMTP id
 y5-20020a170902d645b02900e8ec90d097mr21074765plh.47.1618808579243; 
 Sun, 18 Apr 2021 22:02:59 -0700 (PDT)
Received: from pc-0115 (103.131.189.35.bc.googleusercontent.com.
 [35.189.131.103])
 by smtp.gmail.com with ESMTPSA id ga21sm2553351pjb.5.2021.04.18.22.02.58
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 18 Apr 2021 22:02:58 -0700 (PDT)
Received: from martinet by pc-0115 with local (Exim 4.94)
 (envelope-from <martinet@pc-0115>)
 id 1lYM3l-0016Ra-6N; Mon, 19 Apr 2021 14:02:57 +0900
Date: Mon, 19 Apr 2021 14:02:47 +0900
From: Dominique MARTINET <dominique.martinet@atmark-techno.com>
To: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Subject: Re: [RFC v1 PATCH 3/3] driver: update all the code that use
 soc_device_match
Message-ID: <YH0O907dfGY9jQRZ@atmark-techno.com>
References: <20210419042722.27554-1-alice.guo@oss.nxp.com>
 <20210419042722.27554-4-alice.guo@oss.nxp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210419042722.27554-4-alice.guo@oss.nxp.com>
X-Mailman-Approved-At: Mon, 19 Apr 2021 07:07:20 +0000
Cc: ulf.hansson@linaro.org, aymen.sghaier@nxp.com, geert+renesas@glider.be,
 rafael@kernel.org, airlied@linux.ie, mturquette@baylibre.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 a.hajda@samsung.com, netdev@vger.kernel.org, linux-phy@lists.infradead.org,
 will@kernel.org, linux-clk@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 wim@linux-watchdog.org, herbert@gondor.apana.org.au, horia.geanta@nxp.com,
 khilman@baylibre.com, narmstrong@baylibre.com, linux-staging@lists.linux.dev,
 iommu@lists.linux-foundation.org, peter.ujfalusi@gmail.com, kishon@ti.com,
 tony@atomide.com, linux-omap@vger.kernel.org, stern@rowland.harvard.edu,
 kuba@kernel.org, linus.walleij@linaro.org, linux@roeck-us.net,
 linux-media@vger.kernel.org, linux-watchdog@vger.kernel.org,
 Roy.Pledge@nxp.com, linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 edubezval@gmail.com, linux-gpio@vger.kernel.org,
 linux-mediatek@lists.infradead.org, ssantosh@kernel.org,
 matthias.bgg@gmail.com, linux-amlogic@lists.infradead.org, mchehab@kernel.org,
 linux-arm-kernel@lists.infradead.org, balbi@kernel.org, tomba@kernel.org,
 sboyd@kernel.org, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
 linux-mmc@vger.kernel.org, adrian.hunter@intel.com, robert.foss@linaro.org,
 leoyang.li@nxp.com, linux@prisktech.co.nz, vkoul@kernel.org,
 linux-crypto@vger.kernel.org, daniel@ffwll.ch, j-keerthy@ti.com,
 dmaengine@vger.kernel.org, jyri.sarha@iki.fi, davem@davemloft.net
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

Alice Guo (OSS) wrote on Mon, Apr 19, 2021 at 12:27:22PM +0800:
> From: Alice Guo <alice.guo@nxp.com>
> 
> Update all the code that use soc_device_match

A single patch might be difficult to accept for all components, a each
maintainer will probably want to have a say on their subsystem?

I would suggest to split these for a non-RFC version; a this will really
need to be case-by-case handling.

> because add support for soc_device_match returning -EPROBE_DEFER.

(English does not parse here for me)

I've only commented a couple of places in the code itself, but this
doesn't seem to add much support for errors, just sweep the problem
under the rug.

> Signed-off-by: Alice Guo <alice.guo@nxp.com>
> ---
> 
> diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
> index 5fae60f8c135..00c59aa217c1 100644
> --- a/drivers/bus/ti-sysc.c
> +++ b/drivers/bus/ti-sysc.c
> @@ -2909,7 +2909,7 @@ static int sysc_init_soc(struct sysc *ddata)
>  	}
>  
>  	match = soc_device_match(sysc_soc_feat_match);
> -	if (!match)
> +	if (!match || IS_ERR(match))
>  		return 0;

This function handles errors, I would recommend returning the error as
is if soc_device_match returned one so the probe can be retried later.

>  
>  	if (match->data)
> diff --git a/drivers/clk/renesas/r8a7795-cpg-mssr.c b/drivers/clk/renesas/r8a7795-cpg-mssr.c
> index c32d2c678046..90a18336a4c3 100644
> --- a/drivers/clk/renesas/r8a7795-cpg-mssr.c
> +++ b/drivers/clk/renesas/r8a7795-cpg-mssr.c
> @@ -439,6 +439,7 @@ static const unsigned int r8a7795es2_mod_nullify[] __initconst = {
>  
>  static int __init r8a7795_cpg_mssr_init(struct device *dev)
>  {
> +	const struct soc_device_attribute *match;
>  	const struct rcar_gen3_cpg_pll_config *cpg_pll_config;
>  	u32 cpg_mode;
>  	int error;
> @@ -453,7 +454,8 @@ static int __init r8a7795_cpg_mssr_init(struct device *dev)
>  		return -EINVAL;
>  	}
>  
> -	if (soc_device_match(r8a7795es1)) {
> +	match = soc_device_match(r8a7795es1);
> +	if (!IS_ERR(match) && match) {

Same, return the error.
Assuming an error means no match will just lead to hard to debug
problems because the driver potentially assumed the wrong device when
it's just not ready yet.

>  		cpg_core_nullify_range(r8a7795_core_clks,
>  				       ARRAY_SIZE(r8a7795_core_clks),
>  				       R8A7795_CLK_S0D2, R8A7795_CLK_S0D12);
> [...]
> diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
> index eaaec0a55cc6..13a06b613379 100644
> --- a/drivers/iommu/ipmmu-vmsa.c
> +++ b/drivers/iommu/ipmmu-vmsa.c
> @@ -757,17 +757,20 @@ static const char * const devices_allowlist[] = {
>  
>  static bool ipmmu_device_is_allowed(struct device *dev)
>  {
> +	const struct soc_device_attribute *match1, *match2;
>  	unsigned int i;
>  
>  	/*
>  	 * R-Car Gen3 and RZ/G2 use the allow list to opt-in devices.
>  	 * For Other SoCs, this returns true anyway.
>  	 */
> -	if (!soc_device_match(soc_needs_opt_in))
> +	match1 = soc_device_match(soc_needs_opt_in);
> +	if (!IS_ERR(match1) && !match1)

I'm not sure what you intended to do, but !match1 already means there is
no error so the original code is identical.

In this case ipmmu_device_is_allowed does not allow errors so this is
one of the "difficult" drivers that require slightly more thinking.
It is only called in ipmmu_of_xlate which does return errors properly,
so in this case the most straightforward approach would be to make
ipmmu_device_is_allowed return an int and forward errors as well.



...
This is going to need quite some more work to be acceptable, in my
opinion, but I think it should be possible.

Thanks,
-- 
Dominique
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
