Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 471EAC433EF
	for <iommu@archiver.kernel.org>; Mon, 25 Apr 2022 11:37:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0551181699;
	Mon, 25 Apr 2022 11:37:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oVlMJHeKL2OK; Mon, 25 Apr 2022 11:37:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D0C5481A65;
	Mon, 25 Apr 2022 11:37:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 96731C0039;
	Mon, 25 Apr 2022 11:37:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 97C99C002D
 for <iommu@lists.linux-foundation.org>; Mon, 25 Apr 2022 11:37:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 77A47409FE
 for <iommu@lists.linux-foundation.org>; Mon, 25 Apr 2022 11:37:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6rFAGL8eUK9m for <iommu@lists.linux-foundation.org>;
 Mon, 25 Apr 2022 11:37:51 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20631.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::631])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 71D5B40991
 for <iommu@lists.linux-foundation.org>; Mon, 25 Apr 2022 11:37:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K5GYA4OP+RZjAoCs//uBfxyZd3Mt/WgG4FYpZeDvTMTI40kFjk7Dp4zK6zPnXZeOm8C3XWBRCtWo7renjQzlrzXjQkmt51RabzvhYvjEWeA+IKoeR1xYGY8rpjgbKitZoq+JuLMBmmarDsYsZD8AheMDPOAcVLyzVBDJbGXoU1bzBNxAxmlPQVQ1GHRPP8rtaSR597aMQOcawR2ZplaNOWgEgwx+tqj4HUTR0dH2p5z9dmO32dqU3kQMFaciP3ecxmEP+EwWzgl4G6RBLEiRSiY1IgbycodTEezGzeVVVUYQ1hjQ3NvnzmaA3u9uvcd/xUo85xz3F4d+uLCJ6wDgpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LFf65MgM9stWiF/okyQ+w4Orsf2NvI1IhEOt+o5/G78=;
 b=bI7cCF7IYS+oY920gSs5G1FNdgCTlRK6inB5SIevHte+zVKz2IzQFHqKybT5OeC9gg3fbBA5mX2hvI3CREEdXBlKB5Ob4Tsk1p81aDoyrLXuVNgxyIhzo4p+Dh8xY7rsB+2IYGnvoUzUtrxvzlS+jZSrb9S44X8OyRJp2lrM9gQl9aL1cGIZNT4FNJDgonedZ4K+ZLMmGi4WoWra4Eb2uVvyTjdWeRtqy+saKfYvdq1ry2xeRVUf+4k+d3PWcrtsLfbarPVVJpgSknx81F0RHLgTvkd65EDJprsYX3fY74USI4A9ph8KHMCg8NyTsNYW2wfIDU2EWDYK/sY2YpP/bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LFf65MgM9stWiF/okyQ+w4Orsf2NvI1IhEOt+o5/G78=;
 b=qYEvVLhAwOuNVv2S/wk2O1n2OiRDPKvmbr9Y3lfQT61UCm9nmIyY0XW4qbUrJX85jkyUpbJw4GpmhtoKI0sVeT1C19ae40cB8CkyDXWHOmI769uw/EyKz+0Q4aZIjqBxnIioc2hfQ0MZQQA6gQV8AENR2Ts4X0yTuucZ2JD/80E=
Received: from BN9PR03CA0342.namprd03.prod.outlook.com (2603:10b6:408:f6::17)
 by MN2PR12MB4848.namprd12.prod.outlook.com (2603:10b6:208:1be::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Mon, 25 Apr
 2022 11:37:47 +0000
Received: from BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f6:cafe::9d) by BN9PR03CA0342.outlook.office365.com
 (2603:10b6:408:f6::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14 via Frontend
 Transport; Mon, 25 Apr 2022 11:37:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT025.mail.protection.outlook.com (10.13.177.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Mon, 25 Apr 2022 11:37:47 +0000
Received: from kali.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 25 Apr
 2022 06:37:45 -0500
To: <iommu@lists.linux-foundation.org>
Subject: [PATCH v2 11/37] iommu/amd: Introduce per PCI segment device table
 size
Date: Mon, 25 Apr 2022 17:03:49 +0530
Message-ID: <20220425113415.24087-12-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220425113415.24087-1-vasant.hegde@amd.com>
References: <20220425113415.24087-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5cd59682-4538-4531-6b02-08da26b00544
X-MS-TrafficTypeDiagnostic: MN2PR12MB4848:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB484871FEF42A5EEC5E4AD5ED87F89@MN2PR12MB4848.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +665ifHc90IqBL5cSBnX/1fObOg0+7y7hXepiIA+5MKraqJ/YeUtXPSaF0eveyzTvQLMF3GBnXzh2Ov3q4OCPKP8bHOp2locMbeC4xU38CEq5bZai+N0EEYvlx0bvwhqaqkpFlEbDIc2ZarnJ4w8RyD1Tyok7cUR2riXL5CoY3qIkUbMG236BStj3Up1u1ZZ+y218nt4+35ZFTgJYH0LCNquKMu92P818UAAFtCfIP6GM3WhsK9xJxC0eHQ1+UJSjGjEYUez1yrYjIWHIk3X7x0jIQI/CgGNy0yvRqTlspSIZ1noPkIhGIVBIAGIS2XYGBpGwl5Fkr0KrwxC9OmRlXmga89fw0I5N+PFRNlDbhEqKx1fq19io8EJNNcfl+NxwB92cbV/feh5VHyocYSwXteIy2ZMNvdSaBsULko4Nv79LsM60IzkPIR4ZMAWIqf3l0/ede7uWpAkzAlGKBOuSD1t87bWm1RFQcY6DlIkK245ohYZ1qyR69uptGZgz4zR0DBsJ+rqXCqbKMgLP9xyR7/8sjtaW31AzATg3Hyd0eMeIJf71jeqiyCavHUF7zhUMfk9Hu+q30DYYL2ugedCXv/nmfWu6axNDYtRpmAhS9UC8gAQ2McC4iVu28y8wDHvJsB9dAtnisFxjJY0a1eHa+/Wc24CB/GhhG9kTDrcpFdRdcK4sdBLQ4QOIcXgxoan9qVbPFCNdRxJ1d56XC+oXA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(356005)(426003)(47076005)(186003)(8936002)(44832011)(508600001)(5660300002)(2906002)(36756003)(83380400001)(70586007)(40460700003)(336012)(4326008)(8676002)(316002)(70206006)(1076003)(86362001)(2616005)(16526019)(26005)(54906003)(82310400005)(36860700001)(81166007)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2022 11:37:47.0191 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cd59682-4538-4531-6b02-08da26b00544
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4848
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
