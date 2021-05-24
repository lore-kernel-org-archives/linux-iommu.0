Return-Path: <SRS0=7UOM=KT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFD4EC04FF3
	for <iommu@archiver.kernel.org>; Mon, 24 May 2021 11:04:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C0646113B
	for <iommu@archiver.kernel.org>; Mon, 24 May 2021 11:04:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C0646113B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6D8DD6070A;
	Mon, 24 May 2021 11:04:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pnz16EQG7qsl; Mon, 24 May 2021 11:04:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id A2B5B60626;
	Mon, 24 May 2021 11:04:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 84481C000E;
	Mon, 24 May 2021 11:04:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CEF63C0001
 for <iommu@lists.linux-foundation.org>; Mon, 24 May 2021 11:04:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BE5F44027B
 for <iommu@lists.linux-foundation.org>; Mon, 24 May 2021 11:04:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id q_x2K8WWVN_n for <iommu@lists.linux-foundation.org>;
 Mon, 24 May 2021 11:04:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B265040249
 for <iommu@lists.linux-foundation.org>; Mon, 24 May 2021 11:04:30 +0000 (UTC)
Received: from dggems706-chm.china.huawei.com (unknown [172.30.72.60])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FpZ514N5BzNyyy;
 Mon, 24 May 2021 19:00:53 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 dggems706-chm.china.huawei.com (10.3.19.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 24 May 2021 19:04:28 +0800
Received: from A2006125610.china.huawei.com (10.47.80.77) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 24 May 2021 12:04:18 +0100
From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To: <linux-arm-kernel@lists.infradead.org>, <linux-acpi@vger.kernel.org>,
 <iommu@lists.linux-foundation.org>
Subject: [PATCH v5 8/8] iommu/dma: Reserve any RMR regions associated with a
 dev
Date: Mon, 24 May 2021 12:02:22 +0100
Message-ID: <20210524110222.2212-9-shameerali.kolothum.thodi@huawei.com>
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

Get ACPI IORT RMR regions associated with a dev reserved
so that there is a unity mapping for them in SMMU.

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 drivers/iommu/dma-iommu.c | 56 +++++++++++++++++++++++++++++++++++----
 1 file changed, 51 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index f893d460cfa4..c68093f48816 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -207,22 +207,68 @@ void iommu_dma_put_rmrs(struct fwnode_handle *iommu_fwnode,
 }
 EXPORT_SYMBOL(iommu_dma_put_rmrs);
 
+static bool iommu_dma_dev_has_rmr(struct iommu_fwspec *fwspec,
+				  struct iommu_resv_region *e)
+{
+	int i;
+
+	for (i = 0; i < fwspec->num_ids; i++) {
+		if (e->fw_data.rmr.sid == fwspec->ids[i])
+			return true;
+	}
+
+	return false;
+}
+
+static void iommu_dma_get_rmr_resv_regions(struct device *dev,
+					   struct list_head *list)
+{
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+	struct list_head rmr_list;
+	struct iommu_resv_region *rmr, *tmp;
+
+	INIT_LIST_HEAD(&rmr_list);
+	if (iommu_dma_get_rmrs(fwspec->iommu_fwnode, &rmr_list))
+		return;
+
+	if (dev_is_pci(dev)) {
+		struct pci_dev *pdev = to_pci_dev(dev);
+		struct pci_host_bridge *host = pci_find_host_bridge(pdev->bus);
+
+		if (!host->preserve_config)
+			return;
+	}
+
+	list_for_each_entry_safe(rmr, tmp, &rmr_list, list) {
+		if (!iommu_dma_dev_has_rmr(fwspec, rmr))
+			continue;
+
+		/* Remove from iommu RMR list and add to dev resv_regions */
+		list_del_init(&rmr->list);
+		list_add_tail(&rmr->list, list);
+	}
+
+	iommu_dma_put_rmrs(fwspec->iommu_fwnode, &rmr_list);
+}
+
 /**
  * iommu_dma_get_resv_regions - Reserved region driver helper
  * @dev: Device from iommu_get_resv_regions()
  * @list: Reserved region list from iommu_get_resv_regions()
  *
  * IOMMU drivers can use this to implement their .get_resv_regions callback
- * for general non-IOMMU-specific reservations. Currently, this covers GICv3
- * ITS region reservation on ACPI based ARM platforms that may require HW MSI
- * reservation.
+ * for general non-IOMMU-specific reservations. Currently this covers,
+ *  -GICv3 ITS region reservation on ACPI based ARM platforms that may
+ *   require HW MSI reservation.
+ *  -Any ACPI IORT RMR memory range reservations (IORT spec rev E.b)
  */
 void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list)
 {
 
-	if (!is_of_node(dev_iommu_fwspec_get(dev)->iommu_fwnode))
+	if (!is_of_node(dev_iommu_fwspec_get(dev)->iommu_fwnode)) {
 		iort_iommu_msi_get_resv_regions(dev, list);
-
+		iommu_dma_get_rmr_resv_regions(dev, list);
+	}
 }
 EXPORT_SYMBOL(iommu_dma_get_resv_regions);
 
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
