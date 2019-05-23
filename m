Return-Path: <SRS0=aUVl=TX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 299CCC282DE
	for <iommu@archiver.kernel.org>; Thu, 23 May 2019 22:31:21 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07AE920879
	for <iommu@archiver.kernel.org>; Thu, 23 May 2019 22:31:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07AE920879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 12933FCC;
	Thu, 23 May 2019 22:31:13 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 44790F73
	for <iommu@lists.linux-foundation.org>;
	Thu, 23 May 2019 22:31:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from ale.deltatee.com (ale.deltatee.com [207.54.116.67])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 4A71484F
	for <iommu@lists.linux-foundation.org>;
	Thu, 23 May 2019 22:31:09 +0000 (UTC)
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
	by ale.deltatee.com with esmtps
	(TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.89)
	(envelope-from <gunthorp@deltatee.com>)
	id 1hTwEs-00062N-Eu; Thu, 23 May 2019 16:31:08 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.89)
	(envelope-from <gunthorp@deltatee.com>)
	id 1hTwEp-0001S2-Nu; Thu, 23 May 2019 16:31:03 -0600
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com,
	linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org,
	linux-kselftest@vger.kernel.org, Jon Mason <jdmason@kudzu.us>,
	Joerg Roedel <joro@8bytes.org>
Date: Thu, 23 May 2019 16:30:51 -0600
Message-Id: <20190523223100.5526-2-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190523223100.5526-1-logang@deltatee.com>
References: <20190523223100.5526-1-logang@deltatee.com>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-ntb@googlegroups.com, iommu@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kselftest@vger.kernel.org, jdmason@kudzu.us,
	joro@8bytes.org, bhelgaas@google.com, dave.jiang@intel.com,
	allenbh@gmail.com, fancer.lancer@gmail.com, epilmore@gigaio.com,
	logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v5 01/10] PCI/MSI: Support allocating virtual MSI interrupts
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Cc: Allen Hubbe <allenbh@gmail.com>, Dave Jiang <dave.jiang@intel.com>,
	Serge Semin <fancer.lancer@gmail.com>, Eric Pilmore <epilmore@gigaio.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Logan Gunthorpe <logang@deltatee.com>
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

For NTB devices, we want to be able to trigger MSI interrupts
through a memory window. In these cases we may want to use
more interrupts than the NTB PCI device has available in its MSI-X
table.

We allow for this by creating a new 'virtual' interrupt. These
interrupts are allocated as usual but are not programmed into the
MSI-X table (as there may not be space for them).

The MSI address and data will then handled through an NTB MSI library
introduced later in this series.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/msi.c   | 54 +++++++++++++++++++++++++++++++++++++--------
 include/linux/msi.h |  8 +++++++
 include/linux/pci.h |  9 ++++++++
 3 files changed, 62 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 73986825d221..668bc16ef4d1 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -192,6 +192,9 @@ static void msi_mask_irq(struct msi_desc *desc, u32 mask, u32 flag)
 
 static void __iomem *pci_msix_desc_addr(struct msi_desc *desc)
 {
+	if (desc->msi_attrib.is_virtual)
+		return NULL;
+
 	return desc->mask_base +
 		desc->msi_attrib.entry_nr * PCI_MSIX_ENTRY_SIZE;
 }
@@ -206,14 +209,19 @@ static void __iomem *pci_msix_desc_addr(struct msi_desc *desc)
 u32 __pci_msix_desc_mask_irq(struct msi_desc *desc, u32 flag)
 {
 	u32 mask_bits = desc->masked;
+	void __iomem *desc_addr;
 
 	if (pci_msi_ignore_mask)
 		return 0;
+	desc_addr = pci_msix_desc_addr(desc);
+	if (!desc_addr)
+		return 0;
 
 	mask_bits &= ~PCI_MSIX_ENTRY_CTRL_MASKBIT;
 	if (flag)
 		mask_bits |= PCI_MSIX_ENTRY_CTRL_MASKBIT;
-	writel(mask_bits, pci_msix_desc_addr(desc) + PCI_MSIX_ENTRY_VECTOR_CTRL);
+
+	writel(mask_bits, desc_addr + PCI_MSIX_ENTRY_VECTOR_CTRL);
 
 	return mask_bits;
 }
