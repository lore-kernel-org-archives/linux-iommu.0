Return-Path: <SRS0=GrUw=AH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18284C433DF
	for <iommu@archiver.kernel.org>; Fri, 26 Jun 2020 18:54:17 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D89AE207E8
	for <iommu@archiver.kernel.org>; Fri, 26 Jun 2020 18:54:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="Q3jSm/c7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D89AE207E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A88F086B02;
	Fri, 26 Jun 2020 18:54:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Mnw3R9q3uWQk; Fri, 26 Jun 2020 18:54:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E4475860C9;
	Fri, 26 Jun 2020 18:54:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D6F12C0863;
	Fri, 26 Jun 2020 18:54:15 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C4EA8C016F
 for <iommu@lists.linux-foundation.org>; Fri, 26 Jun 2020 18:54:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id AB25986A90
 for <iommu@lists.linux-foundation.org>; Fri, 26 Jun 2020 18:54:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4H3S6LyB_d7u for <iommu@lists.linux-foundation.org>;
 Fri, 26 Jun 2020 18:54:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lj1-f194.google.com (mail-lj1-f194.google.com
 [209.85.208.194])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 7BFCD860C9
 for <iommu@lists.linux-foundation.org>; Fri, 26 Jun 2020 18:54:13 +0000 (UTC)
Received: by mail-lj1-f194.google.com with SMTP id 9so11397430ljc.8
 for <iommu@lists.linux-foundation.org>; Fri, 26 Jun 2020 11:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=TyklzFj5dCuXNYg3v7eYVOhPNqVFIXACBXr++QvGvZI=;
 b=Q3jSm/c7nM2RMkN/kkJWHeLwAsdboqUxRzth/uSa6NXSM8oXMtiMhj9f8WBol97E5l
 ky6f/QaC4KZ4YCnTQZ3BF5dIXjlSPV4QoV2wqdt2Mxc0dLVha+jmh1N//dKeYUM0kj/p
 Cdd4nWsofe4nR1h6Arv8qYj2pSAqwLLlXKo4g4QCtxbm6LC94tNL9HBuchzz8CHS2BAX
 yl2h1pg/AJIJGgSiC33mfu7Wo9ZAOmNg5sJcT1GNiIaf52Hd/o1vV9XDmSUrR47ulwLj
 ref9AD+MOaS2oD3rCYWv+1d1sjD/0C8RZj9PYTuYlbI4YRzLWzNCmbCgcQYmWu2Ufvyd
 PAzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=TyklzFj5dCuXNYg3v7eYVOhPNqVFIXACBXr++QvGvZI=;
 b=gDUKuenQeTB8gj+68NSBIAm9kMmPvlClnAj4dhFacvJBmYpH/oGcuujiL0/hkdoSvf
 XrKckUR/0LpmjPeUHI08b1EJTAn0z+aAnL6bRIgfZ3zOJOxJAU4jvSOwEJ+vMad8lBCF
 Fx4do3Fq01oQBPE5CqZ4QURTbcIilAuRD7cjDyPUjNEIrjybGMBSFYsHX/s5lGh72BPo
 VN/vHPjOZWvH+e7mMjwBAfwSyW/P6A1AXcyz7ZXsEk1hFyOxO/OPBO1kP53qS0/AyIeO
 sdQatsvE1KgR5JfxfXiEwC5ejiUPw+Cg1qXjsEb5og4Sz4uhc2CkCBOJrqq3/YSzI02H
 73Pg==
X-Gm-Message-State: AOAM530aWSrKb5vGqggjS6uBkTR5+JWZeoG04ir077kH5qJcX1w5JL4Z
 gBKEm5Xu77NeAnAeJkV28hu0I28yaPaIQvz/o6MWZg==
