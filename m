Return-Path: <SRS0=6E3Y=B7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ABC9C433EA
	for <iommu@archiver.kernel.org>; Fri, 21 Aug 2020 02:17:20 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2137C208E4
	for <iommu@archiver.kernel.org>; Fri, 21 Aug 2020 02:17:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eUyv3sON";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="M2AaOXst"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2137C208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 0E04188606;
	Fri, 21 Aug 2020 02:17:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Jy6CTQ-br6X8; Fri, 21 Aug 2020 02:17:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 2B09488609;
	Fri, 21 Aug 2020 02:17:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 181B6C0895;
	Fri, 21 Aug 2020 02:17:19 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 26E21C0051
 for <iommu@lists.linux-foundation.org>; Fri, 21 Aug 2020 02:17:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 15F3E885F6
 for <iommu@lists.linux-foundation.org>; Fri, 21 Aug 2020 02:17:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id khD3tNYFhqxg for <iommu@lists.linux-foundation.org>;
 Fri, 21 Aug 2020 02:17:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 17214885E7
 for <iommu@lists.linux-foundation.org>; Fri, 21 Aug 2020 02:17:16 +0000 (UTC)
Message-Id: <20200821002948.189324911@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1597976234;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:  references:references;
 bh=eWBLX5XgA0aFXkIZkqQam70cKG8KNwwE8vYzAqD+WN4=;
 b=eUyv3sONGiRpnc/zgIJAYkirhWZcZynKVLYkoQPXXP4A6ZnjjoBWLHzsTmHEEM4HCvy9jr
 edi49BZCXKIqUXgHlYUZdl1AE9a4yg+xc1pZDfKbqK5UM72SrtIMeXAM8xa7KoQUn0KfzR
 QTL59m0n4Owxi2cxF5vwj9hJQAq3MpMy7CxEwR9guh/hdlPrL3LL9DIcFn3F0sTM7vMZMS
 06Zuob5KBzqYerYQ33uVsMGFbUQ6ZumEtRGXxklWClYS/T8IGHYIJGeoFrzTBLVqHTzo8Z
 hLIwRJlEaxDg5e5oEKHQ6Q5LEmVf3JA63yBZfaOTXWLXqjyeizqcTRcqJwUwOg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1597976234;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:  references:references;
 bh=eWBLX5XgA0aFXkIZkqQam70cKG8KNwwE8vYzAqD+WN4=;
 b=M2AaOXstsi+4kBCSX8XCuM6S/HPc49K6W3zpC28X3vBu1VOwwAtybmVqDaJleAJgrIJwF+
 eQ3UqKA/FTWlS8Bg==
Date: Fri, 21 Aug 2020 02:24:53 +0200
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [patch RFC 29/38] x86/pci: Set default irq domain in
 pcibios_add_device()
References: <20200821002424.119492231@linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline;
 filename="x86-pci--Set-default-irq-domain-in-pcibios_add_device.patch"
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Now that interrupt remapping sets the irqdomain pointer when a PCI device
is added it's possible to store the default irq domain in the device struct
in pcibios_add_device().

If the bus to which a device is connected has an irq domain associated then
this domain is used otherwise the default domain (PCI/MSI native or XEN
PCI/MSI) is used. Using the bus domain ensures that special MSI bus domains
like VMD work.

This makes XEN and the non-remapped native case work solely based on the
irq domain pointer in struct device for PCI/MSI and allows to remove the
arch fallback and make most of the x86_msi ops private to XEN in the next
steps.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-pci@vger.kernel.org
---
 arch/x86/include/asm/irqdomain.h |    2 ++
 arch/x86/kernel/apic/msi.c       |    2 +-
 arch/x86/pci/common.c            |   18 +++++++++++++++++-
 3 files changed, 20 insertions(+), 2 deletions(-)

--- a/arch/x86/include/asm/irqdomain.h
+++ b/arch/x86/include/asm/irqdomain.h
@@ -53,9 +53,11 @@ extern int mp_irqdomain_ioapic_idx(struc
 #ifdef CONFIG_PCI_MSI
 void x86_create_pci_msi_domain(void);
 struct irq_domain *native_create_pci_msi_domain(void);
+extern struct irq_domain *x86_pci_msi_default_domain;
 #else
 static inline void x86_create_pci_msi_domain(void) { }
 #define native_create_pci_msi_domain	NULL
+#define x86_pci_msi_default_domain	NULL
 #endif
 
 #endif
--- a/arch/x86/kernel/apic/msi.c
+++ b/arch/x86/kernel/apic/msi.c
@@ -21,7 +21,7 @@
 #include <asm/apic.h>
 #include <asm/irq_remapping.h>
 
-static struct irq_domain *x86_pci_msi_default_domain __ro_after_init;
+struct irq_domain *x86_pci_msi_default_domain __ro_after_init;
 
 static void __irq_msi_compose_msg(struct irq_cfg *cfg, struct msi_msg *msg)
 {
--- a/arch/x86/pci/common.c
+++ b/arch/x86/pci/common.c
@@ -19,6 +19,7 @@
 #include <asm/smp.h>
 #include <asm/pci_x86.h>
 #include <asm/setup.h>
+#include <asm/irqdomain.h>
 
 unsigned int pci_probe = PCI_PROBE_BIOS | PCI_PROBE_CONF1 | PCI_PROBE_CONF2 |
 				PCI_PROBE_MMCONF;
@@ -633,8 +634,9 @@ static void set_dev_domain_options(struc
 
 int pcibios_add_device(struct pci_dev *dev)
 {
-	struct setup_data *data;
 	struct pci_setup_rom *rom;
+	struct irq_domain *msidom;
+	struct setup_data *data;
 	u64 pa_data;
 
 	pa_data = boot_params.hdr.setup_data;
@@ -661,6 +663,20 @@ int pcibios_add_device(struct pci_dev *d
 		memunmap(data);
 	}
 	set_dev_domain_options(dev);
+
+	/*
+	 * Setup the initial MSI domain of the device. If the underlying
+	 * bus has a PCI/MSI irqdomain associated use the bus domain,
+	 * otherwise set the default domain. This ensures that special irq
+	 * domains e.g. VMD are preserved. The default ensures initial
+	 * operation if irq remapping is not active. If irq remapping is
+	 * active it will overwrite the domain pointer when the device is
+	 * associated to a remapping domain.
+	 */
+	msidom = dev_get_msi_domain(&dev->bus->dev);
+	if (!msidom)
+		msidom = x86_pci_msi_default_domain;
+	dev_set_msi_domain(&dev->dev, msidom);
 	return 0;
 }
 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
