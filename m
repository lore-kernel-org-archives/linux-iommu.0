Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6503EC4332F
	for <iommu@archiver.kernel.org>; Thu, 21 Apr 2022 08:05:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 16C2F60C26;
	Thu, 21 Apr 2022 08:05:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fYFH6JWcQmPc; Thu, 21 Apr 2022 08:05:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id EB4E6607F4;
	Thu, 21 Apr 2022 08:05:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B41C1C0033;
	Thu, 21 Apr 2022 08:05:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4D5A3C002C
 for <iommu@lists.linux-foundation.org>; Thu, 21 Apr 2022 08:05:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3B3B683EB3
 for <iommu@lists.linux-foundation.org>; Thu, 21 Apr 2022 08:05:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nAAaoMux2s-p for <iommu@lists.linux-foundation.org>;
 Thu, 21 Apr 2022 08:05:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AD81783E9B
 for <iommu@lists.linux-foundation.org>; Thu, 21 Apr 2022 08:05:31 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id C728361BAD
 for <iommu@lists.linux-foundation.org>; Thu, 21 Apr 2022 08:05:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D39BC385B5
 for <iommu@lists.linux-foundation.org>; Thu, 21 Apr 2022 08:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1650528329;
 bh=pEk2DBnIt9rk2wabkGdOd9ccO0Sp1aN2SsNNj0MBRog=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=qWPM0VbCaFTCX7EfkRcA/rtW+syvpvauja9jw25voq6ipQfgeRSOI8QUgToJUNmSz
 OKn+BpJ7yAh+6LD2DtMs+LSIbUdCRp6H6euZbGvUFYkZwrKj22SIgqER2cZs6XltKG
 uftD/9TJgk67j0lF3y11+P7IMrq1mDd8xrKUB6u/Y9WwEa3rdBNgqUdZzQma0dy0CI
 790z77c82J7gC3xpwqTV0fFgHJcAa9+osqbFiqkFNA6wIBW3hjuispqAohUPdowc1D
 F0hBhNuydvq2NiVaV67w1yhkK86x6ydkV9tieQgzUuz+QBueVLbjesjV06o9inYPpk
 zk1SrHXiJ36Lg==
Received: by mail-wr1-f46.google.com with SMTP id m14so5490405wrb.6
 for <iommu@lists.linux-foundation.org>; Thu, 21 Apr 2022 01:05:29 -0700 (PDT)
X-Gm-Message-State: AOAM532XZxy4j0kpFRY5ALji80rB0mBiXMfJgPfNDmkbCt0HBTC2rsNX
 OHLZnDrsFsk7kiTYfmBD8dlFKa9HqJ/ruOdDm54=
X-Google-Smtp-Source: ABdhPJywpA6fOGw9KAZbIcns13/kEE7+YRmRr2P9g6saD61ZSVU9a6gQSpL63u+tG5iSukB8FNVqJ9kAQ9Wk1V6Tp0I=
X-Received: by 2002:adf:e106:0:b0:20a:b31b:213d with SMTP id
 t6-20020adfe106000000b0020ab31b213dmr3969063wrz.219.1650528327698; Thu, 21
 Apr 2022 01:05:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220421074204.1284072-1-hch@lst.de>
 <20220421074204.1284072-7-hch@lst.de>
In-Reply-To: <20220421074204.1284072-7-hch@lst.de>
From: Arnd Bergmann <arnd@kernel.org>
Date: Thu, 21 Apr 2022 10:05:11 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3BD5zLiXf=Wr0kcJp-k3+vmhBkEP5DNRw_-H=OX9CoGA@mail.gmail.com>
Message-ID: <CAK8P3a3BD5zLiXf=Wr0kcJp-k3+vmhBkEP5DNRw_-H=OX9CoGA@mail.gmail.com>
Subject: Re: [PATCH 6/7] ARM: use the common dma_to_phys/phys_to_dma
 implementation where possible
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
> Only the footbridge platforms provide their own DMA address translation
> helpers, so switch to the generic version for all other platforms, and
> consolidate the footbridge implementation to remove two levels of
> indirection.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

> ---
> @@ -335,17 +336,19 @@ unsigned long __bus_to_virt(unsigned long res)
>         return res;
>  }
>  EXPORT_SYMBOL(__bus_to_virt);
> -
> -unsigned long __pfn_to_bus(unsigned long pfn)
> +#else
> +static inline unsigned long fb_bus_sdram_offset(void)
>  {
> -       return __pfn_to_phys(pfn) + (fb_bus_sdram_offset() - PHYS_OFFSET);
> +       return BUS_OFFSET;
>  }
> -EXPORT_SYMBOL(__pfn_to_bus);
> +#endif /* CONFIG_FOOTBRIDGE_ADDIN */

I have an older patch to remove CONFIG_FOOTBRIDGE_ADDIN
completely, as it does a couple of other nasty things and there are
apparently no users. Would that help here?

       Arnd
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
