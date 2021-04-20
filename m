Return-Path: <SRS0=gpU2=JR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C8A4C43460
	for <iommu@archiver.kernel.org>; Tue, 20 Apr 2021 09:28:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F26B061073
	for <iommu@archiver.kernel.org>; Tue, 20 Apr 2021 09:28:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F26B061073
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AD71240515;
	Tue, 20 Apr 2021 09:28:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yWkEChhVsrgb; Tue, 20 Apr 2021 09:28:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 62F1940457;
	Tue, 20 Apr 2021 09:28:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 37956C001E;
	Tue, 20 Apr 2021 09:28:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BC378C000B
 for <iommu@lists.linux-foundation.org>; Tue, 20 Apr 2021 09:28:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AB05483A6A
 for <iommu@lists.linux-foundation.org>; Tue, 20 Apr 2021 09:28:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id I-MjqdblZQ76 for <iommu@lists.linux-foundation.org>;
 Tue, 20 Apr 2021 09:28:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 592DC83A80
 for <iommu@lists.linux-foundation.org>; Tue, 20 Apr 2021 09:28:38 +0000 (UTC)
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
 by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FPdbV3Xh4z7vrv;
 Tue, 20 Apr 2021 17:26:14 +0800 (CST)
Received: from A2006125610.china.huawei.com (10.47.83.26) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.498.0; Tue, 20 Apr 2021 17:28:26 +0800
From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To: <linux-arm-kernel@lists.infradead.org>, <linux-acpi@vger.kernel.org>,
 <iommu@lists.linux-foundation.org>
Subject: [PATCH v3 04/10] iommu/dma: Add a helper function to reserve RMRs for
 IOMMU drivers
Date: Tue, 20 Apr 2021 10:27:45 +0200
Message-ID: <20210420082751.1829-5-shameerali.kolothum.thodi@huawei.com>
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

IOMMU drivers can use this to implement their .get_resv_regions callback
for any RMR address regions specific to a device.

As per ACPI IORT E.b spec, a check is added to make sure OS has preserved
the PCIe configuration done by boot firmware.

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 drivers/iommu/dma-iommu.c | 35 +++++++++++++++++++++++++++++++++++
 include/linux/dma-iommu.h |  7 +++++++
 2 files changed, 42 insertions(+)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index a942cc04eee1..c624000bf230 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -191,6 +191,41 @@ void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list)
 }
 EXPORT_SYMBOL(iommu_dma_get_resv_regions);
 
+void iommu_dma_get_rmr_resv_regions(struct device *dev, struct iommu_rmr *rmr,
+				    struct list_head *list)
+{
+	int prot = IOMMU_READ | IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO;
+	struct iommu_resv_region *region;
+	enum iommu_resv_type type;
+
+	/*
+	 * For ACPI, please make sure the OS has preserved the PCIe configuration
+	 * performed by the boot firmware(See IORT revision E.b).
+	 */
+	if (!is_of_node(dev_iommu_fwspec_get(dev)->iommu_fwnode) &&
+	    dev_is_pci(dev)) {
+		struct pci_dev *pdev = to_pci_dev(dev);
+		struct pci_host_bridge *host = pci_find_host_bridge(pdev->bus);
+
+		if (!host->preserve_config)
+			return;
+	}
+
+	if (rmr->flags & IOMMU_RMR_REMAP_PERMITTED)
+		type = IOMMU_RESV_DIRECT_RELAXABLE;
+	else
+		type = IOMMU_RESV_DIRECT;
+
+	region = iommu_alloc_resv_region(rmr->base_address,
+					 rmr->length, prot,
+					 type);
+	if (!region)
+		return;
+
+	list_add_tail(&region->list, list);
+}
+EXPORT_SYMBOL(iommu_dma_get_rmr_resv_regions);
+
 /**
  * iommu_dma_get_rmrs - Retrieve Reserved Memory Regions(RMRs) associated
  *                      with a given IOMMU
diff --git a/include/linux/dma-iommu.h b/include/linux/dma-iommu.h
index beb84c4fe5b1..dbad5073c9e0 100644
--- a/include/linux/dma-iommu.h
+++ b/include/linux/dma-iommu.h
@@ -40,6 +40,8 @@ void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list);
 void iommu_dma_free_cpu_cached_iovas(unsigned int cpu,
 		struct iommu_domain *domain);
 
+void iommu_dma_get_rmr_resv_regions(struct device *dev, struct iommu_rmr *rmr,
+				    struct list_head *list);
 int iommu_dma_get_rmrs(struct fwnode_handle *iommu, struct list_head *list);
 struct iommu_rmr *iommu_dma_alloc_rmr(u64 base, u64 length, u32 sid, u32 flags);
 
@@ -89,6 +91,11 @@ static inline void iommu_dma_free_cpu_cached_iovas(unsigned int cpu,
 {
 }
 
+static void iommu_dma_get_rmr_resv_regions(struct device *dev, struct iommu_rmr *rmr,
+					   struct list_head *list)
+{
+}
+
 int iommu_dma_get_rmrs(struct fwnode_handle *iommu, struct list_head *list);
 {
 	return 0;
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
