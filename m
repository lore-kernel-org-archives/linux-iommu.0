Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CCC4C433EF
	for <iommu@archiver.kernel.org>; Mon,  4 Jul 2022 12:38:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D8FC24157C;
	Mon,  4 Jul 2022 12:38:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D8FC24157C
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ttufPLcT
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5QGRREqLAuER; Mon,  4 Jul 2022 12:38:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5D05840300;
	Mon,  4 Jul 2022 12:38:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5D05840300
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0CDB0C0032;
	Mon,  4 Jul 2022 12:38:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 81778C002D
 for <iommu@lists.linux-foundation.org>; Mon,  4 Jul 2022 12:38:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 599B14058E
 for <iommu@lists.linux-foundation.org>; Mon,  4 Jul 2022 12:38:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 599B14058E
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=ttufPLcT
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6PF7GjWnfNOE for <iommu@lists.linux-foundation.org>;
 Mon,  4 Jul 2022 12:38:20 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7D0C24049F
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7D0C24049F
 for <iommu@lists.linux-foundation.org>; Mon,  4 Jul 2022 12:38:20 +0000 (UTC)
Received: by mail-lf1-x12e.google.com with SMTP id t24so15593925lfr.4
 for <iommu@lists.linux-foundation.org>; Mon, 04 Jul 2022 05:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=BAn7H856GfFRIZFIPVXMWyj53npckuCFDy0OCv3VUpA=;
 b=ttufPLcTzCznFU5yCsxwU6S2KKVGSbhhl1fAH1EC/QzUhgf5uu757WjgKjCILW6C8G
 ahnSm/UjhZWTglFPNpkRIqigLPNAdTTxYrUW/kvlcHzSP9lHm6LODb7RYRLLrwMvXMyb
 E6MhPv2VXM2CbgjD9ayU4di+itAGXAmQcI0Ubus9FL/o8zGyP3+QXSernOCsmyDXhWSw
 RXv+RR5rzdHAHxxYuJb/VIDS0BB5RwP9qBeV4XqjYZ363eVcqgw3pf42j/Ao0HpPHA7L
 mlpp4lPV6WC9Fmybv7sumvnEDbDhQI16EubQ0mhf+MX+n7+r0ovazuyjaoVNMYIfgZiM
 tDAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=BAn7H856GfFRIZFIPVXMWyj53npckuCFDy0OCv3VUpA=;
 b=ia/UYjRz7IBG4Yi7lFz/y4dQGV6I2lwVJOohWXeoLg9O+DqeLhkOsyh0HaeK5NnEOB
 6O+hujHmzKqWnz1Wt+ZVdnczG12+WKbEXlcCuOs+ijI/HImOP0NrXssvxDXIji3Gv1zS
 yrPqPxdz8/p4jKdhxZlOc6QpOWZEu6jSGXz89fsLtLROjRS7M4djEbYacaSdmkLS7Ei0
 jh36AVUwLXD6TEkk2nFNqFKq1iKZkfqIgIss+PPoH7tLXbbpY8a0q2qRB1HWa6qH2Bn5
 bedGwdI+UI5odC+r6AW1iOsspm0k3ePfupA9gI4vxEIUvqAJftABFH+0RlhAbtHELm0W
 bfQg==
X-Gm-Message-State: AJIora/+Wb5nw0MSoms5lVbEzGoMBRFEC7JLpcMu1djm7iF2uxTjfFQP
 lqdw9T/VjcXUhMBbVQVO1s0klQ==
X-Google-Smtp-Source: AGRyM1tVufJHyD7qAM2njRRF0qbXtYAbqkVJD/3FnkNNHjFwWDejKXalAn22BDebBg99Lz1Y+vUkXw==
X-Received: by 2002:a05:6512:4006:b0:47f:912d:1400 with SMTP id
 br6-20020a056512400600b0047f912d1400mr18533386lfb.466.1656938298236; 
 Mon, 04 Jul 2022 05:38:18 -0700 (PDT)
Received: from [192.168.1.52] ([84.20.121.239])
 by smtp.gmail.com with ESMTPSA id
 s11-20020a056512214b00b0047fbc399ad2sm5008363lfr.245.2022.07.04.05.38.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Jul 2022 05:38:17 -0700 (PDT)
Message-ID: <3b65405d-167f-a0c7-d15e-5da6f08d99b3@linaro.org>
Date: Mon, 4 Jul 2022 14:38:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v1 08/16] arm64: dts: mt8195: Add power domains controller
Content-Language: en-US
To: Tinghan Shen <tinghan.shen@mediatek.com>, Yong Wu <yong.wu@mediatek.com>, 
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Chun-Jie Chen <chun-jie.chen@mediatek.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Enric Balletbo i Serra <enric.balletbo@collabora.com>,
 Weiyi Lu <weiyi.lu@mediatek.com>
References: <20220704100028.19932-1-tinghan.shen@mediatek.com>
 <20220704100028.19932-9-tinghan.shen@mediatek.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220704100028.19932-9-tinghan.shen@mediatek.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com,
 iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
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

On 04/07/2022 12:00, Tinghan Shen wrote:
> Add power domains controller node for mt8195.
> 
> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt8195.dtsi | 327 +++++++++++++++++++++++
>  1 file changed, 327 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> index 8d59a7da3271..d52e140d9271 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> @@ -10,6 +10,7 @@
>  #include <dt-bindings/interrupt-controller/irq.h>
>  #include <dt-bindings/phy/phy.h>
>  #include <dt-bindings/pinctrl/mt8195-pinfunc.h>
> +#include <dt-bindings/power/mt8195-power.h>
>  
>  / {
>  	compatible = "mediatek,mt8195";
> @@ -338,6 +339,332 @@
>  			#interrupt-cells = <2>;
>  		};
>  
> +		scpsys: syscon@10006000 {
> +			compatible = "syscon", "simple-mfd";

These compatibles cannot be alone.

> +			reg = <0 0x10006000 0 0x1000>;
> +			#power-domain-cells = <1>;

If it is simple MFD, then probably it is not a power domain provider.
Decide.

Best regards,
Krzysztof
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
