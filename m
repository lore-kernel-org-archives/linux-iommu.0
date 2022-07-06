Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2047.outbound.protection.outlook.com [40.107.100.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A802F3A
	for <iommu@lists.linux.dev>; Wed,  6 Jul 2022 11:44:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NV9qGoHHgqoc7Dhn0+6VgutviU7INwa9Zhu2hfm2QaxJNNzNuNXC3FXX19JVFHtcjfkFCU4CTjg0n79F5L9sr5F46OUKRkLLxLUnyr9JB9aGIYIYwVTmwt3pZfqiKbMnEEubemdI/fgpwW1mXxDE54zwyEt0bprG9zcf+VKiPQHxAmIkVlRpsED6QzdwUDtLUjFGeVgkkQk/j0XNoOn4Hv0cS/hZpX8s5zbglsNx2tFBJfk0pIFwA9CI2acYeR+PvRgqFlcaVCyQA/HB8QXL5SyHvmaKINqgtud72YX6c2/LCgmyaKAehaO2HTP0mEJjBcdA1Uoc0MANq75Hxm4eZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XX6qaQ+Se1kXrhEjpSmEUGKgmpSTf5SqsGFEXGect54=;
 b=Bt0oZokv3nN7RW+gIFRH0j1K7ScrhUiruJWMIcsAcIpyPwgzR5Nxd6W3BxYeYYWRqUYp6dA5d/F69CO3aXNrSZB/yIex0FN8f20e8RQthWI6SW1MVC9vd6UlC6tQtLmvkPRGXoImVf4v5kbWciGNp+DOsSIh1ogYcYnzDf5hgGheBo3tXbmarAim5XBVUi2Eo1qTv+kfHU558eWpnffLPnz7hwwvh9dhGCuBxU4lmfVWfCyMDfLgOLdPKcY2fVCE7ooDdpV5JXi0pv4o6CZmVCRxgOTy7ckqA02hm2LaQ5/DJlVfLZY/ujad+QY3pS2JjMq3vbPhL7dRHNA9VSjlHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XX6qaQ+Se1kXrhEjpSmEUGKgmpSTf5SqsGFEXGect54=;
 b=OHF+0fxbiuZerhmMHDGAXIypAOKNYSAKhTMzfgZy3670UlMib/y6rGT8flT2deBy44FHaG7oBv3dbQloB1ZhMYP1jxTGcEjh0n6RO6QD6MAL7FgsZMyW5s20+aMDPYQ4lfEpvVGUTLnj42eGJH4BVn7SxHq/5faJwxuTvd/mZls=
Received: from BN6PR16CA0044.namprd16.prod.outlook.com (2603:10b6:405:14::30)
 by BN8PR12MB3202.namprd12.prod.outlook.com (2603:10b6:408:9c::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.19; Wed, 6 Jul
 2022 11:44:13 +0000
Received: from BN8NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:14:cafe::e8) by BN6PR16CA0044.outlook.office365.com
 (2603:10b6:405:14::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.18 via Frontend
 Transport; Wed, 6 Jul 2022 11:44:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT006.mail.protection.outlook.com (10.13.177.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Wed, 6 Jul 2022 11:44:12 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 6 Jul
 2022 06:44:10 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <joro@8bytes.org>, <iommu@lists.linux.dev>
CC: <iommu@lists.linux-foundation.org>, <suravee.suthikulpanit@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v3 RESEND 07/35] iommu/amd: Introduce per PCI segment old_dev_tbl_cpy
Date: Wed, 6 Jul 2022 17:07:57 +0530
Message-ID: <20220706113825.25582-8-vasant.hegde@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: eb13593c-8d96-4e00-626b-08da5f44d8f0
X-MS-TrafficTypeDiagnostic: BN8PR12MB3202:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vjqKUTXNj9uvRQpDQhuXrZBfpg0VGakLyFFF6FKOmlF7euhUoKi6BKCXofut8Hp4DDuEvDFagLlfOSnMKr3HZQMzdTFySBh7gpEAErznRmVZ+ZrYYJsTUPT5qfEScqK5T5izfw9sK6z88w9C3eFvz0pZj4QOPBIunZdtoiQN1xe/pjzvcTi73QXYBLQbgYPisaBlRwzwipOExhm7X/kEIMA5zrUXT6yj03l55Uv/9CiSB1EDr8YVX0wYWwnM/Bomruz4LN7D5PeX9TJZOBU+S3Qj2pUasRpWiygHE7FLzXkuosAMgjJ2wvmsXOBqYA9QjLA2oHlQiAdDFkp96IKmw2lCQhWMYYh0WzP93x6D0Pjtywm/c//FEoxQcW/gkc6Du5OnZDfMcv1ydXU131MVNpmuH7pJHaR3m+U59evphuMqK849Ea1eAWOerl3xT5sS4Sn79mxsyPKj+1fChHVYdkL/6zr8WlneE0znAZSvfXy5AKuFbDmeAcfq8N3WtJyGgvniI9m2LNMWbz2ugIp5c81PmFjxWE9XdymLmdnT4uHHnXmqIzAbdivqcSdCy1MqXSWA1fDQqpd8IwGMG13mZ+hlJmuZ/G4gOV6ELHHJAMVHWW5FHQ+oSpk8WtzV0o0WFNTO5wUw/F8x3fNY5j9MshE+/hyB1Kd+dXTh+Bj4o6s4OrnGI73xJhViCmqqWXn72g2h+MrjAe7OSFoYojN0DXNFQZSl3G73pBZu6oV758Jgj0jOGvGGrITGr6ZFIPQS7eI5YOwdyOkDxXkx8O8vPK0zV1/wgnOLJjQ1g5D2/5YEqX/D2DqbYCPHXhUTsfatUUi1TximVjp9PBIkpfqUP5gBTyYg4VivVBDqijbTqbM8A7ZzoDJ5cZfyzcekD9UG
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(396003)(376002)(346002)(36840700001)(40470700004)(46966006)(110136005)(40480700001)(316002)(82310400005)(54906003)(36860700001)(2906002)(34020700004)(356005)(8676002)(82740400003)(70206006)(36756003)(81166007)(4326008)(70586007)(478600001)(40460700003)(7696005)(186003)(26005)(6666004)(41300700001)(16526019)(86362001)(44832011)(336012)(47076005)(2616005)(8936002)(83380400001)(426003)(1076003)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2022 11:44:12.7768
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb13593c-8d96-4e00-626b-08da5f44d8f0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3202
Message-ID: <20220706113757.wK6ZDuI37CXo95tRRrY6DS4Kv4qQy7wEc1W56gFCR_4@z>

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

It will remove global old_dev_tbl_cpy. Also update copy_device_table()
copy device table for all PCI segments.

Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |   6 ++
 drivers/iommu/amd/init.c            | 109 ++++++++++++++++------------
 2 files changed, 70 insertions(+), 45 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 5f3cc704f131..3ef68d588cc7 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -574,6 +574,12 @@ struct amd_iommu_pci_seg {
 	 * device id quickly.
 	 */
 	struct irq_remap_table **irq_lookup_table;
+
+	/*
+	 * Pointer to a device table which the content of old device table
+	 * will be copied to. It's only be used in kdump kernel.
+	 */
+	struct dev_table_entry *old_dev_tbl_cpy;
 };
 
 /*
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 509655f86851..f188130cc173 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -193,11 +193,6 @@ bool amd_iommu_force_isolation __read_mostly;
  * page table root pointer.
  */
 struct dev_table_entry *amd_iommu_dev_table;
-/*
- * Pointer to a device table which the content of old device table
- * will be copied to. It's only be used in kdump kernel.
- */
-static struct dev_table_entry *old_dev_tbl_cpy;
 
 /*
  * The alias table is a driver specific data structure which contains the
@@ -992,39 +987,27 @@ static int get_dev_entry_bit(u16 devid, u8 bit)
 }
 
 
-static bool copy_device_table(void)
+static bool __copy_device_table(struct amd_iommu *iommu)
 {
-	u64 int_ctl, int_tab_len, entry = 0, last_entry = 0;
+	u64 int_ctl, int_tab_len, entry = 0;
+	struct amd_iommu_pci_seg *pci_seg = iommu->pci_seg;
 	struct dev_table_entry *old_devtb = NULL;
 	u32 lo, hi, devid, old_devtb_size;
 	phys_addr_t old_devtb_phys;
-	struct amd_iommu *iommu;
 	u16 dom_id, dte_v, irq_v;
 	gfp_t gfp_flag;
 	u64 tmp;
 
-	if (!amd_iommu_pre_enabled)
-		return false;
-
-	pr_warn("Translation is already enabled - trying to copy translation structures\n");
-	for_each_iommu(iommu) {
-		/* All IOMMUs should use the same device table with the same size */
-		lo = readl(iommu->mmio_base + MMIO_DEV_TABLE_OFFSET);
-		hi = readl(iommu->mmio_base + MMIO_DEV_TABLE_OFFSET + 4);
-		entry = (((u64) hi) << 32) + lo;
-		if (last_entry && last_entry != entry) {
-			pr_err("IOMMU:%d should use the same dev table as others!\n",
-				iommu->index);
-			return false;
-		}
-		last_entry = entry;
+	/* Each IOMMU use separate device table with the same size */
+	lo = readl(iommu->mmio_base + MMIO_DEV_TABLE_OFFSET);
+	hi = readl(iommu->mmio_base + MMIO_DEV_TABLE_OFFSET + 4);
+	entry = (((u64) hi) << 32) + lo;
 
-		old_devtb_size = ((entry & ~PAGE_MASK) + 1) << 12;
-		if (old_devtb_size != dev_table_size) {
-			pr_err("The device table size of IOMMU:%d is not expected!\n",
-				iommu->index);
-			return false;
-		}
+	old_devtb_size = ((entry & ~PAGE_MASK) + 1) << 12;
+	if (old_devtb_size != dev_table_size) {
+		pr_err("The device table size of IOMMU:%d is not expected!\n",
+			iommu->index);
+		return false;
 	}
 
 	/*
@@ -1047,31 +1030,31 @@ static bool copy_device_table(void)
 		return false;
 
 	gfp_flag = GFP_KERNEL | __GFP_ZERO | GFP_DMA32;
-	old_dev_tbl_cpy = (void *)__get_free_pages(gfp_flag,
-				get_order(dev_table_size));
-	if (old_dev_tbl_cpy == NULL) {
+	pci_seg->old_dev_tbl_cpy = (void *)__get_free_pages(gfp_flag,
+						    get_order(dev_table_size));
+	if (pci_seg->old_dev_tbl_cpy == NULL) {
 		pr_err("Failed to allocate memory for copying old device table!\n");
 		memunmap(old_devtb);
 		return false;
 	}
 
 	for (devid = 0; devid <= amd_iommu_last_bdf; ++devid) {
-		old_dev_tbl_cpy[devid] = old_devtb[devid];
+		pci_seg->old_dev_tbl_cpy[devid] = old_devtb[devid];
 		dom_id = old_devtb[devid].data[1] & DEV_DOMID_MASK;
 		dte_v = old_devtb[devid].data[0] & DTE_FLAG_V;
 
 		if (dte_v && dom_id) {
-			old_dev_tbl_cpy[devid].data[0] = old_devtb[devid].data[0];
-			old_dev_tbl_cpy[devid].data[1] = old_devtb[devid].data[1];
+			pci_seg->old_dev_tbl_cpy[devid].data[0] = old_devtb[devid].data[0];
+			pci_seg->old_dev_tbl_cpy[devid].data[1] = old_devtb[devid].data[1];
 			__set_bit(dom_id, amd_iommu_pd_alloc_bitmap);
 			/* If gcr3 table existed, mask it out */
 			if (old_devtb[devid].data[0] & DTE_FLAG_GV) {
 				tmp = DTE_GCR3_VAL_B(~0ULL) << DTE_GCR3_SHIFT_B;
 				tmp |= DTE_GCR3_VAL_C(~0ULL) << DTE_GCR3_SHIFT_C;
-				old_dev_tbl_cpy[devid].data[1] &= ~tmp;
+				pci_seg->old_dev_tbl_cpy[devid].data[1] &= ~tmp;
 				tmp = DTE_GCR3_VAL_A(~0ULL) << DTE_GCR3_SHIFT_A;
 				tmp |= DTE_FLAG_GV;
-				old_dev_tbl_cpy[devid].data[0] &= ~tmp;
+				pci_seg->old_dev_tbl_cpy[devid].data[0] &= ~tmp;
 			}
 		}
 
@@ -1086,7 +1069,7 @@ static bool copy_device_table(void)
 				return false;
 			}
 
