Return-Path: <SRS0=8mM2=JX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E07DCC433B4
	for <iommu@archiver.kernel.org>; Mon, 26 Apr 2021 14:10:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 521EB6103E
	for <iommu@archiver.kernel.org>; Mon, 26 Apr 2021 14:10:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 521EB6103E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EC36A6059A;
	Mon, 26 Apr 2021 14:10:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id E14mVXc3yOfH; Mon, 26 Apr 2021 14:10:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id BB3E16059F;
	Mon, 26 Apr 2021 14:10:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 879ACC000E;
	Mon, 26 Apr 2021 14:10:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5B69CC000B
 for <iommu@lists.linux-foundation.org>; Mon, 26 Apr 2021 14:10:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 42BBA6059F
 for <iommu@lists.linux-foundation.org>; Mon, 26 Apr 2021 14:10:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id roP3pnXR35TF for <iommu@lists.linux-foundation.org>;
 Mon, 26 Apr 2021 14:10:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 108B16059A
 for <iommu@lists.linux-foundation.org>; Mon, 26 Apr 2021 14:10:10 +0000 (UTC)
Received: from mail-ej1-f72.google.com ([209.85.218.72])
 by youngberry.canonical.com with esmtps
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <krzysztof.kozlowski@canonical.com>)
 id 1lb1w8-0006xP-JB
 for iommu@lists.linux-foundation.org; Mon, 26 Apr 2021 14:10:08 +0000
Received: by mail-ej1-f72.google.com with SMTP id
 ld21-20020a170906f955b029038f648a7175so574949ejb.13
 for <iommu@lists.linux-foundation.org>; Mon, 26 Apr 2021 07:10:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2ADebOh7mdB0pOynqo1V1oIiVpLH7xgzkBg1gH8EygY=;
 b=sVjcYq+zX1wW78g3fsES4VSa2RMlzlAkzcJ++mZUsGm3GJCvSC484qv+IuSuV8KgS4
 PsP6rZAFlx7ZrQcl2Mxf+h6QS8Egg0zeCWiNCRsm9t8tY1SUfgYcnA2yOqVgwwcAQXlS
 FilfpvE8Twxay808G4ZvkPABaIfexbKnnVofaiPRHPS8T8w5Ybrhv1H3QNVlI3r12mj2
 BRr/RFasEQ10yKNby39O97uGMvLD9ysgjS/UbWwHYsQUQSeNaOxiIe5OhS1wfgy/A/iv
 hj4TPvlcCPNJuLhPqnS9sXoEu1sda+N0LXKIIXLDoe8XaHD5uDWvaf3JoIW80mayZzv5
 4XLQ==
X-Gm-Message-State: AOAM533NzyA0AQ4pDuJi+wyEvbrlycQxTXTz5+WShA9PApiTu6zWG1O5
 WwDuChtM2KCBhxd6N2X+Oc6Qdf06KtwCwIM231fpqeBwZIgzcg5Dmad8aaOvD+QcHYIfZGpSYiT
 qTow3bd43AIHS7oNMaohuOmblULuZRbatO/ZEk+um0cx+3Fw=
X-Received: by 2002:a50:ee88:: with SMTP id f8mr10726104edr.176.1619446208305; 
 Mon, 26 Apr 2021 07:10:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwaB1Db7KABg9TD1/UL3dQ5XfAGx3KjxU9sYwe/UocPCGa2sJj2AJlgIhi7ZrvToVrSsb83Tg==
X-Received: by 2002:a50:ee88:: with SMTP id f8mr10726080edr.176.1619446208110; 
 Mon, 26 Apr 2021 07:10:08 -0700 (PDT)
Received: from [192.168.1.115] (xdsl-188-155-180-75.adslplus.ch.
 [188.155.180.75])
 by smtp.gmail.com with ESMTPSA id m14sm14363432edr.45.2021.04.26.07.10.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Apr 2021 07:10:07 -0700 (PDT)
Subject: Re: [PATCH v2 01/10] memory: tegra: Implement SID override programming
To: Thierry Reding <thierry.reding@gmail.com>
References: <20210420172619.3782831-1-thierry.reding@gmail.com>
 <20210420172619.3782831-2-thierry.reding@gmail.com>
 <03e2a655-7dbf-a729-75f6-98db353e2b91@canonical.com>
 <YIauV/BgPCZSZ8u2@orome.fritz.box>
From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <526942f8-861a-8b0f-66a2-42eda600fabe@canonical.com>
Date: Mon, 26 Apr 2021 16:10:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YIauV/BgPCZSZ8u2@orome.fritz.box>
Content-Language: en-US
Cc: Will Deacon <will@kernel.org>, iommu@lists.linux-foundation.org,
 Jon Hunter <jonathanh@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>,
 linux-tegra@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
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

