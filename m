Return-Path: <SRS0=S+y3=AR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5A21C433E0
	for <iommu@archiver.kernel.org>; Mon,  6 Jul 2020 23:41:22 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6680620720
	for <iommu@archiver.kernel.org>; Mon,  6 Jul 2020 23:41:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="e4ZoJPfJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6680620720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 3267988B8E;
	Mon,  6 Jul 2020 23:41:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 46HaL5A9V2+R; Mon,  6 Jul 2020 23:41:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 7DBBF86CDB;
	Mon,  6 Jul 2020 23:41:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6217DC0893;
	Mon,  6 Jul 2020 23:41:21 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 330E1C016F
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jul 2020 23:41:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 2774B88574
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jul 2020 23:41:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Jn8pAp459BsF for <iommu@lists.linux-foundation.org>;
 Mon,  6 Jul 2020 23:41:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lj1-f195.google.com (mail-lj1-f195.google.com
 [209.85.208.195])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 0BEFA8855F
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jul 2020 23:41:19 +0000 (UTC)
Received: by mail-lj1-f195.google.com with SMTP id 9so47680151ljv.5
 for <iommu@lists.linux-foundation.org>; Mon, 06 Jul 2020 16:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Qj0obXfHw+PyCzXxfPBrAWthmmsaPQNxN4o0aIsqBxY=;
 b=e4ZoJPfJCzUv6JiW/ZtKDNwoYQa+BkxY90CNz+S6LE9+7RRt6w4/OAJaTtKXSYhbbF
 oYS0eHWn6OMcxWzbDErcbfbew+X7a6zOBBM6D7f3BIbOaa3bo7kz7TEWGRTKU+1SMROJ
 Uwh+5IvhJYVUsrx3MhOx+3bLdeW7f6pDZsALQBMQiwWMlGokj2qDJ33L/f/aRPXd/Yec
 r7GUTyQDIUkMC7W5jzQUw97nbmg4R/8kNhWAmD/VgGQab7U+hMRgK/zmuD6xQSw28Ovt
 /77UzmwH9JzQPTeu0U2tUJjGo+FYeTGxCf8Ec8gnCy1loG1SpwudA757MIn0qLMe6X2I
 O63w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Qj0obXfHw+PyCzXxfPBrAWthmmsaPQNxN4o0aIsqBxY=;
 b=BB2GPjFM5Kb6JBe9adVgThUhgKyKmOsAWnYXubf0G/Zhs/HZu4ZxlIVIMz+NCXgzPQ
 +hkbXqa4lCL8CkGMccIw2K5FxLjhSMHQgvcazEcGHg8CLK/dwhNgdhcAMgDGOe6HSJwI
 baK0YbNr60qsTHwnkWURJhaNPcx7+4rRjUecsAcDQWC+pf+0KZRWn7cGmpW632isvuc3
 ekp6ry7x+1VR/v+skA4kXiFVuGQXTd2dW5KnCDJahRYSsD3q91r6F/pX2LZC2Z63VMrd
 NDZTRTCy6DsiBb5XXZT1FVj2DXOqO9StAkzd7kXYuyYHUdkcC2odTYnsEuSBnmY1vxCj
 iFUw==
X-Gm-Message-State: AOAM5330wfosHMdsBBs5ckL2ku0TLCIsrvgenmudfuoobBUoMezUC9fP
 sdg7sAfCb5I7RoLEgYW4qH1SA16sCjUslu1eFQc9/w==
X-Google-Smtp-Source: ABdhPJyJE3f+I6Cf0x7ChQa/hx1i7/Jjwak0JpIGwoSbWZNYPbEKzMKAPHJY1Bta2Hsh06yLSlYqq3OVhVwzS1hDg9w=
X-Received: by 2002:a2e:858e:: with SMTP id b14mr30029014lji.301.1594078876784; 
 Mon, 06 Jul 2020 16:41:16 -0700 (PDT)
