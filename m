Return-Path: <SRS0=8mM2=JX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_RED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F7F8C433ED
	for <iommu@archiver.kernel.org>; Mon, 26 Apr 2021 08:28:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C61D661090
	for <iommu@archiver.kernel.org>; Mon, 26 Apr 2021 08:28:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C61D661090
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 477494026D;
	Mon, 26 Apr 2021 08:28:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2zM2XhcEBvvJ; Mon, 26 Apr 2021 08:28:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id F41E5401E3;
	Mon, 26 Apr 2021 08:28:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CDE14C000F;
	Mon, 26 Apr 2021 08:28:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A8885C000B
 for <iommu@lists.linux-foundation.org>; Mon, 26 Apr 2021 08:28:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7EBAA6059C
 for <iommu@lists.linux-foundation.org>; Mon, 26 Apr 2021 08:28:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FXlW4dmpXs65 for <iommu@lists.linux-foundation.org>;
 Mon, 26 Apr 2021 08:28:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4C6666002E
 for <iommu@lists.linux-foundation.org>; Mon, 26 Apr 2021 08:28:46 +0000 (UTC)
Received: from mail-ej1-f69.google.com ([209.85.218.69])
 by youngberry.canonical.com with esmtps
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <krzysztof.kozlowski@canonical.com>)
 id 1lawbk-0002B2-L5
 for iommu@lists.linux-foundation.org; Mon, 26 Apr 2021 08:28:44 +0000
Received: by mail-ej1-f69.google.com with SMTP id
 f15-20020a170906738fb029037c94426fffso9931216ejl.22
 for <iommu@lists.linux-foundation.org>; Mon, 26 Apr 2021 01:28:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=COIkDfjubq7aAUAK5liY18XK8WSLoAGQXd5DYCklQ/A=;
 b=Ws1qpGCe5YCpMRsLoLRaxXpXHb37XStSTAVdcAY0SYT4mqNXjGDfBCqFUeCUd0F4EU
 tpjeRQ00Gcjy5GP8g8mqChx32Y1AHJSFXv4gfp21Q7P+AcBRCriBaCNzYWa8uyvEmmi7
 jrkrwjKBioMJoLy2p361J9XQ3DIPtOThqKnQdwm7h0WCHGt2Ev9xpYIN3z3nwDkEC7bt
 W5uIWFG1k2AE+6lqW74iQ5YTpli6e9NF9Q/Xj0mZEWNWH8iuqFjqP4e+sIDHfF9I9KfE
 dNoqhnqNtEm0QOSiKJ/FomnyA8DPUby1fA26QMfxCm5QJkVgBTqgVJ+Ru+Uswa2qV/+G
 xs3g==
X-Gm-Message-State: AOAM532YW2VeUTmRmuzGbdmszJi2J4OX4SWL21aGJMW3Z8mpkzJGLTNT
 //xA0iRsKLX2fN/qCuaTDIAlWLx70AQ/cdJqMrYzFPI4sGLrKihClr9hXliR4vu2xfH7UbcIQ5h
 s7/aP89VKRqRpoMpMIV2elou+Cp+13k8sZL4mEa/aiNsZA8g=
X-Received: by 2002:a17:906:6d48:: with SMTP id
 a8mr17748263ejt.92.1619425724301; 
 Mon, 26 Apr 2021 01:28:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyhr25H0tBsBH7bLu7FVjvZjArCD5pPEKSdYyH73P4GGQO0s+LeQ8sv8v4PmZJ+zVnujNggsw==
X-Received: by 2002:a17:906:6d48:: with SMTP id
 a8mr17748251ejt.92.1619425724124; 
 Mon, 26 Apr 2021 01:28:44 -0700 (PDT)
Received: from [192.168.1.115] (xdsl-188-155-180-75.adslplus.ch.
 [188.155.180.75])
 by smtp.gmail.com with ESMTPSA id l6sm11153810ejc.92.2021.04.26.01.28.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Apr 2021 01:28:43 -0700 (PDT)
Subject: Re: [PATCH v2 01/10] memory: tegra: Implement SID override programming
To: Thierry Reding <thierry.reding@gmail.com>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>
References: <20210420172619.3782831-1-thierry.reding@gmail.com>
 <20210420172619.3782831-2-thierry.reding@gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <03e2a655-7dbf-a729-75f6-98db353e2b91@canonical.com>
Date: Mon, 26 Apr 2021 10:28:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210420172619.3782831-2-thierry.reding@gmail.com>
Content-Language: en-US
Cc: iommu@lists.linux-foundation.org, Jon Hunter <jonathanh@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>, linux-tegra@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
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

