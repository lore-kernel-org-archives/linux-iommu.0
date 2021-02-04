Return-Path: <SRS0=5Yk+=HG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45293C433DB
	for <iommu@archiver.kernel.org>; Thu,  4 Feb 2021 19:09:32 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4A7E64F65
	for <iommu@archiver.kernel.org>; Thu,  4 Feb 2021 19:09:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4A7E64F65
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 964A686CFC;
	Thu,  4 Feb 2021 19:09:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id P4+pk5vL0NAD; Thu,  4 Feb 2021 19:09:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 14A5386CEE;
	Thu,  4 Feb 2021 19:09:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 01330C0174;
	Thu,  4 Feb 2021 19:09:30 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6B1C7C013A
 for <iommu@lists.linux-foundation.org>; Thu,  4 Feb 2021 19:09:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 28633204C6
 for <iommu@lists.linux-foundation.org>; Thu,  4 Feb 2021 19:09:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KBeJKL0BOCMk for <iommu@lists.linux-foundation.org>;
 Thu,  4 Feb 2021 19:09:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by silver.osuosl.org (Postfix) with ESMTPS id 123072034F
 for <iommu@lists.linux-foundation.org>; Thu,  4 Feb 2021 19:09:27 +0000 (UTC)
IronPort-SDR: PbmeVfCqR9UKMVPFvSLhPyoEsCFLRVbeYJMuB2VeCAGOusiLytnrRIVBrlDnNIQcaILL/wodfi
 8XqK0ncFK1Bg==
X-IronPort-AV: E=McAfee;i="6000,8403,9885"; a="181377678"
X-IronPort-AV: E=Sophos;i="5.81,153,1610438400"; d="scan'208";a="181377678"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Feb 2021 11:09:26 -0800
IronPort-SDR: mgkIpOUnXUJ5f+42lzN4iRZOFIS7LcGeepPGRki8xgk4cSg18tepo8d2LXwMS1wckusk5JlAc0
 jpUFGa0L8UhA==
X-IronPort-AV: E=Sophos;i="5.81,153,1610438400"; d="scan'208";a="434070488"
Received: from sgklier-mobl1.amr.corp.intel.com (HELO
 jderrick-mobl.amr.corp.intel.com) ([10.212.165.190])
 by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Feb 2021 11:09:25 -0800
From: Jon Derrick <jonathan.derrick@intel.com>
To: <linux-pci@vger.kernel.org>,
	<iommu@lists.linux-foundation.org>
Subject: [PATCH v2 2/2] PCI: vmd: Disable MSI/X remapping when possible
Date: Thu,  4 Feb 2021 12:09:06 -0700
Message-Id: <20210204190906.38515-3-jonathan.derrick@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210204190906.38515-1-jonathan.derrick@intel.com>
References: <20210204190906.38515-1-jonathan.derrick@intel.com>
MIME-Version: 1.0
Cc: Nirmal Patel <nirmal.patel@intel.com>, Will Deacon <will@kernel.org>,
 Kapil Karkra <kapil.karkra@intel.com>, Bjorn Helgaas <helgaas@kernel.org>,
 David Woodhouse <dwmw2@infradead.org>,
 Jon Derrick <jonathan.derrick@intel.com>
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

VMD will retransmit child device MSI/X using its own MSI/X table and
requester-id. This limits the number of MSI/X available to the whole
child device domain to the number of VMD MSI/X interrupts.

Some VMD devices have a mode where this remapping can be disabled,
allowing child device interrupts to bypass processing with the VMD MSI/X
domain interrupt handler and going straight the child device interrupt
handler, allowing for better performance and scaling. The requester-id
still gets changed to the VMD endpoint's requester-id, and the interrupt
remapping handlers have been updated to properly set IRTE for child
device interrupts to the VMD endpoint's context.

Some VMD platforms have existing production BIOS which rely on MSI/X
remapping and won't explicitly program the MSI/X remapping bit. This
re-enables MSI/X remapping on unload.

Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
 drivers/pci/controller/vmd.c | 60 ++++++++++++++++++++++++++++--------
 1 file changed, 48 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 5e80f28f0119..a319ce49645b 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -59,6 +59,13 @@ enum vmd_features {
 	 * be used for MSI remapping
 	 */
 	VMD_FEAT_OFFSET_FIRST_VECTOR		= (1 << 3),
+
+	/*
+	 * Device can bypass remapping MSI/X transactions into its MSI/X table,
+	 * avoding the requirement of a VMD MSI domain for child device
+	 * interrupt handling
+	 */
+	VMD_FEAT_BYPASS_MSI_REMAP		= (1 << 4),
 };
 
 /*
@@ -306,6 +313,15 @@ static struct msi_domain_info vmd_msi_domain_info = {
 	.chip		= &vmd_msi_controller,
 };
 
+static void vmd_enable_msi_remapping(struct vmd_dev *vmd, bool enable)
+{
+	u16 reg;
+
+	pci_read_config_word(vmd->dev, PCI_REG_VMCONFIG, &reg);
+	reg = enable ? (reg & ~0x2) : (reg | 0x2);
+	pci_write_config_word(vmd->dev, PCI_REG_VMCONFIG, reg);
+}
+
 static int vmd_create_irq_domain(struct vmd_dev *vmd)
 {
 	struct fwnode_handle *fn;
@@ -325,6 +341,13 @@ static int vmd_create_irq_domain(struct vmd_dev *vmd)
 
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
 
@@ -679,15 +702,31 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 
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
@@ -753,10 +792,6 @@ static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	if (features & VMD_FEAT_OFFSET_FIRST_VECTOR)
 		vmd->first_vec = 1;
 
-	err = vmd_alloc_irqs(vmd);
-	if (err)
-		return err;
-
 	spin_lock_init(&vmd->cfg_lock);
 	pci_set_drvdata(dev, vmd);
 	err = vmd_enable_domain(vmd, features);
@@ -825,7 +860,8 @@ static const struct pci_device_id vmd_ids[] = {
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
