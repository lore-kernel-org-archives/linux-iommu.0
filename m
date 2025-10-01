Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011026.outbound.protection.outlook.com [52.101.62.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703782D8360
	for <iommu@lists.linux.dev>; Wed,  1 Oct 2025 06:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759299032; cv=fail; b=rKw4xw4bUj0LQG5Hz1KWWga9NY+d6PGRRKbax5rCKKy1oqvenrplckVFMk87hfeq90Ave9HYobDCRghfLuXM02L0dZazz2JTM5fcpRL9+dYI80a6/oOr93GzRLKB3PmCfXijAuCDgI52Dn9Si2exhXDAr9eIi86dPDGFe0vzTF0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759299032; c=relaxed/simple;
	bh=dHi8rYzVn5yMIpLJrpt51YrLW3S8IpxsqkdH8KnGoTc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DkEFWn8J4i3WJ9HwKEhsgXA1wye6ASixqkmmq8kFlWIAUWb+sGXjrUNbXP9dEPbottrkQBfNl9ejrMqKzHyOQNAhAmZameJh1UDb2tz8SSIJqi6Vz5Qn8WGD9KyfDIS4YMq1yxwEqSr2+zMNDsf6xQhRBvcA/tNwVG5G8hpVX7g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=h/TEUtdb; arc=fail smtp.client-ip=52.101.62.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="h/TEUtdb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AwWoHyxQsRULy4chiLJzlFO768jmx5zzrJke3Gf+XsDUGEv3tIXdJjQq23oe1eXh/WtDtZ5+GpQ76fK3sIA9npzsQ6Sl1uODY4h6JGKMVSNhjskEExPS77VyLhotdIM2Rwy8lP1+bsvOy7yDbpqDf6Ha3rVBbG8pJEFpP0tTN3pX6NlJx6T+YESTmB0nai9Jppdv57bOxX2xoYtwmpvrMRYZAD+1orpJZ9A3qNXDdAP2kyf8QGt6kglPKLEBWxXiCjysV4OkMEqaoKYMf1AcROjIBckGQFeS5Oj5/BfOLBoDt0ve3/pmcqjI1klGfypJeRTxbPFDhticgMf/yKFHHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rpJ0aKo1KHGVtuIBHopU1ayoE0fA+xTHXDTYNZPqZ5k=;
 b=Aot+ZeIUypyYQzxs8cddI7ivCWOaiXC55DFxYloJ5iQYuR7YbWpU8c7naboWaJAljZO5q646HTZnxaZLm2WjdU+5+9OCQuNBqqZmsZuSHkfjD+zFMFS07uCvmEHtDd1PEJBevrIaU/zihRR9KPthbKVXVIoO8RW5qJ485C1X5P8AIB69RKnWBG2+1aVSxOPcWQkmt22a2LTKOK4Q2d/dTFMqQWMbuQm47ntQ6Eyhj1a+maZcXaWIeylxbIHsH1Kpf5uZzseBWnQVnHBNVxsmWR78e28PDtGqx7uI8ZU0OxsYB9tw2R3BXOmi7bwIjX2ajZAAAo+Argh96Bsq/5vqLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rpJ0aKo1KHGVtuIBHopU1ayoE0fA+xTHXDTYNZPqZ5k=;
 b=h/TEUtdbchIi5U/W0G//AE5DLFl9RkFx7vspOOPF29NIogXbjnpsdJU3+jCeO/ixkdGEdiXikTSC+HXwI+2QsuvzTw1PEeEm/8ScwI8kOVLvwgGkY1SDENnACFUhbmjwT+pDjPvwrL8D2RMHh1U3PVqMapw9t6K3esDb05blU6M=
Received: from SA1PR05CA0004.namprd05.prod.outlook.com (2603:10b6:806:2d2::29)
 by CH1PPF5A8F51299.namprd12.prod.outlook.com (2603:10b6:61f:fc00::60f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Wed, 1 Oct
 2025 06:10:27 +0000
Received: from SA2PEPF00003AE7.namprd02.prod.outlook.com
 (2603:10b6:806:2d2:cafe::ea) by SA1PR05CA0004.outlook.office365.com
 (2603:10b6:806:2d2::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.14 via Frontend Transport; Wed,
 1 Oct 2025 06:10:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003AE7.mail.protection.outlook.com (10.167.248.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.15 via Frontend Transport; Wed, 1 Oct 2025 06:10:25 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 30 Sep
 2025 23:10:19 -0700
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <jgg@nvidia.com>, <nicolinc@nvidia.com>
CC: <linux-kernel@vger.kernel.org>, <robin.murphy@arm.com>, <will@kernel.org>,
	<joro@8bytes.org>, <kevin.tian@intel.com>, <jsnitsel@redhat.com>,
	<vasant.hegde@amd.com>, <iommu@lists.linux.dev>, <santosh.shukla@amd.com>,
	<sairaj.arunkodilkar@amd.com>, <jon.grimm@amd.com>,
	<prashanthpra@google.com>, <wvw@google.com>, <wnliu@google.com>,
	<gptran@google.com>, <kpsingh@google.com>, <joao.m.martins@oracle.com>,
	<alejandro.j.jimenez@oracle.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>
Subject: [PATCH v2 02/12] iommu/amd: Make amd_iommu_pdom_id_alloc() non-static
Date: Wed, 1 Oct 2025 06:09:44 +0000
Message-ID: <20251001060954.5030-3-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251001060954.5030-1-suravee.suthikulpanit@amd.com>
References: <20251001060954.5030-1-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE7:EE_|CH1PPF5A8F51299:EE_
X-MS-Office365-Filtering-Correlation-Id: b7f92f17-9cc9-4dd8-349d-08de00b13658
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mmfqygWc4ClgoKUZ/exEnOhxtAygf3p8Cc4gkq8uPU3zbgqjliNDf9OUyICC?=
 =?us-ascii?Q?COt7nTcK4j2hJ5vdWTXWkTeCESg3C6OdDVbSVThP3a6FKT8JK1kpir7X65XH?=
 =?us-ascii?Q?ncXwYcAeIwvdR6kkAYQCuyGh26LZ1xkylT/CLvKgMGGYsXosfJC8LVLXoUAv?=
 =?us-ascii?Q?0TwN1uiy+Y7IqVv1q1UGCh1s80Eyly+1EI0dKnfcK1MsD0dmK4uT2ir47WsF?=
 =?us-ascii?Q?tMoajNikqnGMcduVySdJqAa1v/VZ0yLeOgcdoXXb65b3/Unn4e4x1ojTBlcO?=
 =?us-ascii?Q?dsF8c+MIvI1BbOsa26ZMLoFN6l1lOc2I/nY7iH0Dk2tMKXMJ/wVlXWt1ccdh?=
 =?us-ascii?Q?u7X3WD1CwpJ+P3c1NZIKtB529jaoaG4JD0x6Tkkdkki6rfoCNNVm24VL6Qu2?=
 =?us-ascii?Q?Ga57RvGXkPegs2T2gkyw3oHGCZwqMGBi6ucmFkvq6M9XahYQvlW6VfLXuGeq?=
 =?us-ascii?Q?9qHk8FV4vZ5I68EWlBbip4Dt25Rwyz19x4s5BoBLYuRctjrBJhfEZQk3Hutp?=
 =?us-ascii?Q?HKl8MaQ8mLIMdJsj5BcsQuVsjVrBRiJ168OqtSqO84ppa2kLLm2PSsvDvahs?=
 =?us-ascii?Q?giOYZj2EbaSGL6kbyd4dM0WPIt0LrB7NTb+4/wquYyuYpfS7xdHvRpCkxrIw?=
 =?us-ascii?Q?9pES0/YaKkCc4s3CbYExggOTCx8FPLN5LRpLFPOjqydQwHuiAGQ1OqNYgP0g?=
 =?us-ascii?Q?l5sYeoUl5POpBUgxzCJlnbZUxiyEKxqViLscbQuFhYtq3dMEjFlUQQquZ/GW?=
 =?us-ascii?Q?HL4mZH34MYXfW6JNTkJ4V9m3nT/A/GWQ8djJX7OsatVoDnXx201PtT1xLQAx?=
 =?us-ascii?Q?CJcj8gL5MB3FNBIjQBnia5XfJc4+3HdT3cravfySGUoLXjRoxJUjttxotxFp?=
 =?us-ascii?Q?XhD4p16YjUYSmXhTrLczyO1xzNpW8OnupC8BvzaZvUvBNIrQbtB2nf+noKDc?=
 =?us-ascii?Q?2ewjTscHyANAg4xDWwLiyFsFgyZcFZHepL+W6fvQdCZiTMzkN/JEN5u49pHJ?=
 =?us-ascii?Q?h/c/KOwkcoNfIc2JUmRLNTG8k1N7aGTrj0tQh51DpkqUyU1ikH/AXDDATfyW?=
 =?us-ascii?Q?ArhwHGpD1LB+w8HyOXlnlhrqmQ5vENJDhzcauDd48HGQT8q6tB37O8rhWefF?=
 =?us-ascii?Q?/x5so8rqD75MRtc+ZwAotnDcymrZbfIY6z72B2NF85MDzk0SfoURRGvE/+7M?=
 =?us-ascii?Q?opeSW4VsqNJzMSo42QQ9CipK5p9ATsnS81TRATzEyz1+7LdWapeTH4AUx1n7?=
 =?us-ascii?Q?/mYl4SSW1Rq6nkGAvI9z1FKnBcz//AWuYL/5zr/R0hpRffsEB5b6zMbamzQy?=
 =?us-ascii?Q?K9Lm2xjGRvbJ4LI0Ii9wLsJL/ERKmIijG56AvJCA9IgtR0xgdxjCT1ZfAi4r?=
 =?us-ascii?Q?nlQsoDkLCUn1wuXKAFGgm+VfYr6+IuO7H7Rxl5Q4bVef9HeDg1WStUoLjjoY?=
 =?us-ascii?Q?hFsi64VYvMzLVr6BS5x938LheOUbeAolc1iqRpqgolHZL7EtgY1JMwH3Sy9Y?=
 =?us-ascii?Q?OAU4syJ3S8wGxFUN4P0yxBqfUBiE5g42lLTetfXzDW4VPCaVJ2OVQ0d+LtVg?=
 =?us-ascii?Q?FMpiYgomlM3Ldszi+hQ=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 06:10:25.3513
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7f92f17-9cc9-4dd8-349d-08de00b13658
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF5A8F51299

To allow reuse in other files in subsequent patches.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu.h | 1 +
 drivers/iommu/amd/iommu.c     | 8 ++++----
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 9b4b589a54b5..6ea549816a1f 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -26,6 +26,7 @@ void amd_iommu_set_rlookup_table(struct amd_iommu *iommu, u16 devid);
 void iommu_feature_enable(struct amd_iommu *iommu, u8 bit);
 void *__init iommu_alloc_4k_pages(struct amd_iommu *iommu,
 				  gfp_t gfp, size_t size);
+int amd_iommu_pdom_id_alloc(void);
 
 #ifdef CONFIG_AMD_IOMMU_DEBUGFS
 void amd_iommu_debugfs_setup(void);
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index a9b17d31a969..78b3e5485006 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1818,7 +1818,7 @@ int amd_iommu_complete_ppr(struct device *dev, u32 pasid, int status, int tag)
  *
  ****************************************************************************/
 
-static int pdom_id_alloc(void)
+int amd_iommu_pdom_id_alloc(void)
 {
 	return ida_alloc_range(&pdom_ids, 1, MAX_DOMAIN_ID - 1, GFP_ATOMIC);
 }
@@ -1906,7 +1906,7 @@ static int setup_gcr3_table(struct gcr3_tbl_info *gcr3_info,
 		return -EBUSY;
 
 	/* Allocate per device domain ID */
-	domid = pdom_id_alloc();
+	domid = amd_iommu_pdom_id_alloc();
 	if (domid <= 0)
 		return -ENOSPC;
 	gcr3_info->domid = domid;
@@ -2489,7 +2489,7 @@ struct protection_domain *protection_domain_alloc(void)
 	if (!domain)
 		return NULL;
 
-	domid = pdom_id_alloc();
+	domid = amd_iommu_pdom_id_alloc();
 	if (domid <= 0) {
 		kfree(domain);
 		return NULL;
@@ -2681,7 +2681,7 @@ void amd_iommu_init_identity_domain(void)
 	domain->ops = &identity_domain_ops;
 	domain->owner = &amd_iommu_ops;
 
-	identity_domain.id = pdom_id_alloc();
+	identity_domain.id = amd_iommu_pdom_id_alloc();
 
 	protection_domain_init(&identity_domain);
 }
-- 
2.34.1

