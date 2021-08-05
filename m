Return-Path: <SRS0=+AsR=M4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_RED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC799C4338F
	for <iommu@archiver.kernel.org>; Thu,  5 Aug 2021 08:09:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D13361040
	for <iommu@archiver.kernel.org>; Thu,  5 Aug 2021 08:09:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9D13361040
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7A01A81B9D;
	Thu,  5 Aug 2021 08:09:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JfuUngCy2tp4; Thu,  5 Aug 2021 08:09:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4CC5A818C9;
	Thu,  5 Aug 2021 08:09:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 24705C001A;
	Thu,  5 Aug 2021 08:09:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 96F8AC000E
 for <iommu@lists.linux-foundation.org>; Thu,  5 Aug 2021 08:09:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 86335403A2
 for <iommu@lists.linux-foundation.org>; Thu,  5 Aug 2021 08:09:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id v5NO5SujBG9M for <iommu@lists.linux-foundation.org>;
 Thu,  5 Aug 2021 08:09:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by smtp4.osuosl.org (Postfix) with ESMTPS id ACAAF40398
 for <iommu@lists.linux-foundation.org>; Thu,  5 Aug 2021 08:09:13 +0000 (UTC)
Received: from fraeml740-chm.china.huawei.com (unknown [172.18.147.206])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GgLpt38RLz6F8FD;
 Thu,  5 Aug 2021 16:08:54 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml740-chm.china.huawei.com (10.206.15.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 5 Aug 2021 10:09:11 +0200
Received: from A2006125610.china.huawei.com (10.47.91.4) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 5 Aug 2021 09:09:04 +0100
From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To: <linux-arm-kernel@lists.infradead.org>, <linux-acpi@vger.kernel.org>,
 <iommu@lists.linux-foundation.org>
Subject: [PATCH v7 4/9] ACPI/IORT: Add a helper to retrieve RMR memory regions
Date: Thu, 5 Aug 2021 09:07:19 +0100
Message-ID: <20210805080724.480-5-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20210805080724.480-1-shameerali.kolothum.thodi@huawei.com>
References: <20210805080724.480-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.47.91.4]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Cc: robin.murphy@arm.com, jon@solid-run.com, linuxarm@huawei.com,
 steven.price@arm.com, guohanjun@huawei.com, yangyicong@huawei.com,
 Sami.Mujawar@arm.com, will@kernel.org, wanghuiqiang@huawei.com
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

Add a helper function (iort_iommu_get_rmrs()) that retrieves RMR
memory descriptors associated with a given IOMMU. This will be used
by IOMMU drivers to setup necessary mappings.

Invoke it from the generic helper iommu_dma_get_rmrs().

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 drivers/acpi/arm64/iort.c | 38 ++++++++++++++++++++++++++++++++++++++
 drivers/iommu/dma-iommu.c |  4 ++++
 include/linux/acpi_iort.h |  7 +++++++
 3 files changed, 49 insertions(+)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index d76ba46ebe67..3c32d62e63b6 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -809,6 +809,42 @@ static struct acpi_iort_node *iort_get_msi_resv_iommu(struct device *dev)
 	return NULL;
 }
 
+/**
+ * iort_iommu_get_rmrs() - Helper to retrieve RMR info associated with IOMMU
+ * @iommu_fwnode: fwnode for the IOMMU
+ * @head: RMR list head to be populated
+ *
+ * Returns: 0 on success, <0 failure. Please note, we will keep the already
+ *          allocated RMR reserve regions in case of a kmemdup()
+ *          failure.
+ */
+int iort_iommu_get_rmrs(struct fwnode_handle *iommu_fwnode,
+			struct list_head *head)
+{
+	struct iommu_resv_region *e;
+	struct acpi_iort_node *iommu;
+	int rmrs = 0;
+
+	iommu = iort_get_iort_node(iommu_fwnode);
+	if (!iommu || list_empty(&iort_rmr_list))
+		return -ENODEV;
+
+	list_for_each_entry(e, &iort_rmr_list, list) {
+		struct iommu_resv_region *region;
+
+		if (e->fw_data.rmr.smmu != iommu)
+			continue;
+
+		region = kmemdup(e, sizeof(*region), GFP_KERNEL);
+		if (region) {
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
@@ -1041,6 +1077,8 @@ int iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head)
 { return 0; }
 int iort_iommu_configure_id(struct device *dev, const u32 *input_id)
 { return -ENODEV; }
+int iort_iommu_get_rmrs(struct fwnode_handle *fwnode, struct list_head *head)
+{ return -ENODEV; }
 #endif
 
 static int nc_dma_get_range(struct device *dev, u64 *size)
diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 2fa2445e9070..1b6e27475279 100644
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
index f1f0842a2cb2..d8c030c103f5 100644
--- a/include/linux/acpi_iort.h
+++ b/include/linux/acpi_iort.h
@@ -38,6 +38,8 @@ int iort_dma_get_ranges(struct device *dev, u64 *size);
 int iort_iommu_configure_id(struct device *dev, const u32 *id_in);
 int iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head);
 phys_addr_t acpi_iort_dma_get_max_cpu_address(void);
+int iort_iommu_get_rmrs(struct fwnode_handle *iommu_fwnode,
+			struct list_head *list);
 #else
 static inline void acpi_iort_init(void) { }
 static inline u32 iort_msi_map_id(struct device *dev, u32 id)
@@ -57,6 +59,11 @@ int iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head)
 
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
