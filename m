Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8A40C433EF
	for <iommu@archiver.kernel.org>; Wed, 11 May 2022 07:29:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9A3836080B;
	Wed, 11 May 2022 07:29:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FnN3z91cOxA5; Wed, 11 May 2022 07:29:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 1B49F60BA3;
	Wed, 11 May 2022 07:29:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 04A2AC0039;
	Wed, 11 May 2022 07:29:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E9E43C002D
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 07:29:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C930941886
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 07:29:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fkUGqXLVm-2Z for <iommu@lists.linux-foundation.org>;
 Wed, 11 May 2022 07:29:07 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on20608.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8b::608])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5594041883
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 07:29:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bwVjKIlFqe46keUCicMjRwbiPLSZ5vKZI7cw+8DAkYz6sWtHoncZXbeIEURqg2OhouAOseBbapCzq0NzOxFue65YYyN2np5YXDNAnTFL4NqTq36b6wXBGnj2YKADvCpp54J5ULOUaoKLqyx21TyI5GMb1qP9orkqTYDu2cnCAz8dPfi800ZdHkkJS0Gl/lNbwHz8EV61M+y5bI8jmCMtzqzCOWQId4bcFuPrP80ZHYysvuRaaPz4J8U7n52KodKwatlgejIfd5qgJueZprtwaIXsofEG21cSgtWks9Z9pHgsaq/4q8+OkooeGSaHc5QZxeVhxVWrXfN8h8OwrI42Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZiM8fHwSpci3C5gTiHXNJfHCR01s1lfYgx0r9ZANJGM=;
 b=OoZJH033px8ga9MhPa5o+9Vcm7gPksxzTWohwmNEffUxi9t2pqv2AtLXiByFu/1BNYzTSRG9Gf9kMqO0vT4lRP/4vxltTpwm0TZDgc7WMBd/TYDYwNPwrH0UiTLH0ENABWgl4Qzo0Fe+b2pq3foqv9cAKsUQkPxTlGgk9Gvv4TJ+DxOreowlb1TAY8r4T5XwxH/T9iU+yk+KlIn3M+gAiNYTR9aYOASVveTa8PYTmqgK0EzpU6hAccS6DXFnJUx8gfn+6nkuGTlNoChpdFAwus54HAJEY9EMTErLwH4C7gs//frKfdmywncRvXKvQzrMjr6LjxEcx3/larZojdE8Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZiM8fHwSpci3C5gTiHXNJfHCR01s1lfYgx0r9ZANJGM=;
 b=wedp5gaNXukXAbzO0t/79QOSug/6920cfW5LW0KhQAJ93D8NE8ZXAFgWje0hq4aL2E7UMgQxvFjntsistx45JroGV/VAOyKoZlvhONCulJ9n3yc5OzKZAG1OeHnUpunOH1bQ7slhzrg+pSm15p+CfjLjgAkB7WaZH73i0NV63ZE=
