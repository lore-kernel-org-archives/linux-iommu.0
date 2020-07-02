Return-Path: <SRS0=8rqH=AN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 402DCC433E1
	for <iommu@archiver.kernel.org>; Thu,  2 Jul 2020 05:23:40 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C813207D4
	for <iommu@archiver.kernel.org>; Thu,  2 Jul 2020 05:23:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qYB6Nf4T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C813207D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 0EA2526046;
	Thu,  2 Jul 2020 05:23:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id d9Cdts961M6Q; Thu,  2 Jul 2020 05:23:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id A5B4A204BE;
	Thu,  2 Jul 2020 05:23:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 96436C0890;
	Thu,  2 Jul 2020 05:23:37 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 232BCC0733
 for <iommu@lists.linux-foundation.org>; Thu,  2 Jul 2020 05:23:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 16C3D8B165
 for <iommu@lists.linux-foundation.org>; Thu,  2 Jul 2020 05:23:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dZp5Dc7iYX+1 for <iommu@lists.linux-foundation.org>;
 Thu,  2 Jul 2020 05:23:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-il1-f196.google.com (mail-il1-f196.google.com
 [209.85.166.196])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 96CB28B163
 for <iommu@lists.linux-foundation.org>; Thu,  2 Jul 2020 05:23:35 +0000 (UTC)
Received: by mail-il1-f196.google.com with SMTP id a11so14885701ilk.0
 for <iommu@lists.linux-foundation.org>; Wed, 01 Jul 2020 22:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=MrIiq6DPHqBGLcGy4awQj5Lf7ocfuRcVU3QA0UqcMzc=;
 b=qYB6Nf4TEwfw/GwxgXjBmvXkwehh+YVaetDdp7hkclhIPnapQdTMsKhe2ZwJ2ruUF8
 e1lgYhAEKSLmH2ZKQDZEg3h2CgunA+w/9jPoC4+QR0+zUfDov7bkT49g9mb0S2WJrMgH
 6hXpgV27P+AfqHwMVph6aZfvyHyfx4x6COiw+youi4BeqYymDTT4oIZbd0TcNwFUvnZ0
 pqG3gqbAk2iDlnAHAAr4ekxxGTSdKrUPqkRDjwvfqzIYOkI6MNYL8DYniIUcqQsn/OvC
 ScSKZ6NYQ9APjTDmidzRCEM0JeEE81VozY/ncio88zD4UlheNeC8yUVwjG/OEqNsoWpP
 C+ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=MrIiq6DPHqBGLcGy4awQj5Lf7ocfuRcVU3QA0UqcMzc=;
 b=AlJbB2GP12P7DL2KUu2bZCvoNkQNkG9wQdhxPhwmHEXTy3cWcsA/Nq1+hBFytsoqGJ
 zEXYq+3yNZAs3te7HfVikxz/qCS7aQrHw6hFamMpi9W1rny5HphgbrsVnfTSoBJGXOLV
 9fKdIlesV3I/zbPQah2uHmwrIy/5CQwPhm1nf3uxdiOYnJc8I7w1olYPwM1ONQqejIxy
 IJznQoan/kkhxLwJTRfYT7Jr4tRpeLrU7IU3tZNaafG2kTOdndKOqWC8L/E6EWAD6w7d
 AD4Uf0RtsnEfXKTBajuOqXtHCOUAloyAHH/JMZQdniBmfTza19Msa7FeBNr7Dct2E5oG
 b5CQ==
X-Gm-Message-State: AOAM533Q36b3EAP1KrhhMoHMudBnu/T0j7iT53w2crBNuAX0lnor5KhE
 uIAkax1lkSyh5dN6JXjUuUFMMgDllfCAKvLRIJc=
X-Google-Smtp-Source: ABdhPJw1rNERV+43T1aSgz1QcWNkBext9nRtzr4Mfiuwrwrl5VMOvx7jOqK/T1tAqNHO9QFkol8bTJx2cfW5MW0tzEM=
X-Received: by 2002:a92:9a97:: with SMTP id c23mr9634019ill.258.1593667414618; 
 Wed, 01 Jul 2020 22:23:34 -0700 (PDT)
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
In-Reply-To: <CACK8Z6Fcrb8PtmbUJLn8RgiGnC8eqTC9GjsgjPmQgU212WPU0Q@mail.gmail.com>
From: "Oliver O'Halloran" <oohall@gmail.com>
Date: Thu, 2 Jul 2020 15:23:23 +1000
Message-ID: <CAOSf1CEZ82iXhYnig0UScS+oRRaxHzSCge9LbA1hW3NaQAiSxQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] driver core: Add device location to "struct
 device" and expose it in sysfs
