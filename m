Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010008.outbound.protection.outlook.com [52.101.85.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503D833263A
	for <iommu@lists.linux.dev>; Mon,  2 Mar 2026 10:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772447970; cv=fail; b=JVHqGVJO6jfjZlt8J1+FUU4zQVjCQcFSqV9bnSWODsKgZJVBQMWPiYe8YTWC3o0+aMP/IMZ1IYsD6bL3PunJl1/ewWkgnxJAdTZ4ereSVZIDTTeRKnkdPziuN8voUtBzPvaeXXHDbdyG5h/tl5pDUGPuAvA0TM3oKj93v0ugdr4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772447970; c=relaxed/simple;
	bh=E0FTIRB4aTdPk/Bu+b3hLUKI5SWd1gJu2qy4NaGxbCo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iqRsdLSP4ZGzUv13yUCjXunJzp72CVLKrXMt1TWUDI20OwZUQxYu8rTWyy/1G/yIj7TjxxfsB8j7R+VwC2OIGZx7S/0xjGo/EGjcWfQF4oHuJWsJ+vS4S8acp4DZkV9uqZ354qWj+vLuMY4SNOBctDgHXKJPBOOvVzHaCQSMrzs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1tTbRH70; arc=fail smtp.client-ip=52.101.85.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1tTbRH70"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F5DAqQRQZD5gEXH7WxEr3RNQI+zQ30NtQACSEOhKzzzO5Egag8g0zxNgdjYZKfHbYEe8D6ivU9RPEl8xwkt0aJl32SsoJZTIeLRW9CK+MeA06HU6kCDyAOTc+ETOxyqScw4kwsQyKbrsKTieXh6AcrPteUbmXZpijBd3AsxzTKgS20oW/XI9uMaGTtKtwbrLjvgSk1JG5QvmpB7gQjLqN65x+cqO29OPXJJvBa8zTgLbdtXwvO1GvC+cuImhzBjRv6wo37yG8gOWRu3aNLEXBoIwJ6Hv6R3KC/laWQfXdKtIo0cWILhoWInCnlggXCSEQkmKJuIChEpFnkX52UUafg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gSoCL605tK1IDIth4UrRL9N0xQePhXBnOrCxRyaDd8E=;
 b=KysdWHx0kiqtYMNUeTKEvzdDP6VUi6YhW0u0uIdm6DqldSq3XCo074FNhJLCkt/lrHqkDpSFxGtaGQJdDdbR/9gfWjQwqIkyJEaa5ACKS29TGrL7c/n/KQouNl5+lsWquE0bXEuTUSW7ZNb8fHbBA6vE91P+KAe3WCHvNpeHxKiUwOF/EbliaKPHGRb4N5U42zJsMrc4TW895xHb7tDS1aE7MLprUeQ9IgZ274A3vJSLLELppO1IA8+erHe2xxK4duKRAjoDTUomDSl8b+Tet4sIabEZrQDsMjOdDvTXotYMtK4NoImspNOl3+0c98STfOzl08qfh54kdBV/YnZ63Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gSoCL605tK1IDIth4UrRL9N0xQePhXBnOrCxRyaDd8E=;
 b=1tTbRH70ee/Tj36yN3RpJd68+Rh1Ozpgbia53i3Iix8A9Nt5RqEnKpOgVOlXuHlMTyW4QFqZQAEjXFrTAuehYfq+avlNFyY5Q4G4cEE1CLSXiWfX0FxQs2OIqR7eMA/d0Q9kaM0gwEjvXkzw4NfobxYCP5EKBKUuaAZXp+Tkuos=
Received: from DM6PR13CA0006.namprd13.prod.outlook.com (2603:10b6:5:bc::19) by
 PH7PR12MB7379.namprd12.prod.outlook.com (2603:10b6:510:20e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.21; Mon, 2 Mar
 2026 10:39:24 +0000
Received: from CY4PEPF0000FCC3.namprd03.prod.outlook.com
 (2603:10b6:5:bc:cafe::4a) by DM6PR13CA0006.outlook.office365.com
 (2603:10b6:5:bc::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.20 via Frontend Transport; Mon,
 2 Mar 2026 10:39:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000FCC3.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Mon, 2 Mar 2026 10:39:24 +0000
Received: from BLRANKISONI.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 2 Mar
 2026 04:39:20 -0600
From: Ankit Soni <Ankit.Soni@amd.com>
To: <iommu@lists.linux.dev>
CC: <vasant.hegde@amd.com>, <suravee.suthikulpanit@amd.com>,
	<joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v2] iommu/amd: Adhere to IVINFO[VASIZE] for address limits
Date: Mon, 2 Mar 2026 10:39:10 +0000
Message-ID: <c719abc28a9ee724228656d2523e3ca43340696c.1772433878.git.Ankit.Soni@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC3:EE_|PH7PR12MB7379:EE_
X-MS-Office365-Filtering-Correlation-Id: c4bf4f98-2eb8-48a7-6964-08de7847f8ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	5L2S5t4HoSm4NOkUcqVsnQbH3/s2cVoZHPU7883W4EBLaNW64kU43kMnZqZ6Zd0a5TGMsBq+fy27l0lP3gCWSNcx8Qz55Yb/4V9EhJGm3iFXg6MFj5j80i2SR08U30HApyX+UHFBZ4LhMitSGT+yOaNp7Oot9FNowpKP0xWKD37jBbhr/fRQOSlVQa4Zd7FtK0mgTWZCOMJfugarsCgyChJ1yvGYubUEucrnaJzu6KHmZUbZyjEXIKzzWdvelPkgxa7O4TB4Nj0oiTj1B3Mcg83CF5vZhPCohrHAVqfdmq/x2fQOVkyAb2ko4GoROpZtA9OSntiQ1Qf1s9gHV8ttAqyop0cE9udn8ZAW6HS/8P3ejElZEtQ1uhllpDXnTSL3+6Ylw6uohBvHDimhMyyJHnN5ZkMBCHCsnWpCTsmnCETOwJvPF30E9ASjS3PyC2wjqvw9hhdwXsJ4HO3eNYCA9/nUlcJd/8HCPMsyfwP772LV5cDXB7Eho9bVvaMnM+S/1H23z2Xr+qCpefYPjRKEDvD1AZVHV2LEwbDw+HzZ9Tn70EJ+El+rLSQX5wLK7Q+bXZ4XMBAK1DS39wwwYA48Ea5BZVnUa02Z7A3cYVnblpmSgPsnM097SqZYM8avsdsbGAilHrl3UvNYXp4VHhWVQ9693E+8G1u1yNwr6p80cQYzchgHJMv3Tyn4gHOiDsChjrHlI+1A63k7UPw3oElrM6mwjtgrr+VhUwOAyxizELauFDckxQijDk4QBlhCW8QaaNNbvtaH1k3m7DrpzNXqmY05i3ccJe79gckr0xHA3jBbvWoA3cjKUCBDKcUbRomKWVJC3JPtnvTIDZ5CONo97g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	+k95LVxkK5WQx6rP/S+R5BwLWZs87R4+8Qbf3XSKa8OLfc+l4j7dLdF4zJxmmkMwV39VYfQXZC6Zmh8QAyT33yDdgRQw4TV5Ipj2IqDGzzYVdNK2GvfWGtZX5evVCzQoec6Gu79yWU4vLyfj9DCm6csVnsISMcFgqi3PKcsV1xrkT77SA9pR3lXdNx3RnjTo9lZqyBUGNqJKsU2FK6qmOtDX0Zg5IYn2MacQnlyRM9e2KZaH+u7T1I1lgBny9IhPCcAyZ+wufiyHHkwtx0ITU6GTDEk6buJVIYFXyi9xMq77+CzIQooOn+KBRZg/69qrFYrHU6UyqAQA6eMMcEd2USo5mwgR3Uih9gUiao+1zQ89Qd2KTGrxm5P0BQJUdCa1vgaSInI8wzvHdydcE0kUnCuaB775W8V4ecYvzUn144EMS40v8Pe8cRDhYm0owwvE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 10:39:24.2541
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4bf4f98-2eb8-48a7-6964-08de7847f8ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7379

ACPI IVRS IVHD’s IVINFO field reports the maximum virtual address
size (VASIZE) supported by the IOMMU. The AMD IOMMU driver currently
caps this with pagetable level reported by EFR[HATS] when configuring
paging domains (hw_max_vasz_lg2). On systems where firmware or VM
advertises smaller or different limits, the driver may over-advertise
capabilities and create domains outside the hardware’s actual bounds.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202602281837.QQl5six6-lkp@intel.com/
Signed-off-by: Ankit Soni <Ankit.Soni@amd.com>
---
v2: Mark ivinfo_vasize_bits() as __init.

 drivers/iommu/amd/amd_iommu.h       |  2 +-
 drivers/iommu/amd/amd_iommu_types.h |  1 +
 drivers/iommu/amd/init.c            | 32 +++++++++++++++++++++++++----
 drivers/iommu/amd/iommu.c           |  3 +--
 4 files changed, 31 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 1342e764a548..f915938a3a08 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -41,7 +41,7 @@ int amd_iommu_enable_faulting(unsigned int cpu);
 extern int amd_iommu_guest_ir;
 extern enum protection_domain_mode amd_iommu_pgtable;
 extern int amd_iommu_gpt_level;
-extern u8 amd_iommu_hpt_level;
+extern u8 amd_iommu_hpt_vasize;
 extern unsigned long amd_iommu_pgsize_bitmap;
 extern bool amd_iommu_hatdis;
 
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index c685d3771436..6a85a38d34bd 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -395,6 +395,7 @@
 #define IOMMU_IVINFO_OFFSET     36
 #define IOMMU_IVINFO_EFRSUP     BIT(0)
 #define IOMMU_IVINFO_DMA_REMAP  BIT(1)
+#define IOMMU_IVINFO_VASIZE	GENMASK_ULL(21, 15)
 
 /* IOMMU Feature Reporting Field (for IVHD type 10h */
 #define IOMMU_FEAT_GASUP_SHIFT	6
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index f3fd7f39efb4..c16d3ddf68ba 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -152,8 +152,8 @@ bool amd_iommu_dump;
 bool amd_iommu_irq_remap __read_mostly;
 
 enum protection_domain_mode amd_iommu_pgtable = PD_MODE_V1;
-/* Host page table level */
-u8 amd_iommu_hpt_level;
+/* Virtual address size */
+u8 amd_iommu_hpt_vasize;
 /* Guest page table level */
 int amd_iommu_gpt_level = PAGE_MODE_4_LEVEL;
 
@@ -3156,6 +3156,27 @@ static void __init ivinfo_init(void *ivrs)
 	amd_iommu_ivinfo = *((u32 *)(ivrs + IOMMU_IVINFO_OFFSET));
 }
 
+static u8 __init ivinfo_vasize_bits(void)
+{
+	u8 vasize;
+
+	vasize = FIELD_GET(IOMMU_IVINFO_VASIZE, amd_iommu_ivinfo);
+
+	/*
+	 * IVINFO[VASIZE] encodes the log2 of the maximum virtual address
+	 * processed by the IOMMU.
+	 */
+	switch (vasize) {
+	case 32:
+	case 40:
+	case 48:
+	case 64:
+		return vasize;
+	default:
+		return 64;
+	}
+}
+
 /*
  * This is the hardware init function for AMD IOMMU in the system.
  * This function is called either from amd_iommu_init or from the interrupt
@@ -3188,7 +3209,7 @@ static int __init early_amd_iommu_init(void)
 	struct acpi_table_header *ivrs_base;
 	int ret;
 	acpi_status status;
-	u8 efr_hats;
+	u8 efr_hats, max_vasize;
 
 	if (!amd_iommu_detected)
 		return -ENODEV;
@@ -3218,6 +3239,8 @@ static int __init early_amd_iommu_init(void)
 
 	ivinfo_init(ivrs_base);
 
+	max_vasize = ivinfo_vasize_bits();
+
 	amd_iommu_target_ivhd_type = get_highest_supported_ivhd_type(ivrs_base);
 	DUMP_printk("Using IVHD type %#x\n", amd_iommu_target_ivhd_type);
 
@@ -3240,7 +3263,8 @@ static int __init early_amd_iommu_init(void)
 		 * efr[HATS] bits specify the maximum host translation level
 		 * supported, with LEVEL 4 being initial max level.
 		 */
-		amd_iommu_hpt_level = efr_hats + PAGE_MODE_4_LEVEL;
+		amd_iommu_hpt_vasize = min(max_vasize,
+					   (efr_hats + PAGE_MODE_4_LEVEL - 1) * 9 + 21);
 	} else {
 		pr_warn_once(FW_BUG "Disable host address translation due to invalid translation level (%#x).\n",
 			     efr_hats);
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 81c4d7733872..e8d15ac9b2bd 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2712,8 +2712,7 @@ static struct iommu_domain *amd_iommu_domain_alloc_paging_v1(struct device *dev,
 	else
 		cfg.common.features |= BIT(PT_FEAT_FLUSH_RANGE);
 
-	cfg.common.hw_max_vasz_lg2 =
-		min(64, (amd_iommu_hpt_level - 1) * 9 + 21);
+	cfg.common.hw_max_vasz_lg2 = amd_iommu_hpt_vasize;
 	cfg.common.hw_max_oasz_lg2 = 52;
 	cfg.starting_level = 2;
 	domain->domain.ops = &amdv1_ops;
-- 
2.43.0

