Return-Path: <SRS0=8RI2=CG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C5D2C433E6
	for <iommu@archiver.kernel.org>; Fri, 28 Aug 2020 18:30:05 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E17222074A
	for <iommu@archiver.kernel.org>; Fri, 28 Aug 2020 18:30:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aCTaFZU+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vXG0XUsJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E17222074A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id A4D3D882D1;
	Fri, 28 Aug 2020 18:30:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OYYclY+DjEs0; Fri, 28 Aug 2020 18:30:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 167DC8820C;
	Fri, 28 Aug 2020 18:30:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0648FC07FF;
	Fri, 28 Aug 2020 18:30:04 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E25E6C0051
 for <iommu@lists.linux-foundation.org>; Fri, 28 Aug 2020 18:30:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id C626F84E0A
 for <iommu@lists.linux-foundation.org>; Fri, 28 Aug 2020 18:30:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GJl8kQ00YtTS for <iommu@lists.linux-foundation.org>;
 Fri, 28 Aug 2020 18:30:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 31A9D84DD1
 for <iommu@lists.linux-foundation.org>; Fri, 28 Aug 2020 18:30:01 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1598639398;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HQQ3PgkKo2hS5HQKNaJ3P1IptF/ClXfBwAd1n3Worn0=;
 b=aCTaFZU+e8x0x58wJ1oeYUMPHmUAbdjR6qrLnzUL2j3Joo6UWr9US/cCwRlh/cn/Dvl3Ea
 AvjuuOBWjpzVXAXBQyGeg3gInDAiqfY9sH0WgQWHi3NyPKyTXpj7zFsze/QeG7xMPEXKCT
 iIrXwbhXKciDtYdzmRP42PwSOTAibh/Ci9iyIDxL9JGAZZDFCWmomrS+tkBweJNjmV2kjb
 BbgDTKvuYwHkEpQDeFwqMNmNeXfaqNVEON0+suObP1Oa+wJK8Ot+NeM4+0tLDCDC/otdSb
 sRbMsWVyem66C8lTMSZznkBMUmQrRkEU4Yxl7AH+oxxHZ72nlgzHwSoX1gI+cQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1598639398;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HQQ3PgkKo2hS5HQKNaJ3P1IptF/ClXfBwAd1n3Worn0=;
 b=vXG0XUsJMIi3DkkPAd4hFW5NyIUjTPD3/KRNdL6hTZ3E1uRKkBApmbjwrrLTXyfG5+s5Mw
 6hQo8a2K/hj9JbDA==
To: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [patch V2 34/46] PCI/MSI: Make arch_.*_msi_irq[s] fallbacks
 selectable
In-Reply-To: <20200827182040.GA2049623@bjorn-Precision-5520>
References: <20200827182040.GA2049623@bjorn-Precision-5520>
Date: Fri, 28 Aug 2020 20:29:57 +0200
Message-ID: <873646lj2y.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Cc: Dimitri Sivanich <sivanich@hpe.com>, linux-hyperv@vger.kernel.org,
 Steve Wahl <steve.wahl@hpe.com>, linux-pci@vger.kernel.org,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Dan Williams <dan.j.williams@intel.com>, Rob Herring <robh@kernel.org>,
 Wei Liu <wei.liu@kernel.org>, Stephen Hemminger <sthemmin@microsoft.com>,
 Baolu Lu <baolu.lu@intel.com>, Marc Zyngier <maz@kernel.org>, x86@kernel.org,
 Jason Gunthorpe <jgg@mellanox.com>, Megha Dey <megha.dey@intel.com>,
 xen-devel@lists.xenproject.org, Kevin Tian <kevin.tian@intel.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Dave Jiang <dave.jiang@intel.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Jon Derrick <jonathan.derrick@intel.com>, Juergen Gross <jgross@suse.com>,
 Russ Anderson <rja@hpe.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 Jacob Pan <jacob.jun.pan@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>
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

On Thu, Aug 27 2020 at 13:20, Bjorn Helgaas wrote:
> On Wed, Aug 26, 2020 at 01:17:02PM +0200, Thomas Gleixner wrote:
>> Make the architectures and drivers which rely on them select them in Kconfig
>> and if not selected replace them by stub functions which emit a warning and
>> fail the PCI/MSI interrupt allocation.
>
> Sorry, I really don't understand this, so these are probably stupid
> questions.
>
> If CONFIG_PCI_MSI_ARCH_FALLBACKS is defined, we will supply
> implementations of:
>
>   arch_setup_msi_irq
>   arch_teardown_msi_irq
>   arch_setup_msi_irqs
>   arch_teardown_msi_irqs
>   default_teardown_msi_irqs    # non-weak
>
> You select CONFIG_PCI_MSI_ARCH_FALLBACKS for ia64, mips, powerpc,
> s390, sparc, and x86.  I see that all of those arches implement at
> least one of the functions above.  But x86 doesn't and I can't figure
> out why it needs to select CONFIG_PCI_MSI_ARCH_FALLBACKS.

X86 still has them at that point in the series and the next patch
removes them. I wanted to have the warnings in place before doing so.

> I assume there's a way to convert these arches to hierarchical irq
> domains so they wouldn't need this at all?  Is there a sample
> conversion to look at?

For a quick and dirty step it's pretty much the wrapper I used for XEN
and then make sure that the msi_domain pointer is populated is
pci_device::device.

> And I can't figure out what's special about tegra, rcar, and xilinx
> that makes them need it as well.

Those are old drivers from the time where ARM did not use hierarchical
irq domains and nobody cared to fix them up.

> Is there something I could grep for
> to identify them?

git grep arch_setup_msi_irq
git grep arch_teardown_msi_irq

> Is there a way to convert them so they don't need it?

Sure, it just needs some work and probably hardware to test.

Thanks,

        tglx
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
