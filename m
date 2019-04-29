Return-Path: <SRS0=wClR=S7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD989C43218
	for <iommu@archiver.kernel.org>; Mon, 29 Apr 2019 02:18:55 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A78BD20675
	for <iommu@archiver.kernel.org>; Mon, 29 Apr 2019 02:18:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A78BD20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id EEB031DE2;
	Mon, 29 Apr 2019 02:18:38 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 958A11D35
	for <iommu@lists.linux-foundation.org>;
	Mon, 29 Apr 2019 02:16:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 396C3608
	for <iommu@lists.linux-foundation.org>;
	Mon, 29 Apr 2019 02:16:05 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
	by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	28 Apr 2019 19:16:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,408,1549958400"; d="scan'208";a="146537849"
Received: from allen-box.sh.intel.com ([10.239.159.136])
	by orsmga003.jf.intel.com with ESMTP; 28 Apr 2019 19:16:03 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: David Woodhouse <dwmw2@infradead.org>,
	Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v3 3/8] iommu/vt-d: Expose ISA direct mapping region via
	iommu_get_resv_regions
Date: Mon, 29 Apr 2019 10:09:20 +0800
Message-Id: <20190429020925.18136-4-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190429020925.18136-1-baolu.lu@linux.intel.com>
References: <20190429020925.18136-1-baolu.lu@linux.intel.com>
Cc: kevin.tian@intel.com, ashok.raj@intel.com, dima@arista.com,
	tmurphy@arista.com, linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org, jacob.jun.pan@intel.com
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
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190429020920.tTvInu8N8iRvB-t1EeP5InqaHKIHW5WBd15a0tvAiU8@z>

From: James Sewart <jamessewart@arista.com>

To support mapping ISA region via iommu_group_create_direct_mappings,
make sure its exposed by iommu_get_resv_regions. This allows
deduplication of reserved region mappings.

Signed-off-by: James Sewart <jamessewart@arista.com>
---
 drivers/iommu/intel-iommu.c | 43 +++++++++++++++++++++++++++++--------
 1 file changed, 34 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index af025955f1bc..e9f31b062305 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -339,6 +339,8 @@ static LIST_HEAD(dmar_rmrr_units);
 #define for_each_rmrr_units(rmrr) \
 	list_for_each_entry(rmrr, &dmar_rmrr_units, list)
 
+static struct iommu_resv_region *isa_resv_region;
+
 /* bitmap for indexing intel_iommus */
 static int g_num_of_iommus;
 
@@ -2785,26 +2787,33 @@ static inline int iommu_prepare_rmrr_dev(struct dmar_rmrr_unit *rmrr,
 					  rmrr->end_address);
 }
 
+static inline struct iommu_resv_region *iommu_get_isa_resv_region(void)
+{
+	if (!isa_resv_region)
+		isa_resv_region = iommu_alloc_resv_region(0, 1UL << 24, 0,
+							  IOMMU_RESV_DIRECT);
+
+	return isa_resv_region;
+}
+
 #ifdef CONFIG_INTEL_IOMMU_FLOPPY_WA
-static inline void iommu_prepare_isa(void)
+static inline void iommu_prepare_isa(struct pci_dev *pdev)
 {
-	struct pci_dev *pdev;
 	int ret;
+	struct iommu_resv_region *reg = iommu_get_isa_resv_region();
 
-	pdev = pci_get_class(PCI_CLASS_BRIDGE_ISA << 8, NULL);
-	if (!pdev)
+	if (!reg)
 		return;
 
 	pr_info("Prepare 0-16MiB unity mapping for LPC\n");
-	ret = iommu_prepare_identity_map(&pdev->dev, 0, 16*1024*1024 - 1);
+	ret = iommu_prepare_identity_map(&pdev->dev, reg->start,
+					 reg->start + reg->length - 1);
 
 	if (ret)
 		pr_err("Failed to create 0-16MiB identity map - floppy might not work\n");
-
-	pci_dev_put(pdev);
 }
 #else
-static inline void iommu_prepare_isa(void)
+static inline void iommu_prepare_isa(struct pci_dev *pdev)
 {
 	return;
 }
@@ -3293,6 +3302,7 @@ static int __init init_dmars(void)
 	struct dmar_rmrr_unit *rmrr;
 	bool copied_tables = false;
 	struct device *dev;
+	struct pci_dev *pdev;
 	struct intel_iommu *iommu;
 	int i, ret;
 
@@ -3473,7 +3483,11 @@ static int __init init_dmars(void)
 		}
 	}
 
-	iommu_prepare_isa();
+	pdev = pci_get_class(PCI_CLASS_BRIDGE_ISA << 8, NULL);
+	if (pdev) {
+		iommu_prepare_isa(pdev);
+		pci_dev_put(pdev);
+	}
 
 domains_done:
 
@@ -5498,6 +5512,17 @@ static void intel_iommu_get_resv_regions(struct device *device,
 	}
 	rcu_read_unlock();
 
+#ifdef CONFIG_INTEL_IOMMU_FLOPPY_WA
+	if (dev_is_pci(device)) {
+		struct pci_dev *pdev = to_pci_dev(device);
+
+		if ((pdev->class >> 8) == PCI_CLASS_BRIDGE_ISA) {
+			reg = iommu_get_isa_resv_region();
+			list_add_tail(&reg->list, head);
+		}
+	}
+#endif /* CONFIG_INTEL_IOMMU_FLOPPY_WA */
+
 	reg = iommu_alloc_resv_region(IOAPIC_RANGE_START,
 				      IOAPIC_RANGE_END - IOAPIC_RANGE_START + 1,
 				      0, IOMMU_RESV_MSI);
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
