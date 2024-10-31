Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2050.outbound.protection.outlook.com [40.107.93.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2951CB304
	for <iommu@lists.linux.dev>; Thu, 31 Oct 2024 18:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730400211; cv=fail; b=ULnxq+YsPIxs3YFYYNdcvpX86NPxW3U6IURvyJFxZL4ImUE5asaxLQn9j/G6OzGB4B+1Bx0eCVe0K8xxEFFm9nhbc4N4a7/yNh9S2sXkx95JGbAuCypZ++ZCOskElJFcttlw3H+bL108eaLMOdUtSq/Q5T2i1TJS1+kIp0f/RYo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730400211; c=relaxed/simple;
	bh=uUqzQyp9gOvmktM2lr/Doxu1hl9u7p5yrd/61QA2hbQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q2WKJj6NMwONFdzLYwSamQGMmaiaJnJ0rhny4u+RGmCn7BXId993F4QQfFVi1AUIDMhGqGG+bBvQfli8xeJyINybhxpxjl4s0YzxRofzyJqgWGuRlwpf+FGOk1bJl/dq2r5KstkzBSE55WEBcxxvi6Mz064Mtx/H8B2Nu2rrTtM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SmYZKvDq; arc=fail smtp.client-ip=40.107.93.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SmYZKvDq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H6m1re/jtMckF4wkosxQhHCSTNJEMay46E4DpTK9a45yUw6v/n8KLzwHhg1FdJ793e1HJiSXKM6lpgm59XbaPspR/BqeIIRIwflX7nFmiRRJKOyt5Am8+J3IrWewmwak9LoSNKypnLPvhc76VENZ2hQGQPuc7Sm3c/Rk+SyIJiIDO5J3HxrznWORWVIP1l/XUDF3yjTF2wPeTlPnCpF/Ys+jjPUmMwmxbZVlw9wltqkwx7v+p874E6ThkLBBzGwht57dvir9XbbFOpAcRb5M2N8ljihBpzxpMUNMNlPlV0WCN0ncdyyxp66so9xrtPAnGIMuri3xj1X/KOQDOud/vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q9O7N+dak/4xWHq30qh53j7BlBoQqFEfJSVGV9MPqyk=;
 b=GMRSzYytVMU4PLn/+pdv6riIu1H6ckGx3LF1SJpYAzSUoMVF8/gkXpmC2iY8WKMwTOQciGbltZsC4iqUZle1fXQG0XlPr98TOomOjS/g3YRf68zQn8yXWePMGAd6T+MLgV9Ll63CkGxYgXUWEchliPNhc7T53QbByAGVc3fypmxceWmIJcyft8xdG0wzYW8oflj1WJgI/5i0tOYL8iWfDdeBVbBp26poUfWqlSzN7dLYURQhPHkxgIvD13jNKy6Hkf/vCVCaz0+WRi6VoLGxJUDi6y72lRo8vY62ocrm2RUesxIDlitXLYUvZ4+wDK75ESM+w+hhv4/3HBB6LNC5zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q9O7N+dak/4xWHq30qh53j7BlBoQqFEfJSVGV9MPqyk=;
 b=SmYZKvDqAvu9or7L5uH2UboA8kLr0WMz2wKgHdlncONrZ/4edmbSPLjS1Vzp0cm1GmI3763kUwk2KDuMJBZZfNUgomQRk6M8VSOGhnpnJZ/3dvcQrz43R2y5VlaynOtIsDW4ntJWwU3+Mcr7+Vhqow8cqR75VxUSqoUPT0o+LKo=
Received: from CH2PR08CA0029.namprd08.prod.outlook.com (2603:10b6:610:5a::39)
 by SN7PR12MB6792.namprd12.prod.outlook.com (2603:10b6:806:267::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.34; Thu, 31 Oct
 2024 18:43:24 +0000
Received: from CH2PEPF0000013F.namprd02.prod.outlook.com
 (2603:10b6:610:5a:cafe::ac) by CH2PR08CA0029.outlook.office365.com
 (2603:10b6:610:5a::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20 via Frontend
 Transport; Thu, 31 Oct 2024 18:43:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000013F.mail.protection.outlook.com (10.167.244.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Thu, 31 Oct 2024 18:43:23 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 31 Oct
 2024 13:43:19 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC: <joro@8bytes.org>, <robin.murphy@arm.com>, <vasant.hegde@amd.com>,
	<jgg@nvidia.com>, <kevin.tian@intel.com>, <jon.grimm@amd.com>,
	<santosh.shukla@amd.com>, <pandoh@google.com>, <kumaranand@google.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v8 06/10] iommu/amd: Modify set_dte_entry() to use 256-bit DTE helpers
Date: Thu, 31 Oct 2024 18:42:39 +0000
Message-ID: <20241031184243.4184-7-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241031184243.4184-1-suravee.suthikulpanit@amd.com>
References: <20241031184243.4184-1-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013F:EE_|SN7PR12MB6792:EE_
X-MS-Office365-Filtering-Correlation-Id: 535a72b6-2693-4591-5e1e-08dcf9dbe66d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3NIDICIwLt2789zmkpUSvCgXDwINgaGvmGZdl/mDECPy1/hvapLIU/9QQkEp?=
 =?us-ascii?Q?SosT/K9F53TcEd5cFB07CHvX3LprG7cFkvGJHHYfad/U7MuCFL+7UEr0xeqK?=
 =?us-ascii?Q?7x7YZSbTtROpi4SMK+RYRS8FMiKO/p1ZagiPG5rQ52rVEbcxuBsvTCXxEo0q?=
 =?us-ascii?Q?p0Ry7GhixV3D66OANyBoc25zncz+DVgpF7LEYvOdrTLDw1tOnVS7lqLbMlsS?=
 =?us-ascii?Q?GhOh3VKvVPvYhZj+mfKbLD3xOXq6MBXIXEK3uMBMaOGNT7CuvXDe7+llprIZ?=
 =?us-ascii?Q?VhyhwpOq6hJZavbGDXHbJ4BRXagdPl13dZXXnwGTKfIhKtA/OaJ2Hmo5glOY?=
 =?us-ascii?Q?H7xg+OYMv9bKB3YKN9oXTM3WOImMieEtzGbmg2HGSRxoT8bNzGeJz0Ve1laP?=
 =?us-ascii?Q?4xH2HupSuX4VAG1CJUt3Lhf7/Z7hLwuiY2cOTHLuk4SGT8Cm4xwkFXNxuDgQ?=
 =?us-ascii?Q?5YOQXGTFKOqlIMYHJYGEjaO1IFQmL3FfE8aq6Th/AVrnvno6lDZ8UOjIglBS?=
 =?us-ascii?Q?qu/sw2Hz8j7mcc9BUMk1yt+JOSODsg0vcONSkdOMvAlpfNFQnbvp9NbXCsYe?=
 =?us-ascii?Q?UADWgbcD1Oi0Dx57T0wYUtV6N4YZ2Dc1yESQnJ6LIrvhqiycOMUjipMkgflG?=
 =?us-ascii?Q?hCJX9CNchTsschNpyYCtcKhG/8pyCVcL255nueD4vyWgbvXMl16IVqR3Cb5B?=
 =?us-ascii?Q?ewDMVHUBQZT7DjZ6fDC32B5C4TCE+tqClPnx64hccqNs9K++wXUcvKOsqfZQ?=
 =?us-ascii?Q?Fd3D/fcFnEtyOmjTsQtUVmR63fy9M+GzE2y88x63DlIibd9BTSJx8zGIffyj?=
 =?us-ascii?Q?3xoFP5UIrkgeDiDbkrVp1ujE8ochk1ETQ9pHi48UVBWh+K8u8xSfE1ZhcDU5?=
 =?us-ascii?Q?1q8dT1ITVLcEvLTtkIvWOLPWg463w9UUVfixG1x36yHEH3LplKGH2yNN6gkE?=
 =?us-ascii?Q?mIcQB+hD/y6y9KzsGFKB4DnkJcexhSR6FMXwkKpAwg87pm87PN8ANvd7mPAR?=
 =?us-ascii?Q?z3xNn0vqNkOZtaE8rdkiJs91BNVJSRRb4B8B2hhn0OQjhK96sZg/VZJ9rPg1?=
 =?us-ascii?Q?ARU4OLVyvNtAub32kBfWtLRrE6cfOpK+E/rmASEJ54B4/Q1I8HWGaQmSCCD/?=
 =?us-ascii?Q?5HaclCLgFquTwNNl4i2Fz7ELG/Ngi0N6EVSA0wOmoq2Y+Mwo9fDGwyjQYLCm?=
 =?us-ascii?Q?1wvqnd+xKLZEKYmeWSZz61Z0WbqZH+twx8FYNDUY6BFWP07ZNT9Kg+D+Xi2A?=
 =?us-ascii?Q?9kkcqP40ANhGq3JDgC1IcajZkvG/ZK3bv5zLpxtBK5xPSeP3RNXRR1ch3miH?=
 =?us-ascii?Q?P/NiE8F0083sm9pBs7CRCPTt/P2hl6VyRmG1QcFFIjXxKhFtluj6DncZPpG9?=
 =?us-ascii?Q?Qzd2QfLQiobs1QGB84DKuQv/KPSAN5OPfBcijeIANvGehpVRPw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 18:43:23.8067
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 535a72b6-2693-4591-5e1e-08dcf9dbe66d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6792

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
 drivers/iommu/amd/init.c            |  31 ++++++-
 drivers/iommu/amd/iommu.c           | 129 ++++++++++++++++------------
 4 files changed, 107 insertions(+), 68 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 6386fa4556d9..25c630bbcc0b 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -177,3 +177,5 @@ void amd_iommu_domain_set_pgtable(struct protection_domain *domain,
 struct dev_table_entry *get_dev_table(struct amd_iommu *iommu);
 
 #endif
+
+struct dev_table_entry *amd_iommu_get_ivhd_dte_flags(u16 segid, u16 devid);
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 8e5fbd78c302..bd42f736ce31 100644
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
index dd98229fbf68..6821ec7f3f8f 100644
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
@@ -1148,6 +1146,31 @@ static bool copy_device_table(void)
 	return true;
 }
 
+struct dev_table_entry *amd_iommu_get_ivhd_dte_flags(u16 segid, u16 devid)
+{
+	struct ivhd_dte_flags *e;
+	unsigned int best_len = UINT_MAX;
+	struct dev_table_entry *dte = NULL;
+
+	for_each_ivhd_dte_flags(e) {
+		/*
+		 * Need to go through the whole list to find the smallest range,
+		 * which contains the devid.
+		 */
+		if ((e->segid == segid) &&
+		    (e->devid_first >= devid) &&
+		    (e->devid_last <= devid)) {
+			unsigned int len = e->devid_last - e->devid_first;
+
+			if (len < best_len) {
+				dte = &(e->dte);
+				best_len = len;
+			}
+		}
+	}
+	return dte;
+}
+
 static bool search_ivhd_dte_flags(u16 segid, u16 first, u16 last)
 {
 	struct ivhd_dte_flags *e;
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index eb22ed1a219c..8c69bb0e9454 100644
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
+	initial_dte = amd_iommu_get_ivhd_dte_flags(iommu->pci_seg->id, dev_data->devid);
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

