Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFD36C43334
	for <iommu@archiver.kernel.org>; Wed,  6 Jul 2022 04:01:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 620C840A49;
	Wed,  6 Jul 2022 04:01:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 620C840A49
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id J_5QoFPBaTr5; Wed,  6 Jul 2022 04:01:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1A2CA400FE;
	Wed,  6 Jul 2022 04:01:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1A2CA400FE
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E98D4C0077;
	Wed,  6 Jul 2022 04:01:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 19FB1C0070
 for <iommu@lists.linux-foundation.org>; Wed,  6 Jul 2022 04:01:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DB8A5833A3
 for <iommu@lists.linux-foundation.org>; Wed,  6 Jul 2022 04:01:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DB8A5833A3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SUbTEh8Ari2z for <iommu@lists.linux-foundation.org>;
 Wed,  6 Jul 2022 04:01:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E2D9383180
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E2D9383180
 for <iommu@lists.linux-foundation.org>; Wed,  6 Jul 2022 04:01:17 +0000 (UTC)
X-UUID: 1b8d86509bc8459b9cc41e09b7aef551-20220706
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8, REQID:120e298e-508e-4e44-b922-2e9625841e0f, OB:0,
 LO
 B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
 ON:release,TS:0
X-CID-META: VersionHash:0f94e32, CLOUDID:a3218663-0b3f-4b2c-b3a6-ed5c044366a0,
 C
 OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
 ,QS:nil,BEC:nil,COL:0
X-UUID: 1b8d86509bc8459b9cc41e09b7aef551-20220706
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by
 mailgw02.mediatek.com (envelope-from <tinghan.shen@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 455434276; Wed, 06 Jul 2022 12:01:09 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 6 Jul 2022 12:01:08 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Wed, 6 Jul 2022 12:01:08 +0800
Message-ID: <1fa0c99d7f22d32e668a5a14501e305b588317ec.camel@mediatek.com>
Subject: Re: [PATCH v1 16/16] arm64: dts: mt8195: Add display node for vdosys0
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 "Yong Wu" <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon
 <will@kernel.org>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, Chun-Jie Chen <chun-jie.chen@mediatek.com>, "Weiyi
 Lu" <weiyi.lu@mediatek.com>
Date: Wed, 6 Jul 2022 12:01:08 +0800
In-Reply-To: <84ce9b03-9edd-9ef1-aec1-127b34c23021@collabora.com>
References: <20220704100028.19932-1-tinghan.shen@mediatek.com>
 <20220704100028.19932-17-tinghan.shen@mediatek.com>
 <84ce9b03-9edd-9ef1-aec1-127b34c23021@collabora.com>
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

On Mon, 2022-07-04 at 12:44 +0200, AngeloGioacchino Del Regno wrote:
> Il 04/07/22 12:00, Tinghan Shen ha scritto:
> > From: "Jason-JH.Lin" <jason-jh.lin@mediatek.com>
> > 
> > Add display node for vdosys0 of mt8195.
> > 
> > Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
> > Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> > ---
> >   arch/arm64/boot/dts/mediatek/mt8195.dtsi | 109 +++++++++++++++++++++++
> >   1 file changed, 109 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> > index 724c6ca837b6..faea8ef33e5a 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> > +++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> > @@ -1961,6 +1961,7 @@
> >   		vdosys0: syscon@1c01a000 {
> >   			compatible = "mediatek,mt8195-mmsys", "syscon";
> >   			reg = <0 0x1c01a000 0 0x1000>;
> > +			mboxes = <&gce0 0 CMDQ_THR_PRIO_4>;
> >   			#clock-cells = <1>;
> >   		};
> >   
> > @@ -1976,6 +1977,114 @@
> >   			power-domains = <&spm MT8195_POWER_DOMAIN_VENC_CORE1>;
> >   		};
> >   
> > +		ovl0: ovl@1c000000 {
> > +			compatible = "mediatek,mt8195-disp-ovl",
> > +				     "mediatek,mt8183-disp-ovl";
> 
> This fits in one line, please fix, here and all of the other instances of that.
> 
> > +			reg = <0 0x1c000000 0 0x1000>;
> > +			interrupts = <GIC_SPI 636 IRQ_TYPE_LEVEL_HIGH 0>;
> > +			power-domains = <&spm MT8195_POWER_DOMAIN_VDOSYS0>;
> > +			clocks = <&vdosys0 CLK_VDO0_DISP_OVL0>;
> > +			iommus = <&iommu_vdo M4U_PORT_L0_DISP_OVL0_RDMA0>;
> > +			mediatek,gce-client-reg =
> > +				 <&gce0 SUBSYS_1c00XXXX 0x0000 0x1000>;
> 
> Same for gce-client-reg.
> 
> Regards,
> Angelo

Ok, I'll update in next version.

Thanks,
TingHan

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
