Return-Path: <SRS0=cxdO=AM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E73AC433E2
	for <iommu@archiver.kernel.org>; Wed,  1 Jul 2020 18:07:31 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E87C1207F5
	for <iommu@archiver.kernel.org>; Wed,  1 Jul 2020 18:07:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="BsTGPXYC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E87C1207F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 7D4D325E94;
	Wed,  1 Jul 2020 18:07:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0pcsvYEYKB-w; Wed,  1 Jul 2020 18:07:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id C45CF20020;
	Wed,  1 Jul 2020 18:07:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A71F8C0890;
	Wed,  1 Jul 2020 18:07:26 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3089AC0733
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jul 2020 18:07:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 15118228B0
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jul 2020 18:07:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id z1gtJTWJm-9L for <iommu@lists.linux-foundation.org>;
 Wed,  1 Jul 2020 18:07:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lj1-f195.google.com (mail-lj1-f195.google.com
 [209.85.208.195])
 by silver.osuosl.org (Postfix) with ESMTPS id 3F03920020
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jul 2020 18:07:22 +0000 (UTC)
Received: by mail-lj1-f195.google.com with SMTP id s1so28322106ljo.0
 for <iommu@lists.linux-foundation.org>; Wed, 01 Jul 2020 11:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=GPchDjqYkLt5LIbAVBTKAkoGd+R4o2ZdbYc6covxDDQ=;
 b=BsTGPXYCVpVlqYTgEWspxnsolANEIVOz/7dLLUO7vQR+2YRsZH1dYqAY7a9jjyk+ye
 h+/+hovMD55Db+/6KXS2T2vM/It5sYnq0hOMDZ19nCKCxlXJOufqu8Qt0LDGM7cd8Pb1
 LKeLBupoZJrJpuNVbRF9Aip1T2pZTKw2qWly1NDPQcvHskkCnL3zaapLf1s4GP222gUI
 6HqjLvF5gwpcZE1D8h9AgakZFIp+b8wX5u1aF819W7kdKkggCJER8c/I8C52EGeabGNa
 xE79UWetUqTFSxFMGrdglLqjEmyYgIJYMM/OOg2uxXYMddi2z+bBGWTSMM5wbV7Rc5zG
 whPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=GPchDjqYkLt5LIbAVBTKAkoGd+R4o2ZdbYc6covxDDQ=;
 b=l6hFpDt32vXkWWstKaEGEaVDwF+mkgdBhgD4fwnGTVxYKlU2SATgxHlm0HSasCvvAV
 taWlI6QEImE2Yna7twbB47WpGYehWx6Sv/w2zcev6n8zjfesfWSPm2zX2cqE1TZPXvoO
 PaC5TZ2aiPFgLq/hH/KelS1ipv72ipvlQGyw7EsA/xnDJ7zimBqTedZ385JLvJdl8Q9R
 i8VytSUpdB44Zhf6vDxHaY7iPS1j1Y4xD1hN6jUNgnCM42HPpViR/mud6A1+VoERxjFO
 FNCOEasQI/QPgDGJ0Th/0yrv1X5ifJxWn/X3wvehoPogKz5wrrUG/Ph4NwKf30OF7h2n
 jxHw==
X-Gm-Message-State: AOAM531o4od5JeWtt7V+T2bqZNWCSOUiJStEf6/5OQ5vCbz7np+sHlk1
 TAntYPleXLdNgUGonHhL1j1o7q0B/T+b0VAEI+hbpQ==
X-Google-Smtp-Source: ABdhPJyL3NPG9USNMnYd3yLWIqT+Oua7tSa5MNUojDCvTt+lpV65yUAnQ072eSVg/tCyEjA3gs/6Bzinn189gX4/V3E=
X-Received: by 2002:a05:651c:550:: with SMTP id
 q16mr13910527ljp.188.1593626839643; 
 Wed, 01 Jul 2020 11:07:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200630044943.3425049-1-rajatja@google.com>
 <20200630044943.3425049-6-rajatja@google.com>
 <20200630104948.GC856968@kuha.fi.intel.com>
 <20200630125216.GA1109228@kroah.com>
 <CAJZ5v0iYFKrouQx_b7afPnz7ohjWOKKDhdHj_3HObKYV_rRhiw@mail.gmail.com>
 <20200630153816.GD1785141@kroah.com>
 <CAJZ5v0jUx-RVhJRDngkOXx-3szFJDOgCJs2yuGKFyo2f1qZAwA@mail.gmail.com>
 <20200630170012.GB1894898@kroah.com>
