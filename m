Return-Path: <SRS0=kikZ=TJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADEB8C46460
	for <iommu@archiver.kernel.org>; Thu,  9 May 2019 18:45:01 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FDCE217F9
	for <iommu@archiver.kernel.org>; Thu,  9 May 2019 18:45:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FDCE217F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 66243E20;
	Thu,  9 May 2019 18:45:01 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 8BE83A7F
	for <iommu@lists.linux-foundation.org>;
	Thu,  9 May 2019 18:45:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 1D2607DB
	for <iommu@lists.linux-foundation.org>;
	Thu,  9 May 2019 18:45:00 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
	by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	09 May 2019 11:44:59 -0700
X-ExtLoop1: 1
Received: from sai-dev-mach.sc.intel.com ([143.183.140.153])
	by orsmga005.jf.intel.com with ESMTP; 09 May 2019 11:44:59 -0700
From: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
To: iommu@lists.linux-foundation.org
Subject: [PATCH 2/3] iommu/vt-d: Introduce macros useful for dumping DMAR table
Date: Thu,  9 May 2019 11:42:11 -0700
Message-Id: <c8a02ebf74dcfb7ed30eba8f69b06e76327ebf44.1556762845.git.sai.praneeth.prakhya@intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <cover.1556762845.git.sai.praneeth.prakhya@intel.com>
References: <cover.1556762845.git.sai.praneeth.prakhya@intel.com>
MIME-Version: 1.0
Cc: Ashok Raj <ashok.raj@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	David Woodhouse <dwmw2@infradead.org>
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

From: Sai Praneeth <sai.praneeth.prakhya@intel.com>

A scalable mode DMAR table walk would involve looking at bits in each stage
of walk, like,
1. Is PASID enabled in the context entry?
2. What's the size of PASID directory?
3. Is the PASID directory entry present?
4. Is the PASID table entry present?
5. Number of PASID table entries?

Hence, add these macros that will later be used during this walk.
Apart from adding new macros, move existing macros (like
pasid_pde_is_present() and get_pasid_table_from_pde()) from pasid.c file
to pasid.h header file so that they could be reused.

Cc: Joerg Roedel <joro@8bytes.org>
Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Sohil Mehta <sohil.mehta@intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
---
 drivers/iommu/intel-pasid.c | 17 -----------------
 drivers/iommu/intel-pasid.h | 26 ++++++++++++++++++++++++++
 2 files changed, 26 insertions(+), 17 deletions(-)

diff --git a/drivers/iommu/intel-pasid.c b/drivers/iommu/intel-pasid.c
index 03b12d2ee213..0be00ff53d25 100644
--- a/drivers/iommu/intel-pasid.c
+++ b/drivers/iommu/intel-pasid.c
@@ -167,23 +167,6 @@ int intel_pasid_alloc_table(struct device *dev)
 	return 0;
 }
 
-/* Get PRESENT bit of a PASID directory entry. */
-static inline bool
-pasid_pde_is_present(struct pasid_dir_entry *pde)
-{
-	return READ_ONCE(pde->val) & PASID_PTE_PRESENT;
-}
-
-/* Get PASID table from a PASID directory entry. */
-static inline struct pasid_entry *
-get_pasid_table_from_pde(struct pasid_dir_entry *pde)
-{
-	if (!pasid_pde_is_present(pde))
-		return NULL;
-
-	return phys_to_virt(READ_ONCE(pde->val) & PDE_PFN_MASK);
-}
-
 void intel_pasid_free_table(struct device *dev)
 {
 	struct device_domain_info *info;
diff --git a/drivers/iommu/intel-pasid.h b/drivers/iommu/intel-pasid.h
index 23537b3f34e3..fc8cd8f17de1 100644
--- a/drivers/iommu/intel-pasid.h
+++ b/drivers/iommu/intel-pasid.h
@@ -18,6 +18,10 @@
 #define PDE_PFN_MASK			PAGE_MASK
 #define PASID_PDE_SHIFT			6
 #define MAX_NR_PASID_BITS		20
+#define PASID_TBL_ENTRIES		BIT(PASID_PDE_SHIFT)
+
+#define is_pasid_enabled(entry)		(((entry)->lo >> 3) & 0x1)
+#define get_pasid_dir_size(entry)	(1 << ((((entry)->lo >> 9) & 0x7) + 7))
 
 /*
  * Domain ID reserved for pasid entries programmed for first-level
@@ -49,6 +53,28 @@ struct pasid_table {
 	struct list_head	dev;		/* device list */
 };
 
+/* Get PRESENT bit of a PASID directory entry. */
+static inline bool pasid_pde_is_present(struct pasid_dir_entry *pde)
+{
+	return READ_ONCE(pde->val) & PASID_PTE_PRESENT;
+}
+
+/* Get PASID table from a PASID directory entry. */
+static inline struct pasid_entry *
+get_pasid_table_from_pde(struct pasid_dir_entry *pde)
+{
+	if (!pasid_pde_is_present(pde))
+		return NULL;
+
+	return phys_to_virt(READ_ONCE(pde->val) & PDE_PFN_MASK);
+}
+
+/* Get PRESENT bit of a PASID table entry. */
+static inline bool pasid_pte_is_present(struct pasid_entry *pte)
+{
+	return READ_ONCE(pte->val[0]) & PASID_PTE_PRESENT;
+}
+
 extern u32 intel_pasid_max_id;
 int intel_pasid_alloc_id(void *ptr, int start, int end, gfp_t gfp);
 void intel_pasid_free_id(int pasid);
-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
