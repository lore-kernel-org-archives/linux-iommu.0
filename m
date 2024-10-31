Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8449D199253
	for <iommu@lists.linux.dev>; Thu, 31 Oct 2024 09:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730366237; cv=fail; b=NGJIHK1xv35Ap34z8PGLqARRpkZoxCQ7s3sMRfaq9INCUwMKAYBdstCAGEDxwwgPVNuaKc0JObz2WxfQM2gR86miip0fgSE1Omj0miO5fD/s0JyyMEVEFEzj+JJhgeuwpLXXPtLIflA+7yGT72ZyG2pnrqg7wMTBN5YamolmSYA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730366237; c=relaxed/simple;
	bh=4sMAb6TaBOviwELMpMm49+Nb00ta2tARTlHyQZ23IpI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EYb6ihyC/5fZIXLhTxxRaZVRR2tSt2rxUCrBV7mUtIHndOeYoEhvBcomjJ0QLTlEecuGETwIEubwcW3OlOhzFEcR/AfUnVWYGDEx7gbDI2t+C0UeP18OB7SjOhYIu0BfB6Lv2q/IQSykJ3Ys2RCbhFfMzf06WiQKErhZExqeClQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=byxhzkGZ; arc=fail smtp.client-ip=40.107.94.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="byxhzkGZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dveb/hTDXfn4DhOKsjVcIFRCT3h7rEqZYL1ZGbxvuvXk1NuTN/3KShhVij4DKX2ol0ALAEp8opn3m5JDP9poSzdtHor7ZOLSXoehO4BwoWQNAJNgyk8FLoYEfmL/fRo2Xu/MxBtVdP/KXP2VhjTDsom+zf/tTvkjtgp+aWKXtVGTtH8PdVMOlhauWBdS7XeVMoyg/xkd4f5Zc17/Qh6EItDEGeeBrl2FWj4ThSjnSN7SAjc2L7V3zKAd50Zqa24bpoE9Z9Teul/BHP7MRN3Wm0Wrfl5HM2/ZZ58a691l9PDTGRpI/O9GFg+0G7a7K1G+OnV1PdNlMWhyCxchAdNSWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F1S2S/GiDDP6YdzrNYh2VKTwFT7iXeJXerukvVIGXCY=;
 b=aeedXjTRs10OdsRSdZn0EPCEq1cvx/MULLkCi0L131yStmxsS0blIxkrzEE4RuVjckjQG6ZIIqawHZLXwTC/IRvCD3xA2fF1gd9ATrhycq9GqysuTDyCPBznLeOpxTFu+aDf6eqNnBnc7Yvu8jc7g+3d2ylwkLMnreR6JLD97X9DHqDb87GSwTX9MtPau9RXhMBxUz/KwghtRbGuPvzQa8OidvICGhM9bFkprtHEuVvXD7+CXFcxoRroRvQxA/CByuzTtKeV0Em0eGbLcyA6tlzvfGS3t0t4wemH0+vuHOB3GBavfrwj5C39gNOgo++mUa/YSpQtHhN4d+RP85kj6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F1S2S/GiDDP6YdzrNYh2VKTwFT7iXeJXerukvVIGXCY=;
 b=byxhzkGZS7JV9xEEGJrGddszrFsBHAIN/FPJX95kihJX6ABtRW4D3qSQFocEJDX+GQgiUfNAUSLyoWIBeLHxH41l2djuekxPUz3KbNFr8YjnuKHJqYRrAbvt+xj2GPDUptjz2KvXw/j0TfBX136FiG+nB6qBxzhyn2gLLWtkTOs=
