Return-Path: <SRS0=gpU2=JR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D79FEC433B4
	for <iommu@archiver.kernel.org>; Tue, 20 Apr 2021 09:28:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D60861090
	for <iommu@archiver.kernel.org>; Tue, 20 Apr 2021 09:28:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D60861090
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0A53A83A6A;
	Tue, 20 Apr 2021 09:28:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 55T80-5h9-Oh; Tue, 20 Apr 2021 09:28:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id E611A83A77;
	Tue, 20 Apr 2021 09:28:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C2F3EC000E;
	Tue, 20 Apr 2021 09:28:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DEB92C000B
 for <iommu@lists.linux-foundation.org>; Tue, 20 Apr 2021 09:28:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CC98440204
 for <iommu@lists.linux-foundation.org>; Tue, 20 Apr 2021 09:28:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UQUlZfTlhq2z for <iommu@lists.linux-foundation.org>;
 Tue, 20 Apr 2021 09:28:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B48504022C
 for <iommu@lists.linux-foundation.org>; Tue, 20 Apr 2021 09:28:23 +0000 (UTC)
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
 by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FPdbC1Qwdz7wMj;
 Tue, 20 Apr 2021 17:25:59 +0800 (CST)
Received: from A2006125610.china.huawei.com (10.47.83.26) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.498.0; Tue, 20 Apr 2021 17:28:14 +0800
From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To: <linux-arm-kernel@lists.infradead.org>, <linux-acpi@vger.kernel.org>,
 <iommu@lists.linux-foundation.org>
Subject: [PATCH v3 02/10] iommu/dma: Introduce generic helper to retrieve RMR
 info
Date: Tue, 20 Apr 2021 10:27:43 +0200
Message-ID: <20210420082751.1829-3-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20210420082751.1829-1-shameerali.kolothum.thodi@huawei.com>
References: <20210420082751.1829-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.47.83.26]
X-CFilter-Loop: Reflected
Cc: jon@solid-run.com, linuxarm@huawei.com, steven.price@arm.com,
 guohanjun@huawei.com, Sami.Mujawar@arm.com, robin.murphy@arm.com,
 wanghuiqiang@huawei.com
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

Reserved Memory Regions(RMR) associated with an IOMMU may be
described either through ACPI tables or DT in systems with
devices that require a unity mapping or bypass for those
regions in IOMMU drivers.

Introduce a generic interface so that IOMMU drivers can retrieve
and set up necessary mappings.

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 drivers/iommu/dma-iommu.c | 33 +++++++++++++++++++++++++++++++++
 include/linux/dma-iommu.h |  8 ++++++++
 include/linux/iommu.h     | 19 +++++++++++++++++++
 3 files changed, 60 insertions(+)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index af765c813cc8..86a1e48b1fe8 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -191,6 +191,39 @@ void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list)
 }
 EXPORT_SYMBOL(iommu_dma_get_resv_regions);
 
+/**
+ * iommu_dma_get_rmrs - Retrieve Reserved Memory Regions(RMRs) associated
+ *                      with a given IOMMU
+ * @iommu_fwnode: fwnode associated with IOMMU
+ * @list: RMR list to be populated
+ *
+ */
+int iommu_dma_get_rmrs(struct fwnode_handle *iommu_fwnode,
+		       struct list_head *list)
+{
+	return 0;
+}
+EXPORT_SYMBOL(iommu_dma_get_rmrs);
+
+struct iommu_rmr *iommu_dma_alloc_rmr(u64 base, u64 length, u32 sid,
+				      u32 flags)
+{
+	struct iommu_rmr *rmr;
+
+	rmr = kzalloc(sizeof(*rmr), GFP_KERNEL);
+	if (!rmr)
+		return NULL;
+
+	INIT_LIST_HEAD(&rmr->list);
+	rmr->base_address = base;
+	rmr->length = length;
+	rmr->sid = sid;
+	rmr->flags = flags;
+
+	return rmr;
+}
+EXPORT_SYMBOL(iommu_dma_alloc_rmr);
+
 static int cookie_init_hw_msi_region(struct iommu_dma_cookie *cookie,
 		phys_addr_t start, phys_addr_t end)
 {
diff --git a/include/linux/dma-iommu.h b/include/linux/dma-iommu.h
index 706b68d1359b..beb84c4fe5b1 100644
--- a/include/linux/dma-iommu.h
+++ b/include/linux/dma-iommu.h
@@ -40,6 +40,9 @@ void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list);
 void iommu_dma_free_cpu_cached_iovas(unsigned int cpu,
 		struct iommu_domain *domain);
 
+int iommu_dma_get_rmrs(struct fwnode_handle *iommu, struct list_head *list);
+struct iommu_rmr *iommu_dma_alloc_rmr(u64 base, u64 length, u32 sid, u32 flags);
+
 #else /* CONFIG_IOMMU_DMA */
 
 struct iommu_domain;
@@ -86,5 +89,10 @@ static inline void iommu_dma_free_cpu_cached_iovas(unsigned int cpu,
 {
 }
 
+int iommu_dma_get_rmrs(struct fwnode_handle *iommu, struct list_head *list);
+{
+	return 0;
+}
+
 #endif	/* CONFIG_IOMMU_DMA */
 #endif	/* __DMA_IOMMU_H */
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 5e7fe519430a..fb8820c40144 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -595,6 +595,25 @@ struct iommu_sva {
 	struct device			*dev;
 };
 
+/**
+ * struct iommu_rmr - Reserved Memory Region details per IOMMU
+ * @list: Linked list pointers to hold RMR region info
+ * @base_address: base address of Reserved Memory Region
+ * @length: length of memory region
+ * @sid: associated stream id
+ * @flags: flags that apply to the RMR node
+ */
+struct iommu_rmr {
+	struct list_head	list;
+	phys_addr_t		base_address;
+	u64			length;
+	u32			sid;
+	u32			flags;
+};
+
+/* RMR Remap permitted */
+#define IOMMU_RMR_REMAP_PERMITTED	(1 << 0)
+
 int iommu_fwspec_init(struct device *dev, struct fwnode_handle *iommu_fwnode,
 		      const struct iommu_ops *ops);
 void iommu_fwspec_free(struct device *dev);
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
