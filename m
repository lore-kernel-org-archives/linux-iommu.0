Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2009C433EF
	for <iommu@archiver.kernel.org>; Thu, 21 Apr 2022 08:10:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 545784099A;
	Thu, 21 Apr 2022 08:10:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8p-rMWvhdmIh; Thu, 21 Apr 2022 08:10:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E005241C29;
	Thu, 21 Apr 2022 08:10:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A8720C002F;
	Thu, 21 Apr 2022 08:10:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 25316C002C
 for <iommu@lists.linux-foundation.org>; Thu, 21 Apr 2022 08:10:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 04FFA841A9
 for <iommu@lists.linux-foundation.org>; Thu, 21 Apr 2022 08:10:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id T__liOvcBd69 for <iommu@lists.linux-foundation.org>;
 Thu, 21 Apr 2022 08:10:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0F19084194
 for <iommu@lists.linux-foundation.org>; Thu, 21 Apr 2022 08:10:10 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by sin.source.kernel.org (Postfix) with ESMTPS id B727DCE210B
 for <iommu@lists.linux-foundation.org>; Thu, 21 Apr 2022 08:10:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08ED0C385AB
 for <iommu@lists.linux-foundation.org>; Thu, 21 Apr 2022 08:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1650528605;
 bh=/W8IliiCajYPso0oJDKeh6+LCmFpM9Iq4B+vqL+KHZ4=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=UtxzIvoNdabVELeWIz3V4TclK6xXmq9BMhzfujlm+gFWBoT8rY4aF9GfRX2ccT1vn
 wDcqT+y+x552llxpM0QL7xb0FLdoLZIo54LK520enQwUc0BbOcQrzNYQiwfY0jTUpi
 4qNX03YnasClaEAYsxgd8xc9OOZJfmG9mYcvjA+pDQdP70iw48miJ+2lz2WSgyuBbq
 tmIpimyZgrqkiOqSIOS0XySlX/JLBOUliDNfhAYHogz26OJgf2EClSsKjy3h8/tJZB
 X4KNgNCuxEid0pr34FAxb4UcPVrvYQRtv4HO3faFNFitLqqrQosV4+qH8YLlMGH9LJ
 cYb7+DzLwXx7g==
Received: by mail-wr1-f43.google.com with SMTP id t6so2068170wra.4
 for <iommu@lists.linux-foundation.org>; Thu, 21 Apr 2022 01:10:04 -0700 (PDT)
X-Gm-Message-State: AOAM53152P1ND7eIhACasjQgxDNxSqRJFekXER37Zq7hObFCe+uKKlV5
 kd2E1F4Ebf9Ewg26fIEdj12aqpOOLV/OwYhSq7c=
X-Google-Smtp-Source: ABdhPJw9RSqdGWpafgMW97qQu7yaTHgV5jKD56P0eBxUAQhkvQ6X95c920XjmeJj56kP8+QCXLYB93ISvku4scoF6r4=
X-Received: by 2002:a5d:6389:0:b0:207:a7d8:2b64 with SMTP id
 p9-20020a5d6389000000b00207a7d82b64mr18151004wru.12.1650528603264; Thu, 21
 Apr 2022 01:10:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220421074204.1284072-1-hch@lst.de>
 <20220421074204.1284072-8-hch@lst.de>
In-Reply-To: <20220421074204.1284072-8-hch@lst.de>
From: Arnd Bergmann <arnd@kernel.org>
Date: Thu, 21 Apr 2022 10:09:47 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3Y9F8Xb-uON8b+X5bUW9BeWkb6dBuXvdkhL4g15+7_uQ@mail.gmail.com>
Message-ID: <CAK8P3a3Y9F8Xb-uON8b+X5bUW9BeWkb6dBuXvdkhL4g15+7_uQ@mail.gmail.com>
Subject: Re: [PATCH 7/7] ARM: use dma-direct unconditionally
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
> Use dma-direct unconditionally on arm.  It has already been used for
> some time for LPAE and nommu configurations.
>
> This mostly changes the streaming mapping implementation and the (simple)
> coherent allocator for device that are DMA coherent.  The existing
> complex allocator for uncached mappings for non-coherent devices is still
> used as is using the arch_dma_alloc/arch_dma_free hooks.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/arm/Kconfig                   |   4 +-
>  arch/arm/include/asm/dma-mapping.h |  24 --
>  arch/arm/mach-highbank/highbank.c  |   2 +-
>  arch/arm/mach-mvebu/coherency.c    |   2 +-
>  arch/arm/mm/dma-mapping.c          | 365 ++---------------------------
>  5 files changed, 19 insertions(+), 378 deletions(-)
>  delete mode 100644 arch/arm/include/asm/dma-mapping.h

The diffstat looks really nice!

I can't really tell from looking at the code if this is an equivalent
conversion,
so I have to trust you on that. I did make sure this passes the basic tests
on kernelci.org, which tests a large number of machines, which is a good
sign.

Tested-by: Arnd Bergmann <arnd@arndb.de>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
