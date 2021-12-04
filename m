Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8175CC433F5
	for <iommu@archiver.kernel.org>; Sat,  4 Dec 2021 11:48:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1085140309;
	Sat,  4 Dec 2021 11:48:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XtrmPotmdagv; Sat,  4 Dec 2021 11:48:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 6FB3E408DE;
	Sat,  4 Dec 2021 11:48:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 14CACC006E;
	Sat,  4 Dec 2021 11:48:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A5E82C0012
 for <iommu@lists.linux-foundation.org>; Sat,  4 Dec 2021 11:48:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8AC2740321
 for <iommu@lists.linux-foundation.org>; Sat,  4 Dec 2021 11:48:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id H4vKwtYlk835 for <iommu@lists.linux-foundation.org>;
 Sat,  4 Dec 2021 11:48:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A5D9E40309
 for <iommu@lists.linux-foundation.org>; Sat,  4 Dec 2021 11:48:47 +0000 (UTC)
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 6D2B54003F
 for <iommu@lists.linux-foundation.org>; Sat,  4 Dec 2021 11:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1638618524;
 bh=1lFAfFri95NobHHfuhDqwKUl/WgnOhHBeDas/mq7lKQ=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=jeMDyAlAQdwBl4jRdI0lhWG0PVK7ngCbRZ2w+4W/ovx5hTgnAYlGwRAZIsD9EdOW6
 dCt+XPn1RiDFjdjdXOnb7tyd830TdMDL144yLJZZb40reI9cfowLT4Tn4jQNmgVjxu
 kKObBSKV/hDboOp7P4tj0wtqjcWi+z7/OBQG9G4fIwEzHOg16wd/wkVGvPqFvSNadn
 F+2XsP8mi7EcSSVc8li6cDIQkQjkD03et8SOFXIfmbRGS/4TvFSdOZQZzI6OUbkl/U
 OypULsYfcH6LpgwNaN7Fnw37dHPTLX2/sg3h3s4LiJJPnfL8b0kSjkXPky2IMBPdm0
 SXY5fGqID3vBw==
Received: by mail-lj1-f200.google.com with SMTP id
 u28-20020a2ea17c000000b0021126b5cca2so2135130ljl.19
 for <iommu@lists.linux-foundation.org>; Sat, 04 Dec 2021 03:48:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=1lFAfFri95NobHHfuhDqwKUl/WgnOhHBeDas/mq7lKQ=;
 b=Ggx78Yw2fETXpJFY5m4DiXeRFMhKLnlDuDBN0h0qPcxyTmUIk3f4nuusuL5QxQbplL
 u+gSqI8KUB6lmy6/ddN2pMTmt3SSsWaBHtS2P+uS7h+GNtWpRIkcz1IXcrOAjqE6NUIP
 ya8mRcfw1VJRpWF/b8hT2gX/DKuyC1LqnbUZbhfszIbZZrmlIQhejvDEA4/4dLNhO4Gq
 L9Di3JFV9c0fFvgL+jIqBrU+H+XUiLDI2UvGR874kWSEnpaj0oIga3LmifGkeEfl3AG8
 0XlfEJ0q5dbIHxrl4PcrDhGMzGo4iwg0ZoWmrpTfVIozNsmskpYvuXHT2ETojkLuDNqr
 GAwg==
X-Gm-Message-State: AOAM5322YbDwlrQVJRH8i80hyRRRJfWq4sae3cEj2xhSyayRCn0kRbpk
 Q8vvXbvdQ6WlYcqXyv/u2es00z82ZOgP79HfCm89UsZLniWb5A7UUG/oZ07vI7yfthlMEbkCpXa
 AB45uRixocPgT5N4YzWmmdiM806q3/2OBR0p0wYzJqpXEEKU=
X-Received: by 2002:ac2:55b2:: with SMTP id y18mr22500769lfg.63.1638618523703; 
 Sat, 04 Dec 2021 03:48:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy8VY1xCGJelFHJMdlqnOnN6muluQiZeh4zdF+O15Whdka1EH+b6V5t0L4S8RYhNAMtWAAoJw==
X-Received: by 2002:ac2:55b2:: with SMTP id y18mr22500750lfg.63.1638618523478; 
 Sat, 04 Dec 2021 03:48:43 -0800 (PST)
Received: from [192.168.3.67] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
 by smtp.gmail.com with ESMTPSA id
 p26sm798181ljj.70.2021.12.04.03.48.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 04 Dec 2021 03:48:42 -0800 (PST)
