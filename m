Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793938794;
	b=xkKOJbrbLtRCwynpFpYPte8LbvpRzztbOsBaFypL8LT/Kghf9CEDFU071Bw3oCiNZuOM
	 mTJUQNJxAmWuSyTVp2d2KwO1qOUjxGwbalTUK4ksrX8hWHIOzcMvtRE6HQV5VmkkncHFP
	 0bF3Hi2rYgC6zoKUJW5qkvnV+pWre52+Q4vWWwS/Ey/n3QOVYvmyWTUIIRtD7iyqKgju2
	 dIidgWYlVpY+W3koDMo3VnevV/4iAgMDQrlaKl7pSL95m5SziL3a2p9Ke4FoAKeVoohTa
	 rLmv31ZulgPifi6OMGcRGIWre8dxGXCK3SA2lDDpSbV9zQkQkjhSqHLEHIDksD07qEA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793938794;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=1k3dkCONaNm0YVEN8kvF8z6C9HbY3uAbCGB2FGNPwcQ=;
	b=5hh6tErooBi1msbBLGfhRfBHoSd1BcPxOkWNZGCq5HjpAhw02ZBuhGizo4RYh3fxUCLE
	 orqNW8ogH6JNom7ULapAcikLwur6f20kI+inKdUx+YSLLUGYnphHo1dW7ToHNuNYg5z+Z
	 qTjbfmPIXpOhA3Pe9Kw9VyF/kSVi+HfsRsh491KVXgNHUNxCbPyL9/1NSLs5EfuDd4q0E
	 kZszgT0MWvvLcAAZZnZv2ARq51V+NlZlE98tMIF2h2rzmlHB0ZW9s9PRmuOevFN+V50AM
	 pq1z5AJkIf+HaK4ypriwMTEajO8d/i5NT3OpJEPA+qOPuStpAvSc/5e0OpUyvTW5qJQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=eBaKg6uU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.44
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010044.outbound.protection.outlook.com [52.101.56.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DB8606A326
	for <iommu@lists.linux.dev>; Fri,  6 Nov 2026 04:19:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68DB8606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=eBaKg6uU
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yG8ASVCEPPDxM+s7uWSgXVZbvQsYM64rQPR/utKTJigV2hb2A7gYjQzadOS+0nKNHRT+mFgpZcYFhwK+51vJWqM4WfzI0LphzOsAmrFFCx8tiu0KJB9V65p8SKvNJ4mlDcHg5BEraLRYEpeawanvoUPTieBAayt/2lxU5dIUH98q3tRKkGry51SFb5XG3Qd2XF2bK1DyOUciK7C7v390Z+8xc9XkztcSq7bHZOrc06RyMOtPEF9bpxZENF07mcARuk2iJXYGf72kh56bEloXDSHZowOFBe+7id1iH3f2dSuc8EDSYL6Q6Mnf1fhu4fOy30DwhYjrKQ70uNz9VHOm1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1k3dkCONaNm0YVEN8kvF8z6C9HbY3uAbCGB2FGNPwcQ=;
 b=YDrcy1ajxyEGm21l5MDjH4Vk5AqqO+EWOnEmL2msXDpCQV6F4cWB8aluZ3vWMZZ2azzZvnkXc3SqQK9dI8X4W2EmNOyi5ZVWZGDNXMp+eeL/8FPfJ2sTolvXLx4f1SjKc+PEnfLzKX41moB0p0IpoOqvnK+FkSWS/JL6LDVtgPd6/IeTOtM0ZOYFukj4Hvpe0upho/EkhNRcVEbXs/gDoeu7HpgRGmoHEDcbtwvoNxrQLBA1OJ5XB3yQLudBuHp5CjHEsDf4rpxDInGMMoAbAIaCeDX/qDLK0UHf2cLGBGonCH+CZYitRwAFqlJRevNGjR/fRZsBQ8bIpXx7UZWn7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1k3dkCONaNm0YVEN8kvF8z6C9HbY3uAbCGB2FGNPwcQ=;
 b=eBaKg6uUjEtDn5Ul5Lvo/s7vtsaU5SqZcHosGLRpQILmSBXyOz8sB902vttZ6rhB/gd6omh0ThhTN/Pyz9y3TcalcThXiUXI4mJ2lKIJafYh8aoaHiiCBUn1oZ4CMGcHCZjKfoXYsP1uILu2P8b/4rVcH8s7+ksckUiEs0ycsyQ=
Received: from CH0PR08CA0001.namprd08.prod.outlook.com (2603:10b6:610:33::6)
 by DS7PR12MB9042.namprd12.prod.outlook.com (2603:10b6:8:ed::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 6 Nov
 2026 04:18:15 +0000
Received: from CH2PEPF00000147.namprd02.prod.outlook.com
 (2603:10b6:610:33:cafe::11) by CH0PR08CA0001.outlook.office365.com
 (2603:10b6:610:33::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Fri, 6
 Nov 2026 04:18:15 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000147.mail.protection.outlook.com (10.167.244.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Fri, 6 Nov 2026 04:18:15 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 5 Nov
 2026 22:18:11 -0600
From: Sairaj Kodilkar <sarunkod@amd.com>
To: "Joerg Roedel (AMD)" <joro@8bytes.org>, Adrian Huang
	<ahuang12@lenovo.com>, Joerg Roedel <jroedel@suse.de>, Robin Murphy
	<robin.murphy@arm.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, "Will
 Deacon" <will@kernel.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
CC: Sairaj Kodilkar <sarunkod@amd.com>, Adam Pelka <adampelka26@gmail.com>
Subject: [PATCH v3 3/3] iommu/amd: Rename unity_map_entry and unit_map to ivmd_entry and ivhd_entry_map
Date: Fri, 6 Nov 2026 09:46:50 +0530
Message-ID: <20261106041650.24076-4-sarunkod@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261106041650.24076-1-sarunkod@amd.com>
References: <20261106041650.24076-1-sarunkod@amd.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000147:EE_|DS7PR12MB9042:EE_
X-MS-Office365-Filtering-Correlation-Id: d6c10cd9-563a-459d-1d89-08df3bbcfacd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|23010399003|376014|1800799024|22082099003|18002099003|6133799003|10067099003|11063799006|56012099006|261026121527099003|261022075727099003|261026140227099003|261102123227099003|261028144727099003|261021123027099003|261022105027099003|261009223027099003|261021121427099003;
X-Microsoft-Antispam-Message-Info:
	JyQDv5QNPma0NsmoU1BRaI037w7WUOyfD7haWG5h93zTn6p0BWF2L2/FpC9i+EpJMXheBHc2a1tG+DPSimYaIN7IL9o6J/W6JzjNsmvmIZ5hsMktTVOb08oUcLMw6tA2gomG8Gm/5YNJDUSYjkUyvdlXqUiM+dPqDTU+21VeozLH5yF7W/rdlHpyMwsRSzAxVmdXOXBUjbL2yT5rKfipZp2twxJ3iK1X6SUa9FaRlO6se0PB4fmr88sthKIeKtjlOB6MGQdquWxaUmf8LT4Q16pXsUz4mEYE0FAvQH0XrqVcBNXvYj/H3izfeQ48rvpC5YQIyM+EGkT+sCZTIweldsAermpNE0ApfDeYdAVG0lzOalmWho5ul243YPoz4S/envCeX2W48IyXyAmh6VKZGP2eTexFNKSCXlkZDSsHouEd+VaziaoX145Uwp/PEFQWokZd9JjOnnZ3byzHDPFA0b9Ag3U0346Ezzu1GBePxUZTJ9CnrWAc7h/WtVchS1lp7CnLW6Jh8mkaWKZIsCqDrRFe58/9bj9VlIcS3Gnt47dXfUSlXfFkdT+Oo7BEW8jQhFsSS4AonqeigMEbte4lnS41zmmHI2qQ4PI1x54HC3kBMpyJGfiYkfqkL3Q64DbDDA4uPsFS45xQb+t4PVZSISvuutVRR71UAhb85dLvZtY/IGrQRvX9n2ZQ+2Wr4tPk0viEIm88R8SsRJZtrEwFqw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(23010399003)(376014)(1800799024)(22082099003)(18002099003)(6133799003)(10067099003)(11063799006)(56012099006)(261026121527099003)(261022075727099003)(261026140227099003)(261102123227099003)(261028144727099003)(261021123027099003)(261022105027099003)(261009223027099003)(261021121427099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	52KXsrUT0552rcK4mDcmo5W4ZDJiNNZnksUBVs2B/tfntIRGk3yFfdb3/hmC26DtOaucuXVmuWA21BGrg6UVM4Q8mLi7bmF4B5OxvF92Pu5kQ7j/Rq4Gj7n7gw+nhkLa53cDOhNT5R8p+fAJYjD9jX8o+gwOqJ7vUpUpHmZDKukBnrsXf8WvPdl3yJ03JdNE8qka1+X7guWczCQjTQRBDi78Ljz844CenP2gUZ7hXKLmbZ+LhAIQiCx2F5+kovbVGx++ak8D/jvvMtNsdFsTYm9bd3Mg67EnWJ5gy8NmI9BtRlipetwhRQTJ4IcVmz0SqTPojfi/acfLm3x8arRIrPqo2gVcdRpFlXbofE8fB0+zQDy18kLQo0c6ycbQrpFbEbqCoKa/6xSpDmkX2dKR0GHHBl0V6zW2y/D2CShKS7WmBYS7tXgWwjmgQThtuM6W
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 04:18:15.6976
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6c10cd9-563a-459d-1d89-08df3bbcfacd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000147.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9042

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

Also, rename struct list_head unity_map to ivmd_entry_map along with
renaming the unity-map helper functions and add error message when
handling invalid IVMD entry.

No functional change intended.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
Tested-by: Adam Pelka <adampelka26@gmail.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  6 +++---
 drivers/iommu/amd/init.c            | 22 +++++++++++-----------
 drivers/iommu/amd/iommu.c           |  7 ++++---
 3 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index bcb88b476167..033cabc5b73a 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -609,11 +609,11 @@ struct amd_iommu_pci_seg {
 	u16 *alias_table;
 
 	/*
-	 * A list of required unity mappings we find in ACPI. It is not locked
+	 * A list of required IVMD mappings we find in ACPI. It is not locked
 	 * because as runtime it is only read. It is created at ACPI table
 	 * parsing time.
 	 */
-	struct list_head unity_map;
+	struct list_head ivmd_entry_map;
 };
 
 /*
@@ -869,7 +869,7 @@ struct ivhd_dte_flags {
 /*
  * One entry for unity mappings parsed out of the ACPI table.
  */
-struct unity_map_entry {
+struct ivmd_entry {
 	struct list_head list;
 
 	/* starting device id this entry is used for (including) */
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 1f0ca675df1c..9356efe14b3e 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -132,7 +132,7 @@ int amd_iommu_pprlog_size = PPRLOG_SIZE_DEF;
 
 /*
  * An AMD IOMMU memory definition structure. It defines things like exclusion
- * ranges for devices and regions that should be unity mapped.
+ * ranges, unity mapping for device and regions.
  */
 struct ivmd_header {
 	u8 type;
@@ -1726,7 +1726,7 @@ static struct amd_iommu_pci_seg *__init alloc_pci_segment(u16 id,
 
 	pci_seg->id = id;
 	init_llist_head(&pci_seg->dev_data_list);
-	INIT_LIST_HEAD(&pci_seg->unity_map);
+	INIT_LIST_HEAD(&pci_seg->ivmd_entry_map);
 	list_add_tail(&pci_seg->list, &amd_iommu_pci_seg_list);
 
 	if (alloc_dev_table(pci_seg))
@@ -2319,8 +2319,8 @@ static int __init amd_iommu_init_pci(void)
 	}
 
 	/*
-	 * Order is important here to make sure any unity map requirements are
-	 * fulfilled. The unity mappings are created and written to the device
+	 * Order is important here to make sure any ivmd map requirements are
+	 * fulfilled. The ivmd mappings are created and written to the device
 	 * table during the iommu_init_pci() call.
 	 *
 	 * After that we call init_device_table_dma() to make sure any
@@ -2606,17 +2606,17 @@ static int iommu_init_irq(struct amd_iommu *iommu)
  *
  * The next functions belong to the third pass of parsing the ACPI
  * table. In this last pass the memory mapping requirements are
- * gathered (like exclusion and unity mapping ranges).
+ * gathered (like exclusion and ivmd mapping ranges).
  *
  ****************************************************************************/
 
-static void __init free_unity_maps(void)
+static void __init free_ivmd_maps(void)
 {
-	struct unity_map_entry *entry, *next;
+	struct ivmd_entry *entry, *next;
 	struct amd_iommu_pci_seg *p, *pci_seg;
 
 	for_each_pci_segment_safe(pci_seg, p) {
-		list_for_each_entry_safe(entry, next, &pci_seg->unity_map, list) {
+		list_for_each_entry_safe(entry, next, &pci_seg->ivmd_entry_map, list) {
 			list_del(&entry->list);
 			kfree(entry);
 		}
@@ -2627,7 +2627,7 @@ static void __init free_unity_maps(void)
 static int __init init_unity_map_range(struct ivmd_header *m,
 				       struct acpi_table_header *ivrs_base)
 {
-	struct unity_map_entry *e = NULL;
+	struct ivmd_entry *e = NULL;
 	struct amd_iommu_pci_seg *pci_seg;
 	char *s;
 
@@ -2678,7 +2678,7 @@ static int __init init_unity_map_range(struct ivmd_header *m,
 		    PCI_SLOT(e->devid_end), PCI_FUNC(e->devid_end),
 		    e->address_start, e->address_end, m->flags);
 
-	list_add_tail(&e->list, &pci_seg->unity_map);
+	list_add_tail(&e->list, &pci_seg->ivmd_entry_map);
 
 	return 0;
 }
@@ -3178,7 +3178,7 @@ static bool __init check_ioapic_information(void)
 static void __init free_dma_resources(void)
 {
 	amd_iommu_pdom_id_destroy();
-	free_unity_maps();
+	free_ivmd_maps();
 }
 
 static void __init ivinfo_init(void *ivrs)
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 699b5f530f11..d0308fbceac6 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3100,7 +3100,7 @@ static void amd_iommu_get_resv_regions(struct device *dev,
 				       struct list_head *head)
 {
 	struct iommu_resv_region *region;
-	struct unity_map_entry *entry;
+	struct ivmd_entry *entry;
 	struct amd_iommu *iommu;
 	struct amd_iommu_pci_seg *pci_seg;
 	int devid, sbdf;
@@ -3113,7 +3113,7 @@ static void amd_iommu_get_resv_regions(struct device *dev,
 	iommu = get_amd_iommu_from_dev(dev);
 	pci_seg = iommu->pci_seg;
 
-	list_for_each_entry(entry, &pci_seg->unity_map, list) {
+	list_for_each_entry(entry, &pci_seg->ivmd_entry_map, list) {
 		int type, prot = 0;
 		size_t length;
 
@@ -3148,7 +3148,8 @@ static void amd_iommu_get_resv_regions(struct device *dev,
 						 length, prot, type,
 						 GFP_KERNEL);
 		if (!region) {
-			dev_err(dev, "Out of memory allocating dm-regions\n");
+			pr_err("%s: Out of memory allocating reserved regions for sbdf=%#x\n",
+			       __func__, sbdf);
 			return;
 		}
 		list_add_tail(&region->list, head);
-- 
2.34.1

