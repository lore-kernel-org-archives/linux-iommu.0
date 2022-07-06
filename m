Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84562C43334
	for <iommu@archiver.kernel.org>; Wed,  6 Jul 2022 04:03:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2436D40ACA;
	Wed,  6 Jul 2022 04:03:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2436D40ACA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XePYN0X1ulD0; Wed,  6 Jul 2022 04:03:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id AF214400FE;
	Wed,  6 Jul 2022 04:03:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AF214400FE
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7694CC0077;
	Wed,  6 Jul 2022 04:03:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 131AEC0070
 for <iommu@lists.linux-foundation.org>; Wed,  6 Jul 2022 04:03:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D2ECB83372
 for <iommu@lists.linux-foundation.org>; Wed,  6 Jul 2022 04:02:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D2ECB83372
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NL5AEZDXp-2v for <iommu@lists.linux-foundation.org>;
 Wed,  6 Jul 2022 04:02:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B3A7F8328E
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B3A7F8328E
 for <iommu@lists.linux-foundation.org>; Wed,  6 Jul 2022 04:02:58 +0000 (UTC)
X-UUID: 1cbe8a4b11d44a30bebfaf81739fe5fa-20220706
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8, REQID:4d587acf-405b-4833-8cf7-5adf8a04ffd5, OB:20,
 L
 OB:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,AC
 TION:release,TS:45
X-CID-INFO: VERSION:1.1.8, REQID:4d587acf-405b-4833-8cf7-5adf8a04ffd5, OB:20,
 LOB
 :0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACTI
 ON:release,TS:45