In-Reply-To: <20200630170012.GB1894898@kroah.com>
Date: Wed, 1 Jul 2020 11:06:43 -0700
Message-ID: <CACK8Z6Fcrb8PtmbUJLn8RgiGnC8eqTC9GjsgjPmQgU212WPU0Q@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] driver core: Add device location to "struct
 device" and expose it in sysfs
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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

Hello,

On Tue, Jun 30, 2020 at 10:00 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Jun 30, 2020 at 06:08:31PM +0200, Rafael J. Wysocki wrote:
> > On Tue, Jun 30, 2020 at 5:38 PM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Tue, Jun 30, 2020 at 03:00:34PM +0200, Rafael J. Wysocki wrote:
> > > > On Tue, Jun 30, 2020 at 2:52 PM Greg Kroah-Hartman
> > > > <gregkh@linuxfoundation.org> wrote:
> > > > >
> > > > > On Tue, Jun 30, 2020 at 01:49:48PM +0300, Heikki Krogerus wrote:
> > > > > > On Mon, Jun 29, 2020 at 09:49:41PM -0700, Rajat Jain wrote:
> > > > > > > Add a new (optional) field to denote the physical location of a device
> > > > > > > in the system, and expose it in sysfs. This was discussed here:
> > > > > > > https://lore.kernel.org/linux-acpi/20200618184621.GA446639@kroah.com/
> > > > > > >
> > > > > > > (The primary choice for attribute name i.e. "location" is already
> > > > > > > exposed as an ABI elsewhere, so settled for "site"). Individual buses
> > > > > > > that want to support this new attribute can opt-in by setting a flag in
> > > > > > > bus_type, and then populating the location of device while enumerating
> > > > > > > it.
> > > > > >
> > > > > > So why not just call it "physical_location"?
> > > > >
> > > > > That's better, and will allow us to put "3rd blue plug from the left,
> > > > > 4th row down" in there someday :)
> > > > >
> > > > > All of this is "relative" to the CPU, right?  But what CPU?  Again, how
> > > > > are the systems with drawers of PCI and CPUs and memory that can be
> > > > > added/removed at any point in time being handled here?  What is
> > > > > "internal" and "external" for them?
> > > > >
> > > > > What exactly is the physical boundry here that is attempting to be
> > > > > described?
> > > >
> > > > Also, where is the "physical location" information going to come from?
> > >
> > > Who knows?  :)
> > >
> > > Some BIOS seem to provide this, but do you trust that?
> > >
> > > > If that is the platform firmware (which I suspect is the anticipated
> > > > case), there may be problems with reliability related to that.
> > >
> > > s/may/will/
> > >
> > > which means making the kernel inact a policy like this patch series
> > > tries to add, will result in a lot of broken systems, which is why I
> > > keep saying that it needs to be done in userspace.
> > >
> > > It's as if some of us haven't been down this road before and just keep
> > > being ignored...
> > >
> > > {sigh}
> >
> > Well, to be honest, if you are a "vertical" vendor and you control the
> > entire stack, *including* the platform firmware, it would be kind of
> > OK for you to do that in a product kernel.
> >
> > However, this is not a practical thing to do in the mainline kernel
> > which must work for everybody, including people who happen to use
> > systems with broken or even actively unfriendly firmware on them.
> >
> > So I'm inclined to say that IMO this series "as is" would not be an
> > improvement from the mainline perspective.
>
> It can be, we have been using this for USB devices for many many years
> now, quite successfully.  The key is not to trust that the platform
> firmware got it right :)
>
> > I guess it would make sense to have an attribute for user space to
> > write to in order to make the kernel reject device plug-in events
> > coming from a given port or connector, but the kernel has no reliable
> > means to determine *which* ports or connectors are "safe", and even if
> > there was a way for it to do that, it still may not agree with user
> > space on which ports or connectors should be regarded as "safe".
>
> Again, we have been doing this for USB devices for a very long time, PCI
> shouldn't be any different.  Why people keep ignoring working solutions
> is beyond me, there's nothing "special" about PCI devices here for this
> type of "worry" or reasoning to try to create new solutions.
>
> So, again, I ask, go do what USB does, and to do that, take the logic
> out of the USB core, make it bus-agnositic, and _THEN_ add it to the PCI
> code. Why the original submitter keeps ignoring my request to do this
> is beyond me, I guess they like making patches that will get rejected :(

IMHO I'm actually trying to precisely do what I think was the
conclusion of our discussion, and then some changes because of the
further feedback I received on those patches. Let's take a step back
and please allow me to explain how I got here (my apologies but this
spans a couple of threads, and I"m trying to tie them all together
here):

GOAL: To allow user space to control what (PCI) drivers he wants to
allow on external (thunderbolt) ports. There was a lot of debate about
the need for such a policy at
https://lore.kernel.org/linux-pci/CACK8Z6GR7-wseug=TtVyRarVZX_ao2geoLDNBwjtB+5Y7VWNEQ@mail.gmail.com/
with the final conclusion that it should be OK to implement such a
policy in userspace, as long as the policy is not implemented in the
kernel. The kernel only needs to expose bits & info that is needed by
the userspace to implement such a policy, and it can be used in
conjunction with "drivers_autoprobe" to implement this policy:
--------------------------------------------------------------------
....
That's an odd thing, but sure, if you want to write up such a policy for
your systems, great.  But that policy does not belong in the kernel, it
belongs in userspace.
....
--------------------------------------------------------------------

1) The post https://lore.kernel.org/linux-pci/20200609210400.GA1461839@bjorn-Precision-5520/
lists out the approach that was agreed on. Replicating it here:
-----------------------------------------------------------------------
  - Expose the PCI pdev->untrusted bit in sysfs.  We don't expose this
    today, but doing so would be trivial.  I think I would prefer a
    sysfs name like "external" so it's more descriptive and less of a
    judgment.

    This comes from either the DT "external-facing" property or the
    ACPI "ExternalFacingPort" property.

  - All devices present at boot are enumerated.  Any statically built
    drivers will bind to them before any userspace code runs.

    If you want to keep statically built drivers from binding, you'd
    need to invent some mechanism so pci_driver_init() could clear
    drivers_autoprobe after registering pci_bus_type.

  - Early userspace code prevents modular drivers from automatically
    binding to PCI devices:

      echo 0 > /sys/bus/pci/drivers_autoprobe

    This prevents modular drivers from binding to all devices, whether
    present at boot or hot-added.

  - Userspace code uses the sysfs "bind" file to control which drivers
    are loaded and can bind to each device, e.g.,

      echo 0000:02:00.0 > /sys/bus/pci/drivers/nvme/bind
