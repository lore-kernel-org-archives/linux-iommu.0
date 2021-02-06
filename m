Return-Path: <SRS0=mSd7=HI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7762C433DB
	for <iommu@archiver.kernel.org>; Sat,  6 Feb 2021 03:35:25 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A86261606
	for <iommu@archiver.kernel.org>; Sat,  6 Feb 2021 03:35:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A86261606
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E833086C6C;
	Sat,  6 Feb 2021 03:35:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dNsmNiCB_kr3; Sat,  6 Feb 2021 03:35:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 8D20286C52;
	Sat,  6 Feb 2021 03:35:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7AA0FC08A1;
	Sat,  6 Feb 2021 03:35:17 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DF28EC013A
 for <iommu@lists.linux-foundation.org>; Sat,  6 Feb 2021 03:35:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id CC69C873CC
 for <iommu@lists.linux-foundation.org>; Sat,  6 Feb 2021 03:35:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cTmHmANYGFFk for <iommu@lists.linux-foundation.org>;
 Sat,  6 Feb 2021 03:35:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by hemlock.osuosl.org (Postfix) with ESMTPS id DF97B873D5
 for <iommu@lists.linux-foundation.org>; Sat,  6 Feb 2021 03:35:13 +0000 (UTC)
IronPort-SDR: u/o0zFSBcz5+DeXgZJcSunuC0B/fxK3owVrYBCAZ7Ypzqev2VIJO3bX5P/FhI9wLGEzZ1RZsZ2
 kc6bOO4SLwNQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9886"; a="200534600"
X-IronPort-AV: E=Sophos;i="5.81,156,1610438400"; d="scan'208";a="200534600"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Feb 2021 19:35:13 -0800
IronPort-SDR: WzWbLKo7EcLKowoDX25Phm/FJThn6RXakfrDo/QCc1DA2DXh3sE1MJjMf2fdWZwfz1q8LCeggZ
 BVkmI+pjLejA==
X-IronPort-AV: E=Sophos;i="5.81,156,1610438400"; d="scan'208";a="576921857"
Received: from rgrover1-mobl.amr.corp.intel.com (HELO
 jderrick-mobl.amr.corp.intel.com) ([10.209.102.94])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Feb 2021 19:35:12 -0800
From: Jon Derrick <jonathan.derrick@intel.com>
To: <linux-pci@vger.kernel.org>,
	<iommu@lists.linux-foundation.org>
Subject: [PATCH v3 2/2] PCI: vmd: Disable MSI-X remapping when possible
Date: Fri,  5 Feb 2021 20:35:02 -0700
Message-Id: <20210206033502.103964-3-jonathan.derrick@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210206033502.103964-1-jonathan.derrick@intel.com>
References: <20210206033502.103964-1-jonathan.derrick@intel.com>
MIME-Version: 1.0
Cc: Nirmal Patel <nirmal.patel@intel.com>,
 Kapil Karkra <kapil.karkra@intel.com>, Joerg Roedel <jroedel@suse.de>,
 Bjorn Helgaas <helgaas@kernel.org>, Jon Derrick <jonathan.derrick@intel.com>
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

VMD will retransmit child device MSI-X using its own MSI-X table and
requester-id. This limits the number of MSI-X available to the whole
child device domain to the number of VMD MSI-X interrupts.

Some VMD devices have a mode where this remapping can be disabled,
allowing child device interrupts to bypass processing with the VMD MSI-X
domain interrupt handler and going straight the child device interrupt
handler, allowing for better performance and scaling. The requester-id
still gets changed to the VMD endpoint's requester-id, and the interrupt
remapping handlers have been updated to properly set IRTE for child
device interrupts to the VMD endpoint's context.

Some VMD platforms have existing production BIOS which rely on MSI-X
remapping and won't explicitly program the MSI-X remapping bit. This
re-enables MSI-X remapping on unload.

Acked-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
 drivers/pci/controller/vmd.c | 61 +++++++++++++++++++++++++++++-------
 1 file changed, 49 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 5e80f28f0119..2a585d1b3349 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -28,6 +28,7 @@
 #define BUS_RESTRICT_CAP(vmcap)	(vmcap & 0x1)
 #define PCI_REG_VMCONFIG	0x44
 #define BUS_RESTRICT_CFG(vmcfg)	((vmcfg >> 8) & 0x3)
+#define VMCFG_MSI_RMP_DIS	0x2
 #define PCI_REG_VMLOCK		0x70
 #define MB2_SHADOW_EN(vmlock)	(vmlock & 0x2)
 
