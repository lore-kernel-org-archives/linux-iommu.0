Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 935CAC43334
	for <iommu@archiver.kernel.org>; Wed,  8 Jun 2022 08:20:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5912040B84;
	Wed,  8 Jun 2022 08:20:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6xv_rbPuPNat; Wed,  8 Jun 2022 08:20:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 43A7E40B79;
	Wed,  8 Jun 2022 08:20:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1DFEBC0039;
	Wed,  8 Jun 2022 08:20:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8F8D8C002D
 for <iommu@lists.linux-foundation.org>; Wed,  8 Jun 2022 08:20:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6CE3F41A05
 for <iommu@lists.linux-foundation.org>; Wed,  8 Jun 2022 08:20:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GTKLWEofTVCR for <iommu@lists.linux-foundation.org>;
 Wed,  8 Jun 2022 08:20:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 124094191D
 for <iommu@lists.linux-foundation.org>; Wed,  8 Jun 2022 08:20:06 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id E207DB825FF
 for <iommu@lists.linux-foundation.org>; Wed,  8 Jun 2022 08:20:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1F2DC341C4
 for <iommu@lists.linux-foundation.org>; Wed,  8 Jun 2022 08:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1654676402;
 bh=rDMX5BalcedoM4G0RTFNbUxPOQoghsgu/8OBAke+GR0=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=W/h6WxvlBEsPXQ7LLxZr5QO/u8vafOvVrOKwRNodyKrcwdtYx8uewJ8cCA65YcEMg
 alacQ3aEaCFnYucv14vBpxrln7eE0w+IUl9Ml0Q/7LYCRVNvGSHDuVNBRGtIoi0BHD
 Qr5ufM1dsDnPItR2irIQVGVoxerv51UkVHYmpLW+0WsyY7wVvJ+J6YNWoxtfegtWYz
 FamoyOjC7VQXl4xIUHow5CF1p1P7Wxh0bzVc5DDARXrzB/D9DtH7DJLq2uy7QMFIxO
 8gV+qq78/NW5yn20jf56zStPrE0wosJLKD6MRBsnwDN5kNQhLX1HrDNepJvQufi2cH
 3p2+fMos1M1jw==
Received: by mail-yb1-f173.google.com with SMTP id y188so5763448ybe.11
 for <iommu@lists.linux-foundation.org>; Wed, 08 Jun 2022 01:20:02 -0700 (PDT)
X-Gm-Message-State: AOAM530+ATBiQueJEuvo5nGzIihUp90nZBe48KRrC65xpu8wjFULxFEc
 HJz039Wn0JyPb+XHQAzi+69FPZm3Q3/4CyltEtE=
X-Google-Smtp-Source: ABdhPJw5adnNWBE7ztmmPDIsnyIjJmMrgIr8fa8e/0DIxEnxDLg4p0rx65KL8vLCz2hbQ8e4xmPnl5Ru880ilknwmmg=
X-Received: by 2002:a25:d6d7:0:b0:663:efa3:3fd2 with SMTP id
 n206-20020a25d6d7000000b00663efa33fd2mr4459955ybg.480.1654676401784; Wed, 08
 Jun 2022 01:20:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220606084109.4108188-1-arnd@kernel.org>
 <20220606084109.4108188-6-arnd@kernel.org>
 <d39fc9bb-07c1-ad74-1e89-d2aa80578cd4@gonehiking.org>
In-Reply-To: <d39fc9bb-07c1-ad74-1e89-d2aa80578cd4@gonehiking.org>
From: Arnd Bergmann <arnd@kernel.org>
Date: Wed, 8 Jun 2022 10:19:44 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3dfTNS4m-SVa1UH+ncT7ZOcMBRaEc7TiO9R19J3KNSxg@mail.gmail.com>
Message-ID: <CAK8P3a3dfTNS4m-SVa1UH+ncT7ZOcMBRaEc7TiO9R19J3KNSxg@mail.gmail.com>
Subject: Re: [PATCH 5/6] scsi: remove stale BusLogic driver
To: Khalid Aziz <khalid@gonehiking.org>
Cc: linux-arch <linux-arch@vger.kernel.org>,
 linux-scsi <linux-scsi@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 linux-m68k <linux-m68k@lists.linux-m68k.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Martyn Welch <martyn@welchs.me.uk>, Manohar Vanga <manohar.vanga@gmail.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Denis Efremov <efremov@linux.com>, Christoph Hellwig <hch@infradead.org>,
 "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Matt Wang <wwentao@vmware.com>, Parisc List <linux-parisc@vger.kernel.org>,
 alpha <linux-alpha@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 "Maciej W . Rozycki" <macro@orcam.me.uk>, Robin Murphy <robin.murphy@arm.com>
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

On Mon, Jun 6, 2022 at 6:35 PM Khalid Aziz <khalid@gonehiking.org> wrote:
> On 6/6/22 02:41, Arnd Bergmann wrote: From: Arnd Bergmann<arnd@arndb.de>
>
> I would say no to removing BusLogic driver. Virtualbox is another
> consumer of this driver. This driver is very old but I would rather fix
> the issues than remove it until we do not have any users.

Maciej already offered to help fix the driver, so I think it will be ok.

On the other hand, it sounds like VirtualBox users should not actually try to
use the BusLogic driver with modern Linux guests. From what I can tell
from the documentation [1], VirtualBox only provides this emulation because it
was shipped with early versions of VMware and is supported by Windows 2000
and earlier, but not actually on any modern Windows guest. The VMware
documentation in turn explicitly says that BusLogic does not work with 64-bit
guests [2], presumably this applies to both Windows and Linux guests.

        Arnd

[1] https://www.virtualbox.org/manual/ch05.html#harddiskcontrollers
[2] https://kb.vmware.com/s/article/2010470
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