On 26/04/2021 14:13, Thierry Reding wrote:
> On Mon, Apr 26, 2021 at 10:28:43AM +0200, Krzysztof Kozlowski wrote:

(...)

>>> +
>>> +	value = readl(mc->regs + client->regs.sid.override);
>>> +	old = value & MC_SID_STREAMID_OVERRIDE_MASK;
>>> +
>>> +	if (old != sid) {
>>> +		dev_dbg(mc->dev, "overriding SID %x for %s with %x\n", old,
>>> +			client->name, sid);
>>> +		writel(sid, mc->regs + client->regs.sid.override);
>>> +	}
>>> +}
>>> +
>>> +static int tegra186_mc_probe_device(struct tegra_mc *mc, struct device *dev)
>>> +{
>>> +#if IS_ENABLED(CONFIG_IOMMU_API)
>>
>> Is this part really build-time dependent? I don't see here any uses of
>> IOMMU specific fields, so maybe this should be runtime choice based on
>> enabled interconnect devices?
> 
> Unfortunately it is. struct iommu_fwspec is an empty structure for
> !CONFIG_IOMMU_API, so the code below that tries to access fwspec->ids
> fails for !CONFIG_IOMMU_API configurations if we don't protect this with
> the preprocessor guard.

OK, thanks.

> 
>>
>>> +	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
>>> +	struct of_phandle_args args;
>>> +	unsigned int i, index = 0;
>>> +
>>> +	while (!of_parse_phandle_with_args(dev->of_node, "interconnects", "#interconnect-cells",
>>> +					   index, &args)) {
>>> +		if (args.np == mc->dev->of_node && args.args_count != 0) {
>>> +			for (i = 0; i < mc->soc->num_clients; i++) {
>>> +				const struct tegra_mc_client *client = &mc->soc->clients[i];
>>> +
>>> +				if (client->id == args.args[0]) {
>>> +					u32 sid = fwspec->ids[0] & MC_SID_STREAMID_OVERRIDE_MASK;
>>> +
>>> +					tegra186_mc_client_sid_override(mc, client, sid);
>>> +				}
>>> +			}
>>> +		}
>>> +
>>> +		index++;
>>> +	}
>>> +#endif
>>> +
>>> +	return 0;
>>> +}
>>> +
>>>  const struct tegra_mc_ops tegra186_mc_ops = {
>>>  	.probe = tegra186_mc_probe,
>>>  	.remove = tegra186_mc_remove,
>>>  	.resume = tegra186_mc_resume,
>>> +	.probe_device = tegra186_mc_probe_device,
>>>  };
>>>  
>>>  #if defined(CONFIG_ARCH_TEGRA_186_SOC)
>>> diff --git a/include/soc/tegra/mc.h b/include/soc/tegra/mc.h
>>> index 1387747d574b..bbad6330008b 100644
>>> --- a/include/soc/tegra/mc.h
>>> +++ b/include/soc/tegra/mc.h
>>> @@ -176,6 +176,7 @@ struct tegra_mc_ops {
>>>  	int (*suspend)(struct tegra_mc *mc);
>>>  	int (*resume)(struct tegra_mc *mc);
>>>  	irqreturn_t (*handle_irq)(int irq, void *data);
>>> +	int (*probe_device)(struct tegra_mc *mc, struct device *dev);
>>>  };
>>>  
>>>  struct tegra_mc_soc {
>>> @@ -240,4 +241,6 @@ devm_tegra_memory_controller_get(struct device *dev)
>>>  }
>>>  #endif
>>>  
>>> +int tegra_mc_probe_device(struct tegra_mc *mc, struct device *dev);
>>> +
>>
>> What about !CONFIG_TEGRA_MC? I think arm-smmmu will fail.
> 
> I think it doesn't fail because for !CONFIG_TEGRA_MC it basically throws
> away most of nvidia_smmu_impl_init() already because ERR_PTR(-ENODEV) is
> returned by devm_tegra_memory_controller_get() and so it unconditionally
> fails early on already.
> 
> I say I /think/ that happens because I can't reproduce a build failure
> even if I manually tweak the .config such that ARM_SMMU is enabled and
> TEGRA_MC is disabled. But I can't say I fully understand why it's
> working, because, yes, the symbol definitely doesn't exist. But again,
> if the compiler is clever enough to figure out that that function can't
> be called anyway and doesn't even want it, why bother making it more
> complicated than it has to be?

Since you tested that case, it's fine.


Best regards,
Krzysztof
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
