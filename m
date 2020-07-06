Return-Path: <SRS0=S+y3=AR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F6A2C433E2
	for <iommu@archiver.kernel.org>; Mon,  6 Jul 2020 22:19:05 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C36D20720
	for <iommu@archiver.kernel.org>; Mon,  6 Jul 2020 22:19:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="KUh+nyqn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C36D20720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 29DD08950B;
	Mon,  6 Jul 2020 22:19:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tuAaYJHgH30P; Mon,  6 Jul 2020 22:19:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 1F98A8947D;
	Mon,  6 Jul 2020 22:19:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 09ECCC0891;
	Mon,  6 Jul 2020 22:19:04 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 774BDC016F
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jul 2020 22:19:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 621FD86F6A
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jul 2020 22:19:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id caWiVAInsT3u for <iommu@lists.linux-foundation.org>;
 Mon,  6 Jul 2020 22:19:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lj1-f193.google.com (mail-lj1-f193.google.com
 [209.85.208.193])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 4E63886F69
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jul 2020 22:19:02 +0000 (UTC)
Received: by mail-lj1-f193.google.com with SMTP id e4so47534157ljn.4
 for <iommu@lists.linux-foundation.org>; Mon, 06 Jul 2020 15:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=+g8b8UDutwpjfN6lizjtfC7IoMCTSDjsjPJug8YnTgg=;
 b=KUh+nyqnQkj9RcybDE5PeCJrAdjLCL6MfvAIePJyXHNRX0F8FKTnKIeG1/vPX6JbR0
 ZkH2vounWJTv0AHW++nq9HTK5t0tj2w7jkJDno0f/aPPilRdMq6kUjJLsLllyc6nZzA9
 gFUpa3s60zoHwqlYS1ibCaFMDpBcrs4toKYyR9eGRtgpjbgUrfwu2ZQtV4h54mS9Dk8Q
 lg38TgKrJ4Lvli78idB1ExZ9K7zVg+JISjzyd/fRrzPpJ9bQnYZblkHcGZJkJsuDKxMs
 /oeUvTOZc6v1rGutbgXAGNSFIyPxvgBklnWYlKvi0d+6iWbY9jFw/OyGoH076u85nh1D
 9QPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+g8b8UDutwpjfN6lizjtfC7IoMCTSDjsjPJug8YnTgg=;
 b=qJhZlDYiUHVtFAVreCftsRcKR2ILmzqAMIxw2QIMdLUmly97SgSqQpeVpQ5lpJKvel
 PplAjddPD44gq+41Jxl5ZuO0BdDQjHgdiAUUA8Nc17b7ZCvlIlFNGSZ8r2AFZR0aO5bM
 Yr5PTkXBayN+a05NDhn3NkLJGdU15PJMqHvnaBA87oantoBrclhTeFijlYxs9RwBif/r
 hU+MlJjkCU4psWIIQPGuDputPwkDmjBnPG2qUFNHyk/6fVXKp4Be3mkH3VWLeNmqJZyF
 Gj1T2vrNLeTTsLewrP88O1ptNWpxh6WfuCO6nJHtrkFAwIOAayUCD/BTthuyC3ZhnGIK
 F1uA==
X-Gm-Message-State: AOAM532rmZ3XQQ7rEfIKLKcUF0c4WhWAOfhWwwzxq/yfORdyQiMZjJxm
 HWFnies+1Rz0pNR/+fJeWUgJ5WnYjnPe6/scE83hLQ==
X-Google-Smtp-Source: ABdhPJyJihOFDUusDuGurRmf+ynZe/E6+YCOUFBYwFoV/94U5zmmw6gWFYJpZfrD7hx040m64pq6G+pFjE5iBr5QmJw=
X-Received: by 2002:a2e:b5a8:: with SMTP id f8mr27313685ljn.247.1594073940036; 
 Mon, 06 Jul 2020 15:19:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200630044943.3425049-1-rajatja@google.com>
 <20200704114452.GA15530@amd>
In-Reply-To: <20200704114452.GA15530@amd>
Date: Mon, 6 Jul 2020 15:18:23 -0700
Message-ID: <CACK8Z6HP00o=rextd0-X-u2aH72PNU3t6zEczC2GGO_QfGhUcA@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] Tighten PCI security, expose dev location in sysfs
To: Pavel Machek <pavel@denx.de>
Cc: Todd Broch <tbroch@google.com>, linux-pci <linux-pci@vger.kernel.org>,
 "Krishnakumar, Lalithambika" <lalithambika.krishnakumar@intel.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Diego Rivas <diegorivas@google.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Furquan Shaikh <furquan@google.com>, Raj Ashok <ashok.raj@intel.com>,
 Saravana Kannan <saravanak@google.com>,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 Christian Kellner <christian@kellner.me>,
 Mattias Nissler <mnissler@google.com>, Jesse Barnes <jsbarnes@google.com>,
 Len Brown <lenb@kernel.org>, Rajat Jain <rajatxjain@gmail.com>,
 Prashant Malani <pmalani@google.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Aaron Durbin <adurbin@google.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Bernie Keany <bernie.keany@intel.com>, Duncan Laurie <dlaurie@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "open list:AMD IOMMU \(AMD-VI\)" <iommu@lists.linux-foundation.org>,
 Arnd Bergmann <arnd@arndb.de>, Oliver O'Halloran <oohall@gmail.com>,
 Benson Leung <bleung@google.com>, David Woodhouse <dwmw2@infradead.org>,
 Alex Levin <levinale@google.com>
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
From: Rajat Jain via iommu <iommu@lists.linux-foundation.org>
Reply-To: Rajat Jain <rajatja@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Sat, Jul 4, 2020 at 4:44 AM Pavel Machek <pavel@denx.de> wrote:
>
> Hi!
>
> > * The first 3 patches tighten the PCI security using ACS, and take care
> >   of a border case.
> > * The 4th patch takes care of PCI bug.
> > * 5th and 6th patches expose a device's location into the sysfs to allow
> >   admin to make decision based on that.
>
> I see no patch for Documentation -- new sysfs interfaces should be
> documented for 5/6.

Yes, sorry. The patches 5/6 have run into discussion and it looks are
not acceptable at the moment.

Thanks,

Rajat

>
>                                                                         Pavel
>
> >  drivers/base/core.c         | 35 +++++++++++++++++++++++++++++++
> >  drivers/iommu/intel/iommu.c | 31 ++++++++++++++++++---------
> >  drivers/pci/ats.c           |  2 +-
> >  drivers/pci/bus.c           | 13 ++++++------
> >  drivers/pci/of.c            |  2 +-
> >  drivers/pci/p2pdma.c        |  2 +-
> >  drivers/pci/pci-acpi.c      | 13 ++++++------
> >  drivers/pci/pci-driver.c    |  1 +
> >  drivers/pci/pci.c           | 34 ++++++++++++++++++++++++++----
> >  drivers/pci/pci.h           |  3 ++-
> >  drivers/pci/probe.c         | 20 +++++++++++-------
> >  drivers/pci/quirks.c        | 19 +++++++++++++----
> >  include/linux/device.h      | 42 +++++++++++++++++++++++++++++++++++++
> >  include/linux/device/bus.h  |  8 +++++++
> >  include/linux/pci.h         | 13 ++++++------
> >  15 files changed, 191 insertions(+), 47 deletions(-)
> >
>
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
