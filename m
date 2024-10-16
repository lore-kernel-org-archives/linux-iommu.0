Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2056.outbound.protection.outlook.com [40.107.220.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4443718D634
	for <iommu@lists.linux.dev>; Wed, 16 Oct 2024 05:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729055929; cv=fail; b=lKzu3a+77aO/FY09eq88EBJaSjHwES/g0JTMSX+p72tcvu/cKFOlyONVkS77txApnnFVnPhdX+LsBGQLS8VNjUdnP4Yuy8VA7CSJbso5rihm6eyqEzK38f2mLFUVnX+XOHgyNl/WIT8rLn9UVY1OwzsFtI3mOX+TkIUpHO9xRC0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729055929; c=relaxed/simple;
	bh=Mf5YeYPit8QmRC6dq/td8ambOmoFakWRRU5ZX8gmwQM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Upx2I/YewK/SZCciJy+1az1Sxx8MwVfSUFJaZ5Uw54KKVhx8CpPJXbgmgXTbBimLMQs0Abm0E+ta50/HWnIsprRQwTTixK2yTq/Kw+8ERVEs0P0E0i+QlhCTMZkkasg1q9iWPymZoOkZyqMt1hosxFn2V1qfSpQuqMZrWKQ/ztY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OPSTgnR9; arc=fail smtp.client-ip=40.107.220.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OPSTgnR9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SajDhYYZ0p7DBTDul4EuhRWweyeqs975fP6vA0AqHX6pPsQ5FnJOlo0lbfQk23gF32cratELetiXyZHfm6yYGRg/L4gr4CnPu47WlBkMn5kcD0BiXDPmzZ8gWsobDGc8jKj/WXlDKz28O1K/gcc1zLYlYawRPNG9fMa1k3ICGZPDmqqWmfg+T9ZWT83SE6cuqIEssoMy975YdmhYTJOpejDkM1a5FBAJJ1fRr73asAmtKnXK/wYOep0+dlmA6Sp9iPpvbN54bA8Jr/4s3l/G2SGyGHQKqj247y0/kVR+Nd2vKvEF0uSDgX8oUde573HkqCc3pteR89ek5wNeujlFkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FE9HSkOisQO1a0Ay4amwT+5wzl0WcdiS7FDWhCdhpKk=;
 b=Ovz4/hiTef9RmHW/RdiTwxsDvYCabTbAdGakMZEEXPp+Cy3sF80fh2nMYTh3e8AOgWjGhQfc0BfKTtHCyzdC4KASfwv1/elui64B5r+gYu+xLRcjrVurNFlTQumDOlp8cCNnGiT7OcuWXYZEMw29Ug86Md3M8d9w2rsYahrVB4p/yFukn2J9bvyxysyBt0Li88Pc5Kjz5N3fLYhhTxmeAquSbMShWZLQIRdNJQZjtNUUdncOOX2wufYlSOU/KfMl0ACHNjR+2fzvCx3vFnoYOV1iguUSXgmUUSfFp6PaLxQLAhxsV5hOAQV1T7RmzCZXRfLHhbZ2Xiys74Vdcwui7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FE9HSkOisQO1a0Ay4amwT+5wzl0WcdiS7FDWhCdhpKk=;
 b=OPSTgnR9Uc/aGa0nmzPMW4jJmWd/Agc8VViYc/91/ufAtZp+FnzdXCn56WA1nfM8qL1lzE1yRBpli9NagIYEm2JQD7DHD20bVdbGS9lrsvMzs6jeAWcixBPiqn5hLh2NFkQy8yJora4ta8r6/ScmdsOv94K4Y4Ja2Er9D1E8wgE=
Received: from SA9PR13CA0111.namprd13.prod.outlook.com (2603:10b6:806:24::26)
 by MW4PR12MB6875.namprd12.prod.outlook.com (2603:10b6:303:209::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.25; Wed, 16 Oct
 2024 05:18:43 +0000
Received: from SA2PEPF00003AE8.namprd02.prod.outlook.com
 (2603:10b6:806:24:cafe::39) by SA9PR13CA0111.outlook.office365.com
 (2603:10b6:806:24::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18 via Frontend
 Transport; Wed, 16 Oct 2024 05:18:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003AE8.mail.protection.outlook.com (10.167.248.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Wed, 16 Oct 2024 05:18:43 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Oct
 2024 00:18:38 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC: <joro@8bytes.org>, <robin.murphy@arm.com>, <vasant.hegde@amd.com>,
	<jgg@nvidia.com>, <kevin.tian@intel.com>, <jon.grimm@amd.com>,
	<santosh.shukla@amd.com>, <pandoh@google.com>, <kumaranand@google.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v6 7/9] iommu/amd: Move erratum 63 logic to write_dte_lower128()
Date: Wed, 16 Oct 2024 05:17:54 +0000
Message-ID: <20241016051756.4317-8-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241016051756.4317-1-suravee.suthikulpanit@amd.com>
References: <20241016051756.4317-1-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE8:EE_|MW4PR12MB6875:EE_
X-MS-Office365-Filtering-Correlation-Id: 86d5a05b-f055-4f85-4848-08dceda200b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NoHx7a0D9qsQW/jFhQ3+ai2/0iOqzoB7vhz4x/A4pCLSt1H0uQy0Z5t8uJMS?=
 =?us-ascii?Q?kNt9LTsjzLVNAlbVjzXvfz2r1HAuYMD83KfOyQ019M35/nLef00DrVwOl3Il?=
 =?us-ascii?Q?ofDbx7z6f7URGyzqb3pKg8OMI+aQzfpZ1yMIAiimyIZcmfzdWJ6zWiS/PTwa?=
 =?us-ascii?Q?kyEaRK3iSoBHVUzWUj/bUy6ESajqniZthCrbiaRX53dZxXN/j6bj0OEXD0rY?=
 =?us-ascii?Q?dZPcNMq9L6UJqxvs241CrA+t7748h+omQG/9yeFd67wQ83+nvIlH+RVR4bJn?=
 =?us-ascii?Q?g7xjHLNzEAQuCyLThIjWexcbJ/XxQJIQnL/tUry89HHlgPwUogrTnmwZpR4G?=
 =?us-ascii?Q?CpK/drvxpF+YG19jhA52sHXnhTx9honLatz5kXY6MwkMubYyWe07KQyEWxcr?=
 =?us-ascii?Q?O9QaigHIazlOkN+g4qrf5AroRUNYlKuba8cJo0vqoQ/prTDxYR6mYMwEzY6S?=
 =?us-ascii?Q?GJQcuOHn4Bvty94hHpZexewmtxU5P9EoTnnmGj/wQ0nuiMsv22V0Ma8kSBZO?=
 =?us-ascii?Q?KaWIlNU4Ya7GZwD6OSLAPrB60RNGY4EoQruckyNeUG04r+pG2gb3Ihet+nPE?=
 =?us-ascii?Q?+eIS33HQmIuQfuZ7b/tHL5BcLf6tBg5zACUcxv2nijfQTtcxBkJShdiWUoUD?=
 =?us-ascii?Q?pE/P4E5bZiKX/qy+L2EMcvnoNxE5QQ+FZ8FsbTxUocUXw6l29a6MJarFnsss?=
 =?us-ascii?Q?ob7/b8m+EiJrsw+ZVD22oDBkZwy6HY0dKmqFxs2wQohI8UtCNZXXqSvV9pQQ?=
 =?us-ascii?Q?dnGiRSm40iygxM4pdysY3kveYMiydPtrqLmXUMa8+yoPGA8gpRuLUqzGmRqt?=
 =?us-ascii?Q?k0JDrkob+70pECO+01zTMa4yFg8xQBPKpwoBOKwiP4xta6luUI1NxwaXpsKy?=
 =?us-ascii?Q?leDKzto6BRHUHlm2E4QZK3zJJesUTTW7eSe2bkM324d4Qa7L09j6sGIe307V?=
 =?us-ascii?Q?dJweIqGrWvs7YZInlaf8eWQCjEND4nJQpgPhwDFS5QQIvRZVENtDlu3wTifQ?=
 =?us-ascii?Q?Cz4CrfJpCqhOpBcQNVx4ifhED0DQdCltdWO8bpV/E7Ie4PPAeTMsoKzN+1k6?=
 =?us-ascii?Q?KrK3p6FyXPcCD+F3Qj/vuBYQfRj+Xyn5gu27GikVZemhJQqJa9Y2f6ZrMFEX?=
 =?us-ascii?Q?G8C1KdWKeLYQ9EXDe/JGxHhSEi1gK5XP5GcOnMrJ4Wphgqj/EA3ARnQMuNXW?=
 =?us-ascii?Q?8Hiq2MnncmBggEioOYCRfNNHciGNsMwt2IE8SnyeonVJ1nJyEOGfoDJ7UMxE?=
 =?us-ascii?Q?PRgER356jgBQFDt7sRfM1SnBEVI9/atLpMUy5OYAODUIO5ospQJsY0lEo2ck?=
 =?us-ascii?Q?vX2LHMy4xcD4meACIudcvmXcE+EG7QkKJgGs3VE8vJe+EZTSeqHd0JUOlu2V?=
 =?us-ascii?Q?dmyDB+gFxgl7zyNKL7canHzfgRnV?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 05:18:43.1457
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86d5a05b-f055-4f85-4848-08dceda200b9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6875

To simplify DTE programming, and remove amd_iommu_apply_erratum_63() and
helper functions since no longer used.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu.h       |  1 -
 drivers/iommu/amd/amd_iommu_types.h |  2 ++
 drivers/iommu/amd/init.c            | 36 -----------------------------
 drivers/iommu/amd/iommu.c           |  6 +++--
 4 files changed, 6 insertions(+), 39 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 96c3bfc234f8..1467bfc34fdf 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -16,7 +16,6 @@ irqreturn_t amd_iommu_int_thread_evtlog(int irq, void *data);
 irqreturn_t amd_iommu_int_thread_pprlog(int irq, void *data);
 irqreturn_t amd_iommu_int_thread_galog(int irq, void *data);
 irqreturn_t amd_iommu_int_handler(int irq, void *data);
-void amd_iommu_apply_erratum_63(struct amd_iommu *iommu, u16 devid);
 void amd_iommu_restart_log(struct amd_iommu *iommu, const char *evt_type,
 			   u8 cntrl_intr, u8 cntrl_log,
 			   u32 status_run_mask, u32 status_overflow_mask);
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 3f53d3bc79cb..53e129835b26 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -220,6 +220,8 @@
 #define DEV_ENTRY_EX            0x67
 #define DEV_ENTRY_SYSMGT1       0x68
 #define DEV_ENTRY_SYSMGT2       0x69
+#define DTE_DATA1_SYSMGT_MASK	GENMASK_ULL(41, 40)
+
 #define DEV_ENTRY_IRQ_TBL_EN	0x80
 #define DEV_ENTRY_INIT_PASS     0xb8
 #define DEV_ENTRY_EINT_PASS     0xb9
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 552a13f7668c..31f10a071abd 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -1014,29 +1014,6 @@ static void __set_dev_entry_bit(struct dev_table_entry *dev_table,
 	dev_table[devid].data[i] |= (1UL << _bit);
 }
 
-static void set_dev_entry_bit(struct amd_iommu *iommu, u16 devid, u8 bit)
-{
-	struct dev_table_entry *dev_table = get_dev_table(iommu);
-
-	return __set_dev_entry_bit(dev_table, devid, bit);
-}
-
-static int __get_dev_entry_bit(struct dev_table_entry *dev_table,
-			       u16 devid, u8 bit)
-{
-	int i = (bit >> 6) & 0x03;
-	int _bit = bit & 0x3f;
-
-	return (dev_table[devid].data[i] & (1UL << _bit)) >> _bit;
-}
-
-static int get_dev_entry_bit(struct amd_iommu *iommu, u16 devid, u8 bit)
-{
-	struct dev_table_entry *dev_table = get_dev_table(iommu);
-
-	return __get_dev_entry_bit(dev_table, devid, bit);
-}
-
 static bool __copy_device_table(struct amd_iommu *iommu)
 {
 	u64 int_ctl, int_tab_len, entry = 0;
@@ -1152,17 +1129,6 @@ static bool copy_device_table(void)
 	return true;
 }
 
-void amd_iommu_apply_erratum_63(struct amd_iommu *iommu, u16 devid)
-{
-	int sysmgt;
-
-	sysmgt = get_dev_entry_bit(iommu, devid, DEV_ENTRY_SYSMGT1) |
-		 (get_dev_entry_bit(iommu, devid, DEV_ENTRY_SYSMGT2) << 1);
-
-	if (sysmgt == 0x01)
-		set_dev_entry_bit(iommu, devid, DEV_ENTRY_IW);
-}
-
 /*
  * This function takes the device specific flags read from the ACPI
  * table and sets up the device table entry with that information
@@ -1185,8 +1151,6 @@ static void __init set_dev_entry_from_acpi(struct amd_iommu *iommu,
 	if (flags & ACPI_DEVFLAG_LINT1)
 		set_dte_cache_bit(iommu, devid, DEV_ENTRY_LINT1_PASS);
 
-	amd_iommu_apply_erratum_63(iommu, devid);
-
 	amd_iommu_set_rlookup_table(iommu, devid);
 }
 
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index c03e2d9d2990..a8c0a57003a8 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -105,6 +105,10 @@ static void write_dte_lower128(struct dev_table_entry *ptr, struct dev_table_ent
 
 	old.data128[0] = READ_ONCE(ptr->data128[0]);
 	do {
+		/* Apply erratum 63 */
+		if (FIELD_GET(DTE_DATA1_SYSMGT_MASK, new->data[1]) == 0x1)
+			new->data[0] |= DTE_FLAG_IW;
+
 	/* Note: try_cmpxchg inherently update &old.data128[0] on failure */
 	} while (!try_cmpxchg128(&ptr->data128[0], &old.data128[0], new->data128[0]));
 }
@@ -2117,8 +2121,6 @@ static void clear_dte_entry(struct amd_iommu *iommu, u16 devid)
 		dev_table[devid].data[0] |= DTE_FLAG_TV;
 
 	dev_table[devid].data[1] &= DTE_FLAG_MASK;
-
-	amd_iommu_apply_erratum_63(iommu, devid);
 }
 
 /* Update and flush DTE for the given device */
-- 
2.34.1

