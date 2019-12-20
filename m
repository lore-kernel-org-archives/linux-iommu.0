Return-Path: <SRS0=Sm7F=2K=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C5A2C43603
	for <iommu@archiver.kernel.org>; Fri, 20 Dec 2019 11:07:52 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B12824679
	for <iommu@archiver.kernel.org>; Fri, 20 Dec 2019 11:07:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="OhGfJ+qN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B12824679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 1D431250E3;
	Fri, 20 Dec 2019 11:07:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mfO69QwqtHaU; Fri, 20 Dec 2019 11:07:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 75ED220392;
	Fri, 20 Dec 2019 11:07:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 653CAC18DC;
	Fri, 20 Dec 2019 11:07:50 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AA4ADC077D
 for <iommu@lists.linux-foundation.org>; Fri, 20 Dec 2019 11:07:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 93F25862D2
 for <iommu@lists.linux-foundation.org>; Fri, 20 Dec 2019 11:07:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Kh1ltdP8NFtT for <iommu@lists.linux-foundation.org>;
 Fri, 20 Dec 2019 11:07:47 +0000 (UTC)
X-Greylist: delayed 00:05:01 by SQLgrey-1.7.6
Received: from mailgw01.mediatek.com (unknown [210.61.82.183])
 by whitealder.osuosl.org (Postfix) with ESMTP id 64C4886274
 for <iommu@lists.linux-foundation.org>; Fri, 20 Dec 2019 11:07:46 +0000 (UTC)
X-UUID: 5dc234f7352b4bf1803446a9b5cb0aaa-20191220
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=Aatwr+ttc7zxtmKQFYI1z8gYIV9l40lZAUrGhcyY+f0=; 
 b=OhGfJ+qNuhXnJbUjN/PlCIgiOV2Je8pomSjwscTL92qSdr9M8Ga/jJTbopKEx8aYzA0TBLH5Q9EuLvx552pImTk/wLiTCecP8ZpIssHBWFhTBni11G6DIQ8gpWzfcdwvqRpNNQEspovlHMJc/ygkhC3exL9DPcCs8utJAmGn/Fo=;
