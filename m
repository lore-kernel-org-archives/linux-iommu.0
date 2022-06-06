Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAACDCCA481
	for <iommu@archiver.kernel.org>; Mon,  6 Jun 2022 15:02:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 45ED884075;
	Mon,  6 Jun 2022 15:02:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XI-seIp0sSHM; Mon,  6 Jun 2022 15:02:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D60BE84005;
	Mon,  6 Jun 2022 15:02:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A9E00C0039;
	Mon,  6 Jun 2022 15:02:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8F76EC002D
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jun 2022 15:02:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6F69360A68
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jun 2022 15:02:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id weUKufw_y1oG for <iommu@lists.linux-foundation.org>;
 Mon,  6 Jun 2022 15:02:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E89F3607E3
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jun 2022 15:02:03 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id A385C614C7
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jun 2022 15:02:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FA45C385A9
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jun 2022 15:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1654527722;
 bh=q53e8R7rif+9VorkencnO96O5zseGyAcQ5tiTh4wb5o=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=Apz8+ZKOfRfLg28N7czbQCp5u1APChOU6nUGQX9FaMmYF1sAaX/E+Ib6PkoNMTzP7
 8jDO0yt1/l7zDqKQc6tX4/clq/6HkX/3W3KZ8nM3wihQ+jMlDOK9ZA4eyqtiXknfW8
 nDehGJBGcME9NWhLnKjuKwi1RHsvWVfiUTSGjzwMBXLmNypEOY8dRiUMaB2ZPKhMqN
 +sCEMynb2DFl+FqYA+WAgVaik3iEnEQyHuNJCcowrCU57ufs9pWJIioY3E4DJJPNzW
 kpZWUqqFJEO2bKuHGgUG6lR6HDAoCyo7pL/NzPacNwyF3UCEA3Cxsbw6IvBn5Rr2+E
 lkYasSc/0weOA==
Received: by mail-yb1-f180.google.com with SMTP id t31so26187036ybi.2
 for <iommu@lists.linux-foundation.org>; Mon, 06 Jun 2022 08:02:02 -0700 (PDT)
X-Gm-Message-State: AOAM533+e+a8YmV4KgJkjfxQBoxK3XbEHBGu8VPeLR3+nnIqBIPWDTCt
 s5NaH0mx6XMIGULSRx2HKbLEMonkepftM5VhaH8=
X-Google-Smtp-Source: ABdhPJzbUSlIedBRNZiWpM9ElJ4TvjZNZhTiqJfwPbhlO6M7rgoOI9pHprJDL1o+SM/GSywwOf+ElbD7ZGPkUhXAozo=
X-Received: by 2002:a25:db8a:0:b0:65c:b04a:f612 with SMTP id
 g132-20020a25db8a000000b0065cb04af612mr24920915ybf.106.1654527721136; Mon, 06
 Jun 2022 08:02:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220606084109.4108188-1-arnd@kernel.org>
 <Yp3ID86TBFxl7qyL@kroah.com>
In-Reply-To: <Yp3ID86TBFxl7qyL@kroah.com>
From: Arnd Bergmann <arnd@kernel.org>
Date: Mon, 6 Jun 2022 17:01:44 +0200
X-Gmail-Original-Message-ID: <CAK8P3a15RuR3VOPLPV3SfdBAGuoyor6o7JMs3kC5dNB5nfDuKA@mail.gmail.com>
Message-ID: <CAK8P3a15RuR3VOPLPV3SfdBAGuoyor6o7JMs3kC5dNB5nfDuKA@mail.gmail.com>
Subject: Re: [PATCH 0/6] phase out CONFIG_VIRT_TO_BUS
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-arch <linux-arch@vger.kernel.org>,
 linux-scsi <linux-scsi@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Martyn Welch <martyn@welchs.me.uk>, Manohar Vanga <manohar.vanga@gmail.com>,
 linux-m68k <linux-m68k@lists.linux-m68k.org>,
 Denis Efremov <efremov@linux.com>, Christoph Hellwig <hch@infradead.org>,
 "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Parisc List <linux-parisc@vger.kernel.org>,
 alpha <linux-alpha@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Khalid Aziz <khalid@gonehiking.org>, Robin Murphy <robin.murphy@arm.com>
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

On Mon, Jun 6, 2022 at 11:25 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> I'll take patches 1 and 2 right now through my staging tree if that's
> ok.

Yes, that's perfect, as there are no actual interdependencies with the
other drivers -- applying the last patch first would just hide the driver
I'm removing here.

Thanks,

      Arnd
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
