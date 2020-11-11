Return-Path: <SRS0=hwFB=ER=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14586C5517A
	for <iommu@archiver.kernel.org>; Wed, 11 Nov 2020 21:33:47 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95C9820637
	for <iommu@archiver.kernel.org>; Wed, 11 Nov 2020 21:33:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95C9820637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 0A64F86C58;
	Wed, 11 Nov 2020 21:33:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ENVWDKk32aOe; Wed, 11 Nov 2020 21:33:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 6F20885F96;
	Wed, 11 Nov 2020 21:33:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5347DC088B;
	Wed, 11 Nov 2020 21:33:45 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 177FCC016F
 for <iommu@lists.linux-foundation.org>; Wed, 11 Nov 2020 21:33:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id EC76986C55
 for <iommu@lists.linux-foundation.org>; Wed, 11 Nov 2020 21:33:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id t+ilpUwGWtvo for <iommu@lists.linux-foundation.org>;
 Wed, 11 Nov 2020 21:33:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com
 [209.85.218.68])
 by whitealder.osuosl.org (Postfix) with ESMTPS id B0ECF85F96
 for <iommu@lists.linux-foundation.org>; Wed, 11 Nov 2020 21:33:42 +0000 (UTC)
Received: by mail-ej1-f68.google.com with SMTP id oq3so4745609ejb.7
 for <iommu@lists.linux-foundation.org>; Wed, 11 Nov 2020 13:33:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=sK4IhYZOOZRYi+a2OxHEj++JSexEzteTRg9o9l5Xmmc=;
 b=byHjhSE0KEHHlX/uDMfWOP681+0YNyMbt8/3+s3F6MuJGLCRx0joJkM0FiA7Th1Xv9
 u+PmSg1QT0YAtTmvYnI22iMKgH7dwfOittTPfQ/2tJla3Cdba1Cwz7iQvBXrqzchnW54
 X0dyeSRiQj2nlFclZGLjExqMt5lhJU27rmygqvTEn/puxhfZcmZMArCT62OP0Ix1Spz3
 +MdSEa3LuRlJ6eT+tBEhdW6tbr88SgAPjvmANoWNrcGCjZ1bTh+CWi3CQ7l4UBPD5C84
 zjR4jMtj9l1r413+o5CA2yNioYXX6tTGEHJmHYRjZEV1gewS7SCOBPlX5079qqD7Aq1+
 TZ8g==
X-Gm-Message-State: AOAM533TXP/lNUMduzZeL9/YVphn2liHtFY/HldlqmN+K+B+XZ8iqBl0
 TQu+Pfer8wxjiLCGkljNIzY=
X-Google-Smtp-Source: ABdhPJyWmV5IHVA2ohdCwF8JXc37esFq7vT8fy5Vv2WHPBbGSRTGdwBIKtPRn5OWSNwKiPjundijtg==
X-Received: by 2002:a17:906:ca83:: with SMTP id
 js3mr28371238ejb.42.1605130421152; 
 Wed, 11 Nov 2020 13:33:41 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
 by smtp.googlemail.com with ESMTPSA id y15sm1439123eds.56.2020.11.11.13.33.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2020 13:33:39 -0800 (PST)
Date: Wed, 11 Nov 2020 22:33:38 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Yong Wu <yong.wu@mediatek.com>
Subject: Re: [PATCH v4 05/24] dt-bindings: mediatek: Add binding for mt8192
 IOMMU
Message-ID: <20201111213338.GD287176@kozik-lap>
References: <20201111123838.15682-1-yong.wu@mediatek.com>
 <20201111123838.15682-6-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201111123838.15682-6-yong.wu@mediatek.com>
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
 Nicolas Boichat <drinkcat@chromium.org>, srv_heupstream@mediatek.com,
 chao.hao@mediatek.com, Will Deacon <will@kernel.org>,
 Greg Kroah-Hartman <gregkh@google.com>, linux-kernel@vger.kernel.org,
 Evan Green <evgreen@chromium.org>, Tomasz Figa <tfiga@google.com>,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>,
 kernel-team@android.com, anan.sun@mediatek.com,
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

On Wed, Nov 11, 2020 at 08:38:19PM +0800, Yong Wu wrote:
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
> index 000000000000..7437fa62654e
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
> +#ifndef _DTS_IOMMU_PORT_MT8192_H_
> +#define _DTS_IOMMU_PORT_MT8192_H_

Not accurate header guard. Shoud be:
_DT_BINDINGS_MEMORY_MT8192_LARB_PORT_H_

Probably you copied it from some other Mediatek headers - all of them
have header guard pointing to different directory.

Best regards,
Krzysztof
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
