Return-Path: <SRS0=5yIV=F3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F19D5C433E0
	for <iommu@archiver.kernel.org>; Wed, 23 Dec 2020 08:26:16 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C9DD22482
	for <iommu@archiver.kernel.org>; Wed, 23 Dec 2020 08:26:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C9DD22482
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 1E2A0867CC;
	Wed, 23 Dec 2020 08:26:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 501v4Su4hZMc; Wed, 23 Dec 2020 08:26:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id DE77F86861;
	Wed, 23 Dec 2020 08:26:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C31DAC1787;
	Wed, 23 Dec 2020 08:26:13 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 68276C0893
 for <iommu@lists.linux-foundation.org>; Wed, 23 Dec 2020 08:26:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 55D8C85C00
 for <iommu@lists.linux-foundation.org>; Wed, 23 Dec 2020 08:26:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8CfoXFCqP6i9 for <iommu@lists.linux-foundation.org>;
 Wed, 23 Dec 2020 08:26:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com
 [209.85.215.174])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 7AEBF859D1
 for <iommu@lists.linux-foundation.org>; Wed, 23 Dec 2020 08:26:09 +0000 (UTC)
Received: by mail-pg1-f174.google.com with SMTP id p18so10153796pgm.11
 for <iommu@lists.linux-foundation.org>; Wed, 23 Dec 2020 00:26:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=9uNIAlyQ4W4gB86gMH5FW+d8wf2A0HQ1RGfA/LhuBqc=;
 b=nLHPSHWJKxeGDBLqGpIjR8vgrnquaWen6OUQOB0kq1mbDB4lH4aS7k7YsXtouyAuTZ
 3igOcx2FS+1VnzDFIGzQtTqEAKbLHVWy94bocuj/ZVAry8eiGa6QEgw5dR0+y+JBU2NQ
 vGwVk7vAcvj2j73U3AGuLC1kFkcP+8UUPELWE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=9uNIAlyQ4W4gB86gMH5FW+d8wf2A0HQ1RGfA/LhuBqc=;
 b=cVt1SafgS5iIK9QQfQ/WbSwr7Btcc/QKSSiwuq+X36kL+AWmSRyTIbJkrQdg4SPDEh
 LD8O9/vJ5lD6zGI9ZajpB2BM9cIXQ/8qdj4ZXTTrZXQiDiEWH/vlrQ3iha/iGDMKgpke
 rkijb5mnb58zyQJVaJ7rAafvlyIBtFsgkEflLWHAkrnIWbNfy9NJxkLkr859wuQunmK3
 q0DLhKrobtaUVU4ZlW6NLPQzO7fSTmTx3oigwJ2d+Ioi2oRG1U7WvtqgIkqdHJSYTR6S
 ZRHVB3tU49gY7M644WETsWH+cpT6crnVEWvJ2e8nw6Z1bfhYkOWL62V4h/2gBu/eRt8l
 DQkA==
X-Gm-Message-State: AOAM533Z3Vrumqy75tmu15n9RHAB6GyqU+2KXYmNuYk5mCW7tONZ3mCK
 6/D0WwcYIGLw8v/yHvpYKYtsOgPqtwj0fA==
X-Google-Smtp-Source: ABdhPJy8h4wp9MPYeG3a1fhuMhR/oPn+R3rT8RvgfDkh5ST720xkiHZOKPNxJQnJQs/mhHdmOcge7Q==
X-Received: by 2002:a17:902:bd09:b029:dc:3399:219c with SMTP id
 p9-20020a170902bd09b02900dc3399219cmr2199380pls.55.1608711525241; 
 Wed, 23 Dec 2020 00:18:45 -0800 (PST)
Received: from chromium.org ([2401:fa00:8f:2:a28c:fdff:fef0:43bf])
 by smtp.gmail.com with ESMTPSA id x125sm9890372pgb.35.2020.12.23.00.18.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Dec 2020 00:18:44 -0800 (PST)
Date: Wed, 23 Dec 2020 17:18:38 +0900
From: Tomasz Figa <tfiga@chromium.org>
To: Yong Wu <yong.wu@mediatek.com>
Subject: Re: [PATCH v5 06/27] dt-bindings: mediatek: Add binding for mt8192
 IOMMU
