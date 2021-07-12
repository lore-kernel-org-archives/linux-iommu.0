Return-Path: <SRS0=b5xv=ME=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7D58C11F70
	for <iommu@archiver.kernel.org>; Mon, 12 Jul 2021 06:52:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77F3B6127C
	for <iommu@archiver.kernel.org>; Mon, 12 Jul 2021 06:52:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77F3B6127C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 469A040118;
	Mon, 12 Jul 2021 06:52:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kc8OGJ5TZJyj; Mon, 12 Jul 2021 06:52:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 0F4B7400CB;
	Mon, 12 Jul 2021 06:52:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D7D65C0010;
	Mon, 12 Jul 2021 06:52:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 71140C000E
 for <iommu@lists.linux-foundation.org>; Mon, 12 Jul 2021 06:52:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5809D82437
 for <iommu@lists.linux-foundation.org>; Mon, 12 Jul 2021 06:52:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=canonical.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fcPL0t5gUI9M for <iommu@lists.linux-foundation.org>;
 Mon, 12 Jul 2021 06:52:32 +0000 (UTC)
X-Greylist: delayed 00:07:39 by SQLgrey-1.8.0
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 86D4D823E0
 for <iommu@lists.linux-foundation.org>; Mon, 12 Jul 2021 06:52:32 +0000 (UTC)
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPS id 05CB0404A0
 for <iommu@lists.linux-foundation.org>; Mon, 12 Jul 2021 06:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1626072290;
 bh=OR0zgeaONK2MupeyE6Ocj/7EocddRmlmkKFDNFfG1NY=;
 h=Subject:To:From:Message-ID:Date:MIME-Version:Content-Type;
 b=br/iqPO48s/Z3W9tLoJ24RW3B1DWXwDbbJMk3Ha/uEeMwKlLR31ReJRayF3Wh04+p
 eE6bxgxe0VQws1G10V1Casu5CgFOocOEfJp4eunsgLxlC8ZBkI7+j8VPYFWsPpwIja
 xCIoi62S3F3aA/XfOP5KyjHMBYlYT1jPVkW5C94Qv+ZRz8Y52TUSKLC9GNfmdfyFqg
 1/BszlrnHDo8UcyQHL8JbULf93HDRnTVMKOmcgrYilD/mowQw9Utu/HMf2oDX5RemW
 6OaxAdvJewFgSzuqu2GJDq696ccWeVAbvzLM8cTpfBVpfX83eKfVmVi7wmhBFMXS+R
 2u8NmB4iKr1cg==
Received: by mail-wm1-f71.google.com with SMTP id
 m6-20020a05600c4f46b0290205f5e73b37so5903903wmq.3
 for <iommu@lists.linux-foundation.org>; Sun, 11 Jul 2021 23:44:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=OR0zgeaONK2MupeyE6Ocj/7EocddRmlmkKFDNFfG1NY=;
 b=Bd05xShFaJrLP4q2PUfRiFMBlU/a73pIPX4gxqmlLPZRPdPU4MwSIjVfc/2fEzId+K
 /WRPf9PJpZrOjtdXyjhBtTWNWtnz1KrdwUdk5yk383ynp1guYnd5yN2jmlxmSjdZlRkL
 XqBlU3/iXEH0kTDkivqmpPuZvXTYKzoMMEi/dMRMdjEuSHCh4uRHqi0+EQvUGST64uYO
 Su67XaCICI3dknhM0Dr2WqbkvENJfiDNKUU1Yr4X+AyFP1rA47nZ+wU8m2uxC22c/qSx
 gPERzxzDRONBpFoAjOHYarztCG58LS0M61z+YbuZ3gGFDPRIe7JCtjrZ6OTOJjy3OHC4
 2BRw==
X-Gm-Message-State: AOAM532uM0pzNjyGqa4/hORCwNOFoTvjM9Cr0JO9MhNK9TkS75GUgdX7
 I+XtORi4Iy7CP6C5bko1dWQL6gOsRcDpb5BZgMa1r1SL9WqtHJXDpEwli4B/D1xgNQ1Q/ozkJ6+
 Qb/zFMrvHb2XUEzmafUt7PIV94zmazDtakfXOWrlcH2JCrak=
X-Received: by 2002:a05:600c:24d3:: with SMTP id
 19mr3339009wmu.171.1626072289679; 
 Sun, 11 Jul 2021 23:44:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJySU0D9B7fRMXEvgvy6Ati/eZuKcVknMxNOdcIIsbPvm/GJGLKf3jsMbB7YcvqNiHnDrw1oEw==
X-Received: by 2002:a05:600c:24d3:: with SMTP id
 19mr3338983wmu.171.1626072289515; 
 Sun, 11 Jul 2021 23:44:49 -0700 (PDT)
Received: from [192.168.3.211] (xdsl-188-155-177-222.adslplus.ch.
 [188.155.177.222])
 by smtp.gmail.com with ESMTPSA id o7sm15468284wrv.72.2021.07.11.23.44.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 11 Jul 2021 23:44:49 -0700 (PDT)
