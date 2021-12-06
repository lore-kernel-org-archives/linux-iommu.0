Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D0D3C433EF
	for <iommu@archiver.kernel.org>; Mon,  6 Dec 2021 22:39:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BC5AC41C53;
	Mon,  6 Dec 2021 22:39:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ikS2o0L1PCSy; Mon,  6 Dec 2021 22:39:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 722A241C50;
	Mon,  6 Dec 2021 22:39:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 49800C0030;
	Mon,  6 Dec 2021 22:39:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0860EC0012
 for <iommu@lists.linux-foundation.org>; Mon,  6 Dec 2021 22:39:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EA41182D40
 for <iommu@lists.linux-foundation.org>; Mon,  6 Dec 2021 22:39:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linutronix.de header.b="0z7xCFi/";
 dkim=neutral reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=linutronix.de header.b="TGcSLRy9"
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id H7I9E35p7BpO for <iommu@lists.linux-foundation.org>;
 Mon,  6 Dec 2021 22:39:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EA81A84BE7
 for <iommu@lists.linux-foundation.org>; Mon,  6 Dec 2021 22:39:20 +0000 (UTC)
Message-ID: <20211206210438.419160862@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1638830359;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 references:references; bh=6EMMNpvyXK75OtHIkqDafkCPKjNT6UjlrUiD6k/V/Kc=;
 b=0z7xCFi/09vRAK0bIazveOxr26GEWEhb+vcWJ0gZbQWEK9Ut/y/r+UU+n0jUtmeUItwok2
 8FGGX6iEwPWPmXC7rY85oXM/8XjhvYhQBAU6xhDN+C37borrNOsEF/j7UqnXLTFNeUNTkt
 wyXImnXaXo+0rFOvuURNfN7ZrCjN8kQgxK22dXadc61KJppUMDy/vuERX2stUTH5IjcgIY
 CzU1zkIlt6lry0dLrmsxP7YvsBZpF36Mc12I5C8ZBcy7YVV2297T1073OywWAyXuFM/6ai
 gp5HPFQAv6ZxL3YvA54sazPuaneFlKhqRxiEyprKK+dRLFS/Hssu2vV315XiOw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1638830359;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 references:references; bh=6EMMNpvyXK75OtHIkqDafkCPKjNT6UjlrUiD6k/V/Kc=;
 b=TGcSLRy94hDV8xdvp8TAIgWTSEQtpXZHPDCy7tgDaxex0jesp8aPKSls8gX7M0+StNJMfG
 II3wNxwVIbxub4Cw==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [patch V2 14/36] platform-msi: Use msi_desc::msi_index
References: <20211206210307.625116253@linutronix.de>
MIME-Version: 1.0
Date: Mon,  6 Dec 2021 23:39:18 +0100 (CET)
Cc: Nishanth Menon <nm@ti.com>, Mark Rutland <mark.rutland@arm.com>,
 Stuart Yoder <stuyoder@gmail.com>, linux-pci@vger.kernel.org,
 Will Deacon <will@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
 Marc Zygnier <maz@kernel.org>, Sinan Kaya <okaya@kernel.org>,
 iommu@lists.linux-foundation.org, Bjorn Helgaas <helgaas@kernel.org>,
 linux-arm-kernel@lists.infradead.org, Jason Gunthorpe <jgg@nvidia.com>,
 xen-devel@lists.xenproject.org, Kevin Tian <kevin.tian@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>, Cedric Le Goater <clg@kaod.org>,
 Santosh Shilimkar <ssantosh@kernel.org>, Megha Dey <megha.dey@intel.com>,
 Juergen Gross <jgross@suse.com>, Tero Kristo <kristo@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vinod Koul <vkoul@kernel.org>,
 dmaengine@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>
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

Use the common msi_index member and get rid of the pointless wrapper struct.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: iommu@lists.linux-foundation.org
Cc: dmaengine@vger.kernel.org
---
 drivers/base/platform-msi.c                 |   10 +++++-----
 drivers/dma/qcom/hidma.c                    |    4 ++--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |    4 ++--
 drivers/mailbox/bcm-flexrm-mailbox.c        |    4 ++--
 include/linux/msi.h                         |   10 ----------
 5 files changed, 11 insertions(+), 21 deletions(-)

--- a/drivers/base/platform-msi.c
+++ b/drivers/base/platform-msi.c
@@ -40,7 +40,7 @@ static irq_hw_number_t platform_msi_calc
 {
 	u32 devid = desc->dev->msi.data->platform_data->devid;
 
-	return (devid << (32 - DEV_ID_SHIFT)) | desc->platform.msi_index;
+	return (devid << (32 - DEV_ID_SHIFT)) | desc->msi_index;
 }
 
 static void platform_msi_set_desc(msi_alloc_info_t *arg, struct msi_desc *desc)
