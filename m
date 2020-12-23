Return-Path: <SRS0=5yIV=F3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC1C3C433DB
	for <iommu@archiver.kernel.org>; Wed, 23 Dec 2020 08:15:50 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 591A32076D
	for <iommu@archiver.kernel.org>; Wed, 23 Dec 2020 08:15:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 591A32076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E689385535;
	Wed, 23 Dec 2020 08:15:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XvKRRUqcxrsW; Wed, 23 Dec 2020 08:15:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 453588551F;
	Wed, 23 Dec 2020 08:15:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 31B65C1787;
	Wed, 23 Dec 2020 08:15:49 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 569F9C0893
 for <iommu@lists.linux-foundation.org>; Wed, 23 Dec 2020 08:15:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 4E2A287230
 for <iommu@lists.linux-foundation.org>; Wed, 23 Dec 2020 08:15:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DWMC7HZAJsci for <iommu@lists.linux-foundation.org>;
 Wed, 23 Dec 2020 08:15:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com
 [209.85.215.170])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 4CB2F8722D
 for <iommu@lists.linux-foundation.org>; Wed, 23 Dec 2020 08:15:46 +0000 (UTC)
Received: by mail-pg1-f170.google.com with SMTP id e2so10149175pgi.5
 for <iommu@lists.linux-foundation.org>; Wed, 23 Dec 2020 00:15:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=XucMaRIeMybHCwI/S50c0P9P/PzyTr/MY7GdCt6gQ/Q=;
 b=aZzdXz0SBtVFnO7PRB2b7RV7mkqwrJBV3MhQ+S6S1rTiukgrEzwXVuVmBglEF6tyx7
 sUMj4R7PThczRRpPOGxwzIDDnG8jhFuhzW11Y/PwPYVvWY8B1h6o1bjgby2jsWczSAK/
 SrYuIgiezft8tCl9+en1fO6d6CqE4ft75I0eg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=XucMaRIeMybHCwI/S50c0P9P/PzyTr/MY7GdCt6gQ/Q=;
 b=FQ3saen0g9WCw9f7ntwiIhxTAFn3Bbu94EaslvExUVgbqUqY2GOrfd5OddJcm7YXYu
 LqXIQGGKmmvmX0GBrEptx9zUAjdclHuTKW68F90toEQAFXlZa1L3wu2amlaKwmkkCn2s
 RHGZX2DY7aqI6uhIyQOvTiPdr+I8jmW8vTvDW/aT5SeTdjA967wnFSmPiU3dzEc0Q8rK
 7LCdr/X8IS9V4qYJVGQtnQayEo9Gq97QFv8WnL/W57xia9Hxv4Sf8nYGM55OCtbp5BT9
 gn2DQp5VPaRvwsXkIEChUn3GJ//E8EQRcB9117Y9VpqNFdFB3Y/Xk5yKXUhOcQXNjNm1
 1suQ==
X-Gm-Message-State: AOAM530fkNGGkRGO0KwaCNmF6+E0ZfYi45tr1iveUNaNJxF3VmhspnMD
 xs4U12Q7W5omjE3c8zoZe7qhsg==
X-Google-Smtp-Source: ABdhPJyifhZqLvN5ckPbaOURCHzmY+l/YaYK8cbQmz0WktjwzfkVze0lIG/pGDQESzamQk6LNGPbAA==
X-Received: by 2002:a63:f12:: with SMTP id e18mr23981690pgl.101.1608711345895; 
 Wed, 23 Dec 2020 00:15:45 -0800 (PST)
Received: from chromium.org ([2401:fa00:8f:2:a28c:fdff:fef0:43bf])
 by smtp.gmail.com with ESMTPSA id z11sm21421970pjn.5.2020.12.23.00.15.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Dec 2020 00:15:45 -0800 (PST)
Date: Wed, 23 Dec 2020 17:15:38 +0900
From: Tomasz Figa <tfiga@chromium.org>
To: Yong Wu <yong.wu@mediatek.com>
Subject: Re: [PATCH v5 04/27] dt-bindings: memory: mediatek: Add domain
 definition
Message-ID: <X+L8qpO+T7+U2s5r@chromium.org>
References: <20201209080102.26626-1-yong.wu@mediatek.com>
 <20201209080102.26626-5-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201209080102.26626-5-yong.wu@mediatek.com>
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

Hi Yong,

On Wed, Dec 09, 2020 at 04:00:39PM +0800, Yong Wu wrote:
> In the latest SoC, there are several HW IP require a sepecial iova
> range, mainly CCU and VPU has this requirement. Take CCU as a example,
> CCU require its iova locate in the range(0x4000_0000 ~ 0x43ff_ffff).

Is this really a domain? Does the address range come from the design of
the IOMMU?

Best regards,
Tomasz

> 
> In this patch we add a domain definition for the special port. In the
> example of CCU, If we preassign CCU port in domain1, then iommu driver
> will prepare a independent iommu domain of the special iova range for it,
> then the iova got from dma_alloc_attrs(ccu-dev) will locate in its special
> range.
> 
> This is a preparing patch for multi-domain support.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
>  include/dt-bindings/memory/mtk-smi-larb-port.h | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/include/dt-bindings/memory/mtk-smi-larb-port.h b/include/dt-bindings/memory/mtk-smi-larb-port.h
> index 7d64103209af..2d4c973c174f 100644
> --- a/include/dt-bindings/memory/mtk-smi-larb-port.h
> +++ b/include/dt-bindings/memory/mtk-smi-larb-port.h
> @@ -7,9 +7,16 @@
>  #define __DT_BINDINGS_MEMORY_MTK_MEMORY_PORT_H_
>  
>  #define MTK_LARB_NR_MAX			32
> +#define MTK_M4U_DOM_NR_MAX		8
> +
> +#define MTK_M4U_DOM_ID(domid, larb, port)	\
> +	(((domid) & 0x7) << 16 | (((larb) & 0x1f) << 5) | ((port) & 0x1f))
> +
> +/* The default dom id is 0. */
> +#define MTK_M4U_ID(larb, port)		MTK_M4U_DOM_ID(0, larb, port)
>  
> -#define MTK_M4U_ID(larb, port)		(((larb) << 5) | (port))
>  #define MTK_M4U_TO_LARB(id)		(((id) >> 5) & 0x1f)
>  #define MTK_M4U_TO_PORT(id)		((id) & 0x1f)
> +#define MTK_M4U_TO_DOM(id)		(((id) >> 16) & 0x7)
>  
>  #endif
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