On 20/04/2021 19:26, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Instead of programming all SID overrides during early boot, perform the
> operation on-demand after the SMMU translations have been set up for a
> device. This reuses data from device tree to match memory clients for a
> device and programs the SID specified in device tree, which corresponds
> to the SID used for the SMMU context banks for the device.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  drivers/memory/tegra/mc.c       |  9 +++++
>  drivers/memory/tegra/tegra186.c | 72 +++++++++++++++++++++++++++++++++
>  include/soc/tegra/mc.h          |  3 ++
>  3 files changed, 84 insertions(+)
> 
> diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
> index c854639cf30c..bace5ecfe770 100644
> --- a/drivers/memory/tegra/mc.c
> +++ b/drivers/memory/tegra/mc.c
> @@ -97,6 +97,15 @@ struct tegra_mc *devm_tegra_memory_controller_get(struct device *dev)
>  }
>  EXPORT_SYMBOL_GPL(devm_tegra_memory_controller_get);
>  
> +int tegra_mc_probe_device(struct tegra_mc *mc, struct device *dev)
> +{
> +	if (mc->soc->ops && mc->soc->ops->probe_device)
> +		return mc->soc->ops->probe_device(mc, dev);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(tegra_mc_probe_device);
> +
>  static int tegra_mc_block_dma_common(struct tegra_mc *mc,
>  				     const struct tegra_mc_reset *rst)
>  {
> diff --git a/drivers/memory/tegra/tegra186.c b/drivers/memory/tegra/tegra186.c
> index 1f87915ccd62..e65eac5764d4 100644
> --- a/drivers/memory/tegra/tegra186.c
> +++ b/drivers/memory/tegra/tegra186.c
> @@ -4,6 +4,7 @@
>   */
>  
>  #include <linux/io.h>
> +#include <linux/iommu.h>
>  #include <linux/module.h>
>  #include <linux/mod_devicetable.h>
>  #include <linux/of_device.h>
> @@ -15,6 +16,10 @@
>  #include <dt-bindings/memory/tegra186-mc.h>
>  #endif
>  
> +#define MC_SID_STREAMID_OVERRIDE_MASK GENMASK(7, 0)
> +#define MC_SID_STREAMID_SECURITY_WRITE_ACCESS_DISABLED BIT(16)
> +#define MC_SID_STREAMID_SECURITY_OVERRIDE BIT(8)
> +
>  static void tegra186_mc_program_sid(struct tegra_mc *mc)
>  {
>  	unsigned int i;
> @@ -66,10 +71,77 @@ static int tegra186_mc_resume(struct tegra_mc *mc)
>  	return 0;
>  }
>  
> +static void tegra186_mc_client_sid_override(struct tegra_mc *mc,
> +					    const struct tegra_mc_client *client,
> +					    unsigned int sid)
> +{
> +	u32 value, old;
> +
> +	value = readl(mc->regs + client->regs.sid.security);
> +	if ((value & MC_SID_STREAMID_SECURITY_OVERRIDE) == 0) {
> +		/*
> +		 * If the secure firmware has locked this down the override
> +		 * for this memory client, there's nothing we can do here.
> +		 */
> +		if (value & MC_SID_STREAMID_SECURITY_WRITE_ACCESS_DISABLED)
> +			return;
> +
> +		/*
> +		 * Otherwise, try to set the override itself. Typically the
> +		 * secure firmware will never have set this configuration.
> +		 * Instead, it will either have disabled write access to
> +		 * this field, or it will already have set an explicit
> +		 * override itself.
> +		 */
> +		WARN_ON((value & MC_SID_STREAMID_SECURITY_OVERRIDE) == 0);
> +
> +		value |= MC_SID_STREAMID_SECURITY_OVERRIDE;
> +		writel(value, mc->regs + client->regs.sid.security);
> +	}
> +
> +	value = readl(mc->regs + client->regs.sid.override);
> +	old = value & MC_SID_STREAMID_OVERRIDE_MASK;
> +
> +	if (old != sid) {
> +		dev_dbg(mc->dev, "overriding SID %x for %s with %x\n", old,
> +			client->name, sid);
> +		writel(sid, mc->regs + client->regs.sid.override);
> +	}
> +}
> +
> +static int tegra186_mc_probe_device(struct tegra_mc *mc, struct device *dev)
> +{
> +#if IS_ENABLED(CONFIG_IOMMU_API)

Is this part really build-time dependent? I don't see here any uses of
IOMMU specific fields, so maybe this should be runtime choice based on
enabled interconnect devices?

> +	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
> +	struct of_phandle_args args;
> +	unsigned int i, index = 0;
> +
> +	while (!of_parse_phandle_with_args(dev->of_node, "interconnects", "#interconnect-cells",
> +					   index, &args)) {
> +		if (args.np == mc->dev->of_node && args.args_count != 0) {
> +			for (i = 0; i < mc->soc->num_clients; i++) {
> +				const struct tegra_mc_client *client = &mc->soc->clients[i];
> +
> +				if (client->id == args.args[0]) {
> +					u32 sid = fwspec->ids[0] & MC_SID_STREAMID_OVERRIDE_MASK;
> +
> +					tegra186_mc_client_sid_override(mc, client, sid);
> +				}
> +			}
> +		}
> +
> +		index++;
> +	}
> +#endif
> +
> +	return 0;
> +}
> +
>  const struct tegra_mc_ops tegra186_mc_ops = {
>  	.probe = tegra186_mc_probe,
>  	.remove = tegra186_mc_remove,
>  	.resume = tegra186_mc_resume,
> +	.probe_device = tegra186_mc_probe_device,
>  };
>  
>  #if defined(CONFIG_ARCH_TEGRA_186_SOC)
> diff --git a/include/soc/tegra/mc.h b/include/soc/tegra/mc.h
> index 1387747d574b..bbad6330008b 100644
> --- a/include/soc/tegra/mc.h
> +++ b/include/soc/tegra/mc.h
> @@ -176,6 +176,7 @@ struct tegra_mc_ops {
>  	int (*suspend)(struct tegra_mc *mc);
>  	int (*resume)(struct tegra_mc *mc);
>  	irqreturn_t (*handle_irq)(int irq, void *data);
> +	int (*probe_device)(struct tegra_mc *mc, struct device *dev);
>  };
>  
>  struct tegra_mc_soc {
> @@ -240,4 +241,6 @@ devm_tegra_memory_controller_get(struct device *dev)
>  }
>  #endif
>  
> +int tegra_mc_probe_device(struct tegra_mc *mc, struct device *dev);
> +

What about !CONFIG_TEGRA_MC? I think arm-smmmu will fail.

>  #endif /* __SOC_TEGRA_MC_H__ */
> 


Best regards,
Krzysztof
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
