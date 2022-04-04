Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84422C433EF
	for <iommu@archiver.kernel.org>; Mon,  4 Apr 2022 12:44:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3F02F40234;
	Mon,  4 Apr 2022 12:44:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gsLo5MaSo6Nz; Mon,  4 Apr 2022 12:44:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 6868D401DD;
	Mon,  4 Apr 2022 12:44:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3C507C001D;
	Mon,  4 Apr 2022 12:44:00 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A62A9C0012
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 12:43:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9400160C05
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 12:43:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LlGDj-Fuxb3y for <iommu@lists.linux-foundation.org>;
 Mon,  4 Apr 2022 12:43:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 695C160B73
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 12:43:58 +0000 (UTC)
Received: from fraeml734-chm.china.huawei.com (unknown [172.18.147.206])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KX9QZ6ZTbz685ZZ;
 Mon,  4 Apr 2022 20:42:14 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml734-chm.china.huawei.com (10.206.15.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 4 Apr 2022 14:43:56 +0200
Received: from A2006125610.china.huawei.com (10.47.93.34) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 4 Apr 2022 13:43:48 +0100
To: <linux-arm-kernel@lists.infradead.org>, <linux-acpi@vger.kernel.org>,
 <iommu@lists.linux-foundation.org>
Subject: [PATCH v9 06/11] ACPI/IORT: Add support to retrieve IORT RMR reserved
 regions
Date: Mon, 4 Apr 2022 13:42:04 +0100
Message-ID: <20220404124209.1086-7-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20220404124209.1086-1-shameerali.kolothum.thodi@huawei.com>
References: <20220404124209.1086-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.47.93.34]
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
From: Shameer Kolothum via iommu <iommu@lists.linux-foundation.org>
Reply-To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Parse through the IORT RMR nodes and populate the reserve region list
corresponding to a given IOMMU and device(optional). Also, go through
the ID mappings of the RMR node and retrieve all the SIDs associated
with it.

Now that we have this support, update iommu_dma_get/_put_resv_regions()
paths to include the RMR reserve regions.

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 drivers/acpi/arm64/iort.c | 275 ++++++++++++++++++++++++++++++++++++++
 drivers/iommu/dma-iommu.c |   3 +
 include/linux/acpi_iort.h |   4 +
 3 files changed, 282 insertions(+)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 63acc3c5b275..1147387cfddb 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -812,6 +812,259 @@ void acpi_configure_pmsi_domain(struct device *dev)
 }
 
 #ifdef CONFIG_IOMMU_API
