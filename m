Return-Path: <SRS0=M77+=AX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD25AC433E3
	for <iommu@archiver.kernel.org>; Sun, 12 Jul 2020 18:06:27 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5C3C206F0
	for <iommu@archiver.kernel.org>; Sun, 12 Jul 2020 18:06:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CAUkLktO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5C3C206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 71FD8253CA;
	Sun, 12 Jul 2020 18:06:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OuUNz9eDRHzl; Sun, 12 Jul 2020 18:06:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 7929324F97;
	Sun, 12 Jul 2020 18:06:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5D3AFC088E;
	Sun, 12 Jul 2020 18:06:26 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A2AAAC0733
 for <iommu@lists.linux-foundation.org>; Sun, 12 Jul 2020 18:06:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 823B92530B
 for <iommu@lists.linux-foundation.org>; Sun, 12 Jul 2020 18:06:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id u4rt7-3fpadw for <iommu@lists.linux-foundation.org>;
 Sun, 12 Jul 2020 18:06:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com
 [209.85.128.68])
 by silver.osuosl.org (Postfix) with ESMTPS id BFECD24F97
 for <iommu@lists.linux-foundation.org>; Sun, 12 Jul 2020 18:06:21 +0000 (UTC)
Received: by mail-wm1-f68.google.com with SMTP id q15so11022990wmj.2
 for <iommu@lists.linux-foundation.org>; Sun, 12 Jul 2020 11:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=rXIYGf7nKP36lUXjPoJamlUt3MsApH6KmL+wKFQttL0=;
 b=CAUkLktOBjEigcVSb5JNR+sboa7yimUHhD+N1nwWEE7TinAlC7ZJNpGfHK9TKMEE9l
 0cFr2gf3pQ/bimZ8PBmiV4spwFLh9Iw1RO9rBcG7PFxWiFLYEPaPpCXAR/N4mc2dgcWB
 tHCvoTJjzayOYqRC+WHHKpHlV4KrlUOlE88MtiGizREsb82J64QBr19uwQSN3z1M+FG/
 Y1DxrB1lza/XDpoPjGgx4mOPJo6Spw3wTZgDtkYXXk8xppsrnxOQwrrSv7ubg5G92EFa
 JRordYRXyQn25uLMcRP1ElTewWOqgggYgqRIBY6UWLtlTGtUn4j7sdy8qAdRtdv5ZVrs
 W+eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=rXIYGf7nKP36lUXjPoJamlUt3MsApH6KmL+wKFQttL0=;
 b=U6hyz4vtpOe1CbvFDMyq+maWoqBIvEKqG1CHNIjvuz1Wp20qn8QqKQ5n/uskY6RIMC
 dV6hzxNlgvatY1F+p7dVsRcr1BXncFk8MUOz1wGU+QSJbD21ahl961bp0WxL0nxI68RZ
 kZpxju447VC1RZroYvh5vQ+9jn72+faRhdvQGgQ+80Ms6PdDtDKdKw90KGVpxF+GmPlf
 mEvLj/Ko2sFnFnpoVl4uJr6wcrtncVLAncttBLjLG8oD3bW2hulBP7p9A42ZVveLce4E
 EJf486kDU1LVW6QDo9cn+RxJRUu4S+Qb14mVR0tt0uFL8IiX2DOLFF7L3KV0zqGx8qca
 ODSw==
X-Gm-Message-State: AOAM530gjsnSjQIV5TKmIMMuQW1x/4nkts18vpOc7KJlk4WJUJhDEf84
 0osn/AbHHHgCq/AFfOOwpj8=
X-Google-Smtp-Source: ABdhPJzOUmPXUmNbjdA7jZ/Qn0aHiRAOlQ80hzDT623yYWJX8GnjOzvPMH7bEVZ6XQEHalOXvPDCZg==
X-Received: by 2002:a1c:49d7:: with SMTP id
 w206mr15866960wma.181.1594577180061; 
 Sun, 12 Jul 2020 11:06:20 -0700 (PDT)
Received: from ziggy.stardust ([213.195.114.245])
 by smtp.gmail.com with ESMTPSA id j6sm20823362wro.25.2020.07.12.11.06.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 12 Jul 2020 11:06:19 -0700 (PDT)
Subject: Re: [PATCH 01/21] dt-binding: memory: mediatek: Add a common
 larb-port header file
To: Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
 Rob Herring <robh+dt@kernel.org>, Robin Murphy <robin.murphy@arm.com>
References: <20200711064846.16007-1-yong.wu@mediatek.com>
 <20200711064846.16007-2-yong.wu@mediatek.com>
From: Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <9e21288c-07da-88b0-2dbb-bd9a2a4d529b@gmail.com>
Date: Sun, 12 Jul 2020 20:06:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200711064846.16007-2-yong.wu@mediatek.com>
Content-Language: en-US
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
 Nicolas Boichat <drinkcat@chromium.org>, cui.zhang@mediatek.com,
 srv_heupstream@mediatek.com, chao.hao@mediatek.com,
 linux-kernel@vger.kernel.org, Evan Green <evgreen@chromium.org>,
 Tomasz Figa <tfiga@google.com>, iommu@lists.linux-foundation.org,
 linux-mediatek@lists.infradead.org, ming-fan.chen@mediatek.com,
 anan.sun@mediatek.com, Will Deacon <will@kernel.org>,
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



