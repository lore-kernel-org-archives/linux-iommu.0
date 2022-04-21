Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4473BC433FE
	for <iommu@archiver.kernel.org>; Thu, 21 Apr 2022 07:49:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D310B402B1;
	Thu, 21 Apr 2022 07:49:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id I6JJQsj9UeAI; Thu, 21 Apr 2022 07:49:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B73AB400E5;
	Thu, 21 Apr 2022 07:49:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8A9DEC0033;
	Thu, 21 Apr 2022 07:49:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 32407C002C
 for <iommu@lists.linux-foundation.org>; Thu, 21 Apr 2022 07:49:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 18DF341BA5
 for <iommu@lists.linux-foundation.org>; Thu, 21 Apr 2022 07:49:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id S00dKrE7mnHz for <iommu@lists.linux-foundation.org>;
 Thu, 21 Apr 2022 07:49:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 30A6241B92
 for <iommu@lists.linux-foundation.org>; Thu, 21 Apr 2022 07:49:12 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 6F234B822B6
 for <iommu@lists.linux-foundation.org>; Thu, 21 Apr 2022 07:49:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41949C385A9
 for <iommu@lists.linux-foundation.org>; Thu, 21 Apr 2022 07:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1650527348;
 bh=XtL+3anNJRhWOAUuNxErGEglp2qD/anNUiavImUZHSc=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=SI6N8MLwQTi/OcfLRqaIbOWpLPAMJQBKpjNIHGCtcKl3DD8PVnvMmhsDEUqlR1Lus
 ijmWsDNl11yvTWQOraEUxNHvcWKVb4GNEdT6Fw4raqIHKf0XZ77g0qaxDXG+JYfL7R
 Zg14HRoH4ZDpkFTKy04n1nNnBFsC0Psbkg+f0gdN5ivSizLqRI8i0jeHcBClfgE37Z
 mdl7box1eAQsd9gasTSzXmLPf+orNsh5zt9ZG2F88V6PwHFZ+8nrtdMFNcK3zn9Q0M
 xP1k1BUiPOPifBGUY0w4JZuxYZsVDYgYaD1UzL9Y7+Qqa8uqZET7wW7fl7gSdMScYk
 LXF79XdsCh00A==
Received: by mail-wm1-f43.google.com with SMTP id
 c190-20020a1c35c7000000b0038e37907b5bso5306076wma.0
 for <iommu@lists.linux-foundation.org>; Thu, 21 Apr 2022 00:49:08 -0700 (PDT)
X-Gm-Message-State: AOAM5330/aqLuduL9T64bqqPR8dYlV6owcIJoEIIx1LpGXFMA1Dp+gQ9
 8FF1vDiRM4tMTuuAZvsjJ/y0Mi0OGm+06Ecqrnw=
X-Google-Smtp-Source: ABdhPJypuC7jbZN67qXyjmmFNWvxuABrK2IojedrMlrL5Yqv356sc3UpIArFOPSqMrdEiOwiEgmPKU7mdySJIdIBwDI=
X-Received: by 2002:a05:600c:4e4a:b0:392:88e1:74a7 with SMTP id
 e10-20020a05600c4e4a00b0039288e174a7mr7345266wmq.174.1650527346456; Thu, 21
 Apr 2022 00:49:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220421074204.1284072-1-hch@lst.de>
 <20220421074204.1284072-3-hch@lst.de>
In-Reply-To: <20220421074204.1284072-3-hch@lst.de>
From: Arnd Bergmann <arnd@kernel.org>
Date: Thu, 21 Apr 2022 09:48:50 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3Y-z+FQWbZo+r_-SGa5D0oJJbKH-YQkk73uG+TOOUKKg@mail.gmail.com>
Message-ID: <CAK8P3a3Y-z+FQWbZo+r_-SGa5D0oJJbKH-YQkk73uG+TOOUKKg@mail.gmail.com>
Subject: Re: [PATCH 2/7] ARM: remove dmabounce
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
> Remove the now unused dmabounce code.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
