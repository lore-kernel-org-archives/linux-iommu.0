Return-Path: <SRS0=ylBP=CQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60927C10DAA
	for <iommu@archiver.kernel.org>; Mon,  7 Sep 2020 03:45:14 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCC282176B
	for <iommu@archiver.kernel.org>; Mon,  7 Sep 2020 03:45:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Ei/MDmmY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCC282176B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7DF8685549;
	Mon,  7 Sep 2020 03:45:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uZM-3IQVadJA; Mon,  7 Sep 2020 03:45:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id EE9FE85551;
	Mon,  7 Sep 2020 03:45:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E86DDC0052;
	Mon,  7 Sep 2020 03:45:12 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 638BEC0051
 for <iommu@lists.linux-foundation.org>; Mon,  7 Sep 2020 03:45:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 5285787044
 for <iommu@lists.linux-foundation.org>; Mon,  7 Sep 2020 03:45:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QXQJZyj5jcoh for <iommu@lists.linux-foundation.org>;
 Mon,  7 Sep 2020 03:45:10 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mailgw02.mediatek.com (unknown [1.203.163.81])
 by hemlock.osuosl.org (Postfix) with ESMTP id 4D8598703E
 for <iommu@lists.linux-foundation.org>; Mon,  7 Sep 2020 03:45:10 +0000 (UTC)
X-UUID: 4749b9027edb4ec4a3dcb522a6b9a3ce-20200907
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=+kQMFZtTwzN5g3ipj6RMOu9cz09zTtXs8Jvc7SvBRYE=; 
 b=Ei/MDmmYIlxQ6eMkoRim98t3V6iyykR81POfDmFima10X4k+i9Ln0zRDpt44gt5vh67c5M1qpydfs61pAa3aNtGHWT0HaFBHCTBQWKbZ2WrhLERE9jZr9TVYmRFPFdhKoV9QAto56ns80AmZmvtu8ib0zxkP3verGSFCiKZ4WAk=;
X-UUID: 4749b9027edb4ec4a3dcb522a6b9a3ce-20200907
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 1702638041; Mon, 07 Sep 2020 11:45:07 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS32N1.mediatek.inc
 (172.27.4.71) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Mon, 7 Sep 2020 11:45:05 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 7 Sep 2020 11:45:06 +0800
Message-ID: <1599450198.27773.12.camel@mhfsdcap03>
Subject: Re: [PATCH v3 1/3] dt-bindings: iommu: Add binding for MediaTek
 MT8167 IOMMU
From: Yong Wu <yong.wu@mediatek.com>
To: Fabien Parent <fparent@baylibre.com>
Date: Mon, 7 Sep 2020 11:43:18 +0800
In-Reply-To: <20200906151928.881209-1-fparent@baylibre.com>
References: <20200906151928.881209-1-fparent@baylibre.com>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 870868C0E752BB5D53643B5CAD2F078C8B2CECA589AC935CFAB57F2A2BDFD3EB2000:8
X-MTK: N
Cc: devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 robh+dt@kernel.org, linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com,
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

On Sun, 2020-09-06 at 17:19 +0200, Fabien Parent wrote:
> This commit adds IOMMU binding documentation and larb port definitions
> for the MT8167 SoC.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
> 
> V3: Added mt8167-larb-port.h file for iommu port definitions
> V2: no change
> 
> ---
>  .../bindings/iommu/mediatek,iommu.txt         |  1 +
>  include/dt-bindings/memory/mt8167-larb-port.h | 49 +++++++++++++++++++
>  2 files changed, 50 insertions(+)
>  create mode 100644 include/dt-bindings/memory/mt8167-larb-port.h
> 
> diff --git a/Documentation/devicetree/bindings/iommu/mediatek,iommu.txt b/Documentation/devicetree/bindings/iommu/mediatek,iommu.txt
> index c1ccd8582eb2..f7a348f48e0d 100644
> --- a/Documentation/devicetree/bindings/iommu/mediatek,iommu.txt
> +++ b/Documentation/devicetree/bindings/iommu/mediatek,iommu.txt
> @@ -61,6 +61,7 @@ Required properties:
>  	"mediatek,mt6779-m4u" for mt6779 which uses generation two m4u HW.
>  	"mediatek,mt7623-m4u", "mediatek,mt2701-m4u" for mt7623 which uses
>  						     generation one m4u HW.
> +	"mediatek,mt8167-m4u" for mt8167 which uses generation two m4u HW.
>  	"mediatek,mt8173-m4u" for mt8173 which uses generation two m4u HW.
>  	"mediatek,mt8183-m4u" for mt8183 which uses generation two m4u HW.
>  - reg : m4u register base and size.

Please also add this line in the iommu-cells property:

     dt-bindings/memory/mt8167-larb-port.h for mt8167.

