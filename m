Return-Path: <SRS0=6E3Y=B7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62860C433E1
	for <iommu@archiver.kernel.org>; Fri, 21 Aug 2020 02:16:45 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35042207DE
	for <iommu@archiver.kernel.org>; Fri, 21 Aug 2020 02:16:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ypwGQhEt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ModaSDKC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35042207DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id DD68786CDD;
	Fri, 21 Aug 2020 02:16:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ducu_EvzeOLm; Fri, 21 Aug 2020 02:16:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 20C0B86CC1;
	Fri, 21 Aug 2020 02:16:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0A92FC0889;
	Fri, 21 Aug 2020 02:16:44 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 67386C0051
 for <iommu@lists.linux-foundation.org>; Fri, 21 Aug 2020 02:16:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 5AF598868A
 for <iommu@lists.linux-foundation.org>; Fri, 21 Aug 2020 02:16:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1JY5-0BnJrRD for <iommu@lists.linux-foundation.org>;
 Fri, 21 Aug 2020 02:16:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 3A1A08868D
 for <iommu@lists.linux-foundation.org>; Fri, 21 Aug 2020 02:16:41 +0000 (UTC)
Message-Id: <20200821002424.119492231@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1597976198;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-transfer-encoding:content-transfer-encoding;
 bh=6NqCao/16SSVwxU3sscyKk1x2qrVHv19Kl/+7RncOTA=;
 b=ypwGQhEtLxJihh7WUOQQEaAMlphwrov24vksOjnplfhLD07eIrUGaOcUsnEzRKsQfyOv/i
 7w3zMDmRM2AoILgUnodia+JhCGDeEecxjS6Pu5B9VOARPg36DZQvZeo3cHLxUaeivTe+oA
 b91J3yONxQwvP86lUhhb4bjxDEGxzXuyNYzWewdtECWVYDomQWqDCXKmI2M3HSXB6Prxt7
 nLYJK526HDM/9meX7y2CpT4QepzWxd6Yg+SAMiq1YT8ZAHqO22TcuSmwUR8pFh1G1hA4Sr
 0Uyr/DE44KKYwFVw7JO1Gl05Kv5vlC356zn0ns8or6odT6MWASx99abAUFd1zg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1597976198;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-transfer-encoding:content-transfer-encoding;
 bh=6NqCao/16SSVwxU3sscyKk1x2qrVHv19Kl/+7RncOTA=;
 b=ModaSDKC/7KPKpfoJXwOupDLtqnQezio5NWZrrxDV9Wdr6vs4o0nJj6hFBppTFsrFMtbmR
 0BGx93AAb/NWdaDg==
Date: Fri, 21 Aug 2020 02:24:24 +0200
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [patch RFC 00/38] x86, PCI, XEN, genirq ...: Prepare for device MSI
Cc: Dimitri Sivanich <sivanich@hpe.com>, linux-hyperv@vger.kernel.org,
 Steve Wahl <steve.wahl@hpe.com>, linux-pci@vger.kernel.org,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Dan Williams <dan.j.williams@intel.com>, Wei Liu <wei.liu@kernel.org>,
 Stephen Hemminger <sthemmin@microsoft.com>, Baolu Lu <baolu.lu@intel.com>,
 Marc Zyngier <maz@kernel.org>, x86@kernel.org,
 Jason Gunthorpe <jgg@mellanox.com>, Megha Dey <megha.dey@intel.com>,
 xen-devel@lists.xenproject.org, Kevin Tian <kevin.tian@intel.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Dave Jiang <dave.jiang@intel.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Jonathan Derrick <jonathan.derrick@intel.com>, Juergen Gross <jgross@suse.com>,
 Russ Anderson <rja@hpe.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 iommu@lists.linux-foundation.org, Jacob Pan <jacob.jun.pan@intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

First of all, sorry for the horrible long Cc list, which was
unfortunately unavoidable as this touches the world and some more.

This patch series aims to provide a base to support device MSI (non
PCI based) in a halfways architecture independent way.

It's a mixed bag of bug fixes, cleanups and general improvements which
are worthwhile independent of the device MSI stuff. Unfortunately this
also comes with an evil abuse of the irqdomain system to coerce XEN on
x86 into compliance without rewriting XEN from scratch.

As discussed in length in this mail thread:

  https://lore.kernel.org/r/87h7tcgbs2.fsf@nanos.tec.linutronix.de

the initial attempt of piggypacking device MSI support on platform MSI
is doomed for various reasons, but creating independent interrupt
domains for these upcoming magic PCI subdevices which are not PCI, but
might be exposed as PCI devices is not as trivial as it seems.

The initially suggested and evaluated approach of extending platform
MSI turned out to be the completely wrong direction and in fact
platform MSI should be rewritten on top of device MSI or completely
replaced by it.