Message-ID: <9631fe7c-b878-79b0-1680-80b0be089429@canonical.com>
Date: Sat, 4 Dec 2021 12:48:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH 3/4] memory: mtk-smi: Add sleep ctrl function
Content-Language: en-US
To: Yong Wu <yong.wu@mediatek.com>, Rob Herring <robh+dt@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>
References: <20211203064027.14993-1-yong.wu@mediatek.com>
 <20211203064027.14993-4-yong.wu@mediatek.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20211203064027.14993-4-yong.wu@mediatek.com>
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org, yi.kuo@mediatek.com,
 srv_heupstream@mediatek.com, Will Deacon <will@kernel.org>,
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
 iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
 lc.kan@mediatek.com, anthony.huang@mediatek.com, anan.sun@mediatek.com,
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

On 03/12/2021 07:40, Yong Wu wrote:
> sleep control means that when the larb go to sleep, we should wait a bit

s/go/goes/

> until all the current commands are finished. thus, when the larb runtime

Please start every sentence with a capital letter.

> suspend, we need enable this function to wait until all the existed

s/suspend/suspends/
s/we need enable/we need to enable/

> command are finished. when the larb resume, just disable this function.

s/command/commands/
s/resume/resumes/

> This function only improve the safe of bus. Add a new flag for this

s/improve/improves/
s/the safe/the safety/

> function. Prepare for mt8186.

In total it is hard to parse, really.

> 
> Signed-off-by: Anan Sun <anan.sun@mediatek.com>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  drivers/memory/mtk-smi.c | 39 +++++++++++++++++++++++++++++++++++----
>  1 file changed, 35 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
> index b883dcc0bbfa..4b59b28e4d73 100644
> --- a/drivers/memory/mtk-smi.c
> +++ b/drivers/memory/mtk-smi.c
> @@ -8,6 +8,7 @@
>  #include <linux/device.h>
>  #include <linux/err.h>
>  #include <linux/io.h>
> +#include <linux/iopoll.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/of_platform.h>
> @@ -32,6 +33,10 @@
>  #define SMI_DUMMY			0x444
>  
>  /* SMI LARB */
> +#define SMI_LARB_SLP_CON                0x00c
> +#define SLP_PROT_EN                     BIT(0)
> +#define SLP_PROT_RDY                    BIT(16)
> +
>  #define SMI_LARB_CMD_THRT_CON		0x24
>  #define SMI_LARB_THRT_RD_NU_LMT_MSK	GENMASK(7, 4)
>  #define SMI_LARB_THRT_RD_NU_LMT		(5 << 4)
> @@ -81,6 +86,7 @@
>  
>  #define MTK_SMI_FLAG_THRT_UPDATE	BIT(0)
>  #define MTK_SMI_FLAG_SW_FLAG		BIT(1)
> +#define MTK_SMI_FLAG_SLEEP_CTL		BIT(2)
>  #define MTK_SMI_CAPS(flags, _x)		(!!((flags) & (_x)))
>  
>  struct mtk_smi_reg_pair {
> @@ -371,6 +377,24 @@ static const struct of_device_id mtk_smi_larb_of_ids[] = {
>  	{}
>  };
>  
> +static int mtk_smi_larb_sleep_ctrl(struct device *dev, bool to_sleep)
> +{

Make two functions instead. There is no single code reuse (shared)
between sleep and resume. In the same time bool arguments are confusing
when looking at caller and one never knows whether true means to resume
or to sleep. Having two functions is obvious. Obvious code is easier to
read and maintain.

> +	struct mtk_smi_larb *larb = dev_get_drvdata(dev);
> +	int ret = 0;
> +	u32 tmp;
> +
> +	if (to_sleep) {
> +		writel_relaxed(SLP_PROT_EN, larb->base + SMI_LARB_SLP_CON);
> +		ret = readl_poll_timeout_atomic(larb->base + SMI_LARB_SLP_CON,
> +						tmp, !!(tmp & SLP_PROT_RDY), 10, 1000);
> +		if (ret)
> +			dev_warn(dev, "sleep ctrl is not ready(0x%x).\n", tmp);
> +	} else {
> +		writel_relaxed(0, larb->base + SMI_LARB_SLP_CON);
> +	}
> +	return ret;
> +}
> +
>  static int mtk_smi_device_link_common(struct device *dev, struct device **com_dev)
>  {
>  	struct platform_device *smi_com_pdev;
> @@ -477,24 +501,31 @@ static int __maybe_unused mtk_smi_larb_resume(struct device *dev)
>  {
>  	struct mtk_smi_larb *larb = dev_get_drvdata(dev);
>  	const struct mtk_smi_larb_gen *larb_gen = larb->larb_gen;
> -	int ret;
> +	int ret = 0;

This line does not have a sense.

>  
>  	ret = clk_bulk_prepare_enable(larb->smi.clk_num, larb->smi.clks);
> -	if (ret < 0)
> +	if (ret)

Why changing this?



Best regards,
Krzysztof
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
