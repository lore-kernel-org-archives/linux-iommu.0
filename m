Return-Path: <SRS0=m4kH=AS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DFEBC433E3
	for <iommu@archiver.kernel.org>; Tue,  7 Jul 2020 06:03:51 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C859020739
	for <iommu@archiver.kernel.org>; Tue,  7 Jul 2020 06:03:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="GgPOPzZV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C859020739
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 8483E893B4;
	Tue,  7 Jul 2020 06:03:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dwqnJUjFAa-J; Tue,  7 Jul 2020 06:03:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 62A96893A5;
	Tue,  7 Jul 2020 06:03:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 53BF2C0893;
	Tue,  7 Jul 2020 06:03:49 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 257A0C016F
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jul 2020 06:03:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 14007888BC
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jul 2020 06:03:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NVbvijS7Gry4 for <iommu@lists.linux-foundation.org>;
 Tue,  7 Jul 2020 06:03:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lf1-f67.google.com (mail-lf1-f67.google.com
 [209.85.167.67])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 57939888B5
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jul 2020 06:03:46 +0000 (UTC)
Received: by mail-lf1-f67.google.com with SMTP id o4so24071447lfi.7
 for <iommu@lists.linux-foundation.org>; Mon, 06 Jul 2020 23:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=At7frkuP//m2C4wO/t68JtiKfwGrxfIjgNhoGFPjuqY=;
 b=GgPOPzZVB9QG+V16ArbLi5HbSt8wmX/XmnUem6yWxPjNtsObAzq4Iu9cmw7ZSWeDyB
 mGodJ1zI8Trej+99LGaRcwwPrnC2CWw3fkde9h2CLvAz5Oq2GNg3GBNDXWkVTJwk499z
 va0qiN0auLDXpURyHcMx0O5f4twmGjWZNUlUiMzUumLZ5+GiAvfINFNk4jNgVcUUX+CS
 sGy8XHr63Pt36UrDUeceTJD7/K2ZMK9XduWN2tVc0+VRly4yh1fpYbXReeJy5XPtPm+1
 B+kWAKlt3lJDmUnPS5Hd/kKzs2DRBiPrHxZXT2uKd6TTthaAtnaHNt+/94D/CAWaGUQW
 ipdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=At7frkuP//m2C4wO/t68JtiKfwGrxfIjgNhoGFPjuqY=;
 b=GtgRlJEpqrkERiCjz9EO9T0F/ShjKWkM8uj+6IWg2l0v1SX+zzGQ1G26BCep6FNl1D
 qb1NtJjDHpHdf7cojX91ELUpNk18e+t3ZEJoIOaNdbx8bkHZZejFpLZwPTDPj9OPSCVd
 Y4cD2xSINDQpcaYYH4OPuKawqLRIttJyH3VPSzo5bLC4W/spqrpEOb6jIFqgnvoNmz/3
 o65X/QjQWu8u+8E/AQ+8D2HSrkZ/ASK/TU/HtsCoH6oppfFuWZquEvPUrpUiOnh1L27S
 cvGKvQQFWwFRMBQ5GDbjZdvxkIcNu4vTTTNjdhEUkzd5lGaEgKLFuxq/vT3GxruTyNy7
 T/bQ==
X-Gm-Message-State: AOAM530mLyjWCDF2/lYK/MDbsI3djKFPThk1HQdt49gxO8+XK7eEvhof
 PMGK4vm21Lznz0FUPP6yPOyR7O4x4webGp1SQDCc+Q==
X-Google-Smtp-Source: ABdhPJxzodXQqLhLPfzMvxo2OHubv3t6cD0Sl4TaPP/Y1UnmLsUpcHicO2BtsMPwbhbOKSkDPHuAo5Vc9TtcI0L9aoE=
X-Received: by 2002:a05:6512:34c3:: with SMTP id
 w3mr15837701lfr.122.1594101823881; 
 Mon, 06 Jul 2020 23:03:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200630044943.3425049-1-rajatja@google.com>
 <20200630044943.3425049-6-rajatja@google.com>
 <20200630104948.GC856968@kuha.fi.intel.com>
 <20200630125216.GA1109228@kroah.com>
 <CAJZ5v0iYFKrouQx_b7afPnz7ohjWOKKDhdHj_3HObKYV_rRhiw@mail.gmail.com>
 <20200630153816.GD1785141@kroah.com>
 <CAJZ5v0jUx-RVhJRDngkOXx-3szFJDOgCJs2yuGKFyo2f1qZAwA@mail.gmail.com>
 <20200630170012.GB1894898@kroah.com>
 <CACK8Z6Fcrb8PtmbUJLn8RgiGnC8eqTC9GjsgjPmQgU212WPU0Q@mail.gmail.com>
 <CAOSf1CEZ82iXhYnig0UScS+oRRaxHzSCge9LbA1hW3NaQAiSxQ@mail.gmail.com>
