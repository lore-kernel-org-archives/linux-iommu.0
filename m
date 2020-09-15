Return-Path: <SRS0=AdPL=CY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7B78C433E2
	for <iommu@archiver.kernel.org>; Tue, 15 Sep 2020 23:02:27 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FBC0206DC
	for <iommu@archiver.kernel.org>; Tue, 15 Sep 2020 23:02:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="ZVyYyQFG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FBC0206DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id C82EB872BF;
	Tue, 15 Sep 2020 23:02:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mrxc5PcNuzIy; Tue, 15 Sep 2020 23:02:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 36DA2872BE;
	Tue, 15 Sep 2020 23:02:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2040AC0859;
	Tue, 15 Sep 2020 23:02:26 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 35126C0051
 for <iommu@lists.linux-foundation.org>; Tue, 15 Sep 2020 23:02:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 1C39B872BE
 for <iommu@lists.linux-foundation.org>; Tue, 15 Sep 2020 23:02:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RHqPEQTplV4W for <iommu@lists.linux-foundation.org>;
 Tue, 15 Sep 2020 23:02:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lj1-f194.google.com (mail-lj1-f194.google.com
 [209.85.208.194])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 1B0DC872BA
 for <iommu@lists.linux-foundation.org>; Tue, 15 Sep 2020 23:02:24 +0000 (UTC)
Received: by mail-lj1-f194.google.com with SMTP id u4so4229255ljd.10
 for <iommu@lists.linux-foundation.org>; Tue, 15 Sep 2020 16:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/9scBHPNix+y6Pwr8cQyVX+xDYS3UrPPXINpHzBknN4=;
 b=ZVyYyQFG1iBiLFuKDDQuAPmiBZLpB11LhmJ8YIOtjnryLAEf3A4zUrMoifNnYRWJlf
 8GcDcZvPM6I43fh/hfWt5Ij4L0sml+BEcbwcrw9YG7Yv4MCF4a3iTKVN2+zx/6t1Ok/U
 EztiiWABfLBG0/pmN5Vl7Cj2fE6WIAdiGdue7cOiCXYCIRSnnNjhvCG039/GlTc80TRj
 aqwQ3MOyvtANK7SvVzqwtpY0bPLrbyc56t1ojaXcJdWtPVCALRtamlRtUIQUeZZ3HY8z
 BDvzFgB0IjGoamrNzKeAtkR8T1BKPA8B09P9hDpTiuNjtQyYdb12iJHIbtSbTSRWvjFY
 sX3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/9scBHPNix+y6Pwr8cQyVX+xDYS3UrPPXINpHzBknN4=;
 b=oSHz0mRHZ45VTEr08gPEfgcQ0B6r4GotFJOrx64Gg2nwpyYt//B2CCucVg1slkRC3j
 QQ9kj4uvkXZkF96VhHWgXvCsrf+DGn9XlZ8/SFKgkhhkFMh/cE0gXOZyRV6os2FblFD7
 x0HyxXTzfeuM0gzDOKMJ7TkrrGSI3x15K+qNvT0FCuZ3rmRCoTJTNJ4ByRvdPwVZ0tO2
 Nb36/IOUFPDoWVptl+zobev00Nv918A+8bcG0GsjORBbI6VO5StBLCxdSDAzc/VcwrML
 Kdz1q602E5HQbrpytc/y0YiuZMZZSF+GLwR6pxn2/QQ/RiAsaCOsEMcpSgPeAx5imU7R
 EXNw==
X-Gm-Message-State: AOAM531SmcGDXW5ElhL6yDb946cIrwX3PTAtCa4iKGQ0XSPx7NkgVoin
 JrVvaSdaLCNC9/4TXBqOrQSm9g3BHFcebu9dADaHIA==
X-Google-Smtp-Source: ABdhPJysOqFs8iJIdAa5maQ13XMna1CrI/NRUUz9V4/qRiA3nA6/D4LifyuPbfI1VmRc64fhlM/srS8bqKradXWp+OM=
X-Received: by 2002:a2e:9992:: with SMTP id w18mr7963973lji.301.1600210941914; 
 Tue, 15 Sep 2020 16:02:21 -0700 (PDT)
MIME-Version: 1.0
References: <CACK8Z6F-8OZNJU8wqWuZq=moCaOi+3W=CzBeppfO31VZnkqBrg@mail.gmail.com>
 <20200711195346.GA132330@bjorn-Precision-5520>
 <CACK8Z6HP1VHs4P=U6-+D_D8HrQ5D1P679P_=saNqUMXE-bNUjg@mail.gmail.com>
