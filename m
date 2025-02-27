Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2088.outbound.protection.outlook.com [40.107.243.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547E41B0424
	for <iommu@lists.linux.dev>; Thu, 27 Feb 2025 16:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740674076; cv=fail; b=ejMUf4LMY56KCH+dBjhmK5ChpviKr5ec3sC87sqNGrAV61qgyyF4FIpLuBzcOLTzZ523536ADxKrePU1LD1lzvcBBw2n92TXZ6LiyNJVWKTS/7izMR1sWGg1PCUHBt1T6912ovC6hAxVAXuLi4XVf/+BSbbv3EFtU7zC1TE+c4U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740674076; c=relaxed/simple;
	bh=qeB0zEOCvERktapxt87wORby/6MqcNtYQQZlAzfMIwc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mkM0EDWsD9mBX00ZVe/muLk7dPbWXh7NCZFGTkKTQe8sdeeUVQOALEUxew8WWRuoFcxCuDxA7PnmrKX9viFavgH2WJJHKbitTDHWJezj0ElmiC41q9Tpcc/0dHkCGSr6DZf3VXa+Pj29ZLk/3JX78utMIUftmS8Ewi7cqn8PbBk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=o6uwRJOX; arc=fail smtp.client-ip=40.107.243.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="o6uwRJOX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rNOucwOrZi04JQ6hqqVNW138Ck8/ednsJToFaWNdAyTH/04HRRh+yImws4UVfxuXalnVH9MRvRirWP3EKdKoAXPkiuYVwE2ogmYCFwN6N/ll/cic72FbM4+Io+0Y4ub5uneBt/yEp3cpe/SPOmKU4deww0USlCDiHZsI8NY7sl9aLR+1DLo48DRQOd1dcxxERchjuL5ghZYQIoOlUQhGzqqVUtju0KLs9GhENoy2QFP0PXLWg6mu0xM2kJHiUoWXdpsJBWBX40WjhjYdv5+C0f4iUz+/hcoaueCIq5+XLvhodkQY5RULyLSpLzPoaQZpXsYqs3Ym14nN5BxIUREBgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vet3kL1HBJEq2rmkzt6qkxf9WHNbTvFLAIImj7MLhd0=;
 b=URl9wn/EeJvm8N2AthXvqkWyx9uDTPyhQ+PQDuIelVKcUCYOSqBDrm8Jma/cK3WQiDmhkOhkmKUnVWn5DbusLZeiyhmJIyEx0JKaVnui+xXJIQuFKCrDmK17KPEa+wVXdETwMjAXgt5G5pzhre1ofkqOu0hNKU+Jr2FAh6+zBlbqHWRNUcpnsKt7xn4i9D4snHmSLz6BlGZ7wrFBFylUBgvE17IpQBRMP8nduLem/mDObeV4aNvhVO5yObV040/2df3FHoWDKp7EhcWDq7oh2+MWV1RXDs7ijMgePah242x5yChUf1O95grLz4GuGPT9f6XmpgDDKhcGQESwrGXcaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vet3kL1HBJEq2rmkzt6qkxf9WHNbTvFLAIImj7MLhd0=;
 b=o6uwRJOXdDt1S9HShWBDlj/Gn0AL2DlpUd+9Li/ZSzhI1rgpjADD9YOLPaJjZWtqoSuD+SjMDUaa6SDNW4wI9F/uSHe7TpO4lw8XHCSVulFHB1mrmIyPUiL/5CKhjNwrHtu7pkwkLwQgCb1I5mOzz3ko79xuPgzTE/QjEPUGNzI=
Received: from BL1PR13CA0441.namprd13.prod.outlook.com (2603:10b6:208:2c3::26)
 by MW6PR12MB8960.namprd12.prod.outlook.com (2603:10b6:303:23e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Thu, 27 Feb
 2025 16:34:32 +0000
Received: from BL02EPF0002992D.namprd02.prod.outlook.com
 (2603:10b6:208:2c3:cafe::2f) by BL1PR13CA0441.outlook.office365.com
 (2603:10b6:208:2c3::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.10 via Frontend Transport; Thu,
 27 Feb 2025 16:34:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0002992D.mail.protection.outlook.com (10.167.249.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Thu, 27 Feb 2025 16:34:31 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 27 Feb
 2025 10:34:29 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, <jgg@nvidia.com>, Vasant Hegde
	<vasant.hegde@amd.com>
Subject: [PATCH v2 7/7] iommu/amd: Consolidate protection domain free code
Date: Thu, 27 Feb 2025 16:23:20 +0000
Message-ID: <20250227162320.5805-8-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250227162320.5805-1-vasant.hegde@amd.com>
References: <20250227162320.5805-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0002992D:EE_|MW6PR12MB8960:EE_
X-MS-Office365-Filtering-Correlation-Id: 78c04600-8934-412a-1363-08dd574c9d01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zzyCYUjkLc4IN2qx6D84dP4fay9AIvsjLlzFAYSSLDxMCjJDZdNWe85LvpCb?=
 =?us-ascii?Q?A3uMsIp1o0K8XHW08t1sCJQGCTf3k122jdhHLBG/+V+7O+ugNT0B6uwLuI4c?=
 =?us-ascii?Q?38nUcaQ3lsO2X19UAvfURB1tGes7VDIwpUTRkQsrspQa7a/jXT4ibqts16B+?=
 =?us-ascii?Q?10ryN3/tlUeeMxPzzgPMeSoM/PS0qwx19rkmQU8PB9dRvkk2CisqkRrKr0xy?=
 =?us-ascii?Q?EYCc31sjUNu4bR3lRxmNJuxEECCq8k6Npbjr9+2IBbbi5CXzFlgNmqDvx1Oh?=
 =?us-ascii?Q?oU2IsoBOnHtT9P5TaEvjARoAlxR/mHO75zAvle1pM6/VTtSqFSOWV39+KnDH?=
 =?us-ascii?Q?iPWZu30typAVwxZ6gbzrYgGuFCic8MUe3iGyOpemybrlpzC9sDo2VOhm8Zv5?=
 =?us-ascii?Q?oV9yKZhXu9jLdq9xsNgF/jk9b/1dr8Bt0AYn63N612emdOJGhitcdH/m2v3I?=
 =?us-ascii?Q?zmCSSKbJTDKXbaK4HJhWpeNobjBzEKNOGm8d2Q1iNW3sGwpulHbKWsmE+tez?=
 =?us-ascii?Q?+uyP58Qy5c20ZgdPsRteMwD/mweeJ95hGp8hNp01qAhqzumvkSER6lhJjd/V?=
 =?us-ascii?Q?ZPE+adQGlzobltHE73q3RweqyOkI5rgEAWj2ch8FlIEtHgMJTIaOeLU/tTCi?=
 =?us-ascii?Q?NCv0aaJRNtIeaxGsWAi3OMBzzA0iqUwS623yj1O5riFSa+v5zyofWFJrJUfS?=
 =?us-ascii?Q?rGS7MWBSB1oK/D6cSkFD9wYldYf6L20JY9hVLcni5I6ogD7l4RggIJcZvPhf?=
 =?us-ascii?Q?W7Af6ZR028gc1P8IUJ0p0JS4eT1zc79JkPxM9AdYfY0m2Ac9Rwf6/1ITcCjD?=
 =?us-ascii?Q?lalznYvV4CUJ3zQhxEW2kZDj0f06IGZBx8OS8gpCdRmN+ioIU6FgG2HgTeIf?=
 =?us-ascii?Q?eZbJGH8QcAKLs68O/CZFv8cSflvOrYM64+cQIr+613fSdkCv9UENjVWq+yru?=
 =?us-ascii?Q?QwUu08DVI2j/2Fhxl3goSLZaMCECsNCNg2niZqorim2+Xd3eV1zTsN7PVe/W?=
 =?us-ascii?Q?6A1Ah9+BGQebs634mWb/b7wsRkXkTDd4woceNyESxBJBIl7hG7aeX5DPbigp?=
 =?us-ascii?Q?sQz0+JGxOTJzO6WLDO8QbVaPbfZiWiz3GlRjoVOYNJr9bexSTOlw2ad/XuLp?=
 =?us-ascii?Q?1PsCc5OPKkdzW47IQ5hl4lS/zvm+MG3b1Ibi6XButFI3EsQRcT6p35u6Eumx?=
 =?us-ascii?Q?y48YF04QlLIpjfH2I+c+9fMlukxYb6kYCPxxH13Drzzyq5+b57oZRZfpIkA5?=
 =?us-ascii?Q?Mik07MhLfEnYfblpWVr+JK6hlr6xLyqmCc/GJC6UiEbyPRi4rPHMMuLPvC84?=
 =?us-ascii?Q?kvG+licyRgt0wHg51I3BXxOHS3U/y0QZvxV9nS9z685qtdkmUuEBJ319BXRx?=
 =?us-ascii?Q?nUa9wUfyh9MlcvuHxBbI9r9SLSGO0bXGd7zKiiiMjkUOeFdl3lsaRsWpsM2l?=
 =?us-ascii?Q?bDxPbj2NhznR1EwUaX8Tp6lfuGxR5ZrHRw/1CR2zK7HFDDXfN83Jc5qwMefM?=
 =?us-ascii?Q?ae14GERuG9cbqrY=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 16:34:31.9390
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78c04600-8934-412a-1363-08dd574c9d01
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0002992D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8960

Consolidate protection domain free code inside amd_iommu_domain_free()
and remove protection_domain_free() function.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/amd/amd_iommu.h |  1 -
 drivers/iommu/amd/iommu.c     | 15 +++++----------
 drivers/iommu/amd/pasid.c     |  2 +-
 3 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index e3bf27da1339..220c598b7e14 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -47,7 +47,6 @@ extern unsigned long amd_iommu_pgsize_bitmap;
 /* Protection domain ops */
 void amd_iommu_init_identity_domain(void);
 struct protection_domain *protection_domain_alloc(void);
-void protection_domain_free(struct protection_domain *domain);
 struct iommu_domain *amd_iommu_domain_alloc_sva(struct device *dev,
 						struct mm_struct *mm);
 void amd_iommu_domain_free(struct iommu_domain *dom);
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 797c8612966a..534585ea0939 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2434,15 +2434,6 @@ static struct iommu_group *amd_iommu_device_group(struct device *dev)
  *
  *****************************************************************************/
 
-void protection_domain_free(struct protection_domain *domain)
-{
-	WARN_ON(!list_empty(&domain->dev_list));
-	if (domain->domain.type & __IOMMU_DOMAIN_PAGING)
-		free_io_pgtable_ops(&domain->iop.pgtbl.ops);
-	pdom_id_free(domain->id);
-	kfree(domain);
-}
-
 static void protection_domain_init(struct protection_domain *domain)
 {
 	spin_lock_init(&domain->lock);
@@ -2580,7 +2571,11 @@ void amd_iommu_domain_free(struct iommu_domain *dom)
 {
 	struct protection_domain *domain = to_pdomain(dom);
 
-	protection_domain_free(domain);
+	WARN_ON(!list_empty(&domain->dev_list));
+	if (domain->domain.type & __IOMMU_DOMAIN_PAGING)
+		free_io_pgtable_ops(&domain->iop.pgtbl.ops);
+	pdom_id_free(domain->id);
+	kfree(domain);
 }
 
 static int blocked_domain_attach_device(struct iommu_domain *domain,
diff --git a/drivers/iommu/amd/pasid.c b/drivers/iommu/amd/pasid.c
index 11150cfd6718..77c8e9a91cbc 100644
--- a/drivers/iommu/amd/pasid.c
+++ b/drivers/iommu/amd/pasid.c
@@ -195,7 +195,7 @@ struct iommu_domain *amd_iommu_domain_alloc_sva(struct device *dev,
 
 	ret = mmu_notifier_register(&pdom->mn, mm);
 	if (ret) {
-		protection_domain_free(pdom);
+		amd_iommu_domain_free(&pdom->domain);
 		return ERR_PTR(ret);
 	}
 
-- 
2.31.1

