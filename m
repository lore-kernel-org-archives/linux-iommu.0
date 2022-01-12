Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2CFFC433EF
	for <iommu@archiver.kernel.org>; Wed, 12 Jan 2022 10:18:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7C890415FE;
	Wed, 12 Jan 2022 10:18:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ihFBtwvRrAKM; Wed, 12 Jan 2022 10:18:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 78217415FB;
	Wed, 12 Jan 2022 10:18:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 487E5C0030;
	Wed, 12 Jan 2022 10:18:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6C62AC001E
 for <iommu@lists.linux-foundation.org>; Wed, 12 Jan 2022 10:18:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6848C41600
 for <iommu@lists.linux-foundation.org>; Wed, 12 Jan 2022 10:18:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zx5MBXZLLc6K for <iommu@lists.linux-foundation.org>;
 Wed, 12 Jan 2022 10:18:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A6AF8415FB
 for <iommu@lists.linux-foundation.org>; Wed, 12 Jan 2022 10:18:07 +0000 (UTC)
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id E36A93F1E9
 for <iommu@lists.linux-foundation.org>; Wed, 12 Jan 2022 10:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1641982685;
 bh=aPXjXruDq54PeYQ9iMhjoDG9FDgbk3AB64hbIMorCCc=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=J1epngDH3rtVyI0kw1nwO+o1iWW//vTfuVENIMKaYqaYCseHA8Y02rjXUM2TiXrLv
 HVUj1uAoisc6ftWpERPfJ3h+P0YTJpRXYXML28XIIgdVh2JYF0kPHF35WHBKPy4fBx
 T/OvlmAS/hjnhz9ZKBSBrsVG7cdnZsM3/O6WsrPzxhL+tpMQqLF0TCS9IppAUSimMW
 I1GJpekek+y5jRkpRQ6m9UGqOjupIYzruyy9VKnm46sn0JXuGtdMuWzeI2HVd07/k8
 Yib67PK91VooIO1EKwu4u4UsqFMfeub6qVfqkDNT1rC8Uh5DRR3iN+PU99tgfC2Lrm
 rtjo7M95toeAQ==
Received: by mail-ed1-f71.google.com with SMTP id
 l14-20020aa7cace000000b003f7f8e1cbbdso1811829edt.20
 for <iommu@lists.linux-foundation.org>; Wed, 12 Jan 2022 02:18:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=aPXjXruDq54PeYQ9iMhjoDG9FDgbk3AB64hbIMorCCc=;
 b=LINCfuhPtQhXzJ3h0iOF07fijG8MzDcnbVhClBTllOB7tRHy7xQBuykRbE9ev9VQMS
 O3TkzK210cYvkMDkFGIf1MB3rhvf4V9BmjgyVM2Y6T3fbzqzut0nrqT0qHFpdD9RWQa3
 I1ozi128C/gZQtIuTXWSUTSaMJB1/Oy/8U/3iM7BLoxAQb3DgiPHBojKTBx8k7LUE5JN
 vtME8/i4AJ6goNNCVMDBbw/A0Aj3T01dXKt1zEOe1i20gKgWarKocyhTA+zAVi+CPYtG
 WzyxlYQA0B3e1v/lbtzGVbvjoQA7tIJ9Kp9eZ/wbwnsgH+YP5qZJOWUSeZketPfbnrHT
 PsgQ==
X-Gm-Message-State: AOAM531saxBrwZPpTLVG1uuanuY/u5IA32a3khX9nx5Jw81/BjmjmrdQ
 0kUeNDOAuLrsz6Ux2GXRRs72BU4+INJgf0Io8tuSna1Wyiuwx33VUQ5NXn9QjugjEsDjylTxpbn
 3PZEEWiqcby1GN02qJBGvTjRMWrzjJTqc8nsfyP6p58Oc8Ds=
X-Received: by 2002:a17:906:ecee:: with SMTP id
 qt14mr471014ejb.133.1641982685614; 
 Wed, 12 Jan 2022 02:18:05 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxkDLUnDXncfLM2SjyZMmYMSSgiKcr4RLjw+16eEj0TVwkNqMlPbJfgszDEo6F90TMvDr8RGQ==
X-Received: by 2002:a17:906:ecee:: with SMTP id
 qt14mr470995ejb.133.1641982685404; 
 Wed, 12 Jan 2022 02:18:05 -0800 (PST)
Received: from [192.168.0.29] (xdsl-188-155-168-84.adslplus.ch.
 [188.155.168.84])
 by smtp.gmail.com with ESMTPSA id eb14sm6047322edb.16.2022.01.12.02.18.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Jan 2022 02:18:05 -0800 (PST)
Message-ID: <b8b8fe77-2ea8-d05c-5fa2-d4cae01baba5@canonical.com>
Date: Wed, 12 Jan 2022 11:18:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v2 2/6] dt-bindings: memory: mtk-smi: Fix the larb
 clock/clock-names dtbs warning
Content-Language: en-US
To: Yong Wu <yong.wu@mediatek.com>, Rob Herring <robh+dt@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>
References: <20220111063904.7583-1-yong.wu@mediatek.com>
 <20220111063904.7583-3-yong.wu@mediatek.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220111063904.7583-3-yong.wu@mediatek.com>
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
> Mute the warning from "make dtbs_check":
> 
> larb@14017000: clock-names: ['apb', 'smi'] is too short
> 	arch/arm64/boot/dts/mediatek/mt8183-evb.dt.yaml
> 	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-burnet.dt.yaml
> 	...
> 
> larb@16010000: clock-names: ['apb', 'smi'] is too short
> 	arch/arm64/boot/dts/mediatek/mt8183-evb.dt.yaml
> 	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-burnet.dt.yaml
> 
> larb@17010000: clock-names: ['apb', 'smi'] is too short
> 	arch/arm64/boot/dts/mediatek/mt8183-evb.dt.yaml
> 	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-burnet.dt.yaml
> 
> If a platform's larb supports gals, there will be some larbs have one
> more "gals" clock while the others still only need "apb"/"smi" clocks,
> then the minItems for clock and clock-names are 2.
> 
> Fixes: 27bb0e42855a ("dt-bindings: memory: mediatek: Convert SMI to DT schema")
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  .../bindings/memory-controllers/mediatek,smi-larb.yaml      | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml
> index 80907e357892..884c0c74e5e4 100644
> --- a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml
> +++ b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml
> @@ -80,10 +80,10 @@ allOf:
>      then:
>        properties:
>          clock:

Separate patch:
This should be clocks. The same in second if. Now it is simply not
working...

> -          items:

Putting min/maxItems under items is wrong. The second if also needs the
fixing. Please make it a separate patch before this one.

The schema was clearly not tested before...


> -            minItems: 3
> -            maxItems: 3
> +          minItems: 2
> +          maxItems: 3
>          clock-names:
> +          minItems: 2
>            items:
>              - const: apb
>              - const: smi
> 


Best regards,
Krzysztof
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
