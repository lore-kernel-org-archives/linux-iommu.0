Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B728F1D043D
	for <iommu@lists.linux.dev>; Mon, 28 Oct 2024 09:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730108471; cv=fail; b=Pv+nwqzHOn17G0sPpHII/Lhl2OgS6YCMHIEAwAgHGyKqCe/hPtWFD3AbQ9ZINuINtD2PAI34qs6mJja/N/Q58E4qOygBMMwcJaLRmEmQwiOi+8iNiEULTtF9Zf0krabKonsets3D1v5wu75oADCiQJmCwTNhJJ+yXBD8k3pZ1tc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730108471; c=relaxed/simple;
	bh=S6oxKPnrtPUvMuZG9bS2Eo7sRhmdbzw7cq8dftGBzHE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UiXCma38q15YX8+tDzduC7cvrcRXYumBez1jki4TzKmRIf6W7bntwqA3dXUK0fofh7MkRkqGEpN/KYU9xogtPUNt+Pa2gsd0pJL/6OVjrvB6j7JWOkv7KqW0m6twz2IHsiLGaIQwCTM74IhcekNLOIDyMNPrmb5uiera+BwXYcM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eV+eTJ9P; arc=fail smtp.client-ip=40.107.220.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eV+eTJ9P"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X/8DimZt9nl8Aq62Npa3wW/7m70lMiM+uckXF7FLx9fbwNnjujLoJuIkQbOGaj5CNSVdhw+8ZBWPtBemsSfVHpdAh98iEybCtwHze35XlD9RXfreZ/qGkFQnYvWnfrEj6DlvLGKyrq6vTsDUknnXh3mXR7O+C3aFjCGFAOi13U20AtC0FYuSSU1DgneOdFMlmBOPp2BL3cGmnjS1VbYSpxVlgzbLAP8Mf1CQWSDZ0YJwSIRbuBP+voruYNaTvTENRhMmsU5P19sxKuw7x85HHYsc9slpIpXhJVU1Tri8dTUYXe4YFOoAAGnwLTwYvskiCYOXRGFRsaYx4i4MUt9qJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ENWeqEBqDMBgqIzYQW4hUEaZggcXfRjRBDdM97GDvuQ=;
 b=gF+eNCi4Ijkd2VdDQJrpeq1G3PXVS17PkMvrkySJ9IPKHFcGnwgsAYWFG1oIRJMQkl9kPWEwhzskr/5Sd9lf1UDA9fIZYr0X3J52CjTe5eyN5H7K7l31hTv/zJNHuKp8QDzK3q9mT86HuHwep3ew2C/AbICASDwJhXfpNrl1N0xyo5pcFUw5y/74OW/rRbl1QO09RigirdsOqDJbIzwgIyyR/ij0wiXAIKi6BbMoNc2I+XDx69gOy3LWzqNDY24286AgSrRRK5nbD9ale8Ev0Q8rZDVm+xA4WsDRfUFqTrDdHQtiCTVM+peFD5eTWxYSvnhjBzp289mHkiNT/r9AyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ENWeqEBqDMBgqIzYQW4hUEaZggcXfRjRBDdM97GDvuQ=;
 b=eV+eTJ9PhHRg697phYeTpPE0q20ciBCGKVRZrHnH6Fa3NfRkUK4fDElD0X7lVMv/p3hW1cHvYpcVh58MITdJe1BIhrMXTZatpbF8TiSLElN6GyjJBt5L4y/d7MGOUubQbY8dGZKf0FUsE84jhlCy1zWO5qkPEsvUOtJIDKdwBO4=