Message-ID: <X+L9XpkoII7tw/tX@chromium.org>
References: <20201209080102.26626-1-yong.wu@mediatek.com>
 <20201209080102.26626-7-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201209080102.26626-7-yong.wu@mediatek.com>
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
 Nicolas Boichat <drinkcat@chromium.org>, srv_heupstream@mediatek.com,
 Tomasz Figa <tfiga@google.com>, Will Deacon <will@kernel.org>,
 linux-kernel@vger.kernel.org, Evan Green <evgreen@chromium.org>,
 chao.hao@mediatek.com, iommu@lists.linux-foundation.org,
 Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, anan.sun@mediatek.com,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
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

On Wed, Dec 09, 2020 at 04:00:41PM +0800, Yong Wu wrote:
> This patch adds decriptions for mt8192 IOMMU and SMI.
> 
> mt8192 also is MTK IOMMU gen2 which uses ARM Short-Descriptor translation
> table format. The M4U-SMI HW diagram is as below:
> 
>                           EMI
>                            |
>                           M4U
>                            |
>                       ------------
>                        SMI Common
>                       ------------
>                            |
>   +-------+------+------+----------------------+-------+
>   |       |      |      |       ......         |       |
>   |       |      |      |                      |       |
> larb0   larb1  larb2  larb4     ......      larb19   larb20
> disp0   disp1   mdp    vdec                   IPE      IPE
> 
> All the connections are HW fixed, SW can NOT adjust it.
> 
> mt8192 M4U support 0~16GB iova range. we preassign different engines
> into different iova ranges:
> 
> domain-id  module     iova-range                  larbs
>    0       disp        0 ~ 4G                      larb0/1
>    1       vcodec      4G ~ 8G                     larb4/5/7
>    2       cam/mdp     8G ~ 12G             larb2/9/11/13/14/16/17/18/19/20

Why do we preassign these addresses in DT? Shouldn't it be a user's or
integrator's decision to split the 16 GB address range into sub-ranges
and define which larbs those sub-ranges are shared with?

Best regards,
Tomasz

