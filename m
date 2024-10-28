Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2054.outbound.protection.outlook.com [40.107.92.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7BB01D0BB1
	for <iommu@lists.linux.dev>; Mon, 28 Oct 2024 09:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730108456; cv=fail; b=of4TSoX6G+XZ0OCnmU2krFKsQkxsnhe7B/IBocnabOKd6FGdTorsnGSppUQ15HJn9xtTPCr8M+MiOZbgwDwycbchSA4G0LTQDP/EzuQzHFbCih3N0r4BejNFWK3BehZAQFAUJ8/jQKNzi/S84hrG/R6CwwG7j3zMjh8k9oglK4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730108456; c=relaxed/simple;
	bh=o+fDW1XAsGMbprzOqLi+tbAuKNFscPOlEAcJSKA5DEI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VGDdYUriJVPCXjrcCrABOvnB16O4PQ+MXpkt+ndluZ12Voq7gz4GCZFlzQxkU+aGyVYuq90ekdjI51xJsXBMkP5J4p47w3ggjbSZD7wfjURoHW2UElTvAKzKW2NiZTkEG8N5xqfnFEzlaek8DjAZQxpANoJbQnMI6dJm39y7VR8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Ria1ctk/; arc=fail smtp.client-ip=40.107.92.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ria1ctk/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NnK6buWRSOcfU02iLPVnlNox9k+GAZM+WVqsv9GztHGEnJIq6HCHlzU6kFYvQi187z88C2wR8Y7xoQfXmOvBMLIMYurMM34Wk0OGjbpYtcFW1uvxlm7tutF0Nx4vQWzJWkVuDmtv+B0WwBzwX+O9LOyl9QegkljNwO+mcMHeTbkbHlXNXC945Ac5LEwzLX76fGZD8QoaZ1U166PkAE0izJYwbgVQQnkEwFGc7eIKfH4yHv4Ugw04+9kP46S/3glYw25IfqWPm+1hdtFBlM32vhC3ht4YgkIY1GWQsdGGBO9f/Q6gDPuemB20PWrx3xSuMy0HScCc5zQbrb+ICIEJxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o9MMwbRqZRxMz1sIXe8u/Sw4tRsCUkgRyTrym2olJR0=;
 b=C6Hw5ZlyIFTBbepJekzx4Pd0IxkwTbqOSWlydry87le8ZzfJG8dXnr3AkhWNiIzIGgDyTamBqGvykwDKzNMEx3Tabk5PJ6O7NGJyP8WW3KAKEanGD5Z5O7fudGO7UeXzUAf+3xtKYvtM86+oYka4wn2xNVmyam3Y6izu8e+FpeMUjzL9RXVxQM0ZnFW7GVPnHoGjiSlGUUdogPfHgixRBkU9lmBHVzwn1MHeiWexYzcIK7Yqeu6n5Krm2mPsh7IO6tVdS21a3pGXsD6iWIzXQR2G2M5E+p3vpL2Ly0cism0LuVQkJm3tjqTiJ1yDnUB2a0qyZ/U5GtZfHG2OSZCMlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o9MMwbRqZRxMz1sIXe8u/Sw4tRsCUkgRyTrym2olJR0=;
 b=Ria1ctk/ZOmCmBohTHzWzEMglOvgZe6uAkOC5NdlOLWU793ejqhgUkOZ3APrUNNwE2BJPpqc+2gh9A7VBx6X7NaT9WN6nwM0eEBQg+3HTfWrbWxW/JUzgNOv9CQ6V6G3CfW9hy6PKKReX0V6r2l3kG13lCiDeGhu5V2VbGNFXMo=
Received: from BY3PR05CA0023.namprd05.prod.outlook.com (2603:10b6:a03:254::28)
 by MN6PR12MB8589.namprd12.prod.outlook.com (2603:10b6:208:47d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.22; Mon, 28 Oct
 2024 09:40:51 +0000
Received: from SJ1PEPF0000231A.namprd03.prod.outlook.com
 (2603:10b6:a03:254:cafe::bb) by BY3PR05CA0023.outlook.office365.com
 (2603:10b6:a03:254::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.9 via Frontend
 Transport; Mon, 28 Oct 2024 09:40:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF0000231A.mail.protection.outlook.com (10.167.242.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Mon, 28 Oct 2024 09:40:50 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Oct
 2024 04:40:45 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, <jgg@ziepe.ca>, <yi.l.liu@intel.com>,
	<baolu.lu@linux.intel.com>, <kevin.tian@intel.com>,
	<jacob.pan@linux.microsoft.com>, Vasant Hegde <vasant.hegde@amd.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>
Subject: [PATCH v5 08/12] iommu/amd: Pass page table type as param to pdom_setup_pgtable()
Date: Mon, 28 Oct 2024 09:38:06 +0000
Message-ID: <20241028093810.5901-9-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241028093810.5901-1-vasant.hegde@amd.com>
References: <20241028093810.5901-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231A:EE_|MN6PR12MB8589:EE_
X-MS-Office365-Filtering-Correlation-Id: 65b105db-df60-4efb-e0f5-08dcf7349bcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iZnn8Z6kFbkX3CdhIOOdLrlk2tm3kgkrmMj0QcTuZ+bs1WlSKCluIGo0xZ+V?=
 =?us-ascii?Q?6VXkRABbUv7VckXFgS6aYpjJy519XMdfNMfgU9dTStqc/LC9yZ+xPdHTXyfI?=
 =?us-ascii?Q?LX126jQieCS377422ZT0/AMnGLf5VA6X7hHO8tkHk4RjHtAmY+91Kdmg/F4e?=
 =?us-ascii?Q?VqUpg8dIxIgs5h45ZRHbj3Mp7A2rykH4kfxKAep27kFqOsyk/ZHvSamqovWL?=
 =?us-ascii?Q?+eMA6Zv7VlZr9NUHW3IZFCGGZDCQ6iHGkTpnK04cxKSP5651EhS731FnfHcV?=
 =?us-ascii?Q?SnF9l5N7LMaBsI8nqeRkbX0n8jbvJqXpquu2mKAUFPNKVdFNbiBPOzWyElV5?=
 =?us-ascii?Q?G5WYeaIJoVHU8k/g0xrrvwTGa312gJjRhdDesaUEvIQ9+8FAq8OkSJM03e8I?=
 =?us-ascii?Q?2ucAxdLRmsW451zwJepyKMjHmJhp2Z8KEfGkKNfCa+wWHAOBCt3dsuE+zXF1?=
 =?us-ascii?Q?KeaGFQnB2AOIuhMuNLzlAyqcrPn6g365QzpRm2IDgE6vtkedYIHuphlzPct5?=
 =?us-ascii?Q?8AYTTDOi/Ygcey5xauMcYVC7vB32+FvW8QgL5AoCgr+qxvlEOCgir5zfF6ev?=
 =?us-ascii?Q?LtUN1cLAz/xK31tUTgatujs4CPjz+FpTRu2cpI0P/l0UfgrHtVhlg4oYjNLk?=
 =?us-ascii?Q?vwwR/qoh/7FStuU3wjDawkPIZ3qTkN5fcRdcEUQnVTxNwd/Hss/HP27EpTEp?=
 =?us-ascii?Q?zWtFuqkzLnkgQ3TmnNoR71/5VmSopaDnmD5jYYguZLP+SSCm6BI8TtICLqVE?=
 =?us-ascii?Q?jmk9AY0g3I4IsfMDlIWQXiVGu08TcBUMG5yuVVd1RbxZA0ZjHTLZwmz5FfVJ?=
 =?us-ascii?Q?FXTVVbXEbt9WuSyv+NKKYR62HZltjIhEaMsmedkMSLhETpHUmo39Pp95O38o?=
 =?us-ascii?Q?wUV92aYDgEnq6q0L2+v0rgOZUbW04/eOJ+2r/T07FJvLxvxlRw2sDLQHmyCX?=
 =?us-ascii?Q?OumoUl1i5XiJgC3hUlVmgqGMGC59e6ScIX7YajNRKO6Z12bbEdsWTzPiFZtB?=
 =?us-ascii?Q?1O7bnEDJw/mlyP1kJn/rGtEI7h4J9dcVqjRGSncO7cWQzkaPluzLMOu9QJpj?=
 =?us-ascii?Q?4D/Nsk92ngiSFPlbRyMgRYRZ7czDowyAcwGTfJLl08YK/p5Qw+EjhNCjwIuP?=
 =?us-ascii?Q?5/sZvJIi49YNd2B/TlmIvkpAnahHAW0SFCdMH23J8yNF/a15PzH02v3FCdJM?=
 =?us-ascii?Q?qSNeb4BoA4zj0YFYlO4IvLNU3ucc+SCfQXznJHLNHQ6tK+V7oGeTuZHLBvNQ?=
 =?us-ascii?Q?fjuFDNBU6YpJJ9vZ+PgZwdJ7i1vtg2bxUnBfa/Qc9D+ru4H++CcNkZFTPVYs?=
 =?us-ascii?Q?hLJDSfM3pfOwydKfmRrysxVlJ3bHxzVxdZFJ9xDLJmeyf2Y1ATTTEzxcnSho?=
 =?us-ascii?Q?GkJgpqK4izSBf5Q3b7i9kplkr4eHiOWKh+zxE0xdQB+cjSCXtA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 09:40:50.2657
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65b105db-df60-4efb-e0f5-08dcf7349bcf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8589

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

