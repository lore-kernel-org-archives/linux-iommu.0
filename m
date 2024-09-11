Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1C9185928
	for <iommu@lists.linux.dev>; Wed, 11 Sep 2024 10:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726050084; cv=fail; b=P/altpUnQ6dz2mZk7LgBR+sUO6dBRH83xUBUiO5z1kC8ZSJmUidW3rm9Q8LHW8iuPO8/U62aiD9SfT2HrjjflGvsQeN0eTXOUl1bzAEzYliTLw113vhDQ0RXWnAcf0CGzCxgGUMx0+jgCR+kNwl7urgRKuTdqChkwzEiXqH1PYU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726050084; c=relaxed/simple;
	bh=lr/wxxFGUJP2MNZY0pgMebkOSBD9fVxIShlcDiFmf2c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kSP7QV4ySj/hjy1zF6a330huxfqqTG5qjkcX5z5BXBZHqdq9rY5sMZrqo1qXYEDKqKRa7nO/baeNfydtx1hOLZe80yZOlVahMJrXdMEao0ZCYAMNi0CmlKLM7LPzrGU5lQE/Ov6WtHtMTua8b0nUtuzlonAVtSz5CqyBYkBs4Do=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4w5iqEsR; arc=fail smtp.client-ip=40.107.93.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4w5iqEsR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Aens7sRnbi+n3Mj3AXbGsSrhSyoHyQEc88XfwNqQlXhnNg2n0dP8DF3DtiCxRLdxayrDrrqYFP7PD02DBOCzhmkyZ5g627sSszGFXSmHr7bl4NqYWX6AZMcwV5z2MZSvwyW00XxAbKvuOQvVTahbi5vhgUX8ZoPNNDsLIJhaCgjdkRdZ48wgTAcohBlxZ1PHgWTvgxsPgp/U4AGNRvO8VWXAhqRp236rJit/4HGIpDmLfNc7gxKbv3Chb1DMzgy3SotKNTuuJDdq3on0pIBd0rKicMxEzk0gE7yxHaF2M0l0eGKEXLY9Y2+LQpa4INmH+UEAwE3plcda5hc3uBxmfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jj1Jp/kRWrN9AfiQJxz+pV2nAaJLrrJYohAYTUDDTBw=;
 b=rBrvuef056mrxxLi+Y/az+dTx0ArWWIvVWjMdLw9ihWQfXPYWIRlfUOKL2xkcm85t3E20pCTJeh8nggf17+UipdBLV4Bi4J52TviLxx0NogfVvOGQY4qDNT3A6TMlb0Y4sZ1U3e/dKUHSerbktLu4kXopxYDKhXu5HiFZP8rEvjh8W5bCxIB8+b1fwsDbAAIUOEBTymgXiuseyZQasovSndgA8qpxAo9enI672EhvfRstzxebWGxxAF4r/qRRayvCxCHdc4pD3HPfmQa1xhWSaDAgVFgU9374wT3XCInDI4qxuMy2TMY4WSKeKfdt9JIJqLJs5huGREP5RuRO/212g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jj1Jp/kRWrN9AfiQJxz+pV2nAaJLrrJYohAYTUDDTBw=;
 b=4w5iqEsRXiMlRhyG1qY01ZDRdVClszpoI65GgdAITuSKL8FCLEkaoFRt70v6M4Dr83eIF/ZCxRyKFZM2Fzlaj0S2XoTYvqeQinXxDtAG9TerWff0msM723nGs9shVwCbkgVTA9pwAaZS98e4sQNnOg2Ck2OmeMgv5IJozYs5qx0=
