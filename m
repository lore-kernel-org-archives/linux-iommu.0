Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88181C433F5
	for <iommu@archiver.kernel.org>; Mon,  4 Apr 2022 09:46:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4693B40376;
	Mon,  4 Apr 2022 09:46:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UXu8F0aeSDy1; Mon,  4 Apr 2022 09:46:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 0B6D04002B;
	Mon,  4 Apr 2022 09:46:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E87F8C002C;
	Mon,  4 Apr 2022 09:46:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AF6B4C0012
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 09:46:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9BD5A414C5
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 09:46:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MNXiTNrZgK-y for <iommu@lists.linux-foundation.org>;
 Mon,  4 Apr 2022 09:46:07 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20610.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::610])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5124D414C2
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 09:46:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a1Kvhr5EhfdXQ+NymGTnrUesrXyX6tIdK389UGMn/XCs3IEs6dt+lNAdy2egpolswyqRgeMpQ7NPDp3SiyL3UJ6e5Qy3u+5lNmvI+dNGkCziqi9C+W1hKtCoKl/OhWw5UoqaR/1BquPZg42VHpVSjmnFRUvOf9ZBmh+qocqEh0Vc7NZf14McJ8Vq4X3fVfhTB283JKUCJR/lv4vvTlwDqE+e+CQM1w7b69i4e6BVL+HeX3NkTAEc6lfMmtSrgUednqSbABsxsiMAy97G5qJgXjShokVfI5wJOckvq7OJ1z+ojx8Qtj2dDpP1fQnLl32wwiMs4Aa5Tx9zWBciFW3ZAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LFf65MgM9stWiF/okyQ+w4Orsf2NvI1IhEOt+o5/G78=;
 b=nSaPbSAMGXEq53PXvMQmjONNYLSJXjZU0ZZ5Y4DSw0v1kd2nz4H4NccUwPy3W4J3tnJHTG3NzOjOnyfb+BvVVReqQ55h6P8V08WRxm3FsTE19NBL7OF1GS0cNV1AcBwKSLaTvyvBsRS0I3Dbxix+iLEOrRVHd4zD1bsKmoE05TpDDvrt0VkKwE3Gfdzb6WZFIrOeHgcrAh8mjrIGYik6wIX2xsiPdz70L4b7nxjq+8VKjTpRFrraC/Izd2dBigzMLCr+JDBGnASrif42/IAVmNFjrn3/7nVoxbeIQfQvo1YabK9bzm/QXJCjtTKQZo0tI0zYUUJiUfHqVmSwiR6Qtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LFf65MgM9stWiF/okyQ+w4Orsf2NvI1IhEOt+o5/G78=;
 b=30wTvSu4MDgq9B/oMkE57/ZQ+BozOUnZK4akk5q8Fp8awraetOkWhJkZTLnelCDc2tkvhSm9rj6djBgc2W//TrGhzEh6E7HtVeZzp7ty4zmJ+oW5s3eNfPfXQqYv8oOzx9wQtF76vJ0CbEt82CR1VTBkEu+kRdRnzYVH9TgKHFI=
Received: from DM6PR08CA0007.namprd08.prod.outlook.com (2603:10b6:5:80::20) by
 CH2PR12MB3718.namprd12.prod.outlook.com (2603:10b6:610:2e::32) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5123.31; Mon, 4 Apr 2022 09:46:04 +0000
