Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011018.outbound.protection.outlook.com [40.93.194.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD309340DBF
	for <iommu@lists.linux.dev>; Fri, 21 Nov 2025 09:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763716383; cv=fail; b=FzjfOeE/7RUE/nL600qvszRGJQcIhY3zLVEmhQAhsJ/koQvUo6AVPBYpta+Q8ZXURmvCJAoqN2im90BlFTfx7/RI7mKmWeGmJG2pJLI8i+/4U+kS2sUvqK4kOtFxii22jfPKQ7Z0ZhOLE/rbPDIDRoY3NUQITl52Yk2i3TlTC/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763716383; c=relaxed/simple;
	bh=mb9atr5QTDMsd1Wqc32GS2iFwxI6QGs1/Re6TEAgwRM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UsCF590/UgBtHDYTdNZ6nBFWT5H9AEOHFuuNWHnJ6PNbin7ENSex2whEk5ANFUeSpaoE3PlFkzXkifKMOi9dTEpWD4goxUwrjrEoFXFgL56qQVheucMUnEPkjbLgBS3sRrKmwarIRa37PNu1JxQavQWoNbFP6w7L+zRpYhM5woI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=R5kaDp56; arc=fail smtp.client-ip=40.93.194.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="R5kaDp56"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I0gLFIibxvzRznTvjHhVhcGoaNo1mK17XgKAeaagQHQhBneKgt4t++BDGq+BmZINr7oyQs+9vtYp+p1bm2pf7vhy3p+mVwkyGUmx/O96KEiNBYSj06VeI45mHePpPx17ch7Jl1zfk4FsIwIWoVIuGFc+LG65nbGRr90JGvAZdu5CDwJZg5SMr88BBbF/i4F3lZMcO9FZu0ToQbps1DjNVbuGk3smZaZWE9APAlKIDNvDgw4UALRHzvjhbm+urvCc/VcNNOAs1eGmNBJyb+V9dTYhi1SyyidSSU8aG5kBmxZYJDci4spuVOzOrylMMTJYCxIqSTOvj4F2QZBxo2IdSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uR+5Phg1ZHu4io4OWmqZ119FZWp3aVfL+9Fa1v4+dLw=;
 b=cU9xcjjnXRqX1MH9/FcVDyvnA/gnKsh+4Qra2OAI9GKULeaChC3rTlehW5B/g93/+L1yW6KV4ORHqD1ncPkWmnCZwrT0kItOGxdcr/pnIHZ/rZWb9PhOqge0dJ8Cq+LAzlKRMKutFgTfkTifv7Chh8sdTm2aBK/ZUt61mOf/Wc1wrtRuqbzlVdnkfrZ0GV45vFLRmw3IbjCZij6+y0CyeFpMsJpp5zHxrEPbojVOIkaeIAc6J4VP/C3BtlwjpT86HESqx6kSCR957KJjZj6rGFsitZkW03bdwMlSFDAvN3uqTzb8/+b1zEu4sbpJyBz4UrRxNzZCzmd8bLdhPoGdaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uR+5Phg1ZHu4io4OWmqZ119FZWp3aVfL+9Fa1v4+dLw=;
 b=R5kaDp56r0P8/CwNbxx9ktAvZtOQ1VXpffGD/ojhPKpDFIetjGyQlGUiJYDZDx4rG/bvrLSUoLzuC85e5hXkbz42vALqPEoe7CbxO5Ac+v6tOGFXATKmgRcOrPgk4FxTsn+HB5qsGJDALf2VtDy3efauhr1bldZsxoDimq5HUNI=
Received: from SJ0PR05CA0082.namprd05.prod.outlook.com (2603:10b6:a03:332::27)
 by BY5PR12MB4148.namprd12.prod.outlook.com (2603:10b6:a03:208::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.18; Fri, 21 Nov
 2025 09:12:56 +0000
Received: from SJ1PEPF00001CE7.namprd03.prod.outlook.com
 (2603:10b6:a03:332:cafe::54) by SJ0PR05CA0082.outlook.office365.com
 (2603:10b6:a03:332::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.4 via Frontend Transport; Fri,
 21 Nov 2025 09:12:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE7.mail.protection.outlook.com (10.167.242.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Fri, 21 Nov 2025 09:12:56 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 21 Nov
 2025 01:12:53 -0800
From: Sairaj Kodilkar <sarunkod@amd.com>
To: <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<vasant.hegde@amd.com>, <robin.murphy@arm.com>, <ashish.kalra@amd.com>,
	<will@kernel.org>, <jgg@nvidia.com>, Sairaj Kodilkar <sarunkod@amd.com>
Subject: [PATCH v2 2/2] amd/iommu: Make protection domain ID functions non-static
Date: Fri, 21 Nov 2025 14:41:16 +0530
Message-ID: <20251121091116.25663-3-sarunkod@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251121091116.25663-1-sarunkod@amd.com>
References: <20251121091116.25663-1-sarunkod@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE7:EE_|BY5PR12MB4148:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d3f4e92-2679-4974-00eb-08de28de289f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pyop/7dmZZRPnCMfg+XxdwoL4TZ5NqKxCzxAI63Aah3LLmVTzNohTzTzoZiv?=
 =?us-ascii?Q?6iNeJwk+S89JF8GldIVHZ0tnu4Rl7b+hOOyPvX2yRYrwEyI5jwkS9Hm+0leU?=
 =?us-ascii?Q?BVykx/bbXMWQmohpxTkC/Aj3YExGyuLPwYhOpnMwILAvgSQs3oRfzEDGb5Qw?=
 =?us-ascii?Q?R8AUajSQPThxsCjdDBqg1gZhaeD3cLEkODHOTdYG8crDZxcKsDsPo9JR6qxF?=
 =?us-ascii?Q?WSKVo6vGu6yu+mk5K2ApdyLlgDu5OrpY1HmrvO7lDLWoXGFYy11jgjjENLI2?=
 =?us-ascii?Q?QOxDN1yhb5TxhqjiVwbXP1k/mBAwvJxxlfGg5hKKaVx9d0Auj3EZw7srNCBs?=
 =?us-ascii?Q?lAwrl2f7nAT+wST3m7gJkMGs1qoGoPETMmu9FJ5OgpySm/CfOJniMM6ggKf2?=
 =?us-ascii?Q?GcHREoNCkFwMr14gbOxNgQyxN4Wu9Pp2DGU3idrduSSmmy9g9q12kJaaIDb4?=
 =?us-ascii?Q?WqMm4Q6NBiqBGij/YWkwNhhUqG9G+aHAldgmCve/fmrYr2FarpPzVKr57/Pf?=
 =?us-ascii?Q?OxdTkQhxabzKD5iVZPa1mnOcW/ylNTVZQrdiN0mrYpLUvnfBa5A3oXpRdIbY?=
 =?us-ascii?Q?LsdthT5g31ryzWGUA6Wjq0O21VnJlZw2nV1s7zwLTXG3km4Nd6ZEGfh/BZxS?=
 =?us-ascii?Q?G/Nft3jcqBbfzFGFOTvUWSd+zP7V71vddG1qqM+1OnOzo7XfJIMACy2zL9Qe?=
 =?us-ascii?Q?u+Rxk+SS1l2iEvYhHuWX+PSz+N2mkUp6CT2hMj01F5tY3Zn2UfYPfnHeMeE9?=
 =?us-ascii?Q?Dsz62bvqoBOSXOGVkboPT1xj68wARkuhpUMRjwrcqwSlaG/BBgHFlQY+Rhdt?=
 =?us-ascii?Q?0T0Q+oPu36CnZCkUQ0a0mZMmuiPW0LNVoUdxt2HY5Y6KR+E1I13haD5Tl101?=
 =?us-ascii?Q?XWBm2wULTCqkWsggTkuR85/3Vx8cdAhswmAgTWU1U3BKl0hRo72Sq520oyvg?=
 =?us-ascii?Q?IbESWZK8Yhindb0Jyvl5tPAPPgRRb3GXJ6sXz2P44Fs7U0GDG4Tga0HXvsq6?=
 =?us-ascii?Q?59FNODcTFfPX1KEx2/F9uNOeJMTasPUuUsb0JTjFmL8qq7WxlyU/ad/ur3Tl?=
 =?us-ascii?Q?jhj/U/tEVqcRJLHYSkAEZ5SBb2vrTgHFtOC5jzQUlJFXvKgkJh3njLVBMVQK?=
 =?us-ascii?Q?9rJL79ReKVIdBtM3jvk9496OwwBWUzkXvGKVfrUdi0fYNy7YJQG0Iz8HzEZX?=
 =?us-ascii?Q?5fTLT3HkmZ7+kWW5uXe2g9cSM51DLNCBeYu3ixhwUoLridBDoFYWruIxqbBv?=
 =?us-ascii?Q?hrwurIkm7F9oCzjys97Gc6pcP+rEVouGriQ1DI4XHCuur3UGlKhpwzkXs4VC?=
 =?us-ascii?Q?CnPkfQmO/My3jISoR2/QMT+DU12VtFO6FtATkte77R83B2a26+GAaos/KACY?=
 =?us-ascii?Q?+fgN8jF1c3y3xjsR3S7rqgcFjX1DNOIU1o4x+NAZUn67ut9IGihgxrQ4ofwe?=
 =?us-ascii?Q?dqWxteSu2lO12gURW2EX29xgCqGxuie5tWOUDL3aDbMRgCUO8hjzAXQorLZw?=
 =?us-ascii?Q?mCSczzXGM0yxGQsRhKQcvVEqbGfAbB0t3qV2Uy+JFSZg5/kXFVXPLue7HwsZ?=
 =?us-ascii?Q?3Y8kVWWXQRsTU1uxgWo=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2025 09:12:56.1209
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d3f4e92-2679-4974-00eb-08de28de289f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4148

So that both iommu.c and init.c can utilize them. Also define a new
function 'pdom_id_destroy()' to destroy 'pdom_ids' instead of directly
calling ida functions.

Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu.h |  5 +++++
 drivers/iommu/amd/init.c      |  7 ++-----
 drivers/iommu/amd/iommu.c     | 27 ++++++++++++++++++---------
 3 files changed, 25 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 25044d28f28a..b742ef1adb35 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -173,6 +173,11 @@ static inline struct protection_domain *to_pdomain(struct iommu_domain *dom)
 bool translation_pre_enabled(struct amd_iommu *iommu);
 int __init add_special_device(u8 type, u8 id, u32 *devid, bool cmd_line);
 
+int amd_iommu_pdom_id_alloc(void);
+int amd_iommu_pdom_id_reserve(u16 id, gfp_t gfp);
+void amd_iommu_pdom_id_free(int id);
+void amd_iommu_pdom_id_destroy(void);
+
 #ifdef CONFIG_DMI
 void amd_iommu_apply_ivrs_quirks(void);
 #else
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 14eb9de33ccb..fe0851ebf397 100644
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
-		ret = ida_alloc_range(&pdom_ids, dom_id, dom_id, GFP_KERNEL);
-		if (ret == -ENOMEM)
+		if (amd_iommu_pdom_id_reserve(dom_id, GFP_KERNEL) == -ENOMEM)
 			return false;
 	}
 
@@ -3132,8 +3130,7 @@ static bool __init check_ioapic_information(void)
 
 static void __init free_dma_resources(void)
 {
-	ida_destroy(&pdom_ids);
-
+	amd_iommu_pdom_id_destroy();
 	free_unity_maps();
 }
 
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 48bca4dc8eb6..af517e7cfffd 100644
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
+int amd_iommu_pdom_id_reserve(u16 id, gfp_t gfp)
+{
+	return ida_alloc_range(&pdom_ids, id, id, gfp);
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