@@ -112,8 +112,8 @@ static void platform_msi_free_descs(stru
 	struct msi_desc *desc, *tmp;
 
 	list_for_each_entry_safe(desc, tmp, dev_to_msi_list(dev), list) {
-		if (desc->platform.msi_index >= base &&
-		    desc->platform.msi_index < (base + nvec)) {
+		if (desc->msi_index >= base &&
+		    desc->msi_index < (base + nvec)) {
 			list_del(&desc->list);
 			free_msi_entry(desc);
 		}
@@ -129,7 +129,7 @@ static int platform_msi_alloc_descs_with
 	if (!list_empty(dev_to_msi_list(dev))) {
 		desc = list_last_entry(dev_to_msi_list(dev),
 				       struct msi_desc, list);
-		base = desc->platform.msi_index + 1;
+		base = desc->msi_index + 1;
 	}
 
 	for (i = 0; i < nvec; i++) {
@@ -137,7 +137,7 @@ static int platform_msi_alloc_descs_with
 		if (!desc)
 			break;
 
-		desc->platform.msi_index = base + i;
+		desc->msi_index = base + i;
 		desc->irq = virq ? virq + i : 0;
 
 		list_add_tail(&desc->list, dev_to_msi_list(dev));
--- a/drivers/dma/qcom/hidma.c
+++ b/drivers/dma/qcom/hidma.c
@@ -666,7 +666,7 @@ static void hidma_write_msi_msg(struct m
 	struct device *dev = msi_desc_to_dev(desc);
 	struct hidma_dev *dmadev = dev_get_drvdata(dev);
 
-	if (!desc->platform.msi_index) {
+	if (!desc->msi_index) {
 		writel(msg->address_lo, dmadev->dev_evca + 0x118);
 		writel(msg->address_hi, dmadev->dev_evca + 0x11C);
 		writel(msg->data, dmadev->dev_evca + 0x120);
@@ -702,7 +702,7 @@ static int hidma_request_msi(struct hidm
 		return rc;
 
 	for_each_msi_entry(desc, &pdev->dev) {
-		if (!desc->platform.msi_index)
+		if (!desc->msi_index)
 			dmadev->msi_virqbase = desc->irq;
 
 		rc = devm_request_irq(&pdev->dev, desc->irq,
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3142,7 +3142,7 @@ static void arm_smmu_write_msi_msg(struc
 	phys_addr_t doorbell;
 	struct device *dev = msi_desc_to_dev(desc);
 	struct arm_smmu_device *smmu = dev_get_drvdata(dev);
-	phys_addr_t *cfg = arm_smmu_msi_cfg[desc->platform.msi_index];
+	phys_addr_t *cfg = arm_smmu_msi_cfg[desc->msi_index];
 
 	doorbell = (((u64)msg->address_hi) << 32) | msg->address_lo;
 	doorbell &= MSI_CFG0_ADDR_MASK;
@@ -3183,7 +3183,7 @@ static void arm_smmu_setup_msis(struct a
 	}
 
 	for_each_msi_entry(desc, dev) {
-		switch (desc->platform.msi_index) {
+		switch (desc->msi_index) {
 		case EVTQ_MSI_INDEX:
 			smmu->evtq.q.irq = desc->irq;
 			break;
--- a/drivers/mailbox/bcm-flexrm-mailbox.c
+++ b/drivers/mailbox/bcm-flexrm-mailbox.c
@@ -1484,7 +1484,7 @@ static void flexrm_mbox_msi_write(struct
 {
 	struct device *dev = msi_desc_to_dev(desc);
 	struct flexrm_mbox *mbox = dev_get_drvdata(dev);
-	struct flexrm_ring *ring = &mbox->rings[desc->platform.msi_index];
+	struct flexrm_ring *ring = &mbox->rings[desc->msi_index];
 
 	/* Configure per-Ring MSI registers */
 	writel_relaxed(msg->address_lo, ring->regs + RING_MSI_ADDR_LS);
@@ -1609,7 +1609,7 @@ static int flexrm_mbox_probe(struct plat
 
 	/* Save alloced IRQ numbers for each ring */
 	for_each_msi_entry(desc, dev) {
-		ring = &mbox->rings[desc->platform.msi_index];
+		ring = &mbox->rings[desc->msi_index];
 		ring->irq = desc->irq;
 	}
 
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -106,14 +106,6 @@ struct pci_msi_desc {
 };
 
 /**
- * platform_msi_desc - Platform device specific msi descriptor data
- * @msi_index:		The index of the MSI descriptor for multi MSI
- */
-struct platform_msi_desc {
-	u16				msi_index;
-};
-
-/**
  * fsl_mc_msi_desc - FSL-MC device specific msi descriptor data
  * @msi_index:		The index of the MSI descriptor
  */
@@ -144,7 +136,6 @@ struct ti_sci_inta_msi_desc {
  *
  * @msi_index:	Index of the msi descriptor
  * @pci:	[PCI]	    PCI speficic msi descriptor data
- * @platform:	[platform]  Platform device specific msi descriptor data
  * @fsl_mc:	[fsl-mc]    FSL MC device specific msi descriptor data
  * @inta:	[INTA]	    TISCI based INTA specific msi descriptor data
  */
@@ -166,7 +157,6 @@ struct msi_desc {
 	u16				msi_index;
 	union {
 		struct pci_msi_desc		pci;
-		struct platform_msi_desc	platform;
 		struct fsl_mc_msi_desc		fsl_mc;
 		struct ti_sci_inta_msi_desc	inta;
 	};

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
