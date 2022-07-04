Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8109CCA47F
	for <iommu@archiver.kernel.org>; Mon,  4 Jul 2022 10:44:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7F9158268B;
	Mon,  4 Jul 2022 10:44:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7F9158268B
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=CioOKrpD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XDzZNBkpgA0w; Mon,  4 Jul 2022 10:44:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5C1DE8261C;
	Mon,  4 Jul 2022 10:44:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5C1DE8261C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 366F6C0032;
	Mon,  4 Jul 2022 10:44:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 18EC1C002D
 for <iommu@lists.linux-foundation.org>; Mon,  4 Jul 2022 10:44:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D4AE182628
 for <iommu@lists.linux-foundation.org>; Mon,  4 Jul 2022 10:44:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D4AE182628
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6vNCmovD5hBp for <iommu@lists.linux-foundation.org>;
 Mon,  4 Jul 2022 10:44:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 20C108261C
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 20C108261C
 for <iommu@lists.linux-foundation.org>; Mon,  4 Jul 2022 10:44:12 +0000 (UTC)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it
 [2.237.20.237])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested) (Authenticated sender: kholk11)
 by madras.collabora.co.uk (Postfix) with ESMTPSA id 62B6766015A6;
 Mon,  4 Jul 2022 11:44:09 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1656931450;
 bh=gjNEsUi0SsF/6vtg4n8Tc6Jg9gWEjEsUA2sD8bp3x9I=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=CioOKrpDBDzPBsG3sOxB6gSfHCwZY7y8rfYurcXucgtbNanLuZyEK65ugGX2LLs4V
 dFKRiesAMYgxiR47wQvDPJBuBmt3S/nD8IeQWXNnLvdnnYIFDESGu0b5o+6DQDSx22
 lc0gNcxYvD+zaz+qQS4DA6vBz/s6u+i6BKT5KnWjHv8FTNh5sIDZffjdxdZqZV3j0d
 OddSGfq5JlDhU6UWuMb75zhx69WQbzMPSCSmLu8ArrCKdV0wU9SpI4aEjTSPTyxFkB
 soyVnShjmhFu8A+ArMUl7Akqabr6UYyPG2qQqN9FTNJkDlual7BTuzAmndoUYsWB7R
 IRmJE2yXMbbwA==
Message-ID: <84ce9b03-9edd-9ef1-aec1-127b34c23021@collabora.com>
Date: Mon, 4 Jul 2022 12:44:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v1 16/16] arm64: dts: mt8195: Add display node for vdosys0
Content-Language: en-US
To: Tinghan Shen <tinghan.shen@mediatek.com>, Yong Wu <yong.wu@mediatek.com>, 
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Chun-Jie Chen <chun-jie.chen@mediatek.com>, Weiyi Lu <weiyi.lu@mediatek.com>
References: <20220704100028.19932-1-tinghan.shen@mediatek.com>
 <20220704100028.19932-17-tinghan.shen@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220704100028.19932-17-tinghan.shen@mediatek.com>
Cc: devicetree@vger.kernel.org, "Jason-JH.Lin" <jason-jh.lin@mediatek.com>,
 linux-kernel@vger.kernel.org,
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Il 04/07/22 12:00, Tinghan Shen ha scritto:
> From: "Jason-JH.Lin" <jason-jh.lin@mediatek.com>
> 
> Add display node for vdosys0 of mt8195.
> 
> Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> ---
>   arch/arm64/boot/dts/mediatek/mt8195.dtsi | 109 +++++++++++++++++++++++
>   1 file changed, 109 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> index 724c6ca837b6..faea8ef33e5a 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> @@ -1961,6 +1961,7 @@
>   		vdosys0: syscon@1c01a000 {
>   			compatible = "mediatek,mt8195-mmsys", "syscon";
>   			reg = <0 0x1c01a000 0 0x1000>;
> +			mboxes = <&gce0 0 CMDQ_THR_PRIO_4>;
>   			#clock-cells = <1>;
>   		};
>   
> @@ -1976,6 +1977,114 @@
>   			power-domains = <&spm MT8195_POWER_DOMAIN_VENC_CORE1>;
>   		};
>   
> +		ovl0: ovl@1c000000 {
> +			compatible = "mediatek,mt8195-disp-ovl",
> +				     "mediatek,mt8183-disp-ovl";

This fits in one line, please fix, here and all of the other instances of that.

> +			reg = <0 0x1c000000 0 0x1000>;
> +			interrupts = <GIC_SPI 636 IRQ_TYPE_LEVEL_HIGH 0>;
> +			power-domains = <&spm MT8195_POWER_DOMAIN_VDOSYS0>;
> +			clocks = <&vdosys0 CLK_VDO0_DISP_OVL0>;
> +			iommus = <&iommu_vdo M4U_PORT_L0_DISP_OVL0_RDMA0>;
> +			mediatek,gce-client-reg =
> +				 <&gce0 SUBSYS_1c00XXXX 0x0000 0x1000>;

Same for gce-client-reg.

Regards,
Angelo
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