+static void iort_rmr_desc_check_overlap(struct acpi_iort_rmr_desc *desc, u32 count)
+{
+	int i, j;
+
+	for (i = 0; i < count; i++) {
+		u64 end, start = desc[i].base_address, length = desc[i].length;
+
+		if (!length) {
+			pr_err(FW_BUG "RMR descriptor[0x%llx] with zero length, continue anyway\n",
+			       start);
+			continue;
+		}
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
+/*
+ * Please note, we will keep the already allocated RMR reserve
+ * regions in case of a memory allocation failure.
+ */
+static void iort_get_rmrs(struct acpi_iort_node *node,
+			  struct acpi_iort_node *smmu,
+			  u32 *sids, u32 num_sids,
+			  struct list_head *head)
+{
+	struct acpi_iort_rmr *rmr = (struct acpi_iort_rmr *)node->node_data;
+	struct acpi_iort_rmr_desc *rmr_desc;
+	int i;
+
+	rmr_desc = ACPI_ADD_PTR(struct acpi_iort_rmr_desc, node,
+				rmr->rmr_offset);
+
+	iort_rmr_desc_check_overlap(rmr_desc, rmr->rmr_count);
+
+	for (i = 0; i < rmr->rmr_count; i++, rmr_desc++) {
+		struct iommu_resv_region *region;
+		enum iommu_resv_type type;
+		u32  *sids_copy;
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
+
+		if (rmr->flags & ACPI_IORT_RMR_REMAP_PERMITTED)
+			type = IOMMU_RESV_DIRECT_RELAXABLE;
+		else
+			type = IOMMU_RESV_DIRECT;
+
+		if (rmr->flags & ACPI_IORT_RMR_ACCESS_PRIVILEGE)
+			prot |= IOMMU_PRIV;
+
+		/* Attributes 0x00 - 0x03 represents device memory */
+		if (ACPI_IORT_RMR_ACCESS_ATTRIBUTES(rmr->flags) <=
+				ACPI_IORT_RMR_ATTR_DEVICE_GRE)
+			prot |= IOMMU_MMIO;
+		else if (ACPI_IORT_RMR_ACCESS_ATTRIBUTES(rmr->flags) ==
+				ACPI_IORT_RMR_ATTR_NORMAL_IWB_OWB)
+			prot |= IOMMU_CACHE;
+
+		/* Create a copy of SIDs array to associate with this resv region */
+		sids_copy = kmemdup(sids, num_sids * sizeof(*sids), GFP_KERNEL);
+		if (!sids_copy)
+			return;
+
+		region = iommu_alloc_resv_region(addr, size, prot, type);
+		if (!region) {
+			kfree(sids_copy);
+			return;
+		}
+
+		region->fw_data.rmr.sids = sids_copy;
+		region->fw_data.rmr.num_sids = num_sids;
+		list_add_tail(&region->list, head);
+	}
+}
+
+static u32 *iort_rmr_alloc_sids(u32 *sids, u32 count, u32 id_start,
+				u32 new_count)
+{
+	u32 *new_sids;
+	u32 total_count = count + new_count;
+	int i;
+
+	new_sids = krealloc_array(sids, count + new_count,
+				  sizeof(*new_sids), GFP_KERNEL);
+	if (!new_sids)
+		return NULL;
+
+	for (i = count; i < total_count; i++)
+		new_sids[i] = id_start++;
+
+	return new_sids;
+}
+
+static bool iort_rmr_has_dev(struct device *dev, u32 id_start,
+			     u32 id_count)
+{
+	int i;
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+
+	/*
+	 * Make sure the kernel has preserved the boot firmware PCIe
+	 * configuration. This is required to ensure that the RMR PCIe
+	 * StreamIDs are still valid (Refer: ARM DEN 0049E.d Section 3.1.1.5).
+	 */
+	if (dev_is_pci(dev)) {
+		struct pci_dev *pdev = to_pci_dev(dev);
+		struct pci_host_bridge *host = pci_find_host_bridge(pdev->bus);
+
+		if (!host->preserve_config)
+			return false;
+	}
+
+	for (i = 0; i < fwspec->num_ids; i++) {
+		if (fwspec->ids[i] >= id_start &&
+		    fwspec->ids[i] <= id_start + id_count)
+			return true;
+	}
+
+	return false;
+}
+
+static void iort_node_get_rmr_info(struct acpi_iort_node *node,
+				   struct acpi_iort_node *iommu,
+				   struct device *dev, struct list_head *head)
+{
+	struct acpi_iort_node *smmu = NULL;
+	struct acpi_iort_rmr *rmr;
+	struct acpi_iort_id_mapping *map;
+	u32 *sids = NULL;
+	u32 num_sids = 0;
+	int i;
+
+	if (!node->mapping_offset || !node->mapping_count) {
+		pr_err(FW_BUG "Invalid ID mapping, skipping RMR node %p\n",
+		       node);
+		return;
+	}
+
+	rmr = (struct acpi_iort_rmr *)node->node_data;
+	if (!rmr->rmr_offset || !rmr->rmr_count)
+		return;
+
+	map = ACPI_ADD_PTR(struct acpi_iort_id_mapping, node,
+			   node->mapping_offset);
+
+	/*
+	 * Go through the ID mappings and see if we have a match for SMMU
+	 * and dev(if !NULL). If found, get the sids for the Node.
+	 * Please note, id_count is equal to the number of IDs  in the
+	 * range minus one.
+	 */
+	for (i = 0; i < node->mapping_count; i++, map++) {
+		struct acpi_iort_node *parent;
+
+		if (!map->id_count)
+			continue;
+
+		parent = ACPI_ADD_PTR(struct acpi_iort_node, iort_table,
+				      map->output_reference);
+		if (parent != iommu)
+			continue;
+
+		/* If dev is valid, check RMR node corresponds to the dev SID */
+		if (dev && !iort_rmr_has_dev(dev, map->output_base,
+					     map->id_count))
+			continue;
+
+		/* Retrieve SIDs associated with the Node. */
+		sids = iort_rmr_alloc_sids(sids, num_sids, map->output_base,
+					   map->id_count + 1);
+		if (!sids)
+			return;
+
+		num_sids += map->id_count + 1;
+	}
+
+	if (!sids)
+		return;
+
+	iort_get_rmrs(node, smmu, sids, num_sids, head);
+	kfree(sids);
+}
+
+static void iort_find_rmrs(struct acpi_iort_node *iommu, struct device *dev,
+			   struct list_head *head)
+{
+	struct acpi_table_iort *iort;
+	struct acpi_iort_node *iort_node, *iort_end;
+	int i;
+
+	/* Only supports ARM DEN 0049E.d onwards */
+	if (iort_table->revision < 5)
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
+			iort_node_get_rmr_info(iort_node, iommu, dev, head);
+
+		iort_node = ACPI_ADD_PTR(struct acpi_iort_node, iort_node,
+					 iort_node->length);
+	}
+}
+
+/*
+ * Populate the RMR list associated with a given IOMMU and dev(if provided).
+ * If dev is NULL, the function populates all the RMRs associated with the
+ * given IOMMU.
+ */
+static void
+iort_iommu_rmr_get_resv_regions(struct fwnode_handle *iommu_fwnode,
+				struct device *dev, struct list_head *head)
+{
+	struct acpi_iort_node *iommu;
+
+	iommu = iort_get_iort_node(iommu_fwnode);
+	if (!iommu)
+		return;
+
+	iort_find_rmrs(iommu, dev, head);
+}
+
 static struct acpi_iort_node *iort_get_msi_resv_iommu(struct device *dev)
 {
 	struct acpi_iort_node *iommu;
@@ -892,7 +1145,27 @@ iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head)
  */
 void iort_iommu_get_resv_regions(struct device *dev, struct list_head *head)
 {
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+
 	iort_iommu_msi_get_resv_regions(dev, head);
+	iort_iommu_rmr_get_resv_regions(fwspec->iommu_fwnode, dev, head);
+}
+
+/**
+ * iort_iommu_put_resv_regions - Free any IORT specific memory allocations
+ *                               associated with reserve regions.
+ * @dev: Associated device(Optional)
+ * @head: Resereved region list
+ */
+void iort_iommu_put_resv_regions(struct device *dev, struct list_head *head)
+{
+	struct iommu_resv_region *e, *tmp;
+
+	/* RMR entries will have mem allocated for fw_data.rmr.sids. */
+	list_for_each_entry_safe(e, tmp, head, list) {
+		if (e->fw_data.rmr.sids)
+			kfree(e->fw_data.rmr.sids);
+	}
 }
 
 static inline bool iort_iommu_driver_enabled(u8 type)
@@ -1061,6 +1334,8 @@ int iort_iommu_configure_id(struct device *dev, const u32 *id_in)
 #else
 void iort_iommu_get_resv_regions(struct device *dev, struct list_head *head)
 { }
+void iort_iommu_put_resv_regions(struct device *dev, struct list_head *head)
+{ }
 int iort_iommu_configure_id(struct device *dev, const u32 *input_id)
 { return -ENODEV; }
 #endif
diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 44e3f3feaab6..5811233dc9fb 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -391,6 +391,9 @@ EXPORT_SYMBOL(iommu_dma_get_resv_regions);
 
 void iommu_dma_put_resv_regions(struct device *dev, struct list_head *list)
 {
+	if (!is_of_node(dev_iommu_fwspec_get(dev)->iommu_fwnode))
+		iort_iommu_put_resv_regions(dev, list);
+
 	generic_iommu_put_resv_regions(dev, list);
 }
 EXPORT_SYMBOL(iommu_dma_put_resv_regions);
diff --git a/include/linux/acpi_iort.h b/include/linux/acpi_iort.h
index e5d2de9caf7f..eb3c28853110 100644
--- a/include/linux/acpi_iort.h
+++ b/include/linux/acpi_iort.h
@@ -37,6 +37,7 @@ int iort_pmsi_get_dev_id(struct device *dev, u32 *dev_id);
 int iort_dma_get_ranges(struct device *dev, u64 *size);
 int iort_iommu_configure_id(struct device *dev, const u32 *id_in);
 void iort_iommu_get_resv_regions(struct device *dev, struct list_head *head);
+void iort_iommu_put_resv_regions(struct device *dev, struct list_head *head);
 phys_addr_t acpi_iort_dma_get_max_cpu_address(void);
 #else
 static inline void acpi_iort_init(void) { }
@@ -54,6 +55,9 @@ static inline int iort_iommu_configure_id(struct device *dev, const u32 *id_in)
 static inline
 void iort_iommu_get_resv_regions(struct device *dev, struct list_head *head)
 { }
+static inline
+void iort_iommu_put_resv_regions(struct device *dev, struct list_head *head)
+{ }
 
 static inline phys_addr_t acpi_iort_dma_get_max_cpu_address(void)
 { return PHYS_ADDR_MAX; }
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
