Return-Path: <SRS0=fKZg=UI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 299B4C28EBD
	for <iommu@archiver.kernel.org>; Sun,  9 Jun 2019 13:43:31 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08E9E20868
	for <iommu@archiver.kernel.org>; Sun,  9 Jun 2019 13:43:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08E9E20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 9B054CF3;
	Sun,  9 Jun 2019 13:41:28 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 4CDCCC5C
	for <iommu@lists.linux-foundation.org>;
	Sun,  9 Jun 2019 13:41:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id AE56476F
	for <iommu@lists.linux-foundation.org>;
	Sun,  9 Jun 2019 13:41:23 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
	by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	09 Jun 2019 06:41:19 -0700
X-ExtLoop1: 1
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
	by orsmga003.jf.intel.com with ESMTP; 09 Jun 2019 06:41:18 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
	Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>,
	Eric Auger <eric.auger@redhat.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: [PATCH v4 21/22] iommu/vt-d: Support flushing more translation cache
	types
Date: Sun,  9 Jun 2019 06:44:21 -0700
Message-Id: <1560087862-57608-22-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1560087862-57608-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1560087862-57608-1-git-send-email-jacob.jun.pan@linux.intel.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>,
	Andriy Shevchenko <andriy.shevchenko@linux.intel.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

When Shared Virtual Memory is exposed to a guest via vIOMMU, scalable
IOTLB invalidation may be passed down from outside IOMMU subsystems.
This patch adds invalidation functions that can be used for additional
translation cache types.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/dmar.c        | 50 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/intel-iommu.h | 21 +++++++++++++++----
 2 files changed, 67 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
index 6d969a1..0cda6fb 100644
--- a/drivers/iommu/dmar.c
+++ b/drivers/iommu/dmar.c
@@ -1357,6 +1357,21 @@ void qi_flush_iotlb(struct intel_iommu *iommu, u16 did, u64 addr,
 	qi_submit_sync(&desc, iommu);
 }
 
