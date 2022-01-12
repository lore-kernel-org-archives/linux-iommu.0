Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03E3CC433EF
	for <iommu@archiver.kernel.org>; Wed, 12 Jan 2022 10:11:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9C03E60B6B;
	Wed, 12 Jan 2022 10:11:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LCwBFoHpTr28; Wed, 12 Jan 2022 10:11:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 7A91860A8A;
	Wed, 12 Jan 2022 10:11:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4A6D5C0030;
	Wed, 12 Jan 2022 10:11:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BC826C001E
 for <iommu@lists.linux-foundation.org>; Wed, 12 Jan 2022 10:11:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 961D960A92
 for <iommu@lists.linux-foundation.org>; Wed, 12 Jan 2022 10:11:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QTRsYqcXV7hy for <iommu@lists.linux-foundation.org>;
 Wed, 12 Jan 2022 10:11:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D1B1560A8A
 for <iommu@lists.linux-foundation.org>; Wed, 12 Jan 2022 10:11:12 +0000 (UTC)
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id C61763F198
 for <iommu@lists.linux-foundation.org>; Wed, 12 Jan 2022 10:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1641982269;
 bh=hFTGw3RKSwc/q5rISEyTidCT2dMSfG1tgduzWghD4aY=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=jFEJe7hEmSE9lZwlAcn3eurFShVIHucioQDnCZ+vItBeYbbOjFk1eiFRg+Ls+Y6Af
 gYwD8zJ9unK8Jw5iRWcg7uKALOV67ER/Fwl/4hABO7zwBvakGLPt4EvSHToB28eH1b
 RjvxOdeLRaq6oebK3iKzo/KKJVsVFxcYf2JQMslegi9o3ewE7Yn8J8vWoJBABXlphG
 MsHUtMKAmyXEP331ihzZBdrPEbMPwXsPD9BVDUQYnkmdDEU6evATDWKy2hwO3VU7+a
 LQeG8l4FBRFAOYBZYh9r4rKtSq039FZYUP1ZUEb1TDHDJkyVwxvKGgF0zxfXbDw+DT
 LIuupLvpvTBuA==
Received: by mail-ed1-f72.google.com with SMTP id
 j10-20020a05640211ca00b003ff0e234fdfso1888246edw.0
 for <iommu@lists.linux-foundation.org>; Wed, 12 Jan 2022 02:11:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=hFTGw3RKSwc/q5rISEyTidCT2dMSfG1tgduzWghD4aY=;
 b=7zcQoixn5ZX0ySNvQEAkrLvoiZ1X2djb4ToEtHxAj1ChRBMXHWdzTsFA++akvOOq2y
 avquzJRQD3UW3Jr3Dook1ArmhnsJj1AfxXZdcBwGE8HIY0TKUq5EUz/T/FHLVHUZuOh5
 v0GVL2x35nW/5e7cjncSf3iXJwimPkL6OHKpCY4mDgH5KyXnY/loO9DvtSIxIZDYhPOe
 akZnGbnf1TYRbkOoBSORY1EZWglyVkBLppnUjLHhxe3qxWK92fUdU+9I227iBXDNk9O5
 IlA76SBrIQwfQrPk5HRDki+BoEbpGxexAluy1Mt8U+JRcCpgO3+AG/uvZDyTa7PRHSff
 xt3w==
X-Gm-Message-State: AOAM532yuj9Mz3iavevW8KHKhchhL2y3Bw/H6ANGnQIqlziajBdonUJl
 lZ+EhVbcr5V0bpHzrgpZQRywXEgCvDz1SQUy35wiV5TvFDEBHxpcC4gYN2waveen8x61ZEpyAUP
 /8AQ9j814EkO1Shhtg5Z7TctbPZ34lX9fwnpZ5yssEYmeptw=
X-Received: by 2002:aa7:d60f:: with SMTP id c15mr8344910edr.197.1641982269300; 
 Wed, 12 Jan 2022 02:11:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzAkZIIY2ouEWvjM2UFpm4JbXirsTAwA2NAyMnQsItvL764zEjLqhJIHuRjBZytND7lxY0dyA==
X-Received: by 2002:aa7:d60f:: with SMTP id c15mr8344880edr.197.1641982269143; 
 Wed, 12 Jan 2022 02:11:09 -0800 (PST)
Received: from [192.168.0.29] (xdsl-188-155-168-84.adslplus.ch.
 [188.155.168.84])
 by smtp.gmail.com with ESMTPSA id 21sm4338800ejx.83.2022.01.12.02.11.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Jan 2022 02:11:08 -0800 (PST)
Message-ID: <82e235d9-4e57-a4e4-66af-84277f9b9da6@canonical.com>
Date: Wed, 12 Jan 2022 11:11:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v2 1/6] dt-bindings: memory: mtk-smi: Fix larb-id
 dtbs_check warning
Content-Language: en-US
To: Yong Wu <yong.wu@mediatek.com>, Rob Herring <robh+dt@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>
References: <20220111063904.7583-1-yong.wu@mediatek.com>
 <20220111063904.7583-2-yong.wu@mediatek.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220111063904.7583-2-yong.wu@mediatek.com>
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

On 11/01/2022 07:38, Yong Wu wrote:
> Mute the warning from "make dtbs_check":
> 
> larb@14016000: 'mediatek,larb-id' is a required property
> 	arch/arm64/boot/dts/mediatek/mt8167-pumpkin.dt.yaml
> larb@15001000: 'mediatek,larb-id' is a required property
> 	arch/arm64/boot/dts/mediatek/mt8167-pumpkin.dt.yaml
> larb@16010000: 'mediatek,larb-id' is a required property
> 	arch/arm64/boot/dts/mediatek/mt8167-pumpkin.dt.yaml

Please explain why larb-id is not necessary on mediatek,mt8167-smi-larb.
IOW, what logical error was there (except the dtschema pointed out issue).

> 
> Fixes: 27bb0e42855a ("dt-bindings: memory: mediatek: Convert SMI to DT schema")
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  .../bindings/memory-controllers/mediatek,smi-larb.yaml           | 1 -
>  1 file changed, 1 deletion(-)
> 


Best regards,
Krzysztof
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
