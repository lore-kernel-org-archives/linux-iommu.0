Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7914C433EF
	for <iommu@archiver.kernel.org>; Fri, 15 Apr 2022 22:15:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 798D161165;
	Fri, 15 Apr 2022 22:15:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id moNR_kqFMUmF; Fri, 15 Apr 2022 22:15:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4EC0A60E30;
	Fri, 15 Apr 2022 22:15:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0D195C0033;
	Fri, 15 Apr 2022 22:15:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B31C5C002C
 for <iommu@lists.linux-foundation.org>; Fri, 15 Apr 2022 22:15:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9A8DD61165
 for <iommu@lists.linux-foundation.org>; Fri, 15 Apr 2022 22:15:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YNyuqfYlFD0k for <iommu@lists.linux-foundation.org>;
 Fri, 15 Apr 2022 22:15:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7541B60E30
 for <iommu@lists.linux-foundation.org>; Fri, 15 Apr 2022 22:15:13 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by sin.source.kernel.org (Postfix) with ESMTPS id B03E1CE31AD;
 Fri, 15 Apr 2022 22:15:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDF39C385A4;
 Fri, 15 Apr 2022 22:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1650060908;
 bh=s0Dk+7YpW8NELxA7hL4hxZKqgZ+VVInWF3zxwlrWQ8Y=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=mWa9A5pSTPbpb4OH489eFDoOPOebYkSL0TyfWWeXqI9ObwL3QN4NooutjQhdqYfVA
 P31YIk8uoXovQZ4uKieXMISW5jSTGLM32Xp/FF8AjRhIlBDCH+stwfaaxG70ULJGDW
 Wnx/bccL5gl290yieW3KZvj9ou5IwY7CLkW6/mAnyL0gdnJGf1OZwOAL7l7Debe0nE
 4kLZieNBHZALIEGeKkryhv4OgJtotVulutog5aOfM2UmXSRMDcekYDjVYgJ0Om8hRk
 wdi1RQLssP7NH+ncNJsiiJPwJj3GswVYN+ztyfBGWMt30VK8HjFzaiZ3DD3dEpUems
 jw9nHoAprKjWw==
Date: Fri, 15 Apr 2022 17:15:06 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Rajat Jain <rajatja@google.com>
Subject: Re: [PATCH v5 1/2] PCI: ACPI: Support Microsoft's "DmaProperty"
Message-ID: <20220415221506.GA851834@bhelgaas>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CACK8Z6Fy3L7vijVn4w+6HwRuuTtW5ePrWc04rUc8U8TPT0Re0w@mail.gmail.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Rajat Jain <rajatxjain@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pci@vger.kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Jesse Barnes <jsbarnes@google.com>,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 iommu@lists.linux-foundation.org, Oliver O'Halloran <oohall@gmail.com>,
 Pavel Machek <pavel@denx.de>, Bjorn Helgaas <bhelgaas@google.com>,
 Will Deacon <will@kernel.org>, David Woodhouse <dwmw2@infradead.org>,
 Dmitry Torokhov <dtor@google.com>, Len Brown <lenb@kernel.org>
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

On Thu, Apr 14, 2022 at 04:15:47PM -0700, Rajat Jain via iommu wrote:
> On Thu, Apr 7, 2022 at 12:17 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Fri, Mar 25, 2022 at 11:46:08AM -0700, Rajat Jain wrote:

> > > Support the "DmaProperty" with the same semantics. This is useful for
> > > internal PCI devices that do not hang off a PCIe rootport, but offer
> > > an attack surface for DMA attacks (e.g. internal network devices).
> >
> > Same semantics as what?
> 
> Er, I meant the same semantics as the "DmaProperty". Please also see below.

"Support the 'DmaProperty' with the same semantics as 'DmaProperty'"
doesn't help much, so there must be a little more to the story :)

> > The MS description of "ExternalFacingPort" says:
> >
> >   This ACPI object enables the operating system to identify externally
> >   exposed PCIe hierarchies, such as Thunderbolt.
> 
> No, my patch doesn't have to do with this one.

I know, but it's similar, and I'm just hoping we can deal with them
consistently.

> > and "DmaProperty" says:
> >
> >   This ACPI object enables the operating system to identify internal
> >   PCIe hierarchies that are easily accessible by users (such as,
> >   Laptop M.2 PCIe slots accessible by way of a latch) and require
> >   protection by the OS Kernel DMA Protection mechanism.
> 
> Yes, this is the property that my patch uses. Microsoft has agreed to
> update this documentation (in a sideband thread that I also copied you
> on), with the updated semantics that this property can be used to
> identify any PCI devices that require Kernel DMA protection. i.e. the
> property is not restricted to identify "internal PCIe hierarchies"
> (starting at root port), but to "any PCI device".
> 
> > I don't really understand why they called out "laptop M.2 PCIe slots"
> > here.  Is the idea that those are more accessible than a standard
> > internal PCIe slot?  Seems like a pretty small distinction to me.
> >
> > I can understand your example of internal network devices adding an
> > attack surface.  But I don't see how "DmaProperty" helps identify
> > those.  Wouldn't a NIC in a standard internal PCIe slot add the same
> > attack surface?
> 
> Yes it would. The attack surface is the same. They probably only
> thought of devices external to the SoC (starting from a root port)
> when designing this property and thus called out internal M.2 PCI
> slots. But nowhave realized that this could be opened to any PCI
> device.

> > > +      * Property also used by Microsoft Windows for same purpose,
> > > +      * (to implement DMA protection from a device, using the IOMMU).
> > > +      */
> > > +     if (device_property_read_u8(&dev->dev, "DmaProperty", &val))
> >
> > The MS web page says a _DSD with this property must be implemented in
> > the Root Port device scope, but we don't enforce that here.  We *do*
> > enforce it in pci_acpi_set_untrusted().  Shouldn't we do the same
> > here?
> 
> No, the whole point of doing this (please refer to the discussion on
> the previous versions of this patch) was that we want to have a
> property that is NOT limited to the root ports only. And we have
> reached an agreement with Microsoft about that.

We need to either mention the fact that we're going beyond what the MS
web page says or (ideally, as you are doing) get the page updated with
the semantics you need.

> > But IIUC, device_property_read_u8() works for either ACPI or DT
> > properties, and maybe there is interest in using this for DT systems.
> > None of these appear in any in-tree DTs, but maybe it is important to
> > handle these in DTs?
> >
> > If that's the case, this code would no longer be specific to ACPI and
> > should be moved to somewhere that's compiled even when CONFIG_ACPI
> > isn't set.
> 
> I think unifying ACPI and GPIO systems to use the same code / function
> to read the properties might be more work/investigation, because
> reading the properties for ACPI system happens much later than DT
> systems (For acpi systems, it happens in pci_acpi_setup() which is
> called much later). Given that no one wants to use this for DT
> systems, I'd prefer for this to be ACPI specific for now, and then we
> can solve it for DT once someone needs it.

I think it's OK to make it ACPI-specific for now.

Bjorn
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
