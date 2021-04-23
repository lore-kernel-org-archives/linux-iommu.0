Return-Path: <SRS0=1bbG=JU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46789C433B4
	for <iommu@archiver.kernel.org>; Fri, 23 Apr 2021 09:52:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAB89613E4
	for <iommu@archiver.kernel.org>; Fri, 23 Apr 2021 09:52:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAB89613E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 85598843F0;
	Fri, 23 Apr 2021 09:52:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oqnEvgCTouJ8; Fri, 23 Apr 2021 09:52:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 75B97843E9;
	Fri, 23 Apr 2021 09:52:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 54581C000F;
	Fri, 23 Apr 2021 09:52:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 43186C000B;
 Fri, 23 Apr 2021 09:52:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 24A6E414FC;
 Fri, 23 Apr 2021 09:52:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oXxZdmRSiD3R; Fri, 23 Apr 2021 09:52:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id 15FBF414D8;
 Fri, 23 Apr 2021 09:52:26 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8A00615EC;
 Fri, 23 Apr 2021 02:52:26 -0700 (PDT)
Received: from usa.arm.com (a074945.blr.arm.com [10.162.16.71])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 623793F774;
 Fri, 23 Apr 2021 02:52:22 -0700 (PDT)
From: Vivek Gautam <vivek.gautam@arm.com>
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux-foundation.org, virtualization@lists.linux-foundation.org
Subject: [PATCH RFC v1 06/11] iommu/pasid-table: Add pasid table ops for
 shared context management
Date: Fri, 23 Apr 2021 15:21:42 +0530
Message-Id: <20210423095147.27922-7-vivek.gautam@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210423095147.27922-1-vivek.gautam@arm.com>
References: <20210423095147.27922-1-vivek.gautam@arm.com>
Cc: jean-philippe@linaro.org, kevin.tian@intel.com, mst@redhat.com,
 will.deacon@arm.com, Vivek Gautam <vivek.gautam@arm.com>, robin.murphy@arm.com
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Add pasid table ops to allocate and free shared contexts. These helpers
interact using mmu notifiers, so add a mmu notifier implementation
structure in pasid tables as well. This change can help pull out the
shared pasid (context-descriptor) implementation out of arm-smmu-v3.

Signed-off-by: Vivek Gautam <vivek.gautam@arm.com>
---
 .../arm/arm-smmu-v3/arm-smmu-v3-cd-lib.c      |  1 +
 drivers/iommu/iommu-pasid-table.h             | 42 +++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-cd-lib.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-cd-lib.c
index fa1a6a632559..ea94f57ad261 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-cd-lib.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-cd-lib.c
@@ -299,6 +299,7 @@ arm_smmu_register_cd_table(struct device *dev, void *cookie,
 	tbl->cookie = cookie;
 	tbl->ops = &arm_cd_table_ops;
 	tbl->cfg.sync = sync_ops;
+	INIT_LIST_HEAD(&tbl->mmu_notifiers);
 
 	return tbl;
 }
diff --git a/drivers/iommu/iommu-pasid-table.h b/drivers/iommu/iommu-pasid-table.h
index 00b1c66e6a9e..4d6590e60f9b 100644
--- a/drivers/iommu/iommu-pasid-table.h
+++ b/drivers/iommu/iommu-pasid-table.h
@@ -8,6 +8,7 @@
 #define __IOMMU_PASID_TABLE_H
 
 #include <linux/io-pgtable.h>
+#include <linux/mmu_notifier.h>
 
 #include "arm/arm-smmu-v3/arm-smmu-v3.h"
 
@@ -52,6 +53,21 @@ struct iommu_vendor_psdtable_cfg {
 
 struct iommu_vendor_psdtable_ops;
 
+/* In-line with 'struct arm_smmu_mmu_notifier' */
+struct iommu_psdtable_mmu_notifier {
+	struct mmu_notifier		mn;
+	bool				cleared;
+	refcount_t			refs;
+	struct list_head		list;
+	/* cookie captures the domain implementation */
+	void				*cookie;
+	union {
+		struct arm_smmu_ctx_desc	*cd;
+	} vendor;
+};
+#define mn_to_pstiommu(mn)	\
+	container_of(mn, struct iommu_psdtable_mmu_notifier, mn)
+
 /**
  * struct iommu_pasid_table - describes a set of PASID tables
  *
@@ -64,6 +80,7 @@ struct iommu_pasid_table {
 	void					*cookie;
 	struct iommu_vendor_psdtable_cfg	cfg;
 	const struct iommu_vendor_psdtable_ops	*ops;
+	struct list_head			mmu_notifiers;
 };
 
 #define pasid_table_cfg_to_table(pst_cfg) \
@@ -77,6 +94,11 @@ struct iommu_vendor_psdtable_ops {
 	int (*write)(struct iommu_vendor_psdtable_cfg *cfg, int ssid,
 		     void *cookie);
 	bool (*free_asid)(struct xarray *xa, void *cookie_cd);
+	struct iommu_psdtable_mmu_notifier *
+	(*alloc_shared)(struct iommu_pasid_table *tbl, struct mm_struct *mm,
+			struct xarray *xa, u32 asid_bits);
+	void (*free_shared)(struct iommu_pasid_table *tbl, struct xarray *xa,
+			    void *cookie_cd);
 };
 
 /* CD manipulation ops */
@@ -129,6 +151,26 @@ static inline bool iommu_psdtable_free_asid(struct iommu_pasid_table *tbl,
 	return tbl->ops->free_asid(xa, cookie_cd);
 }
 
+static inline struct iommu_psdtable_mmu_notifier *
+iommu_psdtable_alloc_shared(struct iommu_pasid_table *tbl,
+			    struct mm_struct *mm, struct xarray *xa,
+			    u32 asid_bits)
+{
+	if (!tbl->ops->alloc_shared)
+		return false;
+
+	return tbl->ops->alloc_shared(tbl, mm, xa, asid_bits);
+}
+
+static inline void iommu_psdtable_free_shared(struct iommu_pasid_table *tbl,
+					      struct xarray *xa, void *cookie)
+{
+	if (!tbl->ops->free_shared)
+		return;
+
+	tbl->ops->free_shared(tbl, xa, cookie);
+}
+
 /* Sync ops for CD cfg or tlb */
 static inline void iommu_psdtable_flush(struct iommu_pasid_table *tbl,
 					void *cookie, int ssid, bool leaf)
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
