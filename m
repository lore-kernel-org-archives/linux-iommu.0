Return-Path: <SRS0=gU7u=JK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE902C433ED
	for <iommu@archiver.kernel.org>; Tue, 13 Apr 2021 14:58:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CC46613B3
	for <iommu@archiver.kernel.org>; Tue, 13 Apr 2021 14:58:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CC46613B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 420B6842A6;
	Tue, 13 Apr 2021 14:58:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Jo4Oh-1UwoHW; Tue, 13 Apr 2021 14:58:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2DFE982B81;
	Tue, 13 Apr 2021 14:58:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 06B45C000C;
	Tue, 13 Apr 2021 14:58:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0D1A2C000A
 for <iommu@lists.linux-foundation.org>; Tue, 13 Apr 2021 14:58:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E8336405D2
 for <iommu@lists.linux-foundation.org>; Tue, 13 Apr 2021 14:58:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QpB21lF0jq5u for <iommu@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 14:58:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 52F6F405D0
 for <iommu@lists.linux-foundation.org>; Tue, 13 Apr 2021 14:58:07 +0000 (UTC)
Received: from mail-ed1-f70.google.com ([209.85.208.70])
 by youngberry.canonical.com with esmtps
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <krzysztof.kozlowski@canonical.com>)
 id 1lWKUO-0005BA-UY
 for iommu@lists.linux-foundation.org; Tue, 13 Apr 2021 14:58:05 +0000
Received: by mail-ed1-f70.google.com with SMTP id
 c5-20020aa7d6050000b02903825f4da4f3so1410979edr.16
 for <iommu@lists.linux-foundation.org>; Tue, 13 Apr 2021 07:58:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=yJ2s7SvtJMvGXXT2TcTaXG1f4Lh8es6VQIDWtx4JoOk=;
 b=Yv5UW1OEBKlroxtXLk328bkCcPDI5ZAIkw+8gKEBX57HGcbjlNh1pPXL8nD9qHws7m
 m3cK7Q8Ki1DaU0+HVOCjTzAYBMU7grqC9SUVFQojCGRiGbANh0UJNv0uGmS8X3X/2oJ1
 yket7bJKRBPmV/js9wxmwMaI7X/4qkT9mjunA/Z/xCq4G1HEF9M2L5ONGbphPoDm6Fai
 4daFbNbwmiscEsTO1D+zOatgBH8esF+3uaOIwC1xCV5yXDydjN2Tnj22uNT7NEIzUuIP
 r43MknzxIUFUAnCzezULOZUu8o/gWGOME00afQPokfeDjNKTFA+30oUuTENWUqZvHa+g
 hxnw==
X-Gm-Message-State: AOAM531JFHIw4OpYI2sMqo/enT+qfLnWngrQQbHfPUKZbCgDj3sDs4gs
 PMvcaCSqFrWTUhtkadEDp/Xb2rI+RsopkJtRC9QS+ZIQTfdT32/QjWDBeJ92HhHHPaEFnHj0nEp
 VSsA346qtryBTdRWTZKunDhn776T3UuFKd4Y2ltbrK3f5aTc=
X-Received: by 2002:a17:906:f1cb:: with SMTP id
 gx11mr13865159ejb.106.1618325884588; 
 Tue, 13 Apr 2021 07:58:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyBS4f8/FtSKZIitrByeXvJ1+6fxGya2GdvXhrTkGICEYkSUaRVVNDzAJfvhqZqrKTZYiywqw==
X-Received: by 2002:a17:906:f1cb:: with SMTP id
 gx11mr13865137ejb.106.1618325884439; 
 Tue, 13 Apr 2021 07:58:04 -0700 (PDT)
Received: from [192.168.1.115] (xdsl-188-155-192-147.adslplus.ch.
 [188.155.192.147])
 by smtp.gmail.com with ESMTPSA id c16sm8258136ejx.81.2021.04.13.07.58.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Apr 2021 07:58:04 -0700 (PDT)
Subject: Re: [PATCH v5 04/16] memory: mtk-smi: Add device-link between
 smi-larb and smi-common
To: Yong Wu <yong.wu@mediatek.com>
References: <20210410091128.31823-1-yong.wu@mediatek.com>
 <20210410091128.31823-5-yong.wu@mediatek.com>
 <ea7ed30f-050d-2d38-7c61-1e0c192f6ded@canonical.com>
 <1618293876.20053.19.camel@mhfsdcap03>
From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <d3b5b48a-82dc-361b-91f7-df0a73629b67@canonical.com>
Date: Tue, 13 Apr 2021 16:58:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <1618293876.20053.19.camel@mhfsdcap03>
Content-Language: en-US
Cc: Will Deacon <will.deacon@arm.com>, youlin.pei@mediatek.com,
 Nicolas Boichat <drinkcat@chromium.org>, Evan Green <evgreen@chromium.org>,
 eizan@chromium.org, Matthias Kaehlcke <mka@chromium.org>,
 devicetree@vger.kernel.org, yi.kuo@mediatek.com,
 Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org,
 Matthias Brugger <matthias.bgg@gmail.com>, ming-fan.chen@mediatek.com,
 linux-arm-kernel@lists.infradead.org, anan.sun@mediatek.com,
 srv_heupstream@mediatek.com, acourbot@chromium.org,
 linux-kernel@vger.kernel.org, chao.hao@mediatek.com,
 iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>
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

On 13/04/2021 08:04, Yong Wu wrote:
> On Sat, 2021-04-10 at 14:40 +0200, Krzysztof Kozlowski wrote:
>> On 10/04/2021 11:11, Yong Wu wrote:
>>> Normally, If the smi-larb HW need work, we should enable the smi-common
>>> HW power and clock firstly.
>>> This patch adds device-link between the smi-larb dev and the smi-common
>>> dev. then If pm_runtime_get_sync(smi-larb-dev), the pm_runtime_get_sync
>>> (smi-common-dev) will be called automatically.
>>>
>>> Also, Add DL_FLAG_STATELESS to avoid the smi-common clocks be gated when
>>> probe.
>>>
>>> CC: Matthias Brugger <matthias.bgg@gmail.com>
>>> Suggested-by: Tomasz Figa <tfiga@chromium.org>
>>> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
>>> ---
>>>  drivers/memory/mtk-smi.c | 19 ++++++++++---------
>>>  1 file changed, 10 insertions(+), 9 deletions(-)
>>
>> I understood this is a dependency for other patches, so:
>> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>>
>> If I am wrong and I can take it via memory tree, let me know.
> 
> Hi Krzysztof,
> 
> Thanks very much for your quickly review.
> 
> I think it is ok if it go through memory tree. In the original patch, we
> pm_runtime_get(smi-common-dev) in the smi-larb's pm resume callback.
> This patch only use device-link do this. thus, this patch have no
> function change. it only adjusts the SMI internal code flow.

Hm, okay, I took it then for v5.13.

> 
> In addition, [14/16] expects your Acked-by. and that one should be
> merged with the others.

Thanks for reminder.

Best regards,
Krzysztof
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
