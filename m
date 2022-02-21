Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 347A6C433FE
	for <iommu@archiver.kernel.org>; Mon, 21 Feb 2022 15:45:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D7B6160E0F;
	Mon, 21 Feb 2022 15:45:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6_q8QRLTFXbN; Mon, 21 Feb 2022 15:45:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id BD313605EA;
	Mon, 21 Feb 2022 15:45:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 975C7C001A;
	Mon, 21 Feb 2022 15:45:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5813BC0011
 for <iommu@lists.linux-foundation.org>; Mon, 21 Feb 2022 15:45:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3917681394
 for <iommu@lists.linux-foundation.org>; Mon, 21 Feb 2022 15:45:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id c75TyUUc1rzY for <iommu@lists.linux-foundation.org>;
 Mon, 21 Feb 2022 15:45:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 61FFA80C33
 for <iommu@lists.linux-foundation.org>; Mon, 21 Feb 2022 15:45:11 +0000 (UTC)
Received: from fraeml711-chm.china.huawei.com (unknown [172.18.147.226])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4K2RMb1rg1z6GCsV;
 Mon, 21 Feb 2022 23:40:27 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml711-chm.china.huawei.com (10.206.15.60) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 21 Feb 2022 16:45:09 +0100
Received: from A2006125610.china.huawei.com (10.47.91.169) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 21 Feb 2022 15:45:01 +0000
To: <linux-arm-kernel@lists.infradead.org>, <linux-acpi@vger.kernel.org>,
 <iommu@lists.linux-foundation.org>
Subject: [PATCH v8 04/11] iommu/dma: Introduce generic helper to retrieve RMR
 info
Date: Mon, 21 Feb 2022 15:43:37 +0000
Message-ID: <20220221154344.2126-5-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20220221154344.2126-1-shameerali.kolothum.thodi@huawei.com>
References: <20220221154344.2126-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.47.91.169]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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
From: Shameer Kolothum via iommu <iommu@lists.linux-foundation.org>
Reply-To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Reserved Memory Regions(RMR) associated with an IOMMU can be
described through ACPI IORT tables in systems with devices
that require a unity mapping or bypass for those
regions.

Introduce a generic interface so that IOMMU drivers can retrieve
and set up necessary mappings.

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 drivers/iommu/dma-iommu.c | 21 +++++++++++++++++++++
 include/linux/dma-iommu.h | 14 ++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index d85d54f2b549..65ab01d5128b 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -370,6 +370,27 @@ void iommu_put_dma_cookie(struct iommu_domain *domain)
 	domain->iova_cookie = NULL;
 }
 
+/**
+ *
+ * iommu_dma_get_rmrs - Retrieve Reserved Memory Regions(RMRs) associated
+ *                      with a given IOMMU and device(optional)
+ * @iommu_fwnode: fwnode associated with IOMMU
+ * @dev: Optional associated device
+ * @list: Reserved region list to be populated
+ *
+ */
+void iommu_dma_get_rmrs(struct fwnode_handle *iommu_fwnode, struct device *dev,
+			struct list_head *list)
+{
+}
+EXPORT_SYMBOL(iommu_dma_get_rmrs);
+
+void iommu_dma_put_rmrs(struct fwnode_handle *iommu_fwnode,
+			struct list_head *list)
+{
+}
+EXPORT_SYMBOL(iommu_dma_put_rmrs);
+
 /**
  * iommu_dma_get_resv_regions - Reserved region driver helper
  * @dev: Device from iommu_get_resv_regions()
diff --git a/include/linux/dma-iommu.h b/include/linux/dma-iommu.h
index 24607dc3c2ac..897b457cad2c 100644
--- a/include/linux/dma-iommu.h
+++ b/include/linux/dma-iommu.h
@@ -43,12 +43,17 @@ void iommu_dma_free_cpu_cached_iovas(unsigned int cpu,
 
 extern bool iommu_dma_forcedac;
 
+void iommu_dma_get_rmrs(struct fwnode_handle *iommu, struct device *dev,
+			struct list_head *list);
+
+void iommu_dma_put_rmrs(struct fwnode_handle *iommu, struct list_head *list);
 #else /* CONFIG_IOMMU_DMA */
 
 struct iommu_domain;
 struct msi_desc;
 struct msi_msg;
 struct device;
+struct fwnode_handle;
 
 static inline void iommu_setup_dma_ops(struct device *dev, u64 dma_base,
 				       u64 dma_limit)
@@ -89,5 +94,14 @@ static inline void iommu_dma_get_resv_regions(struct device *dev, struct list_he
 {
 }
 
+static inline void iommu_dma_get_rmrs(struct fwnode_handle *iommu, struct device *dev,
+				      struct list_head *list)
+{
+}
+
+static inline void iommu_dma_put_rmrs(struct fwnode_handle *iommu, struct list_head *list)
+{
+}
+
 #endif	/* CONFIG_IOMMU_DMA */
 #endif	/* __DMA_IOMMU_H */
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
