Return-Path: <SRS0=SFHS=AY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B87D3C433DF
	for <iommu@archiver.kernel.org>; Mon, 13 Jul 2020 05:43:06 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70E5E20674
	for <iommu@archiver.kernel.org>; Mon, 13 Jul 2020 05:43:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="I5mH74j0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70E5E20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 2F4CA2037E;
	Mon, 13 Jul 2020 05:43:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id paBGrqVaX9tP; Mon, 13 Jul 2020 05:43:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id F1CE720354;
	Mon, 13 Jul 2020 05:43:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D89A4C088E;
	Mon, 13 Jul 2020 05:43:04 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 32A89C0733
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jul 2020 05:43:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 28C73871C3
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jul 2020 05:43:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pIsQRuCa4zfv for <iommu@lists.linux-foundation.org>;
 Mon, 13 Jul 2020 05:43:01 +0000 (UTC)
X-Greylist: delayed 00:05:38 by SQLgrey-1.7.6
Received: from mail-lj1-f194.google.com (mail-lj1-f194.google.com
 [209.85.208.194])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id E0B4E871C1
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jul 2020 05:43:00 +0000 (UTC)
Received: by mail-lj1-f194.google.com with SMTP id b25so15277146ljp.6
 for <iommu@lists.linux-foundation.org>; Sun, 12 Jul 2020 22:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=JZ9NBtGhK+C5WPxWTTuXRE71ybFquUFtwgSFUSFj0PQ=;
 b=I5mH74j0x33+O0sPgotD8Ov+x9JEj3hMbYPLIByQegEOBjPBM32K858i9rvObt+Sh/
 ocvxgOpfDHSlT2f0SKViMGJgJmwBjhMeEx2X7/DyjvXhGxiQnsOogzSeGX8zdJiObqsC
 QjQN1y7TIoO0kt9LD+VH9awYEsgIzvu62leLI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=JZ9NBtGhK+C5WPxWTTuXRE71ybFquUFtwgSFUSFj0PQ=;
 b=XBu/KmIqUM2BaamMQ1HOr/9WNQeqS8jeuj9DBTx1F4WfH13KGnaueTwCsUoGPhQq11
 Hz+NVSyEgr/osOA9iiK1bEEuvNV93Au41IN+0hP4eG3B95mgK5/iV308CazkBJ/r0Egw
 HWxIGgai4hXTX44E/842PqVHFcNol8ioU1xOreThAhO0+tQywifhICwR/M79J9Z2Kba2
 4+ZoIdCiXf+uXD6opn5J6RK/WDzIZRaTvxvqeCnCQtNWj+CmFRo+g76i39ll8pPLxnY8
 llMBCdiiTKE4yWOu8ApJxqtBrK7HIZiepNjiabGaieQ727lvJ3c6kPmmkjJpZTEcVkwO
 ccew==
X-Gm-Message-State: AOAM533IA0fEi49KOTANyYILzGJukC+a7gbnaldhFC9GsznUaSPmv/4C
 bGl14Q2rpv8tVZjt2hMnVGsLiBhaeRdupyaK/q5MdD1m4m4=
X-Google-Smtp-Source: ABdhPJyYL23ot1CCgoFjUvfVTWVGWF6IlrkvQ5vJIbi1guEyZhVmenhpfLkf8+Ge8qIDirvrFYO43Tu8N+jHK5yWE5A=
X-Received: by 2002:a50:d908:: with SMTP id t8mr35579891edj.373.1594618640938; 
 Sun, 12 Jul 2020 22:37:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200711064846.16007-1-yong.wu@mediatek.com>
 <20200711064846.16007-5-yong.wu@mediatek.com>
In-Reply-To: <20200711064846.16007-5-yong.wu@mediatek.com>
From: Pi-Hsun Shih <pihsun@chromium.org>
Date: Mon, 13 Jul 2020 13:36:45 +0800
Message-ID: <CANdKZ0cGNy7ckzD_NAOV613o62WHdYazRRM-J8jY2-4mx_sNDA@mail.gmail.com>
Subject: Re: [PATCH 04/21] dt-binding: mediatek: Add binding for mt8192 IOMMU
 and SMI
To: Yong Wu <yong.wu@mediatek.com>
Cc: =?UTF-8?B?WW91bGluIFBlaSAo6KO05Y+L5p6XKQ==?= <youlin.pei@mediatek.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Nicolas Boichat <drinkcat@chromium.org>,
 cui.zhang@mediatek.com, srv_heupstream@mediatek.com, chao.hao@mediatek.com,
 Robin Murphy <robin.murphy@arm.com>, open list <linux-kernel@vger.kernel.org>,
 Evan Green <evgreen@chromium.org>, Tomasz Figa <tfiga@google.com>,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, ming-fan.chen@mediatek.com,
 anan.sun@mediatek.com, Will Deacon <will@kernel.org>,
 "moderated list:ARM/Mediatek SoC support"
 <linux-arm-kernel@lists.infradead.org>
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