On 11/07/2020 08:48, Yong Wu wrote:
> Put all the macros about smi larb/port togethers, this is a preparing
> patch for extending LARB_NR and adding new dom-id support.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>   include/dt-bindings/memory/mt2712-larb-port.h  |  2 +-
>   include/dt-bindings/memory/mt6779-larb-port.h  |  2 +-
>   include/dt-bindings/memory/mt8173-larb-port.h  |  2 +-
>   include/dt-bindings/memory/mt8183-larb-port.h  |  2 +-
>   include/dt-bindings/memory/mtk-smi-larb-port.h | 15 +++++++++++++++
>   5 files changed, 19 insertions(+), 4 deletions(-)
>   create mode 100644 include/dt-bindings/memory/mtk-smi-larb-port.h
> 
> diff --git a/include/dt-bindings/memory/mt2712-larb-port.h b/include/dt-bindings/memory/mt2712-larb-port.h
> index 6f9aa7349cef..b6b2c6bf4459 100644
> --- a/include/dt-bindings/memory/mt2712-larb-port.h
> +++ b/include/dt-bindings/memory/mt2712-larb-port.h
> @@ -6,7 +6,7 @@
>   #ifndef __DTS_IOMMU_PORT_MT2712_H
>   #define __DTS_IOMMU_PORT_MT2712_H
>   
> -#define MTK_M4U_ID(larb, port)		(((larb) << 5) | (port))
> +#include <dt-bindings/memory/mtk-smi-larb-port.h>
>   
>   #define M4U_LARB0_ID			0
>   #define M4U_LARB1_ID			1
> diff --git a/include/dt-bindings/memory/mt6779-larb-port.h b/include/dt-bindings/memory/mt6779-larb-port.h
> index 2ad0899fbf2f..60f57f54393e 100644
> --- a/include/dt-bindings/memory/mt6779-larb-port.h
> +++ b/include/dt-bindings/memory/mt6779-larb-port.h
> @@ -7,7 +7,7 @@
>   #ifndef _DTS_IOMMU_PORT_MT6779_H_
>   #define _DTS_IOMMU_PORT_MT6779_H_
>   
> -#define MTK_M4U_ID(larb, port)		 (((larb) << 5) | (port))
> +#include <dt-bindings/memory/mtk-smi-larb-port.h>
>   
>   #define M4U_LARB0_ID			 0
>   #define M4U_LARB1_ID			 1
> diff --git a/include/dt-bindings/memory/mt8173-larb-port.h b/include/dt-bindings/memory/mt8173-larb-port.h
> index 9f31ccfeca21..d8c99c946053 100644
> --- a/include/dt-bindings/memory/mt8173-larb-port.h
> +++ b/include/dt-bindings/memory/mt8173-larb-port.h
> @@ -6,7 +6,7 @@
>   #ifndef __DTS_IOMMU_PORT_MT8173_H
>   #define __DTS_IOMMU_PORT_MT8173_H
>   
> -#define MTK_M4U_ID(larb, port)		(((larb) << 5) | (port))
> +#include <dt-bindings/memory/mtk-smi-larb-port.h>
>   
>   #define M4U_LARB0_ID			0
>   #define M4U_LARB1_ID			1
> diff --git a/include/dt-bindings/memory/mt8183-larb-port.h b/include/dt-bindings/memory/mt8183-larb-port.h
> index 2c579f305162..275c095a6fd6 100644
> --- a/include/dt-bindings/memory/mt8183-larb-port.h
> +++ b/include/dt-bindings/memory/mt8183-larb-port.h
> @@ -6,7 +6,7 @@
>   #ifndef __DTS_IOMMU_PORT_MT8183_H
>   #define __DTS_IOMMU_PORT_MT8183_H
>   
> -#define MTK_M4U_ID(larb, port)		(((larb) << 5) | (port))
> +#include <dt-bindings/memory/mtk-smi-larb-port.h>
>   
>   #define M4U_LARB0_ID			0
>   #define M4U_LARB1_ID			1
> diff --git a/include/dt-bindings/memory/mtk-smi-larb-port.h b/include/dt-bindings/memory/mtk-smi-larb-port.h
> new file mode 100644
> index 000000000000..2ec7fe5ce4e9
> --- /dev/null
> +++ b/include/dt-bindings/memory/mtk-smi-larb-port.h
> @@ -0,0 +1,15 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2020 MediaTek Inc.
> + * Author: Yong Wu <yong.wu@mediatek.com>
> + */
> +#ifndef __DTS_MTK_IOMMU_PORT_H_
> +#define __DTS_MTK_IOMMU_PORT_H_
> +
> +#define MTK_LARB_NR_MAX			16

include/soc/mediatek/smi.h has the very same define.
Should smi.h include this file?

Regards,
Matthias

> +
> +#define MTK_M4U_ID(larb, port)		(((larb) << 5) | (port))
> +#define MTK_M4U_TO_LARB(id)		(((id) >> 5) & 0xf)
> +#define MTK_M4U_TO_PORT(id)		((id) & 0x1f)
> +
> +#endif
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
