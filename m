Return-Path: <SRS0=F9Hu=YP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DF1ACA9EA0
	for <iommu@archiver.kernel.org>; Tue, 22 Oct 2019 22:01:35 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07351206C2
	for <iommu@archiver.kernel.org>; Tue, 22 Oct 2019 22:01:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07351206C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id C9B77CCC;
	Tue, 22 Oct 2019 22:01:27 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id E8F8341C
	for <iommu@lists.linux-foundation.org>;
	Tue, 22 Oct 2019 22:01:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from ale.deltatee.com (ale.deltatee.com [207.54.116.67])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 8650D896
	for <iommu@lists.linux-foundation.org>;
	Tue, 22 Oct 2019 22:01:26 +0000 (UTC)
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
	by ale.deltatee.com with esmtps
	(TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.89)
	(envelope-from <gunthorp@deltatee.com>)
	id 1iN2DU-0004Kr-By; Tue, 22 Oct 2019 16:01:26 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
	(envelope-from <gunthorp@deltatee.com>)
	id 1iN2DT-0000Iu-9w; Tue, 22 Oct 2019 16:01:23 -0600
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
	Joerg Roedel <joro@8bytes.org>
Date: Tue, 22 Oct 2019 16:01:21 -0600
Message-Id: <20191022220121.1120-3-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191022220121.1120-1-logang@deltatee.com>
References: <20191022220121.1120-1-logang@deltatee.com>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org, joro@8bytes.org,
	kchow@gigaio.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v2 2/2] iommu/amd: Support multiple PCI DMA aliases in IRQ
	Remapping
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Cc: Logan Gunthorpe <logang@deltatee.com>, Kit Chow <kchow@gigaio.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Non-Transparent Bridge (NTB) devices (among others) may have many DMA
aliases seeing the hardware will send requests with different device ids
depending on their origin across the bridged hardware.

See commit ad281ecf1c7d ("PCI: Add DMA alias quirk for Microsemi Switchtec
NTB") for more information on this.

The AMD IOMMU IRQ remapping functionality ignores all PCI aliases for
IRQs so if devices send an interrupt from one of their aliases they
will be blocked on AMD hardware with the IOMMU enabled.

To fix this, ensure IRQ remapping is enabled for all aliases with
MSI interrupts.

This is analogous to the functionality added to the Intel IRQ remapping
code in commit 3f0c625c6ae7 ("iommu/vt-d: Allow interrupts from the entire
bus for aliased devices")

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/iommu/amd_iommu.c | 37 ++++++++++++++++++++++++++++++-------
 1 file changed, 30 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 585c2a94a7e9..f686d5708572 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -3175,7 +3175,20 @@ static void set_remap_table_entry(struct amd_iommu *iommu, u16 devid,
 	iommu_flush_dte(iommu, devid);
 }
 
-static struct irq_remap_table *alloc_irq_table(u16 devid)
+static int set_remap_table_entry_alias(struct pci_dev *pdev, u16 alias,
+				       void *data)
+{
+	struct irq_remap_table *table = data;
+
+	irq_lookup_table[alias] = table;
+	set_dte_irq_entry(alias, table);
+
+	iommu_flush_dte(amd_iommu_rlookup_table[alias], alias);
+
+	return 0;
+}
+
+static struct irq_remap_table *alloc_irq_table(u16 devid, struct pci_dev *pdev)
 {
 	struct irq_remap_table *table = NULL;
 	struct irq_remap_table *new_table = NULL;
@@ -3221,7 +3234,12 @@ static struct irq_remap_table *alloc_irq_table(u16 devid)
 	table = new_table;
 	new_table = NULL;
 
-	set_remap_table_entry(iommu, devid, table);
+	if (pdev)
+		pci_for_each_dma_alias(pdev, set_remap_table_entry_alias,
+				       table);
+	else
+		set_remap_table_entry(iommu, devid, table);
+
 	if (devid != alias)
 		set_remap_table_entry(iommu, alias, table);
 
@@ -3238,7 +3256,8 @@ static struct irq_remap_table *alloc_irq_table(u16 devid)
 	return table;
 }
 
-static int alloc_irq_index(u16 devid, int count, bool align)
+static int alloc_irq_index(u16 devid, int count, bool align,
+			   struct pci_dev *pdev)
 {
 	struct irq_remap_table *table;
 	int index, c, alignment = 1;
@@ -3248,7 +3267,7 @@ static int alloc_irq_index(u16 devid, int count, bool align)
 	if (!iommu)
 		return -ENODEV;
 
-	table = alloc_irq_table(devid);
+	table = alloc_irq_table(devid, pdev);
 	if (!table)
 		return -ENODEV;
 
@@ -3681,7 +3700,7 @@ static int irq_remapping_alloc(struct irq_domain *domain, unsigned int virq,
 		struct irq_remap_table *table;
 		struct amd_iommu *iommu;
 
-		table = alloc_irq_table(devid);
+		table = alloc_irq_table(devid, NULL);
 		if (table) {
 			if (!table->min_index) {
 				/*
@@ -3698,11 +3717,15 @@ static int irq_remapping_alloc(struct irq_domain *domain, unsigned int virq,
 		} else {
 			index = -ENOMEM;
 		}
-	} else {
+	} else if (info->type == X86_IRQ_ALLOC_TYPE_MSI ||
+		   info->type == X86_IRQ_ALLOC_TYPE_MSIX) {
 		bool align = (info->type == X86_IRQ_ALLOC_TYPE_MSI);
 
-		index = alloc_irq_index(devid, nr_irqs, align);
+		index = alloc_irq_index(devid, nr_irqs, align, info->msi_dev);
+	} else {
+		index = alloc_irq_index(devid, nr_irqs, false, NULL);
 	}
+
 	if (index < 0) {
 		pr_warn("Failed to allocate IRTE\n");
 		ret = index;
-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
