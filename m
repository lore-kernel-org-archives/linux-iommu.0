Return-Path: <SRS0=S+y3=AR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD84BC433E0
	for <iommu@archiver.kernel.org>; Mon,  6 Jul 2020 23:35:46 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B64520720
	for <iommu@archiver.kernel.org>; Mon,  6 Jul 2020 23:35:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="h0hfLaWY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B64520720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 30588267F7;
	Mon,  6 Jul 2020 23:35:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YpvfCCRUpuTF; Mon,  6 Jul 2020 23:35:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 96157261DB;
	Mon,  6 Jul 2020 23:35:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 77E66C0893;
	Mon,  6 Jul 2020 23:35:45 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 78196C016F
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jul 2020 23:35:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 5FA0788B72
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jul 2020 23:35:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fNUEd0mkPlqu for <iommu@lists.linux-foundation.org>;
 Mon,  6 Jul 2020 23:35:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lj1-f196.google.com (mail-lj1-f196.google.com
 [209.85.208.196])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 6BC7A88B67
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jul 2020 23:35:43 +0000 (UTC)
Received: by mail-lj1-f196.google.com with SMTP id b25so44115428ljp.6
 for <iommu@lists.linux-foundation.org>; Mon, 06 Jul 2020 16:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=0xUaLtfV7bWgoPSWuLiBhAg/0ko2eQcaAYCQJ2etMGI=;
 b=h0hfLaWYG1MhCTz6J6AARwPIxYT3gBIha6jL6xVvSUaBoYkx4N94teWLPVBCAUX5Rb
 Mgd6ZfbpomMbwqCIpw6IvR/7+AWSOpd9wxAQaDAndSKUttK7AHQnKPfJUCMld+DdpHSu
 sJug6LFr6dSpqEUPZ5+6SlqOSKPcU4TvkSh0i9oHDdnjmCAeCWWfxOD48hkHGmZ5zzLT
 Qw7h+MQdQuwG++aYuXtmJyJHTeCIayb3GEpeIJHOrsJgSiF0lfhgl6O+IMdV0iCHo6Vj
 tWwgOV29i5d0C37Jw3GV3DT1i0KRM1Kjtu1dClAUAbtDG5GPGRG8YydqDFCi9bBjresk
 O/ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0xUaLtfV7bWgoPSWuLiBhAg/0ko2eQcaAYCQJ2etMGI=;
 b=s19yxhiz0B+5GVsWSu0rJIkLhmXztUmOV3+7OZ5AKnDldWegLQc0QmtwKm9AJwJ2fa
 +OVJku7zwp1iryMU8QQyAKeg4gznBi/7QBU7HqlR+DXWyiTi/67HxiVnHhjRtD9+Y3lt
 8ShAaP20/a+DHStNvQTRRmQXCifViRd4fqaatCxSz15aC45P1UQbVLFS/Jw0ARAX4xnU
 NRWW/x05GUZnzcpaIAXPzFSYraZC0bRU7fQv2ZUmP/Yuscvqb7x+99Gh2UyUqADYQo0m
 RB2BcCJ5ZGVxYSsOzXhT185AvtQGFQR8eKLB5M/6nr+95vID4sQwwHlsQz4C10WEnGVk
 cPaQ==
X-Gm-Message-State: AOAM531i2XJX3wTompEMmMLq5OzKINk/6/Q2w4jwTCm65ijbXpamY14H
 obq++NrxXRlokYPk2kR7oG+fC8IPiNXOk3HoDvw6Sw==
X-Google-Smtp-Source: ABdhPJw6dXXwcyv4KY9Jl80FcEosFSoQoaGDHkx+0zdTw4HjncZQDYJNWjTLcwx9UlAXOCwdVnow/Rw2NoDsjZTLErM=
X-Received: by 2002:a2e:858e:: with SMTP id b14mr30021146lji.301.1594078541252; 
 Mon, 06 Jul 2020 16:35:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200630044943.3425049-1-rajatja@google.com>
 <20200630044943.3425049-5-rajatja@google.com>
 <20200630080220.GC619174@kroah.com>
In-Reply-To: <20200630080220.GC619174@kroah.com>
Date: Mon, 6 Jul 2020 16:35:05 -0700
Message-ID: <CACK8Z6FdWqx5oSXtAtZR7MN_yL0CS5g3yOmGeL5J9sZPHK_MYQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] PCI: Add device even if driver attach failed
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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

On Tue, Jun 30, 2020 at 1:02 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Jun 29, 2020 at 09:49:40PM -0700, Rajat Jain wrote:
> > device_attach() returning failure indicates a driver error while trying to
> > probe the device. In such a scenario, the PCI device should still be added
> > in the system and be visible to the user.
> >
> > This patch partially reverts:
> > commit ab1a187bba5c ("PCI: Check device_attach() return value always")
> >
> > Signed-off-by: Rajat Jain <rajatja@google.com>
> > Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> > v2: Cosmetic change in commit log.
> >     Add Greg's "reviewed-by"
> >
> >  drivers/pci/bus.c | 6 +-----
> >  1 file changed, 1 insertion(+), 5 deletions(-)
> >
> > diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> > index 8e40b3e6da77d..3cef835b375fd 100644
> > --- a/drivers/pci/bus.c
> > +++ b/drivers/pci/bus.c
> > @@ -322,12 +322,8 @@ void pci_bus_add_device(struct pci_dev *dev)
> >
> >       dev->match_driver = true;
> >       retval = device_attach(&dev->dev);
> > -     if (retval < 0 && retval != -EPROBE_DEFER) {
> > +     if (retval < 0 && retval != -EPROBE_DEFER)
> >               pci_warn(dev, "device attach failed (%d)\n", retval);
> > -             pci_proc_detach_device(dev);
> > -             pci_remove_sysfs_dev_files(dev);
> > -             return;
> > -     }
> >
> >       pci_dev_assign_added(dev, true);
> >  }
>
> This should go first in the series, and cc: stable and get merged now.
> No need to tie it to this series at all.
>
> Or just an independant patch, it doesn't have much to do with this
> series, it's a bugfix.

Resent this patch as an independent patch with cc:stable here:
https://lore.kernel.org/patchwork/patch/1268456/

Thanks,

Rajat

>
> thanks,
>
> greg k-h
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
