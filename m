Return-Path: <SRS0=J3Yr=GZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5122DC433DB
	for <iommu@archiver.kernel.org>; Fri, 22 Jan 2021 21:36:06 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F13C323B06
	for <iommu@archiver.kernel.org>; Fri, 22 Jan 2021 21:36:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F13C323B06
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 9C37185809;
	Fri, 22 Jan 2021 21:36:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 96TxsXDsO9jR; Fri, 22 Jan 2021 21:36:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 16895815FA;
	Fri, 22 Jan 2021 21:36:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DBA2CC08A1;
	Fri, 22 Jan 2021 21:36:04 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BDB91C013A
 for <iommu@lists.linux-foundation.org>; Fri, 22 Jan 2021 21:36:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 89E7B2E123
 for <iommu@lists.linux-foundation.org>; Fri, 22 Jan 2021 21:36:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 58MmNljWHamA for <iommu@lists.linux-foundation.org>;
 Fri, 22 Jan 2021 21:36:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com
 [209.85.208.45])
 by silver.osuosl.org (Postfix) with ESMTPS id 451072037E
 for <iommu@lists.linux-foundation.org>; Fri, 22 Jan 2021 21:36:02 +0000 (UTC)
Received: by mail-ed1-f45.google.com with SMTP id f1so8144318edr.12
 for <iommu@lists.linux-foundation.org>; Fri, 22 Jan 2021 13:36:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=SkMtSllHFpUQ8QORRPXzW7+ePTF0623ZPgLmVHJs6Fo=;
 b=Fbd+02GPK+MqArOWEX0xTey11+aefGJ9hbs7Zbbvqo+l+n9FUAvlrdUiNYkhDyXc5j
 SsHMJfmeLiZXB+BF5SybuTEIY+B8YCMqL7szJtB8ErG+zhruW2PeishNxN4mOW4zan0S
 VW+fJkh8mG78mpnYgI3OhHWMM0BBA2DnqGKgmEhzpO4klhsDDkAXLZLq0D5QeLSFI7jd
 ZgeL3TsrrwhS18BQeh3Hn0v8CeKhw/dei81XM0/1kNHBeZvXwY4dLKkPwEYcvDRpp7ma
 eXLYpA4flfRc4+yUVdvTEC68RSCZXiQkmhY/rAazY2MlXxpYZLxFU44bpmyj3qP4yIPW
 VWvg==
X-Gm-Message-State: AOAM532+E/Tidiv1ts611MoKfB+Z1LY8DVGDCeWsz+9CPO+cdB8uh813
 7G+4eUq/mZALaQR5OYOVsao=
X-Google-Smtp-Source: ABdhPJzyOg235kQhejoZjjhHYiWr6Bp7npq1HcrfeqLsMBqDf51BuMXEE+Y4urYHbsd/eXktSLe02A==
X-Received: by 2002:a05:6402:1ad0:: with SMTP id
 ba16mr7963edb.287.1611351360723; 
 Fri, 22 Jan 2021 13:36:00 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
 by smtp.googlemail.com with ESMTPSA id z1sm6442231edm.89.2021.01.22.13.35.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Jan 2021 13:35:59 -0800 (PST)
Date: Fri, 22 Jan 2021 22:35:58 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Yong Wu <yong.wu@mediatek.com>
Subject: Re: [PATCH 3/3] memory: mtk-smi: Switch MTK_SMI to tristate
Message-ID: <20210122213558.qnboqc4obdmipxs4@kozik-lap>
References: <20210121062429.26504-1-yong.wu@mediatek.com>
 <20210121062429.26504-4-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210121062429.26504-4-yong.wu@mediatek.com>
Cc: youlin.pei@mediatek.com, anan.sun@mediatek.com,
 Nicolas Boichat <drinkcat@chromium.org>, srv_heupstream@mediatek.com,
 Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
 yi.kuo@mediatek.com, Tomasz Figa <tfiga@google.com>,
 iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
 Matthias Brugger <matthias.bgg@gmail.com>, Will Deacon <will@kernel.org>,
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

On Thu, Jan 21, 2021 at 02:24:29PM +0800, Yong Wu wrote:
> This patch switches MTK_SMI to tristate. Support it could be 'm'.
> 
> Meanwhile, Fix a build issue while MTK_SMI is built as module.

s/Fix/fix.

What error is being fixed here? How can I reproduce it? Aren't you just
adjusting it to being buildable by module?

Best regards,
Krzysztof


> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
> This patch has a little conflict with the mt8192 iommu patch which
> delete the MTK_LARB_NR_MAX in smi.h(It's still reviewing).
> This patch rebase on the clean v5.11-rc1.
> ---
>  drivers/memory/Kconfig     | 2 +-
>  include/soc/mediatek/smi.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/memory/Kconfig b/drivers/memory/Kconfig
> index 3ea6913df176..d5f0f4680880 100644
> --- a/drivers/memory/Kconfig
> +++ b/drivers/memory/Kconfig
> @@ -173,7 +173,7 @@ config JZ4780_NEMC
>  	  memory devices such as NAND and SRAM.
>  
>  config MTK_SMI
> -	bool "Mediatek SoC Memory Controller driver" if COMPILE_TEST
> +	tristate "Mediatek SoC Memory Controller driver" if COMPILE_TEST
>  	depends on ARCH_MEDIATEK || COMPILE_TEST
>  	help
>  	  This driver is for the Memory Controller module in MediaTek SoCs,
> diff --git a/include/soc/mediatek/smi.h b/include/soc/mediatek/smi.h
> index 5a34b87d89e3..29e2fb8f33d6 100644
> --- a/include/soc/mediatek/smi.h
> +++ b/include/soc/mediatek/smi.h
> @@ -9,7 +9,7 @@
>  #include <linux/bitops.h>
>  #include <linux/device.h>
>  
> -#ifdef CONFIG_MTK_SMI
> +#if IS_ENABLED(CONFIG_MTK_SMI)
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
