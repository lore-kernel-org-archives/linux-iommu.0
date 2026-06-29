Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010069.outbound.protection.outlook.com [40.93.198.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724B73FBB76
	for <iommu@lists.linux.dev>; Mon, 29 Jun 2026 15:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782747708; cv=fail; b=KfrOHVRBeC0MZd8faQEYlQVBpp4MNc1/jwKSmV9XF8khOJgxAPDPItftuN3/VM7sTzWH9xvzP3ljOCO41hYaKV8zY8kIW50cITeSStRkhEJT+/nBxf74B0Q20P0vkO5rXalYIc7cOAm3Tf3w5+1gqtMlz7Qurb863o1OemsU5xk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782747708; c=relaxed/simple;
	bh=2wUnBxVcpfQC/avxiElcDq4KL4lpa3Imbg1FXl7QapM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sogQVSHsOgygDlYK38jT/SaE80x7ATOWlXQUNDHe2wqMD9rlPAXdjDp3SygRvCeoZHW+GPEafTya7ZM3Vkiz85ZRKTQwbOVrpzz8SI6gpv8fSjFfoWt+VWyDr/g+K75hn6HofH/WKVpHD/NZtkpYNHt2v2i5RqeS2ulymxTwXhI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Q5rTQKGn; arc=fail smtp.client-ip=40.93.198.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Q5rTQKGn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sO259TMfcSVtYughc9wBAiuz/HPlv023n2JxL6l0Yb2NI5iOH9pPv+zVlPmJxV6PzywtmT1/yqrU3jba+F8KFYkM+4XtUY6+N8BjW67lL0oqDJuI1pvLAOfRNxHBTmOLgulRFmmi0FIqTvP6X289JNgBIBagCS66rswFhHre6q8wp0NiLXpkPijYYVMKe9muS18G5knYSPnYy3rkdFZn5VMlpq/hrBTeQx2Vioov6wJHLafHsmDf7v+U5uKxCbCek7IaiZUba/qPpJCG/vjoL0iRvUXlVTFLhnH1gIrF7CZX0jBHeeoDbCG8c1tUCWdKEVSx69HX1EH4m43lCuFDTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QZag/GU07m4sRNgqhBdk6g1TvvrEVLU0bGitpfZRAt8=;
 b=iaJWpiYSmwwhvDrkO/G69SbrkMjkSuYIMTQD6Lb2zB9zF5wNcbpo6DagkYY7XC92YYFlLfsZg2ETpL/HjyBZZQUspfhgQ7NMYMUcCfaMaxc4AR0203GCSyxQeSqrGohN1pKPnU/iVB2D7eZqMimGzM3A1+FBGClQIPwyV2Q9Ar9SVm4+2E02L8JHadknEiDtwrUkKTRNrdgcbIAlLA+3u6CjBt7vHjJ+Ke1G10qxJGerNoy9YOLGY8zkZJ0QynRHvrvbdbPayw457zbVEh9wdIwifP06yIb28CVpjnH9+N94wDV7NBOYDle2s4PDOlDa791WrdVbMbdZ0ZSy/oeKDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QZag/GU07m4sRNgqhBdk6g1TvvrEVLU0bGitpfZRAt8=;
 b=Q5rTQKGn/Y63VTby00Cc0SjGs1wYZD5z7TiOQSeJzFsXwZwKyOftXSvrfkXPPhWixnaaGnPudt8R5RJKIMR4sVfgFPTWdIb0iSuqRQwbpskkddRNeJi+S6Uelq1aagB4UE8CVnB9Ec66ym9SGxXYzgfyJI8vHCRyKXeF4LtU3jk=
Received: from BN0PR08CA0013.namprd08.prod.outlook.com (2603:10b6:408:142::21)
 by CH3PR12MB8284.namprd12.prod.outlook.com (2603:10b6:610:12e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 15:41:39 +0000
Received: from BN2PEPF000055E1.namprd21.prod.outlook.com
 (2603:10b6:408:142:cafe::4) by BN0PR08CA0013.outlook.office365.com
 (2603:10b6:408:142::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Mon,
 29 Jun 2026 15:41:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF000055E1.mail.protection.outlook.com (10.167.245.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.202.0 via Frontend Transport; Mon, 29 Jun 2026 15:41:39 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 29 Jun
 2026 10:41:33 -0500
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 29 Jun
 2026 08:36:35 -0700
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>, <jgg@nvidia.com>
CC: <yi.l.liu@intel.com>, <kevin.tian@intel.com>, <nicolinc@nvidia.com>,
	<vasant.hegde@amd.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
	<sairaj.arunkodilkar@amd.com>, <jay.chen@amd.com>, <wvw@google.com>,
	<wnliu@google.com>, <dantuluris@google.com>, <chriscli@google.com>,
	<kpsingh@google.com>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v3 09/22] iommu/amd: Introduce and map vIOMMU private IPA region
Date: Mon, 29 Jun 2026 15:35:22 +0000
Message-ID: <20260629153535.15775-10-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629153535.15775-1-suravee.suthikulpanit@amd.com>
References: <20260629153535.15775-1-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055E1:EE_|CH3PR12MB8284:EE_
X-MS-Office365-Filtering-Correlation-Id: d0e58935-d6f4-4bb2-836a-08ded5f4e919
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|23010399003|376014|7416014|1800799024|13003099007|6133799003|11063799006|18002099003|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info:
	pU53whM5kowGIxsXWGQjHfzbOqGNUxJNixXnSZkJI8XG9pS7RmfCHloba3MRyV8p3pDpMoCrJnCYsyU+Z5WF5II0rAU0hAAjn/lLjPoSBHF87Kz0r6UJvX+4fJfF3aSbryNmsw/EPXME61T75zegUDS4uvXwppnL5oeP18+THVJBtHa55RmDUNQir10VgB+LuOAdFybn0F0azY2+JBCVXmzeX04XWEWQjdLnuKwsZsdNRR9gYh0n40PH06oRyEwDqftFokelbxzeFsgbF/o7dNJNgJNlYdObi0X+KDhxJya6T/jghOrF20e8x9mygCWnfKGHtBgw8o8hp20gk9IOUbTxOs1ZiGFrWKCFOAS/SmZdPxWtDFhnI9iLMLLJ/+hp5qF73XjU2AG0UwcWexVeVYGyZ2TG+nzRpvnloGXsvH/sL564Hk3KvlR6dY+sWS7UN6AR4cTO9AFoByVHwSCML0Qe/3817wNbZsYoDVCBwFJBnn1Inuu3XiFN4Vqwn6oT4Z9tvOaEsvKpetDKYaAatvH+EmsHdw1Romcr0LwyMTWHloUMnpLER7y9yC84iXwoMjTYx2CfhXlox5RwYS9fG7uXe+J0LcK/1tClzrhWairgmWJyFZGzRq/MxfrYXiDm3idZInh2x3byVKlAGS/92OjnJqzK/JC9wRFqlSMfMJq6JdSVLbE1wSBSkv8JekpCpFUCjJd1I5RVQf2e49l7vA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(7416014)(1800799024)(13003099007)(6133799003)(11063799006)(18002099003)(56012099006)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	fMlwegTcZose7xZxfBmO0iE9b6MTKbFTlDnc2hIYn1lJHt3UuNG/mQnx2B0zi0LLFOweuoPw99/7TPiZCPFs6dISSpqwM7OV9Q/jWu6mI9Ty1MmSxukBjTyS+qfxIQ6U2ia+nor/jh2614Wjk+0urJ8VL8MdbMy/AaxV9FJdMEjeX+zrTeRNLTEV9EL6WjT1lnB7K1KtigcirP8j8UBomO3Kl7F5Yr/kCSIMlsTA9Phyex+phyGH0i3yX22PEcOmf8SkS+LDBgVhmYPnQwOIwZRbTnSD47ke45RZLBTo9ZLpd/qSSLANaZQF10iHcvgZdIKZc+cXSPQljGC7K5bqwb98+8Jc5kOMcWfFmIk1U6WGGYpEunCgQDXO3jSIINdC/L04Fo4unHHMpxOza0G7CFd9qBSEkBESI6iu6Bt5Qs8M+jIs4FXPqcyAvqTvQwHG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 15:41:39.2264
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0e58935-d6f4-4bb2-836a-08ded5f4e919
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055E1.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8284

AMD vIOMMU introduces the IOMMU Private Address (IPA) region for
guest-side IOMMU virtualization data structures.

Introduce a per-IOMMU v1 paging domain in viommu_pdom, allocate
8MB of backing memory as four 2MB subregions, map them into the
domain, and add viommu_private_space_init() /
viommu_private_space_uninit() as a matched pair.

For more info, see section vIOMMU Private Address Space of the
IOMMU specification [1].

[1] https://docs.amd.com/v/u/en-US/48882_3.10_PUB

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu.h       |   8 ++
 drivers/iommu/amd/amd_iommu_types.h |  11 ++
 drivers/iommu/amd/iommu.c           |  25 ++++-
 drivers/iommu/amd/viommu.c          | 165 ++++++++++++++++++++++++++++
 4 files changed, 204 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 2ce207529ea0..279f458becda 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -31,6 +31,7 @@ void *__init iommu_alloc_4k_pages(struct amd_iommu *iommu,
 				  gfp_t gfp, size_t size);
 u8 __iomem * __init iommu_map_mmio_space(u64 address, u64 end);
 void __init iommu_unmap_mmio_space(struct amd_iommu *iommu);
+int iommu_flush_dte(struct amd_iommu *iommu, u16 devid);
 
 #ifdef CONFIG_AMD_IOMMU_DEBUGFS
 void amd_iommu_debugfs_setup(void);
@@ -39,6 +40,8 @@ static inline void amd_iommu_debugfs_setup(void) {}
 #endif
 
 extern bool amd_iommu_viommu;
+extern const struct pt_iommu_driver_ops amd_hw_driver_ops_v1;
+extern const struct iommu_domain_ops amdv1_ops;
 
 /* Needed for interrupt remapping */
 int amd_iommu_prepare(void);
@@ -56,6 +59,8 @@ extern bool amd_iommu_hatdis;
 /* Protection domain ops */
 void amd_iommu_init_identity_domain(void);
 struct protection_domain *protection_domain_alloc(void);
+struct iommu_domain *amd_iommu_domain_alloc_paging_v1(struct device *dev,
+						      u32 flags);
 struct iommu_domain *amd_iommu_domain_alloc_sva(struct device *dev,
 						struct mm_struct *mm);
 void amd_iommu_domain_free(struct iommu_domain *dom);
@@ -100,6 +105,9 @@ void amd_iommu_domain_flush_pages(struct protection_domain *domain,
 void amd_iommu_dev_flush_pasid_pages(struct iommu_dev_data *dev_data,
 				     ioasid_t pasid, u64 address, size_t size);
 
+int amd_iommu_flush_private_vm_region(struct amd_iommu *iommu, struct protection_domain *pdom,
+				      u64 address, size_t size);
+
 #ifdef CONFIG_IRQ_REMAP
 int amd_iommu_create_irq_domain(struct amd_iommu *iommu);
 #else
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 44fa1d6c64d6..a5e2f32590d1 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -424,6 +424,13 @@
 /* For vIOMMU, the GID is 16-bit. */
 #define VIOMMU_MAX_GID		0xFFFF
 
+/*
+ * Total IOMMU private region is 8MB (4 x 2MB-subregion)
+ */
+#define VIOMMU_PRIV_REGION_BASE		(0)
+#define VIOMMU_PRIV_SUBREGION_CNT	(4)
+#define VIOMMU_PRIV_SUBREGION_SIZE	(0x200000)  /* 2MB */
+
 /* Timeout stuff */
 #define LOOP_TIMEOUT		100000
 #define MMIO_STATUS_TIMEOUT	2000000
@@ -814,6 +821,10 @@ struct amd_iommu {
 
 	struct ida gid_ida;		 /* guest IDs for this IOMMU */
 	bool gid_ida_inited;
+
+	/* HW vIOMMU support */
+	struct protection_domain *viommu_pdom;
+	void *viommu_priv_region[VIOMMU_PRIV_SUBREGION_CNT];
 };
 
 static inline struct amd_iommu *dev_to_amd_iommu(struct device *dev)
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 6f5ecc48f4ad..8b441f68bc47 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1551,7 +1551,7 @@ static void domain_flush_complete(struct protection_domain *domain)
 		amd_iommu_completion_wait(pdom_iommu_info->iommu);
 }
 
-static int iommu_flush_dte(struct amd_iommu *iommu, u16 devid)
+int iommu_flush_dte(struct amd_iommu *iommu, u16 devid)
 {
 	struct iommu_cmd cmd;
 
@@ -1808,6 +1808,22 @@ static int domain_flush_pages_v1(struct protection_domain *pdom,
 	return ret;
 }
 
+int amd_iommu_flush_private_vm_region(struct amd_iommu *iommu, struct protection_domain *pdom,
+				      u64 address, size_t size)
+{
+	int ret;
+	struct iommu_cmd cmd;
+
+	build_inv_iommu_pages(&cmd, address, size, pdom->id, 0, false);
+
+	ret = iommu_queue_command(iommu, &cmd);
+	if (ret)
+		return ret;
+
+	amd_iommu_completion_wait(iommu);
+	return ret;
+}
+
 /*
  * TLB invalidation function which is called from the mapping functions.
  * It flushes range of PTEs of the domain.
@@ -2726,12 +2742,12 @@ static void amd_iommu_iotlb_sync(struct iommu_domain *domain,
 	iommu_put_pages_list(&gather->freelist);
 }
 
-static const struct pt_iommu_driver_ops amd_hw_driver_ops_v1 = {
+const struct pt_iommu_driver_ops amd_hw_driver_ops_v1 = {
 	.get_top_lock = amd_iommu_get_top_lock,
 	.change_top = amd_iommu_change_top,
 };
 
-static const struct iommu_domain_ops amdv1_ops = {
+const struct iommu_domain_ops amdv1_ops = {
 	IOMMU_PT_DOMAIN_OPS(amdv1),
 	.iotlb_sync_map = amd_iommu_iotlb_sync_map,
 	.flush_iotlb_all = amd_iommu_flush_iotlb_all,
@@ -2746,8 +2762,7 @@ static const struct iommu_dirty_ops amdv1_dirty_ops = {
 	.set_dirty_tracking = amd_iommu_set_dirty_tracking,
 };
 
-static struct iommu_domain *amd_iommu_domain_alloc_paging_v1(struct device *dev,
-							     u32 flags)
+struct iommu_domain *amd_iommu_domain_alloc_paging_v1(struct device *dev, u32 flags)
 {
 	struct pt_iommu_amdv1_cfg cfg = {};
 	struct protection_domain *domain;
diff --git a/drivers/iommu/amd/viommu.c b/drivers/iommu/amd/viommu.c
index 9e6eb2f977ec..c5c85e82c265 100644
--- a/drivers/iommu/amd/viommu.c
+++ b/drivers/iommu/amd/viommu.c
@@ -131,6 +131,167 @@ static int __init viommu_vf_vfcntl_init(struct amd_iommu *iommu)
 	return -ENOMEM;
 }
 
+/*
+ * Allocate backing pages, mark UC, and map at @iova in viommu_pdom.
+ * *@out_va is NULL on any failure.
+ */
+static int viommu_priv_alloc_map_flush(struct amd_iommu *iommu, u64 iova, size_t size,
+				       gfp_t gfp, void **out_va)
+{
+	int ret;
+	void *va;
+	int nid = iommu && iommu->dev ? dev_to_node(&iommu->dev->dev) : NUMA_NO_NODE;
+
+	*out_va = NULL;
+
+	if (!iommu || !iommu->viommu_pdom)
+		return -EINVAL;
+
+	va = iommu_alloc_pages_node_sz(nid, gfp, size);
+	if (!va)
+		return -ENOMEM;
+
+	/*
+	 * IOMMU spec mentions that the vIOMMU backing storage memory
+	 * should be marked as UC.
+	 */
+	ret = set_memory_uc((unsigned long)va, size >> PAGE_SHIFT);
+	if (ret)
+		goto err_free_pages;
+
+	ret = iommu_map(&iommu->viommu_pdom->domain, iova, iommu_virt_to_phys(va), size,
+			IOMMU_PROT_IR | IOMMU_PROT_IW, GFP_KERNEL);
+	if (ret)
+		goto cleanup_mem_attr;
+
+	*out_va = va;
+	return 0;
+
+cleanup_mem_attr:
+	set_memory_wb((unsigned long)va, size >> PAGE_SHIFT);
+err_free_pages:
+	iommu_free_pages(va);
+	return ret;
+}
+
+/*
+ * Unmap @iova, flush the unmapped span on this IOMMU, WB, and free @cpu_va.
+ * Returns 0, or the flush error if amd_iommu_flush_private_vm_region() fails.
+ */
+static int viommu_priv_unmap_flush_free(struct amd_iommu *iommu, u64 iova, size_t size,
+					void *cpu_va)
+{
+	size_t unmapped;
+	int ret = 0;
+
+	if (!cpu_va)
+		return 0;
+	if (!iommu || !iommu->viommu_pdom)
+		return -EINVAL;
+
+	unmapped = iommu_unmap(&iommu->viommu_pdom->domain, iova, size);
+	if (unmapped != size)
+		pr_warn("%s: unmapped %#zx of %#lx at %#llx\n", __func__, unmapped, size, iova);
+
+	if (unmapped) {
+		ret = amd_iommu_flush_private_vm_region(iommu, iommu->viommu_pdom, iova,
+							unmapped);
+		if (ret)
+			pr_warn("%s: IOTLB flush failed (%d) for %#zx at %#llx\n",
+				__func__, ret, unmapped, iova);
+	}
+
+	set_memory_wb((unsigned long)cpu_va, size >> PAGE_SHIFT);
+	iommu_free_pages(cpu_va);
+	return ret;
+}
+
+static void *alloc_private_subregion(struct amd_iommu *iommu, u64 base, size_t size)
+{
+	void *region = NULL;
+	int ret;
+
+	ret = viommu_priv_alloc_map_flush(iommu, base, size, GFP_KERNEL | __GFP_ZERO, &region);
+	if (ret)
+		return NULL;
+
+	pr_debug("%s: base=%#llx, size=%#lx, subregion=%#llx(%#llx)\n",
+		 __func__, base, size, (unsigned long long)region, iommu_virt_to_phys(region));
+
+	return region;
+}
+
+static void viommu_private_space_uninit(struct amd_iommu *iommu)
+{
+	int i, ret, first_err = 0;
+	u64 base;
+	struct iommu_domain *dom;
+
+	if (!iommu->viommu_pdom)
+		return;
+
+	for (i = 0; i < VIOMMU_PRIV_SUBREGION_CNT; i++) {
+		if (!iommu->viommu_priv_region[i])
+			continue;
+		base = VIOMMU_PRIV_REGION_BASE + (i * VIOMMU_PRIV_SUBREGION_SIZE);
+		ret = viommu_priv_unmap_flush_free(iommu, base, VIOMMU_PRIV_SUBREGION_SIZE,
+						   iommu->viommu_priv_region[i]);
+		if (ret && !first_err)
+			first_err = ret;
+		iommu->viommu_priv_region[i] = NULL;
+	}
+
+	dom = &iommu->viommu_pdom->domain;
+	amd_iommu_domain_free(dom);
+	iommu->viommu_pdom = NULL;
+
+	if (first_err)
+		pr_err("%s: private subregion teardown failed (%d)\n", __func__, first_err);
+}
+static int viommu_private_space_init(struct amd_iommu *iommu)
+{
+	int i;
+	u64 base;
+	struct iommu_domain *dom;
+	struct protection_domain *pdom;
+	struct pt_iommu_amdv1_hw_info pt_info;
+
+	/*
+	 * Setup page table root pointer, Guest MMIO and
+	 * Cmdbuf Dirty Status regions.
+	 */
+	dom = amd_iommu_domain_alloc_paging_v1(&iommu->dev->dev, 0);
+	if (!dom) {
+		pr_err("%s: Failed to initialize private space\n", __func__);
+		return -ENOMEM;
+	}
+
+	pdom = to_pdomain(dom);
+	iommu->viommu_pdom = pdom;
+
+	/*
+	 * Each private region requires to 8MB of memory to be allocated
+	 * and mapped. Split the region into 4 x 2MB-subregion.
+	 */
+	for (i = 0; i < VIOMMU_PRIV_SUBREGION_CNT; i++) {
+		base = VIOMMU_PRIV_REGION_BASE + (i * VIOMMU_PRIV_SUBREGION_SIZE);
+		iommu->viommu_priv_region[i] = alloc_private_subregion(iommu, base,
+								       VIOMMU_PRIV_SUBREGION_SIZE);
+		if (!iommu->viommu_priv_region[i]) {
+			pr_err("%s: Failed to allocate vIOMMU private subregion %d\n", __func__, i);
+			viommu_private_space_uninit(iommu);
+			return -ENOMEM;
+		}
+	}
+
+	pt_iommu_amdv1_hw_info(&pdom->amdv1, &pt_info);
+	pr_debug("%s: devid=%#x, pte_root=%#llx\n",
+		 __func__, iommu->devid,
+		 (unsigned long long)pt_info.host_pt_root);
+
+	return 0;
+}
+
 /*
  * Returns VF MMIO BAR offset for the give guest ID which will be
  * mapped to guest vIOMMU 3rd 4K MMIO address
@@ -160,5 +321,9 @@ int __init amd_viommu_init(struct amd_iommu *iommu)
 
 	amd_viommu_gid_ida_init(iommu);
 
+	ret = viommu_private_space_init(iommu);
+	if (ret)
+		return ret;
+
 	return 0;
 }
-- 
2.34.1