One of the main issues is that x86 does not support the concept of irq
domains associations stored in device::msi_domain and still relies on
the arch_*_msi_irqs() fallback implementations which has it's own set
of problems as outlined in

  https://lore.kernel.org/r/87bljg7u4f.fsf@nanos.tec.linutronix.de/

in the very same thread.

The main obstacle of storing that pointer is XEN which has it's own
historical notiion of handling PCI MSI interupts.

This series tries to address these issues in several steps:

 1) Accidental bug fixes
	iommu/amd: Prevent NULL pointer dereference

 2) Janitoring
	x86/init: Remove unused init ops

 3) Simplification of the x86 specific interrupt allocation mechanism

	x86/irq: Rename X86_IRQ_ALLOC_TYPE_MSI* to reflect PCI dependency
	x86/irq: Add allocation type for parent domain retrieval
	iommu/vt-d: Consolidate irq domain getter
	iommu/amd: Consolidate irq domain getter
	iommu/irq_remapping: Consolidate irq domain lookup

 4) Consolidation of the X86 specific interrupt allocation mechanism to be as close
    as possible to the generic MSI allocation mechanism which allows to get rid
    of quite a bunch of x86'isms which are pointless

	x86/irq: Prepare consolidation of irq_alloc_info
	x86/msi: Consolidate HPET allocation
	x86/ioapic: Consolidate IOAPIC allocation
	x86/irq: Consolidate DMAR irq allocation
	x86/irq: Consolidate UV domain allocation
	PCI: MSI: Rework pci_msi_domain_calc_hwirq()
	x86/msi: Consolidate MSI allocation
	x86/msi: Use generic MSI domain ops

  5) x86 specific cleanups to remove the dependency on arch_*_msi_irqs()

	x86/irq: Move apic_post_init() invocation to one place
	z86/pci: Reducde #ifdeffery in PCI init code
	x86/irq: Initialize PCI/MSI domain at PCI init time
	irqdomain/msi: Provide DOMAIN_BUS_VMD_MSI
	PCI: vmd: Mark VMD irqdomain with DOMAIN_BUS_VMD_MSI
	PCI: MSI: Provide pci_dev_has_special_msi_domain() helper
	x86/xen: Make xen_msi_init() static and rename it to xen_hvm_msi_init()
	x86/xen: Rework MSI teardown
	x86/xen: Consolidate XEN-MSI init
	irqdomain/msi: Allow to override msi_domain_alloc/free_irqs()
	x86/xen: Wrap XEN MSI management into irqdomain
	iommm/vt-d: Store irq domain in struct device
	iommm/amd: Store irq domain in struct device
	x86/pci: Set default irq domain in pcibios_add_device()
	PCI/MSI: Allow to disable arch fallbacks
	x86/irq: Cleanup the arch_*_msi_irqs() leftovers
	x86/irq: Make most MSI ops XEN private

    This one is paving the way to device MSI support, but it comes
    with an ugly and evil hack. The ability of overriding the default
    allocation/free functions of an MSI irq domain is useful in general as
    (hopefully) demonstrated with the device MSI POC, but the abuse
    in context of XEN is evil. OTOH without enough XENology and without
    rewriting XEN from scratch wrapping XEN MSI handling into a pseudo
    irq domain is a reasonable step forward for mere mortals with severly
    limited XENology. One day the XEN folks might make it a real irq domain.
    Perhaps when they have to support the same mess on other architectures.
    Hope dies last...

    At least the mechanism to override alloc/free turned out to be useful
    for implementing the base infrastructure for device MSI. So it's not a
    completely lost case.

  6) X86 specific preparation for device MSI

       x86/irq: Add DEV_MSI allocation type
       x86/msi: Let pci_msi_prepare() handle non-PCI MSI

  7) Generic device MSI infrastructure

       platform-msi: Provide default irq_chip:ack
       platform-msi: Add device MSI infrastructure

  8) Infrastructure for and a POC of an IMS (Interrupt Message
     Storm) irq domain and irqchip implementation

       irqdomain/msi: Provide msi_alloc/free_store() callbacks
       irqchip: Add IMS array driver - NOT FOR MERGING

The whole lot is also available from git:

   git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git device-msi

This has been tested on Intel/AMD/KVM but lacks testing on:

    - HYPERV (-ENODEV)
    - VMD enabled systems (-ENODEV)
    - XEN (-ENOCLUE)

#1 and #2 should be applied unconditionally for obvious reasons
#3-5 are wortwhile cleanups which should be done independent of device MSI

#6-7 look promising to cleanup the platform MSI implementation
     independent of #8, but I neither had cycles nor stomache to tackle that.

#8 is obviously just for the folks interested in IMS

And of course this all started with a 100 lines combo patch to figure
out whether this is possible at all with a reasonable effort. 38
patches later ...

Thanks,

	tglx
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
