Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C05BC433F5
	for <iommu@archiver.kernel.org>; Mon,  2 May 2022 19:22:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BAD038266A;
	Mon,  2 May 2022 19:22:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id v4jtabQ8iHbx; Mon,  2 May 2022 19:22:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id AB46581C38;
	Mon,  2 May 2022 19:22:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6AB78C0032;
	Mon,  2 May 2022 19:22:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 71065C002D
 for <iommu@lists.linux-foundation.org>; Mon,  2 May 2022 19:22:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4FDC7408D1
 for <iommu@lists.linux-foundation.org>; Mon,  2 May 2022 19:22:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cN5i4IDEbDKS for <iommu@lists.linux-foundation.org>;
 Mon,  2 May 2022 19:22:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A4E3240133
 for <iommu@lists.linux-foundation.org>; Mon,  2 May 2022 19:22:08 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id D60CBB819EF
 for <iommu@lists.linux-foundation.org>; Mon,  2 May 2022 19:22:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90E85C385B3
 for <iommu@lists.linux-foundation.org>; Mon,  2 May 2022 19:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1651519324;
 bh=0aG9zi/eAzvshX4pChfzjtI5FyTMCAi0+HUAcCHP7jM=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=FNh9+lraT0Fyzxuk6PsRFMVdYRljF/irwK3mBNIIIrg4SIsAn4ceziEF6s0PMYJMY
 4KFW2+g1hP10yCZHT5A/v1CUXtFTbqJL7jezx1SAb37JLMLH+Ogrg5LrOC5xIYS3tZ
 FGL+0GWtShgxCALi1KMJaxSS3r1R0LQwlEQEtgmH72Yf3FUrEFdbTBA43w4SuVPtee
 0qKMoBmIRzx98G1fU9OsKqVaoEboOZfjePoddAWH6Iw/3PqhbPBjAYYKbnjIpnCsBr
 xtAZ3R1IjVY8cflDeLBTmSFlHqthVAjbypEj817GYf2pUncnZ7SToXVa4T243yvl2v
 uZEg1jeSHzn9g==
Received: by mail-yb1-f173.google.com with SMTP id g28so27677914ybj.10
 for <iommu@lists.linux-foundation.org>; Mon, 02 May 2022 12:22:04 -0700 (PDT)
X-Gm-Message-State: AOAM5333GLc3wIR6UBmnhPUxzZPxICHYkhVfURyT177GAv0hOTz4bVOX
 DEob2LgzljFib1AL2SKb1MW7/m11OAt8amKzT/E=
X-Google-Smtp-Source: ABdhPJyNocrkocyw/Rl1W7raRpoFO7LtpbwSGKzdnLpoapTUgqvZ2HvsJmPGgyMH50BFkSJO7u5VKl2ISlcAeK2ibaQ=
X-Received: by 2002:a25:cdc7:0:b0:648:f57d:c0ed with SMTP id
 d190-20020a25cdc7000000b00648f57dc0edmr11240069ybf.480.1651519323588; Mon, 02
 May 2022 12:22:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220502164330.229685-1-hch@lst.de>
 <20220502164330.229685-5-hch@lst.de>
In-Reply-To: <20220502164330.229685-5-hch@lst.de>
From: Arnd Bergmann <arnd@kernel.org>
Date: Mon, 2 May 2022 21:21:47 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2MCVYz9LF7dKR=qt4OddhZMyYVk2UGWeF62QzJ9OADHg@mail.gmail.com>
Message-ID: <CAK8P3a2MCVYz9LF7dKR=qt4OddhZMyYVk2UGWeF62QzJ9OADHg@mail.gmail.com>
Subject: Re: [PATCH 04/10] ARM/dma-mapping: remove the unused virt_to_dma
 helper
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

On Mon, May 2, 2022 at 6:43 PM Christoph Hellwig <hch@lst.de> wrote:
>
> virt_to_dma was only used by the now removed dmabounce code.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