X-Google-Smtp-Source: ABdhPJwEBU78ak0v0VpTknwA5BsMJ5bdkxuMQYVuGSToCCXcbvo/1MlMlImhsgRKT5ooJzz29cDDIywFsWJMzVIeB2E=
X-Received: by 2002:a2e:858e:: with SMTP id b14mr2218327lji.301.1593197651010; 
 Fri, 26 Jun 2020 11:54:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200626002710.110200-1-rajatja@google.com>
 <20200626002710.110200-2-rajatja@google.com>
 <20200626141754.GB4141629@kroah.com>
In-Reply-To: <20200626141754.GB4141629@kroah.com>
Date: Fri, 26 Jun 2020 11:53:34 -0700
Message-ID: <CACK8Z6GSN5iOaCh-ZMaJSY4SgEhw=bCRDzaiPEBJbNNFhZZX6Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] pci: Add parameter to disable attaching untrusted
 devices
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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

Hello,

Thanks for taking a look.

On Fri, Jun 26, 2020 at 7:18 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Jun 25, 2020 at 05:27:10PM -0700, Rajat Jain wrote:
> > Introduce a PCI parameter that disables the automatic attachment of
> > untrusted devices to their drivers.
> >
> > Signed-off-by: Rajat Jain <rajatja@google.com>
> > ---
> > Context:
> >
> >   I set out to implement the approach outlined in
> >     https://lkml.org/lkml/2020/6/9/1331
> >     https://lkml.org/lkml/2020/6/15/1453
> >
> >   But to my surprise, I found that the new hotplugged PCI devices
> >   were getting automatically attached to drivers even though
> >   /sys/bus/pci/drivers_autoprobe was set to 0.
> >
> >   I realized that the device core's "drivers_autoprobe":
> >
> >   * only disables the *initial* probe of the device (i.e. from
> >     device_add()). If a subsystem calls device_attach() explicitly
> >     for its devices like PCI subsystem does, the drivers_autoprobe
> >     setting does not matter. The core will attach device to the driver.
> >     This looks like correct semantic behavior to me because PCI is
> >     explicitly calling device_attach(), which is a way to explicitly
> >     ask the core to find and attach a driver for a device.
> >
> >   * "drivers_autoprobe" cannot be controlled at boot time (to restrict
> >     any drivers before userspace comes up).
> >
> >   The options I considered were:
> >
> >   1) Change device_attach() so that it takes into consideration the
> >      drivers_autoprobe property. Not sure if this is semantically correct
> >      thing to do though. If I do this, then the only way a driver can
> >      be attached to the drivers would be via userspace
> >      (/sys/bus/pci/drivers/bind) (Good for our use case though!).
>
> This is the correct thing to do here, haven't I been asking you do move
> this logic into the driver core so that all busses can use it?

(please see below)

>
> >   2) Make the drivers_autoprobe property available to PCI to use
> >      (currently it is private to device core). The PCI could use this
> >      to determine whether or not to call device_attach(). This still
> >      leaves the other problem (of not being able to set
> >      drivers_autoprobe via command line open).
>
> Ick, command lines are horrible, don't do that if at all possible.  On
> some systems they are not able to be changed which can be good or bad...

(please see below)

>
> >   3) I found the pci_dev->match_driver, which seemed similar to what I
> >      am trying to do, but can't be controlled from userspace. I considered
> >      populating that field based on drivers_autoprobe (still need (2)).
> >      But the problem is that there is the AMD IOMMU driver which is setting
> >      this independently, so setting the match_driver based on
> >      drivers_autoprobe may not be a good idea. May be we can populate it
> >      for untrusted devicesi, based on the parameter that I'm introducing?
> >
> >   4) This patch was my option 4 that helps fix both the problems for me.
>
> I suggest putting some of the above text in the changelog, as it has a
> lot of good context, while your existing changelog is pretty sparse and
> does not explain anything...

Will do.