To: Rajat Jain <rajatja@google.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Thu, Jul 2, 2020 at 4:07 AM Rajat Jain <rajatja@google.com> wrote:
>
> *snip*
>
> > > I guess it would make sense to have an attribute for user space to
> > > write to in order to make the kernel reject device plug-in events
> > > coming from a given port or connector, but the kernel has no reliable
> > > means to determine *which* ports or connectors are "safe", and even if
> > > there was a way for it to do that, it still may not agree with user
> > > space on which ports or connectors should be regarded as "safe".
> >
> > Again, we have been doing this for USB devices for a very long time, PCI
> > shouldn't be any different.  Why people keep ignoring working solutions
> > is beyond me, there's nothing "special" about PCI devices here for this
> > type of "worry" or reasoning to try to create new solutions.
> >
> > So, again, I ask, go do what USB does, and to do that, take the logic
> > out of the USB core, make it bus-agnositic, and _THEN_ add it to the PCI
> > code. Why the original submitter keeps ignoring my request to do this
> > is beyond me, I guess they like making patches that will get rejected :(
>
> IMHO I'm actually trying to precisely do what I think was the
> conclusion of our discussion, and then some changes because of the
> further feedback I received on those patches. Let's take a step back
> and please allow me to explain how I got here (my apologies but this
> spans a couple of threads, and I"m trying to tie them all together
> here):

The previous thread had some suggestions, but no real conclusions.
That's probably why we're still arguing about it...

> GOAL: To allow user space to control what (PCI) drivers he wants to
> allow on external (thunderbolt) ports. There was a lot of debate about
> the need for such a policy at
> https://lore.kernel.org/linux-pci/CACK8Z6GR7-wseug=TtVyRarVZX_ao2geoLDNBwjtB+5Y7VWNEQ@mail.gmail.com/
> with the final conclusion that it should be OK to implement such a
> policy in userspace, as long as the policy is not implemented in the
> kernel. The kernel only needs to expose bits & info that is needed by
> the userspace to implement such a policy, and it can be used in
> conjunction with "drivers_autoprobe" to implement this policy:
> --------------------------------------------------------------------
> ....
> That's an odd thing, but sure, if you want to write up such a policy for
> your systems, great.  But that policy does not belong in the kernel, it
> belongs in userspace.
> ....
> --------------------------------------------------------------------
> 1) The post https://lore.kernel.org/linux-pci/20200609210400.GA1461839@bjorn-Precision-5520/
> lists out the approach that was agreed on. Replicating it here:
> -----------------------------------------------------------------------
>   - Expose the PCI pdev->untrusted bit in sysfs.  We don't expose this
>     today, but doing so would be trivial.  I think I would prefer a
>     sysfs name like "external" so it's more descriptive and less of a
>     judgment.
>
>     This comes from either the DT "external-facing" property or the
>     ACPI "ExternalFacingPort" property.
>
>   - All devices present at boot are enumerated.  Any statically built
>     drivers will bind to them before any userspace code runs.
>
>     If you want to keep statically built drivers from binding, you'd
>     need to invent some mechanism so pci_driver_init() could clear
>     drivers_autoprobe after registering pci_bus_type.
>
>   - Early userspace code prevents modular drivers from automatically
>     binding to PCI devices:
>
>       echo 0 > /sys/bus/pci/drivers_autoprobe
>
>     This prevents modular drivers from binding to all devices, whether
>     present at boot or hot-added.
>
>   - Userspace code uses the sysfs "bind" file to control which drivers
>     are loaded and can bind to each device, e.g.,
>
>       echo 0000:02:00.0 > /sys/bus/pci/drivers/nvme/bind

I think this is a reasonable suggestion. However, as Greg pointed out
it's gratuitously different to what USB does for no real reason.

> -----------------------------------------------------------------------
> 2) As part of implementing the above agreed approach, when I exposed
> PCI "untrusted" attribute to userspace, it ran into discussion that
> concluded that instead of this, the device core should be enhanced
> with a location attribute.
> https://lore.kernel.org/linux-pci/20200618184621.GA446639@kroah.com/
> -----------------------------------------------------------------------
> ...
> The attribute should be called something like "location" or something
> like that (naming is hard), as you don't always know if something is
> external or not (it could be internal, it could be unknown, it could be
> internal to an external device that you trust (think PCI drawers for
> "super" computers that are hot pluggable but yet really part of the
> internal bus).
> ....
> "trust" has no direct relation to the location, except in a policy of
> what you wish to do with that device, so as long as you keep them
> separate that way, I am fine with it.
> ...
> -----------------------------------------------------------------------
>
> And hence this patch. I don't see an attribute in USB comparable to
> this new attribute, except for the boolean "removable" may be. Are you
> suggesting to pull that into the device core instead of adding this
> "physical_location" attribute?

He's suggesting you pull the "authorized" attribute into the driver
core. That's the mechanism USB uses to block drivers binding unless
userspace authorizes them. I don't see any reason why we can't re-use
that sysfs interface for PCI devices since the problem being solved is
fundamentally the same. The main question is what we should do as a
default policy in the kernel. For USB the default comes from the
"authorized_default" module param of usbcore:

> /* authorized_default behaviour:
>  * -1 is authorized for all devices except wireless (old behaviour)
>  * 0 is unauthorized for all devices
>  * 1 is authorized for all devices
>  * 2 is authorized for internal devices
>  */
> #define USB_AUTHORIZE_WIRED   -1
> #define USB_AUTHORIZE_NONE    0
> #define USB_AUTHORIZE_ALL     1
> #define USB_AUTHORIZE_INTERNAL        2
>
> static int authorized_default = USB_AUTHORIZE_WIRED;
> module_param(authorized_default, int, S_IRUGO|S_IWUSR);

So the default policy for USB is to authorize any wired USB device and
we can optionally restrict that to just integrated devices. Sounding
familiar?

The internal / external status is still useful to know so we might
want to make a sysfs attribute for that too. However, I'd like to
point out that internal / external isn't the whole story. As I
mentioned in the last thread if I have a BMC device I *really* don't
want it to be authorized by default even though it's an internal
device. Similarly, if I know all my internal cards support PCIe
Component Authentication then I might choose not to trust any PCI
devices unless they authenticate successfully.

> 3) The one deviation from the agreed approach in (1) is
> https://patchwork.kernel.org/patch/11633095/ . The reason is I
> realized that contrary to what I earlier believed, we might not be
> able to disable the PCI link to all external PCI devices at boot. So
> external PCI devices may actually bind to drivers before userspace
> comes up and does "echo 0 > /sys/bus/pci/drivers_autoprobe").

Yep, that's a problem. If we want to provide a useful mechanism to
userspace then the default behaviour of the kernel can't undermine
that mechanism. If that means we need another kernel command line
parameter then I guess we just have to live with it.

Oliver
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
