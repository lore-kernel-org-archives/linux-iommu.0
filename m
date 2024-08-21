Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2051.outbound.protection.outlook.com [40.107.223.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B886D1A4B65
	for <iommu@lists.linux.dev>; Wed, 21 Aug 2024 13:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724247422; cv=fail; b=unDhHb92vAtTKLYz1TPkjTRqvDOFaywcp7TavOp5FSS1FNvRKQcWAPS+5Ik7xw2DLDcbEEgkvQL0IHb5vrIhWxz3IyLrlGkem79L/4dWXBMtN/9FOSSxBneAiMgUzb8WYo43mERZpr5p6yAQLcyl0212DhVje/u1+nhje5YCZvc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724247422; c=relaxed/simple;
	bh=GxsYYf13mwMAQyRCTmeA75PQozfHt2u4WSCoDUWH4Tk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P7GmaFw2Ck4GawhtwyalgbGA+ha+aEdL9bn5LRldJKFfiiHlaFnbPHYIVS/gO8xAg3IG9UM1FNkoUfr62956zljgXAu7WLWGXW/SW2PsvFtckRp46aQ9Sde2OaKJ2l/aJr+ori+wpHoS9x1TRUOR4nc4aKAUTcY40hyRy2PfkXI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cIPrGN9H; arc=fail smtp.client-ip=40.107.223.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cIPrGN9H"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PWHvEsSa3MS7eYFhlB5Ftg9OA5a+W01U208RLIBqJrrilBZp/MDslwCj3MiVeMoe5nupEHWHDYD2upEIhuZVNI8wPL0rkN1XkhpnFhvCXegstXf7b5wRJk+hwRlSvkQvcGgGcsPh9qJT1i7Cni23E6OC3SWvzSayRT9U04zStDLv8mo6PHZ1YZNruTcuJrV8fnEa6Hz8IK7Xq6ZFJw3/lM7TAYqI2AiYJhnJSjST9nxDqCtzJtuDV2ojrKYTIf2p/pKZZJbR3HA5yNunlUt5xZmOTI75/GhEbRjXNL8+T2Q7NolE4pf+HYlEHYfqIB9d2eSA0sLtga1ydS9heQD1Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7gZ05LXvL3pHmRVFUeQsDM70eB3TgP0yuGOrcI4ZIKM=;
 b=Nyu+e9ea1OtlQqFdGSWhMwpEKgIa1wD37w1Zsr7xh/lf5Z1od7dkfp6TCy9uGncER9OXEMMZfhBdHTSc1QHZ/R7AMGscooR8jh8qTbk+qy9XEWg5RnbIOZ+9cYNS37n6QXj6iwIjQERZ4LIYFi1hvnb4VSsPPOx9nwrgJjFOwHxck2hUbDsaUY0yimxjb4mZqrSPkpHBgTwzocS+mcfzsDlanCLcqmgeAvhvFQFdzysEQpnEFMdNvhJDxLqiNnWQ73qVvXvCaK+PgKPP79Oc+ZbtZ3B2zoLiWN9s9VgsuRg0bHkTmjbNwPrbb2uVYhZZwhTDWbFMqEDBLx3vrhAJbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7gZ05LXvL3pHmRVFUeQsDM70eB3TgP0yuGOrcI4ZIKM=;
 b=cIPrGN9HhhD7SSLCkzscGiYbuAqr1xxxtG5gPnzYLd4t7GTOiVH432al5C56p+A7MGCRDk14aswyLBqNyWPc92zeybIEs/IhRxRCyrGojav/ShBNWW9ke6/0pc9dBY/j9ToETCzfBijE9UGibw+XCvGhl1mMcZObbZ1g+1kvXR0=
Received: from BN7PR06CA0046.namprd06.prod.outlook.com (2603:10b6:408:34::23)
 by MN0PR12MB6149.namprd12.prod.outlook.com (2603:10b6:208:3c7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Wed, 21 Aug
 2024 13:36:55 +0000
Received: from BN3PEPF0000B069.namprd21.prod.outlook.com
 (2603:10b6:408:34:cafe::b7) by BN7PR06CA0046.outlook.office365.com
 (2603:10b6:408:34::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21 via Frontend
 Transport; Wed, 21 Aug 2024 13:36:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B069.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7897.4 via Frontend Transport; Wed, 21 Aug 2024 13:36:55 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 21 Aug
 2024 08:36:51 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, <jgg@ziepe.ca>, <yi.l.liu@intel.com>,
	<baolu.lu@linux.intel.com>, <kevin.tian@intel.com>, Vasant Hegde
	<vasant.hegde@amd.com>
Subject: [PATCH 2/5] iommu/amd: Separate page table setup from domain allocation
Date: Wed, 21 Aug 2024 13:35:51 +0000
Message-ID: <20240821133554.7405-3-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240821133554.7405-1-vasant.hegde@amd.com>
References: <20240821133554.7405-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B069:EE_|MN0PR12MB6149:EE_
X-MS-Office365-Filtering-Correlation-Id: ef59db54-f4a6-4c64-77cf-08dcc1e652af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?K/rTIcCQbuuOb6q8nTa1Rg3ClXBhD5bgLc9V//ktZyT1bMYkhfJGEtRBnQhm?=
 =?us-ascii?Q?ToD0yjiVqmRLxxINIMLOZRdY9jgqLqck2VwLZ/jYe2XFYgM7Mt+UeDHsK3g8?=
 =?us-ascii?Q?R7eUBztcFZ43Y+DJWi8tmnVIGhEvmIy4EGhGxPAYhclXjgoD36HUvMUAdhrK?=
 =?us-ascii?Q?iuWld3FSnkp+JnIvTxAkdwbsfVwnaTlCfhpm+/ZwfKwvhmeIEIOIav4K8fKs?=
 =?us-ascii?Q?JOy2ZK1iT4/YEo1WkG+K5nsUdYzj1qKCScY3A17aHJYm+Q1+5+66TGbteIsL?=
 =?us-ascii?Q?8c0Q3TO+6QBT/i7Dud1gKh5Gy6+GF9OHMpex+sjOYeQ0CVSaKkenbf7TOmJ5?=
 =?us-ascii?Q?1kBpDrkuYMrU39M3XWmFh30dszuNqzTjszNT4rGM3db/0qEdJcgNBBAT49kA?=
 =?us-ascii?Q?xus3vMMiiOelliy7+hsLyC6uqkaOUb+sBLaPbIxY+hYKGXK+EGjF9I7fV4Zv?=
 =?us-ascii?Q?B4xuvCtt3r5u1g4C33JGqp34SK32tODl7jFKyrV+nm5n7/tvUExyqsNHj5Hm?=
 =?us-ascii?Q?TrSRGupnDY58hw+30u1hqnasTX9mtTvkcJQ2/d2Uy+ziSBbCvEERtoSztMp6?=
 =?us-ascii?Q?Y9iO+cYhWH86DAff46yGxY7dffbnGZAXSI3KN85JJ1CnyRF8ZHVfmP//Ulr7?=
 =?us-ascii?Q?2MvemW74edQeRgh+XJhD4UqNpJGG7VWaDd/PiIP7TGFm75buk6GDb3QNYMgK?=
 =?us-ascii?Q?u9ZK+YTh3n2MHpWuaPejaM6exDxilStXXHaVHNOuSuMP1wGU4kxxPXnSFujQ?=
 =?us-ascii?Q?H56jez9q6oh+mq5s8CKPkpFpVC+qIO3q2Tw+N8SkwnsOcKyMRXDDqh30gCzm?=
 =?us-ascii?Q?2u1ezCbxIjpwbZOogzKkIDGpdHsCxFPnwKPhlphozBTbRkmYjHWXrxv2vT1P?=
 =?us-ascii?Q?aUIvSNoPl+3i2gGdYJ9X+K1xo6HsVxH4O7gn+bk/yJJaVjqYdV6Or/GT5tHD?=
 =?us-ascii?Q?Zxi/iu+VjKyYhnKFtOzTtdb11zRfGSxJ7Qk/QILQwGfzyzojENuesWNTftde?=
 =?us-ascii?Q?HyopamNL7+ucIDORWxOA0XRDz/YgxOrvsfn92LYnsN7iDkRHs4DqVdrgsX3t?=
 =?us-ascii?Q?Z/pWCjcrzjdVQcskA6CyzTeU4/Ws64kx9HviKpSb3hYzaSkfu5oUalSBCo4b?=
 =?us-ascii?Q?RnNfQifgJLQlYtaYFcSTkn2K4RODrbElE1D6S3tmD5sEk9upYe+eKxWGyK+C?=
 =?us-ascii?Q?INVixUmRxE8d0+v/SZ7nTg1SgYuZJZnlXxZ3QNx4aFf5GfwhlkGNpNcEUOY2?=
 =?us-ascii?Q?T7/kNBe2FgEo6/IB/z/3BXXieiBT0rTwp1Z9EhQPxQ/dREZ/K6uRHTZP+m8F?=
 =?us-ascii?Q?+hT8f9Si/tMPv3TPmnet9e/IDxLFNRzJPpWfYGLFWSahe9yl4zjr2bAMY2Bk?=
 =?us-ascii?Q?fXI2+q2EDeIf5aFtPKJq+2WzyJgVqcbQtQV86YHP0YhXqAebpebodwMp/1h5?=
 =?us-ascii?Q?Xcfoava+X0ETs99/EhaJoQY3s5RhXCIo?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 13:36:55.3012
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef59db54-f4a6-4c64-77cf-08dcc1e652af
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B069.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6149

Currently protection_domain_alloc() allocates domain and also sets up
page table. Page table setup is required for PAGING domain only. Domain
type like SVA doesn't need page table. Hence move page table setup code
to separate function.

Also SVA domain allocation path does not call pdomain_setup_pgtable().
Hence removed IOMMU_DOMAIN_SVA type check.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu.c | 46 ++++++++++++++++++++++++---------------
 1 file changed, 28 insertions(+), 18 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index b19e8c0f48fa..33930e08bd4c 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2302,29 +2302,38 @@ static int protection_domain_init_v2(struct protection_domain *pdom)
 
 struct protection_domain *protection_domain_alloc(unsigned int type)
 {
-	struct io_pgtable_ops *pgtbl_ops;
 	struct protection_domain *domain;
-	int pgtable;
-	int ret;
 
 	domain = kzalloc(sizeof(*domain), GFP_KERNEL);
 	if (!domain)
 		return NULL;
 
 	domain->id = domain_id_alloc();
-	if (!domain->id)
-		goto out_err;
+	if (!domain->id) {
+		kfree(domain);
+		return NULL;
+	}
 
 	spin_lock_init(&domain->lock);
 	INIT_LIST_HEAD(&domain->dev_list);
 	INIT_LIST_HEAD(&domain->dev_data_list);
 	domain->nid = NUMA_NO_NODE;
 
+	domain->domain.type = type;
+	return domain;
+}
+
+static int pdom_setup_pgtable(struct protection_domain *domain,
+			      unsigned int type)
+{
+	struct io_pgtable_ops *pgtbl_ops;
+	int pgtable;
+	int ret;
+
 	switch (type) {
 	/* No need to allocate io pgtable ops in passthrough mode */
 	case IOMMU_DOMAIN_IDENTITY:
-	case IOMMU_DOMAIN_SVA:
-		return domain;
+		return 0;
 	case IOMMU_DOMAIN_DMA:
 		pgtable = amd_iommu_pgtable;
 		break;
@@ -2336,9 +2345,8 @@ struct protection_domain *protection_domain_alloc(unsigned int type)
 		pgtable = AMD_IOMMU_V1;
 		break;
 	default:
-		goto out_err;
+		return -EINVAL;
 	}
-
 	switch (pgtable) {
 	case AMD_IOMMU_V1:
 		ret = protection_domain_init_v1(domain, DEFAULT_PGTABLE_LEVEL);
@@ -2347,21 +2355,17 @@ struct protection_domain *protection_domain_alloc(unsigned int type)
 		ret = protection_domain_init_v2(domain);
 		break;
 	default:
-		ret = -EINVAL;
-		break;
+		return -EINVAL;
 	}
 
 	if (ret)
-		goto out_err;
+		return ret;
 
 	pgtbl_ops = alloc_io_pgtable_ops(pgtable, &domain->iop.pgtbl_cfg, domain);
 	if (!pgtbl_ops)
-		goto out_err;
+		return -EINVAL;
 
-	return domain;
-out_err:
-	protection_domain_free(domain);
-	return NULL;
+	return 0;
 }
 
 static inline u64 dma_max_address(void)
@@ -2384,6 +2388,7 @@ static struct iommu_domain *do_iommu_domain_alloc(unsigned int type,
 	bool dirty_tracking = flags & IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
 	struct protection_domain *domain;
 	struct amd_iommu *iommu = NULL;
+	int ret;
 
 	if (dev)
 		iommu = get_amd_iommu_from_dev(dev);
@@ -2402,12 +2407,17 @@ static struct iommu_domain *do_iommu_domain_alloc(unsigned int type,
 	if (!domain)
 		return ERR_PTR(-ENOMEM);
 
+	ret = pdom_setup_pgtable(domain, type);
+	if (ret) {
+		protection_domain_free(domain);
+		return ERR_PTR(ret);
+	}
+
 	domain->domain.geometry.aperture_start = 0;
 	domain->domain.geometry.aperture_end   = dma_max_address();
 	domain->domain.geometry.force_aperture = true;
 
 	if (iommu) {
-		domain->domain.type = type;
 		domain->domain.pgsize_bitmap = iommu->iommu.ops->pgsize_bitmap;
 		domain->domain.ops = iommu->iommu.ops->default_domain_ops;
 
-- 
2.31.1