-----------------------------------------------------------------------

2) As part of implementing the above agreed approach, when I exposed
PCI "untrusted" attribute to userspace, it ran into discussion that
concluded that instead of this, the device core should be enhanced
with a location attribute.
https://lore.kernel.org/linux-pci/20200618184621.GA446639@kroah.com/
-----------------------------------------------------------------------
...
The attribute should be called something like "location" or something
like that (naming is hard), as you don't always know if something is
external or not (it could be internal, it could be unknown, it could be
internal to an external device that you trust (think PCI drawers for
"super" computers that are hot pluggable but yet really part of the
internal bus).
....
"trust" has no direct relation to the location, except in a policy of
what you wish to do with that device, so as long as you keep them
separate that way, I am fine with it.
...
-----------------------------------------------------------------------

And hence this patch. I don't see an attribute in USB comparable to
this new attribute, except for the boolean "removable" may be. Are you
suggesting to pull that into the device core instead of adding this
"physical_location" attribute?

3) The one deviation from the agreed approach in (1) is
https://patchwork.kernel.org/patch/11633095/ . The reason is I
realized that contrary to what I earlier believed, we might not be
able to disable the PCI link to all external PCI devices at boot. So
external PCI devices may actually bind to drivers before userspace
comes up and does "echo 0 > /sys/bus/pci/drivers_autoprobe").

I'm really happy to do what you think is the right way as long as it
helps achieve my goal above. Really looking for clear directions here.

Thanks & Best Regards,

Rajat


> thanks,
>
> greg k-h
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