X-CID-META: VersionHash:0f94e32, CLOUDID:e0d0a886-57f0-47ca-ba27-fe8c57fbf305,
 C
 OID:caa6a33a596b,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
 RL:0,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: 1cbe8a4b11d44a30bebfaf81739fe5fa-20220706
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
 (envelope-from <tinghan.shen@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 389606059; Wed, 06 Jul 2022 12:02:53 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3; 
 Wed, 6 Jul 2022 12:02:52 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Wed, 6 Jul 2022 12:02:52 +0800
Message-ID: <2a6619e4e93f09dfae32d33aae968adcad0cf482.camel@mediatek.com>
Subject: Re: [PATCH v1 16/16] arm64: dts: mt8195: Add display node for vdosys0
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Yong Wu
 <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon
 <will@kernel.org>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, Chun-Jie Chen <chun-jie.chen@mediatek.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, "Enric
 Balletbo i Serra" <enric.balletbo@collabora.com>, Weiyi Lu
 <weiyi.lu@mediatek.com>
Date: Wed, 6 Jul 2022 12:02:52 +0800
In-Reply-To: <27c8f7b1-c308-89c2-54be-2d6c1a5527b8@linaro.org>
References: <20220704100028.19932-1-tinghan.shen@mediatek.com>
 <20220704100028.19932-17-tinghan.shen@mediatek.com>
 <27c8f7b1-c308-89c2-54be-2d6c1a5527b8@linaro.org>
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-MTK: N
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
From: Tinghan Shen via iommu <iommu@lists.linux-foundation.org>
Reply-To: Tinghan Shen <tinghan.shen@mediatek.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Mon, 2022-07-04 at 14:39 +0200, Krzysztof Kozlowski wrote:
> On 04/07/2022 12:00, Tinghan Shen wrote:
> > From: "Jason-JH.Lin" <jason-jh.lin@mediatek.com>
> > 
> > Add display node for vdosys0 of mt8195.
> > 
> > Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
> > Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> > ---
> >  arch/arm64/boot/dts/mediatek/mt8195.dtsi | 109 +++++++++++++++++++++++
> >  1 file changed, 109 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> > index 724c6ca837b6..faea8ef33e5a 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> > +++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> > @@ -1961,6 +1961,7 @@
> >  		vdosys0: syscon@1c01a000 {
> >  			compatible = "mediatek,mt8195-mmsys", "syscon";
> >  			reg = <0 0x1c01a000 0 0x1000>;
> > +			mboxes = <&gce0 0 CMDQ_THR_PRIO_4>;
> >  			#clock-cells = <1>;
> >  		};
> >  
> > @@ -1976,6 +1977,114 @@
> >  			power-domains = <&spm MT8195_POWER_DOMAIN_VENC_CORE1>;
> >  		};
> >  
> > +		ovl0: ovl@1c000000 {
> > +			compatible = "mediatek,mt8195-disp-ovl",
> > +				     "mediatek,mt8183-disp-ovl";
> > +			reg = <0 0x1c000000 0 0x1000>;
> > +			interrupts = <GIC_SPI 636 IRQ_TYPE_LEVEL_HIGH 0>;
> > +			power-domains = <&spm MT8195_POWER_DOMAIN_VDOSYS0>;
> > +			clocks = <&vdosys0 CLK_VDO0_DISP_OVL0>;
> > +			iommus = <&iommu_vdo M4U_PORT_L0_DISP_OVL0_RDMA0>;
> > +			mediatek,gce-client-reg =
> > +				 <&gce0 SUBSYS_1c00XXXX 0x0000 0x1000>;
> > +		};
> > +
> > +		rdma0: rdma@1c002000 {
> > +			compatible = "mediatek,mt8195-disp-rdma";
> > +			reg = <0 0x1c002000 0 0x1000>;
> > +			interrupts = <GIC_SPI 638 IRQ_TYPE_LEVEL_HIGH 0>;
> > +			power-domains = <&spm MT8195_POWER_DOMAIN_VDOSYS0>;
> > +			clocks = <&vdosys0 CLK_VDO0_DISP_RDMA0>;
> > +			iommus = <&iommu_vdo M4U_PORT_L0_DISP_RDMA0>;
> > +			mediatek,gce-client-reg =
> > +				 <&gce0 SUBSYS_1c00XXXX 0x2000 0x1000>;
> > +		};
> > +
> > +		color0: color@1c003000 {
> > +			compatible = "mediatek,mt8195-disp-color",
> > +				     "mediatek,mt8173-disp-color";
> > +			reg = <0 0x1c003000 0 0x1000>;
> > +			interrupts = <GIC_SPI 639 IRQ_TYPE_LEVEL_HIGH 0>;
> > +			power-domains = <&spm MT8195_POWER_DOMAIN_VDOSYS0>;
> > +			clocks = <&vdosys0 CLK_VDO0_DISP_COLOR0>;
> > +			mediatek,gce-client-reg =
> > +				 <&gce0 SUBSYS_1c00XXXX 0x3000 0x1000>;
> > +		};
> > +
> > +		ccorr0: ccorr@1c004000 {
> > +			compatible = "mediatek,mt8195-disp-ccorr",
> > +				     "mediatek,mt8192-disp-ccorr";
> > +			reg = <0 0x1c004000 0 0x1000>;
> > +			interrupts = <GIC_SPI 640 IRQ_TYPE_LEVEL_HIGH 0>;
> > +			power-domains = <&spm MT8195_POWER_DOMAIN_VDOSYS0>;
> > +			clocks = <&vdosys0 CLK_VDO0_DISP_CCORR0>;
> > +			mediatek,gce-client-reg =
> > +				 <&gce0 SUBSYS_1c00XXXX 0x4000 0x1000>;
> > +		};
> > +
> > +		aal0: aal@1c005000 {
> > +			compatible = "mediatek,mt8195-disp-aal",
> > +				     "mediatek,mt8183-disp-aal";
> > +			reg = <0 0x1c005000 0 0x1000>;
> > +			interrupts = <GIC_SPI 641 IRQ_TYPE_LEVEL_HIGH 0>;
> > +			power-domains = <&spm MT8195_POWER_DOMAIN_VDOSYS0>;
> > +			clocks = <&vdosys0 CLK_VDO0_DISP_AAL0>;
> > +			mediatek,gce-client-reg =
> > +				 <&gce0 SUBSYS_1c00XXXX 0x5000 0x1000>;
> > +		};
> > +
> > +		gamma0: gamma@1c006000 {
> > +			compatible = "mediatek,mt8195-disp-gamma",
> > +				     "mediatek,mt8183-disp-gamma";
> > +			reg = <0 0x1c006000 0 0x1000>;
> > +			interrupts = <GIC_SPI 642 IRQ_TYPE_LEVEL_HIGH 0>;
> > +			power-domains = <&spm MT8195_POWER_DOMAIN_VDOSYS0>;
> > +			clocks = <&vdosys0 CLK_VDO0_DISP_GAMMA0>;
> > +			mediatek,gce-client-reg =
> > +				 <&gce0 SUBSYS_1c00XXXX 0x6000 0x1000>;
> > +		};
> > +
> > +		dither0: dither@1c007000 {
> > +			compatible = "mediatek,mt8195-disp-dither",
> > +				     "mediatek,mt8183-disp-dither";
> > +			reg = <0 0x1c007000 0 0x1000>;
> > +			interrupts = <GIC_SPI 643 IRQ_TYPE_LEVEL_HIGH 0>;
> > +			power-domains = <&spm MT8195_POWER_DOMAIN_VDOSYS0>;
> > +			clocks = <&vdosys0 CLK_VDO0_DISP_DITHER0>;
> > +			mediatek,gce-client-reg =
> > +				 <&gce0 SUBSYS_1c00XXXX 0x7000 0x1000>;
> > +		};
> > +
> > +		dsc0: dsc@1c009000 {
> > +			compatible = "mediatek,mt8195-disp-dsc";
> > +			reg = <0 0x1c009000 0 0x1000>;
> > +			interrupts = <GIC_SPI 645 IRQ_TYPE_LEVEL_HIGH 0>;
> > +			power-domains = <&spm MT8195_POWER_DOMAIN_VDOSYS0>;
> > +			clocks = <&vdosys0 CLK_VDO0_DSC_WRAP0>;
> > +			mediatek,gce-client-reg =
> > +				 <&gce0 SUBSYS_1c00XXXX 0x9000 0x1000>;
> > +		};
> > +
> > +		merge0: merge0@1c014000 {
> 
> Generic node name.
> 
> > +			compatible = "mediatek,mt8195-disp-merge";
> > +			reg = <0 0x1c014000 0 0x1000>;
> > +			interrupts = <GIC_SPI 656 IRQ_TYPE_LEVEL_HIGH 0>;
> > +			power-domains = <&spm MT8195_POWER_DOMAIN_VDOSYS0>;
> > +			clocks = <&vdosys0 CLK_VDO0_VPP_MERGE0>;
> > +			mediatek,gce-client-reg =
> > +				 <&gce0 SUBSYS_1c01XXXX 0x4000 0x1000>;
> > +		};
> > +
> > +		mutex: mutex0@1c016000 {
> 
> Generic node name.
> 
> > +			compatible = "mediatek,mt8195-disp-mutex";
> > +			reg = <0 0x1c016000 0 0x1000>;
> > +			interrupts = <GIC_SPI 658 IRQ_TYPE_LEVEL_HIGH 0>;
> > +			power-domains = <&spm MT8195_POWER_DOMAIN_VDOSYS0>;
> > +			clocks = <&vdosys0 CLK_VDO0_DISP_MUTEX0>;
> > +			mediatek,gce-events =
> > +				 <CMDQ_EVENT_VDO0_DISP_STREAM_DONE_0>;
> > +		};
> > +
> >  		larb0: larb@1c018000 {
> >  			compatible = "mediatek,mt8195-smi-larb";
> >  			reg = <0 0x1c018000 0 0x1000>;
> 
> 
> Best regards,
> Krzysztof

Ok, I'll update in the next version.

Thanks,
TingHan

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
