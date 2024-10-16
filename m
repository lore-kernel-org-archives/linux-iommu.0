Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF90618BBBE
	for <iommu@lists.linux.dev>; Wed, 16 Oct 2024 05:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729055919; cv=fail; b=Tdji028UPSEZdEXh3gZ1bSpe2nfkjIxliF8m/IrcGuc2wYyBvNaPVu+UeWoNegSIoh1vNa+mA16pVqy5nwiaqTGnhAfiRpVh2GyMLzrHEfH1HNmBFsf36YnMpXi+wzdZVMzTviJNJl5K+QakNQde3z8xSyqk0kY6Im44MgMMzwc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729055919; c=relaxed/simple;
	bh=50CBquZC+tSxI/4AXIjFhN4+BaYLJRwYYX9Un6eCKUE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ovz3p6KdgVCXvU5SyOl6O7eX3m8F9Nhskx+Ymkt+P9QOJFQZZMTeQX5OjtzucSwQTpHwYu2HZoGrlidipUF53bINRxajExq2b9RHL11yOActWLdvzOj+Qf0ZAZpXl6qqUb3yYyATN3ekxQeER1b3IFxdbdNQvaPAQshPf39KBCU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=40d8cSMP; arc=fail smtp.client-ip=40.107.92.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="40d8cSMP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SYDiMHDcs8+D4wePNUIGzYlboYgWEsqjk8gs4TH/X+qNyV69it1DxzcOkJURZMurrVUwlilmpCp5F6uwOzTFYxCW0n51Og+wuf/pPI5vJbfg0DAg8y8i6BTb4uyhwjxJx8Pg0VS1sn0+1iXoR90V7eHYI24v81R5wuI7k3HOLU+mWy3NNphivaGpy7eI9zS46eiaY1XsoTrpt7tma9eilWZt+O6MGIjp15zpCZTktNiJBLd3H8z2A+qQf9BkrvgFCYrGlMRuoMtEhOi3NhUZRDbE3u5CKrtcEcLWFQxUqBTeTr8/Chl2R++lC1xmX2Bu0BT7XrkwVTQUh56zyagwZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KyaAJeH3SXSfqItn/J58t5YFXjqDsAOenzdwK/6LrMs=;
 b=WfzDk2sWQYlCIyHGzD+06yrAMQLhyVMHHJD7uimvF8vjboEdMn2fohs2TUwNtEH5ngit073JV7lxf6stT1aJyCjh/1QujUU3fv/ViYHI854YwsBs/Fec27I251s3F2Us9SSVHtbkQSlcfHaSE4Y6EHolW3RmvypnCfG0L1zE8VpqOqLzmF7Nf3UYiAM4LN8+5LNeJzTy+fbamDI4kPoSLLmgYBRKO0cgEcHEhYQyMY2mqXezViykluCK3hyLug11pz2cBZNrbZ9DqOztOVviD0gFWfZkhkRjW75JHC7w2C1LecxaEGczBYWX4vChmkzn2jIzamP07JlcZE0X+UtnIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KyaAJeH3SXSfqItn/J58t5YFXjqDsAOenzdwK/6LrMs=;
 b=40d8cSMPh637rgcN41oqNM6fH6w/aO6RmtnxUhhOsbYMKOEPIkZD23WqSmJ23V3ppL95ticpq1BlUOLGU8kktaSJlGxq5Lj+7Y0onV0yS8dQ5yMShuMXjybBjHZRJU7hp9QBcTAyt0clpOBTNIVlyqcR9zTwTwJBo9voSd2QX9A=