MIME-Version: 1.0
References: <CACK8Z6FhWyZOJvkrPcHacyvJucGMupOpL=Jm8BpyO7wPrZ_DQA@mail.gmail.com>
 <20200706233040.GA169334@bjorn-Precision-5520>
In-Reply-To: <20200706233040.GA169334@bjorn-Precision-5520>
Date: Mon, 6 Jul 2020 16:40:40 -0700
Message-ID: <CACK8Z6F9zGrOAQ9QQ0Wjt9zbPk3cPnjSTvoZsS_i_Rd0H6Uiiw@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] PCI: Set "untrusted" flag for truly external
 devices only
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

Hello Bjorn,

On Mon, Jul 6, 2020 at 4:30 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Mon, Jul 06, 2020 at 03:31:47PM -0700, Rajat Jain wrote:
> > On Mon, Jul 6, 2020 at 9:38 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > On Mon, Jun 29, 2020 at 09:49:38PM -0700, Rajat Jain wrote:
>
> > > > -static void pci_acpi_set_untrusted(struct pci_dev *dev)
> > > > +static void pci_acpi_set_external_facing(struct pci_dev *dev)
> > > >  {
> > > >       u8 val;
> > > >
> > > > -     if (pci_pcie_type(dev) != PCI_EXP_TYPE_ROOT_PORT)
> > > > +     if (pci_pcie_type(dev) != PCI_EXP_TYPE_ROOT_PORT &&
> > > > +         pci_pcie_type(dev) != PCI_EXP_TYPE_DOWNSTREAM)
> > >
> > > This looks like a change worthy of its own patch.  We used to look for
> > > "ExternalFacingPort" only on Root Ports; now we'll also do it for
> > > Switch Downstream Ports.
> >
> > Can do. (please see below)
> >
> > > Can you include DT and ACPI spec references if they exist?  I found
> > > this mention:
> > > https://docs.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pcie-root-ports
> > > which actually says it should only be implemented for Root Ports.
> >
> > I actually have no references. It seems to me that the microsoft spec
> > assumes that all external ports must be implemented on root ports, but
> > I think it would be equally fair for systems with PCIe switches to
> > implement one on one of their switch downstream ports. I don't have an
> > immediate use of this anyway, so if you think this should rather wait
> > unless someone really has this case, this can wait. Let me know.
>
> I agree that it "makes sense" to pay attention to this property no
> matter where it appears, but since that Microsoft doc went to the
> trouble to restrict it to Root Ports, I think we should leave this
> as-is and only look for it in the Root Port.  Otherwise Linux will
> accept something Windows will reject, and that seems like a needless
> difference.
>
> We can at least include the above link to the Microsoft doc in the
> commit log.

Will do.

>
> > > It also mentions a "DmaProperty" that looks related.  Maybe Linux
> > > should also pay attention to this?
> >
> > Interesting. Since this is not in use currently by the kernel as well
> > as not exposed by (our) BIOS, I don't have an immediate use case for
> > this. I'd like to defer this for later (as-the-need-arises).
>
> I agree, you can defer this until you see a need for it.  I just
> pointed it out in case it would be useful to you.
>
> > > > +     /*
> > > > +      * Devices are marked as external-facing using info from platform
> > > > +      * (ACPI / devicetree). An external-facing device is still an internal
> > > > +      * trusted device, but it faces external untrusted devices. Thus any
> > > > +      * devices enumerated downstream an external-facing device is marked
> > > > +      * as untrusted.
> > >
> > > This comment has a subject/verb agreement problem.
> >
> > I assume you meant s/is/are/ in last sentence. Will do.
>
> Right.  There's also something wrong with "enumerated downstream an".

I'm apparently really bad at English :-). This is what I have in my
latest patch I am about to send out:

"Thus any device enumerated downstream an external-facing device, is
marked as untrusted."

Are you suggesting s/an/a/ ? Please let me know what you would like to
see and I'd copy it as-is :-)

Thanks!

Rajat
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
