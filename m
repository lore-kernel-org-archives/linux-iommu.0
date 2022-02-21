Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A23AC433F5
	for <iommu@archiver.kernel.org>; Mon, 21 Feb 2022 15:45:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C6E4E401A2;
	Mon, 21 Feb 2022 15:45:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NmFm0PiysViM; Mon, 21 Feb 2022 15:45:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 7DE89404F0;
	Mon, 21 Feb 2022 15:45:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 397F5C001A;
	Mon, 21 Feb 2022 15:45:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8B24EC0011
 for <iommu@lists.linux-foundation.org>; Mon, 21 Feb 2022 15:45:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8682A40292
 for <iommu@lists.linux-foundation.org>; Mon, 21 Feb 2022 15:45:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 63NtnrQ0YQWf for <iommu@lists.linux-foundation.org>;
 Mon, 21 Feb 2022 15:45:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3A1E940125
 for <iommu@lists.linux-foundation.org>; Mon, 21 Feb 2022 15:45:03 +0000 (UTC)
Received: from fraeml712-chm.china.huawei.com (unknown [172.18.147.200])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4K2RMQ3v9bz6GD5Q;
 Mon, 21 Feb 2022 23:40:18 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml712-chm.china.huawei.com (10.206.15.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 21 Feb 2022 16:45:00 +0100
Received: from A2006125610.china.huawei.com (10.47.91.169) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 21 Feb 2022 15:44:52 +0000
To: <linux-arm-kernel@lists.infradead.org>, <linux-acpi@vger.kernel.org>,
 <iommu@lists.linux-foundation.org>
Subject: [PATCH v8 03/11] ACPI/IORT: Add helper functions to parse RMR nodes
Date: Mon, 21 Feb 2022 15:43:36 +0000
Message-ID: <20220221154344.2126-4-shameerali.kolothum.thodi@huawei.com>
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

The helper functions here parse through the IORT RMR nodes and
populate a reserved region list  corresponding to a given iommu
and device(optional). These also go through the ID mappings of
the RMR node and retrieves all the SIDs associated with a RMR
descriptor.

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 drivers/acpi/arm64/iort.c | 225 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 225 insertions(+)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 0730c4dbb700..05da9ebff50a 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -830,6 +830,231 @@ static struct acpi_iort_node *iort_get_msi_resv_iommu(struct device *dev)
 	return NULL;
 }
 
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
+/*
+ * Please note, we will keep the already allocated RMR reserve
+ * regions in case of a memory allocation failure.
+ */
+static void iort_rmr_get_resv_regions(struct acpi_iort_node *node,
+				      struct acpi_iort_node *smmu,
+				      u32 *sids, u32 num_sids,
+				      struct list_head *head)
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
+				ACPI_IORT_RMR_ATTR_NORMAL)
+			prot |= IOMMU_CACHE;
+
+		/* Create a copy of sids array to associate with this resv region */
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
+	/*Update new ones */
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
+	 * Go through the ID mappings and see if we have a match
+	 * for smmu and dev(if !NULL). If found, get the sids
+	 * for the Node.
+	 * Please note, id_count is equal to the number of IDs
+	 * in the range minus one.
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
+		/* If dev is valid, check RMR node corresponds to the dev sid */
+		if (dev && !iort_rmr_has_dev(dev, map->output_base,
+					     map->id_count))
+			continue;
+
+		/* Retrieve sids associated with the Node. */
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
+	iort_rmr_get_resv_regions(node, smmu, sids, num_sids, head);
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
 /**
  * iort_iommu_msi_get_resv_regions - Reserved region driver helper
  * @dev: Device from iommu_get_resv_regions()
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
