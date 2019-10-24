Return-Path: <SRS0=zRLl=YR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FBA3CA9EBC
	for <iommu@archiver.kernel.org>; Thu, 24 Oct 2019 19:51:17 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F04A21A4A
	for <iommu@archiver.kernel.org>; Thu, 24 Oct 2019 19:51:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F04A21A4A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id D58C61263;
	Thu, 24 Oct 2019 19:50:50 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 904AD1150
	for <iommu@lists.linux-foundation.org>;
	Thu, 24 Oct 2019 19:50:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 0710389A
	for <iommu@lists.linux-foundation.org>;
	Thu, 24 Oct 2019 19:50:47 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	24 Oct 2019 12:50:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,225,1569308400"; d="scan'208";a="282043164"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
	by orsmga001.jf.intel.com with ESMTP; 24 Oct 2019 12:50:43 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
	Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.com>
Subject: [PATCH v7 10/11] iommu/vt-d: Support flushing more translation cache
	types
Date: Thu, 24 Oct 2019 12:55:03 -0700
Message-Id: <1571946904-86776-11-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1571946904-86776-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1571946904-86776-1-git-send-email-jacob.jun.pan@linux.intel.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>,
	Jonathan Cameron <jic23@kernel.org>
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
 drivers/iommu/dmar.c        | 46 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/iommu/intel-pasid.c |  3 ++-
 include/linux/intel-iommu.h | 21 +++++++++++++++++----
 3 files changed, 65 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
index 49bb7d76e646..0ce2d32ff99e 100644
--- a/drivers/iommu/dmar.c
+++ b/drivers/iommu/dmar.c
@@ -1346,6 +1346,20 @@ void qi_flush_iotlb(struct intel_iommu *iommu, u16 did, u64 addr,
 	qi_submit_sync(&desc, iommu);
 }
 