>    3       CCU0    0x4000_0000 ~ 0x43ff_ffff     larb13: port 9/10
>    4       CCU1    0x4400_0000 ~ 0x47ff_ffff     larb14: port 4/5
> 
> The iova range for CCU0/1(camera control unit) is HW requirement.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  .../bindings/iommu/mediatek,iommu.yaml        |  18 +-
>  include/dt-bindings/memory/mt8192-larb-port.h | 240 ++++++++++++++++++
>  2 files changed, 257 insertions(+), 1 deletion(-)
>  create mode 100644 include/dt-bindings/memory/mt8192-larb-port.h
> 
> diff --git a/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
> index ba6626347381..0f26fe14c8e2 100644
> --- a/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
> +++ b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
> @@ -76,6 +76,7 @@ properties:
>            - mediatek,mt8167-m4u  # generation two
>            - mediatek,mt8173-m4u  # generation two
>            - mediatek,mt8183-m4u  # generation two
> +          - mediatek,mt8192-m4u  # generation two
>  
>        - description: mt7623 generation one
>          items:
> @@ -115,7 +116,11 @@ properties:
>        dt-binding/memory/mt6779-larb-port.h for mt6779,
>        dt-binding/memory/mt8167-larb-port.h for mt8167,
>        dt-binding/memory/mt8173-larb-port.h for mt8173,
> -      dt-binding/memory/mt8183-larb-port.h for mt8183.
> +      dt-binding/memory/mt8183-larb-port.h for mt8183,
> +      dt-binding/memory/mt8192-larb-port.h for mt8192.
> +
> +  power-domains:
> +    maxItems: 1
>  
>  required:
>    - compatible
> @@ -133,11 +138,22 @@ allOf:
>                - mediatek,mt2701-m4u
>                - mediatek,mt2712-m4u
>                - mediatek,mt8173-m4u
> +              - mediatek,mt8192-m4u
>  
>      then:
>        required:
>          - clocks
>  
> +  - if:
> +      properties:
> +        compatible:
> +          enum:
> +            - mediatek,mt8192-m4u
> +
> +    then:
> +      required:
> +        - power-domains
> +
>  additionalProperties: false
>  
>  examples:
> diff --git a/include/dt-bindings/memory/mt8192-larb-port.h b/include/dt-bindings/memory/mt8192-larb-port.h
> new file mode 100644
> index 000000000000..ec1ac2ba7094
> --- /dev/null
> +++ b/include/dt-bindings/memory/mt8192-larb-port.h
> @@ -0,0 +1,240 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2020 MediaTek Inc.
> + *
> + * Author: Chao Hao <chao.hao@mediatek.com>
> + * Author: Yong Wu <yong.wu@mediatek.com>
> + */
> +#ifndef _DT_BINDINGS_MEMORY_MT8192_LARB_PORT_H_
> +#define _DT_BINDINGS_MEMORY_MT8192_LARB_PORT_H_
> +
> +#include <dt-bindings/memory/mtk-smi-larb-port.h>
> +
> +/*
> + * MM IOMMU:
> + * domain 0: display: larb0, larb1.
> + * domain 1: vcodec: larb4, larb5, larb7.
> + * domain 2: CAM/MDP: larb2, larb9, larb11, larb13, larb14, larb16,
> + *           larb17, larb18, larb19, larb20,
> + * domain 3: CCU0: larb13 - port9/10.
> + * domain 4: CCU1: larb14 - port4/5.
> + *
> + * larb3/6/8/10/12/15 is null.
> + */
> +
> +/* larb0 */
> +#define M4U_PORT_L0_DISP_POSTMASK0		MTK_M4U_DOM_ID(0, 0, 0)
> +#define M4U_PORT_L0_OVL_RDMA0_HDR		MTK_M4U_DOM_ID(0, 0, 1)
> +#define M4U_PORT_L0_OVL_RDMA0			MTK_M4U_DOM_ID(0, 0, 2)
> +#define M4U_PORT_L0_DISP_RDMA0			MTK_M4U_DOM_ID(0, 0, 3)
> +#define M4U_PORT_L0_DISP_WDMA0			MTK_M4U_DOM_ID(0, 0, 4)
> +#define M4U_PORT_L0_DISP_FAKE0			MTK_M4U_DOM_ID(0, 0, 5)
> +
> +/* larb1 */
> +#define M4U_PORT_L1_OVL_2L_RDMA0_HDR		MTK_M4U_DOM_ID(0, 1, 0)
> +#define M4U_PORT_L1_OVL_2L_RDMA2_HDR		MTK_M4U_DOM_ID(0, 1, 1)
> +#define M4U_PORT_L1_OVL_2L_RDMA0		MTK_M4U_DOM_ID(0, 1, 2)
> +#define M4U_PORT_L1_OVL_2L_RDMA2		MTK_M4U_DOM_ID(0, 1, 3)
> +#define M4U_PORT_L1_DISP_MDP_RDMA4		MTK_M4U_DOM_ID(0, 1, 4)
> +#define M4U_PORT_L1_DISP_RDMA4			MTK_M4U_DOM_ID(0, 1, 5)
> +#define M4U_PORT_L1_DISP_UFBC_WDMA0		MTK_M4U_DOM_ID(0, 1, 6)
> +#define M4U_PORT_L1_DISP_FAKE1			MTK_M4U_DOM_ID(0, 1, 7)
> +
> +/* larb2 */
> +#define M4U_PORT_L2_MDP_RDMA0			MTK_M4U_DOM_ID(2, 2, 0)
> +#define M4U_PORT_L2_MDP_RDMA1			MTK_M4U_DOM_ID(2, 2, 1)
> +#define M4U_PORT_L2_MDP_WROT0			MTK_M4U_DOM_ID(2, 2, 2)
> +#define M4U_PORT_L2_MDP_WROT1			MTK_M4U_DOM_ID(2, 2, 3)
> +#define M4U_PORT_L2_MDP_DISP_FAKE0		MTK_M4U_DOM_ID(2, 2, 4)
> +
> +/* larb3: null */
> +
> +/* larb4 */
> +#define M4U_PORT_L4_VDEC_MC_EXT			MTK_M4U_DOM_ID(1, 4, 0)
> +#define M4U_PORT_L4_VDEC_UFO_EXT		MTK_M4U_DOM_ID(1, 4, 1)
> +#define M4U_PORT_L4_VDEC_PP_EXT			MTK_M4U_DOM_ID(1, 4, 2)
> +#define M4U_PORT_L4_VDEC_PRED_RD_EXT		MTK_M4U_DOM_ID(1, 4, 3)
> +#define M4U_PORT_L4_VDEC_PRED_WR_EXT		MTK_M4U_DOM_ID(1, 4, 4)
> +#define M4U_PORT_L4_VDEC_PPWRAP_EXT		MTK_M4U_DOM_ID(1, 4, 5)
> +#define M4U_PORT_L4_VDEC_TILE_EXT		MTK_M4U_DOM_ID(1, 4, 6)
> +#define M4U_PORT_L4_VDEC_VLD_EXT		MTK_M4U_DOM_ID(1, 4, 7)
> +#define M4U_PORT_L4_VDEC_VLD2_EXT		MTK_M4U_DOM_ID(1, 4, 8)
> +#define M4U_PORT_L4_VDEC_AVC_MV_EXT		MTK_M4U_DOM_ID(1, 4, 9)
> +#define M4U_PORT_L4_VDEC_RG_CTRL_DMA_EXT	MTK_M4U_DOM_ID(1, 4, 10)
> +
> +/* larb5 */
> +#define M4U_PORT_L5_VDEC_LAT0_VLD_EXT		MTK_M4U_DOM_ID(1, 5, 0)
> +#define M4U_PORT_L5_VDEC_LAT0_VLD2_EXT		MTK_M4U_DOM_ID(1, 5, 1)
> +#define M4U_PORT_L5_VDEC_LAT0_AVC_MV_EXT	MTK_M4U_DOM_ID(1, 5, 2)
> +#define M4U_PORT_L5_VDEC_LAT0_PRED_RD_EXT	MTK_M4U_DOM_ID(1, 5, 3)
> +#define M4U_PORT_L5_VDEC_LAT0_TILE_EXT		MTK_M4U_DOM_ID(1, 5, 4)
> +#define M4U_PORT_L5_VDEC_LAT0_WDMA_EXT		MTK_M4U_DOM_ID(1, 5, 5)
> +#define M4U_PORT_L5_VDEC_LAT0_RG_CTRL_DMA_EXT	MTK_M4U_DOM_ID(1, 5, 6)
> +#define M4U_PORT_L5_VDEC_UFO_ENC_EXT		MTK_M4U_DOM_ID(1, 5, 7)
> +
> +/* larb6: null */
> +
> +/* larb7 */
> +#define M4U_PORT_L7_VENC_RCPU			MTK_M4U_DOM_ID(1, 7, 0)
> +#define M4U_PORT_L7_VENC_REC			MTK_M4U_DOM_ID(1, 7, 1)
> +#define M4U_PORT_L7_VENC_BSDMA			MTK_M4U_DOM_ID(1, 7, 2)
> +#define M4U_PORT_L7_VENC_SV_COMV		MTK_M4U_DOM_ID(1, 7, 3)
> +#define M4U_PORT_L7_VENC_RD_COMV		MTK_M4U_DOM_ID(1, 7, 4)
> +#define M4U_PORT_L7_VENC_CUR_LUMA		MTK_M4U_DOM_ID(1, 7, 5)
> +#define M4U_PORT_L7_VENC_CUR_CHROMA		MTK_M4U_DOM_ID(1, 7, 6)
> +#define M4U_PORT_L7_VENC_REF_LUMA		MTK_M4U_DOM_ID(1, 7, 7)
> +#define M4U_PORT_L7_VENC_REF_CHROMA		MTK_M4U_DOM_ID(1, 7, 8)
> +#define M4U_PORT_L7_JPGENC_Y_RDMA		MTK_M4U_DOM_ID(1, 7, 9)
> +#define M4U_PORT_L7_JPGENC_Q_RDMA		MTK_M4U_DOM_ID(1, 7, 10)
> +#define M4U_PORT_L7_JPGENC_C_TABLE		MTK_M4U_DOM_ID(1, 7, 11)
> +#define M4U_PORT_L7_JPGENC_BSDMA		MTK_M4U_DOM_ID(1, 7, 12)
> +#define M4U_PORT_L7_VENC_SUB_R_LUMA		MTK_M4U_DOM_ID(1, 7, 13)
> +#define M4U_PORT_L7_VENC_SUB_W_LUMA		MTK_M4U_DOM_ID(1, 7, 14)
> +
> +/* larb8: null */
> +
> +/* larb9 */
> +#define M4U_PORT_L9_IMG_IMGI_D1			MTK_M4U_DOM_ID(2, 9, 0)
> +#define M4U_PORT_L9_IMG_IMGBI_D1		MTK_M4U_DOM_ID(2, 9, 1)
> +#define M4U_PORT_L9_IMG_DMGI_D1			MTK_M4U_DOM_ID(2, 9, 2)
> +#define M4U_PORT_L9_IMG_DEPI_D1			MTK_M4U_DOM_ID(2, 9, 3)
> +#define M4U_PORT_L9_IMG_ICE_D1			MTK_M4U_DOM_ID(2, 9, 4)
> +#define M4U_PORT_L9_IMG_SMTI_D1			MTK_M4U_DOM_ID(2, 9, 5)
> +#define M4U_PORT_L9_IMG_SMTO_D2			MTK_M4U_DOM_ID(2, 9, 6)
> +#define M4U_PORT_L9_IMG_SMTO_D1			MTK_M4U_DOM_ID(2, 9, 7)
> +#define M4U_PORT_L9_IMG_CRZO_D1			MTK_M4U_DOM_ID(2, 9, 8)
> +#define M4U_PORT_L9_IMG_IMG3O_D1		MTK_M4U_DOM_ID(2, 9, 9)
> +#define M4U_PORT_L9_IMG_VIPI_D1			MTK_M4U_DOM_ID(2, 9, 10)
> +#define M4U_PORT_L9_IMG_SMTI_D5			MTK_M4U_DOM_ID(2, 9, 11)
> +#define M4U_PORT_L9_IMG_TIMGO_D1		MTK_M4U_DOM_ID(2, 9, 12)
> +#define M4U_PORT_L9_IMG_UFBC_W0			MTK_M4U_DOM_ID(2, 9, 13)
> +#define M4U_PORT_L9_IMG_UFBC_R0			MTK_M4U_DOM_ID(2, 9, 14)
> +
> +/* larb10: null */
> +
> +/* larb11 */
> +#define M4U_PORT_L11_IMG_IMGI_D1		MTK_M4U_DOM_ID(2, 11, 0)
> +#define M4U_PORT_L11_IMG_IMGBI_D1		MTK_M4U_DOM_ID(2, 11, 1)
> +#define M4U_PORT_L11_IMG_DMGI_D1		MTK_M4U_DOM_ID(2, 11, 2)
> +#define M4U_PORT_L11_IMG_DEPI_D1		MTK_M4U_DOM_ID(2, 11, 3)
> +#define M4U_PORT_L11_IMG_ICE_D1			MTK_M4U_DOM_ID(2, 11, 4)
> +#define M4U_PORT_L11_IMG_SMTI_D1		MTK_M4U_DOM_ID(2, 11, 5)
> +#define M4U_PORT_L11_IMG_SMTO_D2		MTK_M4U_DOM_ID(2, 11, 6)
> +#define M4U_PORT_L11_IMG_SMTO_D1		MTK_M4U_DOM_ID(2, 11, 7)
> +#define M4U_PORT_L11_IMG_CRZO_D1		MTK_M4U_DOM_ID(2, 11, 8)
> +#define M4U_PORT_L11_IMG_IMG3O_D1		MTK_M4U_DOM_ID(2, 11, 9)
> +#define M4U_PORT_L11_IMG_VIPI_D1		MTK_M4U_DOM_ID(2, 11, 10)
> +#define M4U_PORT_L11_IMG_SMTI_D5		MTK_M4U_DOM_ID(2, 11, 11)
> +#define M4U_PORT_L11_IMG_TIMGO_D1		MTK_M4U_DOM_ID(2, 11, 12)
> +#define M4U_PORT_L11_IMG_UFBC_W0		MTK_M4U_DOM_ID(2, 11, 13)
> +#define M4U_PORT_L11_IMG_UFBC_R0		MTK_M4U_DOM_ID(2, 11, 14)
> +#define M4U_PORT_L11_IMG_WPE_RDMA1		MTK_M4U_DOM_ID(2, 11, 15)
> +#define M4U_PORT_L11_IMG_WPE_RDMA0		MTK_M4U_DOM_ID(2, 11, 16)
> +#define M4U_PORT_L11_IMG_WPE_WDMA		MTK_M4U_DOM_ID(2, 11, 17)
> +#define M4U_PORT_L11_IMG_MFB_RDMA0		MTK_M4U_DOM_ID(2, 11, 18)
> +#define M4U_PORT_L11_IMG_MFB_RDMA1		MTK_M4U_DOM_ID(2, 11, 19)
> +#define M4U_PORT_L11_IMG_MFB_RDMA2		MTK_M4U_DOM_ID(2, 11, 20)
> +#define M4U_PORT_L11_IMG_MFB_RDMA3		MTK_M4U_DOM_ID(2, 11, 21)
> +#define M4U_PORT_L11_IMG_MFB_RDMA4		MTK_M4U_DOM_ID(2, 11, 22)
> +#define M4U_PORT_L11_IMG_MFB_RDMA5		MTK_M4U_DOM_ID(2, 11, 23)
> +#define M4U_PORT_L11_IMG_MFB_WDMA0		MTK_M4U_DOM_ID(2, 11, 24)
> +#define M4U_PORT_L11_IMG_MFB_WDMA1		MTK_M4U_DOM_ID(2, 11, 25)
> +
> +/* larb12: null */
> +
> +/* larb13 */
> +#define M4U_PORT_L13_CAM_MRAWI			MTK_M4U_DOM_ID(2, 13, 0)
> +#define M4U_PORT_L13_CAM_MRAWO0			MTK_M4U_DOM_ID(2, 13, 1)
> +#define M4U_PORT_L13_CAM_MRAWO1			MTK_M4U_DOM_ID(2, 13, 2)
> +#define M4U_PORT_L13_CAM_CAMSV1			MTK_M4U_DOM_ID(2, 13, 3)
> +#define M4U_PORT_L13_CAM_CAMSV2			MTK_M4U_DOM_ID(2, 13, 4)
> +#define M4U_PORT_L13_CAM_CAMSV3			MTK_M4U_DOM_ID(2, 13, 5)
> +#define M4U_PORT_L13_CAM_CAMSV4			MTK_M4U_DOM_ID(2, 13, 6)
> +#define M4U_PORT_L13_CAM_CAMSV5			MTK_M4U_DOM_ID(2, 13, 7)
> +#define M4U_PORT_L13_CAM_CAMSV6			MTK_M4U_DOM_ID(2, 13, 8)
> +#define M4U_PORT_L13_CAM_CCUI			MTK_M4U_DOM_ID(3, 13, 9)
> +#define M4U_PORT_L13_CAM_CCUO			MTK_M4U_DOM_ID(3, 13, 10)
> +#define M4U_PORT_L13_CAM_FAKE			MTK_M4U_DOM_ID(2, 13, 11)
> +
> +/* larb14 */
> +#define M4U_PORT_L14_CAM_RESERVE1		MTK_M4U_DOM_ID(2, 14, 0)
> +#define M4U_PORT_L14_CAM_RESERVE2		MTK_M4U_DOM_ID(2, 14, 1)
> +#define M4U_PORT_L14_CAM_RESERVE3		MTK_M4U_DOM_ID(2, 14, 2)
> +#define M4U_PORT_L14_CAM_CAMSV0			MTK_M4U_DOM_ID(2, 14, 3)
> +#define M4U_PORT_L14_CAM_CCUI			MTK_M4U_DOM_ID(4, 14, 4)
> +#define M4U_PORT_L14_CAM_CCUO			MTK_M4U_DOM_ID(4, 14, 5)
> +
> +/* larb15: null */
> +
> +/* larb16 */
> +#define M4U_PORT_L16_CAM_IMGO_R1_A		MTK_M4U_DOM_ID(2, 16, 0)
> +#define M4U_PORT_L16_CAM_RRZO_R1_A		MTK_M4U_DOM_ID(2, 16, 1)
> +#define M4U_PORT_L16_CAM_CQI_R1_A		MTK_M4U_DOM_ID(2, 16, 2)
> +#define M4U_PORT_L16_CAM_BPCI_R1_A		MTK_M4U_DOM_ID(2, 16, 3)
> +#define M4U_PORT_L16_CAM_YUVO_R1_A		MTK_M4U_DOM_ID(2, 16, 4)
> +#define M4U_PORT_L16_CAM_UFDI_R2_A		MTK_M4U_DOM_ID(2, 16, 5)
> +#define M4U_PORT_L16_CAM_RAWI_R2_A		MTK_M4U_DOM_ID(2, 16, 6)
> +#define M4U_PORT_L16_CAM_RAWI_R3_A		MTK_M4U_DOM_ID(2, 16, 7)
> +#define M4U_PORT_L16_CAM_AAO_R1_A		MTK_M4U_DOM_ID(2, 16, 8)
> +#define M4U_PORT_L16_CAM_AFO_R1_A		MTK_M4U_DOM_ID(2, 16, 9)
> +#define M4U_PORT_L16_CAM_FLKO_R1_A		MTK_M4U_DOM_ID(2, 16, 10)
> +#define M4U_PORT_L16_CAM_LCESO_R1_A		MTK_M4U_DOM_ID(2, 16, 11)
> +#define M4U_PORT_L16_CAM_CRZO_R1_A		MTK_M4U_DOM_ID(2, 16, 12)
> +#define M4U_PORT_L16_CAM_LTMSO_R1_A		MTK_M4U_DOM_ID(2, 16, 13)
> +#define M4U_PORT_L16_CAM_RSSO_R1_A		MTK_M4U_DOM_ID(2, 16, 14)
> +#define M4U_PORT_L16_CAM_AAHO_R1_A		MTK_M4U_DOM_ID(2, 16, 15)
> +#define M4U_PORT_L16_CAM_LSCI_R1_A		MTK_M4U_DOM_ID(2, 16, 16)
> +
> +/* larb17 */
> +#define M4U_PORT_L17_CAM_IMGO_R1_B		MTK_M4U_DOM_ID(2, 17, 0)
> +#define M4U_PORT_L17_CAM_RRZO_R1_B		MTK_M4U_DOM_ID(2, 17, 1)
> +#define M4U_PORT_L17_CAM_CQI_R1_B		MTK_M4U_DOM_ID(2, 17, 2)
> +#define M4U_PORT_L17_CAM_BPCI_R1_B		MTK_M4U_DOM_ID(2, 17, 3)
> +#define M4U_PORT_L17_CAM_YUVO_R1_B		MTK_M4U_DOM_ID(2, 17, 4)
> +#define M4U_PORT_L17_CAM_UFDI_R2_B		MTK_M4U_DOM_ID(2, 17, 5)
> +#define M4U_PORT_L17_CAM_RAWI_R2_B		MTK_M4U_DOM_ID(2, 17, 6)
> +#define M4U_PORT_L17_CAM_RAWI_R3_B		MTK_M4U_DOM_ID(2, 17, 7)
> +#define M4U_PORT_L17_CAM_AAO_R1_B		MTK_M4U_DOM_ID(2, 17, 8)
> +#define M4U_PORT_L17_CAM_AFO_R1_B		MTK_M4U_DOM_ID(2, 17, 9)
> +#define M4U_PORT_L17_CAM_FLKO_R1_B		MTK_M4U_DOM_ID(2, 17, 10)
> +#define M4U_PORT_L17_CAM_LCESO_R1_B		MTK_M4U_DOM_ID(2, 17, 11)
> +#define M4U_PORT_L17_CAM_CRZO_R1_B		MTK_M4U_DOM_ID(2, 17, 12)
> +#define M4U_PORT_L17_CAM_LTMSO_R1_B		MTK_M4U_DOM_ID(2, 17, 13)
> +#define M4U_PORT_L17_CAM_RSSO_R1_B		MTK_M4U_DOM_ID(2, 17, 14)
> +#define M4U_PORT_L17_CAM_AAHO_R1_B		MTK_M4U_DOM_ID(2, 17, 15)
> +#define M4U_PORT_L17_CAM_LSCI_R1_B		MTK_M4U_DOM_ID(2, 17, 16)
> +
> +/* larb18 */
> +#define M4U_PORT_L18_CAM_IMGO_R1_C		MTK_M4U_DOM_ID(2, 18, 0)
> +#define M4U_PORT_L18_CAM_RRZO_R1_C		MTK_M4U_DOM_ID(2, 18, 1)
> +#define M4U_PORT_L18_CAM_CQI_R1_C		MTK_M4U_DOM_ID(2, 18, 2)
> +#define M4U_PORT_L18_CAM_BPCI_R1_C		MTK_M4U_DOM_ID(2, 18, 3)
> +#define M4U_PORT_L18_CAM_YUVO_R1_C		MTK_M4U_DOM_ID(2, 18, 4)
> +#define M4U_PORT_L18_CAM_UFDI_R2_C		MTK_M4U_DOM_ID(2, 18, 5)
> +#define M4U_PORT_L18_CAM_RAWI_R2_C		MTK_M4U_DOM_ID(2, 18, 6)
> +#define M4U_PORT_L18_CAM_RAWI_R3_C		MTK_M4U_DOM_ID(2, 18, 7)
> +#define M4U_PORT_L18_CAM_AAO_R1_C		MTK_M4U_DOM_ID(2, 18, 8)
> +#define M4U_PORT_L18_CAM_AFO_R1_C		MTK_M4U_DOM_ID(2, 18, 9)
> +#define M4U_PORT_L18_CAM_FLKO_R1_C		MTK_M4U_DOM_ID(2, 18, 10)
> +#define M4U_PORT_L18_CAM_LCESO_R1_C		MTK_M4U_DOM_ID(2, 18, 11)
> +#define M4U_PORT_L18_CAM_CRZO_R1_C		MTK_M4U_DOM_ID(2, 18, 12)
> +#define M4U_PORT_L18_CAM_LTMSO_R1_C		MTK_M4U_DOM_ID(2, 18, 13)
> +#define M4U_PORT_L18_CAM_RSSO_R1_C		MTK_M4U_DOM_ID(2, 18, 14)
> +#define M4U_PORT_L18_CAM_AAHO_R1_C		MTK_M4U_DOM_ID(2, 18, 15)
> +#define M4U_PORT_L18_CAM_LSCI_R1_C		MTK_M4U_DOM_ID(2, 18, 16)
> +
> +/* larb19 */
> +#define M4U_PORT_L19_IPE_DVS_RDMA		MTK_M4U_DOM_ID(2, 19, 0)
> +#define M4U_PORT_L19_IPE_DVS_WDMA		MTK_M4U_DOM_ID(2, 19, 1)
> +#define M4U_PORT_L19_IPE_DVP_RDMA		MTK_M4U_DOM_ID(2, 19, 2)
> +#define M4U_PORT_L19_IPE_DVP_WDMA		MTK_M4U_DOM_ID(2, 19, 3)
> +
> +/* larb20 */
> +#define M4U_PORT_L20_IPE_FDVT_RDA		MTK_M4U_DOM_ID(2, 20, 0)
> +#define M4U_PORT_L20_IPE_FDVT_RDB		MTK_M4U_DOM_ID(2, 20, 1)
> +#define M4U_PORT_L20_IPE_FDVT_WRA		MTK_M4U_DOM_ID(2, 20, 2)
> +#define M4U_PORT_L20_IPE_FDVT_WRB		MTK_M4U_DOM_ID(2, 20, 3)
> +#define M4U_PORT_L20_IPE_RSC_RDMA0		MTK_M4U_DOM_ID(2, 20, 4)
> +#define M4U_PORT_L20_IPE_RSC_WDMA		MTK_M4U_DOM_ID(2, 20, 5)
> +
> +#endif
> -- 
> 2.18.0
> 
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