In-Reply-To: <CACK8Z6HP1VHs4P=U6-+D_D8HrQ5D1P679P_=saNqUMXE-bNUjg@mail.gmail.com>
Date: Tue, 15 Sep 2020 16:01:45 -0700
Message-ID: <CACK8Z6FgCZR+PrW88myVsy=ZEq-rCD=s7xV5tDGOM437=1apMA@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] PCI/ACS: Enable PCI_ACS_TB for
 untrusted/external-facing devices
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Todd Broch <tbroch@google.com>, linux-pci <linux-pci@vger.kernel.org>,
 "Krishnakumar, Lalithambika" <lalithambika.krishnakumar@intel.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Diego Rivas <diegorivas@google.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Furquan Shaikh <furquan@google.com>, "Raj, Ashok" <ashok.raj@intel.com>,
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

Hello Bjorn,


On Tue, Jul 14, 2020 at 1:19 PM Rajat Jain <rajatja@google.com> wrote:
>
> On Sat, Jul 11, 2020 at 12:53 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > On Fri, Jul 10, 2020 at 03:53:59PM -0700, Rajat Jain wrote:
> > > On Fri, Jul 10, 2020 at 2:29 PM Raj, Ashok <ashok.raj@intel.com> wrote:
> > > > On Fri, Jul 10, 2020 at 03:29:22PM -0500, Bjorn Helgaas wrote:
> > > > > On Tue, Jul 07, 2020 at 03:46:04PM -0700, Rajat Jain wrote:
> > > > > > When enabling ACS, enable translation blocking for external facing ports
> > > > > > and untrusted devices.
> > > > > >
> > > > > > Signed-off-by: Rajat Jain <rajatja@google.com>
> > > > > > ---
> > > > > > v4: Add braces to avoid warning from kernel robot
> > > > > >     print warning for only external-facing devices.
> > > > > > v3: print warning if ACS_TB not supported on external-facing/untrusted ports.
> > > > > >     Minor code comments fixes.
> > > > > > v2: Commit log change
> > > > > >
> > > > > >  drivers/pci/pci.c    |  8 ++++++++
> > > > > >  drivers/pci/quirks.c | 15 +++++++++++++++
> > > > > >  2 files changed, 23 insertions(+)
> > > > > >
> > > > > > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > > > > > index 73a8627822140..a5a6bea7af7ce 100644
> > > > > > --- a/drivers/pci/pci.c
> > > > > > +++ b/drivers/pci/pci.c
> > > > > > @@ -876,6 +876,14 @@ static void pci_std_enable_acs(struct pci_dev *dev)
> > > > > >     /* Upstream Forwarding */
> > > > > >     ctrl |= (cap & PCI_ACS_UF);
> > > > > >
> > > > > > +   /* Enable Translation Blocking for external devices */
> > > > > > +   if (dev->external_facing || dev->untrusted) {
> > > > > > +           if (cap & PCI_ACS_TB)
> > > > > > +                   ctrl |= PCI_ACS_TB;
> > > > > > +           else if (dev->external_facing)
> > > > > > +                   pci_warn(dev, "ACS: No Translation Blocking on external-facing dev\n");
> > > > > > +   }
> > > > >
> > > > > IIUC, this means that external devices can *never* use ATS and
> > > > > can never cache translations.
> > >
> > > Yes, but it already exists today (and this patch doesn't change that):
> > > 521376741b2c2 "PCI/ATS: Only enable ATS for trusted devices"
> > >
> > > IMHO any external device trying to send ATS traffic despite having ATS
> > > disabled should count as a bad intent. And this patch is trying to
> > > plug that loophole, by blocking the AT traffic from devices that we do
> > > not expect to see AT from anyway.
> >
> > Thinking about this some more, I wonder if Linux should:
> >
> >   - Explicitly disable ATS for every device at enumeration-time, e.g.,
> >     in pci_init_capabilities(),
> >
> >   - Enable PCI_ACS_TB for every device (not just external-facing or
> >     untrusted ones),
> >
> >   - Disable PCI_ACS_TB for the relevant devices along the path only
> >     when enabling ATS.
> >
> > One nice thing about doing that is that the "untrusted" test would be
> > only in pci_enable_ats(), and we wouldn't need one in
> > pci_std_enable_acs().
>
> Sent out v5 with this approach here:
> https://patchwork.kernel.org/patch/11663515/

Any feedback on the patch above? It has been waiting for feedback....

Thanks & Best Regards,,

Rajat


>
> Thanks,
>
> Rajat
>
> >
> >
> > It's possible BIOS gives us devices with ATS enabled, and this might
> > break them, but that seems like something we'd want to find out about.
> >
> > Bjorn
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