+/* PASID-based IOTLB Invalidate */
+void qi_flush_piotlb(struct intel_iommu *iommu, u16 did, u64 addr, u32 pasid,
+		unsigned int size_order, u64 granu, int ih)
+{
+	struct qi_desc desc = {.qw2 = 0, .qw3 = 0};
+
+	desc.qw0 = QI_EIOTLB_PASID(pasid) | QI_EIOTLB_DID(did) |
+		QI_EIOTLB_GRAN(granu) | QI_EIOTLB_TYPE;
+	desc.qw1 = QI_EIOTLB_ADDR(addr) | QI_EIOTLB_IH(ih) |
+		QI_EIOTLB_AM(size_order);
+
+	qi_submit_sync(&desc, iommu);
+}
+
 void qi_flush_dev_iotlb(struct intel_iommu *iommu, u16 sid, u16 pfsid,
 			u16 qdep, u64 addr, unsigned mask)
 {
@@ -1369,6 +1383,38 @@ void qi_flush_dev_iotlb(struct intel_iommu *iommu, u16 sid, u16 pfsid,
 	qi_submit_sync(&desc, iommu);
 }
 
+/* PASID-based device IOTLB Invalidate */
+void qi_flush_dev_piotlb(struct intel_iommu *iommu, u16 sid, u16 pfsid,
+		u32 pasid,  u16 qdep, u64 addr, unsigned size_order, u64 granu)
+{
+	struct qi_desc desc;
+
+	desc.qw0 = QI_DEV_EIOTLB_PASID(pasid) | QI_DEV_EIOTLB_SID(sid) |
+		QI_DEV_EIOTLB_QDEP(qdep) | QI_DEIOTLB_TYPE |
+		QI_DEV_IOTLB_PFSID(pfsid);
+	desc.qw1 = QI_DEV_EIOTLB_GLOB(granu);
+
+	/* If S bit is 0, we only flush a single page. If S bit is set,
+	 * The least significant zero bit indicates the invalidation address
+	 * range. VT-d spec 6.5.2.6.
+	 * e.g. address bit 12[0] indicates 8KB, 13[0] indicates 16KB.
+	 */
+	if (!size_order) {
+		desc.qw0 |= QI_DEV_EIOTLB_ADDR(addr) & ~QI_DEV_EIOTLB_SIZE;
+	} else {
+		unsigned long mask = 1UL << (VTD_PAGE_SHIFT + size_order);
+		desc.qw1 |= QI_DEV_EIOTLB_ADDR(addr & ~mask) | QI_DEV_EIOTLB_SIZE;
+	}
+	qi_submit_sync(&desc, iommu);
+}
+
+void qi_flush_pasid_cache(struct intel_iommu *iommu, u16 did, u64 granu, int pasid)
+{
+	struct qi_desc desc = {.qw1 = 0, .qw2 = 0, .qw3 = 0};
+
+	desc.qw0 = QI_PC_PASID(pasid) | QI_PC_DID(did) | QI_PC_GRAN(granu) | QI_PC_TYPE;
+	qi_submit_sync(&desc, iommu);
+}
 /*
  * Disable Queued Invalidation interface.
  */
diff --git a/drivers/iommu/intel-pasid.c b/drivers/iommu/intel-pasid.c
index f846a907cfcf..6d7a701ef4d3 100644
--- a/drivers/iommu/intel-pasid.c
+++ b/drivers/iommu/intel-pasid.c
@@ -491,7 +491,8 @@ pasid_cache_invalidation_with_pasid(struct intel_iommu *iommu,
 {
 	struct qi_desc desc;
 
-	desc.qw0 = QI_PC_DID(did) | QI_PC_PASID_SEL | QI_PC_PASID(pasid);
+	desc.qw0 = QI_PC_DID(did) | QI_PC_GRAN(QI_PC_PASID_SEL) |
+		QI_PC_PASID(pasid) | QI_PC_TYPE;
 	desc.qw1 = 0;
 	desc.qw2 = 0;
 	desc.qw3 = 0;
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 6c74c71b1ebf..a25fb3a0ea5b 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -332,7 +332,7 @@ enum {
 #define QI_IOTLB_GRAN(gran) 	(((u64)gran) >> (DMA_TLB_FLUSH_GRANU_OFFSET-4))
 #define QI_IOTLB_ADDR(addr)	(((u64)addr) & VTD_PAGE_MASK)
 #define QI_IOTLB_IH(ih)		(((u64)ih) << 6)
-#define QI_IOTLB_AM(am)		(((u8)am))
+#define QI_IOTLB_AM(am)		(((u8)am) & 0x3f)
 
 #define QI_CC_FM(fm)		(((u64)fm) << 48)
 #define QI_CC_SID(sid)		(((u64)sid) << 32)
@@ -350,16 +350,21 @@ enum {
 #define QI_PC_DID(did)		(((u64)did) << 16)
 #define QI_PC_GRAN(gran)	(((u64)gran) << 4)
 
-#define QI_PC_ALL_PASIDS	(QI_PC_TYPE | QI_PC_GRAN(0))
-#define QI_PC_PASID_SEL		(QI_PC_TYPE | QI_PC_GRAN(1))
+/* PASID cache invalidation granu */
+#define QI_PC_ALL_PASIDS	0
+#define QI_PC_PASID_SEL		1
 
 #define QI_EIOTLB_ADDR(addr)	((u64)(addr) & VTD_PAGE_MASK)
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
@@ -655,8 +660,16 @@ extern void qi_flush_context(struct intel_iommu *iommu, u16 did, u16 sid,
 			     u8 fm, u64 type);
 extern void qi_flush_iotlb(struct intel_iommu *iommu, u16 did, u64 addr,
 			  unsigned int size_order, u64 type);
+extern void qi_flush_piotlb(struct intel_iommu *iommu, u16 did, u64 addr,
+			u32 pasid, unsigned int size_order, u64 type, int ih);
 extern void qi_flush_dev_iotlb(struct intel_iommu *iommu, u16 sid, u16 pfsid,
 			u16 qdep, u64 addr, unsigned mask);
+
+extern void qi_flush_dev_piotlb(struct intel_iommu *iommu, u16 sid, u16 pfsid,
+			u32 pasid, u16 qdep, u64 addr, unsigned size_order, u64 granu);
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