+/* PASID-based IOTLB Invalidate */
+void qi_flush_piotlb(struct intel_iommu *iommu, u16 did, u64 addr, u32 pasid,
+		unsigned int size_order, u64 granu, int ih)
+{
+	struct qi_desc desc;
+
+	desc.qw0 = QI_EIOTLB_PASID(pasid) | QI_EIOTLB_DID(did) |
+		QI_EIOTLB_GRAN(granu) | QI_EIOTLB_TYPE;
+	desc.qw1 = QI_EIOTLB_ADDR(addr) | QI_EIOTLB_IH(ih) |
+		QI_EIOTLB_AM(size_order);
+	desc.qw2 = 0;
+	desc.qw3 = 0;
+	qi_submit_sync(&desc, iommu);
+}
+
 void qi_flush_dev_iotlb(struct intel_iommu *iommu, u16 sid, u16 pfsid,
 			u16 qdep, u64 addr, unsigned mask)
 {
@@ -1380,6 +1395,41 @@ void qi_flush_dev_iotlb(struct intel_iommu *iommu, u16 sid, u16 pfsid,
 	qi_submit_sync(&desc, iommu);
 }
 
+/* PASID-based device IOTLB Invalidate */
+void qi_flush_dev_piotlb(struct intel_iommu *iommu, u16 sid, u16 pfsid,
+		u32 pasid,  u16 qdep, u64 addr, unsigned size, u64 granu)
+{
+	struct qi_desc desc;
+
+	desc.qw0 = QI_DEV_EIOTLB_PASID(pasid) | QI_DEV_EIOTLB_SID(sid) |
+		QI_DEV_EIOTLB_QDEP(qdep) | QI_DEIOTLB_TYPE |
+		QI_DEV_IOTLB_PFSID(pfsid);
+	desc.qw1 = QI_DEV_EIOTLB_GLOB(granu);
+
+	/* If S bit is 0, we only flush a single page. If S bit is set,
+	 * The least significant zero bit indicates the size. VT-d spec
+	 * 6.5.2.6
+	 */
+	if (!size)
+		desc.qw0 |= QI_DEV_EIOTLB_ADDR(addr) & ~QI_DEV_EIOTLB_SIZE;
+	else {
+		unsigned long mask = 1UL << (VTD_PAGE_SHIFT + size);
+
+		desc.qw1 |= QI_DEV_EIOTLB_ADDR(addr & ~mask) | QI_DEV_EIOTLB_SIZE;
+	}
+	qi_submit_sync(&desc, iommu);
+}
+
+void qi_flush_pasid_cache(struct intel_iommu *iommu, u16 did, u64 granu, int pasid)
+{
+	struct qi_desc desc;
+
+	desc.qw0 = QI_PC_TYPE | QI_PC_DID(did) | QI_PC_GRAN(granu) | QI_PC_PASID(pasid);
+	desc.qw1 = 0;
+	desc.qw2 = 0;
+	desc.qw3 = 0;
+	qi_submit_sync(&desc, iommu);
+}
 /*
  * Disable Queued Invalidation interface.
  */
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 94d3a9a..1cdb35b 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -339,7 +339,7 @@ enum {
 #define QI_IOTLB_GRAN(gran) 	(((u64)gran) >> (DMA_TLB_FLUSH_GRANU_OFFSET-4))
 #define QI_IOTLB_ADDR(addr)	(((u64)addr) & VTD_PAGE_MASK)
 #define QI_IOTLB_IH(ih)		(((u64)ih) << 6)
-#define QI_IOTLB_AM(am)		(((u8)am))
+#define QI_IOTLB_AM(am)		(((u8)am) & 0x3f)
 
 #define QI_CC_FM(fm)		(((u64)fm) << 48)
 #define QI_CC_SID(sid)		(((u64)sid) << 32)
@@ -357,17 +357,22 @@ enum {
 #define QI_PC_DID(did)		(((u64)did) << 16)
 #define QI_PC_GRAN(gran)	(((u64)gran) << 4)
 
-#define QI_PC_ALL_PASIDS	(QI_PC_TYPE | QI_PC_GRAN(0))
-#define QI_PC_PASID_SEL		(QI_PC_TYPE | QI_PC_GRAN(1))
+/* PASID cache invalidation granu */
+#define QI_PC_ALL_PASIDS	0
+#define QI_PC_PASID_SEL		1
 
 #define QI_EIOTLB_ADDR(addr)	((u64)(addr) & VTD_PAGE_MASK)
 #define QI_EIOTLB_GL(gl)	(((u64)gl) << 7)
 #define QI_EIOTLB_IH(ih)	(((u64)ih) << 6)
-#define QI_EIOTLB_AM(am)	(((u64)am))
+#define QI_EIOTLB_AM(am)	(((u64)am) & 0x3f)
 #define QI_EIOTLB_PASID(pasid) 	(((u64)pasid) << 32)
 #define QI_EIOTLB_DID(did)	(((u64)did) << 16)
 #define QI_EIOTLB_GRAN(gran) 	(((u64)gran) << 4)
 
+/* QI Dev-IOTLB inv granu */
+#define QI_DEV_IOTLB_GRAN_ALL		1
+#define QI_DEV_IOTLB_GRAN_PASID_SEL	0
+
 #define QI_DEV_EIOTLB_ADDR(a)	((u64)(a) & VTD_PAGE_MASK)
 #define QI_DEV_EIOTLB_SIZE	(((u64)1) << 11)
 #define QI_DEV_EIOTLB_GLOB(g)	((u64)g)
@@ -658,8 +663,16 @@ extern void qi_flush_context(struct intel_iommu *iommu, u16 did, u16 sid,
 			     u8 fm, u64 type);
 extern void qi_flush_iotlb(struct intel_iommu *iommu, u16 did, u64 addr,
 			  unsigned int size_order, u64 type);
+extern void qi_flush_piotlb(struct intel_iommu *iommu, u16 did, u64 addr,
+			u32 pasid, unsigned int size_order, u64 type, int ih);
 extern void qi_flush_dev_iotlb(struct intel_iommu *iommu, u16 sid, u16 pfsid,
 			u16 qdep, u64 addr, unsigned mask);
+
+extern void qi_flush_dev_piotlb(struct intel_iommu *iommu, u16 sid, u16 pfsid,
+			u32 pasid, u16 qdep, u64 addr, unsigned size, u64 granu);
+
+extern void qi_flush_pasid_cache(struct intel_iommu *iommu, u16 did, u64 granu, int pasid);
+
 extern int qi_submit_sync(struct qi_desc *desc, struct intel_iommu *iommu);
 
 extern int dmar_ir_support(void);
-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