X-UUID: 5dc234f7352b4bf1803446a9b5cb0aaa-20191220
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
 (envelope-from <chao.hao@mediatek.com>)
 (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
 with ESMTP id 1003720282; Fri, 20 Dec 2019 19:02:40 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 20 Dec 2019 19:02:38 +0800
Received: from [10.15.20.246] (10.15.20.246) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 20 Dec 2019 19:01:43 +0800
Message-ID: <1576839713.20031.2.camel@mbjsdccf07>
Subject: Re: [RESEND,PATCH 01/13] dt-bindings: mediatek: Add bindings for
 MT6779
From: chao hao <Chao.Hao@mediatek.com>
To: Yong Wu <yong.wu@mediatek.com>
Date: Fri, 20 Dec 2019 19:01:53 +0800
In-Reply-To: <1576497901.28043.71.camel@mhfsdcap03>
References: <20191104115238.2394-1-chao.hao@mediatek.com>
 <20191104115238.2394-2-chao.hao@mediatek.com>
 <1576497901.28043.71.camel@mhfsdcap03>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: CED2145DA5A5DB969C5A979274DE6004671E4E920E54B13366D6759B41D5A90B2000:8
X-MTK: N
Cc: Anan Sun <anan.sun@mediatek.com>, devicetree@vger.kernel.org,
 Cui Zhang <cui.zhang@mediatek.com>, Jun Yan <jun.yan@mediatek.com>,
 wsd_upstream@mediatek.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 linux-mediatek@lists.infradead.org, Miles Chen <miles.chen@mediatek.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 linux-arm-kernel@lists.infradead.org,
 Guangming Cao <guangming.cao@mediatek.com>
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

On Mon, 2019-12-16 at 20:05 +0800, Yong Wu wrote:
> On Mon, 2019-11-04 at 19:52 +0800, Chao Hao wrote:
> > This patch adds description for MT6779 IOMMU.
> > 
> > MT6779 has two iommus, they are MM_IOMMU and APU_IOMMU which
> > use ARM Short-Descriptor translation format.
> > 
> > The MT6779 IOMMU hardware diagram is as below, it is only a brief
> > diagram about iommu, it don't focus on the part of smi_larb, so
> > I don't describe the smi_larb detailedly.
> > 
> > 			     EMI
> > 			      |
> > 	   --------------------------------------
> > 	   |					|
> >         MM_IOMMU                            APU_IOMMU
> > 	   |					|
> >        SMI_COMMOM-----------		     APU_BUS
> >           |		   |			|
> >     SMI_LARB(0~11)  SMI_LARB12(FAKE)	    SMI_LARB13(FAKE)
> > 	  |		   |			|
> > 	  |		   |		   --------------
> > 	  |		   |		   |	 |	|
> >    Multimedia engine	  CCU		  VPU   MDLA   EMDA
> > 
> > All the connections are hardware fixed, software can not adjust it.
> > 
> > From the diagram above, MM_IOMMU provides mapping for multimedia engine,
> > but CCU is connected with smi_common directly, we can take them as larb12.
> > APU_IOMMU provides mapping for APU engine, we can take them larb13.
> > Larb12 and Larb13 are fake larbs.
> > 
> > Signed-off-by: Chao Hao <chao.hao@mediatek.com>
> > ---
> >  .../bindings/iommu/mediatek,iommu.txt         |   2 +
> >  include/dt-bindings/memory/mt6779-larb-port.h | 217 ++++++++++++++++++
> >  2 files changed, 219 insertions(+)
> >  create mode 100644 include/dt-bindings/memory/mt6779-larb-port.h
> > 
> > diff --git a/Documentation/devicetree/bindings/iommu/mediatek,iommu.txt b/Documentation/devicetree/bindings/iommu/mediatek,iommu.txt
> > index ce59a505f5a4..c1ccd8582eb2 100644
> > --- a/Documentation/devicetree/bindings/iommu/mediatek,iommu.txt
> > +++ b/Documentation/devicetree/bindings/iommu/mediatek,iommu.txt
> > @@ -58,6 +58,7 @@ Required properties:
> >  - compatible : must be one of the following string:
> >  	"mediatek,mt2701-m4u" for mt2701 which uses generation one m4u HW.
> >  	"mediatek,mt2712-m4u" for mt2712 which uses generation two m4u HW.
> > +	"mediatek,mt6779-m4u" for mt6779 which uses generation two m4u HW.
> >  	"mediatek,mt7623-m4u", "mediatek,mt2701-m4u" for mt7623 which uses
> >  						     generation one m4u HW.
> >  	"mediatek,mt8173-m4u" for mt8173 which uses generation two m4u HW.
> > @@ -78,6 +79,7 @@ Required properties:
> >  	Specifies the mtk_m4u_id as defined in
> >  	dt-binding/memory/mt2701-larb-port.h for mt2701, mt7623
> >  	dt-binding/memory/mt2712-larb-port.h for mt2712,
> > +	dt-binding/memory/mt6779-larb-port.h for mt6779,
> >  	dt-binding/memory/mt8173-larb-port.h for mt8173, and
> >  	dt-binding/memory/mt8183-larb-port.h for mt8183.
> >  
> > diff --git a/include/dt-bindings/memory/mt6779-larb-port.h b/include/dt-bindings/memory/mt6779-larb-port.h
> > new file mode 100644
> > index 000000000000..8b7f2d2446ea
> > --- /dev/null
> > +++ b/include/dt-bindings/memory/mt6779-larb-port.h
> > @@ -0,0 +1,217 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright (c) 2019 MediaTek Inc.
> > + * Author: Chao Hao <chao.hao@mediatek.com>
> > + */
> > +
> > +#ifndef _DTS_IOMMU_PORT_MT6779_H_
> > +#define _DTS_IOMMU_PORT_MT6779_H_
> > +
> > +#define MTK_M4U_ID(larb, port)		 (((larb) << 5) | (port))
> > +
> > +#define M4U_LARB0_ID			 0
> > +#define M4U_LARB1_ID			 1
> > +#define M4U_LARB2_ID			 2
> > +#define M4U_LARB3_ID			 3
> > +#define M4U_LARB4_ID			 4
> > +#define M4U_LARB5_ID			 5
> > +#define M4U_LARB6_ID			 6
> > +#define M4U_LARB7_ID			 7
> > +#define M4U_LARB8_ID			 8
> > +#define M4U_LARB9_ID			 9
> > +#define M4U_LARB10_ID			 10
> > +#define M4U_LARB11_ID			 11
> > +#define M4U_LARB12_ID			 12
> > +#define M4U_LARB13_ID			 13
> > +
> > +/* larb0 */
> > +#define M4U_PORT_DISP_POSTMASK0		 MTK_M4U_ID(M4U_LARB0_ID, 0)
> > +#define M4U_PORT_DISP_OVL0_HDR		 MTK_M4U_ID(M4U_LARB0_ID, 1)
> > +#define M4U_PORT_DISP_OVL1_HDR		 MTK_M4U_ID(M4U_LARB0_ID, 2)
> > +#define M4U_PORT_DISP_OVL0		 MTK_M4U_ID(M4U_LARB0_ID, 3)
> > +#define M4U_PORT_DISP_OVL1		 MTK_M4U_ID(M4U_LARB0_ID, 4)
> > +#define M4U_PORT_DISP_PVRIC0		 MTK_M4U_ID(M4U_LARB0_ID, 5)
> > +#define M4U_PORT_DISP_RDMA0		 MTK_M4U_ID(M4U_LARB0_ID, 6)
> > +#define M4U_PORT_DISP_WDMA0		 MTK_M4U_ID(M4U_LARB0_ID, 7)
> > +#define M4U_PORT_DISP_FAKE0		 MTK_M4U_ID(M4U_LARB0_ID, 8)
> > +
> > +/* larb1 */
> > +#define M4U_PORT_DISP_OVL0_2L_HDR	 MTK_M4U_ID(M4U_LARB1_ID, 0)
> > +#define M4U_PORT_DISP_OVL1_2L_HDR	 MTK_M4U_ID(M4U_LARB1_ID, 1)
> > +#define M4U_PORT_DISP_OVL0_2L		 MTK_M4U_ID(M4U_LARB1_ID, 2)
> > +#define M4U_PORT_DISP_OVL1_2L		 MTK_M4U_ID(M4U_LARB1_ID, 3)
> > +#define M4U_PORT_DISP_RDMA1		 MTK_M4U_ID(M4U_LARB1_ID, 4)
> > +#define M4U_PORT_MDP_PVRIC0		 MTK_M4U_ID(M4U_LARB1_ID, 5)
> > +#define M4U_PORT_MDP_PVRIC1		 MTK_M4U_ID(M4U_LARB1_ID, 6)
> > +#define M4U_PORT_MDP_RDMA0		 MTK_M4U_ID(M4U_LARB1_ID, 7)
> > +#define M4U_PORT_MDP_RDMA1		 MTK_M4U_ID(M4U_LARB1_ID, 8)
> > +#define M4U_PORT_MDP_WROT0_R		 MTK_M4U_ID(M4U_LARB1_ID, 9)
> > +#define M4U_PORT_MDP_WROT0_W		 MTK_M4U_ID(M4U_LARB1_ID, 10)
> > +#define M4U_PORT_MDP_WROT1_R		 MTK_M4U_ID(M4U_LARB1_ID, 11)
> > +#define M4U_PORT_MDP_WROT1_W		 MTK_M4U_ID(M4U_LARB1_ID, 12)
> > +#define M4U_PORT_DISP_FAKE1		 MTK_M4U_ID(M4U_LARB1_ID, 13)
> > +
> > +/* larb2-VDEC */
> > +#define M4U_PORT_HW_VDEC_MC_EXT          MTK_M4U_ID(M4U_LARB2_ID, 0)
> > +#define M4U_PORT_HW_VDEC_UFO_EXT         MTK_M4U_ID(M4U_LARB2_ID, 1)
> > +#define M4U_PORT_HW_VDEC_PP_EXT          MTK_M4U_ID(M4U_LARB2_ID, 2)
> > +#define M4U_PORT_HW_VDEC_PRED_RD_EXT     MTK_M4U_ID(M4U_LARB2_ID, 3)
> > +#define M4U_PORT_HW_VDEC_PRED_WR_EXT     MTK_M4U_ID(M4U_LARB2_ID, 4)
> > +#define M4U_PORT_HW_VDEC_PPWRAP_EXT      MTK_M4U_ID(M4U_LARB2_ID, 5)
> > +#define M4U_PORT_HW_VDEC_TILE_EXT        MTK_M4U_ID(M4U_LARB2_ID, 6)
> > +#define M4U_PORT_HW_VDEC_VLD_EXT         MTK_M4U_ID(M4U_LARB2_ID, 7)
> > +#define M4U_PORT_HW_VDEC_VLD2_EXT        MTK_M4U_ID(M4U_LARB2_ID, 8)
> > +#define M4U_PORT_HW_VDEC_AVC_MV_EXT      MTK_M4U_ID(M4U_LARB2_ID, 9)
> > +#define M4U_PORT_HW_VDEC_UFO_ENC_EXT     MTK_M4U_ID(M4U_LARB2_ID, 10)
> > +#define M4U_PORT_HW_VDEC_RG_CTRL_DMA_EXT MTK_M4U_ID(M4U_LARB2_ID, 11)
> > +
> > +/*larb3-VENC*/
> 
> Normally add space before and after the word. Like: /* larb3-VENC */
> 
> below are the same.
> 
> > +#define M4U_PORT_VENC_RCPU		 MTK_M4U_ID(M4U_LARB3_ID, 0)
> > +#define M4U_PORT_VENC_REC		 MTK_M4U_ID(M4U_LARB3_ID, 1)
> > +#define M4U_PORT_VENC_BSDMA		 MTK_M4U_ID(M4U_LARB3_ID, 2)
> > +#define M4U_PORT_VENC_SV_COMV		 MTK_M4U_ID(M4U_LARB3_ID, 3)
> > +#define M4U_PORT_VENC_RD_COMV		 MTK_M4U_ID(M4U_LARB3_ID, 4)
> > +#define M4U_PORT_VENC_NBM_RDMA		 MTK_M4U_ID(M4U_LARB3_ID, 5)
> > +#define M4U_PORT_VENC_NBM_RDMA_LITE	 MTK_M4U_ID(M4U_LARB3_ID, 6)
> > +#define M4U_PORT_JPGENC_Y_RDMA		 MTK_M4U_ID(M4U_LARB3_ID, 7)
> > +#define M4U_PORT_JPGENC_C_RDMA		 MTK_M4U_ID(M4U_LARB3_ID, 8)
> > +#define M4U_PORT_JPGENC_Q_TABLE		 MTK_M4U_ID(M4U_LARB3_ID, 9)
> > +#define M4U_PORT_JPGENC_BSDMA		 MTK_M4U_ID(M4U_LARB3_ID, 10)
> > +#define M4U_PORT_JPGDEC_WDMA		 MTK_M4U_ID(M4U_LARB3_ID, 11)
> > +#define M4U_PORT_JPGDEC_BSDMA		 MTK_M4U_ID(M4U_LARB3_ID, 12)
> > +#define M4U_PORT_VENC_NBM_WDMA		 MTK_M4U_ID(M4U_LARB3_ID, 13)
> > +#define M4U_PORT_VENC_NBM_WDMA_LITE	 MTK_M4U_ID(M4U_LARB3_ID, 14)
> > +#define M4U_PORT_VENC_CUR_LUMA		 MTK_M4U_ID(M4U_LARB3_ID, 15)
> > +#define M4U_PORT_VENC_CUR_CHROMA	 MTK_M4U_ID(M4U_LARB3_ID, 16)
> > +#define M4U_PORT_VENC_REF_LUMA		 MTK_M4U_ID(M4U_LARB3_ID, 17)
> > +#define M4U_PORT_VENC_REF_CHROMA	 MTK_M4U_ID(M4U_LARB3_ID, 18)
> > +
> > +/*larb4-dummy*/
> > +
> > +/*larb5-IMG*/
> 
> [snip]
> 
> > +
> > +#define M4U_PORT_VPU			 MTK_M4U_ID(M4U_LARB13_ID, 0)
> > +#define M4U_PORT_MDLA			 MTK_M4U_ID(M4U_LARB13_ID, 1)
> > +#define M4U_PORT_EDMA			 MTK_M4U_ID(M4U_LARB13_ID, 2)
> > +
> > +#define M4U_PORT_UNKNOWN		 (M4U_PORT_EDMA + 1)
> 
> When do you need this UNKNOWN one? The other SoC doesn't have it. Please
> remove if it is unnecessary.
> 
ok, I will fix it in next version, thanks

> > +
> > +#endif
> 
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
