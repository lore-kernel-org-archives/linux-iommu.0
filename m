Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4C02C433EF
	for <iommu@archiver.kernel.org>; Mon, 25 Apr 2022 11:41:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 617C9410A4;
	Mon, 25 Apr 2022 11:41:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LMRpaj6bgdbA; Mon, 25 Apr 2022 11:41:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9576240250;
	Mon, 25 Apr 2022 11:41:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 69889C0039;
	Mon, 25 Apr 2022 11:41:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8FAF5C002D
 for <iommu@lists.linux-foundation.org>; Mon, 25 Apr 2022 11:41:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8BF5C405A6
 for <iommu@lists.linux-foundation.org>; Mon, 25 Apr 2022 11:41:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3wWTlcdwfllV for <iommu@lists.linux-foundation.org>;
 Mon, 25 Apr 2022 11:41:47 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20611.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::611])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B851C40566
 for <iommu@lists.linux-foundation.org>; Mon, 25 Apr 2022 11:41:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j1wNaoacGclk1dKsGbpAKreniEZvibbFARVgnSd3IF1WjNEFRhdLMIBraUDtpNXvHcvDqtksSGz7dXGXnQv/B0tfhD9WIYZFLZm7Y3mnQ9oYJxfKU1b0zXZI2xS4PRCMijb3TN3CHSa2k/iXxMSFYEFAGtfS5zc+Sjr7pnr0KHLjL1JpuD+EhcWLskrDZCz/7hFdw0iPuYu/jyv++oZkCZT21BoWZ4wOEmXIW0HzOV/tA8jfuawGhFOR4WNmDS2Gn3jWU2tPEL4DOfF6py0r4Nwl7QfqLhHjqCNrELx/iaLns0QYOk47jy52sVsXKKNzr/owd0hcHl3oCQpiYqgELw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MSNtlOkwxMBsaevHyDmONa1ECH4ZYLvmUMCiK2CIy2k=;
 b=CtscXmHAivRgZLtUwk28/7dbWL/p7A4J9UdxfzfwVja5uTVMI+mpnHhns6aCaO7r26xbEYqsL4VxMegDiGlBDh8b+c4YDWRozW+q97ED3adNNCx1RV9Txy2A3P37gtQEq/NEvxAQPWDPf8jq64CURQF7B3glAMDOT+N74efwugUWp4/Est9NsT/0Y5ijqODGmcanmqmRTzNnTH0sWCC2GwLSWuzsEhLdpgofCrBLONKE+VKN95QNSLB0Jv2sIjCGlDWxxY9506SePRTvDkKX6/++5jZcMPRUwHmEwBrGRTGyiefSOhaF2Dg2MXAgyJyVjM2lyQWUwbqF+GRFAvQQ+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MSNtlOkwxMBsaevHyDmONa1ECH4ZYLvmUMCiK2CIy2k=;
 b=dmlHSq5wp1A7dPPh+CqN4FJrJn3BTgTW78ZDwjmR+2BPhTusBAPLERkxQUqvSOOfvA8eYo9CirrAHxDy2mntkhO3wuX60g6p+47+mM2P3WLmI3lsEUfXpuweYcP2ozE4DTlA3dYeo3fWwq8jWtsIUl3U1LNg9M1Ifb7pwWdQSQY=