@@ -273,6 +281,11 @@ void __pci_read_msi_msg(struct msi_desc *entry, struct msi_msg *msg)
 	if (entry->msi_attrib.is_msix) {
 		void __iomem *base = pci_msix_desc_addr(entry);
 
+		if (!base) {
+			WARN_ON(1);
+			return;
+		}
+
 		msg->address_lo = readl(base + PCI_MSIX_ENTRY_LOWER_ADDR);
 		msg->address_hi = readl(base + PCI_MSIX_ENTRY_UPPER_ADDR);
 		msg->data = readl(base + PCI_MSIX_ENTRY_DATA);
@@ -303,6 +316,9 @@ void __pci_write_msi_msg(struct msi_desc *entry, struct msi_msg *msg)
 	} else if (entry->msi_attrib.is_msix) {
 		void __iomem *base = pci_msix_desc_addr(entry);
 
+		if (!base)
+			goto skip;
+
 		writel(msg->address_lo, base + PCI_MSIX_ENTRY_LOWER_ADDR);
 		writel(msg->address_hi, base + PCI_MSIX_ENTRY_UPPER_ADDR);
 		writel(msg->data, base + PCI_MSIX_ENTRY_DATA);
@@ -327,7 +343,13 @@ void __pci_write_msi_msg(struct msi_desc *entry, struct msi_msg *msg)
 					      msg->data);
 		}
 	}
+
+skip:
 	entry->msg = *msg;
+
+	if (entry->write_msi_msg)
+		entry->write_msi_msg(entry, entry->write_msi_msg_data);
+
 }
 
 void pci_write_msi_msg(unsigned int irq, struct msi_msg *msg)
@@ -550,6 +572,7 @@ msi_setup_entry(struct pci_dev *dev, int nvec, struct irq_affinity *affd)
 
 	entry->msi_attrib.is_msix	= 0;
 	entry->msi_attrib.is_64		= !!(control & PCI_MSI_FLAGS_64BIT);
+	entry->msi_attrib.is_virtual    = 0;
 	entry->msi_attrib.entry_nr	= 0;
 	entry->msi_attrib.maskbit	= !!(control & PCI_MSI_FLAGS_MASKBIT);
 	entry->msi_attrib.default_irq	= dev->irq;	/* Save IOAPIC IRQ */