On Sat, Jul 11, 2020 at 2:50 PM Yong Wu <yong.wu@mediatek.com> wrote:
>
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
>    3       CCU0    0x4000_0000 ~ 0x43ff_ffff     larb13: port 9/10
>    4       CCU1    0x4400_0000 ~ 0x47ff_ffff     larb14: port 4/5
>
> The iova range for CCU0/1(camera control unit) is HW requirement.
>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  .../bindings/iommu/mediatek,iommu.txt         |   8 +-
>  .../mediatek,smi-common.txt                   |   5 +-
>  .../memory-controllers/mediatek,smi-larb.txt  |   3 +-
>  include/dt-bindings/memory/mt8192-larb-port.h | 237 ++++++++++++++++++
>  4 files changed, 247 insertions(+), 6 deletions(-)
>  create mode 100644 include/dt-bindings/memory/mt8192-larb-port.h
> ...
> diff --git a/include/dt-bindings/memory/mt8192-larb-port.h b/include/dt-bindings/memory/mt8192-larb-port.h
> new file mode 100644
> index 000000000000..fbe0d5d50f1c
> --- /dev/null
> +++ b/include/dt-bindings/memory/mt8192-larb-port.h
> ...
> +/* larb7 */
> +#define M4U_PORT_L7_VENC_RCPU                  MTK_M4U_DOM_ID(1, 7, 0)
> +#define M4U_PORT_L7_VENC_REC                   MTK_M4U_DOM_ID(1, 7, 1)
> +#define M4U_PORT_L7_VENC_BSDMA                 MTK_M4U_DOM_ID(1, 7, 2)
> +#define M4U_PORT_L7_VENC_SV_COMV               MTK_M4U_DOM_ID(1, 7, 3)
> +#define M4U_PORT_L7_VENC_RD_COMV               MTK_M4U_DOM_ID(1, 7, 4)
> +#define M4U_PORT_L7_VENC_CUR_LUMA              MTK_M4U_DOM_ID(1, 7, 5)
> +#define M4U_PORT_L7_VENC_CUR_CHROMA            MTK_M4U_DOM_ID(1, 7, 6)
> +#define M4U_PORT_L7_VENC_REF_LUMA              MTK_M4U_DOM_ID(1, 7, 7)
> +#define M4U_PORT_L7_VENC_REF_CHROMA            MTK_M4U_DOM_ID(1, 7, 8)
> +#define M4U_PORT_L7_JPGENC_Y_RDMA              MTK_M4U_DOM_ID(1, 7, 9)
> +#define M4U_PORT_L7_JPGENC_Q_RDMA              MTK_M4U_DOM_ID(1, 7, 10)
> +#define M4U_PORT_L7_JPGENC_C_TABLE             MTK_M4U_DOM_ID(1, 7, 11)
> +#define M4U_PORT_L7_JPGENC_BSDMA               MTK_M4U_DOM_ID(1, 7, 12)
> +#define M4U_PORT_L7_VENC_SUB_R_LUMA            MTK_M4U_DOM_ID(1, 7, 13)
> +#define M4U_PORT_L7_VENC_SUB_W_LUMA            MTK_M4U_DOM_ID(1, 7, 14)
> +

Small nit, /* larb8: null */ is missing here.

> +/* larb9 */
> +#define M4U_PORT_L9_IMG_IMGI_D1                        MTK_M4U_DOM_ID(2, 9, 0)
> +#define M4U_PORT_L9_IMG_IMGBI_D1               MTK_M4U_DOM_ID(2, 9, 1)
> +#define M4U_PORT_L9_IMG_DMGI_D1                        MTK_M4U_DOM_ID(2, 9, 2)
> +#define M4U_PORT_L9_IMG_DEPI_D1                        MTK_M4U_DOM_ID(2, 9, 3)
> +#define M4U_PORT_L9_IMG_ICE_D1                 MTK_M4U_DOM_ID(2, 9, 4)
> +#define M4U_PORT_L9_IMG_SMTI_D1                        MTK_M4U_DOM_ID(2, 9, 5)
> +#define M4U_PORT_L9_IMG_SMTO_D2                        MTK_M4U_DOM_ID(2, 9, 6)
> +#define M4U_PORT_L9_IMG_SMTO_D1                        MTK_M4U_DOM_ID(2, 9, 7)
> +#define M4U_PORT_L9_IMG_CRZO_D1                        MTK_M4U_DOM_ID(2, 9, 8)
> +#define M4U_PORT_L9_IMG_IMG3O_D1               MTK_M4U_DOM_ID(2, 9, 9)
> +#define M4U_PORT_L9_IMG_VIPI_D1                        MTK_M4U_DOM_ID(2, 9, 10)
> +#define M4U_PORT_L9_IMG_SMTI_D5                        MTK_M4U_DOM_ID(2, 9, 11)
> +#define M4U_PORT_L9_IMG_TIMGO_D1               MTK_M4U_DOM_ID(2, 9, 12)
> +#define M4U_PORT_L9_IMG_UFBC_W0                        MTK_M4U_DOM_ID(2, 9, 13)
> +#define M4U_PORT_L9_IMG_UFBC_R0                        MTK_M4U_DOM_ID(2, 9, 14)
> +
> ...
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
