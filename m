Return-Path: <SRS0=ms/0=4M=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C43E6C11D34
	for <iommu@archiver.kernel.org>; Mon, 24 Feb 2020 13:08:11 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88F2320828
	for <iommu@archiver.kernel.org>; Mon, 24 Feb 2020 13:08:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ggAX4k2X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88F2320828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 4BE5985E24;
	Mon, 24 Feb 2020 13:08:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qAeBhpgzA70X; Mon, 24 Feb 2020 13:08:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A894685DF2;
	Mon, 24 Feb 2020 13:08:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A39F0C07FF;
	Mon, 24 Feb 2020 13:08:10 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 694AEC0177
 for <iommu@lists.linux-foundation.org>; Mon, 24 Feb 2020 13:08:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 54CC385DF5
 for <iommu@lists.linux-foundation.org>; Mon, 24 Feb 2020 13:08:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xZ1Z64jkPL5J for <iommu@lists.linux-foundation.org>;
 Mon, 24 Feb 2020 13:08:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com
 [207.211.31.81])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 6BFA785DF2
 for <iommu@lists.linux-foundation.org>; Mon, 24 Feb 2020 13:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582549687;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8hYIHZTnTP03p6Yp4LlShbTvxf4UyOXsFmmyMPgeaYI=;
 b=ggAX4k2X/nrSgbEhTp+FSzWVvJrMksYG+aQw/fFewmeopr8t5GVMxVo8Ko0zK+ubk8SGlF
 slcxuKjlsB4HV3HQwEEAPxAoRubW2aGHP3ny957SSRsMQ4nXgMxVuNFfuWmPsz8ZWuE8fb
 Xrsh5GL39M8Fa5iDWYLTVJ0mm+w/AAE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-463-1KFA4pPFOt-nSzxZ1v6H2w-1; Mon, 24 Feb 2020 08:08:01 -0500
X-MC-Unique: 1KFA4pPFOt-nSzxZ1v6H2w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A47AB107ACCA;
 Mon, 24 Feb 2020 13:07:55 +0000 (UTC)
Received: from [10.36.116.59] (ovpn-116-59.ams2.redhat.com [10.36.116.59])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BF3FB909E9;
 Mon, 24 Feb 2020 13:07:44 +0000 (UTC)
Subject: Re: [RFC PATCH 01/11] vfio: Remove Calxeda XGMAC reset driver
To: Rob Herring <robh@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, soc@kernel.org,
 Andre Przywara <andre.przywara@arm.com>,
 Robert Richter <rrichter@marvell.com>, Jon Loeliger <jdl@jdl.com>,
 Alexander Graf <graf@amazon.com>, Matthias Brugger <mbrugger@suse.com>,
 Mark Langsdorf <mlangsdo@redhat.com>
References: <20200218171321.30990-1-robh@kernel.org>
 <20200218171321.30990-2-robh@kernel.org>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <23fda074-149e-9c77-5eee-4d6b591a6ebf@redhat.com>
Date: Mon, 24 Feb 2020 14:07:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20200218171321.30990-2-robh@kernel.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Cc: kvm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>,
 linux-ide@vger.kernel.org, Will Deacon <will@kernel.org>,
 linux-clk@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>,
 devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, linux-edac@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>, Tony Luck <tony.luck@intel.com>,
 Stephen Boyd <sboyd@kernel.org>, netdev@vger.kernel.org,
 Cornelia Huck <cohuck@redhat.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 iommu@lists.linux-foundation.org, James Morse <james.morse@arm.com>,
 Robin Murphy <robin.murphy@arm.com>, "David S. Miller" <davem@davemloft.net>
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

Hi Rob, Alex,

