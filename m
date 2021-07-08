Return-Path: <SRS0=RnLw=MA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7270C07E99
	for <iommu@archiver.kernel.org>; Thu,  8 Jul 2021 09:32:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A03E61A14
	for <iommu@archiver.kernel.org>; Thu,  8 Jul 2021 09:32:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A03E61A14
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 37F2A6068B;
	Thu,  8 Jul 2021 09:32:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CeBwf7ggNCK9; Thu,  8 Jul 2021 09:32:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B53CF60658;
	Thu,  8 Jul 2021 09:32:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 88A89C0010;
	Thu,  8 Jul 2021 09:32:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5BA33C000E
 for <iommu@lists.linux-foundation.org>; Thu,  8 Jul 2021 09:32:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 422A683984
 for <iommu@lists.linux-foundation.org>; Thu,  8 Jul 2021 09:32:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GadJ8SkC61N7 for <iommu@lists.linux-foundation.org>;
 Thu,  8 Jul 2021 09:32:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0A8448333F
 for <iommu@lists.linux-foundation.org>; Thu,  8 Jul 2021 09:32:23 +0000 (UTC)
Received: from mail-wr1-f72.google.com ([209.85.221.72])
 by youngberry.canonical.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.93)
 (envelope-from <krzysztof.kozlowski@canonical.com>)
 id 1m1QOM-0006Xf-EM
 for iommu@lists.linux-foundation.org; Thu, 08 Jul 2021 09:32:22 +0000
Received: by mail-wr1-f72.google.com with SMTP id
 i10-20020a5d55ca0000b029013b976502b6so297763wrw.2
 for <iommu@lists.linux-foundation.org>; Thu, 08 Jul 2021 02:32:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=hivxADq7n4rAof/nBtodbPp1gcTG2fZwZu7ibesuf2Q=;
 b=mdQw4tSEvfZaDQSO77hUTJwWVO2StnaSMVqIGGzlsqi/PdMEI3QhFZbMGD4Xq/KKHu
 VLQzVRlRsFGT5l8MRFBlSzDtbtMb361HWbHWcBZJn3EReihYWnXQA7skkspuZTvph36k
 nCPmr3AFYKgtPJHyYZ8qtSGJnu1wFLVUzTcJ6Tkf9MKfiDupJ3ZahWtcnhGho0o4ZLBn
 3LQ8DuqTrWxqrc8vph/OeHLM1yWHPRClQgUrIXAp0YbDJJNK4yNwdp92zVByOlGrE1t+
 3V0puBkcuF0rewE8WVJzBNsi1bMjaYejbwrhdtN40xmptJcikJTGQvp31GnicEGpZuWO
 h6VA==
X-Gm-Message-State: AOAM531PiZ0YQzOwYC6iQOF37N3ubTtpD9vEj5LLw+tKsoYdgkLlbear
 YDp7cudj2UD3yt9jLHparDS85XcTkGV4uy1Wn7JZ+iLWMA3qTHbA2ltWymG9EcRhW3euMkO7GtB
 L2OklE3+wlW1FgSX6RH1sQs8JdeuJOBW2dJJ/8ktASPysaaM=
X-Received: by 2002:adf:8bc9:: with SMTP id w9mr32448645wra.378.1625736739768; 
 Thu, 08 Jul 2021 02:32:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwYvIhElP2QnQ1MVXp3En3sYzdzxCpW/5Qttn+9qPay8qf7fZU6RYcEzfSKQKNyg8stKaaVWw==
X-Received: by 2002:adf:8bc9:: with SMTP id w9mr32448601wra.378.1625736739535; 
 Thu, 08 Jul 2021 02:32:19 -0700 (PDT)
Received: from [192.168.3.211] (xdsl-188-155-177-222.adslplus.ch.
 [188.155.177.222])
 by smtp.gmail.com with ESMTPSA id h14sm1918435wro.32.2021.07.08.02.32.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jul 2021 02:32:19 -0700 (PDT)