@@ -59,6 +60,13 @@ enum vmd_features {
 	 * be used for MSI remapping
 	 */
 	VMD_FEAT_OFFSET_FIRST_VECTOR		= (1 << 3),
+
+	/*
+	 * Device can bypass remapping MSI-X transactions into its MSI-X table,
+	 * avoiding the requirement of a VMD MSI domain for child device
+	 * interrupt handling.
+	 */
+	VMD_FEAT_BYPASS_MSI_REMAP		= (1 << 4),
 };
 
 /*
@@ -306,6 +314,15 @@ static struct msi_domain_info vmd_msi_domain_info = {
 	.chip		= &vmd_msi_controller,
 };
 
+static void vmd_enable_msi_remapping(struct vmd_dev *vmd, bool enable)
+{
+	u16 reg;
+
+	pci_read_config_word(vmd->dev, PCI_REG_VMCONFIG, &reg);
+	reg = enable ? (reg & ~VMCFG_MSI_RMP_DIS) : (reg | VMCFG_MSI_RMP_DIS);
+	pci_write_config_word(vmd->dev, PCI_REG_VMCONFIG, reg);
+}
+
 static int vmd_create_irq_domain(struct vmd_dev *vmd)
 {
 	struct fwnode_handle *fn;
@@ -325,6 +342,13 @@ static int vmd_create_irq_domain(struct vmd_dev *vmd)
 
 static void vmd_remove_irq_domain(struct vmd_dev *vmd)
 {
+	/*
+	 * Some production BIOS won't enable remapping between soft reboots.
+	 * Ensure remapping is restored before unloading the driver.
+	 */
+	if (!vmd->msix_count)
+		vmd_enable_msi_remapping(vmd, true);
+
 	if (vmd->irq_domain) {
 		struct fwnode_handle *fn = vmd->irq_domain->fwnode;
 
@@ -679,15 +703,31 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 
 	sd->node = pcibus_to_node(vmd->dev->bus);
 
-	ret = vmd_create_irq_domain(vmd);
-	if (ret)
-		return ret;
-
 	/*
-	 * Override the irq domain bus token so the domain can be distinguished
-	 * from a regular PCI/MSI domain.
+	 * Currently MSI remapping must be enabled in guest passthrough mode
+	 * due to some missing interrupt remapping plumbing. This is probably
+	 * acceptable because the guest is usually CPU-limited and MSI
+	 * remapping doesn't become a performance bottleneck.
 	 */
-	irq_domain_update_bus_token(vmd->irq_domain, DOMAIN_BUS_VMD_MSI);
+	if (!(features & VMD_FEAT_BYPASS_MSI_REMAP) || offset[0] || offset[1]) {
+		ret = vmd_alloc_irqs(vmd);
+		if (ret)
+			return ret;
+
+		vmd_enable_msi_remapping(vmd, true);
+
+		ret = vmd_create_irq_domain(vmd);
+		if (ret)
+			return ret;
+
+		/*
+		 * Override the irq domain bus token so the domain can be
+		 * distinguished from a regular PCI/MSI domain.
+		 */
+		irq_domain_update_bus_token(vmd->irq_domain, DOMAIN_BUS_VMD_MSI);
+	} else {
+		vmd_enable_msi_remapping(vmd, false);
+	}
 
 	pci_add_resource(&resources, &vmd->resources[0]);
 	pci_add_resource_offset(&resources, &vmd->resources[1], offset[0]);
@@ -753,10 +793,6 @@ static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	if (features & VMD_FEAT_OFFSET_FIRST_VECTOR)
 		vmd->first_vec = 1;
 
-	err = vmd_alloc_irqs(vmd);
-	if (err)
-		return err;
-
 	spin_lock_init(&vmd->cfg_lock);
 	pci_set_drvdata(dev, vmd);
 	err = vmd_enable_domain(vmd, features);
@@ -825,7 +861,8 @@ static const struct pci_device_id vmd_ids[] = {
 		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP,},
 	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_VMD_28C0),
 		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW |
-				VMD_FEAT_HAS_BUS_RESTRICTIONS,},
+				VMD_FEAT_HAS_BUS_RESTRICTIONS |
+				VMD_FEAT_BYPASS_MSI_REMAP,},
 	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x467f),
 		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
 				VMD_FEAT_HAS_BUS_RESTRICTIONS |
-- 
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
