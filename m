Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6194CC433F5
	for <iommu@archiver.kernel.org>; Thu, 21 Apr 2022 08:01:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1A79A408EC;
	Thu, 21 Apr 2022 08:01:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ePUvWB4z6SRH; Thu, 21 Apr 2022 08:01:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D4118408F1;
	Thu, 21 Apr 2022 08:01:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A34A8C0033;
	Thu, 21 Apr 2022 08:01:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E35D5C002C
 for <iommu@lists.linux-foundation.org>; Thu, 21 Apr 2022 08:01:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D0B184018D
 for <iommu@lists.linux-foundation.org>; Thu, 21 Apr 2022 08:01:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QPYHS1fHekzK for <iommu@lists.linux-foundation.org>;
 Thu, 21 Apr 2022 08:01:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 27DC9400E5
 for <iommu@lists.linux-foundation.org>; Thu, 21 Apr 2022 08:01:15 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 6BD2CB822BA
 for <iommu@lists.linux-foundation.org>; Thu, 21 Apr 2022 08:01:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19769C385A9
 for <iommu@lists.linux-foundation.org>; Thu, 21 Apr 2022 08:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1650528073;
 bh=ifEFSZv1UM5fIRCyiaGc43+OrGh0I0CVrDw1Pe824tk=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=Jxw9n3090AL4dD2aIROf5ZASfrb4qGnMntHn9OV0MR3E9rF8iS1w32M8y0P+QTcQB
 f8BJooistAMxQF1cKz6Xn8LnCNe5de8pFPCR2vro3T9tVXXcTHTSuO+o6QvnooXcCy
 e07OjhCpum5gCdaLxthe0DzzgxJlv3WJHKinRs5rQTvVXPndDQiS2Q7r5qlxrMnSZk
 7mVLL6AT8WNyDR10Aj9stFSpOIP1GHwnoTZS+ZJK2cPkljol0G9qi9JKM1ufXjjXPp
 gilVv7PAj5XWmpwXB8kTWVl9OZyxhM8EbxZ27wzwbyb4wKnqArq5ti9OGnuiWd9fTY
 EJpYiYBngAQfA==
Received: by mail-wm1-f52.google.com with SMTP id
 n40-20020a05600c3ba800b0038ff1939b16so2825401wms.2
 for <iommu@lists.linux-foundation.org>; Thu, 21 Apr 2022 01:01:12 -0700 (PDT)
X-Gm-Message-State: AOAM532lpF6B5RKXLeVGY9+yNnTKbcowW2B+Sb5gfCdlFjT0CsmsPfFy
 LtLz8EX+Mvv3Roenztm7f9OIyGFPX8iyNvSAy1k=
X-Google-Smtp-Source: ABdhPJzqgi7L5ALaCLdUcSpoT2Nq18aUkuxmUof0UjJFR0/s3eAKaJPqD7JeGsY3967XuokcLCyC0mVbOg8OIiR57g4=
X-Received: by 2002:a1c:f219:0:b0:38c:782c:3bb with SMTP id
 s25-20020a1cf219000000b0038c782c03bbmr7185525wmc.94.1650528071363; Thu, 21
 Apr 2022 01:01:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220421074204.1284072-1-hch@lst.de>
 <20220421074204.1284072-5-hch@lst.de>
In-Reply-To: <20220421074204.1284072-5-hch@lst.de>
From: Arnd Bergmann <arnd@kernel.org>
Date: Thu, 21 Apr 2022 10:00:55 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2zSZsiq_FFHJMHex6uLc_7sUfvns8W8-mE52yzxOqhKw@mail.gmail.com>
Message-ID: <CAK8P3a2zSZsiq_FFHJMHex6uLc_7sUfvns8W8-mE52yzxOqhKw@mail.gmail.com>
Subject: Re: [PATCH 4/7] ARM: remove the unused virt_to_dma helper
To: Christoph Hellwig <hch@lst.de>
Cc: Andrew Lunn <andrew@lunn.ch>, Andre Przywara <andre.przywara@arm.com>,
 Linus Walleij <linus.walleij@linaro.org>, USB list <linux-usb@vger.kernel.org>,
 Russell King <linux@armlinux.org.uk>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Alan Stern <stern@rowland.harvard.edu>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Gregory Clement <gregory.clement@bootlin.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
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
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

I generally prefer to have at least something useful in the description, e.g.
why it's now unused and what it was used for before.

> -static inline dma_addr_t virt_to_dma(struct device *dev, void *addr)
> -{
> -       if (dev)
> -               return pfn_to_dma(dev, virt_to_pfn(addr));
> -
> -       return (dma_addr_t)__virt_to_bus((unsigned long)(addr));
> -}

I think __virt_to_bus() is now unused as well and could be removed
in the same step.

It looks like __bus_to_virt() is still used in the ISA DMA API, but
as that is only used on footbridge and rpc, the generic version of
that could be moved into rpc (footbridge already has a custom
version).

    Arnd
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