Subject: Re: [PATCH 3/9] memory: mtk-smi: Use clk_bulk instead of the clk ops
To: Yong Wu <yong.wu@mediatek.com>, Rob Herring <robh+dt@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>
References: <20210616114346.18812-1-yong.wu@mediatek.com>
 <20210616114346.18812-4-yong.wu@mediatek.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <4047dfaf-f2f8-b6b2-52fd-41821475b162@canonical.com>
Date: Thu, 8 Jul 2021 11:32:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210616114346.18812-4-yong.wu@mediatek.com>
Content-Language: en-US
Cc: youlin.pei@mediatek.com, anan.sun@mediatek.com, srv_heupstream@mediatek.com,
 Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzk@kernel.org>, iommu@lists.linux-foundation.org,
 linux-mediatek@lists.infradead.org, anthony.huang@mediatek.com,
 ming-fan.chen@mediatek.com, yi.kuo@mediatek.com,
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

On 16/06/2021 13:43, Yong Wu wrote:
> smi have many clocks: apb/smi/gals.
> This patch use clk_bulk interface instead of the orginal one to simply
> the code.
> 
> gals is optional clk(some larbs may don't have gals). use clk_bulk_optional
> instead. and then remove the has_gals flag.
> 
> Also remove clk fail logs since bulk interface already output fail log.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  drivers/memory/mtk-smi.c | 124 +++++++++++----------------------------
>  1 file changed, 34 insertions(+), 90 deletions(-)
> 
> diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
> index c5fb51f73b34..bcd2bf130655 100644
> --- a/drivers/memory/mtk-smi.c
> +++ b/drivers/memory/mtk-smi.c
> @@ -60,9 +60,18 @@ enum mtk_smi_gen {
>  	MTK_SMI_GEN2
>  };
>  
> +#define MTK_SMI_CLK_NR_MAX			4
> +
> +static const char * const mtk_smi_common_clocks[] = {
> +	"apb", "smi", "gals0", "gals1", /* glas is optional */

Typo here - glas.

> +};
> +
> +static const char * const mtk_smi_larb_clocks[] = {
> +	"apb",  "smi", "gals"
> +};
> +
>  struct mtk_smi_common_plat {
>  	enum mtk_smi_gen gen;
> -	bool             has_gals;
>  	u32              bus_sel; /* Balance some larbs to enter mmu0 or mmu1 */
>  };
>  
> @@ -70,13 +79,12 @@ struct mtk_smi_larb_gen {
>  	int port_in_larb[MTK_LARB_NR_MAX + 1];
>  	void (*config_port)(struct device *dev);
>  	unsigned int			larb_direct_to_common_mask;
> -	bool				has_gals;
>  };
>  
>  struct mtk_smi {
>  	struct device			*dev;
> -	struct clk			*clk_apb, *clk_smi;
> -	struct clk			*clk_gals0, *clk_gals1;
> +	unsigned int			clk_num;
> +	struct clk_bulk_data		clks[MTK_SMI_CLK_NR_MAX];
>  	struct clk			*clk_async; /*only needed by mt2701*/
>  	union {
>  		void __iomem		*smi_ao_base; /* only for gen1 */
> @@ -95,45 +103,6 @@ struct mtk_smi_larb { /* larb: local arbiter */
>  	unsigned char			*bank;
>  };
>  
> -static int mtk_smi_clk_enable(const struct mtk_smi *smi)
> -{
> -	int ret;
> -
> -	ret = clk_prepare_enable(smi->clk_apb);
> -	if (ret)
> -		return ret;
> -
> -	ret = clk_prepare_enable(smi->clk_smi);
> -	if (ret)
> -		goto err_disable_apb;
> -
> -	ret = clk_prepare_enable(smi->clk_gals0);
> -	if (ret)
> -		goto err_disable_smi;
> -
> -	ret = clk_prepare_enable(smi->clk_gals1);
> -	if (ret)
> -		goto err_disable_gals0;
> -
> -	return 0;
> -
> -err_disable_gals0:
> -	clk_disable_unprepare(smi->clk_gals0);
> -err_disable_smi:
> -	clk_disable_unprepare(smi->clk_smi);
> -err_disable_apb:
> -	clk_disable_unprepare(smi->clk_apb);
> -	return ret;
> -}
> -
> -static void mtk_smi_clk_disable(const struct mtk_smi *smi)
> -{
> -	clk_disable_unprepare(smi->clk_gals1);
> -	clk_disable_unprepare(smi->clk_gals0);
> -	clk_disable_unprepare(smi->clk_smi);
> -	clk_disable_unprepare(smi->clk_apb);
> -}
> -
>  int mtk_smi_larb_get(struct device *larbdev)
>  {
>  	int ret = pm_runtime_resume_and_get(larbdev);
> @@ -270,7 +239,6 @@ static const struct mtk_smi_larb_gen mtk_smi_larb_mt6779 = {
>  };
>  
>  static const struct mtk_smi_larb_gen mtk_smi_larb_mt8183 = {
> -	.has_gals                   = true,
>  	.config_port                = mtk_smi_larb_config_port_gen2_general,
>  	.larb_direct_to_common_mask = BIT(2) | BIT(3) | BIT(7),
>  				      /* IPU0 | IPU1 | CCU */
> @@ -320,6 +288,7 @@ static int mtk_smi_larb_probe(struct platform_device *pdev)
>  	struct device_node *smi_node;
>  	struct platform_device *smi_pdev;
>  	struct device_link *link;
> +	int i, ret;
>  
>  	larb = devm_kzalloc(dev, sizeof(*larb), GFP_KERNEL);
>  	if (!larb)
> @@ -331,22 +300,14 @@ static int mtk_smi_larb_probe(struct platform_device *pdev)
>  	if (IS_ERR(larb->base))
>  		return PTR_ERR(larb->base);
>  
> -	larb->smi.clk_apb = devm_clk_get(dev, "apb");
> -	if (IS_ERR(larb->smi.clk_apb))
> -		return PTR_ERR(larb->smi.clk_apb);
> -
> -	larb->smi.clk_smi = devm_clk_get(dev, "smi");
> -	if (IS_ERR(larb->smi.clk_smi))
> -		return PTR_ERR(larb->smi.clk_smi);
> -
> -	if (larb->larb_gen->has_gals) {
> -		/* The larbs may still haven't gals even if the SoC support.*/
> -		larb->smi.clk_gals0 = devm_clk_get(dev, "gals");
> -		if (PTR_ERR(larb->smi.clk_gals0) == -ENOENT)
> -			larb->smi.clk_gals0 = NULL;
> -		else if (IS_ERR(larb->smi.clk_gals0))
> -			return PTR_ERR(larb->smi.clk_gals0);
> -	}
> +	larb->smi.clk_num = ARRAY_SIZE(mtk_smi_larb_clocks);
> +	for (i = 0; i < larb->smi.clk_num; i++)
> +		larb->smi.clks[i].id = mtk_smi_larb_clocks[i];
> +
> +	ret = devm_clk_bulk_get_optional(dev, larb->smi.clk_num, larb->smi.clks);
> +	if (ret)
> +		return ret;
> +
>  	larb->smi.dev = dev;
>  
>  	smi_node = of_parse_phandle(dev->of_node, "mediatek,smi", 0);
> @@ -391,11 +352,9 @@ static int __maybe_unused mtk_smi_larb_resume(struct device *dev)
>  	const struct mtk_smi_larb_gen *larb_gen = larb->larb_gen;
>  	int ret;
>  
> -	ret = mtk_smi_clk_enable(&larb->smi);
> -	if (ret < 0) {
> -		dev_err(dev, "Failed to enable clock(%d).\n", ret);
> +	ret = clk_bulk_prepare_enable(larb->smi.clk_num, larb->smi.clks);
> +	if (ret < 0)
>  		return ret;
> -	}
>  
>  	/* Configure the basic setting for this larb */
>  	larb_gen->config_port(dev);
> @@ -407,7 +366,7 @@ static int __maybe_unused mtk_smi_larb_suspend(struct device *dev)
>  {
>  	struct mtk_smi_larb *larb = dev_get_drvdata(dev);
>  
> -	mtk_smi_clk_disable(&larb->smi);
> +	clk_bulk_disable_unprepare(larb->smi.clk_num, larb->smi.clks);
>  	return 0;
>  }
>  
> @@ -437,21 +396,18 @@ static const struct mtk_smi_common_plat mtk_smi_common_gen2 = {
>  
>  static const struct mtk_smi_common_plat mtk_smi_common_mt6779 = {
>  	.gen		= MTK_SMI_GEN2,
> -	.has_gals	= true,
>  	.bus_sel	= F_MMU1_LARB(1) | F_MMU1_LARB(2) | F_MMU1_LARB(4) |
>  			  F_MMU1_LARB(5) | F_MMU1_LARB(6) | F_MMU1_LARB(7),
>  };
>  
>  static const struct mtk_smi_common_plat mtk_smi_common_mt8183 = {
>  	.gen      = MTK_SMI_GEN2,
> -	.has_gals = true,
>  	.bus_sel  = F_MMU1_LARB(1) | F_MMU1_LARB(2) | F_MMU1_LARB(5) |
>  		    F_MMU1_LARB(7),
>  };
>  
>  static const struct mtk_smi_common_plat mtk_smi_common_mt8192 = {
>  	.gen      = MTK_SMI_GEN2,
> -	.has_gals = true,
>  	.bus_sel  = F_MMU1_LARB(1) | F_MMU1_LARB(2) | F_MMU1_LARB(5) |
>  		    F_MMU1_LARB(6),
>  };
> @@ -493,7 +449,7 @@ static int mtk_smi_common_probe(struct platform_device *pdev)
>  	struct device *dev = &pdev->dev;
>  	struct mtk_smi *common;
>  	struct resource *res;
> -	int ret;
> +	int i, ret;
>  
>  	common = devm_kzalloc(dev, sizeof(*common), GFP_KERNEL);
>  	if (!common)
> @@ -501,23 +457,13 @@ static int mtk_smi_common_probe(struct platform_device *pdev)
>  	common->dev = dev;
>  	common->plat = of_device_get_match_data(dev);
>  
> -	common->clk_apb = devm_clk_get(dev, "apb");
> -	if (IS_ERR(common->clk_apb))
> -		return PTR_ERR(common->clk_apb);
> -
> -	common->clk_smi = devm_clk_get(dev, "smi");
> -	if (IS_ERR(common->clk_smi))
> -		return PTR_ERR(common->clk_smi);
> +	common->clk_num = ARRAY_SIZE(mtk_smi_common_clocks);
> +	for (i = 0; i < common->clk_num; i++)
> +		common->clks[i].id = mtk_smi_common_clocks[i];
>  
> -	if (common->plat->has_gals) {
> -		common->clk_gals0 = devm_clk_get(dev, "gals0");
> -		if (IS_ERR(common->clk_gals0))
> -			return PTR_ERR(common->clk_gals0);
> -
> -		common->clk_gals1 = devm_clk_get(dev, "gals1");
> -		if (IS_ERR(common->clk_gals1))
> -			return PTR_ERR(common->clk_gals1);
> -	}
> +	ret = devm_clk_bulk_get_optional(dev, common->clk_num, common->clks);
> +	if (ret)
> +		return ret;

How do you handle now missing required clocks?

>  
>  	/*
>  	 * for mtk smi gen 1, we need to get the ao(always on) base to config
> @@ -561,11 +507,9 @@ static int __maybe_unused mtk_smi_common_resume(struct device *dev)
>  	u32 bus_sel = common->plat->bus_sel;
>  	int ret;
>  
> -	ret = mtk_smi_clk_enable(common);
> -	if (ret) {
> -		dev_err(common->dev, "Failed to enable clock(%d).\n", ret);
> +	ret = clk_bulk_prepare_enable(common->clk_num, common->clks);
> +	if (ret)
>  		return ret;
> -	}
>  
>  	if (common->plat->gen == MTK_SMI_GEN2 && bus_sel)
>  		writel(bus_sel, common->base + SMI_BUS_SEL);
> @@ -576,7 +520,7 @@ static int __maybe_unused mtk_smi_common_suspend(struct device *dev)
>  {
>  	struct mtk_smi *common = dev_get_drvdata(dev);
>  
> -	mtk_smi_clk_disable(common);
> +	clk_bulk_disable_unprepare(common->clk_num, common->clks);
>  	return 0;
>  }
>  
> 


Best regards,
Krzysztof
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
