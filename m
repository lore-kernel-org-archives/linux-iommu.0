Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68496C433EF
	for <iommu@archiver.kernel.org>; Fri, 10 Dec 2021 22:18:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F332061B4A;
	Fri, 10 Dec 2021 22:18:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sfYw2qsS8L8G; Fri, 10 Dec 2021 22:18:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A91B361B46;
	Fri, 10 Dec 2021 22:18:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 82235C001E;
	Fri, 10 Dec 2021 22:18:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6F692C0012
 for <iommu@lists.linux-foundation.org>; Fri, 10 Dec 2021 22:18:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5B298418D8
 for <iommu@lists.linux-foundation.org>; Fri, 10 Dec 2021 22:18:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linutronix.de header.b="RVFQBQqA";
 dkim=neutral reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=linutronix.de header.b="W5z8GHgz"
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id I2pW6Shd3cyg for <iommu@lists.linux-foundation.org>;
 Fri, 10 Dec 2021 22:18:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 62657418C9
 for <iommu@lists.linux-foundation.org>; Fri, 10 Dec 2021 22:18:48 +0000 (UTC)
Message-ID: <20211210221813.250049810@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1639174725;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 references:references; bh=LAPO48TeSRvyraOCUaLnLGoqr3cykpYVLg5Q2NPw+tk=;
 b=RVFQBQqAHeoiRwlZ3riRsRVnIL91ZjHAfRJRIp58J8GUnDjLQx7L9kWYIIUbdLwuKR/jwL
 JcJBPfohipM62TDgI++91yG93z8S9yOtP19oQQE8Q8k13Dz0zt5IP/hM5mMrevOXLmlklN
 kWOoGd3So5Fe6OgP0QbWV76D4psb9hl5USqdOyh+D6Aqhblm4cpa5e5Vf78Qu6ZYHkQHTi
 bgYvnB6aYzx+LTLoj46c14I2SP51PPz15FBrvc8JBpekzRO6sF7T8vtiJHTJFweb24goaW
 joW6zxk5fBYith6L0SW2dhYjEXttIyscMDGJDovBvIbb2eL2uBhx9UWrfH/KNw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1639174725;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 references:references; bh=LAPO48TeSRvyraOCUaLnLGoqr3cykpYVLg5Q2NPw+tk=;
 b=W5z8GHgzI4pNn8BJLekDX4e1pfDaOzUgMdqste1q3KO/3rlD+JtPo0I0BMrvt2m3/1G3Vk
 MFABiwOkTOMR3XAQ==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [patch V3 01/35] PCI/MSI: Set pci_dev::msi[x]_enabled early
References: <20211210221642.869015045@linutronix.de>
MIME-Version: 1.0
Date: Fri, 10 Dec 2021 23:18:44 +0100 (CET)
Cc: Nishanth Menon <nm@ti.com>, Mark Rutland <mark.rutland@arm.com>,
 Stuart Yoder <stuyoder@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Will Deacon <will@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Jassi Brar <jassisinghbrar@gmail.com>,
 Sinan Kaya <okaya@kernel.org>, iommu@lists.linux-foundation.org,
 Peter Ujfalusi <peter.ujfalusi@gmail.com>, Bjorn Helgaas <helgaas@kernel.org>,
 linux-arm-kernel@lists.infradead.org, Jason Gunthorpe <jgg@nvidia.com>,
 linux-pci@vger.kernel.org, xen-devel@lists.xenproject.org,
 Kevin Tian <kevin.tian@intel.com>, Arnd Bergmann <arnd@arndb.de>,
 Robin Murphy <robin.murphy@arm.com>,
 Alex Williamson <alex.williamson@redhat.com>, Cedric Le Goater <clg@kaod.org>,
 Santosh Shilimkar <ssantosh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Megha Dey <megha.dey@intel.com>, Juergen Gross <jgross@suse.com>,
 Tero Kristo <kristo@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vinod Koul <vkoul@kernel.org>,
 Marc Zygnier <maz@kernel.org>, dmaengine@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
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

There are quite some places which retrieve the first MSI descriptor to
evaluate whether the setup is for MSI or MSI-X. That's required because
pci_dev::msi[x]_enabled is only set when the setup completed successfully.

There is no real reason why msi[x]_enabled can't be set at the beginning of
the setup sequence and cleared in case of a failure.

Implement that so the MSI descriptor evaluations can be converted to simple
property queries.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V3: New patch
---
 drivers/pci/msi/msi.c |   23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -421,11 +421,18 @@ static int msi_capability_init(struct pc
 	struct msi_desc *entry;
 	int ret;
 
-	pci_msi_set_enable(dev, 0);	/* Disable MSI during set up */
+	/*
+	 * Disable MSI during setup in the hardware, but mark it enabled
+	 * so that setup code can evaluate it.
+	 */
+	pci_msi_set_enable(dev, 0);
+	dev->msi_enabled = 1;
 
 	entry = msi_setup_entry(dev, nvec, affd);
-	if (!entry)
-		return -ENOMEM;
+	if (!entry) {
+		ret = -ENOMEM;
+		goto fail;
+	}
 
 	/* All MSIs are unmasked by default; mask them all */
 	pci_msi_mask(entry, msi_multi_mask(entry));
@@ -452,7 +459,6 @@ static int msi_capability_init(struct pc
 	/* Set MSI enabled bits	*/
 	pci_intx_for_msi(dev, 0);
 	pci_msi_set_enable(dev, 1);
-	dev->msi_enabled = 1;
 
 	pcibios_free_irq(dev);
 	dev->irq = entry->irq;
@@ -461,6 +467,8 @@ static int msi_capability_init(struct pc
 err:
 	pci_msi_unmask(entry, msi_multi_mask(entry));
 	free_msi_irqs(dev);
+fail:
+	dev->msi_enabled = 0;
 	return ret;
 }
 
@@ -589,6 +597,9 @@ static int msix_capability_init(struct p
 	pci_msix_clear_and_set_ctrl(dev, 0, PCI_MSIX_FLAGS_MASKALL |
 				    PCI_MSIX_FLAGS_ENABLE);
 
+	/* Mark it enabled so setup functions can query it */
+	dev->msix_enabled = 1;
+
 	pci_read_config_word(dev, dev->msix_cap + PCI_MSIX_FLAGS, &control);
 	/* Request & Map MSI-X table region */
 	tsize = msix_table_size(control);
@@ -626,9 +637,8 @@ static int msix_capability_init(struct p
 
 	dev->msi_irq_groups = groups;
 
-	/* Set MSI-X enabled bits and unmask the function */
+	/* Disable INTX and unmask MSI-X */
 	pci_intx_for_msi(dev, 0);
-	dev->msix_enabled = 1;
 	pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_MASKALL, 0);
 
 	pcibios_free_irq(dev);
@@ -638,6 +648,7 @@ static int msix_capability_init(struct p
 	free_msi_irqs(dev);
 
 out_disable:
+	dev->msix_enabled = 0;
 	pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_ENABLE, 0);
 
 	return ret;

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
