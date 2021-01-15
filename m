Return-Path: <SRS0=aa3U=GS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26B92C4332B
	for <iommu@archiver.kernel.org>; Fri, 15 Jan 2021 12:14:09 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D27432371F
	for <iommu@archiver.kernel.org>; Fri, 15 Jan 2021 12:14:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D27432371F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 990D187480;
	Fri, 15 Jan 2021 12:14:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 33VDKc9FkqM4; Fri, 15 Jan 2021 12:14:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id D3CC2872A6;
	Fri, 15 Jan 2021 12:14:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C05A9C08A1;
	Fri, 15 Jan 2021 12:14:07 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A3252C013A;
 Fri, 15 Jan 2021 12:14:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 91174873E0;
 Fri, 15 Jan 2021 12:14:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9I8e6rpvpANI; Fri, 15 Jan 2021 12:14:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by hemlock.osuosl.org (Postfix) with ESMTP id F11B787482;
 Fri, 15 Jan 2021 12:14:02 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 78F4211FB;
 Fri, 15 Jan 2021 04:14:02 -0800 (PST)
Received: from usa.arm.com (a074945.blr.arm.com [10.162.16.71])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 01F233F70D;
 Fri, 15 Jan 2021 04:13:57 -0800 (PST)
From: Vivek Gautam <vivek.gautam@arm.com>
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux-foundation.org, virtualization@lists.linux-foundation.org
Subject: [PATCH RFC v1 02/15] iommu: Add a simple PASID table library
Date: Fri, 15 Jan 2021 17:43:29 +0530
Message-Id: <20210115121342.15093-3-vivek.gautam@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210115121342.15093-1-vivek.gautam@arm.com>
References: <20210115121342.15093-1-vivek.gautam@arm.com>
Cc: jean-philippe@linaro.org, kevin.tian@intel.com, mst@redhat.com,
 will.deacon@arm.com, alex.williamson@redhat.com, vivek.gautam@arm.com,
 robin.murphy@arm.com
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

Add a small API in iommu subsystem to handle PASID table allocation
requests from different consumer drivers, such as a paravirtualized
iommu driver. The API provides ops for allocating and freeing PASID
table, writing to it and managing the table caches.

This library also provides for registering a vendor API that attaches
to these ops. The vendor APIs would eventually perform arch level
implementations for these PASID tables.

Signed-off-by: Vivek Gautam <vivek.gautam@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: Eric Auger <eric.auger@redhat.com>
Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Liu Yi L <yi.l.liu@intel.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
---
 drivers/iommu/iommu-pasid-table.h | 134 ++++++++++++++++++++++++++++++
 1 file changed, 134 insertions(+)
 create mode 100644 drivers/iommu/iommu-pasid-table.h