Received: from BY3PR05CA0024.namprd05.prod.outlook.com (2603:10b6:a03:254::29)
 by DM4PR12MB8524.namprd12.prod.outlook.com (2603:10b6:8:18d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Thu, 31 Oct
 2024 09:17:11 +0000
Received: from CO1PEPF000042AC.namprd03.prod.outlook.com
 (2603:10b6:a03:254:cafe::9d) by BY3PR05CA0024.outlook.office365.com
 (2603:10b6:a03:254::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.7 via Frontend
 Transport; Thu, 31 Oct 2024 09:17:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AC.mail.protection.outlook.com (10.167.243.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Thu, 31 Oct 2024 09:17:10 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 31 Oct
 2024 04:17:00 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC: <joro@8bytes.org>, <robin.murphy@arm.com>, <vasant.hegde@amd.com>,
	<jgg@nvidia.com>, <kevin.tian@intel.com>, <jon.grimm@amd.com>,
	<santosh.shukla@amd.com>, <pandoh@google.com>, <kumaranand@google.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v7 06/10] iommu/amd: Modify set_dte_entry() to use 256-bit DTE helpers
Date: Thu, 31 Oct 2024 09:16:20 +0000
Message-ID: <20241031091624.4895-7-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241031091624.4895-1-suravee.suthikulpanit@amd.com>
References: <20241031091624.4895-1-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AC:EE_|DM4PR12MB8524:EE_
X-MS-Office365-Filtering-Correlation-Id: 317a5637-979a-4139-f757-08dcf98cccc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8YRPNjR6rw7orkLdnFb7GoUwjFdaveoNWTubCSSlftsSMMCQh3qdk0Vt5yKL?=
 =?us-ascii?Q?r6qLSOSM+0ZIxes56v+lzDFGQ7T8l7D8QRq616eN/qQQnva5h8+ybGZ03XzY?=
 =?us-ascii?Q?F9sJzJfuh5LGrdGxP1dtpKcaEgJzz6I/Phnwi0Oi/WbnWm5PGBURrUbpRnl+?=
 =?us-ascii?Q?ebktQ8dQUBo09LWaARWCRU9F84vjJgBRL3gdCnZoa5/H6VTSrTIHPhEYEnbz?=
 =?us-ascii?Q?L1uWuRnKh4mPKSkFzjyMVl3bBjVZ67W9ujmle8FUNAlSx5ToTSsJEdjJ67g8?=
 =?us-ascii?Q?S7yGAs/c9AB/uvAOk4jvkKhcPaKiyb6xE/WOS4Izp1T6ycsckS2MC9GMjvvQ?=
 =?us-ascii?Q?vMBAeiEqd3LKWh0+O/MTI1aGjr637c1de8Qe+f7AbiPqvK2X839kzE7XyQjW?=
 =?us-ascii?Q?TXp4001jQRJdtsdtitL7LEYpkRr4v36r7WdqiwU7t6P0IG6udcopIwYVTEt0?=
 =?us-ascii?Q?/71BOIFzXoGTwlCSLetwIgqjOmiuziALz78k8K5YFuw3hhQHcoMFQ5bkM610?=
 =?us-ascii?Q?PaH2c5g+72wX2UKOGrykiWxrPS30iIqunJG0Js4TQboX0JOqugu/7n+QoYGJ?=
 =?us-ascii?Q?tRzGm6hQopbiroLGFcG7gegqXU3IT6vpl1L4/+jh/ok56si6/L+jrROBjvX2?=
 =?us-ascii?Q?EgPL/AockGTGJ8GD9SUctnnMhFT48FMx7rm9yEvy7uL52EiH2l9U+WQIFCeW?=
 =?us-ascii?Q?Xx/6uVUBn7mBIQUU4kEXMZPguBCMqmdiXMlFMAf0vttCjoQJZVJ2YYk5GRDa?=
 =?us-ascii?Q?iH8ZciI6O/mwikSip9JJH7VfD05bj3bDXatq2CdKjWs0Oz9SV+oBxR6FE6Bn?=
 =?us-ascii?Q?bWF+54hgCfUpT/z87GFDN9zNtaPPtnoc2MIftQGPLLAp3lIcALoMf5YzF+x8?=
 =?us-ascii?Q?iY7gLMTToP5M+MKkIrp9KpFGl1mLqE42i2VANMLMr19+ylBds41Q7+f9rZl5?=
 =?us-ascii?Q?89T/gIJlvYVMqkgJiO5fnGuJDjNPDPL57mNkPwE9bWhFkPmz9pzTKfXVcjJ1?=
 =?us-ascii?Q?/2PqbL+CrOT1I+oPMjvSbyasEF4ZtzusmQphAGmC6l1Kj5t+09oOjyCexrtA?=
 =?us-ascii?Q?KpWuTeiblir1sZ63ySII+k85Aof2ncC0oLfqskeLSwrekJf6lhIwsDfg5zHs?=
 =?us-ascii?Q?CycdWt9zZneOzxB30NujWZAIUzD0MBt2ZHrFtoNpkjW+2OPNZUxpZZxSz7sV?=
 =?us-ascii?Q?U9P545BqZ0AUBkR544Vz2WSLejUzpfJUvwgCmTI1Xp1K0O1+H/HiODDSBs/8?=
 =?us-ascii?Q?cN5dqfCR2vcV8OjP+lhE24xSBsEqiP+Kk+bC5YcI8rPYkEEWhj+zIblrAQFt?=
 =?us-ascii?Q?esO5dFgZwFRMFOLthAnjARXr1UyGyMjc+etPTvXg25H9bu57kR57Jsy8bNqL?=
 =?us-ascii?Q?UnOk2rRptUbe6qZYARMmmvFtJ4mhRXXQldQ1n+UxGzDdgP0t0A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 09:17:10.4665
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 317a5637-979a-4139-f757-08dcf98cccc8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8524

Also, the set_dte_entry() is used to program several DTE fields (e.g.
stage1 table, stage2 table, domain id, and etc.), which is difficult
to keep track with current implementation.

Therefore, separate logic for clearing DTE (i.e. make_clear_dte) and
another function for setting up the GCR3 Table Root Pointer, GIOV, GV,
GLX, and GuestPagingMode into another function set_dte_gcr3_table().

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu.h       |   2 +
 drivers/iommu/amd/amd_iommu_types.h |  13 +--
 drivers/iommu/amd/init.c            |  28 +++++-
 drivers/iommu/amd/iommu.c           | 129 ++++++++++++++++------------
 4 files changed, 104 insertions(+), 68 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 6386fa4556d9..35d1e40930a5 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -177,3 +177,5 @@ void amd_iommu_domain_set_pgtable(struct protection_domain *domain,
 struct dev_table_entry *get_dev_table(struct amd_iommu *iommu);
 
 #endif
+
+struct dev_table_entry *amd_iommu_get_ivhd_dte_flags(u16 devid);
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index e11a77c0f592..561972356ff6 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -409,8 +409,7 @@
 #define DTE_FLAG_HAD	(3ULL << 7)
 #define DTE_FLAG_GIOV	BIT_ULL(54)
 #define DTE_FLAG_GV	BIT_ULL(55)
-#define DTE_GLX_SHIFT	(56)
-#define DTE_GLX_MASK	(3)
+#define DTE_GLX		GENMASK_ULL(57, 56)
 #define DTE_FLAG_IR	BIT_ULL(61)
 #define DTE_FLAG_IW	BIT_ULL(62)
 
@@ -418,13 +417,9 @@
 #define DTE_FLAG_MASK	(0x3ffULL << 32)
 #define DEV_DOMID_MASK	0xffffULL
 
-#define DTE_GCR3_VAL_A(x)	(((x) >> 12) & 0x00007ULL)
-#define DTE_GCR3_VAL_B(x)	(((x) >> 15) & 0x0ffffULL)
-#define DTE_GCR3_VAL_C(x)	(((x) >> 31) & 0x1fffffULL)
-
-#define DTE_GCR3_SHIFT_A	58
-#define DTE_GCR3_SHIFT_B	16
-#define DTE_GCR3_SHIFT_C	43
+#define DTE_GCR3_14_12	GENMASK_ULL(60, 58)
+#define DTE_GCR3_30_15	GENMASK_ULL(31, 16)
+#define DTE_GCR3_51_31	GENMASK_ULL(63, 43)
 
 #define DTE_GPT_LEVEL_SHIFT	54
 #define DTE_GPT_LEVEL_MASK	GENMASK_ULL(55, 54)
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 98b4b116d557..9f5bda23e45e 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -1093,11 +1093,9 @@ static bool __copy_device_table(struct amd_iommu *iommu)
 			__set_bit(dom_id, amd_iommu_pd_alloc_bitmap);
 			/* If gcr3 table existed, mask it out */
 			if (old_devtb[devid].data[0] & DTE_FLAG_GV) {
-				tmp = DTE_GCR3_VAL_B(~0ULL) << DTE_GCR3_SHIFT_B;
-				tmp |= DTE_GCR3_VAL_C(~0ULL) << DTE_GCR3_SHIFT_C;
+				tmp = (DTE_GCR3_30_15 | DTE_GCR3_51_31);
 				pci_seg->old_dev_tbl_cpy[devid].data[1] &= ~tmp;
-				tmp = DTE_GCR3_VAL_A(~0ULL) << DTE_GCR3_SHIFT_A;
-				tmp |= DTE_FLAG_GV;
+				tmp = (DTE_GCR3_14_12 | DTE_FLAG_GV);
 				pci_seg->old_dev_tbl_cpy[devid].data[0] &= ~tmp;
 			}
 		}
@@ -1148,6 +1146,28 @@ static bool copy_device_table(void)
 	return true;
 }
 
+struct dev_table_entry *amd_iommu_get_ivhd_dte_flags(u16 devid)
+{
+	u16 f = 0, l = 0xFFFF;
+	struct ivhd_dte_flags *e;
+	struct dev_table_entry *dte = NULL;
+
+	for_each_ivhd_dte_flags(e) {
+		/*
+		 * Need to go through the whole list to find the smallest range,
+		 * which contains the devid. Then store it in f and l variables.
+		 */
+		if ((e->devid_first >= devid) && (e->devid_last <= devid)) {
+			if (f < e->devid_first)
+				f = e->devid_first;
+			if (e->devid_last < l)
+				l = e->devid_last;
+			dte = &(e->dte);
+		}
+	}
+	return dte;
+}
+
 static bool search_ivhd_dte_flags(u16 first, u16 last)
 {
 	struct ivhd_dte_flags *e;
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index eb22ed1a219c..fd239b38809b 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1958,90 +1958,109 @@ int amd_iommu_clear_gcr3(struct iommu_dev_data *dev_data, ioasid_t pasid)
 	return ret;
 }
 
+static void make_clear_dte(struct iommu_dev_data *dev_data, struct dev_table_entry *ptr,
+			   struct dev_table_entry *new)
+{
+	/* All existing DTE must have V bit set */
+	new->data128[0] = DTE_FLAG_V;
+	new->data128[1] = 0;
+}
+
+/*
+ * Note:
+ * The old value for GCR3 table and GPT have been cleared from caller.
+ */
+static void set_dte_gcr3_table(struct amd_iommu *iommu,
+			       struct iommu_dev_data *dev_data,
+			       struct dev_table_entry *target)
+{
+	struct gcr3_tbl_info *gcr3_info = &dev_data->gcr3_info;
+	u64 gcr3;
+
+	if (!gcr3_info->gcr3_tbl)
+		return;
+
+	pr_debug("%s: devid=%#x, glx=%#x, gcr3_tbl=%#llx\n",
+		 __func__, dev_data->devid, gcr3_info->glx,
+		 (unsigned long long)gcr3_info->gcr3_tbl);
+
+	gcr3 = iommu_virt_to_phys(gcr3_info->gcr3_tbl);
+
+	target->data[0] |= DTE_FLAG_GV |
+			   FIELD_PREP(DTE_GLX, gcr3_info->glx) |
+			   FIELD_PREP(DTE_GCR3_14_12, gcr3 >> 12);
+	if (pdom_is_v2_pgtbl_mode(dev_data->domain))
+		target->data[0] |= DTE_FLAG_GIOV;
+
+	target->data[1] |= FIELD_PREP(DTE_GCR3_30_15, gcr3 >> 15) |
+			   FIELD_PREP(DTE_GCR3_51_31, gcr3 >> 31);
+
+	/* Guest page table can only support 4 and 5 levels  */
+	if (amd_iommu_gpt_level == PAGE_MODE_5_LEVEL)
+		target->data[2] |= FIELD_PREP(DTE_GPT_LEVEL_MASK, GUEST_PGTABLE_5_LEVEL);
+	else
+		target->data[2] |= FIELD_PREP(DTE_GPT_LEVEL_MASK, GUEST_PGTABLE_4_LEVEL);
+}
+
 static void set_dte_entry(struct amd_iommu *iommu,
 			  struct iommu_dev_data *dev_data)
 {
-	u64 pte_root = 0;
-	u64 flags = 0;
-	u32 old_domid;
-	u16 devid = dev_data->devid;
 	u16 domid;
+	u32 old_domid;
+	struct dev_table_entry *initial_dte;
+	struct dev_table_entry new = {};
 	struct protection_domain *domain = dev_data->domain;
-	struct dev_table_entry *dev_table = get_dev_table(iommu);
 	struct gcr3_tbl_info *gcr3_info = &dev_data->gcr3_info;
+	struct dev_table_entry *dte = &get_dev_table(iommu)[dev_data->devid];
 
 	if (gcr3_info && gcr3_info->gcr3_tbl)
 		domid = dev_data->gcr3_info.domid;
 	else
 		domid = domain->id;
 
+	make_clear_dte(dev_data, dte, &new);
+
 	if (domain->iop.mode != PAGE_MODE_NONE)
-		pte_root = iommu_virt_to_phys(domain->iop.root);
+		new.data[0] = iommu_virt_to_phys(domain->iop.root);
 
-	pte_root |= (domain->iop.mode & DEV_ENTRY_MODE_MASK)
+	new.data[0] |= (domain->iop.mode & DEV_ENTRY_MODE_MASK)
 		    << DEV_ENTRY_MODE_SHIFT;
 
-	pte_root |= DTE_FLAG_IR | DTE_FLAG_IW | DTE_FLAG_V;
+	new.data[0] |= DTE_FLAG_IR | DTE_FLAG_IW | DTE_FLAG_V;
 
 	/*
-	 * When SNP is enabled, Only set TV bit when IOMMU
-	 * page translation is in use.
+	 * When SNP is enabled, we can only support TV=1 with non-zero domain ID.
+	 * This is prevented by the SNP-enable and IOMMU_DOMAIN_IDENTITY check in
+	 * do_iommu_domain_alloc().
 	 */
-	if (!amd_iommu_snp_en || (domid != 0))
-		pte_root |= DTE_FLAG_TV;
-
-	flags = dev_table[devid].data[1];
-
-	if (dev_data->ats_enabled)
-		flags |= DTE_FLAG_IOTLB;
+	WARN_ON(amd_iommu_snp_en && (domid == 0));
+	new.data[0] |= DTE_FLAG_TV;
 
 	if (dev_data->ppr)
-		pte_root |= 1ULL << DEV_ENTRY_PPR;
+		new.data[0] |= 1ULL << DEV_ENTRY_PPR;
 
 	if (domain->dirty_tracking)
-		pte_root |= DTE_FLAG_HAD;
-
-	if (gcr3_info && gcr3_info->gcr3_tbl) {
-		u64 gcr3 = iommu_virt_to_phys(gcr3_info->gcr3_tbl);
-		u64 glx  = gcr3_info->glx;
-		u64 tmp;
-
-		pte_root |= DTE_FLAG_GV;
-		pte_root |= (glx & DTE_GLX_MASK) << DTE_GLX_SHIFT;
+		new.data[0] |= DTE_FLAG_HAD;
 
-		/* First mask out possible old values for GCR3 table */
-		tmp = DTE_GCR3_VAL_B(~0ULL) << DTE_GCR3_SHIFT_B;
-		flags    &= ~tmp;
-
-		tmp = DTE_GCR3_VAL_C(~0ULL) << DTE_GCR3_SHIFT_C;
-		flags    &= ~tmp;
-
-		/* Encode GCR3 table into DTE */
-		tmp = DTE_GCR3_VAL_A(gcr3) << DTE_GCR3_SHIFT_A;
-		pte_root |= tmp;
-
-		tmp = DTE_GCR3_VAL_B(gcr3) << DTE_GCR3_SHIFT_B;
-		flags    |= tmp;
-
-		tmp = DTE_GCR3_VAL_C(gcr3) << DTE_GCR3_SHIFT_C;
-		flags    |= tmp;
+	if (dev_data->ats_enabled)
+		new.data[1] |= DTE_FLAG_IOTLB;
 
-		if (amd_iommu_gpt_level == PAGE_MODE_5_LEVEL) {
-			dev_table[devid].data[2] |=
-				((u64)GUEST_PGTABLE_5_LEVEL << DTE_GPT_LEVEL_SHIFT);
-		}
+	old_domid = READ_ONCE(dte->data[1]) & DEV_DOMID_MASK;
+	new.data[1] |= domid;
 
-		/* GIOV is supported with V2 page table mode only */
-		if (pdom_is_v2_pgtbl_mode(domain))
-			pte_root |= DTE_FLAG_GIOV;
+	/*
+	 * Restore cached persistent DTE bits, which can be set by information
+	 * in IVRS table. See set_dev_entry_from_acpi().
+	 */
+	initial_dte = amd_iommu_get_ivhd_dte_flags(dev_data->devid);
+	if (initial_dte) {
+		new.data128[0] |= initial_dte->data128[0];
+		new.data128[1] |= initial_dte->data128[1];
 	}
 
-	flags &= ~DEV_DOMID_MASK;
-	flags |= domid;
+	set_dte_gcr3_table(iommu, dev_data, &new);
 
-	old_domid = dev_table[devid].data[1] & DEV_DOMID_MASK;
-	dev_table[devid].data[1]  = flags;
-	dev_table[devid].data[0]  = pte_root;
+	update_dte256(iommu, dev_data, &new);
 
 	/*
 	 * A kdump kernel might be replacing a domain ID that was copied from
-- 
2.34.1

