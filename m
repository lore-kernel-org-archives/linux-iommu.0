Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2086.outbound.protection.outlook.com [40.107.237.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E161A0AE1
	for <iommu@lists.linux.dev>; Wed, 23 Oct 2024 10:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729680292; cv=fail; b=eesl6pIH7P1lFsQQy/TV/famNnz7eun3JSk0FRkSU6uvm1UP6kceiaGA9vR2oNjL5+wzb5KMfjQY+kbXB7d2t12qIqjt5/tZv7YMyZEVzmnVTv6mPY/dYB/s0y2EoEkWijNywGJPyfEn7u2jNWGDoau/wQL/+QIiQ26APGxEMqA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729680292; c=relaxed/simple;
	bh=o+fDW1XAsGMbprzOqLi+tbAuKNFscPOlEAcJSKA5DEI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yj2eex8br1/qIc3H4ZG8IRkPvUaJDClsFi1UTk98oxrwJ+4LwTNMXWHMG1fV8J2l1vJnIq/3V5JE4HU2qLXJW8oeYXM0hrzWCDZ7YbvTOMGCG44y+x3YjP5o6uL/bqy+Dc8vW6y9NXvwEUHe/6Xg9wnTbzEu9oiip1oSLqPqsQE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Rs//rb17; arc=fail smtp.client-ip=40.107.237.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Rs//rb17"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ko5PKQOT3ODWndtmmHEyVv6VIK2ofYGLguDTNfekEFirU/VP7L5UEP6Ru6HujmmndT08vBc5G2dygmVIRd6cVYDFdgXbdYiut5bLK/wbmJcTt4vQg6xmdmdvlG1T51zznWT5muObSb2R65378fKV73dXeuotHv/uOo42y+v6jbOiTYd/Xziyh/8eMDFfZpJ5iYXA7y1l+27m3DpZb38kTe/PYgZwpXXLPBKI6JBI8ruHrWpZxveK45iy4OCRX/RbU1OM1VaoqdqFZdVvMzFVFNH83eV9olccMpPh2d0OX/eBZdXP6qGhIgEyV0PaGpx5qWiiyCKgAqDbgnb7941a+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o9MMwbRqZRxMz1sIXe8u/Sw4tRsCUkgRyTrym2olJR0=;
 b=Cdb3F9NjHpZB7ASUT43++HQU/ENle/QKXpF6I5h8DD/FSzSlXK6Y/t3Ms5nYk3M86n39PBtBMssHzlKV6l+Xb5YhBgyeZa5prV/cWS3g0Xgfj+92jOgYJ0l6rowmJtQTGSos3xFkNgAZ5/tBZVmkrGtOOCSC3/g1xuvD9hwxpVXudL1n0YuRqh26Xmj+/e7DLNrCajfccFv7B2czgO8jrqcnfBw5UC9B8s3dcvWnJebjP5R4k3GoR2EIzEc4ug0oit8kAanaqNohFFYrLQ8fEGtrBG8iFlVZCZJJFvMzCOET4kFYt17Fb+YMn/1HCBXDPWwszyz2vrDFnJeJ0N6tpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o9MMwbRqZRxMz1sIXe8u/Sw4tRsCUkgRyTrym2olJR0=;
 b=Rs//rb17svgGmXg8HTf0SpbBhXXXuxpAVfByPOSb5afci6epJCQB2me7DHMRUeVK8CQpqJenWblK+psezmHT73VWMXJmoHuXlxiUT2YYSS8Q9DxrQOwMztgVzfQFcxM5N8z2IcE2Hz4Np4RAao2IdPN5Z17hY3ea4Ur6V9UxoVs=
Received: from MW4P222CA0009.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::14)
 by MN0PR12MB5714.namprd12.prod.outlook.com (2603:10b6:208:371::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Wed, 23 Oct
 2024 10:44:47 +0000
Received: from BL6PEPF00020E63.namprd04.prod.outlook.com
 (2603:10b6:303:114:cafe::7c) by MW4P222CA0009.outlook.office365.com
 (2603:10b6:303:114::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28 via Frontend
 Transport; Wed, 23 Oct 2024 10:44:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E63.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Wed, 23 Oct 2024 10:44:46 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Oct
 2024 05:44:42 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, <jgg@ziepe.ca>, <yi.l.liu@intel.com>,
	<baolu.lu@linux.intel.com>, <kevin.tian@intel.com>,
	<jacob.pan@linux.microsoft.com>, Vasant Hegde <vasant.hegde@amd.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>
Subject: [PATCH v4 08/12] iommu/amd: Pass page table type as param to pdom_setup_pgtable()
Date: Wed, 23 Oct 2024 10:42:03 +0000
Message-ID: <20241023104207.5894-9-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241023104207.5894-1-vasant.hegde@amd.com>
References: <20241023104207.5894-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E63:EE_|MN0PR12MB5714:EE_
X-MS-Office365-Filtering-Correlation-Id: d75365a0-fdb9-4b66-6314-08dcf34fb67b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Iz/dMpHH+OtadpDmadi9tDYCCoHu2uvGhnBq34Z5pg/f3UBS1PKOGMYQnegI?=
 =?us-ascii?Q?kJNnlrsI6iTTyVXJrqfn4qr5zs/W8x/nVXFPXMNGpwOpZYVA+BF5x66zBB0O?=
 =?us-ascii?Q?FehdX4Ojng/Pl7vHcRQO2kr8dd4L1oZDIXJtIBr9oBm0t0DIMSVqF0vHvGy2?=
 =?us-ascii?Q?3gP8SUiSur109eGOmJq/sbxBDL1De9+UTjaucZww9oxa4o5oRxs8slk6a40s?=
 =?us-ascii?Q?hE0+qME844D6Bll2LmInr2goX1JoiYMGdXahgkEdTZW7q9AnatpAD4/IlPtr?=
 =?us-ascii?Q?yVDPLOqetqPeN7tpdTd71Trm6QHZk0a1xBW4eq5Y6Jcrkah1UREkRddE+OwB?=
 =?us-ascii?Q?oA11nFuM0ucr+JY0151+Mh4TVYKMV4Vo2x4Gjyf0CgtBHimSIErZ/LJsLiZc?=
 =?us-ascii?Q?rvZEwccVf0s90w0iZfWX3eVXpJjJda62EnPGHlkn3xdPKygi0K3fmfUT5e1J?=
 =?us-ascii?Q?75G43PHRoRuLg4LXxqK2lW+q+2Jg4XtbJmkahL5D4/bU8i00Usr0Ge80uVUn?=
 =?us-ascii?Q?Nu2gTxgHeE4gaUiesQ2KnUSUplzrBsIw6zm+h/uNOynayaghYhsjnCJ7WekL?=
 =?us-ascii?Q?VdE+xCoecncCiJ6ROJNfrLgeWY9pcG3RiMLuJxrjEWPHSS/W+ncEKqe8NCnR?=
 =?us-ascii?Q?O8E30N8C2gbFqySLGDFvAIxCpXg6uEtfYw9CJlhJfXhlbR8NqSVepraU76yp?=
 =?us-ascii?Q?F3EgYerTYHDjaW07uBW3P/wIhxesYikK0fYBL7wG3XhtkcfiBnzPsoxxBQQM?=
 =?us-ascii?Q?qUvLWBwWDagUvwvTK3xJE84lqLYPvPnzuSQzq+84aNGOdKuyRFgyaq8LFKDa?=
 =?us-ascii?Q?VZOiyz7RkJHFuw1CgvDw+NLTUEvuh2MXs4CsktrHeprUcyxRE/jVTROoXYC3?=
 =?us-ascii?Q?R6iuqpFNmqn+uMo8eOKEo+MGAyIvQc2lgoUssygzVI/iQJAvUP+ebOt5IfqB?=
 =?us-ascii?Q?bRwkcruQYMfgYuvGSmgEuhzcXqaVXqRX/PKJwg13fsmSypCrR9s/5u+b/YBE?=
 =?us-ascii?Q?lHILgdggIR3yhPKVcxneUsBrJydcctWU+zxPc5h0VDjN629JBf48ZD3MeqDd?=
 =?us-ascii?Q?bhGGn3OJkSLF/T9Q3NQ4ToRkTZKn9OMafWiYYclLrLJPnxx2/pj/5M4a+wpH?=
 =?us-ascii?Q?Cnhsu0xg/OghpxSGyPxeYL7QaWxWqijaCGsZjjfnveU1IWlfVsvhwezToFPS?=
 =?us-ascii?Q?7tRiZZaPsOPa4kz1DPZ+S0haDYz2JSCcvRhpHUMDPox9DBNMZJ90d2Q1c008?=
 =?us-ascii?Q?yHImH11z4P27EiqjFM1CuzPhB9M7l/iebhCVwYdwf+i/L0ThnUXmk0A8ujhf?=
 =?us-ascii?Q?vdW2V0HVamcKbDzwffsxnDiIOM0vUyYATYwVomFyn0q/+Hl8SwHkvQaNboGv?=
 =?us-ascii?Q?x7hZ7NQP/CHvpkBar4fDS5P7syH9RIWyNFTRa7RoUAAIbKEyyQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 10:44:46.8492
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d75365a0-fdb9-4b66-6314-08dcf34fb67b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5714

Current code forces v1 page table for UNMANAGED domain and global page
table type (amd_iommu_pgtable) for rest of paging domain.

Following patch series adds support for domain_alloc_paging() ops. Also
enhances domain_alloc_user() to allocate page table based on 'flags.

Hence pass page table type as parameter to pdomain_setup_pgtable(). So
that caller can decide right page table type. Also update
dma_max_address() to take pgtable as parameter.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Jacob Pan <jacob.pan@linux.microsoft.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/amd/iommu.c | 43 +++++++++++++++++----------------------
 1 file changed, 19 insertions(+), 24 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 6285fd1afd50..cb6a72564c23 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2286,28 +2286,13 @@ struct protection_domain *protection_domain_alloc(unsigned int type, int nid)
 }
 
 static int pdom_setup_pgtable(struct protection_domain *domain,
-			      unsigned int type)
+			      unsigned int type, int pgtable)
 {
 	struct io_pgtable_ops *pgtbl_ops;
-	int pgtable;
 
-	switch (type) {
 	/* No need to allocate io pgtable ops in passthrough mode */
-	case IOMMU_DOMAIN_IDENTITY:
+	if (!(type & __IOMMU_DOMAIN_PAGING))
 		return 0;
-	case IOMMU_DOMAIN_DMA:
-		pgtable = amd_iommu_pgtable;
-		break;
-	/*
-	 * Force IOMMU v1 page table when allocating
-	 * domain for pass-through devices.
-	 */
-	case IOMMU_DOMAIN_UNMANAGED:
-		pgtable = AMD_IOMMU_V1;
-		break;
-	default:
-		return -EINVAL;
-	}
 
 	switch (pgtable) {
 	case AMD_IOMMU_V1:
@@ -2319,6 +2304,7 @@ static int pdom_setup_pgtable(struct protection_domain *domain,
 	default:
 		return -EINVAL;
 	}
+
 	pgtbl_ops =
 		alloc_io_pgtable_ops(pgtable, &domain->iop.pgtbl.cfg, domain);
 	if (!pgtbl_ops)
@@ -2327,9 +2313,9 @@ static int pdom_setup_pgtable(struct protection_domain *domain,
 	return 0;
 }
 
-static inline u64 dma_max_address(void)
+static inline u64 dma_max_address(int pgtable)
 {
-	if (amd_iommu_pgtable == AMD_IOMMU_V1)
+	if (pgtable == AMD_IOMMU_V1)
 		return ~0ULL;
 
 	/* V2 with 4/5 level page table */
@@ -2342,7 +2328,8 @@ static bool amd_iommu_hd_support(struct amd_iommu *iommu)
 }
 
 static struct iommu_domain *do_iommu_domain_alloc(unsigned int type,
-						  struct device *dev, u32 flags)
+						  struct device *dev,
+						  u32 flags, int pgtable)
 {
 	bool dirty_tracking = flags & IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
 	struct protection_domain *domain;
@@ -2367,7 +2354,7 @@ static struct iommu_domain *do_iommu_domain_alloc(unsigned int type,
 	if (!domain)
 		return ERR_PTR(-ENOMEM);
 
-	ret = pdom_setup_pgtable(domain, type);
+	ret = pdom_setup_pgtable(domain, type, pgtable);
 	if (ret) {
 		domain_id_free(domain->id);
 		kfree(domain);
@@ -2375,7 +2362,7 @@ static struct iommu_domain *do_iommu_domain_alloc(unsigned int type,
 	}
 
 	domain->domain.geometry.aperture_start = 0;
-	domain->domain.geometry.aperture_end   = dma_max_address();
+	domain->domain.geometry.aperture_end   = dma_max_address(pgtable);
 	domain->domain.geometry.force_aperture = true;
 	domain->domain.pgsize_bitmap = domain->iop.pgtbl.cfg.pgsize_bitmap;
 
@@ -2393,8 +2380,16 @@ static struct iommu_domain *do_iommu_domain_alloc(unsigned int type,
 static struct iommu_domain *amd_iommu_domain_alloc(unsigned int type)
 {
 	struct iommu_domain *domain;
+	int pgtable = amd_iommu_pgtable;
+
+	/*
+	 * Force IOMMU v1 page table when allocating
+	 * domain for pass-through devices.
+	 */
+	if (type == IOMMU_DOMAIN_UNMANAGED)
+		pgtable = AMD_IOMMU_V1;
 
-	domain = do_iommu_domain_alloc(type, NULL, 0);
+	domain = do_iommu_domain_alloc(type, NULL, 0, pgtable);
 	if (IS_ERR(domain))
 		return NULL;
 
@@ -2412,7 +2407,7 @@ amd_iommu_domain_alloc_user(struct device *dev, u32 flags,
 	if ((flags & ~IOMMU_HWPT_ALLOC_DIRTY_TRACKING) || parent || user_data)
 		return ERR_PTR(-EOPNOTSUPP);
 
-	return do_iommu_domain_alloc(type, dev, flags);
+	return do_iommu_domain_alloc(type, dev, flags, AMD_IOMMU_V1);
 }
 
 void amd_iommu_domain_free(struct iommu_domain *dom)
-- 
2.31.1

