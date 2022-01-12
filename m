Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52E9BC433F5
	for <iommu@archiver.kernel.org>; Wed, 12 Jan 2022 10:28:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0969D409CC;
	Wed, 12 Jan 2022 10:28:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hc9Y91x_VxZh; Wed, 12 Jan 2022 10:28:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 66945409A9;
	Wed, 12 Jan 2022 10:28:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 38E30C0030;
	Wed, 12 Jan 2022 10:28:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0F26EC001E
 for <iommu@lists.linux-foundation.org>; Wed, 12 Jan 2022 10:28:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F1E8D408D8
 for <iommu@lists.linux-foundation.org>; Wed, 12 Jan 2022 10:28:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=canonical.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id T77o-_h5gtS6 for <iommu@lists.linux-foundation.org>;
 Wed, 12 Jan 2022 10:28:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2838C4049F
 for <iommu@lists.linux-foundation.org>; Wed, 12 Jan 2022 10:28:04 +0000 (UTC)
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 6E2DE402DE
 for <iommu@lists.linux-foundation.org>; Wed, 12 Jan 2022 10:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1641983282;
 bh=QRI3RyqVgPy+I4GidDpfSQY18QjzUt/rAxNK//Q3/V4=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=Y1fNjQm7w8ub4ZmMRDuneay/9gYtEqous4JlodGBJscrJyHmdFuvRyo14jy6wKSvY
 V+9zPbFYSD/HIiBBFFIUlsP3XBHT8FEwl886jLinoFVKartxi89F8fVvh6htIqII74
 ZVDQ4UzsefUGTSEE4oKAi+Xkk+hQwAYmlpsa/AGdoYVEbW7UluARh4dW6+hhAWmUwb
 qN7btD0U7yr1fGtw8rJZRrrMhfB/LXEkIS/LiSdp0kGBL+At50xn7wmPoht+F44fRF
 AQ1BDAlT1PpE4A++eXpfAPgurJL3ekOOkwmUZoL02um/eUPUaBR3oYJyIBLXoo8Jbl
 oLBYVQAGtG4LQ==
Received: by mail-ed1-f71.google.com with SMTP id
 l14-20020aa7cace000000b003f7f8e1cbbdso1832474edt.20
 for <iommu@lists.linux-foundation.org>; Wed, 12 Jan 2022 02:28:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=QRI3RyqVgPy+I4GidDpfSQY18QjzUt/rAxNK//Q3/V4=;
 b=fzWM5/wXARq8gc7Wiaks63R5r92B3uVQ70re7O8GMpOvlgao3XztFHGoctEW4re8Be
 7cmuSUd3QPwvawlmYZYvnMImbM1shP7+05Cn06r8veGFi3FLkE0d1OwLAAaO+vEcCziU
 W0bN9/fJb6U3ck0WZ5JlVMg+FGUWTbtLH6NOvR50mssU4y5OJ6bYA237VwWJWkqWwavp
 Qli5Bu14FVZVWi4jXbRWMBSXTztFC+u33D5UL7DhWxUeS9bB5O9JajdLwZGZCN9Li4ux
 yyDliDEC/YdXCTyPwkYBI/3hhzvgLg8NQOrWKbIY9rYWx0Epmx3QlUkEJsXcWyj5o7Pe
 FdXA==
X-Gm-Message-State: AOAM531MsS2+bCWOkcVsUWWm5rE9zEqDUJuZM5UiMI1mbcowMtHcoesN
 Dy046gqLINIfAC3pwFYjMfJqW0Mnut7PZvmJY9GfkyudrlTrGhtgFqK9KY9+1m/3unQ2nC/Os/w
 r/7DvXij8LEjWoGbeKD8ZTO5jl43pjXnmsSxF2r36g5PJtqo=
X-Received: by 2002:aa7:d554:: with SMTP id u20mr8492738edr.322.1641983281842; 
 Wed, 12 Jan 2022 02:28:01 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxNl0142m+NR0mNOStdmmNLcUcWydkHPUn0K/3hwATxqUffiAMouRTvD80ezk7JLym0RGyLwA==
X-Received: by 2002:aa7:d554:: with SMTP id u20mr8492708edr.322.1641983281648; 
 Wed, 12 Jan 2022 02:28:01 -0800 (PST)
