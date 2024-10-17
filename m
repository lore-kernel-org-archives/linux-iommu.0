Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57E81DE3A6
	for <iommu@lists.linux.dev>; Thu, 17 Oct 2024 14:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729173850; cv=fail; b=agVtCuyIhTJYooxOt9M0WqHgpcv3IGS+W+QHCkcfjF+ivahMwRO807BUfKNRhF+mjOqhwRBpOOWV7HybEZhNRdgbifI0cvUJmh/Ugvlto3kAABD6C92QennUZqbqVydVHfQRJOwBtwBJ0huaAPfnbaVyfAqeErU0rKM5YEfOrO8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729173850; c=relaxed/simple;
	bh=EsBD+Eb8HXXPlyNaWwptoxX0VraCIU3xYVvIz0SaiVo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k6QwqE91z3Zk/8yl17+vII7a1+4YIgYwzo/5xyd8qNVGrFa6U8uomi3JNIQ93W+wi2PcODnhWmk3icCkRN8+meQ419WLOb5k0cf/C5RQQadbmzCLPhl5v8uwlfYNmVWTE94/68ETAVwoLA1l3nP7Kxi8phCUWsrfi7pl9QUAeRM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yf8IxGJr; arc=fail smtp.client-ip=40.107.92.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yf8IxGJr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nfvxj59Bhlq7L0YIuc0erDiFbQIHuWXE/Xe/nvZcfAl/Mix7XuvQKy+sBml7udnGOm9nG7zc7Fk4RwZKk4Nt9MZZnAXO6hEMJOZ6hC9D4TJxDkHJ2Ik6PyAe/jSEiR35alaEgNtuQXpTHJuoxcqfY4YirPnW0N+Z7vRdtC4xPo01yWOUv9vLdUo2v59Y/E5zg3hVBQX+dOm6mMvsley8lGTj2ZBHZb80w2URJou/9k5MLe9zEGFbUyeEqHvTE0yjENgWXd6xDv7uPKlV9VyIk3upviQUue6ldEt3DtXGwd/Mdq6k3meDIcbor9fmSiVxEtG9Myq+NNJ+tT9vGj45fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mUWuWCXZdJgKeqGF6ECbcieeTuWspqNfhISf5+g6HL0=;
 b=yGj7UNdBlVcxMe03D3be5ajTHA/uRNM/62glqSu60t0mdleMQfrzFHo1hlBE7twRniqYHp1YwV7d0FkGN7JP3gqYEbNkn8Wz2ykPURm9S+hqjzxPsqrTeY2eokxLnpX5jiSpc9KTc6SPu3NwcWMqRgc/DLHQNizMW/VVLcxGzkWFaFiumzgX1Wl7vMLiDdpZzgmdcf+W0C+dsVVQVYoI5oirr1B2QsR6SBAdFPGR5r7jpJiw63JhVjMaH+cQBtAQ2VUfFCnSqsiBCIs0UMR+qN7rPxQ8ykbqZIKTmGRa7d+0H02ZPFqikgq+NrzmenRi+rrf2b4VONQ/LkV16cj8BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mUWuWCXZdJgKeqGF6ECbcieeTuWspqNfhISf5+g6HL0=;
 b=yf8IxGJrMeiN+CK1c4AA6JVt51r/5DkVPVRjE2Nj8GUuGm6x6Gr6a5mDyW0FEXSoIO8FrtqgrXElMxEC/SK1YsExgYE+vz6BDDvSb5XsB2SCTwm+lgJYhEi1nZ+V1TeV8HTnwFnozqpI5b7hXhwZyMx1Z48pZFMpME0noYQJu+Q=
Received: from CH0PR13CA0049.namprd13.prod.outlook.com (2603:10b6:610:b2::24)
 by SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 17 Oct
 2024 14:03:59 +0000