Received: from DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:80:cafe::6e) by DM6PR08CA0007.outlook.office365.com
 (2603:10b6:5:80::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31 via Frontend
 Transport; Mon, 4 Apr 2022 09:46:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT054.mail.protection.outlook.com (10.13.173.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5123.19 via Frontend Transport; Mon, 4 Apr 2022 09:46:03 +0000
Received: from kali.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 4 Apr
 2022 04:46:01 -0500
To: <iommu@lists.linux-foundation.org>, <joro@8bytes.org>
Subject: [PATCH v1 11/37] iommu/amd: Introduce per PCI segment device table
 size
Date: Mon, 4 Apr 2022 15:11:03 +0530
Message-ID: <20220404094129.323642-12-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220404094129.323642-1-vasant.hegde@amd.com>
References: <20220404094129.323642-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 727191b7-4e8e-4bff-4e33-08da161fef1b
X-MS-TrafficTypeDiagnostic: CH2PR12MB3718:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB37182825C5876CF10CB94CE187E59@CH2PR12MB3718.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ktDAQrBBGkxoX8xgo0vNe0hh17qyTKJCnijqhWLmPUggd5wyySDFzbsjXswFpMcBufMEJCG1fVAV+qBpxo0nuksDRwws6NeaFPXD/1fckE2WVEQVERfqCrCON+0jEhbxQIjYAM1rqVz1lfFB894oxyttgNfoi0T6iSocz9KQaN7aII2s8d4IIkKs9U73CQIsiOMeoi+6g0AklL3EHGRFsjiP9AXhp12qm3l062Xop46WDhk5hi2znRCwkGruUdxrpemSc61NhZarc1pDiuH6PRI/5qNJQfgrezd4vJmJ1XOWRxoHl8EaIYk4tB+qAQlz0vnk/PdwJtGzZKolYKnZC5PBW2PoI6y9Pm+xwKAdAsgjYOtNPcWmGQ0PXAmMHhA46hYr38Ph6XZIiRfqxeNakMDjUI7joSkiYuxZXdsUExwKhra+7oI/zUjLr6XPLEZDiEdoVy8ftNsgxZKgc0YUS31wjaKMHh2xa23sK2q3MRvNmvt5Rj02KZQSFZIJHYhwMXclKnK/2RuUTIYqDqK5SX/rsZrxQB81jTrH6QGx0jaOBZMoiUGajSDGKZWfaoEp4p1Ol2O3x6khI40gQyijwCSrJ9vS0T7/aTOqKseaG0fh8VeyQXJRRHPR/DqqxjOSiTO22BZf5nqq8bnP51GAEBrLLr0wLVA4gITZW/AlVLC/qTuZoYpKtbPIZm/5lOKA8OyIpKUXtzVPuGXZ50fTEg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(2906002)(36860700001)(356005)(110136005)(36756003)(8676002)(4326008)(70206006)(47076005)(316002)(70586007)(5660300002)(40460700003)(2616005)(54906003)(82310400004)(83380400001)(16526019)(1076003)(186003)(81166007)(508600001)(26005)(8936002)(86362001)(426003)(336012)(44832011)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2022 09:46:03.6594 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 727191b7-4e8e-4bff-4e33-08da161fef1b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3718
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

With multiple pci segment support, number of BDF supported by each
segment may differ. Hence introduce per segment device table size
which depends on last_bdf. This will replace global
"device_table_size" variable.

Co-developed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  3 +++
 drivers/iommu/amd/init.c            | 18 ++++++++++--------
 2 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index e39e7db54e69..aa666d0723ba 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -547,6 +547,9 @@ struct amd_iommu_pci_seg {
 	/* Largest PCI device id we expect translation requests for */
 	u16 last_bdf;
 
+	/* Size of the device table */
+	u32 dev_table_size;
+
 	/*
 	 * device table virtual address
 	 *
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 71f39551a83a..f8da686182b5 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -414,6 +414,7 @@ static void iommu_set_cwwb_range(struct amd_iommu *iommu)
 static void iommu_set_device_table(struct amd_iommu *iommu)
 {
 	u64 entry;
+	u32 dev_table_size = iommu->pci_seg->dev_table_size;
 
 	BUG_ON(iommu->mmio_base == NULL);
 
@@ -651,7 +652,7 @@ static int __init find_last_devid_acpi(struct acpi_table_header *table, u16 pci_
 static inline int __init alloc_dev_table(struct amd_iommu_pci_seg *pci_seg)
 {
 	pci_seg->dev_table = (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO | GFP_DMA32,
-						      get_order(dev_table_size));
+						      get_order(pci_seg->dev_table_size));
 	if (!pci_seg->dev_table)
 		return -ENOMEM;
 
@@ -661,7 +662,7 @@ static inline int __init alloc_dev_table(struct amd_iommu_pci_seg *pci_seg)
 static inline void free_dev_table(struct amd_iommu_pci_seg *pci_seg)
 {
 	free_pages((unsigned long)pci_seg->dev_table,
-		    get_order(dev_table_size));
+		    get_order(pci_seg->dev_table_size));
 	pci_seg->dev_table = NULL;
 }
 
@@ -1034,7 +1035,7 @@ static bool __copy_device_table(struct amd_iommu *iommu)
 	entry = (((u64) hi) << 32) + lo;
 
 	old_devtb_size = ((entry & ~PAGE_MASK) + 1) << 12;
-	if (old_devtb_size != dev_table_size) {
+	if (old_devtb_size != pci_seg->dev_table_size) {
 		pr_err("The device table size of IOMMU:%d is not expected!\n",
 			iommu->index);
 		return false;
@@ -1053,15 +1054,15 @@ static bool __copy_device_table(struct amd_iommu *iommu)
 	}
 	old_devtb = (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT) && is_kdump_kernel())
 		    ? (__force void *)ioremap_encrypted(old_devtb_phys,
-							dev_table_size)
-		    : memremap(old_devtb_phys, dev_table_size, MEMREMAP_WB);
+							pci_seg->dev_table_size)
+		    : memremap(old_devtb_phys, pci_seg->dev_table_size, MEMREMAP_WB);
 
 	if (!old_devtb)
 		return false;
 
 	gfp_flag = GFP_KERNEL | __GFP_ZERO | GFP_DMA32;
 	pci_seg->old_dev_tbl_cpy = (void *)__get_free_pages(gfp_flag,
-						    get_order(dev_table_size));
+						    get_order(pci_seg->dev_table_size));
 	if (pci_seg->old_dev_tbl_cpy == NULL) {
 		pr_err("Failed to allocate memory for copying old device table!\n");
 		memunmap(old_devtb);
@@ -1580,6 +1581,7 @@ static struct amd_iommu_pci_seg *__init alloc_pci_segment(u16 id,
 
 	pci_seg->last_bdf = last_bdf;
 	DUMP_printk("PCI segment : 0x%0x, last bdf : 0x%04x\n", id, last_bdf);
+	pci_seg->dev_table_size     = tbl_size(DEV_TABLE_ENTRY_SIZE);
 
 	pci_seg->id = id;
 	init_llist_head(&pci_seg->dev_data_list);
@@ -2675,7 +2677,7 @@ static void early_enable_iommus(void)
 		for_each_pci_segment(pci_seg) {
 			if (pci_seg->old_dev_tbl_cpy != NULL) {
 				free_pages((unsigned long)pci_seg->old_dev_tbl_cpy,
-						get_order(dev_table_size));
+						get_order(pci_seg->dev_table_size));
 				pci_seg->old_dev_tbl_cpy = NULL;
 			}
 		}
@@ -2689,7 +2691,7 @@ static void early_enable_iommus(void)
 
 		for_each_pci_segment(pci_seg) {
 			free_pages((unsigned long)pci_seg->dev_table,
-				   get_order(dev_table_size));
+				   get_order(pci_seg->dev_table_size));
 			pci_seg->dev_table = pci_seg->old_dev_tbl_cpy;
 		}
 
-- 
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