In-Reply-To: <CAOSf1CEZ82iXhYnig0UScS+oRRaxHzSCge9LbA1hW3NaQAiSxQ@mail.gmail.com>
Date: Mon, 6 Jul 2020 23:03:07 -0700
Message-ID: <CACK8Z6EqTkHbWQdWB-yGapUrtiesxEv=S8OCsoxf+AzVAj9jJA@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] driver core: Add device location to "struct
 device" and expose it in sysfs
To: "Oliver O'Halloran" <oohall@gmail.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Linux PCI <linux-pci@vger.kernel.org>,
 "Krishnakumar, Lalithambika" <lalithambika.krishnakumar@intel.com>,
 Todd Broch <tbroch@google.com>, Diego Rivas <diegorivas@google.com>,
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
 Arnd Bergmann <arnd@arndb.de>, Benson Leung <bleung@google.com>,
 David Woodhouse <dwmw2@infradead.org>, Alex Levin <levinale@google.com>
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

On Wed, Jul 1, 2020 at 10:23 PM Oliver O'Halloran <oohall@gmail.com> wrote:
>
> On Thu, Jul 2, 2020 at 4:07 AM Rajat Jain <rajatja@google.com> wrote:
> >
> > *snip*
> >
> > > > I guess it would make sense to have an attribute for user space to
> > > > write to in order to make the kernel reject device plug-in events
> > > > coming from a given port or connector, but the kernel has no reliable
> > > > means to determine *which* ports or connectors are "safe", and even if
> > > > there was a way for it to do that, it still may not agree with user
> > > > space on which ports or connectors should be regarded as "safe".
> > >
> > > Again, we have been doing this for USB devices for a very long time, PCI
> > > shouldn't be any different.  Why people keep ignoring working solutions
> > > is beyond me, there's nothing "special" about PCI devices here for this
> > > type of "worry" or reasoning to try to create new solutions.
> > >
> > > So, again, I ask, go do what USB does, and to do that, take the logic
> > > out of the USB core, make it bus-agnositic, and _THEN_ add it to the PCI
> > > code. Why the original submitter keeps ignoring my request to do this
> > > is beyond me, I guess they like making patches that will get rejected :(
> >
> > IMHO I'm actually trying to precisely do what I think was the
> > conclusion of our discussion, and then some changes because of the
> > further feedback I received on those patches. Let's take a step back
> > and please allow me to explain how I got here (my apologies but this
> > spans a couple of threads, and I"m trying to tie them all together
> > here):
>
> The previous thread had some suggestions, but no real conclusions.
> That's probably why we're still arguing about it...
>
> > GOAL: To allow user space to control what (PCI) drivers he wants to
> > allow on external (thunderbolt) ports. There was a lot of debate about
> > the need for such a policy at
> > https://lore.kernel.org/linux-pci/CACK8Z6GR7-wseug=TtVyRarVZX_ao2geoLDNBwjtB+5Y7VWNEQ@mail.gmail.com/
> > with the final conclusion that it should be OK to implement such a
> > policy in userspace, as long as the policy is not implemented in the
> > kernel. The kernel only needs to expose bits & info that is needed by
> > the userspace to implement such a policy, and it can be used in
> > conjunction with "drivers_autoprobe" to implement this policy:
> > --------------------------------------------------------------------
> > ....
> > That's an odd thing, but sure, if you want to write up such a policy for
> > your systems, great.  But that policy does not belong in the kernel, it
> > belongs in userspace.
> > ....
> > --------------------------------------------------------------------
> > 1) The post https://lore.kernel.org/linux-pci/20200609210400.GA1461839@bjorn-Precision-5520/
> > lists out the approach that was agreed on. Replicating it here:
> > -----------------------------------------------------------------------
> >   - Expose the PCI pdev->untrusted bit in sysfs.  We don't expose this
> >     today, but doing so would be trivial.  I think I would prefer a
> >     sysfs name like "external" so it's more descriptive and less of a
> >     judgment.
> >
> >     This comes from either the DT "external-facing" property or the
> >     ACPI "ExternalFacingPort" property.
> >
> >   - All devices present at boot are enumerated.  Any statically built
> >     drivers will bind to them before any userspace code runs.
> >
> >     If you want to keep statically built drivers from binding, you'd
> >     need to invent some mechanism so pci_driver_init() could clear
> >     drivers_autoprobe after registering pci_bus_type.
> >
> >   - Early userspace code prevents modular drivers from automatically
> >     binding to PCI devices:
> >
> >       echo 0 > /sys/bus/pci/drivers_autoprobe
> >
> >     This prevents modular drivers from binding to all devices, whether
> >     present at boot or hot-added.
> >
> >   - Userspace code uses the sysfs "bind" file to control which drivers
> >     are loaded and can bind to each device, e.g.,
> >
> >       echo 0000:02:00.0 > /sys/bus/pci/drivers/nvme/bind
>
> I think this is a reasonable suggestion. However, as Greg pointed out
> it's gratuitously different to what USB does for no real reason.
>
> > -----------------------------------------------------------------------
> > 2) As part of implementing the above agreed approach, when I exposed
> > PCI "untrusted" attribute to userspace, it ran into discussion that
> > concluded that instead of this, the device core should be enhanced
> > with a location attribute.
> > https://lore.kernel.org/linux-pci/20200618184621.GA446639@kroah.com/
> > -----------------------------------------------------------------------
> > ...
> > The attribute should be called something like "location" or something
> > like that (naming is hard), as you don't always know if something is
> > external or not (it could be internal, it could be unknown, it could be
> > internal to an external device that you trust (think PCI drawers for
> > "super" computers that are hot pluggable but yet really part of the
> > internal bus).
> > ....
> > "trust" has no direct relation to the location, except in a policy of
> > what you wish to do with that device, so as long as you keep them
> > separate that way, I am fine with it.
> > ...
> > -----------------------------------------------------------------------
> >
> > And hence this patch. I don't see an attribute in USB comparable to
> > this new attribute, except for the boolean "removable" may be. Are you
> > suggesting to pull that into the device core instead of adding this
> > "physical_location" attribute?
>
> He's suggesting you pull the "authorized" attribute into the driver
> core. That's the mechanism USB uses to block drivers binding unless
> userspace authorizes them. I don't see any reason why we can't re-use
> that sysfs interface for PCI devices since the problem being solved is
> fundamentally the same. The main question is what we should do as a
> default policy in the kernel. For USB the default comes from the
> "authorized_default" module param of usbcore:
>
> > /* authorized_default behaviour:
> >  * -1 is authorized for all devices except wireless (old behaviour)
> >  * 0 is unauthorized for all devices
> >  * 1 is authorized for all devices
> >  * 2 is authorized for internal devices
> >  */
> > #define USB_AUTHORIZE_WIRED   -1
> > #define USB_AUTHORIZE_NONE    0
> > #define USB_AUTHORIZE_ALL     1
> > #define USB_AUTHORIZE_INTERNAL        2
> >
> > static int authorized_default = USB_AUTHORIZE_WIRED;
> > module_param(authorized_default, int, S_IRUGO|S_IWUSR);
>
> So the default policy for USB is to authorize any wired USB device and
> we can optionally restrict that to just integrated devices. Sounding
> familiar?

Thank you for explaining! It is a lot more clear now :-)