Received: from DS7PR07CA0018.namprd07.prod.outlook.com (2603:10b6:5:3af::27)
 by BN6PR12MB1729.namprd12.prod.outlook.com (2603:10b6:404:108::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22; Wed, 11 May
 2022 07:29:03 +0000
Received: from DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3af:cafe::29) by DS7PR07CA0018.outlook.office365.com
 (2603:10b6:5:3af::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13 via Frontend
 Transport; Wed, 11 May 2022 07:29:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT028.mail.protection.outlook.com (10.13.173.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5250.13 via Frontend Transport; Wed, 11 May 2022 07:29:03 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 11 May
 2022 02:29:01 -0500
To: <iommu@lists.linux-foundation.org>
Subject: [PATCH v3 27/35] iommu/amd: Remove global
 amd_iommu_[dev_table/alias_table/last_bdf]
Date: Wed, 11 May 2022 12:51:33 +0530
Message-ID: <20220511072141.15485-28-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220511072141.15485-1-vasant.hegde@amd.com>
References: <20220511072141.15485-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 037702ab-9822-4ab7-35d1-08da331fecd4
X-MS-TrafficTypeDiagnostic: BN6PR12MB1729:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB172907AEE09D18189FBA526C87C89@BN6PR12MB1729.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D69DrxnZrV/msSCmB2FYnHcVZHSWW751g8sXyiacJC22xZsv9fbKQnu6xSR5ffpP76cil3W70YOB1aGMTppyAmAmxMV5e/Pf00JfqZfyyDyW8A5B/sX8Vs5vuMbQ37V9pOczVOVmOfX54E9hvk57FKMg0O3Ohcm4ARwoEmEU+0kmK8Yf7ztYMh/BOEDuVYJjM6AtHbD5ioUC8e29Q0VoXYmOuDbQ/5IX/UF5kTu93pHkG0Aks04zFZsXAEVf9NmkJbiZYeflMImxg0ESposzOEz9GHahz++B6wcW6JkxMIJq3ij5JyLnRQ8tNrR60XpUeoiDbl7GfidMHeD1VsHacR9e/FS2Vq7xGEcc6tVAjfUM2g9U1eFbbDITq6NU28OwUH9ZsDfHP0kfwoJDN/Ps3t3/17oYtV2XcE/46qr1y7GSbOW7ijjyeVVQPU85pdiPgF48d4JmxNRLl0IRMypLHmQ+dD4b6QTLB+rCDfobUCO985DFocnE+Ijy6MXLeV/cOZGLEKHEm9b45G9HSbvRF9c3VSfmQILy34CB8za58nczbzUsLlD+askYrE8wFDvnd5tqAtcB1a6Up6neXmU2Z1OLIA5syQFdza/5/75MKnQBrwaJZx7/yCFvXUDvl13Uzxv5cwHn7NnEEceV3bJ3CCZgEM+4ipkrlZPDgkXFTS45ay4shECELghnT4/YBZWxqSh3rIxuxefseojYFmY5+g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(36860700001)(54906003)(8936002)(86362001)(6916009)(7696005)(30864003)(81166007)(44832011)(316002)(5660300002)(36756003)(508600001)(70586007)(336012)(426003)(40460700003)(8676002)(2906002)(82310400005)(4326008)(70206006)(6666004)(47076005)(356005)(83380400001)(186003)(2616005)(16526019)(26005)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 07:29:03.5585 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 037702ab-9822-4ab7-35d1-08da331fecd4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1729
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

Replace them with per PCI segment device table.
Also remove dev_table_size, alias_table_size, amd_iommu_last_bdf
variables.

Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h | 15 -----
 drivers/iommu/amd/init.c            | 89 +++++------------------------
 drivers/iommu/amd/iommu.c           | 18 ++++--
 3 files changed, 27 insertions(+), 95 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index ddd606daa653..dfb1f2055f0c 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -830,24 +830,9 @@ struct unity_map_entry {
  * Data structures for device handling
  */
 
-/*
- * Device table used by hardware. Read and write accesses by software are
- * locked with the amd_iommu_pd_table lock.
- */
-extern struct dev_table_entry *amd_iommu_dev_table;
-
-/*
- * Alias table to find requestor ids to device ids. Not locked because only
- * read on runtime.
- */
-extern u16 *amd_iommu_alias_table;
-
 /* size of the dma_ops aperture as power of 2 */
 extern unsigned amd_iommu_aperture_order;
 
-/* largest PCI device id we expect translation requests for */
-extern u16 amd_iommu_last_bdf;
-
 /* allocation bitmap for domain ids */
 extern unsigned long *amd_iommu_pd_alloc_bitmap;
 
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 2cdce8a3b86e..7c81e733a3ac 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -161,9 +161,6 @@ static bool amd_iommu_disabled __initdata;
 static bool amd_iommu_force_enable __initdata;
 static int amd_iommu_target_ivhd_type;
 
-u16 amd_iommu_last_bdf;			/* largest PCI device id we have
-					   to handle */
-
 LIST_HEAD(amd_iommu_pci_seg_list);	/* list of all PCI segments */
 LIST_HEAD(amd_iommu_list);		/* list of all AMD IOMMUs in the
 					   system */
@@ -185,30 +182,12 @@ static bool amd_iommu_pc_present __read_mostly;
 
 bool amd_iommu_force_isolation __read_mostly;
 
-/*
- * Pointer to the device table which is shared by all AMD IOMMUs
- * it is indexed by the PCI device id or the HT unit id and contains
- * information about the domain the device belongs to as well as the
- * page table root pointer.
- */
-struct dev_table_entry *amd_iommu_dev_table;
-
-/*
- * The alias table is a driver specific data structure which contains the
- * mappings of the PCI device ids to the actual requestor ids on the IOMMU.
- * More than one device can share the same requestor id.
- */
-u16 *amd_iommu_alias_table;
-
 /*
  * AMD IOMMU allows up to 2^16 different protection domains. This is a bitmap
  * to know which ones are already in use.
  */
 unsigned long *amd_iommu_pd_alloc_bitmap;
 
-static u32 dev_table_size;	/* size of the device table */
-static u32 alias_table_size;	/* size of the alias table */
-
 enum iommu_init_state {
 	IOMMU_START_STATE,
 	IOMMU_IVRS_DETECTED,
@@ -263,16 +242,10 @@ static void init_translation_status(struct amd_iommu *iommu)
 		iommu->flags |= AMD_IOMMU_FLAG_TRANS_PRE_ENABLED;
 }
 
-static inline void update_last_devid(u16 devid)
-{
-	if (devid > amd_iommu_last_bdf)
-		amd_iommu_last_bdf = devid;
-}
-
-static inline unsigned long tbl_size(int entry_size)
+static inline unsigned long tbl_size(int entry_size, int last_bdf)
 {
 	unsigned shift = PAGE_SHIFT +
-			 get_order(((int)amd_iommu_last_bdf + 1) * entry_size);
+			 get_order((last_bdf + 1) * entry_size);
 
 	return 1UL << shift;
 }
@@ -402,10 +375,11 @@ static void iommu_set_device_table(struct amd_iommu *iommu)
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
@@ -555,14 +529,12 @@ static int __init find_last_devid_from_ivhd(struct ivhd_header *h)
 		switch (dev->type) {
 		case IVHD_DEV_ALL:
 			/* Use maximum BDF value for DEV_ALL */
-			update_last_devid(0xffff);
 			return 0xffff;
 		case IVHD_DEV_SELECT:
 		case IVHD_DEV_RANGE_END:
 		case IVHD_DEV_ALIAS:
 		case IVHD_DEV_EXT_SELECT:
 			/* all the above subfield types refer to device ids */
-			update_last_devid(dev->devid);
 			if (dev->devid > last_devid)
 				last_devid = dev->devid;
 			break;
@@ -704,7 +676,7 @@ static int __init alloc_alias_table(struct amd_iommu_pci_seg *pci_seg)
 	/*
 	 * let all alias entries point to itself
 	 */
-	for (i = 0; i <= amd_iommu_last_bdf; ++i)
+	for (i = 0; i <= pci_seg->last_bdf; ++i)
 		pci_seg->alias_table[i] = i;
 
 	return 0;
@@ -1070,7 +1042,7 @@ static bool __copy_device_table(struct amd_iommu *iommu)
 		return false;
 	}
 
-	for (devid = 0; devid <= amd_iommu_last_bdf; ++devid) {
+	for (devid = 0; devid <= pci_seg->last_bdf; ++devid) {
 		pci_seg->old_dev_tbl_cpy[devid] = old_devtb[devid];
 		dom_id = old_devtb[devid].data[1] & DEV_DOMID_MASK;
 		dte_v = old_devtb[devid].data[0] & DTE_FLAG_V;
@@ -1147,12 +1119,6 @@ void amd_iommu_apply_erratum_63(struct amd_iommu *iommu, u16 devid)
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
@@ -1177,7 +1143,7 @@ static void __init set_dev_entry_from_acpi(struct amd_iommu *iommu,
 
 	amd_iommu_apply_erratum_63(iommu, devid);
 
-	set_iommu_for_device(iommu, devid);
+	amd_iommu_set_rlookup_table(iommu, devid);
 }
 
 int __init add_special_device(u8 type, u8 id, u16 *devid, bool cmd_line)
@@ -1337,7 +1303,7 @@ static int __init init_iommu_from_acpi(struct amd_iommu *iommu,
 
 			DUMP_printk("  DEV_ALL\t\t\tflags: %02x\n", e->flags);
 
-			for (dev_i = 0; dev_i <= amd_iommu_last_bdf; ++dev_i)
+			for (dev_i = 0; dev_i <= pci_seg->last_bdf; ++dev_i)
 				set_dev_entry_from_acpi(iommu, dev_i, e->flags, 0);
 			break;
 		case IVHD_DEV_SELECT:
@@ -1582,9 +1548,9 @@ static struct amd_iommu_pci_seg *__init alloc_pci_segment(u16 id,
 
 	pci_seg->last_bdf = last_bdf;
 	DUMP_printk("PCI segment : 0x%0x, last bdf : 0x%04x\n", id, last_bdf);
-	pci_seg->dev_table_size     = tbl_size(DEV_TABLE_ENTRY_SIZE);
-	pci_seg->alias_table_size   = tbl_size(ALIAS_TABLE_ENTRY_SIZE);
-	pci_seg->rlookup_table_size = tbl_size(RLOOKUP_TABLE_ENTRY_SIZE);
+	pci_seg->dev_table_size     = tbl_size(DEV_TABLE_ENTRY_SIZE, last_bdf);
+	pci_seg->alias_table_size   = tbl_size(ALIAS_TABLE_ENTRY_SIZE, last_bdf);
+	pci_seg->rlookup_table_size = tbl_size(RLOOKUP_TABLE_ENTRY_SIZE, last_bdf);
 
 	pci_seg->id = id;
 	init_llist_head(&pci_seg->dev_data_list);
@@ -2465,7 +2431,7 @@ static int __init init_unity_map_range(struct ivmd_header *m,
 	case ACPI_IVMD_TYPE_ALL:
 		s = "IVMD_TYPE_ALL\t\t";
 		e->devid_start = 0;
-		e->devid_end = amd_iommu_last_bdf;
+		e->devid_end = pci_seg->last_bdf;
 		break;
 	case ACPI_IVMD_TYPE_RANGE:
 		s = "IVMD_TYPE_RANGE\t\t";
@@ -2532,7 +2498,7 @@ static void init_device_table_dma(struct amd_iommu_pci_seg *pci_seg)
 	if (dev_table == NULL)
 		return;
 
-	for (devid = 0; devid <= amd_iommu_last_bdf; ++devid) {
+	for (devid = 0; devid <= pci_seg->last_bdf; ++devid) {
 		__set_dev_entry_bit(dev_table, devid, DEV_ENTRY_VALID);
 		__set_dev_entry_bit(dev_table, devid, DEV_ENTRY_TRANSLATION);
 	}
@@ -2546,7 +2512,7 @@ static void __init uninit_device_table_dma(struct amd_iommu_pci_seg *pci_seg)
 	if (dev_table == NULL)
 		return;
 
-	for (devid = 0; devid <= amd_iommu_last_bdf; ++devid) {
+	for (devid = 0; devid <= pci_seg->last_bdf; ++devid) {
 		dev_table[devid].data[0] = 0ULL;
 		dev_table[devid].data[1] = 0ULL;
 	}
@@ -2561,7 +2527,7 @@ static void init_device_table(void)
 		return;
 
 	for_each_pci_segment(pci_seg) {
-		for (devid = 0; devid <= amd_iommu_last_bdf; ++devid)
+		for (devid = 0; devid <= pci_seg->last_bdf; ++devid)
 			__set_dev_entry_bit(pci_seg->dev_table,
 					    devid, DEV_ENTRY_IRQ_TBL_EN);
 	}
@@ -2804,14 +2770,6 @@ static void __init free_iommu_resources(void)
 	kmem_cache_destroy(amd_iommu_irq_cache);
 	amd_iommu_irq_cache = NULL;
 
-	free_pages((unsigned long)amd_iommu_alias_table,
-		   get_order(alias_table_size));
-	amd_iommu_alias_table = NULL;
-
-	free_pages((unsigned long)amd_iommu_dev_table,
-		   get_order(dev_table_size));
-	amd_iommu_dev_table = NULL;
-
 	free_iommu_all();
 	free_pci_segments();
 }
@@ -2940,25 +2898,8 @@ static int __init early_amd_iommu_init(void)
 	amd_iommu_target_ivhd_type = get_highest_supported_ivhd_type(ivrs_base);
 	DUMP_printk("Using IVHD type %#x\n", amd_iommu_target_ivhd_type);
 
-	dev_table_size     = tbl_size(DEV_TABLE_ENTRY_SIZE);
-	alias_table_size   = tbl_size(ALIAS_TABLE_ENTRY_SIZE);
-
 	/* Device table - directly used by all IOMMUs */
 	ret = -ENOMEM;
-	amd_iommu_dev_table = (void *)__get_free_pages(
-				      GFP_KERNEL | __GFP_ZERO | GFP_DMA32,
-				      get_order(dev_table_size));
-	if (amd_iommu_dev_table == NULL)
-		goto out;
-
-	/*
-	 * Alias table - map PCI Bus/Dev/Func to Bus/Dev/Func the
-	 * IOMMU see for that device
-	 */
-	amd_iommu_alias_table = (void *)__get_free_pages(GFP_KERNEL,
-			get_order(alias_table_size));
-	if (amd_iommu_alias_table == NULL)
-		goto out;
 
 	amd_iommu_pd_alloc_bitmap = (void *)__get_free_pages(
 					    GFP_KERNEL | __GFP_ZERO,
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 5361cc1f8b6b..c21346e48bcd 100644
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
@@ -356,6 +358,8 @@ static bool pci_iommuv2_capable(struct pci_dev *pdev)
  */
 static bool check_device(struct device *dev)
 {
+	struct amd_iommu_pci_seg *pci_seg;
+	struct amd_iommu *iommu;
 	int devid;
 
 	if (!dev)
@@ -365,11 +369,13 @@ static bool check_device(struct device *dev)
 	if (devid < 0)
 		return false;
 
-	/* Out of our scope? */
-	if (devid > amd_iommu_last_bdf)
+	iommu = rlookup_amd_iommu(dev);
+	if (!iommu)
 		return false;
 
-	if (rlookup_amd_iommu(dev) == NULL)
+	/* Out of our scope? */
+	pci_seg = iommu->pci_seg;
+	if ((devid & 0xffff) > pci_seg->last_bdf)
 		return false;
 
 	return true;
-- 
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
