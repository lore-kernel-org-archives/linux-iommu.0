Return-Path: <SRS0=S+y3=AR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B487C433DF
	for <iommu@archiver.kernel.org>; Mon,  6 Jul 2020 23:20:12 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2489A2073E
	for <iommu@archiver.kernel.org>; Mon,  6 Jul 2020 23:20:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="uQJyuwzh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2489A2073E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id DF2A0878DD;
	Mon,  6 Jul 2020 23:20:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id et0aDL607Jux; Mon,  6 Jul 2020 23:20:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 2C661817F8;
	Mon,  6 Jul 2020 23:20:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1FA42C0893;
	Mon,  6 Jul 2020 23:20:11 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1F955C016F
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jul 2020 23:20:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 0E6FD87861
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jul 2020 23:20:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id isKaDxn3ZElk for <iommu@lists.linux-foundation.org>;
 Mon,  6 Jul 2020 23:20:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lf1-f67.google.com (mail-lf1-f67.google.com
 [209.85.167.67])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 1C36C8784E
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jul 2020 23:20:09 +0000 (UTC)
Received: by mail-lf1-f67.google.com with SMTP id u25so23699197lfm.1
 for <iommu@lists.linux-foundation.org>; Mon, 06 Jul 2020 16:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=S3X9p3/Tcr/ntGdk7/sKAQe/cqkFM9AS9Ft6l97WEKQ=;
 b=uQJyuwzhr1LE9Kuu0uj364VAAz32Bh7MBlXiEDIQ/nUXcVpCy46dFU+hOB7IQ1k/ZN
 bJgvUcwxMNHu4LDAb+vAaKgiG7GYiIy67zI1i2MUI3EvXO84kY8FEEPUVp/hvHeiNL6c
 ZygjdlEC+YziNf4Q/RlhItGSwpgUrrWRKO5Co76LjKMxg7su1J6iFs06TCzAmeHEY/Jk
 ceUn6JagX5snL/WJLnKUWPPc4WHeRKiN6R6mT6oQ1sbMsRTT6O2cGqrkOashlprvdlRo
 eyPIPw8Vy/Ewj162V27wNRLki/xnrojkju/PLxmHEJ6Ji+8AscOEXddWLC6XeyOL1qct
 3PQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=S3X9p3/Tcr/ntGdk7/sKAQe/cqkFM9AS9Ft6l97WEKQ=;
 b=YuYmIRZ8gL+8bF5FPAKp1VxWiEajcWHJQ9wh/mWHvouF4EaxFW3FbYtvwE8/q/ERLP
 pZGb+VIyytwrpMddNFSjsFoM8U7WOaGFr4LzPWZH/qGmAAXFPnNFMislHkWDkvlIwYJt
 Rf0OsB/T4rY+wM8PWh2vRTzmFAw/dHFCTszMOGIayx+CHFWgJjWQcV2F1VSxPgQfhXa2
 K/8Wu+K+c1Ly20VF2V0PXf233f7h99dBzH72m5wy7P+QV6in/LtaNmc+yGr5sDVgkEjG
 qTvwvNFDFhC2g+6IFTiXIXPC1lR2/jg7qEymmfUD3j0QIJh9Rh6cfinhn0paDqyhQps7
 rQGw==
X-Gm-Message-State: AOAM533RntlzOmvCe5K1jx4REOjBkX0PrS27FW7qGzP25Mx3E6gV8r1f
 2lWsMeVv/oTVmIbqE1x0TX58T7BiYY4sHyaundpk+A==
X-Google-Smtp-Source: ABdhPJxhlrks5dTrFpXpr6UWodktRTBMegtu4j0YZwtWWhGamKlzpsn99s1KAheWtq3vN90rWaEkmGqPB/S4gzc6C0Y=
X-Received: by 2002:a19:ca11:: with SMTP id a17mr31096448lfg.120.1594077606885; 
 Mon, 06 Jul 2020 16:20:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200630044943.3425049-4-rajatja@google.com>
 <20200706170736.GA125844@bjorn-Precision-5520>
