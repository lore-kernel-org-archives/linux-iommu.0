Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D601EC433EF
	for <iommu@archiver.kernel.org>; Fri, 22 Apr 2022 21:17:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 72E7C61186;
	Fri, 22 Apr 2022 21:17:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qL84yZpO97QP; Fri, 22 Apr 2022 21:17:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 6E53560EFA;
	Fri, 22 Apr 2022 21:17:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2F53CC0032;
	Fri, 22 Apr 2022 21:17:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4D466C002D
 for <iommu@lists.linux-foundation.org>; Fri, 22 Apr 2022 21:17:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 257C74046D
 for <iommu@lists.linux-foundation.org>; Fri, 22 Apr 2022 21:17:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gsmMB6BlERdZ for <iommu@lists.linux-foundation.org>;
 Fri, 22 Apr 2022 21:17:33 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com
 [IPv6:2607:f8b0:4864:20::b2f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7152240141
 for <iommu@lists.linux-foundation.org>; Fri, 22 Apr 2022 21:17:33 +0000 (UTC)
Received: by mail-yb1-xb2f.google.com with SMTP id b26so11070692ybj.13
 for <iommu@lists.linux-foundation.org>; Fri, 22 Apr 2022 14:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=AEXINFBxuSdD+7ajNy/LTJwAuKduMs79L1VZw5ckLgw=;
 b=YPX9uaDWm6FyszcIeSL6VLxMtHjGpipQS1CT+MROq+lyzWSXP9zeOJilU3YTuHeADl
 gVfMx7CZ/Bp1jpwp63gKAwhhwytpJb+IeqrtAMVC6/5CIX3Ky3jzzBWpPocZ+B2rJ9pI
 PgEIW9H0Q9RYS8itMZnvFXFkypugEZSo8611na4wlf1KUSbzAXaq0bn4IBI2vWmwvmzi
 ZjMTjnLJ/JnM5ssLK+3n8M1QfuhPVPFT3dG+jYE+WDQrXqIlmNh4BZ1B+i/NoNMbs6mm
 95AoR8XauXSPoozrjT+qgPfex9J2yOUOUBCjKAmESZZaYT5LSsVsU3MUjXU0rxnlGpAD
 tC6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=AEXINFBxuSdD+7ajNy/LTJwAuKduMs79L1VZw5ckLgw=;
 b=C5MwO70+20gdbyhA8EWGu1k/o2f4RxcUKkMJOquN3dyQBcBdgdenrDIStVZ4ZJWn1j
 ZQDRqOGl1uwwdUalpddxuQkM8wQwplQ1aBLDlIb5ntc395pMBJS/wRkVIsYQu9jhS9OV
 zYxLPJbsoZS8zDP4MgaTI25rpvH11dwdYNOlzLfqUVrOfXXMTdyVzVltrNNSexhfZHSC
 1zxMe43gk7dULe+sAscSuZtiIGDcsjqBxZpnKizrRuVTp+FyQip3cw82LoBHyik0RaSr
 Bc+aiOWBK6NllxeIgYk0L25IZkcP5j6qzHCzj2HF3VnQJEG5iVXXeoRNZAqtJ0pqbdRs
 kncQ==
X-Gm-Message-State: AOAM530/k+gVQsO/+Dzag1Hxwi9Jl1TSBhWtWABZxQCBX5399QasXJYs
 YKxabZ3FY+K0XQI29uR/z2kfVypFi7hstJocmcF5/g==
X-Google-Smtp-Source: ABdhPJwEMor42osEuSk1UZ2FnNZS/vcpuI9uXKIDxgV1q2FGoggt/IKFaagXtPhObqlqNzaaHAXkGaXNYoZps1VvbDQ=
X-Received: by 2002:a25:e6d5:0:b0:645:7257:8271 with SMTP id
 d204-20020a25e6d5000000b0064572578271mr6674251ybh.291.1650662252356; Fri, 22
 Apr 2022 14:17:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220421074204.1284072-1-hch@lst.de>
In-Reply-To: <20220421074204.1284072-1-hch@lst.de>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 22 Apr 2022 23:17:20 +0200
Message-ID: <CACRpkdbdKBfmXGdyTm3T-MFAK30N-z4KH0k8eD8F7xaYUbDDhA@mail.gmail.com>
Subject: Re: fully convert arm to use dma-direct
To: Christoph Hellwig <hch@lst.de>, Marc Zyngier <maz@kernel.org>
Cc: Arnd Bergmann <arnd@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Andre Przywara <andre.przywara@arm.com>,
 Gregory Clement <gregory.clement@bootlin.com>, linux-usb@vger.kernel.org,
 Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Alan Stern <stern@rowland.harvard.edu>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
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

On Thu, Apr 21, 2022 at 9:42 AM Christoph Hellwig <hch@lst.de> wrote:

> arm is the last platform not using the dma-direct code for directly
> mapped DMA.  With the dmaboune removal from Arnd we can easily switch
> arm to always use dma-direct now (it already does for LPAE configs
> and nommu).  I'd love to merge this series through the dma-mapping tree
> as it gives us the opportunity for additional core dma-mapping
> improvements.
(...)

>  b/arch/arm/mach-footbridge/Kconfig                   |    1
>  b/arch/arm/mach-footbridge/common.c                  |   19
>  b/arch/arm/mach-footbridge/include/mach/dma-direct.h |    8
>  b/arch/arm/mach-footbridge/include/mach/memory.h     |    4

I think Marc Z has a Netwinder that he can test this on. Marc?
I have one too, just not much in my office because of parental leave.

Yours,
Linus Walleij
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