I have separated out the PCI portions of this patchset (patches 1-4
i.e. ones not related to this controversial change) into its own
patchset. W.r.t patches 5-7, I think I'd like to collect my thoughts
and send out a fresh RFC once I am ready (I'm running out of time on
my deliverables so may have to carry some patches internally for the
time being). But 2 quick points:

1) Currently there are already at least 2 existing buses with their
own versions of "authorized": usb and thunderbolt, and the UAPI /
semantics of "authorized" is different amongst these.

Documentation/ABI/testing/sysfs-bus-thunderbolt - "authorized" is boolean
Documentation/usb/authorization.rst  - "authorized" is 0/1/2

(Side note: In addition to that, usb also has additional "authorized"
related attributes e.g. interface_authorized_default etc which might
not have an easy corresponding sensible meaning in other buses, so we
may have to still leave it in USB.)

So my question is, assuming we do not want to change or break existing
UAPI, if I move the "authorized" attribute to the device core, who
defines the semantics of the values it can take? It seems to me like
individual buses should define that. And if so, then device core
cannot use "authorized" value to decide to prevent drivers from
binding to it?

2) It seemed to me
(https://lore.kernel.org/linux-acpi/20200618184621.GA446639@kroah.com/)
that we had at least somewhat agreement that the location of a device
is a useful piece of info to have for userspace to have. The point I'm
trying to make is that "exporting the location of device in sysfs"
seems independent of "move untrusted attribute to the device core".
LIke you said below, location of device is still useful (may not be
sufficient, BMC case you mention) for the userspace to have, in order
to decide whether to allow a device.  So why object to this patch?

Thanks,

Rajat



>
> The internal / external status is still useful to know so we might
> want to make a sysfs attribute for that too. However, I'd like to
> point out that internal / external isn't the whole story. As I
> mentioned in the last thread if I have a BMC device I *really* don't
> want it to be authorized by default even though it's an internal
> device. Similarly, if I know all my internal cards support PCIe
> Component Authentication then I might choose not to trust any PCI
> devices unless they authenticate successfully.
>
> > 3) The one deviation from the agreed approach in (1) is
> > https://patchwork.kernel.org/patch/11633095/ . The reason is I
> > realized that contrary to what I earlier believed, we might not be
> > able to disable the PCI link to all external PCI devices at boot. So
> > external PCI devices may actually bind to drivers before userspace
> > comes up and does "echo 0 > /sys/bus/pci/drivers_autoprobe").
>
> Yep, that's a problem. If we want to provide a useful mechanism to
> userspace then the default behaviour of the kernel can't undermine
> that mechanism. If that means we need another kernel command line
> parameter then I guess we just have to live with it.
>
> Oliver
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
