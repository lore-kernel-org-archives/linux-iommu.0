Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F401BC433EF
	for <iommu@archiver.kernel.org>; Fri, 21 Jan 2022 08:26:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 858DD832B3;
	Fri, 21 Jan 2022 08:26:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VMT8iR_Qmbba; Fri, 21 Jan 2022 08:26:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 60AA1832AA;
	Fri, 21 Jan 2022 08:26:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 33F73C0031;
	Fri, 21 Jan 2022 08:26:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1520FC002F
 for <iommu@lists.linux-foundation.org>; Fri, 21 Jan 2022 08:26:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id F160660BD7
 for <iommu@lists.linux-foundation.org>; Fri, 21 Jan 2022 08:26:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=canonical.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KDQjUAb7NQ6p for <iommu@lists.linux-foundation.org>;
 Fri, 21 Jan 2022 08:26:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2CDD760A90
 for <iommu@lists.linux-foundation.org>; Fri, 21 Jan 2022 08:26:20 +0000 (UTC)
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 7DA1E4004F
 for <iommu@lists.linux-foundation.org>; Fri, 21 Jan 2022 08:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1642753577;
 bh=WFaN2NaRLA9rIp327g1xVjFRTrxCMZQ865lGwbwG9Rk=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=AHehVNRhEXawGtsLWdVJn/T6EwhenYKgrTe39COmL72rBxRgsM6fBL55UWbZu6hSh
 W8PZsGwF4ci6heRnt5PdCvCOZ4/ZG1wxlQz3bSuLclnwHNd5nxcCv/64SkccPKdA7i
 UFEIC3kRqPUbZA2P+n4bDzqB8YX+KvUq6vFN+5q+2sPK2g3zdLSIrkJSmzmJDgQvpa
 REx7faqkW0zMMLOJZBeHhaHK8808ZFM2VwjDnrKUn6q1PDmF6PleUOqzMADGONAFl8
 pMCPuHvcn3X+T/ncqkUMzXl67BqsG+HHC5qyxmqayB80Auo1SRwRhVkX/kwLueMo10
 FzYORSZXY3lbg==
Received: by mail-ed1-f69.google.com with SMTP id
 o25-20020a056402039900b0040631c2a67dso2182562edv.19
 for <iommu@lists.linux-foundation.org>; Fri, 21 Jan 2022 00:26:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=WFaN2NaRLA9rIp327g1xVjFRTrxCMZQ865lGwbwG9Rk=;
 b=DgqAqeGyfLgNQgkJDShFFsMPyT8V8ivN/M1e8iXmzjIjoQsX92Ne21orj9QsG3ywVT
 gtlAteSiSky+/QnDyQjft6uAJwXa2wbi09frn5ZQNSbLbWXu4mS8tKdqcP3WepIJDzd/
 2Lj42IJN7kx2mnpqvY0Ma/EX/BQBCHSoRfLFNXzQ4dtxU+SjJ/8jd7d/RwGaz7kgSw8B
 D/RhRpk6UDiOvHWs073vM0BjXx32Qr1D9pnv06sFd07OKU9p96KVxP17txINnBtrAlA6
 ZlwiLAzHV93Y6MxJrDAZSE48GDWOTOgnjotAb5P8EVxezJuersYzLMsxMIaiRkDuOzaL
 gRAA==
X-Gm-Message-State: AOAM53023TxZGt7FH5y7JGhe5Pv//xgCJwtHpdnbAeg9+o3AcOR2QMib
 TyqvrPYpnn8GNdD1KAxkE4cDCO7fpCvxkA2Znw4HlnkKxjkdV3XH2SUMWwhvlAhhvq+m4Ku4ENB
 VuZROxrzfZTHzFbeqUXnWFJn2MISLJyC8rid1RKMa9woNodU=
X-Received: by 2002:aa7:d949:: with SMTP id l9mr3339677eds.54.1642753576909;
 Fri, 21 Jan 2022 00:26:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzM9vD86mwMtX+h2FjjQlccFgtkFev6o5qFbfunrbz4ISkFfscZEMnftrRS9hu6u4qvlPa49w==
X-Received: by 2002:aa7:d949:: with SMTP id l9mr3339671eds.54.1642753576763;
 Fri, 21 Jan 2022 00:26:16 -0800 (PST)
Received: from [192.168.0.50] (xdsl-188-155-168-84.adslplus.ch.
 [188.155.168.84])
 by smtp.gmail.com with ESMTPSA id cf13sm1821768ejb.141.2022.01.21.00.26.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Jan 2022 00:26:16 -0800 (PST)
