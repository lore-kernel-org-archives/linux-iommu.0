Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3ED1DDC11
	for <iommu@lists.linux.dev>; Thu, 17 Oct 2024 14:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729173866; cv=fail; b=A1JzixAa1o4OAM2p3z5apeHLf2nOyu51I2EcN9Cgb+/cX9+YDFVGlle+DN+Ymbxt/j7e6aLPIrmpdH+d3ryYNEFDm7IK1f+zLhXqYsLjAa57J8paJaUXFphIbF7IPQB8qhwN1z9ktBShM8rnkhjUHOOt0AYnpKk6q6IBq073zIY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729173866; c=relaxed/simple;
	bh=Z19XzstU9RGmoja06WjDU6n/icAqIfGg5A+tFD6RSo4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gina6CrKFAs9QQlEGlpaksNW8kzU/DKDZHE38SidB5AkBnseOdtjHNn1PVsc19o7Luc/KRey/AILRsfhFK2OXdeqHWmRyb9Yp0BSvypmNajxU1oXXO376Ig5O52T0pwNZ1A6apH7LfP+AZYEMxC55rxcCtznHxsRV6qeJgGrivI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qOCRGmTQ; arc=fail smtp.client-ip=40.107.92.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qOCRGmTQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yc+RC/tdKVP0oTBjyITEDCoXiX+Xoa008PspWVZS6k3HpHx5XmJkEZNx/9attFlyyMZ7UTGYXrljiIw9nWYXJXm6Zg/TWLfjnXZdSNI/bEsPNZHm1LKbMuZBKPmb3TfhHw610sv90pyC59W6BH586CPmpqlMIEyF15TBQIAFOqX12bCrLzBAsfmgPfxKcXGc77pAEFF2PL9hKsOwAVZwggojbOUzue4wK5MT+6eAJJsgcjq3QQNdAYbvJqfwvwv9rXzzowFU+sZiK/Wi3nNQ3OQmTIHASFLzSpYP+cwrmNkCnUsI4fFsmk4zxlQaaKhEepqCoeHPGZsJSdFhXpCqRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Y0nssoGGwySsraOilC2Nvd8tX4/Sm945i5Z65+uHSI=;
 b=ehshIEWJdFdkY9RRBtd3ngvH+dO+iU9PxV78KOAZcltz6a7Iis0gZfIvGnmvOSPeaBiBXiY3ppHw8x0XckLZJmkAgikitjeCiG7o9o4BafcaxAJ4oYuAnA6f4DIut1FwtC19a1JpyP4/ySyvqHIorkdMEKSzZctgFWaQl/qf4nRodXe+BLuq/+Vieyd0dOfWBFcYow8nzteiB6Pq1jUSPDqOoIQuRgfKb6rJ1CuM1Mb//yUYOpESd5yqzxScwIUuQwyJMq/OeqXs8jkfSZ1LWHaGi+h4nJnIKp8dBfsnPA0EeS7RrYtDH//lpYG74SeNgGYESBHMmTXfVWnghivvDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Y0nssoGGwySsraOilC2Nvd8tX4/Sm945i5Z65+uHSI=;
 b=qOCRGmTQobsXHf6MyNUZdMenpSjTA2RjSzhiOHZRqQGfBqVJ9AZdyA8xBr08jE3u4ajqg/CPmjwFW8+ZpYRtjGatI8XKXt1oLBMKtRSpIMdeus0d88/U3fwViA6+mCUOjLCePxVAEZxIqUjg2JtwxoQxvWwe+sYs/qohKdHumdE=
