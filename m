Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 520D8C433EF
	for <iommu@archiver.kernel.org>; Mon,  4 Apr 2022 09:44:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DD10E40868;
	Mon,  4 Apr 2022 09:44:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0S4JD0kj0s87; Mon,  4 Apr 2022 09:44:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 6B35D410B1;
	Mon,  4 Apr 2022 09:44:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 43A38C002C;
	Mon,  4 Apr 2022 09:44:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F3296C0012
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 09:44:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D2FD8410B1
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 09:44:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id A1vUSu0HyEtV for <iommu@lists.linux-foundation.org>;
 Mon,  4 Apr 2022 09:44:10 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2060e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::60e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B606140868
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 09:44:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MvJBt6ep/EHnO1f0dtOrpDci3zOh0vUzjGrbWUqI4qeKPgCDcd4aA8tIG/hyboliwE4y3BL2W0P2ioyICBKmVcOor0qkcSo+PJbGTFu+JG19ZjEFsnOJOdDi9OZXUL80hYfpkwDhE2vFPeOli3BPDtN9xxUDBdC7WqGX6vpTuWw/zvpabdsa3UgaNEI9Bjy8Tnm3i9JeMM+TvE5ZZ4CtfILiJxs/dP2DHYgEx3oAoaP+db4rhs/Z5Wv4eXWdtQvIlLlDhupm+J/Y5xdybqxxAYCvF93SKJThRtYmCvHDUI0Q7bU1NW/oenuuBddvOh/VEvwS6ajQfVJFgzv0vL3LAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eO0d3P3L4d+9mw8V609G9eo51O65kFlxpJN4g6PVkRQ=;
 b=jNaXkaUZCOyfhR7z1Ht87VAnP9YViW6Q0StA0LiDUAccitdO6hZkTQbJRrUqREMuTZXmNFe0uU3SgdDrZV2ZZHJrsHuQuyLgsJ0Hga1DGqkpQXZbrGc7M+Z2/mJd6jnOJpifoikJGh+5v5Y0DYx6z/KAv3f0Sa0+38oNLZv4B1/3tH1bE2KMkfHzrtsTWkhs+gHvSsBOO0IDYLZ5WnBxl994EAPHs9S2PUtm3DEzCstHqmLciKpvX2LaoPupsraDSG1FOdCc9/u197hAy1AyuBFeN04Wfxtki33oog5XivJgEYjnUkjQdCYgBojPwLbY0a7yqplDHKmGkLNvqD8Zqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eO0d3P3L4d+9mw8V609G9eo51O65kFlxpJN4g6PVkRQ=;
 b=i6H0l6xdDvF9TSJssBtV/+PEEHWxCrn5Zagh9sznxho179U20iMwUZZnjE0gG5HZ9Cm4HZCgrr2GTqNB0TipmRN432D9JadK6RuFVdjEh+BmoswX8/gVrqT8eCkG01d4Im4F68l5fzJlGObIxK2ZOjkPgsfEycK6iIJrX1wklkg=