Received: from SJ0PR03CA0299.namprd03.prod.outlook.com (2603:10b6:a03:39e::34)
 by PH0PR12MB8775.namprd12.prod.outlook.com (2603:10b6:510:28e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.27; Mon, 28 Oct
 2024 09:41:05 +0000
Received: from SJ1PEPF0000231B.namprd03.prod.outlook.com
 (2603:10b6:a03:39e:cafe::3e) by SJ0PR03CA0299.outlook.office365.com
 (2603:10b6:a03:39e::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23 via Frontend
 Transport; Mon, 28 Oct 2024 09:41:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF0000231B.mail.protection.outlook.com (10.167.242.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Mon, 28 Oct 2024 09:41:05 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Oct
 2024 04:41:01 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, <jgg@ziepe.ca>, <yi.l.liu@intel.com>,
	<baolu.lu@linux.intel.com>, <kevin.tian@intel.com>,
	<jacob.pan@linux.microsoft.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v5 09/12] iommu/amd: Enhance amd_iommu_domain_alloc_user()
Date: Mon, 28 Oct 2024 09:38:07 +0000
Message-ID: <20241028093810.5901-10-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231B:EE_|PH0PR12MB8775:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c31ebd1-7cf9-442b-ab26-08dcf734a49c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JvChT2iRNQjcC8QkMKS/rEU1Uy2yP1+GV6ylFFs8NVwuBm/68DqfP+MzuzQ3?=
 =?us-ascii?Q?t+MYb2GGGClDjAS4rSenaC4DJSbnEPOwXgUD8ka2LTWXxLasX+4uib60EKOl?=
 =?us-ascii?Q?E/uCHQ6p9V0VIlFiz50+GnB6WAyQlec4D92Z1EaW0NV1cwKi9EYUJkBi9zH5?=
 =?us-ascii?Q?YORVWhm1cT6plVEFtHyC1WFNwk7QZwlQOdPDGYUR+sv52w0WxlsZBOBiHudK?=
 =?us-ascii?Q?wePVu/r0+5TuKVzYF8ye/KuvCGgFjDafBPJOk2Sz9Fe9LMjmYCimhHUzPkzo?=
 =?us-ascii?Q?Tr8qym6aiU0bxxELpgar99jjrusjRWJVJqKhDMOzl/nGpvPb4H7FmToAUlm4?=
 =?us-ascii?Q?9uOzEBVNAOqHndrp8TzzQj89dRwp0JnbNgTObrMc8Dnds4VkTARU4wmL6chq?=
 =?us-ascii?Q?NZkLxw2JlgvBPgPxa8kgFZsV31xEixtwF244viRUh1DTn58z/oHitsVyw9kD?=
 =?us-ascii?Q?Qu7esDMyKTxRWYHIeLe/ZbWkubc10A6N+T9RyzIDhxdUnpOMf3FDe9+T8Kyq?=
 =?us-ascii?Q?3qJIPWypwc+JEVo5Cxq0hYEZo/WJ4yZnI3BDa+cvxm+KNATCp3RCiMf5y9or?=
 =?us-ascii?Q?r+xCAEkHfaGKkZGjGeleYyyKWx7kQIjBR82EiocxRV0GdV+mKTogHDJt4VQA?=
 =?us-ascii?Q?RMmOMZdvwb+bj2hJVrn0ofJ9/eKB53PsdMEBZBiczG4IdNfXPlRZ2FYjo3Zd?=
 =?us-ascii?Q?YtpotJZqJVOnypgQkjyJ51C2/TWzye0YTFJoLh8z9UKuaBsU9I3p5pG6ApvS?=
 =?us-ascii?Q?zkJZrjC3vpKFAde/fs7FJSbavI/nBSo31X+q6XZ/7zvH4SmOqxHfM7/MS7Qg?=
 =?us-ascii?Q?cHag9J4OaRIQdB/WPOVlT2Gk5ftl3FP2MF8peNOW+5Uc4eWbVGIMAE/NihTD?=
 =?us-ascii?Q?72osbcaIXfr4xd+zrDQHmCMcZ7/kstEYM8rZxwIgV0JOvYwl1OJ2yP4lEPl/?=
 =?us-ascii?Q?dCTaqR8Cr+u6LNhiLZi7dxMY4TM1VYmSoeC7XVUzzCx9Bj/E5qEfW50yWP12?=
 =?us-ascii?Q?+iv+WQi1NoWcEcLeeEyMC+GTO7OYxTlXchXutT2xKZ6Qv8hSoJMh+tCTqowG?=
 =?us-ascii?Q?FkpO99++WCC9WpQlEC/ZGEyS+6aujfw8a/QdPDAsYfpWGXNP6jHFIcfwQtyF?=
 =?us-ascii?Q?rWn9YfBNjL1xiCgmlA82QFGmbTh69iP1D+CmE34GIbMlCKzyYDW11veVvHyF?=
 =?us-ascii?Q?HtRx5Q2TP308aJEJ0urUjX64qGp40x7Zv08qgjG5pFv145U0h1n4pt0+yQ28?=
 =?us-ascii?Q?jQqjnMUAgKKou//iHbRoA3esdXZz2jAq2lVFSzEemizSiGO0AVyRKGRpL6oP?=
 =?us-ascii?Q?aPVE/CKBFO7GF58AE0SAtNjH1JBIcK04whCjWbbmzrDM6LhzkrSdmCFPgmLm?=
 =?us-ascii?Q?VGEkCpFmtNraGrVEbLRZ3jE8M6Ao8Qa17Eb/n14usjLonaiTxw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 09:41:05.0296
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c31ebd1-7cf9-442b-ab26-08dcf734a49c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8775

Previous patch enhanced core layer to check device PASID capability and
pass right flags to ops->domain_alloc_user().

Enhance amd_iommu_domain_alloc_user() to allocate domain with
appropriate page table based on flags parameter.
  - If flags is empty then allocate domain with default page table type.
    This will eventually replace ops->domain_alloc().
    For UNMANAGED domain, core will call this interface with flags=0. So
    AMD driver will continue to allocate V1 page table.

  - If IOMMU_HWPT_ALLOC_PASID flags is passed then allocate domain with v2
    page table.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
---
 drivers/iommu/amd/iommu.c | 32 +++++++++++++++++++++++++++-----
 1 file changed, 27 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index cb6a72564c23..671131c22d9d 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2346,9 +2346,6 @@ static struct iommu_domain *do_iommu_domain_alloc(unsigned int type,
 	if (amd_iommu_snp_en && (type == IOMMU_DOMAIN_IDENTITY))
 		return ERR_PTR(-EINVAL);
 
-	if (dirty_tracking && !amd_iommu_hd_support(iommu))
-		return ERR_PTR(-EOPNOTSUPP);
-
 	domain = protection_domain_alloc(type,
 					 dev ? dev_to_node(dev) : NUMA_NO_NODE);
 	if (!domain)
@@ -2403,11 +2400,36 @@ amd_iommu_domain_alloc_user(struct device *dev, u32 flags,
 
 {
 	unsigned int type = IOMMU_DOMAIN_UNMANAGED;
+	struct amd_iommu *iommu = NULL;
+	const u32 supported_flags = IOMMU_HWPT_ALLOC_DIRTY_TRACKING |
+						IOMMU_HWPT_ALLOC_PASID;
+
+	if (dev)
+		iommu = get_amd_iommu_from_dev(dev);
+
+	if ((flags & ~supported_flags) || parent || user_data)
+		return ERR_PTR(-EOPNOTSUPP);
+
+	/* Allocate domain with v2 page table if IOMMU supports PASID. */
+	if (flags & IOMMU_HWPT_ALLOC_PASID) {
+		if (!amd_iommu_pasid_supported())
+			return ERR_PTR(-EOPNOTSUPP);
+
+		return do_iommu_domain_alloc(type, dev, flags, AMD_IOMMU_V2);
+	}
+
+	/* Allocate domain with v1 page table for dirty tracking */
+	if (flags & IOMMU_HWPT_ALLOC_DIRTY_TRACKING) {
+		if (iommu && amd_iommu_hd_support(iommu)) {
+			return do_iommu_domain_alloc(type, dev,
+						     flags, AMD_IOMMU_V1);
+		}
 
-	if ((flags & ~IOMMU_HWPT_ALLOC_DIRTY_TRACKING) || parent || user_data)
 		return ERR_PTR(-EOPNOTSUPP);
+	}
 
-	return do_iommu_domain_alloc(type, dev, flags, AMD_IOMMU_V1);
+	/* If nothing specific is required use the kernel commandline default */
+	return do_iommu_domain_alloc(type, dev, 0, amd_iommu_pgtable);
 }
 
 void amd_iommu_domain_free(struct iommu_domain *dom)
-- 
2.31.1