In-Reply-To: <20200706170736.GA125844@bjorn-Precision-5520>
Date: Mon, 6 Jul 2020 16:19:30 -0700
Message-ID: <CACK8Z6H-8SAmGPFAwQjiJFQyH0S6h5EGyzSNpnrdhsu2UhpFjg@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] PCI/ACS: Enable PCI_ACS_TB for
 untrusted/external-facing devices
To: Bjorn Helgaas <helgaas@kernel.org>
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

On Mon, Jul 6, 2020 at 10:07 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Mon, Jun 29, 2020 at 09:49:39PM -0700, Rajat Jain wrote:
> > When enabling ACS, enable translation blocking for external facing ports
> > and untrusted devices.
> >
> > Signed-off-by: Rajat Jain <rajatja@google.com>
> > ---
> > v2: Commit log change
> >
> >  drivers/pci/pci.c    |  4 ++++
> >  drivers/pci/quirks.c | 11 +++++++++++
> >  2 files changed, 15 insertions(+)
> >
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index d2ff987585855..79853b52658a2 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -3330,6 +3330,10 @@ static void pci_std_enable_acs(struct pci_dev *dev)
> >       /* Upstream Forwarding */
> >       ctrl |= (cap & PCI_ACS_UF);
> >
> > +     if (dev->external_facing || dev->untrusted)
> > +             /* Translation Blocking */
> > +             ctrl |= (cap & PCI_ACS_TB);
> > +
> >       pci_write_config_word(dev, pos + PCI_ACS_CTRL, ctrl);
> >  }
> >
> > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > index b341628e47527..6294adeac4049 100644
> > --- a/drivers/pci/quirks.c
> > +++ b/drivers/pci/quirks.c
> > @@ -4934,6 +4934,13 @@ static void pci_quirk_enable_intel_rp_mpc_acs(struct pci_dev *dev)
> >       }
> >  }
> >
> > +/*
> > + * Currently this quirk does the equivalent of
> > + * PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_UF | PCI_ACS_SV
>
> Nit: Reorder these as in c8de8ed2dcaa ("PCI: Make ACS quirk
> implementations more uniform") so they match other similar lists in
> the code.

Will do.

>
> But more to the point: we have a bunch of other quirks for devices
> that do not have an ACS capability but *do* provide some ACS-like
> features.  Most of them support
>
>   PCI_ACS_SV | PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_UF
>
> because that's what we usually want.  But I bet some of them also
> actually provide the equivalent of PCI_ACS_TB.
>
> REQ_ACS_FLAGS doesn't include PCI_ACS_TB.  Is there anything we need
> to do on the pci_acs_enabled() side to check for PCI_ACS_TB, and
> consequently, to update any of the quirks for devices that provide it?

I'm actually not sure.
+Alex Williamson , do you have any comments here?

Thanks,

Rajat

>
> > + *
> > + * Currently missing, it also needs to do equivalent of PCI_ACS_TB,
> > + * if dev->external_facing || dev->untrusted
> > + */
> >  static int pci_quirk_enable_intel_pch_acs(struct pci_dev *dev)
> >  {
> >       if (!pci_quirk_intel_pch_acs_match(dev))
> > @@ -4973,6 +4980,10 @@ static int pci_quirk_enable_intel_spt_pch_acs(struct pci_dev *dev)
> >       ctrl |= (cap & PCI_ACS_CR);
> >       ctrl |= (cap & PCI_ACS_UF);
> >
> > +     if (dev->external_facing || dev->untrusted)
> > +             /* Translation Blocking */
> > +             ctrl |= (cap & PCI_ACS_TB);
> > +
> >       pci_write_config_dword(dev, pos + INTEL_SPT_ACS_CTRL, ctrl);
> >
> >       pci_info(dev, "Intel SPT PCH root port ACS workaround enabled\n");
> > --
> > 2.27.0.212.ge8ba1cc988-goog
> >
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
