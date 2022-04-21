Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69781C433EF
	for <iommu@archiver.kernel.org>; Thu, 21 Apr 2022 07:50:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2228E82ED2;
	Thu, 21 Apr 2022 07:50:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SsN3A39NnYgk; Thu, 21 Apr 2022 07:50:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 081C282DD9;
	Thu, 21 Apr 2022 07:50:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CB736C0033;
	Thu, 21 Apr 2022 07:50:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D64F3C002C
 for <iommu@lists.linux-foundation.org>; Thu, 21 Apr 2022 07:50:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C463060C26
 for <iommu@lists.linux-foundation.org>; Thu, 21 Apr 2022 07:50:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tIKko5yc4Gej for <iommu@lists.linux-foundation.org>;
 Thu, 21 Apr 2022 07:50:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 40D3E60C22
 for <iommu@lists.linux-foundation.org>; Thu, 21 Apr 2022 07:50:12 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 13BC561B7C
 for <iommu@lists.linux-foundation.org>; Thu, 21 Apr 2022 07:50:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CF7BC385AB
 for <iommu@lists.linux-foundation.org>; Thu, 21 Apr 2022 07:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1650527410;
 bh=scrBCeJL1OsZjxal/hOOJR8xrKpdhNNc3BiRG6d2EkQ=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=I53ZD6Ob3R8QcG8tmbBFOshAoeh0KWTCN+0xytPix2nry7uRQ548WOA6mgeTA8b60
 xqcd8bPRZq0d9NGREbKcENA/6rrZ++7viLpgU63REWPzgO8q9prVkcA/bzV7MqTM58
 sUmxO6IoWO0a7H1x5VJkkaFc4lpZjiYA6noI7uY3mGaa0VeH955HVnMBGSpEbC8CAP
 RSs7zWjx/m1FtilWmdqSWcPG8debp7PnluxDXjtK3iWbHqmoQNSc7t0ehoBzQTENv0
 9QatR/d4pEc4EkMNyUjBndFN83NNoQCS6otBb5tlBjEwZo7+fypytHRD8fIwU/Q/4/
 PgYcCLLU9pZKg==
Received: by mail-wr1-f54.google.com with SMTP id m14so5435747wrb.6
 for <iommu@lists.linux-foundation.org>; Thu, 21 Apr 2022 00:50:10 -0700 (PDT)
X-Gm-Message-State: AOAM532M/S5cc3jAhE94J9MpFBC1p+i6jWXZQ9eR3xH+HcvrHbEO57VV
 HhY6oZWEVgsHXa+/OXNmfrOdGu1CIQ1tkvaMoxo=
X-Google-Smtp-Source: ABdhPJzRVJ/OmeGnrqJE761/+0TPqsFFrrS+icRdgf4Xe42e9Mrpm76xuvHw8bwt5K0xWAFGMv08ylmpsjeKAOckTf8=
X-Received: by 2002:adf:e106:0:b0:20a:b31b:213d with SMTP id
 t6-20020adfe106000000b0020ab31b213dmr3918734wrz.219.1650527408610; Thu, 21
 Apr 2022 00:50:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220421074204.1284072-1-hch@lst.de>
 <20220421074204.1284072-4-hch@lst.de>
In-Reply-To: <20220421074204.1284072-4-hch@lst.de>
From: Arnd Bergmann <arnd@kernel.org>
Date: Thu, 21 Apr 2022 09:49:52 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2Mv++CCGf2BuC-wS4VGb+ZhfnJqVwJkK-VcYAqfiPi8A@mail.gmail.com>
Message-ID: <CAK8P3a2Mv++CCGf2BuC-wS4VGb+ZhfnJqVwJkK-VcYAqfiPi8A@mail.gmail.com>
Subject: Re: [PATCH 3/7] ARM: mark various dma-mapping routines static in
 dma-mapping.c
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
> With the dmabounce removal these aren't used outside of dma-mapping.c,
> so mark them static.  Move the dma_map_ops declarations down a bit
> to avoid lots of forward declarations.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
