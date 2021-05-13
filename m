Return-Path: <SRS0=YXze=KI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAF34C433ED
	for <iommu@archiver.kernel.org>; Thu, 13 May 2021 13:46:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F610613C7
	for <iommu@archiver.kernel.org>; Thu, 13 May 2021 13:46:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F610613C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E50AD83E5B;
	Thu, 13 May 2021 13:46:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jsnjSFo3MAIi; Thu, 13 May 2021 13:46:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id E09358444D;
	Thu, 13 May 2021 13:46:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BEA5FC000E;
	Thu, 13 May 2021 13:46:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A87F3C0001
 for <iommu@lists.linux-foundation.org>; Thu, 13 May 2021 13:46:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A447C403EF
 for <iommu@lists.linux-foundation.org>; Thu, 13 May 2021 13:46:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Qpi2hHSBDjkv for <iommu@lists.linux-foundation.org>;
 Thu, 13 May 2021 13:46:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 44D6A40408
 for <iommu@lists.linux-foundation.org>; Thu, 13 May 2021 13:46:32 +0000 (UTC)
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FgtD400ydzsRCP;
 Thu, 13 May 2021 21:43:47 +0800 (CST)
Received: from A2006125610.china.huawei.com (10.47.81.63) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.498.0; Thu, 13 May 2021 21:46:22 +0800
From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To: <linux-arm-kernel@lists.infradead.org>, <linux-acpi@vger.kernel.org>,
 <iommu@lists.linux-foundation.org>
Subject: [PATCH v4 1/8] ACPI/IORT: Add support for RMR node parsing
Date: Thu, 13 May 2021 14:45:43 +0100
Message-ID: <20210513134550.2117-2-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20210513134550.2117-1-shameerali.kolothum.thodi@huawei.com>
References: <20210513134550.2117-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.47.81.63]
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
Find associated stream id and smmu node info from the
RMR node and populate a linked list with RMR memory
descriptors.

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 drivers/acpi/arm64/iort.c | 104 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 103 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 3912a1f6058e..fea1ffaedf3b 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -40,6 +40,19 @@ struct iort_fwnode {
 static LIST_HEAD(iort_fwnode_list);
 static DEFINE_SPINLOCK(iort_fwnode_lock);
 
+/*
+ * One entry for IORT RMR.
+ */
+struct iort_rmr_entry {
+	struct list_head list;
+	u32 sid;
+	struct acpi_iort_node *smmu;
+	struct acpi_iort_rmr_desc *rmr_desc;
+	u32 flags;
+};
+
+static LIST_HEAD(iort_rmr_list);         /* list of RMR regions from ACPI */
+
 /**
  * iort_set_fwnode() - Create iort_fwnode and use it to register
  *		       iommu data in the iort_fwnode_list
@@ -393,7 +406,8 @@ static struct acpi_iort_node *iort_node_get_id(struct acpi_iort_node *node,
 		if (node->type == ACPI_IORT_NODE_NAMED_COMPONENT ||
 		    node->type == ACPI_IORT_NODE_PCI_ROOT_COMPLEX ||
 		    node->type == ACPI_IORT_NODE_SMMU_V3 ||
-		    node->type == ACPI_IORT_NODE_PMCG) {
+		    node->type == ACPI_IORT_NODE_PMCG ||
+		    node->type == ACPI_IORT_NODE_RMR) {
 			*id_out = map->output_base;
 			return parent;
 		}
@@ -1660,6 +1674,91 @@ static void __init iort_enable_acs(struct acpi_iort_node *iort_node)
 #else
 static inline void iort_enable_acs(struct acpi_iort_node *iort_node) { }
 #endif
+static int iort_rmr_desc_valid(struct acpi_iort_rmr_desc *desc, u32 count)
+{
+	int i, j;
+
+	for (i = 0; i < count; i++) {
+		u64 end, start = desc[i].base_address, length = desc[i].length;
+
+		if (!IS_ALIGNED(start, SZ_64K) || !IS_ALIGNED(length, SZ_64K))
+			return -EINVAL;
+
+		end = start + length - 1;
+
+		/* Check for address overlap */
+		for (j = i + 1; j < count; j++) {
+			u64 e_start = desc[j].base_address;
+			u64 e_end = e_start + desc[j].length - 1;
+
+			if (start <= e_end && end >= e_start)
+				return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
+static int __init iort_parse_rmr(struct acpi_iort_node *iort_node)
+{
+	struct acpi_iort_node *smmu;
+	struct iort_rmr_entry *e;
+	struct acpi_iort_rmr *rmr;
+	struct acpi_iort_rmr_desc *rmr_desc;
+	u32 map_count = iort_node->mapping_count;
+	u32  sid;
+	int i, ret = 0;
+
+	if (iort_node->type != ACPI_IORT_NODE_RMR)
+		return 0;
+
+	if (!iort_node->mapping_offset || map_count != 1) {
+		pr_err(FW_BUG "Invalid ID mapping, skipping RMR node %p\n",
+		       iort_node);
+		return -EINVAL;
+	}
+
+	/* Retrieve associated smmu and stream id */
+	smmu = iort_node_get_id(iort_node, &sid, 0);
+	if (!smmu) {
+		pr_err(FW_BUG "Invalid SMMU reference, skipping RMR node %p\n",
+		       iort_node);
+		return -EINVAL;
+	}
+
+	/* Retrieve RMR data */
+	rmr = (struct acpi_iort_rmr *)iort_node->node_data;
+	if (!rmr->rmr_offset || !rmr->rmr_count) {
+		pr_err(FW_BUG "Invalid RMR descriptor array, skipping RMR node %p\n",
+		       iort_node);
+		return -EINVAL;
+	}
+
+	rmr_desc = ACPI_ADD_PTR(struct acpi_iort_rmr_desc, iort_node,
+				rmr->rmr_offset);
+
+	ret = iort_rmr_desc_valid(rmr_desc, rmr->rmr_count);
+	if (ret) {
+		pr_err(FW_BUG "Invalid RMR descriptor[%d] for node %p, skipping...\n",
+		       i, iort_node);
+		return ret;
+	}
+
+	for (i = 0; i < rmr->rmr_count; i++, rmr_desc++) {
+		e = kmalloc(sizeof(*e), GFP_KERNEL);
+		if (!e)
+			return -ENOMEM;
+
+		e->sid = sid;
+		e->smmu = smmu;
+		e->rmr_desc = rmr_desc;
+		e->flags = rmr->flags;
+
+		list_add_tail(&e->list, &iort_rmr_list);
+	}
+
+	return 0;
+}
 
 static void __init iort_init_platform_devices(void)
 {
@@ -1689,6 +1788,9 @@ static void __init iort_init_platform_devices(void)
 
 		iort_enable_acs(iort_node);
 
+		if (iort_table->revision == 3)
+			iort_parse_rmr(iort_node);
+
 		ops = iort_get_dev_cfg(iort_node);
 		if (ops) {
 			fwnode = acpi_alloc_fwnode_static();
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
