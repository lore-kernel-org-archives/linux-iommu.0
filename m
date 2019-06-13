Return-Path: <SRS0=dZmg=UM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A536DC31E4A
	for <iommu@archiver.kernel.org>; Thu, 13 Jun 2019 18:16:30 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D7312082C
	for <iommu@archiver.kernel.org>; Thu, 13 Jun 2019 18:16:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="CZadsBz6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D7312082C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 5373614A8;
	Thu, 13 Jun 2019 18:16:30 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 930B313C6
	for <iommu@lists.linux-foundation.org>;
	Thu, 13 Jun 2019 18:16:29 +0000 (UTC)
X-Greylist: delayed 01:37:07 by SQLgrey-1.7.6
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 10F6182F
	for <iommu@lists.linux-foundation.org>;
	Thu, 13 Jun 2019 18:16:28 +0000 (UTC)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x5DGd8ns038871;
	Thu, 13 Jun 2019 11:39:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1560443948;
	bh=oAxd7WsqqxVifhcKmMTYcuvBXH5GAfbEq6A7S7y01t4=;
	h=Subject:To:CC:References:From:Date:In-Reply-To;
	b=CZadsBz6yW6A12cVWwuWQ8fd4z6F8QjnHIBMKdvs/T3a7WcevNTwMybpYoHQ+gGtB
	eC+dAIp+qMlCEhaeq6BWlNwb51tH5CUKzIJB1ePSyXV1elfUtEvx3H0KKb0aqsk0Cp
	xNa5RMpgq62tJz990OtcijyQjsdod/99wmTKRVuI=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x5DGd8CM108463
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 13 Jun 2019 11:39:08 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE106.ent.ti.com
	(157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5;
	Thu, 13 Jun 2019 11:39:08 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE106.ent.ti.com
	(157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
	Frontend Transport; Thu, 13 Jun 2019 11:39:08 -0500
Received: from [128.247.58.153] (ileax41-snat.itg.ti.com [10.172.224.153])
	by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x5DGd8wc055409;
	Thu, 13 Jun 2019 11:39:08 -0500
Subject: Re: [PATCH 03/10] iommu/omap: convert to SPDX license tags
To: Yangtao Li <tiny.windzz@gmail.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"m.szyprowski@samsung.com" <m.szyprowski@samsung.com>, "kgene@kernel.org"
	<kgene@kernel.org>, "krzk@kernel.org" <krzk@kernel.org>,
	"will.deacon@arm.com" <will.deacon@arm.com>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "agross@kernel.org" <agross@kernel.org>,
	"david.brown@linaro.org" <david.brown@linaro.org>, "robdclark@gmail.com"
	<robdclark@gmail.com>, "heiko@sntech.de" <heiko@sntech.de>,
	"thierry.reding@gmail.com" <thierry.reding@gmail.com>,
	"jonathanh@nvidia.com" <jonathanh@nvidia.com>
References: <20190613162703.986-1-tiny.windzz@gmail.com>
	<20190613162703.986-3-tiny.windzz@gmail.com>
Message-ID: <ac67e363-70cf-af64-d634-c3b0b6d408fa@ti.com>
Date: Thu, 13 Jun 2019 11:39:08 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190613162703.986-3-tiny.windzz@gmail.com>
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Cc: "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>,
	"linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-rockchip@lists.infradead.org" <linux-rockchip@lists.infradead.org>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
From: Suman Anna via iommu <iommu@lists.linux-foundation.org>
Reply-To: Suman Anna <s-anna@ti.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Hi Yangtao,

On 6/13/19 11:26 AM, Yangtao Li wrote:
> Updates license to use SPDX-License-Identifier.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>

Thanks for the patch. Can you also update another related file
while at this. Will leave it to Joerg if he prefers it as a separate
patch, or folded into this patch.

include/linux/platform_data/iommu-omap.h

Acked-by: Suman Anna <s-anna@ti.com>

regards
Suman

> ---
>  drivers/iommu/omap-iommu-debug.c | 5 +----
>  drivers/iommu/omap-iommu.c       | 5 +----
>  drivers/iommu/omap-iommu.h       | 5 +----
>  drivers/iommu/omap-iopgtable.h   | 5 +----
>  4 files changed, 4 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/iommu/omap-iommu-debug.c b/drivers/iommu/omap-iommu-debug.c
> index 4abc0ef522a8..55ec67a45101 100644
> --- a/drivers/iommu/omap-iommu-debug.c
> +++ b/drivers/iommu/omap-iommu-debug.c
> @@ -1,13 +1,10 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * omap iommu: debugfs interface
>   *
>   * Copyright (C) 2008-2009 Nokia Corporation
>   *
>   * Written by Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
>   */
>  
>  #include <linux/err.h>
> diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
> index d2fb347aa4ff..e6442876913f 100644
> --- a/drivers/iommu/omap-iommu.c
> +++ b/drivers/iommu/omap-iommu.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * omap iommu: tlb and pagetable primitives
>   *
> @@ -6,10 +7,6 @@
>   *
>   * Written by Hiroshi DOYU <Hiroshi.DOYU@nokia.com>,
>   *		Paul Mundt and Toshihiro Kobayashi
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
>   */
>  
>  #include <linux/dma-mapping.h>
> diff --git a/drivers/iommu/omap-iommu.h b/drivers/iommu/omap-iommu.h
> index 1703159ef5af..5256e17d86a7 100644
> --- a/drivers/iommu/omap-iommu.h
> +++ b/drivers/iommu/omap-iommu.h
> @@ -1,13 +1,10 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
>  /*
>   * omap iommu: main structures
>   *
>   * Copyright (C) 2008-2009 Nokia Corporation
>   *
>   * Written by Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
>   */
>  
>  #ifndef _OMAP_IOMMU_H
> diff --git a/drivers/iommu/omap-iopgtable.h b/drivers/iommu/omap-iopgtable.h
> index 01a315227bf0..871c2a38f453 100644
> --- a/drivers/iommu/omap-iopgtable.h
> +++ b/drivers/iommu/omap-iopgtable.h
> @@ -1,13 +1,10 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
>  /*
>   * omap iommu: pagetable definitions
>   *
>   * Copyright (C) 2008-2010 Nokia Corporation
>   *
>   * Written by Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
>   */
>  
>  #ifndef _OMAP_IOPGTABLE_H
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