>
>
> >
> >  drivers/pci/bus.c | 11 ++++++++---
> >  drivers/pci/pci.c |  9 +++++++++
> >  drivers/pci/pci.h |  1 +
> >  3 files changed, 18 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> > index 3cef835b375fd..336aeeb4c4ebf 100644
> > --- a/drivers/pci/bus.c
> > +++ b/drivers/pci/bus.c
> > @@ -321,9 +321,14 @@ void pci_bus_add_device(struct pci_dev *dev)
> >       pci_bridge_d3_update(dev);
> >
> >       dev->match_driver = true;
> > -     retval = device_attach(&dev->dev);
> > -     if (retval < 0 && retval != -EPROBE_DEFER)
> > -             pci_warn(dev, "device attach failed (%d)\n", retval);
> > +
> > +     if (dev->untrusted && pci_dont_attach_untrusted_devs) {
> > +             pci_info(dev, "not attaching untrusted device\n");
> > +     } else {
> > +             retval = device_attach(&dev->dev);
> > +             if (retval < 0 && retval != -EPROBE_DEFER)
> > +                     pci_warn(dev, "device attach failed (%d)\n", retval);
> > +     }
> >
> >       pci_dev_assign_added(dev, true);
> >  }
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index ce096272f52b1..dec1f9ef27d71 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -127,6 +127,13 @@ static bool pcie_ats_disabled;
> >  /* If set, the PCI config space of each device is printed during boot. */
> >  bool pci_early_dump;
> >
> > +/*
> > + * If set, the devices with "untrusted" flag shall not be attached automatically
> > + * Userspace will need to attach them manually:
> > + * echo <pci device>  > /sys/bus/pci/drivers/<driver>/bind
> > + */
> > +bool pci_dont_attach_untrusted_devs;
> > +
> >  bool pci_ats_disabled(void)
> >  {
> >       return pcie_ats_disabled;
> > @@ -6522,6 +6529,8 @@ static int __init pci_setup(char *str)
> >                               pci_add_flags(PCI_SCAN_ALL_PCIE_DEVS);
> >                       } else if (!strncmp(str, "disable_acs_redir=", 18)) {
> >                               disable_acs_redir_param = str + 18;
> > +                     } else if (!strcmp(str, "dont_attach_untrusted_devs")) {
> > +                             pci_dont_attach_untrusted_devs = true;
> >                       } else {
> >                               pr_err("PCI: Unknown option `%s'\n", str);
> >                       }
> > diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> > index 6d3f758671064..30ffad047d926 100644
> > --- a/drivers/pci/pci.h
> > +++ b/drivers/pci/pci.h
> > @@ -13,6 +13,7 @@
> >
> >  extern const unsigned char pcie_link_speed[];
> >  extern bool pci_early_dump;
> > +extern bool pci_dont_attach_untrusted_devs;
> >
> >  bool pcie_cap_has_lnkctl(const struct pci_dev *dev);
> >  bool pcie_cap_has_rtctl(const struct pci_dev *dev);
> > --
> > 2.27.0.212.ge8ba1cc988-goog
> >
>
> What happened to the split of "trust" and "internal/external" logic that
> we discussed before?

a) I think what was decided was introducing a device core "location"
property that can be exposed to userspace to help it to decide whether
or not to attach a driver to a device. Yes, that is still the plan.
(Mild sidenote: userspace may not need to distinguish between internal
and external devices if it can assume that no internal PCI devices
will show up after "echo 0 > /sys/bus/pci/drivers_autoprobe". But
nevertheless...)

b) Note that even with (a) in place, we still need a parameter that
can ensure that drivers are not bound to external devices at boot,
*before* userspace gets a chance to disable "drivers_autoprobe".
https://lkml.org/lkml/2020/6/15/1453
Is it OK to add such a parameter in device core?

Thanks,

Rajat





> This seems to ignore all of that and go straight
> to some form of "we know what we trust, so all is fine!".
>
> It's not obvious what this is really doing here at all, sorry...
>
> greg k-h
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
