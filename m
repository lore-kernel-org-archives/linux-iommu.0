Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F658C433F5
	for <iommu@archiver.kernel.org>; Thu, 21 Apr 2022 08:14:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1667560B32;
	Thu, 21 Apr 2022 08:14:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tgFEmBgmK1ZD; Thu, 21 Apr 2022 08:14:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 04E16607F4;
	Thu, 21 Apr 2022 08:14:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CD9A2C002F;
	Thu, 21 Apr 2022 08:14:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7920CC002C
 for <iommu@lists.linux-foundation.org>; Thu, 21 Apr 2022 08:14:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6339A60B32
 for <iommu@lists.linux-foundation.org>; Thu, 21 Apr 2022 08:14:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kaP24Azwk3Sg for <iommu@lists.linux-foundation.org>;
 Thu, 21 Apr 2022 08:14:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A0446607F4
 for <iommu@lists.linux-foundation.org>; Thu, 21 Apr 2022 08:14:38 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by sin.source.kernel.org (Postfix) with ESMTPS id 5EC97CE0FD5
 for <iommu@lists.linux-foundation.org>; Thu, 21 Apr 2022 08:14:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF4A5C385AE
 for <iommu@lists.linux-foundation.org>; Thu, 21 Apr 2022 08:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1650528873;
 bh=qvOB0ikvcyf8yw1Oo7pNju5ahvdIUh+2Ix9pkj27y0Y=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=C8/36XvBwLlf/tCkvKdfxh2dlEfTwb3EENcYUs7KzlM9ndwHlgIvwLRtufU1yCfZA
 KYdJoOqqjcf9N6DXfaXdlsuqzcCkvpmJtduGtJ7I8h4CSVYQbm6k17H7d//HzRl1xT
 +iLV4x1sM5NxUm9HVTj4ysVMwzaZfVw/fvd6ju1sh2mrdEOi/o/+H0T6JRE/MDevo2
 R/mw1ENGqiMBVG71qRJyYQ2KhyHdxQyK+pHv+IZH9LJSr426ea/y1UGGoPMWSecBQI
 FIslay2JFfL+IFTCjL3SnfnfcRPlyyTQGhbaubsdobe5Qzj75cwt2eYys8zsmNhZKf
 2YEu9sdnJHjVg==
Received: by mail-wr1-f41.google.com with SMTP id bv16so5492399wrb.9
 for <iommu@lists.linux-foundation.org>; Thu, 21 Apr 2022 01:14:33 -0700 (PDT)
X-Gm-Message-State: AOAM530kgJVANl0u8FTisMyLR9wX2ofdOxhVML5B/lWeFd7mBybqQ697
 /qbYDfG12DRwXiHZH3ZcGSMsX+2ButkTiMHKd0Y=
X-Google-Smtp-Source: ABdhPJwmmO+oW480q+9P9XgUMSnyEpeIXZk6a3NVVRJyO7eKIgGvUhnLJsU5orqLkWv0a3+Q7VPZ8SMJsIerFHk4Q8s=
X-Received: by 2002:a5d:64a3:0:b0:20a:7931:5b84 with SMTP id
 m3-20020a5d64a3000000b0020a79315b84mr19205164wrp.407.1650528872088; Thu, 21
 Apr 2022 01:14:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220421074204.1284072-1-hch@lst.de>
In-Reply-To: <20220421074204.1284072-1-hch@lst.de>
From: Arnd Bergmann <arnd@kernel.org>
Date: Thu, 21 Apr 2022 10:14:16 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0mrbawriAE28pkFvdmMQKy3BUR72RtKiVwbEUNLxhx=Q@mail.gmail.com>
Message-ID: <CAK8P3a0mrbawriAE28pkFvdmMQKy3BUR72RtKiVwbEUNLxhx=Q@mail.gmail.com>
Subject: Re: fully convert arm to use dma-direct
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

On Thu, Apr 21, 2022 at 9:41 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Hi all,
>
> arm is the last platform not using the dma-direct code for directly
> mapped DMA.  With the dmaboune removal from Arnd we can easily switch
> arm to always use dma-direct now (it already does for LPAE configs
> and nommu).  I'd love to merge this series through the dma-mapping tree
> as it gives us the opportunity for additional core dma-mapping
> improvements.

Thanks a lot for completing this, it looks all good to me, and I hope that
Russell can test my assabet patch to make sure this doesn't break
anything.

I saw one opportunity for an additional cleanup patch that I commented
on, but that does not stop the rest from getting merged.

I also made sure that this passes the basic kernelci tests across all
arm machines.

     Arnd
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