Received: from CH2PR19CA0027.namprd19.prod.outlook.com (2603:10b6:610:4d::37)
 by IA0PR12MB8325.namprd12.prod.outlook.com (2603:10b6:208:407::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.25; Wed, 11 Sep
 2024 10:21:18 +0000
Received: from CH2PEPF0000013C.namprd02.prod.outlook.com
 (2603:10b6:610:4d:cafe::6a) by CH2PR19CA0027.outlook.office365.com
 (2603:10b6:610:4d::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Wed, 11 Sep 2024 10:21:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000013C.mail.protection.outlook.com (10.167.244.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 11 Sep 2024 10:21:18 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Sep
 2024 05:21:14 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, <jgg@ziepe.ca>, <yi.l.liu@intel.com>,
	<baolu.lu@linux.intel.com>, <kevin.tian@intel.com>,
	<jacob.pan@linux.microsoft.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v2 5/8] iommu/amd: Pass page table type as param to pdom_setup_pgtable()
Date: Wed, 11 Sep 2024 10:19:08 +0000
Message-ID: <20240911101911.6269-6-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240911101911.6269-1-vasant.hegde@amd.com>
References: <20240911101911.6269-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013C:EE_|IA0PR12MB8325:EE_
X-MS-Office365-Filtering-Correlation-Id: 412f8881-a98c-4f52-9046-08dcd24b79a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SIGlgk263ehCUdEaUjvH8xJQ0B65ki45MNmIVz829nA5IWDltiR/N0RN/WNI?=
 =?us-ascii?Q?hgO3fdQzQGx+NNPENXhbY5XIp5NxGmh2Kk3mvbYUjFMB5bXjkOU5GkUeoahI?=
 =?us-ascii?Q?QWC9m3cbnGoSrjERavq7xHk6/mDNzmy7Q/o6y5qllIKBUKViNb6WXCX83SKl?=
 =?us-ascii?Q?BZtUTfaqtVomC0sWjSR/uFy4+FhLNfmxjaYl4zN1hpMWhzQsGeajkiLx0/8Y?=
 =?us-ascii?Q?U5rL5leTlF0TEmamkwjbRvoZVUYper4kQPCt390eYJE/r0UJI+SrOCAVrfbl?=
 =?us-ascii?Q?dr5BZD4czz0Rs2KHUlOnMZxEm4/ztwDa1BoNEAE8u2WTfliPFq34EaEwI2o/?=
 =?us-ascii?Q?Sj0awqyPs1qu1sdhipHf89VP9uDjUEUGCZQT5IcXuo/mT1/4QVqH6NNWKFOX?=
 =?us-ascii?Q?1lajg8+IPGvfh0QOkciAYyaTEeYpJDexKwGzbkZPEHYXpET6NppeitiFr7AG?=
 =?us-ascii?Q?icaT/79qwCuWLt3D1n7uE3s0dwBLBpxLYdj9h7N+iOgB1WnKq4ZZ1g+5yN8/?=
 =?us-ascii?Q?/CLJHIGZQGUlSbTm+/NwuTJBDP0Xk5f9NW2SYD7XBjcWgOnrBrG5i7wk387n?=
 =?us-ascii?Q?Oidg9g8u0EKZxfjuM57Dt7t/38A8BR880R0f1RSSgV1yq3LTHLj0tSYiQJOy?=
 =?us-ascii?Q?bu6DRW+drjWEwIJali97e3jRM4wSRcwdZoBGYT87/YCzUJSm20rMxlKOC8le?=
 =?us-ascii?Q?8vKXm4R+L5lY4llr5GyC6oW/TnKjw4LexDLCGJkb7bb19q/Wq8pi6LQ19LX4?=
 =?us-ascii?Q?jLTLdm3QGRPuK9zWAGc107dNVt3nmneBzcU+k3VSwVHjsyGufAkkSIidW2qM?=
 =?us-ascii?Q?qXI7ff6UsdAnE/K4ff7idQP3zbAiQq6s3QrYP72yICgDAQAVu5ZbGHOUf+AS?=
 =?us-ascii?Q?xF39g0+lElKiy0daKcq+Kptp45eGRkakBRwxbB5K4Lx/cCyNVLyNmO2+sVnj?=
 =?us-ascii?Q?c1MkNiWfMIa9tfkD+VVgtRetea6u/tBlpW2pkHiKRK5k4UOlZlTfY+wgMbrK?=
 =?us-ascii?Q?hCHgz2k/qtXdJkovsVbiLdeD2elzRs9NN+wse/VKpt54K9qsq5XHV/6aUzVO?=
 =?us-ascii?Q?ZirCPh6O7IyNevnlWF99FF2Gnfmb0hZDbs+Ynwhe/DYu7MHYmBwZx2FQMqUJ?=
 =?us-ascii?Q?IVyzIMVNrYHubH+o5VaPjUsOqxAuEhJioGXKgIN0mLlhOW7WURK8Qu/oF5Bu?=
 =?us-ascii?Q?msEh4UsB95kyuALr1E3tYbUNuyCVWOQ9nICTN2ZKR9ImkGhoGlVEZHcT3YrR?=
 =?us-ascii?Q?VJ6+sPgKNjsSLRlMJh/g+ISZJJFMpCmtotJP6dH5zPfteQADS3hSvPAiXUnl?=
 =?us-ascii?Q?onE1wfDa8TQwhyXPhDBj4lFtCdYh076d6DKwgng1+yx0HThAJRkEz7DXeM9a?=
 =?us-ascii?Q?OnL275sY/wVm14kMOkvTwTUptG+0TDnj2Iz0Y+fC/pzGwjzwTmAFDO5WdEOS?=
 =?us-ascii?Q?Pn+VZ4/HRUeyvx3Rrrvw0LolhX8N2Q2a?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 10:21:18.4169
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 412f8881-a98c-4f52-9046-08dcd24b79a6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8325

Current code forces v1 page table for UNMANAGED domain and global page
table type (amd_iommu_pgtable) for rest of paging domain.

Following patch series adds support for domain_alloc_paging() ops. Also
enhances domain_alloc_user() to allocate page table based on 'flags.

Hence pass page table type as parameter to pdomain_setup_pgtable(). So
that caller can decide right page table type. Also update
dma_max_address() to take pgtable as parameter.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu.c | 43 +++++++++++++++++----------------------
 1 file changed, 19 insertions(+), 24 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 6844040b3702..cfeb3202ceee 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2285,28 +2285,13 @@ struct protection_domain *protection_domain_alloc(unsigned int type, int nid)
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
@@ -2318,6 +2303,7 @@ static int pdom_setup_pgtable(struct protection_domain *domain,
 	default:
 		return -EINVAL;
 	}
+
 	pgtbl_ops =
 		alloc_io_pgtable_ops(pgtable, &domain->iop.pgtbl.cfg, domain);
 	if (!pgtbl_ops)
@@ -2326,9 +2312,9 @@ static int pdom_setup_pgtable(struct protection_domain *domain,
 	return 0;
 }
 
-static inline u64 dma_max_address(void)
+static inline u64 dma_max_address(int pgtable)
 {
-	if (amd_iommu_pgtable == AMD_IOMMU_V1)
+	if (pgtable == AMD_IOMMU_V1)
 		return ~0ULL;
 
 	/* V2 with 4/5 level page table */
@@ -2341,7 +2327,8 @@ static bool amd_iommu_hd_support(struct amd_iommu *iommu)
 }
 
 static struct iommu_domain *do_iommu_domain_alloc(unsigned int type,
-						  struct device *dev, u32 flags)
+						  struct device *dev,
+						  u32 flags, int pgtable)
 {
 	bool dirty_tracking = flags & IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
 	struct protection_domain *domain;
@@ -2366,7 +2353,7 @@ static struct iommu_domain *do_iommu_domain_alloc(unsigned int type,
 	if (!domain)
 		return ERR_PTR(-ENOMEM);
 
-	ret = pdom_setup_pgtable(domain, type);
+	ret = pdom_setup_pgtable(domain, type, pgtable);
 	if (ret) {
 		domain_id_free(domain->id);
 		kfree(domain);
@@ -2374,7 +2361,7 @@ static struct iommu_domain *do_iommu_domain_alloc(unsigned int type,
 	}
 
 	domain->domain.geometry.aperture_start = 0;
-	domain->domain.geometry.aperture_end   = dma_max_address();
+	domain->domain.geometry.aperture_end   = dma_max_address(pgtable);
 	domain->domain.geometry.force_aperture = true;
 	domain->domain.pgsize_bitmap = domain->iop.pgtbl.cfg.pgsize_bitmap;
 
@@ -2392,8 +2379,16 @@ static struct iommu_domain *do_iommu_domain_alloc(unsigned int type,
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
 
@@ -2411,7 +2406,7 @@ amd_iommu_domain_alloc_user(struct device *dev, u32 flags,
 	if ((flags & ~IOMMU_HWPT_ALLOC_DIRTY_TRACKING) || parent || user_data)
 		return ERR_PTR(-EOPNOTSUPP);
 
-	return do_iommu_domain_alloc(type, dev, flags);
+	return do_iommu_domain_alloc(type, dev, flags, AMD_IOMMU_V1);
 }
 
 void amd_iommu_domain_free(struct iommu_domain *dom)
-- 
2.31.1