diff --git a/drivers/iommu/iommu-pasid-table.h b/drivers/iommu/iommu-pasid-table.h
new file mode 100644
index 000000000000..bd4f57656f67
--- /dev/null
+++ b/drivers/iommu/iommu-pasid-table.h
@@ -0,0 +1,134 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PASID table management for the IOMMU
+ *
+ * Copyright (C) 2021 Arm Ltd.
+ */
+#ifndef __IOMMU_PASID_TABLE_H
+#define __IOMMU_PASID_TABLE_H
+
+#include <linux/io-pgtable.h>
+
+#include "arm/arm-smmu-v3/arm-smmu-v3.h"
+
+enum pasid_table_fmt {
+	PASID_TABLE_ARM_SMMU_V3,
+	PASID_TABLE_NUM_FMTS,
+};
+
+/**
+ * struct arm_smmu_cfg_info - arm-smmu-v3 specific configuration data
+ *
+ * @s1_cfg: arm-smmu-v3 stage1 config data
+ * @feat_flag: features supported by arm-smmu-v3 implementation
+ */
+struct arm_smmu_cfg_info {
+	struct arm_smmu_s1_cfg	*s1_cfg;
+	u32			feat_flag;
+};
+
+/**
+ * struct iommu_vendor_psdtable_cfg - Configuration data for PASID tables
+ *
+ * @iommu_dev: device performing the DMA table walks
+ * @fmt: The PASID table format
+ * @base: DMA address of the allocated table, set by the vendor driver
+ * @cfg: arm-smmu-v3 specific config data
+ */
+struct iommu_vendor_psdtable_cfg {
+	struct device		*iommu_dev;
+	enum pasid_table_fmt	fmt;
+	dma_addr_t		base;
+	union {
+		struct arm_smmu_cfg_info	cfg;
+	} vendor;
+};
+
+struct iommu_vendor_psdtable_ops;
+
+/**
+ * struct iommu_pasid_table - describes a set of PASID tables
+ *
+ * @cookie: An opaque token provided by the IOMMU driver and passed back to any
+ * callback routine.
+ * @cfg: A copy of the PASID table configuration
+ * @ops: The PASID table operations in use for this set of page tables
+ */
+struct iommu_pasid_table {
+	void					*cookie;
+	struct iommu_vendor_psdtable_cfg	cfg;
+	struct iommu_vendor_psdtable_ops	*ops;
+};
+
+#define pasid_table_cfg_to_table(pst_cfg) \
+	container_of((pst_cfg), struct iommu_pasid_table, cfg)
+
+struct iommu_vendor_psdtable_ops {
+	int (*alloc)(struct iommu_vendor_psdtable_cfg *cfg);
+	void (*free)(struct iommu_vendor_psdtable_cfg *cfg);
+	void (*prepare)(struct iommu_vendor_psdtable_cfg *cfg,
+			struct io_pgtable_cfg *pgtbl_cfg, u32 asid);
+	int (*write)(struct iommu_vendor_psdtable_cfg *cfg, int ssid,
+		     void *cookie);
+	void (*sync)(void *cookie, int ssid, bool leaf);
+};
+
+static inline int iommu_psdtable_alloc(struct iommu_pasid_table *tbl,
+				       struct iommu_vendor_psdtable_cfg *cfg)
+{
+	if (!tbl->ops->alloc)
+		return -ENOSYS;
+
+	return tbl->ops->alloc(cfg);
+}
+
+static inline void iommu_psdtable_free(struct iommu_pasid_table *tbl,
+				       struct iommu_vendor_psdtable_cfg *cfg)
+{
+	if (!tbl->ops->free)
+		return;
+
+	tbl->ops->free(cfg);
+}
+
+static inline int iommu_psdtable_prepare(struct iommu_pasid_table *tbl,
+					 struct iommu_vendor_psdtable_cfg *cfg,
+					 struct io_pgtable_cfg *pgtbl_cfg,
+					 u32 asid)
+{
+	if (!tbl->ops->prepare)
+		return -ENOSYS;
+
+	tbl->ops->prepare(cfg, pgtbl_cfg, asid);
+	return 0;
+}
+
+static inline int iommu_psdtable_write(struct iommu_pasid_table *tbl,
+				       struct iommu_vendor_psdtable_cfg *cfg,
+				       int ssid, void *cookie)
+{
+	if (!tbl->ops->write)
+		return -ENOSYS;
+
+	return tbl->ops->write(cfg, ssid, cookie);
+}
+
+static inline int iommu_psdtable_sync(struct iommu_pasid_table *tbl,
+				      void *cookie, int ssid, bool leaf)
+{
+	if (!tbl->ops->sync)
+		return -ENOSYS;
+
+	tbl->ops->sync(cookie, ssid, leaf);
+	return 0;
+}
+
+/* A placeholder to register vendor specific pasid layer */
+static inline struct iommu_pasid_table *
+iommu_register_pasid_table(enum pasid_table_fmt fmt,
+			   struct device *dev, void *cookie)
+{
+	return NULL;
+}
+
+#endif /* __IOMMU_PASID_TABLE_H */
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