Message-ID: <9a006308-cabb-7ee2-0556-860d425b251f@canonical.com>
Date: Fri, 21 Jan 2022 09:26:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [RFC 1/3] dt-bindings: iommu: Add bindings for samsung,sysmmu-v8
Content-Language: en-US
To: Sam Protsenko <semen.protsenko@linaro.org>, Joerg Roedel
 <joro@8bytes.org>, Will Deacon <will@kernel.org>
References: <20220120201958.2649-1-semen.protsenko@linaro.org>
 <20220120201958.2649-2-semen.protsenko@linaro.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220120201958.2649-2-semen.protsenko@linaro.org>
Cc: Janghyuck Kim <janghyuck.kim@samsung.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Carlos Llamas <cmllamas@google.com>,
 Sumit Semwal <sumit.semwal@linaro.org>, linux-samsung-soc@vger.kernel.org,
 Mark Salyzyn <salyzyn@google.com>, Jinkyu Yang <jinkyu1.yang@samsung.com>,
 Thierry Strudel <tstrudel@google.com>, Will McVicker <willmcvicker@google.com>,
 Cho KyongHo <pullip.cho@samsung.com>, linux-arm-kernel@lists.infradead.org,
 Jonglin Lee <jonglin@google.com>, "J . Avila" <elavila@google.com>,
 Alex <acnwigwe@google.com>, linux-kernel@vger.kernel.org,
 Hyesoo Yu <hyesoo.yu@samsung.com>, iommu@lists.linux-foundation.org,
 Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>
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

On 20/01/2022 21:19, Sam Protsenko wrote:
> Only example of usage and header for now.
> 
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---
>  .../bindings/iommu/samsung,sysmmu-v8.txt      | 31 +++++++++++++

Please, don't copy paste bindings or entire drviers from vendor kernel.
It looks very bad. Instead, submit them in dtschema.

NAK.

>  include/dt-bindings/soc/samsung,sysmmu-v8.h   | 43 +++++++++++++++++++
>  2 files changed, 74 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iommu/samsung,sysmmu-v8.txt
>  create mode 100644 include/dt-bindings/soc/samsung,sysmmu-v8.h
> 
> diff --git a/Documentation/devicetree/bindings/iommu/samsung,sysmmu-v8.txt b/Documentation/devicetree/bindings/iommu/samsung,sysmmu-v8.txt
> new file mode 100644
> index 000000000000..d6004ea4a746
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iommu/samsung,sysmmu-v8.txt
> @@ -0,0 +1,31 @@
> +Example (Exynos850, IOMMU for DPU usage):
> +
> +	#include <dt-bindings/soc/samsung,sysmmu-v8.h>
> +
> +	/* IOMMU group info */
> +	iommu_group_dpu: iommu_group_dpu {
> +		compatible = "samsung,sysmmu-group";
> +	};
> +
> +	sysmmu_dpu: sysmmu@130c0000 {
> +		compatible = "samsung,sysmmu-v8";
> +		reg = <0x130c0000 0x9000>;
> +		interrupts = <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>;
> +		qos = <15>;
> +
> +		clocks = <&cmu_dpu CLK_GOUT_DPU_SMMU_CLK>;
> +		clock-names = "gate";
> +
> +		sysmmu,secure-irq;
> +		sysmmu,secure_base = <0x130d0000>;
> +		sysmmu,default_tlb = <TLB_CFG(BL1, PREFETCH_PREDICTION)>;
> +		sysmmu,tlb_property =
> +			<1 TLB_CFG(BL1, PREFETCH_PREDICTION) (DIR_READ | (1 << 16)) SYSMMU_ID_MASK(0x2, 0xF)>,
> +			<2 TLB_CFG(BL1, PREFETCH_PREDICTION) (DIR_READ | (1 << 16)) SYSMMU_ID_MASK(0x4, 0xF)>,
> +			<3 TLB_CFG(BL1, PREFETCH_PREDICTION) (DIR_READ | (1 << 16)) SYSMMU_ID_MASK(0x6, 0xF)>,
> +			<4 TLB_CFG(BL1, PREFETCH_PREDICTION) (DIR_READ | (1 << 16)) SYSMMU_ID_MASK(0x8, 0xF)>;
> +		port-name = "DPU";
> +		#iommu-cells = <0>;
> +		//power-domains = <&pd_dpu>;

We try not to store dead code in kernel.



Best regards,
Krzysztof
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