Received: from CH1PEPF0000A347.namprd04.prod.outlook.com
 (2603:10b6:610:b2:cafe::db) by CH0PR13CA0049.outlook.office365.com
 (2603:10b6:610:b2::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.16 via Frontend
 Transport; Thu, 17 Oct 2024 14:03:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A347.mail.protection.outlook.com (10.167.244.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Thu, 17 Oct 2024 14:03:59 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Oct
 2024 09:03:55 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, <jgg@ziepe.ca>, <yi.l.liu@intel.com>,
	<baolu.lu@linux.intel.com>, <kevin.tian@intel.com>,
	<jacob.pan@linux.microsoft.com>, Vasant Hegde <vasant.hegde@amd.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>
Subject: [PATCH v3 07/12] iommu/amd: Separate page table setup from domain allocation
Date: Thu, 17 Oct 2024 14:01:32 +0000
Message-ID: <20241017140137.6028-8-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A347:EE_|SJ2PR12MB8784:EE_
X-MS-Office365-Filtering-Correlation-Id: 83214ba1-9832-43e7-6d2a-08dceeb48c52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GSv3LJYOXADGfA3i3VwBSDqg9SlcABYqoUT0htFK9JtkgNS04tYrbjkVmee8?=
 =?us-ascii?Q?9vhe8xMvt/p0P+4W8pi1gzhhdoOCvI2hmYy3ZuvXKdPti0igB4VrGrVVzXrE?=
 =?us-ascii?Q?AqGUhpG297a3wvl9Kqun0OFPhA8A61OaneB4a7qh5V1yHJSOliZS9vyywZFm?=
 =?us-ascii?Q?bKh/9sy/GCDXNBNSxv4h6b8ngfH6+OSu1hOIfLCFe8kQ54iArCrYjk/2wFVA?=
 =?us-ascii?Q?OD+TCtEvx+0ubKJsFCw++mpNRR95hNbMhZpoWJ96AosL3Z5+LwY8QSweVo1q?=
 =?us-ascii?Q?HwXvwJKMK3tEdYcLgdG69vppE92SKYXYzbEWUquyHR5DCEG71sZpdJ0K65If?=
 =?us-ascii?Q?v58wexB634FP0y+voZmKRmmdLWncyeYQOVjev2RedJwOkEYW2gUF35NJ+UuQ?=
 =?us-ascii?Q?vU3+F+Kj+DwLSSYdz6THRPvwTm2+VKkyxF0KPtb+TCAlDi37eNu++8SxGjSo?=
 =?us-ascii?Q?HFu5EqoKnmEBQ61Yq7vsP8E6J4UL9zCtQ7ALmx8LosstK5UFPEWuipt9bvyS?=
 =?us-ascii?Q?f7dRbYxDcAzSP7EJBeOXHyodck4zM2FCS4At0JlWB8NSoCm6A9bVZsHIGTWR?=
 =?us-ascii?Q?0vaj0qa75K0tD2OMR+nD4YSgUZByODkj5agZIQx8HagDA8DxgNk0OMYGLwDz?=
 =?us-ascii?Q?YiVtMcpkDVsFr+29P1RJZqDenkbPc4jPR9fHo7rIRSLVek5COXAYoXkg0p56?=
 =?us-ascii?Q?XtgooqKA2PL9e9eX4q6IYmVxaVXfoDDlD3OWlxsq3FHFuSbdPKdFnnIVCYzI?=
 =?us-ascii?Q?oGcjNdlwqzLXN0BNtnGjYhi5wh/oQloj/XmKsIeFsWF1mFdKMQOaJkJG3jzx?=
 =?us-ascii?Q?u6MizaEMpXsVsKYUHANb7Eud39VOK9csO//b6mMxZC+EdRSceehaWRRM+vLf?=
 =?us-ascii?Q?O9gHItfdFHkdwpaz7Jhzma11NUJISLoowQy3o08pSZtnumUM7/5vIL/x8WIE?=
 =?us-ascii?Q?dBRLZO6Rt7aOCSjDlhSfSJAG6ECU7JMwbjcKeES3fvoa/RufpxsZUpZrY/Bh?=
 =?us-ascii?Q?g//hzW0tMp5zbv5JjDKjUXButyb7fV7g/APVkE97nLpQtB96AvGPDzUY2bWr?=
 =?us-ascii?Q?+YiX6F9voIWmeyM8/RHNrIjNiZ8MH66vYFSQYGFBQ1Wey2gzjSe2bjqMua/L?=
 =?us-ascii?Q?Ph0zx7JP0eGbtAaBRF4vF5KxLVjsJbEGWlKWDsCj7SL0d0Kxum1hQ/coT0oM?=
 =?us-ascii?Q?rhZY32LPKEZ2gqqr9FKGA1XsvyJMamSFerjVXxG38yG1yDIomCVhf+iygij9?=
 =?us-ascii?Q?VTNOUGEQ7IHXHqsnq7rXBqNs5yW/HeQKjFoPzvYD3mYb9qUjhoD2jxzuUiuL?=
 =?us-ascii?Q?gxjg6chl69sxk2q59qNdEr4hDG7aBs7SD3aG2iQCpCpPIXL2tANMEQGOYp7M?=
 =?us-ascii?Q?LVAUj9WG6KvCnT+0jYDj3sf+Vm0uheT6yZROv155usC7+J0PjA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 14:03:59.4566
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83214ba1-9832-43e7-6d2a-08dceeb48c52
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A347.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8784

Currently protection_domain_alloc() allocates domain and also sets up
page table. Page table setup is required for PAGING domain only. Domain
type like SVA doesn't need page table. Hence move page table setup code
to separate function.

Also SVA domain allocation path does not call pdom_setup_pgtable().
Hence remove IOMMU_DOMAIN_SVA type check.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Jacob Pan <jacob.pan@linux.microsoft.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/amd/iommu.c | 42 ++++++++++++++++++++++++---------------
 1 file changed, 26 insertions(+), 16 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 8364cd6fa47d..6285fd1afd50 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2265,28 +2265,36 @@ void protection_domain_free(struct protection_domain *domain)
 
 struct protection_domain *protection_domain_alloc(unsigned int type, int nid)
 {
-	struct io_pgtable_ops *pgtbl_ops;
 	struct protection_domain *domain;
-	int pgtable;
 
 	domain = kzalloc(sizeof(*domain), GFP_KERNEL);
 	if (!domain)
 		return NULL;
 
 	domain->id = domain_id_alloc();
-	if (!domain->id)
-		goto err_free;
+	if (!domain->id) {
+		kfree(domain);
+		return NULL;
+	}
 
 	spin_lock_init(&domain->lock);
 	INIT_LIST_HEAD(&domain->dev_list);
 	INIT_LIST_HEAD(&domain->dev_data_list);
 	domain->iop.pgtbl.cfg.amd.nid = nid;
 
+	return domain;
+}
+
+static int pdom_setup_pgtable(struct protection_domain *domain,
+			      unsigned int type)
+{
+	struct io_pgtable_ops *pgtbl_ops;
+	int pgtable;
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
@@ -2298,7 +2306,7 @@ struct protection_domain *protection_domain_alloc(unsigned int type, int nid)
 		pgtable = AMD_IOMMU_V1;
 		break;
 	default:
-		goto err_id;
+		return -EINVAL;
 	}
 
 	switch (pgtable) {
@@ -2309,20 +2317,14 @@ struct protection_domain *protection_domain_alloc(unsigned int type, int nid)
 		domain->pd_mode = PD_MODE_V2;
 		break;
 	default:
-		goto err_id;
+		return -EINVAL;
 	}
-
 	pgtbl_ops =
 		alloc_io_pgtable_ops(pgtable, &domain->iop.pgtbl.cfg, domain);
 	if (!pgtbl_ops)
-		goto err_id;
+		return -ENOMEM;
 
-	return domain;
-err_id:
-	domain_id_free(domain->id);
-err_free:
-	kfree(domain);
-	return NULL;
+	return 0;
 }
 
 static inline u64 dma_max_address(void)
@@ -2345,6 +2347,7 @@ static struct iommu_domain *do_iommu_domain_alloc(unsigned int type,
 	bool dirty_tracking = flags & IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
 	struct protection_domain *domain;
 	struct amd_iommu *iommu = NULL;
+	int ret;
 
 	if (dev)
 		iommu = get_amd_iommu_from_dev(dev);
@@ -2364,6 +2367,13 @@ static struct iommu_domain *do_iommu_domain_alloc(unsigned int type,
 	if (!domain)
 		return ERR_PTR(-ENOMEM);
 
+	ret = pdom_setup_pgtable(domain, type);
+	if (ret) {
+		domain_id_free(domain->id);
+		kfree(domain);
+		return ERR_PTR(ret);
+	}
+
 	domain->domain.geometry.aperture_start = 0;
 	domain->domain.geometry.aperture_end   = dma_max_address();
 	domain->domain.geometry.force_aperture = true;
-- 
2.31.1

