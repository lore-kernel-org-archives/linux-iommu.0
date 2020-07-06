Return-Path: <SRS0=S+y3=AR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F27EC433E1
	for <iommu@archiver.kernel.org>; Mon,  6 Jul 2020 23:30:51 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF57F20720
	for <iommu@archiver.kernel.org>; Mon,  6 Jul 2020 23:30:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="f4JVsr+F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF57F20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 77E9F88B72;
	Mon,  6 Jul 2020 23:30:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dYI9QsnV6+nP; Mon,  6 Jul 2020 23:30:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 9E6D288B40;
	Mon,  6 Jul 2020 23:30:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 90EB1C0893;
	Mon,  6 Jul 2020 23:30:49 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4005BC016F
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jul 2020 23:30:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 2E0C1894D3
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jul 2020 23:30:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2XfNUoAEeuir for <iommu@lists.linux-foundation.org>;
 Mon,  6 Jul 2020 23:30:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 83282894BE
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jul 2020 23:30:47 +0000 (UTC)
Received: from localhost (mobile-166-175-191-139.mycingular.net
 [166.175.191.139])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 1A937206DF;
 Mon,  6 Jul 2020 23:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1594078247;
 bh=f2hh0GUopLuKkcXDVWTmfciWI/Nf4mF/htzG+HH8RNU=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=f4JVsr+FBnvTXG/UGYU+BhWL5/GxgtIyQWiYhUmKhQntGNfdpLXH2OTsU18T84J6J
 rozvcMTQ33o4xawcau+dKYIVeXMZClT4LHt5FI2a32iIOtwL6UZQqex47R6nyu3Xiu
 74ZKhPMc9knrbc6jjicKTbDTibtxKc9O39VOPWKg=
Date: Mon, 6 Jul 2020 18:30:40 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Rajat Jain <rajatja@google.com>
Subject: Re: [PATCH v2 2/7] PCI: Set "untrusted" flag for truly external
 devices only
Message-ID: <20200706233040.GA169334@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CACK8Z6FhWyZOJvkrPcHacyvJucGMupOpL=Jm8BpyO7wPrZ_DQA@mail.gmail.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Mon, Jul 06, 2020 at 03:31:47PM -0700, Rajat Jain wrote:
> On Mon, Jul 6, 2020 at 9:38 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Mon, Jun 29, 2020 at 09:49:38PM -0700, Rajat Jain wrote:

> > > -static void pci_acpi_set_untrusted(struct pci_dev *dev)
> > > +static void pci_acpi_set_external_facing(struct pci_dev *dev)
> > >  {
> > >       u8 val;
> > >
> > > -     if (pci_pcie_type(dev) != PCI_EXP_TYPE_ROOT_PORT)
> > > +     if (pci_pcie_type(dev) != PCI_EXP_TYPE_ROOT_PORT &&
> > > +         pci_pcie_type(dev) != PCI_EXP_TYPE_DOWNSTREAM)
> >
> > This looks like a change worthy of its own patch.  We used to look for
> > "ExternalFacingPort" only on Root Ports; now we'll also do it for
> > Switch Downstream Ports.
> 
> Can do. (please see below)
> 
> > Can you include DT and ACPI spec references if they exist?  I found
> > this mention:
> > https://docs.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pcie-root-ports
> > which actually says it should only be implemented for Root Ports.
> 
> I actually have no references. It seems to me that the microsoft spec
> assumes that all external ports must be implemented on root ports, but
> I think it would be equally fair for systems with PCIe switches to
> implement one on one of their switch downstream ports. I don't have an
> immediate use of this anyway, so if you think this should rather wait
> unless someone really has this case, this can wait. Let me know.

I agree that it "makes sense" to pay attention to this property no
matter where it appears, but since that Microsoft doc went to the
trouble to restrict it to Root Ports, I think we should leave this
as-is and only look for it in the Root Port.  Otherwise Linux will
accept something Windows will reject, and that seems like a needless
difference.

We can at least include the above link to the Microsoft doc in the
commit log.

> > It also mentions a "DmaProperty" that looks related.  Maybe Linux
> > should also pay attention to this?
> 
> Interesting. Since this is not in use currently by the kernel as well
> as not exposed by (our) BIOS, I don't have an immediate use case for
> this. I'd like to defer this for later (as-the-need-arises).

I agree, you can defer this until you see a need for it.  I just
pointed it out in case it would be useful to you.

> > > +     /*
> > > +      * Devices are marked as external-facing using info from platform
> > > +      * (ACPI / devicetree). An external-facing device is still an internal
> > > +      * trusted device, but it faces external untrusted devices. Thus any
> > > +      * devices enumerated downstream an external-facing device is marked
> > > +      * as untrusted.
> >
> > This comment has a subject/verb agreement problem.
> 
> I assume you meant s/is/are/ in last sentence. Will do.

Right.  There's also something wrong with "enumerated downstream an".
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
