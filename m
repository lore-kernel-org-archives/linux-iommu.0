Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76D97C433EF
	for <iommu@archiver.kernel.org>; Mon, 17 Jan 2022 12:01:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1B5DE401ED;
	Mon, 17 Jan 2022 12:01:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SHGt4bMLBCRr; Mon, 17 Jan 2022 12:01:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id ECF14401E2;
	Mon, 17 Jan 2022 12:01:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BFC5CC0039;
	Mon, 17 Jan 2022 12:01:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AE339C002F
 for <iommu@lists.linux-foundation.org>; Mon, 17 Jan 2022 12:01:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9B39780B63
 for <iommu@lists.linux-foundation.org>; Mon, 17 Jan 2022 12:01:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=canonical.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id x-8AvlIxTWtv for <iommu@lists.linux-foundation.org>;
 Mon, 17 Jan 2022 12:01:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C688880B60
 for <iommu@lists.linux-foundation.org>; Mon, 17 Jan 2022 12:01:45 +0000 (UTC)
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id CA2334000F
 for <iommu@lists.linux-foundation.org>; Mon, 17 Jan 2022 12:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1642420902;
 bh=bAUdRzIm9/2z1tZx93HbZGiaxfI165En29R890ewPoU=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=UzlMSriAYt/VsMIgB5iS7dgfqnUpuc4K003Eqk3icTMVlFhZeypeYslrPoYz8heKk
 s8hkL2lnLwti4r4cZzhWi/yCOBqRWFiAFEbfSxEasnJypcoGPpK6GOcR4o9gYBxGxJ
 Aj9fvfqTzub8eTmjbAbtEDjBvGqzi4q3joABviMGxfBDAV2R4DylJDpC2d0N0J+j+1
 SiyFoyEucLelrM3G60Z+9EZin8iTo2V09qyzGYUomOkaZPXPIKww8dxH0AlmKmHbYF
 lr5eNIePqx9TemfGthh/DI0dFaLTSOGN/Nl+h2p0yYM1IUJp2+hmZNsw/odh9nUllO
 Ud0CBpdeP3lVw==
Received: by mail-ed1-f71.google.com with SMTP id
 c8-20020a05640227c800b003fdc1684cdeso14052408ede.12
 for <iommu@lists.linux-foundation.org>; Mon, 17 Jan 2022 04:01:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=bAUdRzIm9/2z1tZx93HbZGiaxfI165En29R890ewPoU=;
 b=MrWU/BJgbweknRjrUoj3f83AoHOJC6O62Zw+5L5W9EdPxVYmJi3zKggoMgyN+qOAPe
 ydRl+Yi+zSaaChVRsjc+Dfx3KK5L2YXJZRVg4OQDt9KmAqPzWYO4fcVd7lf61tmNrH8x
 AWjxRHSGKVDqL1s/I69LWIp2RvifnWN3xQwadJLKwQ0REB07arCXfS2hDZKwzl6Is7IB
 YNtLI7D0/nHsaCEi/MNp31UDILASQ3sCLoQht3IFdor15yeFZsIKOeqg5+1bASaKyrRr
 SfMm+FdGUIw+BQy9d2iaXnucQmIhB4gGLlJua5qEYMYkG8o+XkXOpffQaUETNI6LAPCp
 w0MQ==
X-Gm-Message-State: AOAM531eFx5vIIBaUYLtTrkSal/8FRdL+K25TAoIboKrGrpef+VXCD6C
 qUWeVmMODP08dncxzbIofPmiXNMurHJSLo0C2z3duUHV8kzqFPZIH7+Q/6PxouubqCkEN0GSbeu
 boasWHTVlPoHyjcL+HfR16Hyl3SdAYa4U8EKJwk1g425LqJ8=
X-Received: by 2002:a17:906:e249:: with SMTP id
 gq9mr14818910ejb.258.1642420902444; 
 Mon, 17 Jan 2022 04:01:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwdZgJNSpG3yPSHuygPWHopeMLD3qUZtx1G/vR+ammoYPGm5EgWxjMpAsCvVrMFa/M0hof7+A==
X-Received: by 2002:a17:906:e249:: with SMTP id
 gq9mr14818904ejb.258.1642420902250; 
 Mon, 17 Jan 2022 04:01:42 -0800 (PST)
Received: from [192.168.0.37] (xdsl-188-155-168-84.adslplus.ch.
 [188.155.168.84])
 by smtp.gmail.com with ESMTPSA id r15sm1766230ejz.39.2022.01.17.04.01.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Jan 2022 04:01:41 -0800 (PST)
Message-ID: <7370f18b-e273-69f2-1cc9-a42495e04874@canonical.com>
Date: Mon, 17 Jan 2022 13:01:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v3 5/7] memory: mtk-smi: Fix the return value for
 clk_bulk_prepare_enable
Content-Language: en-US
To: Yong Wu <yong.wu@mediatek.com>, Rob Herring <robh+dt@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>
References: <20220113111057.29918-1-yong.wu@mediatek.com>
 <20220113111057.29918-6-yong.wu@mediatek.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220113111057.29918-6-yong.wu@mediatek.com>
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org, yi.kuo@mediatek.com,
 srv_heupstream@mediatek.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
 lc.kan@mediatek.com, anthony.huang@mediatek.com, anan.sun@mediatek.com,
 linux-arm-kernel@lists.infradead.org,
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

On 13/01/2022 12:10, Yong Wu wrote:
> Function clk_bulk_prepare_enable() returns 0 for success or a negative
> number for error. Fix this code style issue.

The message does not really make sense. If negative is returned, then
the check (ret < 0) was correct.

I guess you wanted to say that common code style is to check for any
non-zero return value, just like it's implementation in clk.h does.

I'll adjust the commit msg when applying.

> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  drivers/memory/mtk-smi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
> index b883dcc0bbfa..e7b1a22b12ea 100644
> --- a/drivers/memory/mtk-smi.c
> +++ b/drivers/memory/mtk-smi.c
> @@ -480,7 +480,7 @@ static int __maybe_unused mtk_smi_larb_resume(struct device *dev)
>  	int ret;
>  
>  	ret = clk_bulk_prepare_enable(larb->smi.clk_num, larb->smi.clks);
> -	if (ret < 0)
> +	if (ret)
>  		return ret;
>  
>  	/* Configure the basic setting for this larb */
> 


Best regards,
Krzysztof
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
