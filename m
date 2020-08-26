Return-Path: <SRS0=L2Qy=CE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1676DC433E4
	for <iommu@archiver.kernel.org>; Wed, 26 Aug 2020 12:01:42 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB99C20838
	for <iommu@archiver.kernel.org>; Wed, 26 Aug 2020 12:01:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qdLXZDV7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NRzvd48e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB99C20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id CEDFC8685B;
	Wed, 26 Aug 2020 12:01:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mVqkuWqa31FX; Wed, 26 Aug 2020 12:01:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B8F12864EC;
	Wed, 26 Aug 2020 12:01:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A19E7C0891;
	Wed, 26 Aug 2020 12:01:40 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D4D01C0051
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 12:01:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id CCC5D86AFE
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 12:01:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NpIoyC6iUgLS for <iommu@lists.linux-foundation.org>;
 Wed, 26 Aug 2020 12:01:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 178FE86AF2
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 12:01:38 +0000 (UTC)
Message-Id: <20200826112333.900423047@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1598443296;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:  references:references;
 bh=CFNzw38SWj/GhzqEQcV+Y1J46H8ZfR0tQEL7ka0C2fs=;
 b=qdLXZDV7WBNlTkEUz0j7VwNT/Md+4QCdcriDKySFTLnxkbOMBbFHawqFD+Ru4EXFLNKus7
 k1w72FaNHSbmjSZfAo6Fi9q51EDk7DEIWJWmIT5Vl+u3+cZ8ajqf1oSIp0ueyX3+yvkMKR
 rtn9EoWo33NL5mIAz5s1PSU+IUaqTpNtif+2elN6KLUBwj1ge6ODHxcBklg2QftNGh2bLI
 0sGHGDeI5a+Es9BerWQ5nLosHZKKLae/20Fjvlh9flD+Wxi1+LB7iDcIzlecGe5PCaP7H5
 WE7wM7lnRcX4tcwbkLC9Tnpip9LFzCgaTCKTpAg9nJKI4AwWNUB6AtvQPXHiqg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1598443296;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:  references:references;
 bh=CFNzw38SWj/GhzqEQcV+Y1J46H8ZfR0tQEL7ka0C2fs=;
 b=NRzvd48efsAXTARo13QYZgl3dFYwChRIwQIYCz10LZg7VQQugi+0kIKCwnAfsNrcq7GQ83
 RKOrBK9cNr79XUAA==
Date: Wed, 26 Aug 2020 13:17:01 +0200
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [patch V2 33/46] x86/pci: Set default irq domain in
 pcibios_add_device()
References: <20200826111628.794979401@linutronix.de>
MIME-Version: 1.0
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
 Jon Derrick <jonathan.derrick@intel.com>, Juergen Gross <jgross@suse.com>,
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

From: Thomas Gleixner <tglx@linutronix.de>

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