Received: from BN0PR03CA0054.namprd03.prod.outlook.com (2603:10b6:408:e7::29)
 by BYAPR12MB4616.namprd12.prod.outlook.com (2603:10b6:a03:a2::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Mon, 25 Apr
 2022 11:41:45 +0000
Received: from BN8NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e7:cafe::bb) by BN0PR03CA0054.outlook.office365.com
 (2603:10b6:408:e7::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13 via Frontend
 Transport; Mon, 25 Apr 2022 11:41:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT066.mail.protection.outlook.com (10.13.177.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Mon, 25 Apr 2022 11:41:44 +0000
Received: from kali.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 25 Apr
 2022 06:41:42 -0500
To: <iommu@lists.linux-foundation.org>
Subject: [PATCH v2 27/37] iommu/amd: Remove global amd_iommu_dev_table
Date: Mon, 25 Apr 2022 17:04:05 +0530
Message-ID: <20220425113415.24087-28-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220425113415.24087-1-vasant.hegde@amd.com>
References: <20220425113415.24087-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 98a6450f-9b60-430f-793d-08da26b092b4
X-MS-TrafficTypeDiagnostic: BYAPR12MB4616:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB461635B69C59F863F4D4BD8D87F89@BYAPR12MB4616.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VwAWa+vKUF0AA+HP3cN/6Vizr6vJhKHONP10wsnJTtT6bh4PduRkPaPlE0N70bTjZaxzMBDOeOa9qDDbJVmU+6ccFy6ndO8315myPDR16Rfm5J5hg6zFBgWLQTZVRJXlAjZ7drcaxlY50mGm/E3mfG/VlmUhFWQJNXQjH2E/qyM0SPQpMni9kV0xzouOrQhzoVCQ72+UnK7Mmls/oT/SfmDGXkSmpmkBXNAs3IHv0UMlvUuasn6on/M2CPv+rLSMKvIka5s47brAyzC7TRjBt4O64VylQcoovgMBvRlh81R/EeqA3lkpWZ9hliGBguAEk3YuxOwmcm/3d052YOY69uhIaVV3YFIvacMM6I1B3zxm1fB+lku9+sCme12cHFbrTeP0rYugsJOskYXbq7PHw+slU0OZgkmMDaaNPULFpQLq/Mt9T4wKUKIqa19gMcSgwm+AnQU2bAkjuTadfuhid76zYDdS7/F2iPkcPy+8BCasE00ApFDtn+dV/pSMgU9uNpb4TWBWnSo+NXcYcWRiZpPzuo+CwwYeyirvJmcrWy/9vSyu2EB12huO3qGsLf4MtDVSXJ1kbDiZAB2YiYls9TeKHfqvViJUTqQiFwlSSB1iCfpSJHBIp+P6CBg2cAVnqcNjq2/yMoeM9pZBD8RAOIkNFFOyBiZByuadGV1wvE0ikMOjpLwOKi8oMaEcEx981AWKz8VOZzXJv7bFNDYEBA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(336012)(1076003)(26005)(186003)(16526019)(6916009)(54906003)(2616005)(426003)(40460700003)(82310400005)(36756003)(508600001)(36860700001)(81166007)(86362001)(5660300002)(316002)(2906002)(6666004)(356005)(83380400001)(47076005)(8676002)(4326008)(8936002)(70586007)(44832011)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2022 11:41:44.3122 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98a6450f-9b60-430f-793d-08da26b092b4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4616
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

Replace global amd_iommu_dev_table with per PCI segment device table.
Also remove "dev_table_size".

Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  6 ------
 drivers/iommu/amd/init.c            | 30 +++--------------------------
 drivers/iommu/amd/iommu.c           |  8 +++++---
 3 files changed, 8 insertions(+), 36 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 334206381f84..dc76ee2c3ea5 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -826,12 +826,6 @@ struct unity_map_entry {
  * Data structures for device handling
  */
 
-/*
- * Device table used by hardware. Read and write accesses by software are
- * locked with the amd_iommu_pd_table lock.
- */
-extern struct dev_table_entry *amd_iommu_dev_table;
-
 /*
  * Alias table to find requestor ids to device ids. Not locked because only
  * read on runtime.
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index b2ddf407e967..dd667dfb4355 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -185,14 +185,6 @@ static bool amd_iommu_pc_present __read_mostly;
 
 bool amd_iommu_force_isolation __read_mostly;
 
-/*
- * Pointer to the device table which is shared by all AMD IOMMUs
- * it is indexed by the PCI device id or the HT unit id and contains
- * information about the domain the device belongs to as well as the
- * page table root pointer.
- */
-struct dev_table_entry *amd_iommu_dev_table;
-
 /*
  * The alias table is a driver specific data structure which contains the
  * mappings of the PCI device ids to the actual requestor ids on the IOMMU.
@@ -206,7 +198,6 @@ u16 *amd_iommu_alias_table;
  */
 unsigned long *amd_iommu_pd_alloc_bitmap;
 
-static u32 dev_table_size;	/* size of the device table */
 static u32 alias_table_size;	/* size of the alias table */
 
 enum iommu_init_state {
@@ -402,10 +393,11 @@ static void iommu_set_device_table(struct amd_iommu *iommu)
 {
 	u64 entry;
 	u32 dev_table_size = iommu->pci_seg->dev_table_size;
+	void *dev_table = (void *)get_dev_table(iommu);
 
 	BUG_ON(iommu->mmio_base == NULL);
 
-	entry = iommu_virt_to_phys(amd_iommu_dev_table);
+	entry = iommu_virt_to_phys(dev_table);
 	entry |= (dev_table_size >> 12) - 1;
 	memcpy_toio(iommu->mmio_base + MMIO_DEV_TABLE_OFFSET,
 			&entry, sizeof(entry));
@@ -1148,12 +1140,6 @@ void amd_iommu_apply_erratum_63(struct amd_iommu *iommu, u16 devid)
 		set_dev_entry_bit(iommu, devid, DEV_ENTRY_IW);
 }
 
-/* Writes the specific IOMMU for a device into the rlookup table */
-static void __init set_iommu_for_device(struct amd_iommu *iommu, u16 devid)
-{
-	iommu->pci_seg->rlookup_table[devid] = iommu;
-}
-
 /*
  * This function takes the device specific flags read from the ACPI
  * table and sets up the device table entry with that information
@@ -1178,7 +1164,7 @@ static void __init set_dev_entry_from_acpi(struct amd_iommu *iommu,
 
 	amd_iommu_apply_erratum_63(iommu, devid);
 
-	set_iommu_for_device(iommu, devid);
+	amd_iommu_set_rlookup_table(iommu, devid);
 }
 
 int __init add_special_device(u8 type, u8 id, u16 *devid, bool cmd_line)
@@ -2809,10 +2795,6 @@ static void __init free_iommu_resources(void)
 		   get_order(alias_table_size));
 	amd_iommu_alias_table = NULL;
 
-	free_pages((unsigned long)amd_iommu_dev_table,
-		   get_order(dev_table_size));
-	amd_iommu_dev_table = NULL;
-
 	free_iommu_all();
 	free_pci_segment();
 }
@@ -2941,16 +2923,10 @@ static int __init early_amd_iommu_init(void)
 	amd_iommu_target_ivhd_type = get_highest_supported_ivhd_type(ivrs_base);
 	DUMP_printk("Using IVHD type %#x\n", amd_iommu_target_ivhd_type);
 
-	dev_table_size     = tbl_size(DEV_TABLE_ENTRY_SIZE);
 	alias_table_size   = tbl_size(ALIAS_TABLE_ENTRY_SIZE);
 
 	/* Device table - directly used by all IOMMUs */
 	ret = -ENOMEM;
-	amd_iommu_dev_table = (void *)__get_free_pages(
-				      GFP_KERNEL | __GFP_ZERO | GFP_DMA32,
-				      get_order(dev_table_size));
-	if (amd_iommu_dev_table == NULL)
-		goto out;
 
 	/*
 	 * Alias table - map PCI Bus/Dev/Func to Bus/Dev/Func the
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 079b38501b3b..476217f2890d 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -230,6 +230,7 @@ static struct iommu_dev_data *search_dev_data(struct amd_iommu *iommu, u16 devid
 static int clone_alias(struct pci_dev *pdev, u16 alias, void *data)
 {
 	struct amd_iommu *iommu;
+	struct dev_table_entry *dev_table;
 	u16 devid = pci_dev_id(pdev);
 
 	if (devid == alias)
@@ -240,9 +241,10 @@ static int clone_alias(struct pci_dev *pdev, u16 alias, void *data)
 		return 0;
 
 	amd_iommu_set_rlookup_table(iommu, alias);
-	memcpy(amd_iommu_dev_table[alias].data,
-	       amd_iommu_dev_table[devid].data,
-	       sizeof(amd_iommu_dev_table[alias].data));
+	dev_table = get_dev_table(iommu);
+	memcpy(dev_table[alias].data,
+	       dev_table[devid].data,
+	       sizeof(dev_table[alias].data));
 
 	return 0;
 }
-- 
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
