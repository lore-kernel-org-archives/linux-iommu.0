Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2056.outbound.protection.outlook.com [40.107.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA0A33C6
	for <iommu@lists.linux.dev>; Wed,  6 Jul 2022 11:49:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mLMWqTlMUf9IdvjgNRUDjebqj4zwd9BmHR0Q+wfmxEaYO60ugiWOBu1x53BWbrsb2/1Wjivz7GWHwR4fcbSyVaBNbE50eV6UQiLWyvkTe93H1WJTl/3L/ugPRoRhnSB1605/oxEE6rARkiJyv5KkpVHTdDmPJ/URLoRQ6eSzTyc/99Ku7eBNXIxAGeI+A7hpGgEiwut9uG9LmltGW8eMONWpZRSdzNUEEEYyFecgonsWyD/Ls7nZ7ihM/28J6WIDmuNyctqSPxwWPn8nuSEcnekCfS1r2oNQ+SSM1bcI5496vyciOkW1d/fLtxxMh0fwoQq2K0f1tFz6hb+r/h1bFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UjHuVS+rdmHv+rY6/Lz4qWHA03F4DKGFmLR5tfp4LHE=;
 b=cMrrhuPHuWTA8k/sy9D2U+aqiGcDBdyE2Q8F9B+kcuDjxZkoPoL/oDz6K2nQxmrKmEb0zVB4horyMtN14JfPX1Tsx7r/5RCTPfRXymAPpni5lXNQ2uBdosTNVFcfsh+0XSRb8EyAtg6LqWoZkNAJ9yVot30NXno1AZF0z2KE940BhmVKr8Cws9V4keypPngvGofm13712Qnq3OfutLAEfeN9PAP4mHC7BXRg0NnjCVPEZGwb53gpbBKM6mDSUOJ5Cw/IQSnea+3J2snJVt3Sf8o1iHwLVboF/Z0xfyNjBTC93shCgFIAwd55kxRPxy38XaYEZsptCZjPeZIdTDfcOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UjHuVS+rdmHv+rY6/Lz4qWHA03F4DKGFmLR5tfp4LHE=;
 b=y7UETqUa8sm9/NyOBIEhzfZiTVyWexlKBRATzt3X0GsexgaQYZQAs0Fw17gCg0V5i0O1EH7pHOjEutcreZ703p8QvoowzPl4fHaoOFGzzo6ssDybi5kVefdglqKtz6O2vfb/fZvNBkptBuuAJYymkzz3oqckVq6pfXrX/VJ72+Y=
Received: from CO1PR15CA0096.namprd15.prod.outlook.com (2603:10b6:101:21::16)
 by MW4PR12MB5602.namprd12.prod.outlook.com (2603:10b6:303:169::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.22; Wed, 6 Jul
 2022 11:49:19 +0000
Received: from CO1NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:101:21:cafe::6b) by CO1PR15CA0096.outlook.office365.com
 (2603:10b6:101:21::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.15 via Frontend
 Transport; Wed, 6 Jul 2022 11:49:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT012.mail.protection.outlook.com (10.13.175.192) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Wed, 6 Jul 2022 11:49:18 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 6 Jul
 2022 06:49:16 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <joro@8bytes.org>, <iommu@lists.linux.dev>
CC: <iommu@lists.linux-foundation.org>, <suravee.suthikulpanit@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v3 RESEND 27/35] iommu/amd: Remove global amd_iommu_[dev_table/alias_table/last_bdf]
Date: Wed, 6 Jul 2022 17:08:17 +0530
Message-ID: <20220706113825.25582-28-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220706113825.25582-1-vasant.hegde@amd.com>
References: <20220706113825.25582-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: facd3d82-7f15-47e9-1fd4-08da5f458f7a
X-MS-TrafficTypeDiagnostic: MW4PR12MB5602:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tsYGFaH7lV1+cNXhWCsc+MzIUaMWqvPHVxJZgQNKXLGraoRGrD23X+NeRar75ueb2Scm2ZI0SpzheOzNNI7D1XYsk6Rn4cJaWtIVa1ERugUk40p2GB+teh+Av3pcQA8Qde0sfyklOH0RbfCZDrpcO0triugQzQxzAHK1mStJ/BOrJNuPgIJvb1eT3aV4/13pKSALEFiVdVAb60uSemGpHs1PkbZb8dOC2/UBvtOp4xvH0Xi9D2KXGuuqGw8sOWJ3pAUvSf2HfVHUgMHsZuOykEOPjFWxyKXgkPP29dELfvuP2qIlQ3oPc1I41nuJJsi2AacAVY7TeH2anlZsYSQRbmIvYsQyM3bN8Hs5PkR7bTptPZrD7I42pfymj1+WyEbRlQIIe6Dn9JCX/0liOnIHa1nkYNhqc3AjNeV5Q9mf+/ByCAl8z+7SamJJrhtEUwmyxsWapPmkGwURcUiCzhkLZbnRqXkS5OaxFd1XQWus1GoIPpULwMoGY5Qsr2lynwiIbsOoJ4Eqvr5uoT701aF1toHW0lqgOmW+TQ3JRmgwbw7ZxVYbA8olpYHZdbyBsGqFqIhZbUevd/2yscmR5U7aSJOE/UeosIoba5xSfLxkcQyam0+V7Ele1BmbP1BRxXs95NT1IC4fr8zqdJ25N78D8GVl9SeP2WHH2vRk0R++GsjS7PMDlCx+dgnX14pwnTbLl8q32G9AgNcls1AFKAz6Qg794vPegX/ecNbPuUZXglYM0uEpkQnMcD46NRr8wJEWTR52VMuv41qigXt4xc1rhe0RqJa+L5R7yDBGOSLxAYy/G98EMTChs9u+y42oDT2isNZg9dwzTD4VUJpq4alg7MzK84ijhFP60lXhPfz9EAos9w2Tvv4E8FRUs6+xfTlr
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(376002)(136003)(346002)(396003)(40470700004)(36840700001)(46966006)(81166007)(40480700001)(356005)(82740400003)(36860700001)(2616005)(186003)(1076003)(47076005)(426003)(336012)(16526019)(30864003)(2906002)(44832011)(8936002)(5660300002)(36756003)(316002)(70586007)(70206006)(54906003)(8676002)(478600001)(4326008)(82310400005)(7696005)(41300700001)(26005)(34020700004)(40460700003)(110136005)(86362001)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2022 11:49:18.8842
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: facd3d82-7f15-47e9-1fd4-08da5f458f7a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5602
Message-ID: <20220706113817.9cybVKdWEVjr9FiABos3BTeOD74JZfi20HmmzmPe3nI@z>

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
index d932c90329e4..65b02e2ae28f 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -834,24 +834,9 @@ struct unity_map_entry {
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
index 508959182c7f..df8f4b9d20cd 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -160,9 +160,6 @@ static bool amd_iommu_disabled __initdata;
 static bool amd_iommu_force_enable __initdata;
 static int amd_iommu_target_ivhd_type;
 
-u16 amd_iommu_last_bdf;			/* largest PCI device id we have
-					   to handle */
-
 LIST_HEAD(amd_iommu_pci_seg_list);	/* list of all PCI segments */
 LIST_HEAD(amd_iommu_list);		/* list of all AMD IOMMUs in the
 					   system */
@@ -185,30 +182,12 @@ bool amdr_ivrs_remap_support __read_mostly;
 
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
@@ -404,10 +377,11 @@ static void iommu_set_device_table(struct amd_iommu *iommu)
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
@@ -557,14 +531,12 @@ static int __init find_last_devid_from_ivhd(struct ivhd_header *h)
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
@@ -706,7 +678,7 @@ static int __init alloc_alias_table(struct amd_iommu_pci_seg *pci_seg)
 	/*
 	 * let all alias entries point to itself
 	 */
-	for (i = 0; i <= amd_iommu_last_bdf; ++i)
+	for (i = 0; i <= pci_seg->last_bdf; ++i)
 		pci_seg->alias_table[i] = i;
 
 	return 0;
@@ -1072,7 +1044,7 @@ static bool __copy_device_table(struct amd_iommu *iommu)
 		return false;
 	}
 
-	for (devid = 0; devid <= amd_iommu_last_bdf; ++devid) {
+	for (devid = 0; devid <= pci_seg->last_bdf; ++devid) {
 		pci_seg->old_dev_tbl_cpy[devid] = old_devtb[devid];
 		dom_id = old_devtb[devid].data[1] & DEV_DOMID_MASK;
 		dte_v = old_devtb[devid].data[0] & DTE_FLAG_V;
@@ -1149,12 +1121,6 @@ void amd_iommu_apply_erratum_63(struct amd_iommu *iommu, u16 devid)
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
@@ -1179,7 +1145,7 @@ static void __init set_dev_entry_from_acpi(struct amd_iommu *iommu,
 
 	amd_iommu_apply_erratum_63(iommu, devid);
 
-	set_iommu_for_device(iommu, devid);
+	amd_iommu_set_rlookup_table(iommu, devid);
 }
 
 int __init add_special_device(u8 type, u8 id, u16 *devid, bool cmd_line)
@@ -1339,7 +1305,7 @@ static int __init init_iommu_from_acpi(struct amd_iommu *iommu,
 
 			DUMP_printk("  DEV_ALL\t\t\tflags: %02x\n", e->flags);
 
-			for (dev_i = 0; dev_i <= amd_iommu_last_bdf; ++dev_i)
+			for (dev_i = 0; dev_i <= pci_seg->last_bdf; ++dev_i)
 				set_dev_entry_from_acpi(iommu, dev_i, e->flags, 0);
 			break;
 		case IVHD_DEV_SELECT:
@@ -1584,9 +1550,9 @@ static struct amd_iommu_pci_seg *__init alloc_pci_segment(u16 id,
 
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
@@ -2466,7 +2432,7 @@ static int __init init_unity_map_range(struct ivmd_header *m,
 	case ACPI_IVMD_TYPE_ALL:
 		s = "IVMD_TYPE_ALL\t\t";
 		e->devid_start = 0;
-		e->devid_end = amd_iommu_last_bdf;
+		e->devid_end = pci_seg->last_bdf;
 		break;
 	case ACPI_IVMD_TYPE_RANGE:
 		s = "IVMD_TYPE_RANGE\t\t";
@@ -2533,7 +2499,7 @@ static void init_device_table_dma(struct amd_iommu_pci_seg *pci_seg)
 	if (dev_table == NULL)
 		return;
 
-	for (devid = 0; devid <= amd_iommu_last_bdf; ++devid) {
+	for (devid = 0; devid <= pci_seg->last_bdf; ++devid) {
 		__set_dev_entry_bit(dev_table, devid, DEV_ENTRY_VALID);
 		__set_dev_entry_bit(dev_table, devid, DEV_ENTRY_TRANSLATION);
 	}
@@ -2547,7 +2513,7 @@ static void __init uninit_device_table_dma(struct amd_iommu_pci_seg *pci_seg)
 	if (dev_table == NULL)
 		return;
 
-	for (devid = 0; devid <= amd_iommu_last_bdf; ++devid) {
+	for (devid = 0; devid <= pci_seg->last_bdf; ++devid) {
 		dev_table[devid].data[0] = 0ULL;
 		dev_table[devid].data[1] = 0ULL;
 	}
@@ -2562,7 +2528,7 @@ static void init_device_table(void)
 		return;
 
 	for_each_pci_segment(pci_seg) {
-		for (devid = 0; devid <= amd_iommu_last_bdf; ++devid)
+		for (devid = 0; devid <= pci_seg->last_bdf; ++devid)
 			__set_dev_entry_bit(pci_seg->dev_table,
 					    devid, DEV_ENTRY_IRQ_TBL_EN);
 	}
@@ -2805,14 +2771,6 @@ static void __init free_iommu_resources(void)
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
@@ -2941,25 +2899,8 @@ static int __init early_amd_iommu_init(void)
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
index 7d431a0b80e5..94ebffe15960 100644
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
2.31.1