Received: from [192.168.0.29] (xdsl-188-155-168-84.adslplus.ch.
 [188.155.168.84])
 by smtp.gmail.com with ESMTPSA id e16sm5905001edu.15.2022.01.12.02.28.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Jan 2022 02:28:00 -0800 (PST)
Message-ID: <22935ffa-469c-a609-c30b-919ba85b842c@canonical.com>
Date: Wed, 12 Jan 2022 11:27:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v2 5/6] memory: mtk-smi: Add sleep ctrl function
Content-Language: en-US
To: Yong Wu <yong.wu@mediatek.com>, Rob Herring <robh+dt@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>
References: <20220111063904.7583-1-yong.wu@mediatek.com>
 <20220111063904.7583-6-yong.wu@mediatek.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220111063904.7583-6-yong.wu@mediatek.com>
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org, yi.kuo@mediatek.com,
 srv_heupstream@mediatek.com, Will Deacon <will@kernel.org>,
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
 iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
 lc.kan@mediatek.com, anthony.huang@mediatek.com, anan.sun@mediatek.com,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 11/01/2022 07:39, Yong Wu wrote:
> Sleep control means that when the larb goes to sleep, we should wait a bit
> until all the current commands are finished. Thus, when the larb runtime
> suspends, we need to enable this function to wait until all the existed
> commands are finished. When the larb resumes, just disable this function.
> This function only improves the safety of bus. Add a new flag for this
> function. Prepare for mt8186.
> 
> Signed-off-by: Anan Sun <anan.sun@mediatek.com>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  drivers/memory/mtk-smi.c | 35 ++++++++++++++++++++++++++++++++++-
>  1 file changed, 34 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
> index e7b1a22b12ea..d8552f4caba4 100644
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
> +#define SMI_LARB_SLP_CON                0xc
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
> @@ -371,6 +377,26 @@ static const struct of_device_id mtk_smi_larb_of_ids[] = {
>  	{}
>  };
>  
> +static int mtk_smi_larb_sleep_ctrl_enable(struct mtk_smi_larb *larb)
> +{
> +	int ret;
> +	u32 tmp;
> +
> +	writel_relaxed(SLP_PROT_EN, larb->base + SMI_LARB_SLP_CON);
> +	ret = readl_poll_timeout_atomic(larb->base + SMI_LARB_SLP_CON,
> +					tmp, !!(tmp & SLP_PROT_RDY), 10, 1000);
> +	if (ret) {
> +		/* TODO: Reset this larb if it fails here. */
> +		dev_warn(larb->smi.dev, "sleep ctrl is not ready(0x%x).\n", tmp);
> +	}
> +	return ret;
> +}
> +
> +static void mtk_smi_larb_sleep_ctrl_disable(struct mtk_smi_larb *larb)
> +{
> +	writel_relaxed(0, larb->base + SMI_LARB_SLP_CON);
> +}
> +
>  static int mtk_smi_device_link_common(struct device *dev, struct device **com_dev)
>  {
>  	struct platform_device *smi_com_pdev;
> @@ -483,6 +509,9 @@ static int __maybe_unused mtk_smi_larb_resume(struct device *dev)
>  	if (ret)
>  		return ret;
>  
> +	if (MTK_SMI_CAPS(larb->larb_gen->flags_general, MTK_SMI_FLAG_SLEEP_CTL))
> +		mtk_smi_larb_sleep_ctrl_disable(larb);
> +
>  	/* Configure the basic setting for this larb */
>  	larb_gen->config_port(dev);
>  
> @@ -492,9 +521,13 @@ static int __maybe_unused mtk_smi_larb_resume(struct device *dev)
>  static int __maybe_unused mtk_smi_larb_suspend(struct device *dev)
>  {
>  	struct mtk_smi_larb *larb = dev_get_drvdata(dev);
> +	int ret = 0;
> +
> +	if (MTK_SMI_CAPS(larb->larb_gen->flags_general, MTK_SMI_FLAG_SLEEP_CTL))
> +		ret = mtk_smi_larb_sleep_ctrl_enable(larb);
>  
>  	clk_bulk_disable_unprepare(larb->smi.clk_num, larb->smi.clks);
> -	return 0;
> +	return ret;

I am wondering whether disabling clocks in error case is a proper step.
On suspend error, the PM core won't run any further callbacks on this
device. This means, it won't be resumed and your clocks stay disabled. I
think you should return early and leave the device in active state in
case of error.


Best regards,
Krzysztof
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
