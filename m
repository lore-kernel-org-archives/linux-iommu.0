Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2063.outbound.protection.outlook.com [40.107.212.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5C32F3A
	for <iommu@lists.linux.dev>; Wed,  6 Jul 2022 11:45:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j9B6HtnBNnyOABD5IGDB8e0J1uLjkuoOotntOc40b7dcClNk8SNfPwlTPBO5J2PlrnSUimas8KEOwH/an6lvv1KeJVBRXywsoI34cOEWQfkLTfnFR1B0/yW2WH/nIiecSLaq2r7cNZNn4K/JYyyS+9AiA0M6oKbVCoaZ6yia1MpMFb9RYpTmVY4LJX0bq+fWm94UqVVgftosy/ghcnV3RIcGhhfBV18SRJrVLOq9wZpFoRngnPbE+ioVpVLXMdhQgdVbXDi1HasMojXXp0jpF5ZnYivECD810cnflA4GSr93yf05Wa8XVnBrINmF95zpVrDiYdvVzPwMqAD+H4NIrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J8uD+Ivii5XhhbQRqiT/X1PTa6uROz9RmlF17cQqKPE=;
 b=GJ4Jf1ythFfoikM1dBKcF3TJVEfGblZvWDksKAuchYBwS4PH0YMoleGMRicPWRxoGpXlGa4X5wZWVIP+M5Qu3cMbjtx12eg58IS75u8LAoBPwRqwzE4A6OfkC+DYQ97fWx/VNPmSF4Vhv7n6tsOsnq4C0GDgFBUVL/ZhhMdIM7XEmt3prhxLS9c8BGkk4+FooMgDjDuOdfcrXhkdWe/qfUBvKEMfnKT7Dy+sBnZozrPKKfwFKssDUHVqF0LCgqHbbCiAvI2/Q1lQji9NMEauQmvtAk+hbsNWH3FpM3RRg6Yu1bVPG36CLwnKOg2jGTWrBuE8NeKGgLk7sURCpbPLoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J8uD+Ivii5XhhbQRqiT/X1PTa6uROz9RmlF17cQqKPE=;
 b=JZTKymE2R1/b7a+ocJilkpwPYl37LDH3GJLwCBi7QnUa48Ea59lvj9J+dPD30rDaTNAVnk7JMQt85YRnM0NqpXua9wnFASD7foPcQVSY3oFL2ylnTHHMhlZ/G5LGOTD/Svc15IbVDuk86BYrceftEhpPTn8JAevhAHlbEyHCCdU=
Received: from BN6PR22CA0038.namprd22.prod.outlook.com (2603:10b6:404:37::24)
 by BL0PR12MB2435.namprd12.prod.outlook.com (2603:10b6:207:48::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.17; Wed, 6 Jul
 2022 11:45:14 +0000
Received: from BN8NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:37:cafe::9b) by BN6PR22CA0038.outlook.office365.com
 (2603:10b6:404:37::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.18 via Frontend
 Transport; Wed, 6 Jul 2022 11:45:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT043.mail.protection.outlook.com (10.13.177.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Wed, 6 Jul 2022 11:45:13 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 6 Jul
 2022 06:45:11 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <joro@8bytes.org>, <iommu@lists.linux.dev>
CC: <iommu@lists.linux-foundation.org>, <suravee.suthikulpanit@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v3 RESEND 11/35] iommu/amd: Introduce per PCI segment device table size
Date: Wed, 6 Jul 2022 17:08:01 +0530
Message-ID: <20220706113825.25582-12-vasant.hegde@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: b72213f2-c634-4998-8815-08da5f44fd61
X-MS-TrafficTypeDiagnostic: BL0PR12MB2435:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	iKnl3e60OohVl9nZhEmTPTefVjYi5D7DZJEvnr3xy7Eit1s6jeQ/0VgZNqAGi/SycOkq6yv4tO70C5mDCQ+Af0uWa94+vpw1AB6LLIzNYMiAK8/x+31XFr68LPn9cTOBKqEP4AjC1FP0uO8cYCJpdmYpSzbUmFmQx8+ES/8iv2ihPnEDItGXJljdcnyboxYk8MhMo47l9wgiq6xMD92EZfrjpqcdtt3rrPChs9eT/mPi/clmdiy40l29rMUJpGdFYfFkTrKemsPPZPOCIaJF29ctsuTpG64/zKk6DFBY4PoOlsQB9DYRvPxHy2D2m8Rn1j7Hg0/xdJiBHEnCyjIRNeXsfDUKRfpAreds9hg+XV/c+juC7estWkGWHEgP5RJwbOcMPx5JmUwqhWjPvuv+l6456MYhVAvHDjpM4BEUhEZGs2saU+VsdAsR5oK8kgP2m2iYy7eik2jE9R5/KLsStuHQlbUdfvVFP7+luvMzuzwatv2rqPngj64SLKlmWezhg4oo2IBfiKF/jSeLjvSOE3ly9UYOqareFS2ysMrSXQqVUiCBG9qAk7jHMnmPiff9PRzhlYF7uEpHc4pFmgo6z45vTevtigVRbMVQkWpw2zOS+BG4o57kCkZ5x5pWR/ksWNDpHsV8gjb+ymcHngAXn5UQml5trbvCcaO4dRLhQdx7kWCbjhQuRQKA+3/TEBr0yzYfujv9HEhNO1e9E9Oy86ujiOLifvzqlGySbB5euxXMquUd6XGBIwV8T7Q2JsBWtNJynqPz4bGf0vK5bFf0Su4/GsKrMj3G2zlckR5SXYv5xakfq/I50lWAkHMuGceLy/5NXA+OXb6det1pZvD595EXKa7EQR9OqQmuKpf87gSre1wVny2ZS/qze3vdL2KC
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(376002)(39860400002)(136003)(40470700004)(36840700001)(46966006)(316002)(82310400005)(110136005)(54906003)(36860700001)(40460700003)(426003)(336012)(47076005)(83380400001)(36756003)(26005)(34020700004)(16526019)(186003)(5660300002)(86362001)(44832011)(2906002)(81166007)(1076003)(7696005)(70206006)(8676002)(4326008)(70586007)(6666004)(478600001)(41300700001)(82740400003)(40480700001)(356005)(2616005)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2022 11:45:13.9163
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b72213f2-c634-4998-8815-08da5f44fd61
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT043.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2435
Message-ID: <20220706113801.8HY47o2bVlCFmx6iE4PWJeFFRFF9alustkQxyelWbpY@z>

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
index 8be8f3d6b44a..1dbe9c7f973d 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -555,6 +555,9 @@ struct amd_iommu_pci_seg {
 	/* Largest PCI device id we expect translation requests for */
 	u16 last_bdf;
 
+	/* Size of the device table */
+	u32 dev_table_size;
+
 	/*
 	 * device table virtual address
 	 *
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 73554ee9c3b3..4a1807f7a8b9 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -416,6 +416,7 @@ static void iommu_set_cwwb_range(struct amd_iommu *iommu)
 static void iommu_set_device_table(struct amd_iommu *iommu)
 {
 	u64 entry;
+	u32 dev_table_size = iommu->pci_seg->dev_table_size;
 
 	BUG_ON(iommu->mmio_base == NULL);
 
@@ -652,7 +653,7 @@ static int __init find_last_devid_acpi(struct acpi_table_header *table, u16 pci_
 static inline int __init alloc_dev_table(struct amd_iommu_pci_seg *pci_seg)
 {
 	pci_seg->dev_table = (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO | GFP_DMA32,
-						      get_order(dev_table_size));
+						      get_order(pci_seg->dev_table_size));
 	if (!pci_seg->dev_table)
 		return -ENOMEM;
 
@@ -662,7 +663,7 @@ static inline int __init alloc_dev_table(struct amd_iommu_pci_seg *pci_seg)
 static inline void free_dev_table(struct amd_iommu_pci_seg *pci_seg)
 {
 	free_pages((unsigned long)pci_seg->dev_table,
-		    get_order(dev_table_size));
+		    get_order(pci_seg->dev_table_size));
 	pci_seg->dev_table = NULL;
 }
 
@@ -1035,7 +1036,7 @@ static bool __copy_device_table(struct amd_iommu *iommu)
 	entry = (((u64) hi) << 32) + lo;
 
 	old_devtb_size = ((entry & ~PAGE_MASK) + 1) << 12;
-	if (old_devtb_size != dev_table_size) {
+	if (old_devtb_size != pci_seg->dev_table_size) {
 		pr_err("The device table size of IOMMU:%d is not expected!\n",
 			iommu->index);
 		return false;
@@ -1054,15 +1055,15 @@ static bool __copy_device_table(struct amd_iommu *iommu)
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
@@ -1581,6 +1582,7 @@ static struct amd_iommu_pci_seg *__init alloc_pci_segment(u16 id,
 
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
2.31.1