@@ -674,6 +697,7 @@ static int msix_setup_entries(struct pci_dev *dev, void __iomem *base,
 	struct irq_affinity_desc *curmsk, *masks = NULL;
 	struct msi_desc *entry;
 	int ret, i;
+	int vec_count = pci_msix_vec_count(dev);
 
 	if (affd)
 		masks = irq_create_affinity_masks(nvec, affd);
@@ -696,6 +720,10 @@ static int msix_setup_entries(struct pci_dev *dev, void __iomem *base,
 			entry->msi_attrib.entry_nr = entries[i].entry;
 		else
 			entry->msi_attrib.entry_nr = i;
+
+		entry->msi_attrib.is_virtual =
+			entry->msi_attrib.entry_nr >= vec_count;
+
 		entry->msi_attrib.default_irq	= dev->irq;
 		entry->mask_base		= base;
 
@@ -714,12 +742,19 @@ static void msix_program_entries(struct pci_dev *dev,
 {
 	struct msi_desc *entry;
 	int i = 0;
+	void __iomem *desc_addr;
 
 	for_each_pci_msi_entry(entry, dev) {
 		if (entries)
 			entries[i++].vector = entry->irq;
-		entry->masked = readl(pci_msix_desc_addr(entry) +
-				PCI_MSIX_ENTRY_VECTOR_CTRL);
+
+		desc_addr = pci_msix_desc_addr(entry);
+		if (desc_addr)
+			entry->masked = readl(desc_addr +
+					      PCI_MSIX_ENTRY_VECTOR_CTRL);
+		else
+			entry->masked = 0;
+
 		msix_mask_irq(entry, 1);
 	}
 }
@@ -932,7 +967,7 @@ int pci_msix_vec_count(struct pci_dev *dev)
 EXPORT_SYMBOL(pci_msix_vec_count);
 
 static int __pci_enable_msix(struct pci_dev *dev, struct msix_entry *entries,
-			     int nvec, struct irq_affinity *affd)
+			     int nvec, struct irq_affinity *affd, int flags)
 {
 	int nr_entries;
 	int i, j;
@@ -943,7 +978,7 @@ static int __pci_enable_msix(struct pci_dev *dev, struct msix_entry *entries,
 	nr_entries = pci_msix_vec_count(dev);
 	if (nr_entries < 0)
 		return nr_entries;
-	if (nvec > nr_entries)
+	if (nvec > nr_entries && !(flags & PCI_IRQ_VIRTUAL))
 		return nr_entries;
 
 	if (entries) {
@@ -1079,7 +1114,8 @@ EXPORT_SYMBOL(pci_enable_msi);
 
 static int __pci_enable_msix_range(struct pci_dev *dev,
 				   struct msix_entry *entries, int minvec,
-				   int maxvec, struct irq_affinity *affd)
+				   int maxvec, struct irq_affinity *affd,
+				   int flags)
 {
 	int rc, nvec = maxvec;
 
@@ -1096,7 +1132,7 @@ static int __pci_enable_msix_range(struct pci_dev *dev,
 				return -ENOSPC;
 		}
 
-		rc = __pci_enable_msix(dev, entries, nvec, affd);
+		rc = __pci_enable_msix(dev, entries, nvec, affd, flags);
 		if (rc == 0)
 			return nvec;
 
@@ -1127,7 +1163,7 @@ static int __pci_enable_msix_range(struct pci_dev *dev,
 int pci_enable_msix_range(struct pci_dev *dev, struct msix_entry *entries,
 		int minvec, int maxvec)
 {
-	return __pci_enable_msix_range(dev, entries, minvec, maxvec, NULL);
+	return __pci_enable_msix_range(dev, entries, minvec, maxvec, NULL, 0);
 }
 EXPORT_SYMBOL(pci_enable_msix_range);
 
@@ -1167,7 +1203,7 @@ int pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
 
 	if (flags & PCI_IRQ_MSIX) {
 		msix_vecs = __pci_enable_msix_range(dev, NULL, min_vecs,
-						    max_vecs, affd);
+						    max_vecs, affd, flags);
 		if (msix_vecs > 0)
 			return msix_vecs;
 	}
diff --git a/include/linux/msi.h b/include/linux/msi.h
index 7e9b81c3b50d..c278ae8760df 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -56,6 +56,10 @@ struct fsl_mc_msi_desc {
  * @msg:	The last set MSI message cached for reuse
  * @affinity:	Optional pointer to a cpu affinity mask for this descriptor
  *
+ * @write_msi_msg:	Callback that may be called when the MSI message
+ *			address or data changes
+ * @write_msi_msg_data:	Data parameter for the callback.
+ *
  * @masked:	[PCI MSI/X] Mask bits
  * @is_msix:	[PCI MSI/X] True if MSI-X
  * @multiple:	[PCI MSI/X] log2 num of messages allocated
@@ -78,6 +82,9 @@ struct msi_desc {
 	struct msi_msg			msg;
 	struct irq_affinity_desc	*affinity;
 
+	void (*write_msi_msg)(struct msi_desc *entry, void *data);
+	void *write_msi_msg_data;
+
 	union {
 		/* PCI MSI/X specific data */
 		struct {
@@ -88,6 +95,7 @@ struct msi_desc {
 				u8	multi_cap	: 3;
 				u8	maskbit		: 1;
 				u8	is_64		: 1;
+				u8	is_virtual	: 1;
 				u16	entry_nr;
 				unsigned default_irq;
 			} msi_attrib;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 77448215ef5b..c482aaa8e970 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1355,6 +1355,15 @@ int pci_set_vga_state(struct pci_dev *pdev, bool decode,
 #define PCI_IRQ_MSI		(1 << 1) /* Allow MSI interrupts */
 #define PCI_IRQ_MSIX		(1 << 2) /* Allow MSI-X interrupts */
 #define PCI_IRQ_AFFINITY	(1 << 3) /* Auto-assign affinity */
+
+/*
+ * Virtual interrupts allow for more interrupts to be allocated
+ * than the device has interrupts for. These are not programmed
+ * into the device's MSI-X table and must be handled by some
+ * other driver means.
+ */
+#define PCI_IRQ_VIRTUAL		(1 << 4)
+
 #define PCI_IRQ_ALL_TYPES \
 	(PCI_IRQ_LEGACY | PCI_IRQ_MSI | PCI_IRQ_MSIX)
 
-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
