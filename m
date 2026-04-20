Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012004.outbound.protection.outlook.com [52.101.53.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D3C37D124
	for <iommu@lists.linux.dev>; Mon, 20 Apr 2026 17:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776704459; cv=fail; b=PZVqoonyRDN1D0kyjHbq8OUc8wEkUmtsyutqiIO8XqBZUSt9NV/GIpWoxhdsGEOHVQTeOch9yjoIxef2/8Jpalz52ls7/lettMehVW+PDj1hxb7u8Ei9I8sjPzb9oenWM6qMUUKMDMdLggBwJgMrJBBTO6tlDXVAhtFvtsaY7zA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776704459; c=relaxed/simple;
	bh=7kGMpIdpMbDWalEDnWkyfccYQ7zS/5JYcHcVsMT3apI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G/i0LZfc5fObwNGkYk/1glz2VlUBV3Bi8LESfFRbV682Ga7X4QaOd09eTYyAtTd6ZiShuBUBUM4mikUQw31E5AnLOO4iLok3JxYe9FsxUWlub2cqJL5qM5ens1tLC3P8luIM4YnURfz2sphJmMnB7aOOpCpQQuS7BE6fwn9ags0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4fRc1xY5; arc=fail smtp.client-ip=52.101.53.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4fRc1xY5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bp/mDeWvWdeBd6cNBM3S36XANutqCON44lTgcAOGFJn816aZG7YuzwXLz3P9CFBSl8Qlfc+GUBoVgNHkCvHylRvrTjlIRz9CYNQb/RSuPKHCMXSJ/Q4rX5hDjYmqGM/LdmYLRRwvDGpEjKrdwnOlbJYpdxrjpEdoikTuo5gi2S9jWPkZTbhFpbPkLKcPhJ0jwbdZC/qYJeynSzorGnb1+GVT+x4tKAd5YCZ8UUHGKm1snoEEMlj3bnyb+voTcIfQPL9yucx4ZDlMLCdOgFtFJgY5+gp3WtieQiUeZ6dM08gTLmmVuAri+tJMN0JTm1fXIyvgRITZIMx2+N9KIDocOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Abk05HQbCi0hhx60pDEP543N2VJKU3nUQVS9YOnw76A=;
 b=qvn/hmGuHRFYtCTbLLdPNnRWTNqLPcJn6QpHT6bYqgtGhREYQZFLO5SskGWuauwgmhjEn0jNBLhPLgk84CoodGbg3C8bdvn+uoMWdc41ffXCwsItIf6/nbt9KY9W3TMuVNbhyK+0w+tc03JMMmHIKFaS0B/cDhkNd9oO3pgGKXpeXcnDyLEF0fppsB12I35Qjt15lyL8NbesYX06v5KVnFuojBDj5hTFLTGgJCTxXGQx3BiFfP1XaTrIMPMvO9i+hJorsvs2kfWXb70tEEUFg1pEW6V9OE48SrDTHAGLz/ARj4RGCLiVVmfzf7TcbARG47ttDBgXQcfrTir7tyjuzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Abk05HQbCi0hhx60pDEP543N2VJKU3nUQVS9YOnw76A=;
 b=4fRc1xY5bF+8gjhmT04AI2jXyvntdQ5Hy1FYYfBVDb7aqBIOa8ZPG8dPCgeW2acSIZoOL3iRJCxesq829BT9oLgb4tE+DY3N0XMZqKXKAxo5LTCa+7SA3mtJeoTr2UB8nWBCq/3XnFlV0cfF8v7HFEfWVzEvEivNYJwMOAg7Rwg=
Received: from BL1PR13CA0440.namprd13.prod.outlook.com (2603:10b6:208:2c3::25)
 by IA0PPFDC28CEE69.namprd12.prod.outlook.com (2603:10b6:20f:fc04::be8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Mon, 20 Apr
 2026 17:00:53 +0000
Received: from BL02EPF0001A108.namprd05.prod.outlook.com
 (2603:10b6:208:2c3:cafe::ba) by BL1PR13CA0440.outlook.office365.com
 (2603:10b6:208:2c3::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Mon,
 20 Apr 2026 17:00:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A108.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9791.48 via Frontend Transport; Mon, 20 Apr 2026 17:00:53 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 20 Apr
 2026 12:00:50 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC: <joro@8bytes.org>, <jon.grimm@amd.com>, <vasant.hegde@amd.com>,
	<frank.gorishek@amd.com>, <thomas.lendacky@amd.com>,
	<santosh.shukla@amd.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>
Subject: [PATCH 1/4] iommu/amd: Drop unused global exclusion range fields and init
Date: Mon, 20 Apr 2026 17:00:30 +0000
Message-ID: <20260420170033.6780-2-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260420170033.6780-1-suravee.suthikulpanit@amd.com>
References: <20260420170033.6780-1-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A108:EE_|IA0PPFDC28CEE69:EE_
X-MS-Office365-Filtering-Correlation-Id: 03e7b010-220a-4d3f-2abb-08de9efe6225
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|376014|82310400026|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	lRKHPstuVkmsrFUzuAhrHzOnaz5r634wVRIPlRW+2ffx9JuBtlixhpldy/GOPnwO20g8Db93U5/5CsdASi+MuMqvelhY1mToUYO2isfFOvTwBrfcohYCP4pUuBebnwyi54Kc4ki3Ifxsto19NaG5LJLj4fbZ0qDyijH0EdkL2O7SJM+mK21V/EFMwUbkjKQQ+6OAx4dki2EbMbMnZV/fC9fLIp8RWCWbDsQayhi7BCdiZPU60CLa3ouzqHRbM9dJarRntfF8aDyFFVsyAJUL4MAdvAXZ5YG2JUEupDKzCIT/oC8PfBo9ja+EgSDMBotgatn6CtTxBBpiWQXBSXRS4gQfSqE3no3WWhFGn+/y6uj4tPOy+LuqiLuBXjft2WIOMiAVOLefZS5sZ5emJiVc1TTDEJSmBPWGvvJesa+az4qDFgw5z+BG4GC8mcFKA0QKe8GAwjiHSih9rti/cqykNEdWye5XSVRsEZHAmz2rqSjBmss2XTWGKPx98m3TZNv+aNnU9kMrFOrm68l59VwgLJ6qBxPsM+0p/HhkErkmEhiyxHJ4zByK4qdQplWM1NkMq7vmOw9RyQZ4YgeYZTFt7pQjAUljfC5lXsakWdnOqECK5WDz+86KG68IiOb5oNs63DG3yHaNBvMBhYwa0+pARfvRKjcEAY10Kvtuas5OzBeb39uKVdLB6ceKQhybLdNThtz30zQjw9EHrl519v7zL9uNi6NSTk7sGwFL1ppnuZPnMcluiHHnPGJN9OJVfwPuyRp80GEuBLFIGXjarHoavw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	D/u4gGVliXwOb667nCL46Rshqwh53AR0QgzguEH+Pd/w5NWTbkTQPAB+Elj30L63xh/+DXb3FWFExArwO7uJ7o8/EDFkyTwOWqR4YgYc/HWvitYSAa2NJ9yId+EzU1wvjumNbJRZ7LNhjmOJ+G53dlI9sD7kRwkUMbyGZwmgl9F36KtzB6VNR3genmdpWjHPSExtguKeqGzb6Mxk7GNzWPXXzIWA8wzZqaxMNfjmW8XGwkjQmWGq+sRX/AuSrU6Ujcv6Yk/czEVFb05GC7dwEeB1wipSkhfs878msrpSP4xd4rEvrQYIs/3xf8dEBTP25gBlzNGRNtoh4zFWUAgnhKZIpddNJq/RCAcA+QUH8pa9E7pML+tH5Wy/oekstHDMFGaJ8GYx4l5Bm3UNUEVMXn6X51xLsbJ7akwiAz9zcNRPOfFKKDkxBNPr2Tyi8xM7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 17:00:53.8238
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03e7b010-220a-4d3f-2abb-08de9efe6225
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A108.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFDC28CEE69

Remove unused struct amd_iommu.exclusion_start/exclusion_length, the
MMIO_EXCL_* flag masks, and iommu_set_exclusion_range(). These struct
amd_iommu fields were never assigned, so early_enable_iommu() never
programmed the hardware exclusion registers through this path.

Please note that the exclusion range registers have been repurposed
to SNP completion-wait store base / limit registers. So, rename
MMIO_EXCL_BASE/LIMIT via to MMIO_COMPL_STORE_BASE/LIMIT instead.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h | 13 ++-----------
 drivers/iommu/amd/init.c            | 29 +++--------------------------
 2 files changed, 5 insertions(+), 37 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index c685d3771436..c4ea701b7cab 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -50,17 +50,13 @@
 #define MMIO_GET_BUS(x) (((x) & MMIO_RANGE_BUS_MASK) >> MMIO_RANGE_BUS_SHIFT)
 #define MMIO_MSI_NUM(x)	((x) & 0x1f)
 
-/* Flag masks for the AMD IOMMU exclusion range */
-#define MMIO_EXCL_ENABLE_MASK 0x01ULL
-#define MMIO_EXCL_ALLOW_MASK  0x02ULL
-
 /* Used offsets into the MMIO space */
 #define MMIO_DEV_TABLE_OFFSET   0x0000
 #define MMIO_CMD_BUF_OFFSET     0x0008
 #define MMIO_EVT_BUF_OFFSET     0x0010
 #define MMIO_CONTROL_OFFSET     0x0018
-#define MMIO_EXCL_BASE_OFFSET   0x0020
-#define MMIO_EXCL_LIMIT_OFFSET  0x0028
+#define MMIO_COMPL_STORE_BASE_OFFSET   0x0020
+#define MMIO_COMPL_STORE_LIMIT_OFFSET  0x0028
 #define MMIO_EXT_FEATURES	0x0030
 #define MMIO_PPR_LOG_OFFSET	0x0038
 #define MMIO_GA_LOG_BASE_OFFSET	0x00e0
@@ -680,11 +676,6 @@ struct amd_iommu {
 	/* pci domain of this IOMMU */
 	struct amd_iommu_pci_seg *pci_seg;
 
-	/* start of exclusion range of that IOMMU */
-	u64 exclusion_start;
-	/* length of exclusion range of that IOMMU */
-	u64 exclusion_length;
-
 	/* command buffer virtual address */
 	u8 *cmd_buf;
 	u32 cmd_buf_head;
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index f3fd7f39efb4..866249d3673e 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -352,28 +352,6 @@ static void iommu_write_l2(struct amd_iommu *iommu, u8 address, u32 val)
  *
  ****************************************************************************/
 
-/*
- * This function set the exclusion range in the IOMMU. DMA accesses to the
- * exclusion range are passed through untranslated
- */
-static void iommu_set_exclusion_range(struct amd_iommu *iommu)
-{
-	u64 start = iommu->exclusion_start & PAGE_MASK;
-	u64 limit = (start + iommu->exclusion_length - 1) & PAGE_MASK;
-	u64 entry;
-
-	if (!iommu->exclusion_start)
-		return;
-
-	entry = start | MMIO_EXCL_ENABLE_MASK;
-	memcpy_toio(iommu->mmio_base + MMIO_EXCL_BASE_OFFSET,
-			&entry, sizeof(entry));
-
-	entry = limit;
-	memcpy_toio(iommu->mmio_base + MMIO_EXCL_LIMIT_OFFSET,
-			&entry, sizeof(entry));
-}
-
 static void iommu_set_cwwb_range(struct amd_iommu *iommu)
 {
 	u64 start = iommu_virt_to_phys((void *)iommu->cmd_sem);
@@ -386,14 +364,14 @@ static void iommu_set_cwwb_range(struct amd_iommu *iommu)
 	 * Re-purpose Exclusion base/limit registers for Completion wait
 	 * write-back base/limit.
 	 */
-	memcpy_toio(iommu->mmio_base + MMIO_EXCL_BASE_OFFSET,
+	memcpy_toio(iommu->mmio_base + MMIO_COMPL_STORE_BASE_OFFSET,
 		    &entry, sizeof(entry));
 
 	/* Note:
 	 * Default to 4 Kbytes, which can be specified by setting base
 	 * address equal to the limit address.
 	 */
-	memcpy_toio(iommu->mmio_base + MMIO_EXCL_LIMIT_OFFSET,
+	memcpy_toio(iommu->mmio_base + MMIO_COMPL_STORE_LIMIT_OFFSET,
 		    &entry, sizeof(entry));
 }
 
@@ -1013,7 +991,7 @@ static int __init remap_or_alloc_cwwb_sem(struct amd_iommu *iommu)
 		 * completion wait buffer (CWB) address. Read and re-use it.
 		 */
 		pr_info_once("Re-using CWB buffers from the previous kernel\n");
-		paddr = readq(iommu->mmio_base + MMIO_EXCL_BASE_OFFSET) & PM_ADDR_MASK;
+		paddr = readq(iommu->mmio_base + MMIO_COMPL_STORE_BASE_OFFSET) & PM_ADDR_MASK;
 		iommu->cmd_sem = iommu_memremap(paddr, PAGE_SIZE);
 		if (!iommu->cmd_sem)
 			return -ENOMEM;
@@ -2891,7 +2869,6 @@ static void early_enable_iommu(struct amd_iommu *iommu)
 	iommu_set_device_table(iommu);
 	iommu_enable_command_buffer(iommu);
 	iommu_enable_event_buffer(iommu);
-	iommu_set_exclusion_range(iommu);
 	iommu_enable_gt(iommu);
 	iommu_enable_ga(iommu);
 	iommu_enable_xt(iommu);
-- 
2.34.1

