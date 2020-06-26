Return-Path: <SRS0=GrUw=AH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AF74C433DF
	for <iommu@archiver.kernel.org>; Fri, 26 Jun 2020 19:02:18 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D92FF2088E
	for <iommu@archiver.kernel.org>; Fri, 26 Jun 2020 19:02:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="PljCG4p1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D92FF2088E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id AD2A388726;
	Fri, 26 Jun 2020 19:02:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id f+QftYdo6nzV; Fri, 26 Jun 2020 19:02:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 1FC3B882B1;
	Fri, 26 Jun 2020 19:02:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0113DC0863;
	Fri, 26 Jun 2020 19:02:17 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DEC68C016F
 for <iommu@lists.linux-foundation.org>; Fri, 26 Jun 2020 19:02:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id CD58D84D41
 for <iommu@lists.linux-foundation.org>; Fri, 26 Jun 2020 19:02:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BNOSVIly6gjJ for <iommu@lists.linux-foundation.org>;
 Fri, 26 Jun 2020 19:02:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lj1-f196.google.com (mail-lj1-f196.google.com
 [209.85.208.196])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id D895781127
 for <iommu@lists.linux-foundation.org>; Fri, 26 Jun 2020 19:02:14 +0000 (UTC)
Received: by mail-lj1-f196.google.com with SMTP id s1so11456300ljo.0
 for <iommu@lists.linux-foundation.org>; Fri, 26 Jun 2020 12:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=CupTv356WOheWFFcn47AA78Bc8xE85sorZq/DL/d5ow=;
 b=PljCG4p1Fw8CHLh+rUo2wSWaKZbvtTK+SH69StUSy72aY4d1OYyiZUq/AaW6a5d1MI
 mq7+P723mcxuKFZJ5YT7j2sJC2nDwAp1KAMuq5VMYdluPT75VMQ3W97a14UhUtX4a1Q2
 Y7Br1N0WDugVyuoC8lYZ/SyVf6EN373Kqez82pnoO4DMI2ZgGgU2GH+Ppuhy6J6g/YUt
 1XpiIuatKtMKTEm14jT7CRjJOtuvbAALQKYB80RhD2Byety+zKHXncWQo4dJsh1SQeMA
 nSqGNi15sCpqApCXfW8JO5PL/hkt8la90/o6M5m9jJhBWq0yG5p6KMs8op0c3aNYsphn
 8wzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=CupTv356WOheWFFcn47AA78Bc8xE85sorZq/DL/d5ow=;
 b=pVhb2SoLl+LJ87UWylKrYklNkz/0sEoW1XcZ9P2SwDnHHQhEIIz6D2giNTQPkEklOg
 p1fwiketGD5eUzD7I1LcwKPOdBPE/VDM3oCasrNMuIpmnfOQf+S4vulahfmGvdEkVWaL
 /wy5xkKeKXoAYFoB7KOtY80cFGKgBZM6xjbz4wi5vuFjxEHlKHzRuWOOp/KGSfyErMj5
 JXD71NGAkgBGC9s2MpCwpXCKmfbi78mm5kISVoaPjpS2KLigJs31OA37Zvb2VPb23vdB
 kyn9WryXXEQTv59sCZcTz8tkdYCiSaYFgfmFii8iX8G6fMpBusMdleHF/YQN96Z0HZ4I
 hPSw==
X-Gm-Message-State: AOAM532N/DmQYIRb5bM7FN84ZOz/r7yG5e27FKWXvBmuX8jEMVvpe2q4
 OqSKoLid/rwVTZTcg7Ixxl2T2qyNHMnItv2aJxOC1A==
X-Google-Smtp-Source: ABdhPJwXqAgY35bZFXo6/B0G8JpMwZbJM19I1mNnWaLF8LNBfGwBsVegK/WyraehTX79S8Hc7skGI2IKEUUkez0pahs=
X-Received: by 2002:a2e:92cf:: with SMTP id k15mr2200496ljh.333.1593198132811; 
 Fri, 26 Jun 2020 12:02:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200626002710.110200-1-rajatja@google.com>
 <20200626153906.GA2897118@bjorn-Precision-5520>
In-Reply-To: <20200626153906.GA2897118@bjorn-Precision-5520>
Date: Fri, 26 Jun 2020 12:01:36 -0700
Message-ID: <CACK8Z6G7Pau3LTt2LYx=pezLcwxO5kKaM18_yis0w-UGYd675w@mail.gmail.com>
Subject: Re: [PATCH 1/2] pci: Add pci device even if the driver failed to
 attach
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Todd Broch <tbroch@google.com>, linux-pci <linux-pci@vger.kernel.org>,
 "Krishnakumar, Lalithambika" <lalithambika.krishnakumar@intel.com>,
 Diego Rivas <diegorivas@google.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Furquan Shaikh <furquan@google.com>, Raj Ashok <ashok.raj@intel.com>,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 Christian Kellner <christian@kellner.me>,
 Mattias Nissler <mnissler@google.com>, Jesse Barnes <jsbarnes@google.com>,
 Len Brown <lenb@kernel.org>, Rajat Jain <rajatxjain@gmail.com>,
 Prashant Malani <pmalani@google.com>, Aaron Durbin <adurbin@google.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Bernie Keany <bernie.keany@intel.com>, Duncan Laurie <dlaurie@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 iommu@lists.linux-foundation.org, Oliver O'Halloran <oohall@gmail.com>,
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

On Fri, Jun 26, 2020 at 8:39 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> Nit: when you update these patches, can you run "git log --oneline
> drivers/pci/bus.c" and make your subject lines match the convention?

Sorry, will do.

> E.g.,
>
>   PCI: Add device even if driver attach failed
>
> On Thu, Jun 25, 2020 at 05:27:09PM -0700, Rajat Jain wrote:
> > device_attach() returning failure indicates a driver error
> > while trying to probe the device. In such a scenario, the PCI
> > device should still be added in the system and be visible to
> > the user.
>
> Nit: please wrap logs to fill 75 characters.  "git log" adds 4 spaces
> at the beginning, so 75+4 still fits nicely in 80 columns without
> wrapping.

Sorry, will do.

>
> > This patch partially reverts:
> > commit ab1a187bba5c ("PCI: Check device_attach() return value always")
> >
> > Signed-off-by: Rajat Jain <rajatja@google.com>
> > ---
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
>
> Thanks for catching my bug!
>
> > -             return;
> > -     }
> >
> >       pci_dev_assign_added(dev, true);
> >  }
> > --
> > 2.27.0.212.ge8ba1cc988-goog
> >
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
