Return-Path: <SRS0=XGcg=MI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D606CC12002
	for <iommu@archiver.kernel.org>; Fri, 16 Jul 2021 08:35:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C5C3613ED
	for <iommu@archiver.kernel.org>; Fri, 16 Jul 2021 08:35:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C5C3613ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3E20960D5E;
	Fri, 16 Jul 2021 08:35:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hiECPtw2JXJi; Fri, 16 Jul 2021 08:35:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 1CB536077B;
	Fri, 16 Jul 2021 08:35:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 07A74C0010;
	Fri, 16 Jul 2021 08:35:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3329BC000E
 for <iommu@lists.linux-foundation.org>; Fri, 16 Jul 2021 08:35:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 21BE060C03
 for <iommu@lists.linux-foundation.org>; Fri, 16 Jul 2021 08:35:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AWc1wj_zwqvH for <iommu@lists.linux-foundation.org>;
 Fri, 16 Jul 2021 08:35:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 30B576077B
 for <iommu@lists.linux-foundation.org>; Fri, 16 Jul 2021 08:35:12 +0000 (UTC)
Received: from fraeml710-chm.china.huawei.com (unknown [172.18.147.201])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GR48T6Jdbz6FDGr;
 Fri, 16 Jul 2021 16:26:33 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml710-chm.china.huawei.com (10.206.15.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 16 Jul 2021 10:35:09 +0200
Received: from A2006125610.china.huawei.com (10.47.80.222) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 16 Jul 2021 09:35:02 +0100
From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To: <linux-arm-kernel@lists.infradead.org>, <linux-acpi@vger.kernel.org>,
 <iommu@lists.linux-foundation.org>
Subject: [PATCH v6 2/9] ACPI/IORT: Add support for RMR node parsing
Date: Fri, 16 Jul 2021 09:34:35 +0100
Message-ID: <20210716083442.1708-3-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20210716083442.1708-1-shameerali.kolothum.thodi@huawei.com>
References: <20210716083442.1708-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.47.80.222]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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

Add support for parsing RMR node information from ACPI.