Received: from SA1P222CA0181.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c4::28)
 by SA1PR12MB7412.namprd12.prod.outlook.com (2603:10b6:806:2b2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Wed, 16 Oct
 2024 05:18:33 +0000
Received: from SA2PEPF00003AEA.namprd02.prod.outlook.com
 (2603:10b6:806:3c4:cafe::21) by SA1P222CA0181.outlook.office365.com
 (2603:10b6:806:3c4::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18 via Frontend
 Transport; Wed, 16 Oct 2024 05:18:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003AEA.mail.protection.outlook.com (10.167.248.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Wed, 16 Oct 2024 05:18:27 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Oct
 2024 00:18:22 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC: <joro@8bytes.org>, <robin.murphy@arm.com>, <vasant.hegde@amd.com>,
	<jgg@nvidia.com>, <kevin.tian@intel.com>, <jon.grimm@amd.com>,
	<santosh.shukla@amd.com>, <pandoh@google.com>, <kumaranand@google.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v6 3/9] iommu/amd: Introduce helper function to update 256-bit DTE
Date: Wed, 16 Oct 2024 05:17:50 +0000
Message-ID: <20241016051756.4317-4-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AEA:EE_|SA1PR12MB7412:EE_
X-MS-Office365-Filtering-Correlation-Id: 6932237c-5e26-4b75-4a12-08dceda1f740
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?O8ANMfylXvEfwl0zhHKc9h2Bo04AfIe4Dr00D8oppPctDu1pZLbmsTEWY16Z?=
 =?us-ascii?Q?v7Z0ipLQ/4IFQxjBjGhtJpcxTGG2fLwJLO4TmM6piUHADIv1yjRj3La8Npyb?=
 =?us-ascii?Q?s9Os64hkIDKYL8a37Ug7GHFfHDeIigMfjwsIvj4v1JjzKtNSFIj3hPoPiIZd?=
 =?us-ascii?Q?CoZ99GVtSOPGR5P/x1bPbLvy/dlCHRZ/MWq/TuCYwgUu6lvL4RcE9TmEhz3S?=
 =?us-ascii?Q?4VCwKbwtPgBi3SP+16IiIxRsw0pTu2p9CUUt/oqe9uWD+hOqNQ13/WgMTyWO?=
 =?us-ascii?Q?SFnYjwkUpkCX3o8B5+XGunw4M31X9sYNqyopQU1T1mtfyJUPfRKWNfEKZ5l7?=
 =?us-ascii?Q?eF9lfDvllVlkUSUAuqK3YfndOFLGysgmAY0t66kMkTufDZQj8hOssRx/roBB?=
 =?us-ascii?Q?80ThwhZ8xDW5z/Yr3vJrKaqoWMI+t8bPrdpWfoJduqGMyYNKPkDdqDHPMMY0?=
 =?us-ascii?Q?UQ7FzOZHE7GuoEgJuQwGMcCGaouhowYRe29bA+uAn56T9lXqdCqzG5zVy9DY?=
 =?us-ascii?Q?je7I93JmroN8vi5d9lET5Ty8AUjkmddRgljIlKmryCc+G8MtSgdYU3Y36Dw9?=
 =?us-ascii?Q?aLxBbRG61/7ZATW9ry/Jnwpmtxw0h6KTUceve1P5kkMh89O5yNXNqabWmO9T?=
 =?us-ascii?Q?IV9ftzdO9Pgd+1EEOlfKkpb+IPjl0X8CmEn82v2utDuHgUGB+owpCvB+I7eQ?=
 =?us-ascii?Q?Pt7MrQjN77I5bynvKDUTATB6DUnFqp8fS6Yen2zQ0YJYUglMYrdam5BNiM8N?=
 =?us-ascii?Q?bo0Oj53xB1Y6Lxvq89bLXRKopU/km3541EfxArqDXHqu4CgocrIVYMqxt8Oo?=
 =?us-ascii?Q?0rxjgEqCZ7cG0I6panMNv0uFKE5FMQrz4ELddqjETR1RcJ4CK23BVt59Yidp?=
 =?us-ascii?Q?YRmNDp5s/JZVkkyvOUprSwcIjQ9pJ7T7btAnsGZg3at81w1Ck3JUshd8Nzd4?=
 =?us-ascii?Q?yVibi2xzih5r+uMdDRP0HH6+Xn0VpkkRSiwVOiareIVbqH1+V6VrmEQ35nFj?=
 =?us-ascii?Q?K7a1lqD7JmcSNum+Cm4R6QftaCvRqkl5K2kmdFy0Sb+w3zqQSNkoAYmdsMO1?=
 =?us-ascii?Q?wZvyzZA3kvOJd8sbBRUT77teIfzHnE3mV0CD+qCljaJg43oJhm8Ro4O89jmb?=
 =?us-ascii?Q?8kmmi41IgU5LORgsXzTyUc/BO0TpxEgwEj92uNRauTjm8XzM8D+jmUz8ojFw?=
 =?us-ascii?Q?/XCLQ6nW930ULh0nsIQBDi/E97P/As6qEBeXiZgtgGmKoaEl2Li4EUrCLzTF?=
 =?us-ascii?Q?wG2a4e9JE0wxYD3NZIBlHzywGMgZpNzjXlpWZl/sdmVI95Ot7eViSgBbLUyG?=
 =?us-ascii?Q?G86hAvtsuY377eeiod/TFeSM29BnzqhfRBnbdDLPaLowUiMBiGQx+xfyNLOB?=
 =?us-ascii?Q?siRpTBWiIeRxLD6a5vv3VVnD4ZL8?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 05:18:27.2533
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6932237c-5e26-4b75-4a12-08dceda1f740
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AEA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7412

The current implementation does not follow 128-bit write requirement
to update DTE as specified in the AMD I/O Virtualization Techonology
(IOMMU) Specification.

Therefore, modify the struct dev_table_entry to contain union of u128 data
array, and introduce a helper functions update_dte256() to update DTE using
two 128-bit cmpxchg operations to update 256-bit DTE with the modified
structure, and take into account the DTE[V, GV] bits when programming
the DTE to ensure proper order of DTE programming and flushing.

In addition, introduce a per-DTE spin_lock struct dev_data.dte_lock to
provide synchronization when updating the DTE to prevent cmpxchg128
failure.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  10 ++-
 drivers/iommu/amd/iommu.c           | 112 ++++++++++++++++++++++++++++
 2 files changed, 121 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 601fb4ee6900..f537b264f118 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -425,9 +425,13 @@
 #define DTE_GCR3_SHIFT_C	43
 
 #define DTE_GPT_LEVEL_SHIFT	54
+#define DTE_GPT_LEVEL_MASK	GENMASK_ULL(55, 54)
 
 #define GCR3_VALID		0x01ULL
 
+/* DTE[128:179] | DTE[184:191] */
+#define DTE_DATA2_INTR_MASK	~GENMASK_ULL(55, 52)
+
 #define IOMMU_PAGE_MASK (((1ULL << 52) - 1) & ~0xfffULL)
 #define IOMMU_PTE_PRESENT(pte) ((pte) & IOMMU_PTE_PR)
 #define IOMMU_PTE_DIRTY(pte) ((pte) & IOMMU_PTE_HD)
@@ -832,6 +836,7 @@ struct devid_map {
 struct iommu_dev_data {
 	/*Protect against attach/detach races */
 	spinlock_t lock;
+	spinlock_t dte_lock;              /* DTE lock for 256-bit access */
 
 	struct list_head list;		  /* For domain->dev_list */
 	struct llist_node dev_data_list;  /* For global dev_data_list */
@@ -882,7 +887,10 @@ extern struct amd_iommu *amd_iommus[MAX_IOMMUS];
  * Structure defining one entry in the device table
  */
 struct dev_table_entry {
-	u64 data[4];
+	union {
+		u64 data[4];
+		u128 data128[2];
+	};
 };
 
 /*
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 8364cd6fa47d..ab0d3f46871e 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -77,12 +77,114 @@ static void detach_device(struct device *dev);
 static void set_dte_entry(struct amd_iommu *iommu,
 			  struct iommu_dev_data *dev_data);
 
+static void iommu_flush_dte_sync(struct amd_iommu *iommu, u16 devid);
+
 /****************************************************************************
  *
  * Helper functions
  *
  ****************************************************************************/
 
+static void write_dte_upper128(struct dev_table_entry *ptr, struct dev_table_entry *new)
+{
+	struct dev_table_entry old = {};
+
+	old.data128[1] = READ_ONCE(ptr->data128[1]);
+	do {
+		/* Need to preserve DTE_DATA2_INTR_MASK */
+		new->data[2] &= ~DTE_DATA2_INTR_MASK;
+		new->data[2] |= old.data[2] & DTE_DATA2_INTR_MASK;
+
+	/* Note: try_cmpxchg inherently update &old.data128[1] on failure */
+	} while (!try_cmpxchg128(&ptr->data128[1], &old.data128[1], new->data128[1]));
+}
+
+static void write_dte_lower128(struct dev_table_entry *ptr, struct dev_table_entry *new)
+{
+	struct dev_table_entry old = {};
+
+	old.data128[0] = READ_ONCE(ptr->data128[0]);
+	do {
+	/* Note: try_cmpxchg inherently update &old.data128[0] on failure */
+	} while (!try_cmpxchg128(&ptr->data128[0], &old.data128[0], new->data128[0]));
+}
+
+/*
+ * Note:
+ * IOMMU reads the entire Device Table entry in a single 256-bit transaction
+ * but the driver is programming DTE using 2 128-bit cmpxchg. So, the driver
+ * need to ensure the following:
+ *   - DTE[V|GV] bit is being written last when setting.
+ *   - DTE[V|GV] bit is being written first when clearing.
+ *
+ * This function is used only by code, which updates DMA translation part of the DTE.
+ * So, only consider control bits related to DMA when updating the entry.
+ */
+static void update_dte256(struct amd_iommu *iommu, struct iommu_dev_data *dev_data,
+			  struct dev_table_entry *new)
+{
+	struct dev_table_entry *dev_table = get_dev_table(iommu);
+	struct dev_table_entry *ptr = &dev_table[dev_data->devid];
+
+	spin_lock(&dev_data->dte_lock);
+
+	if (!(ptr->data[0] & DTE_FLAG_V)) {
+		/* Existing DTE is not valid. */
+		write_dte_upper128(ptr, new);
+		write_dte_lower128(ptr, new);
+		iommu_flush_dte_sync(iommu, dev_data->devid);
+	} else if (!(new->data[0] & DTE_FLAG_V)) {
+		/* Existing DTE is valid. New DTE is not valid.  */
+		write_dte_lower128(ptr, new);
+		write_dte_upper128(ptr, new);
+		iommu_flush_dte_sync(iommu, dev_data->devid);
+	} else if (!FIELD_GET(DTE_FLAG_GV, ptr->data[0])) {
+		/*
+		 * Both DTEs are valid.
+		 * Existing DTE has no guest page table.
+		 */
+		write_dte_upper128(ptr, new);
+		write_dte_lower128(ptr, new);
+		iommu_flush_dte_sync(iommu, dev_data->devid);
+	} else if (!FIELD_GET(DTE_FLAG_GV, new->data[0])) {
+		/*
+		 * Both DTEs are valid.
+		 * Existing DTE has guest page table,
+		 * new DTE has no guest page table,
+		 */
+		write_dte_lower128(ptr, new);
+		write_dte_upper128(ptr, new);
+		iommu_flush_dte_sync(iommu, dev_data->devid);
+	} else if (FIELD_GET(DTE_GPT_LEVEL_MASK, ptr->data[2]) !=
+		   FIELD_GET(DTE_GPT_LEVEL_MASK, new->data[2])) {
+		/*
+		 * Both DTEs are valid and have guest page table,
+		 * but have different number of levels. So, we need
+		 * to upadte both upper and lower 128-bit value, which
+		 * require disabling and flushing.
+		 */
+		struct dev_table_entry clear = {};
+
+		/* First disable DTE */
+		write_dte_lower128(ptr, &clear);
+		iommu_flush_dte_sync(iommu, dev_data->devid);
+
+		/* Then update DTE */
+		write_dte_upper128(ptr, new);
+		write_dte_lower128(ptr, new);
+		iommu_flush_dte_sync(iommu, dev_data->devid);
+	} else {
+		/*
+		 * Both DTEs are valid and have guest page table,
+		 * and same number of levels. We just need to only
+		 * update the lower 128-bit. So no need to disable DTE.
+		 */
+		write_dte_lower128(ptr, new);
+	}
+
+	spin_unlock(&dev_data->dte_lock);
+}
+
 static inline bool pdom_is_v2_pgtbl_mode(struct protection_domain *pdom)
 {
 	return (pdom && (pdom->pd_mode == PD_MODE_V2));
@@ -203,6 +305,7 @@ static struct iommu_dev_data *alloc_dev_data(struct amd_iommu *iommu, u16 devid)
 		return NULL;
 
 	spin_lock_init(&dev_data->lock);
+	spin_lock_init(&dev_data->dte_lock);
 	dev_data->devid = devid;
 	ratelimit_default_init(&dev_data->rs);
 
@@ -1272,6 +1375,15 @@ static int iommu_flush_dte(struct amd_iommu *iommu, u16 devid)
 	return iommu_queue_command(iommu, &cmd);
 }
 
+static void iommu_flush_dte_sync(struct amd_iommu *iommu, u16 devid)
+{
+	int ret;
+
+	ret = iommu_flush_dte(iommu, devid);
+	if (!ret)
+		iommu_completion_wait(iommu);
+}
+
 static void amd_iommu_flush_dte_all(struct amd_iommu *iommu)
 {
 	u32 devid;
-- 
2.34.1