Subject: Re: [PATCH 3/9] memory: mtk-smi: Use clk_bulk instead of the clk ops
To: Yong Wu <yong.wu@mediatek.com>
References: <20210616114346.18812-1-yong.wu@mediatek.com>
 <20210616114346.18812-4-yong.wu@mediatek.com>
 <4047dfaf-f2f8-b6b2-52fd-41821475b162@canonical.com>
 <1625992199.22309.15.camel@mhfsdcap03>
From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <fe426c10-4cfe-103c-9961-1b8fdb18a16a@canonical.com>
Date: Mon, 12 Jul 2021 08:44:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1625992199.22309.15.camel@mhfsdcap03>
Content-Language: en-US
Cc: youlin.pei@mediatek.com, anan.sun@mediatek.com, srv_heupstream@mediatek.com,
 Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzk@kernel.org>, iommu@lists.linux-foundation.org,
 Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org,
 Matthias Brugger <matthias.bgg@gmail.com>, anthony.huang@mediatek.com,
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

On 11/07/2021 10:29, Yong Wu wrote:
> On Thu, 2021-07-08 at 11:32 +0200, Krzysztof Kozlowski wrote:
>> On 16/06/2021 13:43, Yong Wu wrote:
>>> smi have many clocks: apb/smi/gals.
>>> This patch use clk_bulk interface instead of the orginal one to simply
>>> the code.
>>>
>>> gals is optional clk(some larbs may don't have gals). use clk_bulk_optional
>>> instead. and then remove the has_gals flag.
>>>
>>> Also remove clk fail logs since bulk interface already output fail log.
>>>
>>> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
>>> ---
>>>  drivers/memory/mtk-smi.c | 124 +++++++++++----------------------------
>>>  1 file changed, 34 insertions(+), 90 deletions(-)
>>>
>>> diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
>>> index c5fb51f73b34..bcd2bf130655 100644
>>> --- a/drivers/memory/mtk-smi.c
>>> +++ b/drivers/memory/mtk-smi.c
>>> @@ -60,9 +60,18 @@ enum mtk_smi_gen {
>>>  	MTK_SMI_GEN2
>>>  };
>>>  
>>> +#define MTK_SMI_CLK_NR_MAX			4
>>> +
>>> +static const char * const mtk_smi_common_clocks[] = {
>>> +	"apb", "smi", "gals0", "gals1", /* glas is optional */
>>
>> Typo here - glas.
> 
> Will Fix. Thanks.
> 
>>
>>> +};
>>> +
> 
> [snip]
> 
>>> @@ -493,7 +449,7 @@ static int mtk_smi_common_probe(struct platform_device *pdev)
>>>  	struct device *dev = &pdev->dev;
>>>  	struct mtk_smi *common;
>>>  	struct resource *res;
>>> -	int ret;
>>> +	int i, ret;
>>>  
>>>  	common = devm_kzalloc(dev, sizeof(*common), GFP_KERNEL);
>>>  	if (!common)
>>> @@ -501,23 +457,13 @@ static int mtk_smi_common_probe(struct platform_device *pdev)
>>>  	common->dev = dev;
>>>  	common->plat = of_device_get_match_data(dev);
>>>  
>>> -	common->clk_apb = devm_clk_get(dev, "apb");
>>> -	if (IS_ERR(common->clk_apb))
>>> -		return PTR_ERR(common->clk_apb);
>>> -
>>> -	common->clk_smi = devm_clk_get(dev, "smi");
>>> -	if (IS_ERR(common->clk_smi))
>>> -		return PTR_ERR(common->clk_smi);
>>> +	common->clk_num = ARRAY_SIZE(mtk_smi_common_clocks);
>>> +	for (i = 0; i < common->clk_num; i++)
>>> +		common->clks[i].id = mtk_smi_common_clocks[i];
>>>  
>>> -	if (common->plat->has_gals) {
>>> -		common->clk_gals0 = devm_clk_get(dev, "gals0");
>>> -		if (IS_ERR(common->clk_gals0))
>>> -			return PTR_ERR(common->clk_gals0);
>>> -
>>> -		common->clk_gals1 = devm_clk_get(dev, "gals1");
>>> -		if (IS_ERR(common->clk_gals1))
>>> -			return PTR_ERR(common->clk_gals1);
>>> -	}
>>> +	ret = devm_clk_bulk_get_optional(dev, common->clk_num, common->clks);
>>> +	if (ret)
>>> +		return ret;
>>
>> How do you handle now missing required clocks?
> 
> It looks this is a common issue for this function which supports all the
> clocks could be optional. Is there common suggestion for this?
> 
> For our case, the apb/smi clocks are required while "gals" are optional.
> 
> thus, we should use devm_clk_bulk_get for the necessary clocks and
> devm_clk_bulk_get_optional for the optional ones. right?

Yes, I think that's the solution. Otherwise you might not have proper
clocks leading to accesses to disabled/gated hardware.

Best regards,
Krzysztof
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
