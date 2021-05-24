Return-Path: <SRS0=7UOM=KT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22C1EC2B9F7
	for <iommu@archiver.kernel.org>; Mon, 24 May 2021 11:03:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8A8E61132
	for <iommu@archiver.kernel.org>; Mon, 24 May 2021 11:03:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8A8E61132
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AF79C83487;
	Mon, 24 May 2021 11:03:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ULHhNiiqr1MZ; Mon, 24 May 2021 11:03:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 70EBF83147;
	Mon, 24 May 2021 11:03:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5C4F2C000E;
	Mon, 24 May 2021 11:03:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0955FC000E
 for <iommu@lists.linux-foundation.org>; Mon, 24 May 2021 11:03:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DCA9740141
 for <iommu@lists.linux-foundation.org>; Mon, 24 May 2021 11:03:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LJxWT13wnT9X for <iommu@lists.linux-foundation.org>;
 Mon, 24 May 2021 11:03:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4AC214023B
 for <iommu@lists.linux-foundation.org>; Mon, 24 May 2021 11:03:49 +0000 (UTC)
Received: from dggems704-chm.china.huawei.com (unknown [172.30.72.59])
 by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FpZ541s5yzCx69;
 Mon, 24 May 2021 19:00:56 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 dggems704-chm.china.huawei.com (10.3.19.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 24 May 2021 19:03:38 +0800
Received: from A2006125610.china.huawei.com (10.47.80.77) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 24 May 2021 12:03:28 +0100
From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To: <linux-arm-kernel@lists.infradead.org>, <linux-acpi@vger.kernel.org>,
 <iommu@lists.linux-foundation.org>
Subject: [PATCH v5 3/8] ACPI/IORT: Add a helper to retrieve RMR memory regions
Date: Mon, 24 May 2021 12:02:17 +0100
Message-ID: <20210524110222.2212-4-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20210524110222.2212-1-shameerali.kolothum.thodi@huawei.com>
References: <20210524110222.2212-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.47.80.77]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Cc: jon@solid-run.com, linuxarm@huawei.com, steven.price@arm.com,
 guohanjun@huawei.com, yangyicong@huawei.com, Sami.Mujawar@arm.com,
 robin.murphy@arm.com, wanghuiqiang@huawei.com
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

Add a helper function that retrieves RMR memory descriptors
associated with a given IOMMU. This will be used by IOMMU
drivers to setup necessary mappings.

Now that we have this, invoke it from the generic helper
interface.

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 drivers/acpi/arm64/iort.c | 50 +++++++++++++++++++++++++++++++++++++++
 drivers/iommu/dma-iommu.c |  4 ++++
 include/linux/acpi_iort.h |  7 ++++++
 3 files changed, 61 insertions(+)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index fea1ffaedf3b..01917caf58de 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -12,6 +12,7 @@
 
 #include <linux/acpi_iort.h>
 #include <linux/bitfield.h>
+#include <linux/dma-iommu.h>
 #include <linux/iommu.h>
 #include <linux/kernel.h>
 #include <linux/list.h>
@@ -837,6 +838,53 @@ static inline int iort_add_device_replay(struct device *dev)
 	return err;
 }
 
+/**
+ * iort_iommu_get_rmrs - Helper to retrieve RMR info associated with IOMMU
+ * @iommu: fwnode for the IOMMU
+ * @head: RMR list head to be populated
+ *
+ * Returns: 0 on success, <0 failure
+ */
+int iort_iommu_get_rmrs(struct fwnode_handle *iommu_fwnode,
+			struct list_head *head)
+{
+	struct iort_rmr_entry *e;
+	struct acpi_iort_node *iommu;
+	int rmrs = 0;
+
+	iommu = iort_get_iort_node(iommu_fwnode);
+	if (!iommu || list_empty(&iort_rmr_list))
+		return -ENODEV;
+
+	list_for_each_entry(e, &iort_rmr_list, list) {
+		int prot = IOMMU_READ | IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO;
+		struct iommu_resv_region *region;
+		enum iommu_resv_type type;
+		struct acpi_iort_rmr_desc *rmr_desc;
+
+		if (e->smmu != iommu)
+			continue;
+
+		rmr_desc = e->rmr_desc;
+		if (e->flags & IOMMU_RMR_REMAP_PERMITTED)
+			type = IOMMU_RESV_DIRECT_RELAXABLE;
+		else
+			type = IOMMU_RESV_DIRECT;
+
+		region = iommu_alloc_resv_region(rmr_desc->base_address,
+						 rmr_desc->length,
+						 prot, type);
+		if (region) {
+			region->fw_data.rmr.flags = e->flags;
+			region->fw_data.rmr.sid = e->sid;
+			list_add_tail(&region->list, head);
+			rmrs++;
+		}
+	}
+
+	return (rmrs == 0) ? -ENODEV : 0;
+}
+
 /**
  * iort_iommu_msi_get_resv_regions - Reserved region driver helper
  * @dev: Device from iommu_get_resv_regions()
@@ -1108,6 +1156,8 @@ int iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head)
 const struct iommu_ops *iort_iommu_configure_id(struct device *dev,
 						const u32 *input_id)
 { return NULL; }
+int iort_iommu_get_rmrs(struct fwnode_handle *fwnode, struct list_head *head)
+{ return -ENODEV; }
 #endif
 
 static int nc_dma_get_range(struct device *dev, u64 *size)
diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 229ec65d98be..f893d460cfa4 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -185,6 +185,9 @@ EXPORT_SYMBOL(iommu_put_dma_cookie);
 int iommu_dma_get_rmrs(struct fwnode_handle *iommu_fwnode,
 		       struct list_head *list)
 {
+	if (!is_of_node(iommu_fwnode))
+		return iort_iommu_get_rmrs(iommu_fwnode, list);
+
 	return -EINVAL;
 }
 EXPORT_SYMBOL(iommu_dma_get_rmrs);
@@ -200,6 +203,7 @@ EXPORT_SYMBOL(iommu_dma_get_rmrs);
 void iommu_dma_put_rmrs(struct fwnode_handle *iommu_fwnode,
 			struct list_head *list)
 {
+	generic_iommu_put_resv_regions(iommu_fwnode->dev, list);
 }
 EXPORT_SYMBOL(iommu_dma_put_rmrs);
 
diff --git a/include/linux/acpi_iort.h b/include/linux/acpi_iort.h
index 1a12baa58e40..e8c45fa59531 100644
--- a/include/linux/acpi_iort.h
+++ b/include/linux/acpi_iort.h
@@ -39,6 +39,8 @@ const struct iommu_ops *iort_iommu_configure_id(struct device *dev,
 						const u32 *id_in);
 int iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head);
 phys_addr_t acpi_iort_dma_get_max_cpu_address(void);
+int iort_iommu_get_rmrs(struct fwnode_handle *iommu_fwnode,
+			struct list_head *list);
 #else
 static inline void acpi_iort_init(void) { }
 static inline u32 iort_msi_map_id(struct device *dev, u32 id)
@@ -59,6 +61,11 @@ int iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head)
 
 static inline phys_addr_t acpi_iort_dma_get_max_cpu_address(void)
 { return PHYS_ADDR_MAX; }
+
+static inline
+int iort_iommu_get_rmrs(struct fwnode_handle *iommu_fwnode,
+			struct list_head *list)
+{ return -ENODEV; }
 #endif
 
 #endif /* __ACPI_IORT_H__ */
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