Received: from CH5PR05CA0016.namprd05.prod.outlook.com (2603:10b6:610:1f0::21)
 by SN7PR12MB7347.namprd12.prod.outlook.com (2603:10b6:806:29a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Thu, 17 Oct
 2024 14:04:16 +0000
Received: from CH1PEPF0000A346.namprd04.prod.outlook.com
 (2603:10b6:610:1f0:cafe::7b) by CH5PR05CA0016.outlook.office365.com
 (2603:10b6:610:1f0::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.10 via Frontend
 Transport; Thu, 17 Oct 2024 14:04:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A346.mail.protection.outlook.com (10.167.244.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Thu, 17 Oct 2024 14:04:16 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Oct
 2024 09:04:11 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, <jgg@ziepe.ca>, <yi.l.liu@intel.com>,
	<baolu.lu@linux.intel.com>, <kevin.tian@intel.com>,
	<jacob.pan@linux.microsoft.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v3 08/12] iommu/amd: Pass page table type as param to pdom_setup_pgtable()
Date: Thu, 17 Oct 2024 14:01:33 +0000
Message-ID: <20241017140137.6028-9-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241017140137.6028-1-vasant.hegde@amd.com>
References: <20241017140137.6028-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A346:EE_|SN7PR12MB7347:EE_
X-MS-Office365-Filtering-Correlation-Id: 2037812a-8e24-43a5-5043-08dceeb49652
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?w5zObrPcoksQSj8wzp5kaKAf0/FqJ75N89UI22KRByMSWZs6eEFYm82taUiJ?=
 =?us-ascii?Q?n9EO1OzwWK7Aege4NuR7GmmhPPfxFInc7/3rvyi4EYS4vtT8XNORRFfe0Dlu?=
 =?us-ascii?Q?XoetmhQK1AkpJeOsCzF5RInFLGsu+Fh8nSBBnf2mNKkf+OIhBCYgppwINgQn?=
 =?us-ascii?Q?mHQFEetn3AGCs16YNpTBjJ4ZZKx/pTv2KqAMfWUYWUt4YRbE/rIxhnhtnHZj?=
 =?us-ascii?Q?D2M76qEq6e/JRiHqX1X4/alRQA0KUF/pspoVkfP1Rnw6MBd9u0hI8Ry9iBX6?=
 =?us-ascii?Q?UuZn4JIsNfkDJaD2geOkbFpdJV5YDmtbg8sgAsX9ocEMWEfbXLub+yGDv1Wf?=
 =?us-ascii?Q?qIdYm35vevmVe1OrnXiVHGcpa1IAHOOwVqFBth7II9wGHVdI8nRv5KfesNia?=
 =?us-ascii?Q?N8zbwsViC5/nFhV+OOdtme6U/MeTLQOQyObz5G3jaeYm/nYUy+x6Fep/XMBe?=
 =?us-ascii?Q?9QtcSjdyMwaHMPdo4jLandhwNyfmLQ5WU1uFxPSlrU4gnotJ4hz36yP7iRWf?=
 =?us-ascii?Q?NXnXazlhpbXcn21D+zTWsgqrYTjIb53kkX6VbEyuXnK6oEkOw/l7JP3gP/5L?=
 =?us-ascii?Q?JfbTSRMjJLx7WbF0RtKeyP29y8ytW/hre41qJQ3B86Ms3I9W8DIjJjw1doi0?=
 =?us-ascii?Q?mp9egPwpAmBwmn4WIjKAePNmbu1UxLOYGTSnPXyvOxy0R0yheOnWtC48qObt?=
 =?us-ascii?Q?ctVWgi4c2caBz/UfPajtA7e7T9BrftjvIzPrnfKZw8oXqEz0ZNlLwHa0EF82?=
 =?us-ascii?Q?beZAk9uZnU3xeCgqMDJTuOpNBYxyCodB1CwY9hd0sU6azStiTiswGoqEPWGA?=
 =?us-ascii?Q?wPBMvBfKE7voA8gl7eLTC3yVT/ubDSbWKU/JnU04DGZ+rZnhsiZiHsDy0hzx?=
 =?us-ascii?Q?gR/R3YQyd6nH2XIV3tAAkO/FlfnrAG5JvlcqXu+wK5W1L69Zl6Prpq0bZA8K?=
 =?us-ascii?Q?UFmSTrIcncuyOgUuy2Uadwx+jStIhKDq7dQ2vxpO3ZLpowr8K4WEFjgdbbIS?=
 =?us-ascii?Q?RM/XfjA7dkriD4XrUZC5ID+ZoewfJfdr/90PkoD0QMDS6rUMAN+JuOIuImlu?=
 =?us-ascii?Q?uu576rqx0Iu0sXLuCf00h++oiS0vfHlTxw9WeU8YWA8q/Jg3KfjDSNzg5c3z?=
 =?us-ascii?Q?ZEXIjS00N8U4tZJL34evU2WQFGih6YY/hN3oXrJGbnktuYcaoXGapu8zVyTa?=
 =?us-ascii?Q?GUao7FwXX5WMf3qKAxRkVO5PqgXJ6ei6+2cCFRZ6V3D4DRuRG6iK38pBhP5/?=
 =?us-ascii?Q?l4S5VxzuHRvbhmYJ2ib70CFzw89vFsIOzD6qrbyCigBeaFlSi7EOqp1bnIZI?=
 =?us-ascii?Q?+tTzeeeIs1GQ45+1QyazvEXGyHabvrga4ev96889sDgadgpnF1iyHbinFiMj?=
 =?us-ascii?Q?OJeQXHji7UP/7+iLnJlxmI0XpqSzPgvT6jORVCchiJnLJ4A0Wg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 14:04:16.2331
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2037812a-8e24-43a5-5043-08dceeb49652
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A346.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7347

Current code forces v1 page table for UNMANAGED domain and global page
table type (amd_iommu_pgtable) for rest of paging domain.

Following patch series adds support for domain_alloc_paging() ops. Also
enhances domain_alloc_user() to allocate page table based on 'flags.

Hence pass page table type as parameter to pdomain_setup_pgtable(). So
that caller can decide right page table type. Also update
dma_max_address() to take pgtable as parameter.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Jacob Pan <jacob.pan@linux.microsoft.com>
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