-		        old_dev_tbl_cpy[devid].data[2] = old_devtb[devid].data[2];
+			pci_seg->old_dev_tbl_cpy[devid].data[2] = old_devtb[devid].data[2];
 		}
 	}
 	memunmap(old_devtb);
@@ -1094,6 +1077,33 @@ static bool copy_device_table(void)
 	return true;
 }
 
+static bool copy_device_table(void)
+{
+	struct amd_iommu *iommu;
+	struct amd_iommu_pci_seg *pci_seg;
+
+	if (!amd_iommu_pre_enabled)
+		return false;
+
+	pr_warn("Translation is already enabled - trying to copy translation structures\n");
+
+	/*
+	 * All IOMMUs within PCI segment shares common device table.
+	 * Hence copy device table only once per PCI segment.
+	 */
+	for_each_pci_segment(pci_seg) {
+		for_each_iommu(iommu) {
+			if (pci_seg->id != iommu->pci_seg->id)
+				continue;
+			if (!__copy_device_table(iommu))
+				return false;
+			break;
+		}
+	}
+
+	return true;
+}
+
 void amd_iommu_apply_erratum_63(u16 devid)
 {
 	int sysmgt;
@@ -2588,7 +2598,7 @@ static void early_enable_iommu(struct amd_iommu *iommu)
 static void early_enable_iommus(void)
 {
 	struct amd_iommu *iommu;
-
+	struct amd_iommu_pci_seg *pci_seg;
 
 	if (!copy_device_table()) {
 		/*
@@ -2598,9 +2608,14 @@ static void early_enable_iommus(void)
 		 */
 		if (amd_iommu_pre_enabled)
 			pr_err("Failed to copy DEV table from previous kernel.\n");
-		if (old_dev_tbl_cpy != NULL)
-			free_pages((unsigned long)old_dev_tbl_cpy,
-					get_order(dev_table_size));
+
+		for_each_pci_segment(pci_seg) {
+			if (pci_seg->old_dev_tbl_cpy != NULL) {
+				free_pages((unsigned long)pci_seg->old_dev_tbl_cpy,
+						get_order(dev_table_size));
+				pci_seg->old_dev_tbl_cpy = NULL;
+			}
+		}
 
 		for_each_iommu(iommu) {
 			clear_translation_pre_enabled(iommu);
@@ -2608,9 +2623,13 @@ static void early_enable_iommus(void)
 		}
 	} else {
 		pr_info("Copied DEV table from previous kernel.\n");
-		free_pages((unsigned long)amd_iommu_dev_table,
-				get_order(dev_table_size));
-		amd_iommu_dev_table = old_dev_tbl_cpy;
+
+		for_each_pci_segment(pci_seg) {
+			free_pages((unsigned long)pci_seg->dev_table,
+				   get_order(dev_table_size));
+			pci_seg->dev_table = pci_seg->old_dev_tbl_cpy;
+		}
+
 		for_each_iommu(iommu) {
 			iommu_disable_command_buffer(iommu);
 			iommu_disable_event_buffer(iommu);
-- 
2.31.1

