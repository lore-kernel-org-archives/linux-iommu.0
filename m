Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2D2DC43334
	for <iommu@archiver.kernel.org>; Thu,  9 Jun 2022 18:08:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4B23341CCD;
	Thu,  9 Jun 2022 18:08:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id H0BbxsKe9GhT; Thu,  9 Jun 2022 18:08:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E0E6041B57;
	Thu,  9 Jun 2022 18:08:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A3EBBC0032;
	Thu,  9 Jun 2022 18:08:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6A4C7C002D
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jun 2022 18:08:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 50BF982468
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jun 2022 18:08:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id p_sRNO6tegKT for <iommu@lists.linux-foundation.org>;
 Thu,  9 Jun 2022 18:08:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8802D823E3
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jun 2022 18:08:51 +0000 (UTC)
X-UUID: 0f46fe5d8de7409e94190e6eefd88765-20220610
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5, REQID:a195b405-18dd-4bd5-a4ed-49db4cfc5322, OB:10,
 L
 OB:20,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,A
 CTION:release,TS:45
X-CID-INFO: VERSION:1.1.5, REQID:a195b405-18dd-4bd5-a4ed-49db4cfc5322, OB:10,
 LOB
 :20,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACT
 ION:release,TS:45
X-CID-META: VersionHash:2a19b09, CLOUDID:b82cd47e-c8dc-403a-96e8-6237210dceee,
 C
 OID:0599961d4d23,Recheck:0,SF:28|17|19|48,TC:nil,Content:-5,EDM:-3,IP:nil,
 URL:0,File:nil,QS:0,BEC:nil
X-UUID: 0f46fe5d8de7409e94190e6eefd88765-20220610
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by
 mailgw01.mediatek.com (envelope-from <miles.chen@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 512735973; Fri, 10 Jun 2022 02:08:46 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3; 
 Fri, 10 Jun 2022 02:08:45 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Fri, 10 Jun 2022 02:08:45 +0800
To: <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v3 4/6] arm64: dts: mediatek: mt2712e: Add mediatek,
 infracfg phandle for IOMMU
Date: Fri, 10 Jun 2022 02:08:45 +0800
Message-ID: <20220609180845.31195-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220609100802.54513-5-angelogioacchino.delregno@collabora.com>
References: <20220609100802.54513-5-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
X-MTK: N
Cc: devicetree@vger.kernel.org, krzysztof.kozlowski@linaro.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 robh+dt@kernel.org, linux-mediatek@lists.infradead.org,
 krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com, will@kernel.org,
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
From: Miles Chen via iommu <iommu@lists.linux-foundation.org>
Reply-To: Miles Chen <miles.chen@mediatek.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

> The IOMMU driver now looks for the "mediatek,infracfg" phandle as a
> new way to retrieve a syscon to that:
> even though the old way is retained, it has been deprecated and the
> driver will write a message in kmsg advertising to use the phandle
> way instead.
> 
> For this reason, assign the right phandle to mediatek,infracfg in
> the iommu node.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Miles Chen <miles.chen@mediatek.com> 

> ---
>  arch/arm64/boot/dts/mediatek/mt2712e.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt2712e.dtsi b/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
> index 623eb3beabf2..4797537cb368 100644
> --- a/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
> @@ -329,6 +329,7 @@ iommu0: iommu@10205000 {
>  		interrupts = <GIC_SPI 147 IRQ_TYPE_LEVEL_LOW>;
>  		clocks = <&infracfg CLK_INFRA_M4U>;
>  		clock-names = "bclk";
> +		mediatek,infracfg = <&infracfg>;
>  		mediatek,larbs = <&larb0>, <&larb1>, <&larb2>,
>  				 <&larb3>, <&larb6>;
>  		#iommu-cells = <1>;
> @@ -346,6 +347,7 @@ iommu1: iommu@1020a000 {
>  		interrupts = <GIC_SPI 145 IRQ_TYPE_LEVEL_LOW>;
>  		clocks = <&infracfg CLK_INFRA_M4U>;
>  		clock-names = "bclk";
> +		mediatek,infracfg = <&infracfg>;
>  		mediatek,larbs = <&larb4>, <&larb5>, <&larb7>;
>  		#iommu-cells = <1>;
>  	};
> -- 
> 2.35.1
> 
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
