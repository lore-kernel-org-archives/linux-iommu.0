Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AC04C433EF
	for <iommu@archiver.kernel.org>; Fri, 11 Mar 2022 09:59:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E1323415DC;
	Fri, 11 Mar 2022 09:59:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1PzSIYXPi1Aj; Fri, 11 Mar 2022 09:59:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id A142540274;
	Fri, 11 Mar 2022 09:59:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7B21DC0012;
	Fri, 11 Mar 2022 09:59:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 496B5C000B
 for <iommu@lists.linux-foundation.org>; Fri, 11 Mar 2022 09:59:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 29D91605BE
 for <iommu@lists.linux-foundation.org>; Fri, 11 Mar 2022 09:59:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hYAql7TWKZWL for <iommu@lists.linux-foundation.org>;
 Fri, 11 Mar 2022 09:59:05 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20628.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::628])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 36F68611EA
 for <iommu@lists.linux-foundation.org>; Fri, 11 Mar 2022 09:59:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=egK3azcrX3ZNYJ9SKvZnI2Ie3tO+HQEgnhdDO5swC81DIHs0Ro0zofmXmWauf2PMc+DT2nSukXqOEX9gxlRAdhOUMqRCPwqkPmQEn6Koe4e+S11eOdtSbdJz0gjsac2LT03MdJ3Vi9GcDCeggG+8gTayHwgbvbZUr7e0AkJDQWG4NEqN0PTqv4h3JpkqvRYCPhHCn1YSM5meRl3euS+dSTxxYPqbwt5lW16PljWcWgxDi24J6RX163wHxZiwuO70vPbKxNfXkZbMSCOifPGbQOPTI7wjxLyUnM7xhzhimbkBkWSZhVFq7DWctgNhng0d+a9LynaTXVDPuk0dhUmRBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qswSZx6oP3LjdGwX/hTukhri+Dn4OpIvvVO6s/lBUzE=;
 b=A8gNesN1hZNO6iK65Fv9UqmTXax38pYjr4AFgvd4OSsY0pLz6/smCEoZmBr1sYenBScozSH2gVly+NXTeElnoUpu6/Zcmj5iq5PPTJa45f7oZ0OxUGxyFEE157zIbOXzkvjF45cNlZbHhlTxI8P87ku7IXAWNoufQIuu7908wl9uLiMu8cjrO6W/xprmfJFl8iQqCNNAYqqxYvml2Y2EOGOCPzceQUrBT9FNQxXGz8pmTx8CKp96DnI+DxiupzfYc1CwFxRRWWaIm9HYPj4I9t5GvctEDGhlQXHeiXR+I4VJFmrAjAUmxuFaLboXbPNQhz9xfoeh5ZRLPvKaZQfzWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qswSZx6oP3LjdGwX/hTukhri+Dn4OpIvvVO6s/lBUzE=;
 b=p+0st5muIepevA4wJS/VDf7sppyGDFtMR9MiJvExUFODb+sOd7iH4cylsdfwrhBVnrGsWFjp1mUKXXTbklNMC+8HThILKgzJo0qO8xs/Q8e1XA4FpIokfnopLrutuB5vhS4Smaomi4/+0cM6Wcsw8SggRjSaBC/6QJCkOI6g+vY=
Received: from BN0PR04CA0176.namprd04.prod.outlook.com (2603:10b6:408:eb::31)
 by SN1PR12MB2525.namprd12.prod.outlook.com (2603:10b6:802:29::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Fri, 11 Mar
 2022 09:59:02 +0000
Received: from BN8NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:eb:cafe::82) by BN0PR04CA0176.outlook.office365.com
 (2603:10b6:408:eb::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22 via Frontend
 Transport; Fri, 11 Mar 2022 09:59:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT066.mail.protection.outlook.com (10.13.177.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5061.22 via Frontend Transport; Fri, 11 Mar 2022 09:59:01 +0000
Received: from kali.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 11 Mar
 2022 03:58:58 -0600
To: <iommu@lists.linux-foundation.org>, <joro@8bytes.org>
Subject: [RFC PATCH 26/36] iommu/amd: Remove global amd_iommu_dev_table
Date: Fri, 11 Mar 2022 15:18:44 +0530
Message-ID: <20220311094854.31595-27-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220311094854.31595-1-vasant.hegde@amd.com>
References: <20220311094854.31595-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ba693266-e205-4939-f13a-08da0345c4f3
X-MS-TrafficTypeDiagnostic: SN1PR12MB2525:EE_
X-Microsoft-Antispam-PRVS: <SN1PR12MB25252DABE9D52F6FDF07811D870C9@SN1PR12MB2525.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yiv0UCBx/MtFudie3IqRWFtZmxm+W/GC2NQlgDyXSv/iCAUDN+zrKz2sm6uUr1szBbIpMHBRio7jcMBJ5MU6rGYhXVqTZDu1srKJh3GilykzqdCZYXLMZsGH/jlw0amN9aAqzRfmigq6OH/E3FRyuS3TF3oJfD5NqUZSRU6kYXRDv21D9uURLhwOGLfyR51uAjRobpUIGeX6L0qYDQ9omH2kiZLa5C/DKlaa1ucepGAZRbpdaIwUW52AI4BlGzCDPHaomHcJxjhGp74qXd9YiGQqAJ0T+EBUOT32AAgDwO9TToddyH6ZYyrdcjoetAYBggBKQv1kDDLzLVik/lAZLpyHUgUZXd0QC+RrFVHS1EkOKGSkOuVN+K8gQlRDHSD00k/YcY+BOBHUYyW/lwSTNWZtgAU80d6KOmxIDZUo5h/bNPmrS+kqH6XRJiRNlnscWNwgfuaqu2kHja2t+CW7wHyrr5k6VFepXHtHntPDbY9JUh0dykSC2CEqzSZkNWBZyUm61oaqEy56rPqo4gJ3pKdapC11rBnq4Ht2DuID1DSCRqj6ndZHS8Y6KeqXHwWB+tHk0ZhTJAIbSQVZN8ogK9LsJDWh3lu4lxMlYCS1252fF42uQJGgf0m1pH0ReiQsGKND4WvKs9IMpvJHBgAblwZvddD0L7BoWLcnZsVlwkrZvx5Pcoo518dWjBE+13GhbXFlE6NPmmCJkE9HBu3x4w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(1076003)(426003)(336012)(36860700001)(81166007)(40460700003)(4326008)(70206006)(8676002)(356005)(47076005)(44832011)(508600001)(2906002)(54906003)(86362001)(316002)(110136005)(8936002)(83380400001)(36756003)(2616005)(5660300002)(26005)(16526019)(186003)(6666004)(82310400004)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2022 09:59:01.7044 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba693266-e205-4939-f13a-08da0345c4f3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2525
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
index e36f043ad19e..ca54e7665771 100644
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
index 2e321bce6d26..9ffe27f04776 100644
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