> diff --git a/include/dt-bindings/memory/mt8167-larb-port.h b/include/dt-bindings/memory/mt8167-larb-port.h
> new file mode 100644
> index 000000000000..4dd44d1037a7
> --- /dev/null
> +++ b/include/dt-bindings/memory/mt8167-larb-port.h
> @@ -0,0 +1,49 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2020 BayLibre, SAS
> + * Author: Fabien Parent <fparent@baylibre.com>

If I'm not wrong, the first version was created by:
 Honghui Zhang <honghui.zhang@mediatek.com>

the original author should be kept.

> + */
> +#ifndef __DTS_IOMMU_PORT_MT8167_H
> +#define __DTS_IOMMU_PORT_MT8167_H
> +
> +#define MTK_M4U_ID(larb, port)		(((larb) << 5) | (port))
> +
> +#define M4U_LARB0_ID			0
> +#define M4U_LARB1_ID			1
> +#define M4U_LARB2_ID			2
> +
> +/* larb0 */
> +#define M4U_PORT_DISP_OVL0		MTK_M4U_ID(M4U_LARB0_ID, 0)
> +#define M4U_PORT_DISP_RDMA0		MTK_M4U_ID(M4U_LARB0_ID, 1)
> +#define M4U_PORT_DISP_WDMA0		MTK_M4U_ID(M4U_LARB0_ID, 2)
> +#define M4U_PORT_DISP_RDMA1		MTK_M4U_ID(M4U_LARB0_ID, 3)
> +#define M4U_PORT_MDP_RDMA		MTK_M4U_ID(M4U_LARB0_ID, 4)
> +#define M4U_PORT_MDP_WDMA		MTK_M4U_ID(M4U_LARB0_ID, 5)
> +#define M4U_PORT_MDP_WROT		MTK_M4U_ID(M4U_LARB0_ID, 6)
> +#define M4U_PORT_DISP_FAKE		MTK_M4U_ID(M4U_LARB0_ID, 7)
> +
> +/* IMG larb1*/
> +#define M4U_PORT_CAM_IMGO		MTK_M4U_ID(M4U_LARB1_ID, 0)
> +#define M4U_PORT_CAM_IMG2O		MTK_M4U_ID(M4U_LARB1_ID, 1)
> +#define M4U_PORT_CAM_LSCI		MTK_M4U_ID(M4U_LARB1_ID, 2)
> +#define M4U_PORT_CAM_ESFKO		MTK_M4U_ID(M4U_LARB1_ID, 3)
> +#define M4U_PORT_CAM_AAO		MTK_M4U_ID(M4U_LARB1_ID, 4)
> +#define M4U_PORT_VENC_REC		MTK_M4U_ID(M4U_LARB1_ID, 5)
> +#define M4U_PORT_VENC_BSDMA		MTK_M4U_ID(M4U_LARB1_ID, 6)
> +#define M4U_PORT_VENC_RD_COMV		MTK_M4U_ID(M4U_LARB1_ID, 7)
> +#define M4U_PORT_CAM_IMGI		MTK_M4U_ID(M4U_LARB1_ID, 8)
> +#define M4U_PORT_VENC_CUR_LUMA		MTK_M4U_ID(M4U_LARB1_ID, 9)
> +#define M4U_PORT_VENC_CUR_CHROMA	MTK_M4U_ID(M4U_LARB1_ID, 10)
> +#define M4U_PORT_VENC_REF_LUMA		MTK_M4U_ID(M4U_LARB1_ID, 11)
> +#define M4U_PORT_VENC_REF_CHROMA	MTK_M4U_ID(M4U_LARB1_ID, 12)
> +
> +/* VDEC larb2*/
> +#define M4U_PORT_HW_VDEC_MC_EXT		MTK_M4U_ID(M4U_LARB2_ID, 0)
> +#define M4U_PORT_HW_VDEC_PP_EXT		MTK_M4U_ID(M4U_LARB2_ID, 1)
> +#define M4U_PORT_HW_VDEC_VLD_EXT	MTK_M4U_ID(M4U_LARB2_ID, 2)
> +#define M4U_PORT_HW_VDEC_AVC_MV_EXT	MTK_M4U_ID(M4U_LARB2_ID, 3)
> +#define M4U_PORT_HW_VDEC_PRED_RD_EXT	MTK_M4U_ID(M4U_LARB2_ID, 4)
> +#define M4U_PORT_HW_VDEC_PRED_WR_EXT	MTK_M4U_ID(M4U_LARB2_ID, 5)
> +#define M4U_PORT_HW_VDEC_PPWRAP_EXT	MTK_M4U_ID(M4U_LARB2_ID, 6)
> +
> +#endif

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