Received: from MW2PR2101CA0029.namprd21.prod.outlook.com (2603:10b6:302:1::42)
 by BYAPR12MB2727.namprd12.prod.outlook.com (2603:10b6:a03:71::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 09:44:06 +0000
Received: from CO1NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:302:1:cafe::37) by MW2PR2101CA0029.outlook.office365.com
 (2603:10b6:302:1::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.4 via Frontend
 Transport; Mon, 4 Apr 2022 09:44:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT035.mail.protection.outlook.com (10.13.175.36) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5123.19 via Frontend Transport; Mon, 4 Apr 2022 09:44:04 +0000
Received: from kali.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 4 Apr
 2022 04:44:00 -0500
To: <iommu@lists.linux-foundation.org>, <joro@8bytes.org>
Subject: [PATCH v1 03/37] iommu/amd: Introduce per PCI segment device table
Date: Mon, 4 Apr 2022 15:10:55 +0530
Message-ID: <20220404094129.323642-4-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220404094129.323642-1-vasant.hegde@amd.com>
References: <20220404094129.323642-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2553fe17-cd9f-4b0f-4d22-08da161fa812
X-MS-TrafficTypeDiagnostic: BYAPR12MB2727:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB272786461BD37BA7AF9FB01287E59@BYAPR12MB2727.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9y1jUCg6lqRWDmInzZRCSw1rFsLphbisDcMtNZ7Q2ZNO+cmfNpnjGE4h98Y2+r8iIcsqaZJ/LWpADVCsZ/mar/LDLhGgFCocTnoSD6sXsu+jjDowl4uU5ACl2eLXh4CDdW6akO9Eq3eOxEPKD2SpcrbNRAsL+SLgm/x7wreeXaieCnLPoOj7Rf9JlgLBXCJCuTi/ebAjbGFPC6kA1n0EXoL/cjRFfTiAyu+YOc3FVxO+aSthCQUAjrI8kEfH2quAmYrPp0zh1/bBPnz64RNWCUNz6sF5nLH9IwDfD8BbpwYD6WapJPBw3wAwVYhoiS1Ij1ehFWvxl0ADhWXUw/aV5AsDPnuYyf6C0q0IqQkFxWFzwcsF7AYgxr6IXS6+iSemyvifYuF1bE+av09oEWipYUbrFPqHgbv+qDX2iAWi91jNT2q79Yd6uTGJaQhUcCN36FL00+T2XQ6m/fP/FROSqS2XhDzw0RcajOAIpgbljm2ZzRcRqFfggbJ0DJMNGriAfc0jJz2vGt+mG3iXuK75PxZYH0bn0JbcZN4CiSxoZzWcWbualqlc0MSvGpzDYOpAWEno6T+kaUC7Y8nvsna4eZDV4FjUM9SilMIvEqWW9FxwVQJfBsFJsVVoEqUz/PAiLIT5sjHI6razYzUBvyP//ZVkaAbXI9HukFGRocsai+KOKL0phEYRc8o4iu+Hg7hatWTI2c1CWjBkzkkswAslpQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(8676002)(508600001)(2906002)(82310400004)(86362001)(70206006)(4326008)(6666004)(186003)(16526019)(336012)(8936002)(26005)(44832011)(426003)(5660300002)(40460700003)(83380400001)(70586007)(2616005)(54906003)(110136005)(47076005)(316002)(36860700001)(36756003)(1076003)(356005)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2022 09:44:04.4040 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2553fe17-cd9f-4b0f-4d22-08da161fa812
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2727
Cc: Vasant Hegde <vasant.hegde@amd.com>
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
From: Vasant Hegde via iommu <iommu@lists.linux-foundation.org>
Reply-To: Vasant Hegde <vasant.hegde@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

Introduce per PCI segment device table. All IOMMUs within the segment
will share this device table. This will replace global device
table i.e. amd_iommu_dev_table.

Also introduce helper function to get the device table for the given IOMMU.

Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu.h       |  1 +
 drivers/iommu/amd/amd_iommu_types.h | 10 ++++++++++
 drivers/iommu/amd/init.c            | 26 ++++++++++++++++++++++++--
 drivers/iommu/amd/iommu.c           | 12 ++++++++++++
 4 files changed, 47 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 1ab31074f5b3..885570cd0d77 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -128,4 +128,5 @@ static inline void amd_iommu_apply_ivrs_quirks(void) { }
 
 extern void amd_iommu_domain_set_pgtable(struct protection_domain *domain,
 					 u64 *root, int mode);
+extern struct dev_table_entry *get_dev_table(struct amd_iommu *iommu);
 #endif
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 62442d88978f..404feb7995cc 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -539,6 +539,16 @@ struct amd_iommu_pci_seg {
 
 	/* PCI segment number */
 	u16 id;
+
+	/*
+	 * device table virtual address
+	 *
+	 * Pointer to the per PCI segment device table.
+	 * It is indexed by the PCI device id or the HT unit id and contains
+	 * information about the domain the device belongs to as well as the
+	 * page table root pointer.
+	 */
+	struct dev_table_entry *dev_table;
 };
 
 /*
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index e01eae9dcbc1..0fd1071bfc85 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -640,11 +640,29 @@ static int __init find_last_devid_acpi(struct acpi_table_header *table)
  *
  * The following functions belong to the code path which parses the ACPI table
  * the second time. In this ACPI parsing iteration we allocate IOMMU specific
- * data structures, initialize the device/alias/rlookup table and also
- * basically initialize the hardware.
+ * data structures, initialize the per PCI segment device/alias/rlookup table
+ * and also basically initialize the hardware.
  *
  ****************************************************************************/
 
+/* Allocate per PCI segment device table */
+static inline int __init alloc_dev_table(struct amd_iommu_pci_seg *pci_seg)
+{
+	pci_seg->dev_table = (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO | GFP_DMA32,
+						      get_order(dev_table_size));
+	if (!pci_seg->dev_table)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static inline void free_dev_table(struct amd_iommu_pci_seg *pci_seg)
+{
+	free_pages((unsigned long)pci_seg->dev_table,
+		    get_order(dev_table_size));
+	pci_seg->dev_table = NULL;
+}
+
 /*
  * Allocates the command buffer. This buffer is per AMD IOMMU. We can
  * write commands to that buffer later and the IOMMU will execute them
@@ -1469,6 +1487,9 @@ static struct amd_iommu_pci_seg *__init alloc_pci_segment(u16 id)
 	pci_seg->id = id;
 	list_add_tail(&pci_seg->list, &amd_iommu_pci_seg_list);
 
+	if (alloc_dev_table(pci_seg))
+		return NULL;
+
 	return pci_seg;
 }
 
@@ -1490,6 +1511,7 @@ static void __init free_pci_segment(void)
 
 	for_each_pci_segment_safe(pci_seg, next) {
 		list_del(&pci_seg->list);
+		free_dev_table(pci_seg);
 		kfree(pci_seg);
 	}
 }
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 7a29e2645dc4..52058c0d4f62 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -134,6 +134,18 @@ static inline int get_device_id(struct device *dev)
 	return devid;
 }
 
+struct dev_table_entry *get_dev_table(struct amd_iommu *iommu)
+{
+	struct dev_table_entry *dev_table;
+	struct amd_iommu_pci_seg *pci_seg = iommu->pci_seg;
+
+	BUG_ON(pci_seg == NULL);
+	dev_table = pci_seg->dev_table;
+	BUG_ON(dev_table == NULL);
+
+	return dev_table;
+}
+
 static struct protection_domain *to_pdomain(struct iommu_domain *dom)
 {
 	return container_of(dom, struct protection_domain, domain);
-- 
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
