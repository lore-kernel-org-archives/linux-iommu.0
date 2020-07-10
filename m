Return-Path: <SRS0=wTTv=AV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BF03C433E1
	for <iommu@archiver.kernel.org>; Fri, 10 Jul 2020 02:03:56 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 438B920708
	for <iommu@archiver.kernel.org>; Fri, 10 Jul 2020 02:03:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 438B920708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 191ED88641;
	Fri, 10 Jul 2020 02:03:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xFc4q18Ut1-2; Fri, 10 Jul 2020 02:03:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 300FD88634;
	Fri, 10 Jul 2020 02:03:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1FDD9C077B;
	Fri, 10 Jul 2020 02:03:55 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E8335C016F
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jul 2020 02:03:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id DD3D889A55
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jul 2020 02:03:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id N2q2GJDmuVsO for <iommu@lists.linux-foundation.org>;
 Fri, 10 Jul 2020 02:03:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by hemlock.osuosl.org (Postfix) with ESMTPS id D64F689A4F
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jul 2020 02:03:52 +0000 (UTC)
Received: from mail-ot1-f71.google.com ([209.85.210.71])
 by youngberry.canonical.com with esmtps
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <koba.ko@canonical.com>) id 1jtiOE-0001KM-Fw
 for iommu@lists.linux-foundation.org; Fri, 10 Jul 2020 02:03:50 +0000
Received: by mail-ot1-f71.google.com with SMTP id b22so2447284otp.2
 for <iommu@lists.linux-foundation.org>; Thu, 09 Jul 2020 19:03:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=SQxlxH8w1XRv/PIUz5GYKxBrNAiYJPuPTh1GdFkqGIs=;
 b=ZSCdTA28VzbidnnAdMMj3Cb74me81+DbVFvfB2eateQ8YBCwYia49yMzcPE09qZpE1
 Bz7cK26wJfDy0Xl1JmWlGk2g2SQf6LUYXKpOUvIlNtsCYFNMGRKJR4ZPAtf9QBLMBpOU
 3rfaBGTafTLYPfk9TcgETcgTcUnTfBbXgHvV+wOH9CFr3FxRQXZM5GYw/G/uSq5FdBfj
 RBbceiXwRDvOF2lfTiQZrc6QQvZyfy0rLGNyRtSHUm+ISnxZROgNDuHjZnIvjBz55Cu8
 M6lfpZAyPbQSa8XawxLMJ+NZmeGbOyofYO+QOQDj4XmolYi09MoyL2cmKz79P2KAKrB2
 ijsg==
X-Gm-Message-State: AOAM533F8mXIZ9NQYxSTsNXO1vpIDndHy9fjfz/TpZwows1nVAhP5pX5
 eicycPV2spKzJ7+S3LK/zaP6vG0vUmhzoOYgW9i3zn/WSgd6qeebQfa7hmQFEu6/V5x/RGFmXES
 vlzZFWmY0JzB+PXDI3mcVt6WAg14VG0mnfs6nYe5jXyvVZO7D/1u4anhmpwXkOfA=
X-Received: by 2002:aca:53cc:: with SMTP id h195mr2497091oib.49.1594346629493; 
 Thu, 09 Jul 2020 19:03:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz90EXEBZzxChOGSMn3vAPnhPKqsDehoEfZ24XLl6I6F50PLmaY8HIRbNnEjkQ9CdqtwnBSbeAYwTS32c6cGEs=
X-Received: by 2002:aca:53cc:: with SMTP id h195mr2497064oib.49.1594346629211; 
 Thu, 09 Jul 2020 19:03:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAJB-X+VcHvYWngtMVHw5f_XaqA4i4T61yt=h7YvuD=eo3y7Rog@mail.gmail.com>
 <DM6PR19MB2636E5A28FB655C2F657FDF8FA640@DM6PR19MB2636.namprd19.prod.outlook.com>
In-Reply-To: <DM6PR19MB2636E5A28FB655C2F657FDF8FA640@DM6PR19MB2636.namprd19.prod.outlook.com>
From: Koba Ko <koba.ko@canonical.com>
Date: Fri, 10 Jul 2020 10:03:38 +0800
Message-ID: <CAJB-X+UJx+xTJ05snD9xuf7N-ofvTk3ddeSTtNfrGZ738SRvYg@mail.gmail.com>
Subject: Re: [Issue]platform/x86: iommu: System can't shutdown because iommu
 driver keeps checking the status of DMA_GSTS_TES
To: "Limonciello, Mario" <Mario.Limonciello@dell.com>
Cc: Christian Kellner <ckellner@redhat.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Anthony Wong <anthony.wong@canonical.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Kai Heng Feng <kai.heng.feng@canonical.com>,
 David Woodhouse <dwmw2@infradead.org>
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

Hi Mario
On Fri, Jul 10, 2020 at 4:58 AM Limonciello, Mario
<Mario.Limonciello@dell.com> wrote:
>
> > -----Original Message-----
> > From: iommu <iommu-bounces@lists.linux-foundation.org> On Behalf Of Koba Ko
> > Sent: Sunday, June 14, 2020 10:47 PM
> > To: David Woodhouse; Lu Baolu; Joerg Roedel
> > Cc: iommu@lists.linux-foundation.org; Kai Heng Feng; Linux Kernel Mailing
> > List
> > Subject: [Issue]platform/x86: iommu: System can't shutdown because iommu
> > driver keeps checking the status of DMA_GSTS_TES
> >
> > hi All,
> > I have a machine and there's only intel gpu.
> > the secureboot and vt-d is enabled in BIOS.
> > On the Ubuntu desktop, I do s2idle first and restart the machine.
> > The machine can't restart successfully, so I need to press the power
> > button to shutdown.
> > I tried  each of the following and the issue can't be triggered.
> > 1. disable secure boot in BIOS.
>
> Just to explain why this happens, on many of Dell's systems VT-d is only enabled
> when secure boot is enabled.
>
> > 2. intel_iommu=off.
> > 3. intel_iomm=igfx_off.
> > 4. nomodeset
> > 5. i915.modeset=0.
> >
> > After I investigate further, find inte_iommu keeps checking the status
> > of DMA_GSTS_TES.
> > During the procedure of restart, the driver would disable iommu translation
> > and
> > check the status of DMA_GSTS_TES until status of DMA_GSTS_TES is 0.
> >
> > If you need more information, I can provide it.
> >
> > Thanks
> > Koba Ko
> > _______________________________________________
> > iommu mailing list
> > iommu@lists.linux-foundation.org
> > https://lists.linuxfoundation.org/mailman/listinfo/iommu
>
> This is reported on TGL pre-production system, but actually same symptom is also
> happening in ICL production systems such as XPS 7390 2-in-1 and XPS 9300.
>
> Details for the ICL issue are available here:
> https://bugzilla.kernel.org/show_bug.cgi?id=206571
>
> A user did bisect it back to commit 6c3a44ed3c553c324845744f30bcd1d3b07d61fd in
> 5.5.  Glancing through the code and comparing the suspend case, I would ask is it
> just a case of missing a flush at shutdown (IE iommu_flush_all)?
>
If dma translation doesn't be disabled during shutdown, the machine
would be powered off successfully.
I have tried to flush before disabled and this can't affect the result
of the issue.

koba ko
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
