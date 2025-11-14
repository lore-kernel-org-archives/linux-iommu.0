Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010036.outbound.protection.outlook.com [52.101.201.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FEF314A61
	for <iommu@lists.linux.dev>; Fri, 14 Nov 2025 10:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763117145; cv=fail; b=mujObpXv7xDenfiK6MsRKa+OfND7SzJlF7eIy0XnmsKs/UDhdYPY+5PfSP2aPip4gxUGXFPUznq4eYsTw4vsgBqj2qagQuRQxTX5tWNQGfWbrvEWO+kzaks9LzXvcElHxTSWwElIoU9NSZ5crT11EBtAPzL8+Rl8GD6wnCbugZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763117145; c=relaxed/simple;
	bh=5Lxvf1hgWe80BYsx+nGWloZc6AlYR2IhtipiBVYyiu0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z/T8CfCRd1d+gkJ40TvSpJJLui/tBZtKzzZkXgzV/LahLm8W93vNowKrcztWrgv/l7BPpL/pi9u/2TRqZgJG4r1J0MMDUVdcWHtW2bxWRvR2596k8D0K//oY2hBs21JOD6SZtDzLiroyiS/bqVvV9GQ4kUVMlVcU0GnX2iIM5Ig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dZGeynR/; arc=fail smtp.client-ip=52.101.201.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dZGeynR/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rvGhYVpud/sjSPNNQtlZBfIiu7/MgA5xwoUpQ9V7/jXBp9yPVoVESaWka4wp8z54Nr1PieN2Yl+p8XnkrYBcniNJpm3QBISXM2K8nEP9QvtnprsKqmy8k5Df9jdyfMEoTZEPZn6HPsWFUuo+o6w5IXSsz2iASESKbgad0NAybwOQObqJ5KWoTbkzHxS7KKLXwr0dPDJPMJ32A9Fj9unnvqfM6NchDQVRBp8joq5JAm9yUi1sz+EgyTDhAkUQ+og5Pbj1B2Xj0+BxT95I0/3GgdGYnocDBPuZe8aYN//iMyPQEl55Qcj6n3SPxTLxLQMO9qw3rdF3bt99Ze51VJ8f/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FbOIMuZre463ylKXDy+tgrwtWS0DGpXQ+E2DNpjVBdU=;
 b=xIL8TkzeJ8Sy36bvW5JlcSCFeS+62bIqJTIY1RCedZp319GTqWWkwCvO4zb1EZj8v4sfqfa7RVbdpRO7jW5NnyCBOpxCjZMNeLsEx4XRso4dggJgpb5KK5h7TEOaJA0z4w1WmLGSuVsPsRMJoD8+QKONNhvDTuAUhwPOiixpbAHdcUhiWRjmJPHY3Sno+bSEAXsXPRAuMoJZzKFTUf+eZv4qiMtJtiN7x30dHurGnej2ouZEeMaUTbmhGLB+mDI5gXpjOUval1itXLb2PkAKIfquKErkBvLo6dO1URvirLA/soi4nxy6efvaopHIm5Y8C/TbEAyJT2ssFjmyQXxrKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FbOIMuZre463ylKXDy+tgrwtWS0DGpXQ+E2DNpjVBdU=;
 b=dZGeynR/npMLTPNi9vuQc8lcAzS0e+yvHoKSBKqXqIVP6v+XtKUg5eihlDuwn9Im/F9ZaDqLfsf6O7d5N6V6OvwXuI7wffNfkc0AHKEVayEhmCL5TLwklcnECfiDPG1qS/Z41UP7AtZx30J5sZMZ2YLE9yQYWp9Wj6Y7snv7Cdk=
Received: from DS7PR06CA0021.namprd06.prod.outlook.com (2603:10b6:8:2a::23) by
 BL3PR12MB6451.namprd12.prod.outlook.com (2603:10b6:208:3ba::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.17; Fri, 14 Nov 2025 10:45:39 +0000
Received: from CY4PEPF0000EDD3.namprd03.prod.outlook.com
 (2603:10b6:8:2a:cafe::89) by DS7PR06CA0021.outlook.office365.com
 (2603:10b6:8:2a::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.17 via Frontend Transport; Fri,
 14 Nov 2025 10:45:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EDD3.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Fri, 14 Nov 2025 10:45:37 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 14 Nov
 2025 02:45:34 -0800
From: Sairaj Kodilkar <sarunkod@amd.com>
To: <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<vasant.hegde@amd.com>, <ashish.kalra@amd.com>, <robin.murphy@arm.com>,
	<will@kernel.org>, Sairaj Kodilkar <sarunkod@amd.com>
Subject: [PATCH 2/2] amd/iommu: Make protection domain ID functions non-static
Date: Fri, 14 Nov 2025 16:14:42 +0530
Message-ID: <20251114104442.23296-3-sarunkod@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251114104442.23296-1-sarunkod@amd.com>
References: <20251114104442.23296-1-sarunkod@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD3:EE_|BL3PR12MB6451:EE_
X-MS-Office365-Filtering-Correlation-Id: f18cc133-fdaf-4a6a-d938-08de236af27a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OkRfExe5GPtNfGK2uHfSr8JPgVPYwujM6HiUjWZxSQrmrU2iCMEXUFhY50YX?=
 =?us-ascii?Q?9leK/e+bHMOPE30T8q/M/+k7UgZlU2g1CSzx9C0FjJpBeFgfkzNCFV5UBDoz?=
 =?us-ascii?Q?XwZSK0SKxQ87rk1I7HntbWJFvf9euZZzblx7w+C90BOSYMOgpPIU6zetxfey?=
 =?us-ascii?Q?F99edc1IMNlcu9MOGCZa/q+yGHWIK3S/z3nB6zPUTcyN+vLRplvhlPAZYxc9?=
 =?us-ascii?Q?OVaaR6+oa6QF7SXhm8tDDEB/004DaqBL+k1OQulZmZ1Y2kHBlywPeBCJ2bZL?=
 =?us-ascii?Q?VshY3/wBUxk3xROm2eL7LqLhm7JkM4rKiw7RVgv9apuFzXL0pHTSUd+cybp8?=
 =?us-ascii?Q?uc4q9KhPK2LHgF68Qe+uz4BZuvKA0F4v+KPkaUQOHxaWQFE6BK6ORA9U3LTL?=
 =?us-ascii?Q?PXZAFCmw1d2LgmjF5EXV98c8AgrgzY7lPhIhbNHeeS4JPATHQdh2hiNM3RPy?=
 =?us-ascii?Q?eUsy42I0q5R0lQqveRV71ixUP76s5noC3w+aQF4BdRL1lnbsNXSKgKhcs/4c?=
 =?us-ascii?Q?QuwMGDkKTGBhGO60Shd7oUPnIrQtNwsvKWHl2BXp9nIPep4h3Siu93pmM8bZ?=
 =?us-ascii?Q?JcDDbsI1piaarbMuz4lKFTb6bXjlvvuHg7hOT4Z262NhPkvywB83jeWwGuYU?=
 =?us-ascii?Q?GRvsbk3r/0d4fXPoHhXO01OVe+0OQT6iDqhgv9TfIuo7vjtQGAu3MD3wDwu5?=
 =?us-ascii?Q?elZO5102CFbGBlthlhf73d9MwTnvBsnWHYneGV1RlUWr8f5s1dRDJV/d3Dq6?=
 =?us-ascii?Q?0asuNtD+b1roa79wNLAKCreqAC67HACHsu3zp2LetrB6j2lV6X0bTAx6d00U?=
 =?us-ascii?Q?k1iAq0UXcuU8yzfiDIdJvWKM9d8qs4dGrn/cR0nhuQFntnizHSUF7WtdH7IL?=
 =?us-ascii?Q?NnSyz5rht2BgplUG9xFwgkwK8FGxO2KJh5xpclnIjt+3Al/QHwYZc6e8zh2B?=
 =?us-ascii?Q?zhEPvhAjzTBoounZK2J9fSrDIbu5zOtpt0PKD+T3Z6Nw1UncgNfU+QWgZqlA?=
 =?us-ascii?Q?DMsUBE7ulWgdKWpE/X4mgK3pirrXQdPJft9cSL+LzuLhltcltglGcY0mx4WJ?=
 =?us-ascii?Q?2RP5NSPJFl1KanUUzQ5o2RypHEneO/Ywj6SD4aBtGpdEaN53zN3igmVR8pJB?=
 =?us-ascii?Q?8EYDPjogNOnBZn8r3EHXaBqv2fS8hVub5rD6vTMfURMoYmUqfA2gGwQZCSxy?=
 =?us-ascii?Q?Xpn9E1ow2x3Zq8tlcl2vMBb7USW+oXyH/Sbar/2ymCiAQkd8UOd8fbqKKAjt?=
 =?us-ascii?Q?Gi6Gk0Nr8kXhUr+hhKX0nWqhRfm6ZrXjK4AuFhy5thxjINMLMEd9+D3WOXnx?=
 =?us-ascii?Q?yKJE5yH6f/bzMqO/TBKz4e9KkZ+FQhlInK1RiRtYEiLAE/zl/Jbvfexl8Hi/?=
 =?us-ascii?Q?m4X7IsiejpaTFnre5Qp9aZdRoOPo2MJ/utoMrVGIwUMjULBnxifa+YCAiL0v?=
 =?us-ascii?Q?UF5dst3Y4f9nz3oPjG77kcpVuJiTodYaYsmOi/xPbpuTq1+wQkcATmnv2+GS?=
 =?us-ascii?Q?76GCTzYw8PNFqNAmpiSL84VkwxDOel8YsKQAQdavMIDTE2CrGXwpjNbqimlM?=
 =?us-ascii?Q?Tfi7/+k99gRveBsZEEs=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 10:45:37.3962
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f18cc133-fdaf-4a6a-d938-08de236af27a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6451

So that both iommu.c and init.c can utilize them. Also define a new
function 'pdom_id_destroy()' to destroy 'pdom_ids' instead of directly
calling ida functions.

Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
---
 drivers/iommu/amd/amd_iommu.h |  5 +++++
 drivers/iommu/amd/init.c      |  7 ++-----
 drivers/iommu/amd/iommu.c     | 27 ++++++++++++++++++---------
 3 files changed, 25 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 25044d28f28a..6335b577f80d 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -173,6 +173,11 @@ static inline struct protection_domain *to_pdomain(struct iommu_domain *dom)
 bool translation_pre_enabled(struct amd_iommu *iommu);
 int __init add_special_device(u8 type, u8 id, u32 *devid, bool cmd_line);
 
+int amd_iommu_pdom_id_alloc(void);
+int amd_iommu_pdom_id_reserve(int id);
+void amd_iommu_pdom_id_free(int id);
+void amd_iommu_pdom_id_destroy(void);
+
 #ifdef CONFIG_DMI
 void amd_iommu_apply_ivrs_quirks(void);
 #else
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 9375fba1071c..c78fa67f34c6 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -1142,7 +1142,6 @@ static bool __reuse_device_table(struct amd_iommu *iommu)
 	u16 dom_id;
 	bool dte_v;
 	u64 entry;
-	int ret;
 
 	/* Each IOMMU use separate device table with the same size */
 	lo = readl(iommu->mmio_base + MMIO_DEV_TABLE_OFFSET);
@@ -1189,8 +1188,7 @@ static bool __reuse_device_table(struct amd_iommu *iommu)
 		 * are multiple devices present in the same domain,
 		 * hence check only for -ENOMEM.
 		 */
-		ret = ida_alloc_range(&pdom_ids, dom_id, dom_id, GFP_ATOMIC);
-		if (ret == -ENOMEM) {
+		if (amd_iommu_pdom_id_reserve(dom_id) == -ENOMEM) {
 			pr_err("Failed to reserve domain ID 0x%x\n", dom_id);
 			return false;
 		}
@@ -3134,8 +3132,7 @@ static bool __init check_ioapic_information(void)
 
 static void __init free_dma_resources(void)
 {
-	ida_destroy(&pdom_ids);
-
+	amd_iommu_pdom_id_destroy();
 	free_unity_maps();
 }
 
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 48bca4dc8eb6..4d57e820b824 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1785,17 +1785,26 @@ int amd_iommu_complete_ppr(struct device *dev, u32 pasid, int status, int tag)
  * contain.
  *
  ****************************************************************************/
-
-static int pdom_id_alloc(void)
+int amd_iommu_pdom_id_alloc(void)
 {
 	return ida_alloc_range(&pdom_ids, 1, MAX_DOMAIN_ID - 1, GFP_ATOMIC);
 }
 
-static void pdom_id_free(int id)
+int amd_iommu_pdom_id_reserve(int id)
+{
+	return ida_alloc_range(&pdom_ids, id, id, GFP_ATOMIC);
+}
+
+void amd_iommu_pdom_id_free(int id)
 {
 	ida_free(&pdom_ids, id);
 }
 
+void amd_iommu_pdom_id_destroy(void)
+{
+	ida_destroy(&pdom_ids);
+}
+
 static void free_gcr3_tbl_level1(u64 *tbl)
 {
 	u64 *ptr;
@@ -1838,7 +1847,7 @@ static void free_gcr3_table(struct gcr3_tbl_info *gcr3_info)
 	gcr3_info->glx = 0;
 
 	/* Free per device domain ID */
-	pdom_id_free(gcr3_info->domid);
+	amd_iommu_pdom_id_free(gcr3_info->domid);
 
 	iommu_free_pages(gcr3_info->gcr3_tbl);
 	gcr3_info->gcr3_tbl = NULL;
@@ -1874,14 +1883,14 @@ static int setup_gcr3_table(struct gcr3_tbl_info *gcr3_info,
 		return -EBUSY;
 
 	/* Allocate per device domain ID */
-	domid = pdom_id_alloc();
+	domid = amd_iommu_pdom_id_alloc();
 	if (domid <= 0)
 		return -ENOSPC;
 	gcr3_info->domid = domid;
 
 	gcr3_info->gcr3_tbl = iommu_alloc_pages_node_sz(nid, GFP_ATOMIC, SZ_4K);
 	if (gcr3_info->gcr3_tbl == NULL) {
-		pdom_id_free(domid);
+		amd_iommu_pdom_id_free(domid);
 		return -ENOMEM;
 	}
 
@@ -2477,7 +2486,7 @@ struct protection_domain *protection_domain_alloc(void)
 	if (!domain)
 		return NULL;
 
-	domid = pdom_id_alloc();
+	domid = amd_iommu_pdom_id_alloc();
 	if (domid <= 0) {
 		kfree(domain);
 		return NULL;
@@ -2773,7 +2782,7 @@ void amd_iommu_domain_free(struct iommu_domain *dom)
 
 	WARN_ON(!list_empty(&domain->dev_list));
 	pt_iommu_deinit(&domain->iommu);
-	pdom_id_free(domain->id);
+	amd_iommu_pdom_id_free(domain->id);
 	kfree(domain);
 }
 
@@ -2824,7 +2833,7 @@ void amd_iommu_init_identity_domain(void)
 	domain->ops = &identity_domain_ops;
 	domain->owner = &amd_iommu_ops;
 
-	identity_domain.id = pdom_id_alloc();
+	identity_domain.id = amd_iommu_pdom_id_alloc();
 
 	protection_domain_init(&identity_domain);
 }
-- 
2.34.1

