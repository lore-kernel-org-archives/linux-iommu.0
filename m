Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2070.outbound.protection.outlook.com [40.107.95.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FEC51A4B93
	for <iommu@lists.linux.dev>; Wed, 21 Aug 2024 13:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724247437; cv=fail; b=nF+EFn7o14P57oy3E2rf+P/egns/Xq5j44naQ9nwbwxGKp/3MYYUbxAtwHWmHPOsaDqwHfaSEJdqUaZeVb13palYXQj9go+pINpDp4rpzRc9xUKTTMx+9Zv2CiG6HA3tpvSbspbCREcdDQfaInw3iVU8cvk3pHuNHf0U5Ny0kXs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724247437; c=relaxed/simple;
	bh=Iq4QbEF01Dc3Y89xvWAIotzf+WWVJRzO/7h3yk+atYQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DXg/+DQpR5jam8nyxSLBjZrG0IVxJ9JPMzFGmudrMH7d1kE+QPlLzngh9pzW6Mg90hpYsRQuMg8m4xvvwLvtC56lurkOyGmb/aXk7EflHZBJ1AzdKx7GXXMeOH+Fvr1IOnDX4MzVc4QeN2yoAY+AfFhEL69T5xX/LbyCiYkJGI4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vUaB/oPG; arc=fail smtp.client-ip=40.107.95.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vUaB/oPG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n2sNTM4ODmAif13roAAFRrKCf51+OIfXrJd3LrJ7JfI9f261oYvMbzgdF+y87ez7udVOdC2FdNvPLgZIDUXaeyFOGZcMew8VwevTt1jodOvBpEqZ8rqpwnJ31+1eSoink0arva8n/MDB3AKemsf6alyLQHX4Qh4Y5cr8jbM7yC075ik2Yq8hcIY0WMVUhAQ/hhExzFze9kFO4INsrWHTPfndDeI3XoSlOxTNNbXxvLAgxJtrpcULvZ+Pya+F72AAtIwZ/H/CVgwH8eIqeybkT+dS4GjugWenTsRMOolqilU5DF8yioh3SNGb8Q72ANyTopAnFloYWWHW0Qy/WvAK+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o82Qm2VL7I5pArh/DlB3C8llIUBWaJ+qXF+dYoeidJo=;
 b=MnBjAMSO6p1XlGQIK+Y4SUasWfvSVdLESRPS7eDqUqml8BgEt7JsxP9NnxATxGzZe8Ye/c9xV/43SqPp+zJBHo+04mYGtNtuw5XjcGFC9n0C3dbTNZyoLW+EnT4H2T8cQxMu5KuCPljkxiBifBW76dl5SmZWAgB6BOrIL6I1USkOWMQ7+NlZcMbl6sdOVVCDPAUQ0diJKYEpafjyw2ziJ7ZYIibqkWNmOknSEiBG/NdGSJbyFGWu1kWakRkpf7WB2RExCX1ws6XB3hBLxQX45Sxjd4CdiUilPCoZz8w59Y0XXB0dOn+NQh+wICdrPt8IGp5Gah9uzGB0VjCDRbEXZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o82Qm2VL7I5pArh/DlB3C8llIUBWaJ+qXF+dYoeidJo=;
 b=vUaB/oPGPa0BxtKqetb07T0DjMmy3YdCTut0ONRogbCmyWbkcNosBk4WWVMbdsYC4Rj204qszY7vhjQrLq7JeTFH9d6r48PbVvn+KtbYT7nPVi3U/3od2A8n43kGi5wajoOUjZbjqpDcax4a0BqsSf+L+y4AJQe52WRIDmhPrAc=
Received: from BN9PR03CA0137.namprd03.prod.outlook.com (2603:10b6:408:fe::22)
 by MW4PR12MB7141.namprd12.prod.outlook.com (2603:10b6:303:213::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.16; Wed, 21 Aug
 2024 13:37:11 +0000
Received: from BN3PEPF0000B06F.namprd21.prod.outlook.com
 (2603:10b6:408:fe:cafe::56) by BN9PR03CA0137.outlook.office365.com
 (2603:10b6:408:fe::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.16 via Frontend
 Transport; Wed, 21 Aug 2024 13:37:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B06F.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7897.4 via Frontend Transport; Wed, 21 Aug 2024 13:37:11 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 21 Aug
 2024 08:37:07 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, <jgg@ziepe.ca>, <yi.l.liu@intel.com>,
	<baolu.lu@linux.intel.com>, <kevin.tian@intel.com>, Vasant Hegde
	<vasant.hegde@amd.com>
Subject: [PATCH 3/5] iommu/amd: Pass page table type to pdomain_setup_pgtable()
Date: Wed, 21 Aug 2024 13:35:52 +0000
Message-ID: <20240821133554.7405-4-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06F:EE_|MW4PR12MB7141:EE_
X-MS-Office365-Filtering-Correlation-Id: eda97ac1-0cad-4137-024a-08dcc1e65c3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QAXaUt1YAjp955d4Yd9yyaA/rsw3zJmO447SZWG8vJMhjMZyu+iv2LDdWORt?=
 =?us-ascii?Q?aePIGQ/SeIAlho151Xu6Ygkm1wWdHh4kUw6fKXp3Q2Fao61joDw3W6eS/EKB?=
 =?us-ascii?Q?qTj1L3ISFBy+xeNIqyKZdZhwJXbSWJZCUa2Kwdh+W3brMDgakzX5eFmFTS5o?=
 =?us-ascii?Q?8Yvy3qRTjedM+NX7vvt6x4GrgIW9y8d6RNHlp7mvqn5FmiNrM3Np064RuLwz?=
 =?us-ascii?Q?qFdPl0hZ3a0yD8mmL5KC9UOdxrMKDwv6ePw9a5jby8z7+xKx8e+Py5q0sghI?=
 =?us-ascii?Q?opy5byrof4MBsy43Y+woGW8XCi7fvYYjlTnjih0Ui4i3xookUtrz6NHRioXx?=
 =?us-ascii?Q?KD68Hze06Of3UI+Zh9GMjCvId5t/ODzj8s+4gOAJEO+WOEU8T8u6vcdYWcBd?=
 =?us-ascii?Q?twN1DpTvOV4wUHVdYRFvzA0kESwD1rAp/XBEp1bZm4Y3W5kfyK9nBa/eyHnb?=
 =?us-ascii?Q?h7XsMYkbKcutj05RNsv38+mD+6rjcFabgMhNWtYDKxiIZGWw0MQnsDAp3a2T?=
 =?us-ascii?Q?0RLGpxlumWuhBC+W1UlcatiN5RYpBgMIM7/kXXXKt85sz6wwDU8hxKV3Gt87?=
 =?us-ascii?Q?WaTU/TD9sUORYzsvtNHFu8nbrt3XdnLrtv3VfZhD8WI2D3UKWSjyHLR2DdXI?=
 =?us-ascii?Q?PsgDY1aZ75SyHhw85QDvg3zZe9KhVfL0fqr+m7qlA4eHUME8D1Ie92IOPAxP?=
 =?us-ascii?Q?bymNv7zDnAovgaAsWSsfOwIwVEVNIzJ1B1kqV2tWx5qe2H6UNSDGSI4sU5fh?=
 =?us-ascii?Q?VZvv3/Pz2jrA4lNYvdD844WPc9XxQQCM4SlKHsHE84I/loFRHQnGAZ0tkkS3?=
 =?us-ascii?Q?wAaJiIj+WrBHVpykKdgbHHV8HF5fhN+PiulVyZD6lD2pplENgyjsNdjb2qDg?=
 =?us-ascii?Q?nrBsmpxc9k5yIkNp4AAYb4d+8S1jNEXcr2YqyVao2elr8nC4FS9juQtu7U7O?=
 =?us-ascii?Q?a4nJVfmhX3VVmi454ZjsG9Q0xrW3M757r4P+kQwNLMtxxhDBhC/DKiWv9dQB?=
 =?us-ascii?Q?G+epS3zBhNHKvjOazvaUSF8uzYTlH4fKe6QTKRc7XAJmfGgSUq4IyNqG/hLX?=
 =?us-ascii?Q?OPoF4YR+mFPL8+eoVOudP0oLA7E7BxFpC53GMo1w8MQaH2WfGZaTmSj/V60/?=
 =?us-ascii?Q?o6nKcViw3ne00WAcHQRJ1mbzpYnaHpMuom1T0RKDHuTpHLgYVO3IxAEfMzVX?=
 =?us-ascii?Q?WzSvClUMW2DoZ2LI8fVuX1GFhBh6gecrNwmgpPBKqhUK9PmTfXd8zsqceYEQ?=
 =?us-ascii?Q?QeN2kdCQYL4jNhUFncwY2crYvW+PTa8iQfLCG2bUcC10omzORCyyBOmnaEnQ?=
 =?us-ascii?Q?K4h+y8K5FBSrQUg1b5FAMOoa/WH6Aza9nuv7pMPMx2FwSNtv3F+MKvDl2mjd?=
 =?us-ascii?Q?cNtacDwBVIAO7BeBlHKAT5wyp8gSg/fTSEMt9u8oBSKjuu0X2hPhE09LbRAw?=
 =?us-ascii?Q?zFbf+r7ZOpIlLdFmOiVaZtkb8ODUxlbr?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 13:37:11.3283
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eda97ac1-0cad-4137-024a-08dcc1e65c3d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7141

Current code forces v1 page table for UNMANAGED domain and global page
table type (amd_iommu_pgtable) for rest of paging domain.

Following patch series adds support for domain_alloc_paging() ops. Also
enhances domain_alloc_user() to allocate page table based on 'flags.

Hence pass page table type to parameter to pdomain_setup_pgtable(). So
that caller can decide right page table type. Also update
dma_max_address() to take pgtable as parameter.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu.c | 50 +++++++++++++++++++--------------------
 1 file changed, 24 insertions(+), 26 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 33930e08bd4c..817a26727894 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2324,29 +2324,14 @@ struct protection_domain *protection_domain_alloc(unsigned int type)
 }
 
 static int pdom_setup_pgtable(struct protection_domain *domain,
-			      unsigned int type)
+			      int pgtable)
 {
 	struct io_pgtable_ops *pgtbl_ops;
-	int pgtable;
 	int ret;
 
-	switch (type) {
-	/* No need to allocate io pgtable ops in passthrough mode */
-	case IOMMU_DOMAIN_IDENTITY:
+	if (!(domain->domain.type & __IOMMU_DOMAIN_PAGING))
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
+
 	switch (pgtable) {
 	case AMD_IOMMU_V1:
 		ret = protection_domain_init_v1(domain, DEFAULT_PGTABLE_LEVEL);
@@ -2368,9 +2353,9 @@ static int pdom_setup_pgtable(struct protection_domain *domain,
 	return 0;
 }
 
-static inline u64 dma_max_address(void)
+static inline u64 dma_max_address(int pgtable)
 {
-	if (amd_iommu_pgtable == AMD_IOMMU_V1)
+	if (pgtable == AMD_IOMMU_V1)
 		return ~0ULL;
 
 	/* V2 with 4/5 level page table */
@@ -2383,7 +2368,8 @@ static bool amd_iommu_hd_support(struct amd_iommu *iommu)
 }
 
 static struct iommu_domain *do_iommu_domain_alloc(unsigned int type,
-						  struct device *dev, u32 flags)
+						  struct device *dev,
+						  u32 flags, int pgtable)
 {
 	bool dirty_tracking = flags & IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
 	struct protection_domain *domain;
@@ -2407,18 +2393,22 @@ static struct iommu_domain *do_iommu_domain_alloc(unsigned int type,
 	if (!domain)
 		return ERR_PTR(-ENOMEM);
 
-	ret = pdom_setup_pgtable(domain, type);
+	ret = pdom_setup_pgtable(domain, pgtable);
 	if (ret) {
 		protection_domain_free(domain);
 		return ERR_PTR(ret);
 	}
 
 	domain->domain.geometry.aperture_start = 0;
-	domain->domain.geometry.aperture_end   = dma_max_address();
+	domain->domain.geometry.aperture_end   = dma_max_address(pgtable);
 	domain->domain.geometry.force_aperture = true;
 
 	if (iommu) {
-		domain->domain.pgsize_bitmap = iommu->iommu.ops->pgsize_bitmap;
+		if (pgtable == AMD_IOMMU_V2)
+			domain->domain.pgsize_bitmap = AMD_IOMMU_PGSIZES_V2;
+		else
+			domain->domain.pgsize_bitmap = iommu->iommu.ops->pgsize_bitmap;
+
 		domain->domain.ops = iommu->iommu.ops->default_domain_ops;
 
 		if (dirty_tracking)
@@ -2431,8 +2421,16 @@ static struct iommu_domain *do_iommu_domain_alloc(unsigned int type,
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
 
@@ -2450,7 +2448,7 @@ amd_iommu_domain_alloc_user(struct device *dev, u32 flags,
 	if ((flags & ~IOMMU_HWPT_ALLOC_DIRTY_TRACKING) || parent || user_data)
 		return ERR_PTR(-EOPNOTSUPP);
 
-	return do_iommu_domain_alloc(type, dev, flags);
+	return do_iommu_domain_alloc(type, dev, flags, AMD_IOMMU_V1);
 }
 
 void amd_iommu_domain_free(struct iommu_domain *dom)
-- 
2.31.1