On 2/18/20 6:13 PM, Rob Herring wrote:
> Cc: Eric Auger <eric.auger@redhat.com>
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Cc: Cornelia Huck <cohuck@redhat.com>
> Cc: kvm@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> Do not apply yet.
> 
>  drivers/vfio/platform/reset/Kconfig           |  8 --
>  drivers/vfio/platform/reset/Makefile          |  2 -
>  .../reset/vfio_platform_calxedaxgmac.c        | 74 -------------------
>  3 files changed, 84 deletions(-)
>  delete mode 100644 drivers/vfio/platform/reset/vfio_platform_calxedaxgmac.c
> 
> diff --git a/drivers/vfio/platform/reset/Kconfig b/drivers/vfio/platform/reset/Kconfig
> index 1edbe9ee7356..3668d1d92909 100644
> --- a/drivers/vfio/platform/reset/Kconfig
> +++ b/drivers/vfio/platform/reset/Kconfig
> @@ -1,12 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> -config VFIO_PLATFORM_CALXEDAXGMAC_RESET
> -	tristate "VFIO support for calxeda xgmac reset"
> -	depends on VFIO_PLATFORM
> -	help
> -	  Enables the VFIO platform driver to handle reset for Calxeda xgmac
> -
> -	  If you don't know what to do here, say N.
> -
>  config VFIO_PLATFORM_AMDXGBE_RESET
>  	tristate "VFIO support for AMD XGBE reset"
>  	depends on VFIO_PLATFORM
> diff --git a/drivers/vfio/platform/reset/Makefile b/drivers/vfio/platform/reset/Makefile
> index 7294c5ea122e..be7960ce5dbc 100644
> --- a/drivers/vfio/platform/reset/Makefile
> +++ b/drivers/vfio/platform/reset/Makefile
> @@ -1,7 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0
> -vfio-platform-calxedaxgmac-y := vfio_platform_calxedaxgmac.o
>  vfio-platform-amdxgbe-y := vfio_platform_amdxgbe.o
> 
> -obj-$(CONFIG_VFIO_PLATFORM_CALXEDAXGMAC_RESET) += vfio-platform-calxedaxgmac.o
>  obj-$(CONFIG_VFIO_PLATFORM_AMDXGBE_RESET) += vfio-platform-amdxgbe.o
>  obj-$(CONFIG_VFIO_PLATFORM_BCMFLEXRM_RESET) += vfio_platform_bcmflexrm.o
> diff --git a/drivers/vfio/platform/reset/vfio_platform_calxedaxgmac.c b/drivers/vfio/platform/reset/vfio_platform_calxedaxgmac.c
> deleted file mode 100644
> index 09a9453b75c5..000000000000
> --- a/drivers/vfio/platform/reset/vfio_platform_calxedaxgmac.c
> +++ /dev/null
> @@ -1,74 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/*
> - * VFIO platform driver specialized for Calxeda xgmac reset
> - * reset code is inherited from calxeda xgmac native driver
> - *
> - * Copyright 2010-2011 Calxeda, Inc.
> - * Copyright (c) 2015 Linaro Ltd.
> - *              www.linaro.org
> - */
> -
> -#include <linux/module.h>
> -#include <linux/kernel.h>
> -#include <linux/init.h>
> -#include <linux/io.h>
> -
> -#include "../vfio_platform_private.h"
> -
> -#define DRIVER_VERSION  "0.1"
> -#define DRIVER_AUTHOR   "Eric Auger <eric.auger@linaro.org>"
> -#define DRIVER_DESC     "Reset support for Calxeda xgmac vfio platform device"
> -
> -/* XGMAC Register definitions */
> -#define XGMAC_CONTROL           0x00000000      /* MAC Configuration */
> -
> -/* DMA Control and Status Registers */
> -#define XGMAC_DMA_CONTROL       0x00000f18      /* Ctrl (Operational Mode) */
> -#define XGMAC_DMA_INTR_ENA      0x00000f1c      /* Interrupt Enable */
> -
> -/* DMA Control registe defines */
> -#define DMA_CONTROL_ST          0x00002000      /* Start/Stop Transmission */
> -#define DMA_CONTROL_SR          0x00000002      /* Start/Stop Receive */
> -
> -/* Common MAC defines */
> -#define MAC_ENABLE_TX           0x00000008      /* Transmitter Enable */
> -#define MAC_ENABLE_RX           0x00000004      /* Receiver Enable */
> -
> -static inline void xgmac_mac_disable(void __iomem *ioaddr)
> -{
> -	u32 value = readl(ioaddr + XGMAC_DMA_CONTROL);
> -
> -	value &= ~(DMA_CONTROL_ST | DMA_CONTROL_SR);
> -	writel(value, ioaddr + XGMAC_DMA_CONTROL);
> -
> -	value = readl(ioaddr + XGMAC_CONTROL);
> -	value &= ~(MAC_ENABLE_TX | MAC_ENABLE_RX);
> -	writel(value, ioaddr + XGMAC_CONTROL);
> -}
> -
> -static int vfio_platform_calxedaxgmac_reset(struct vfio_platform_device *vdev)
> -{
> -	struct vfio_platform_region *reg = &vdev->regions[0];
> -
> -	if (!reg->ioaddr) {
> -		reg->ioaddr =
> -			ioremap(reg->addr, reg->size);
> -		if (!reg->ioaddr)
> -			return -ENOMEM;
> -	}
> -
> -	/* disable IRQ */
> -	writel(0, reg->ioaddr + XGMAC_DMA_INTR_ENA);
> -
> -	/* Disable the MAC core */
> -	xgmac_mac_disable(reg->ioaddr);
> -
> -	return 0;
> -}
> -
> -module_vfio_reset_handler("calxeda,hb-xgmac", vfio_platform_calxedaxgmac_reset);
> -
> -MODULE_VERSION(DRIVER_VERSION);
> -MODULE_LICENSE("GPL v2");
> -MODULE_AUTHOR(DRIVER_AUTHOR);
> -MODULE_DESCRIPTION(DRIVER_DESC);
> --
> 2.20.1
> 
I do not have access to this HW anymore and I use Seattle to test
vfio-platform. So

Acked-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