Find the associated streamid and smmu node info from the
RMR node and populate a linked list with RMR memory
descriptors.

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 drivers/acpi/arm64/iort.c | 134 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 133 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 3b23fb775ac4..d76ba46ebe67 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -40,6 +40,8 @@ struct iort_fwnode {
 static LIST_HEAD(iort_fwnode_list);
 static DEFINE_SPINLOCK(iort_fwnode_lock);
 
+static LIST_HEAD(iort_rmr_list);	/* list of RMR regions from ACPI */
+
 /**
  * iort_set_fwnode() - Create iort_fwnode and use it to register
  *		       iommu data in the iort_fwnode_list
@@ -393,7 +395,8 @@ static struct acpi_iort_node *iort_node_get_id(struct acpi_iort_node *node,
 		if (node->type == ACPI_IORT_NODE_NAMED_COMPONENT ||
 		    node->type == ACPI_IORT_NODE_PCI_ROOT_COMPLEX ||
 		    node->type == ACPI_IORT_NODE_SMMU_V3 ||
-		    node->type == ACPI_IORT_NODE_PMCG) {
+		    node->type == ACPI_IORT_NODE_PMCG ||
+		    node->type == ACPI_IORT_NODE_RMR) {
 			*id_out = map->output_base;
 			return parent;
 		}
@@ -1566,6 +1569,134 @@ static void __init iort_enable_acs(struct acpi_iort_node *iort_node)
 #else
 static inline void iort_enable_acs(struct acpi_iort_node *iort_node) { }
 #endif
+static void iort_rmr_desc_check_overlap(struct acpi_iort_rmr_desc *desc, u32 count)
+{
+	int i, j;
+
+	for (i = 0; i < count; i++) {
+		u64 end, start = desc[i].base_address, length = desc[i].length;
+
+		end = start + length - 1;
+
+		/* Check for address overlap */
+		for (j = i + 1; j < count; j++) {
+			u64 e_start = desc[j].base_address;
+			u64 e_end = e_start + desc[j].length - 1;
+
+			if (start <= e_end && end >= e_start)
+				pr_err(FW_BUG "RMR descriptor[0x%llx - 0x%llx] overlaps, continue anyway\n",
+				       start, end);
+		}
+	}
+}
+
+static void __init iort_node_get_rmr_info(struct acpi_iort_node *iort_node)
+{
+	struct acpi_iort_node *smmu;
+	struct acpi_iort_rmr *rmr;
+	struct acpi_iort_rmr_desc *rmr_desc;
+	u32 map_count = iort_node->mapping_count;
+	u32 sid;
+	int i;
+
+	if (!iort_node->mapping_offset || map_count != 1) {
+		pr_err(FW_BUG "Invalid ID mapping, skipping RMR node %p\n",
+		       iort_node);
+		return;
+	}
+
+	/* Retrieve associated smmu and stream id */
+	smmu = iort_node_get_id(iort_node, &sid, 0);
+	if (!smmu) {
+		pr_err(FW_BUG "Invalid SMMU reference, skipping RMR node %p\n",
+		       iort_node);
+		return;
+	}
+
+	/* Retrieve RMR data */
+	rmr = (struct acpi_iort_rmr *)iort_node->node_data;
+	if (!rmr->rmr_offset || !rmr->rmr_count) {
+		pr_err(FW_BUG "Invalid RMR descriptor array, skipping RMR node %p\n",
+		       iort_node);
+		return;
+	}
+
+	rmr_desc = ACPI_ADD_PTR(struct acpi_iort_rmr_desc, iort_node,
+				rmr->rmr_offset);
+
+	iort_rmr_desc_check_overlap(rmr_desc, rmr->rmr_count);
+
+	for (i = 0; i < rmr->rmr_count; i++, rmr_desc++) {
+		struct iommu_resv_region *region;
+		enum iommu_resv_type type;
+		int prot = IOMMU_READ | IOMMU_WRITE;
+		u64 addr = rmr_desc->base_address, size = rmr_desc->length;
+
+		if (!IS_ALIGNED(addr, SZ_64K) || !IS_ALIGNED(size, SZ_64K)) {
+			/* PAGE align base addr and size */
+			addr &= PAGE_MASK;
+			size = PAGE_ALIGN(size + offset_in_page(rmr_desc->base_address));
+
+			pr_err(FW_BUG "RMR descriptor[0x%llx - 0x%llx] not aligned to 64K, continue with [0x%llx - 0x%llx]\n",
+			       rmr_desc->base_address,
+			       rmr_desc->base_address + rmr_desc->length - 1,
+			       addr, addr + size - 1);
+		}
+		if (rmr->flags & IOMMU_RMR_REMAP_PERMITTED) {
+			type = IOMMU_RESV_DIRECT_RELAXABLE;
+			/*
+			 * Set IOMMU_CACHE as IOMMU_RESV_DIRECT_RELAXABLE is
+			 * normally used for allocated system memory that is
+			 * then used for device specific reserved regions.
+			 */
+			prot |= IOMMU_CACHE;
+		} else {
+			type = IOMMU_RESV_DIRECT;
+			/*
+			 * Set IOMMU_MMIO as IOMMU_RESV_DIRECT is normally used
+			 * for device memory like MSI doorbell.
+			 */
+			prot |= IOMMU_MMIO;
+		}
+
+		region = iommu_alloc_resv_region(addr, size, prot, type);
+		if (region) {
+			region->fw_data.rmr.flags = rmr->flags;
+			region->fw_data.rmr.sid = sid;
+			region->fw_data.rmr.smmu = smmu;
+			list_add_tail(&region->list, &iort_rmr_list);
+		}
+	}
+}
+
+static void __init iort_parse_rmr(void)
+{
+	struct acpi_iort_node *iort_node, *iort_end;
+	struct acpi_table_iort *iort;
+	int i;
+
+	if (iort_table->revision < 3)
+		return;
+
+	iort = (struct acpi_table_iort *)iort_table;
+
+	iort_node = ACPI_ADD_PTR(struct acpi_iort_node, iort,
+				 iort->node_offset);
+	iort_end = ACPI_ADD_PTR(struct acpi_iort_node, iort,
+				iort_table->length);
+
+	for (i = 0; i < iort->node_count; i++) {
+		if (WARN_TAINT(iort_node >= iort_end, TAINT_FIRMWARE_WORKAROUND,
+			       "IORT node pointer overflows, bad table!\n"))
+			return;
+
+		if (iort_node->type == ACPI_IORT_NODE_RMR)
+			iort_node_get_rmr_info(iort_node);
+
+		iort_node = ACPI_ADD_PTR(struct acpi_iort_node, iort_node,
+					 iort_node->length);
+	}
+}
 
 static void __init iort_init_platform_devices(void)
 {
@@ -1636,6 +1767,7 @@ void __init acpi_iort_init(void)
 	}
 
 	iort_init_platform_devices();
+	iort_parse_rmr();
 }
 
 #ifdef CONFIG_ZONE_DMA
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
