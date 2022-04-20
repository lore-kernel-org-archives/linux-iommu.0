Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF103C433F5
	for <iommu@archiver.kernel.org>; Wed, 20 Apr 2022 16:50:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 84BF3417B0;
	Wed, 20 Apr 2022 16:50:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BJ34cp__Nvu5; Wed, 20 Apr 2022 16:50:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1707B41766;
	Wed, 20 Apr 2022 16:50:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E14B9C0033;
	Wed, 20 Apr 2022 16:50:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AF2A8C002C
 for <iommu@lists.linux-foundation.org>; Wed, 20 Apr 2022 16:50:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8EDAD41794
 for <iommu@lists.linux-foundation.org>; Wed, 20 Apr 2022 16:50:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5UsSOoZhUuWg for <iommu@lists.linux-foundation.org>;
 Wed, 20 Apr 2022 16:50:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 72FAD41766
 for <iommu@lists.linux-foundation.org>; Wed, 20 Apr 2022 16:50:12 +0000 (UTC)
Received: from fraeml706-chm.china.huawei.com (unknown [172.18.147.200])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Kk66W2nhfz67tcX;
 Thu, 21 Apr 2022 00:47:47 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml706-chm.china.huawei.com (10.206.15.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Wed, 20 Apr 2022 18:50:10 +0200
Received: from A2006125610.china.huawei.com (10.47.81.194) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 20 Apr 2022 17:50:01 +0100
To: <linux-arm-kernel@lists.infradead.org>, <linux-acpi@vger.kernel.org>,
 <iommu@lists.linux-foundation.org>
Subject: [PATCH v10 5/9] ACPI/IORT: Add a helper to retrieve RMR info directly
Date: Wed, 20 Apr 2022 17:48:32 +0100
Message-ID: <20220420164836.1181-6-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20220420164836.1181-1-shameerali.kolothum.thodi@huawei.com>
References: <20220420164836.1181-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.47.81.194]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Cc: robin.murphy@arm.com, jon@solid-run.com, linuxarm@huawei.com,
 steven.price@arm.com, hch@infradead.org, guohanjun@huawei.com,
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
From: Shameer Kolothum via iommu <iommu@lists.linux-foundation.org>
Reply-To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

This will provide a way for SMMU drivers to retrieve StreamIDs
associated with IORT RMR nodes and use that to set bypass settings
for those IDs.

Reviewed-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Tested-by: Steven Price <steven.price@arm.com>
Tested-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 drivers/acpi/arm64/iort.c | 30 ++++++++++++++++++++++++++++++
 include/linux/acpi_iort.h |  8 ++++++++
 2 files changed, 38 insertions(+)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 8b189e9eca95..971904b2205f 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -1367,6 +1367,36 @@ int iort_dma_get_ranges(struct device *dev, u64 *size)
 		return nc_dma_get_range(dev, size);
 }
 
+/**
+ * iort_get_rmr_sids - Retrieve IORT RMR node reserved regions with
+ *                     associated StreamIDs information.
+ * @iommu_fwnode: fwnode associated with IOMMU
+ * @head: Resereved region list
+ */
+void iort_get_rmr_sids(struct fwnode_handle *iommu_fwnode,
+		       struct list_head *head)
+{
+	iort_iommu_rmr_get_resv_regions(iommu_fwnode, NULL, head);
+}
+EXPORT_SYMBOL_GPL(iort_get_rmr_sids);
+
+/**
+ * iort_put_rmr_sids - Free all the memory allocated for RMR reserved regions.
+ * @iommu_fwnode: fwnode associated with IOMMU
+ * @head: Resereved region list
+ */
+void iort_put_rmr_sids(struct fwnode_handle *iommu_fwnode,
+		       struct list_head *head)
+{
+	struct iommu_resv_region *entry, *next;
+
+	list_for_each_entry_safe(entry, next, head, list) {
+		kfree(entry->fw_data.rmr.sids);
+		kfree(entry);
+	}
+}
+EXPORT_SYMBOL_GPL(iort_put_rmr_sids);
+
 static void __init acpi_iort_register_irq(int hwirq, const char *name,
 					  int trigger,
 					  struct resource *res)
diff --git a/include/linux/acpi_iort.h b/include/linux/acpi_iort.h
index e5d2de9caf7f..b43be0987b19 100644
--- a/include/linux/acpi_iort.h
+++ b/include/linux/acpi_iort.h
@@ -33,6 +33,10 @@ struct irq_domain *iort_get_device_domain(struct device *dev, u32 id,
 					  enum irq_domain_bus_token bus_token);
 void acpi_configure_pmsi_domain(struct device *dev);
 int iort_pmsi_get_dev_id(struct device *dev, u32 *dev_id);
+void iort_get_rmr_sids(struct fwnode_handle *iommu_fwnode,
+		       struct list_head *head);
+void iort_put_rmr_sids(struct fwnode_handle *iommu_fwnode,
+		       struct list_head *head);
 /* IOMMU interface */
 int iort_dma_get_ranges(struct device *dev, u64 *size);
 int iort_iommu_configure_id(struct device *dev, const u32 *id_in);
@@ -46,6 +50,10 @@ static inline struct irq_domain *iort_get_device_domain(
 	struct device *dev, u32 id, enum irq_domain_bus_token bus_token)
 { return NULL; }
 static inline void acpi_configure_pmsi_domain(struct device *dev) { }
+static inline
+void iort_get_rmr_sids(struct fwnode_handle *iommu_fwnode, struct list_head *head) { }
+static inline
+void iort_put_rmr_sids(struct fwnode_handle *iommu_fwnode, struct list_head *head) { }
 /* IOMMU interface */
 static inline int iort_dma_get_ranges(struct device *dev, u64 *size)
 { return -ENODEV; }
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
