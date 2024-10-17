Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2086.outbound.protection.outlook.com [40.107.94.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3101DDA24
	for <iommu@lists.linux.dev>; Thu, 17 Oct 2024 14:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729173815; cv=fail; b=gthL+vBWGd1amCIE/CMgnhYu9wgJgWdbbynvG2cQ+8dRAlgHwLZ37yLyn0LglX0jsi67ChSCsHE7Kpd73ojBpxYfgxoAb/Ay5XkHO5Mp5Ja2NECo9w54lQpNXd6hC9uJhD8yp0rYM1+wsl7hG0sD+VWeFpUitk++L9T4wNLwB70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729173815; c=relaxed/simple;
	bh=gBFV8g/qvJtNcekGu5RZB9BDzYQCSe0QndAeDTHwo10=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mqfnWSWJJqdWo3Z6OG//Jhx1TomwknqVqz5XFr7kwo/oThgdpkbUV3jLZPyaigNpC3IFqyCCCU6Lg2ejQVg6w6M5L/dH/hi4SsPY6TRgToAcIwNAK8VU1bF4lfXT5zzpO7AczafKJpc7OWJlq3c040LfT9ohrF1qpAXfKVz7Oxg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FBrIn24b; arc=fail smtp.client-ip=40.107.94.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FBrIn24b"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G/VZDwgfyQqM6M1pnXj23ay5XuVw0mFOManMYOZW66yR1gWSo3f3vSRF/yvsV5O4qMpfFekX7ozz+Dx9Gozg1sHFoSuzlqXq4ez/+hVjMQVjJNdrQDSrWjea71hCwmbIVxOZ9xUCIQJJkbfuYxX1ECWr2ax54fOjraSsQ8RBmtOL6yFEJiP0OKPglq7xIeKQPov3zK6B2+PwIM+yy81OA5VwoVSRLFxBOJtXVzlaK7fAKaBB/Trr1pWYH6VLa+GQbxEbVDHGLUO7CEDcZfrk7ghH/47IHDyHeAjOZAqeVa1zoy9ae9m7wn/LHsXSbxa6SrKNZhiyAWiRGufZsjIZzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2mgrf8vLOx7AmaHYkNAMF6fi2IzZhhFkBQg3CPdC82E=;
 b=yARK9yD8l5/sIcTRqNYccvmKR3b5I3qzW7Wos1r1gOY4v/XYuLHH/fStOIvbtNn4XqemBo0EuQi7EQsQSc5vURT3elQQW+aYbYZwCEM+4ULx8ulw8TMW8OgiI8KiSwrOQwXV7qaKNhyOnjUGZZWrAlZJFx7GUtBXZFAyoXQfQCSyt0+kCXgaVJxTzlNar1Obu5mZ0jZcLRWpVgys7lipSeuGNreR/beXHMKdfamoOYtaozurvZkgCmteA25TXGbh/4eMwX+0aE1fIMetuqHqCQzwVYsp+OClwjxdLNm/2f5BBNscH8ZTl55YP1/+z84MZEmObtADKzAGc9qkpm1ySg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2mgrf8vLOx7AmaHYkNAMF6fi2IzZhhFkBQg3CPdC82E=;
 b=FBrIn24bDFRB7jLqx2k8bxR/9x5gDxZZPpNBcRQLxaenUTbkiwpBTgr3JUI7by0ja3LdP9TDJNJ8oatHT4ymLkaXIW12ff1JBWHpQwsn+oaPmL6JJi5QZwN9gHJlxFmDm8sj69iKNt2zSzhNRSmhhFcGeOBw2o0vou312BzNleM=
Received: from CH0PR03CA0274.namprd03.prod.outlook.com (2603:10b6:610:e6::9)
 by BL1PR12MB5922.namprd12.prod.outlook.com (2603:10b6:208:399::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 17 Oct
 2024 14:03:27 +0000
Received: from CH1PEPF0000A34B.namprd04.prod.outlook.com
 (2603:10b6:610:e6:cafe::83) by CH0PR03CA0274.outlook.office365.com
 (2603:10b6:610:e6::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.20 via Frontend
 Transport; Thu, 17 Oct 2024 14:03:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A34B.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Thu, 17 Oct 2024 14:03:27 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Oct
 2024 09:03:23 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, <jgg@ziepe.ca>, <yi.l.liu@intel.com>,
	<baolu.lu@linux.intel.com>, <kevin.tian@intel.com>,
	<jacob.pan@linux.microsoft.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v3 05/12] iommu/amd: Add helper function to check GIOSUP/GTSUP
Date: Thu, 17 Oct 2024 14:01:30 +0000
Message-ID: <20241017140137.6028-6-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34B:EE_|BL1PR12MB5922:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cc4c594-fc5e-4063-b52f-08dceeb47911
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UPVvD87hQqXyWP+T7C+mOoCCOqgV//eXx0Rxn+PzR11j+23lxxrMElNpCVN2?=
 =?us-ascii?Q?Xl0XXttc4VzvXh2O6JUjP/0Ek88V6fcxKuQRayIWM5wv0RW5UyF434Z898Ty?=
 =?us-ascii?Q?ygu92XdSo4c/8wqTQ2r+9xptLIhKPqEkxzQr/FbpMGup7Jke6TZkQtosGfft?=
 =?us-ascii?Q?FaseUaAY2F7iZ8w9MIa7pEaj4vmlSUcAUKiCqPmCAmL9cz8+lguq4zVCYqjI?=
 =?us-ascii?Q?3zCmKFEA5UDCIylS/uuI0j6y1Zflw8DfRFkC3gteLjDSrEod7zhd1wqaw830?=
 =?us-ascii?Q?E8r65OVHEo2UymK94PLdjDkAIh4kxeaTFPXHHVuyutjWbpK2ERXniHKouH2N?=
 =?us-ascii?Q?4lvvGzV3pekdTmlM8FEKR42wv4+MRLj+hMvtdnT6ezIV9lQCT1UJGLZzjRhu?=
 =?us-ascii?Q?6HK5uYbm2BV3Xm6V+Ub72QJPukNQZY3sAIZ2BCGY+K99yZQhEWigxR9atJh+?=
 =?us-ascii?Q?jHaUYOaPsvCN1MdcALx4nhgfgMweVmPyrCm/vTGuNyxEHpYmCH8yKQiHLwod?=
 =?us-ascii?Q?Pd/fUL6R/ITs96rXxGy/R6vGJ229CCo01FQFW0g7qYCkbISPai2NmqesqtMd?=
 =?us-ascii?Q?e/StfXnlsBV/sjZ1dsPC92qYe1dKsHq/OhOR1aFMl1MRTm6zk3BxfVqs1Z2I?=
 =?us-ascii?Q?kS8QcTaIV2QppSdvwFryaakiadvO1ldHWpi1EBLfiBnGsVxyvOtnN3ZDCIQi?=
 =?us-ascii?Q?MctNPuoSx4oZxIJJb8WepsK8dnDMOo8PRdJILVrOnzn4sSolTAmKCMRVxbcH?=
 =?us-ascii?Q?zg5exHGttwsRy0sb1WD3r97Ry0TqrXUs46CUU0TqysOkabMzRCmVVkTbEgjO?=
 =?us-ascii?Q?xLLVjpv4m/y8cmQLRILTmTvFvIegjvZl6CtixpahNkHHCsgQTBr+WAW1XurK?=
 =?us-ascii?Q?wuZPtteqEXAXFryrH0M65m2cZVuLqyBkLuMcax9CjkIBPhn3/TSUvSWo3RgT?=
 =?us-ascii?Q?I16aCOyypY8ErEQDoe1Qi+qyFDcozBZsL6A34Sc99kAzf5Y1/GkMJqMq7RZK?=
 =?us-ascii?Q?RlplCAOQkM5qD/pH04EWJmaEkRLQ5rmjlsRosKJHpPtj9CXDNE7txDzuTvZv?=
 =?us-ascii?Q?EzB7qv24P95aYHsSg8I7Ds1s4VoZSXwVh/IIGvY1hl21sjf1FAvm7BK1f8hH?=
 =?us-ascii?Q?z0C1y4JuDyZ8ilizFzsFR/2v5FtDt4QWbnsOHPzqtoE9V9ajFPYIa+2Xiv7F?=
 =?us-ascii?Q?aGJfMvx4cylhiooAdqANK1YSTUX37Xb1pCpqXB8UFZqWvPJ5TvIW4U18iXDg?=
 =?us-ascii?Q?zrxFtlIlu3MA2yacgTcxm7LBHOHdcty2TK9/Ubk90oy/UIz7Xnr53Et6viJ7?=
 =?us-ascii?Q?ddEd1Ct64CFVlhhqS21QpkH6WnyeravOQyASfj4EztuytHssFladC7JLP7WW?=
 =?us-ascii?Q?+bnZZR40uEAgkfeOJVb8hM7PhKxyRO2P14EN1PccYw7seTTFQA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 14:03:27.1714
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cc4c594-fc5e-4063-b52f-08dceeb47911
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A34B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5922

amd_iommu_gt_ppr_supported() only checks for GTSUP. To support PASID
with V2 page table we need GIOSUP as well. Hence add new helper function
to check GIOSUP/GTSUP.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu.h | 7 ++++++-
 drivers/iommu/amd/init.c      | 3 +--
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 6386fa4556d9..3b6c6332b09f 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -118,9 +118,14 @@ static inline bool check_feature2(u64 mask)
 	return (amd_iommu_efr2 & mask);
 }
 
+static inline bool amd_iommu_v2_pgtbl_supported(void)
+{
+	return (check_feature(FEATURE_GIOSUP) && check_feature(FEATURE_GT));
+}
+
 static inline bool amd_iommu_gt_ppr_supported(void)
 {
-	return (check_feature(FEATURE_GT) &&
+	return (amd_iommu_v2_pgtbl_supported() &&
 		check_feature(FEATURE_PPR) &&
 		check_feature(FEATURE_EPHSUP));
 }
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 43131c3a2172..7ae478d95e2b 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -2071,8 +2071,7 @@ static int __init iommu_init_pci(struct amd_iommu *iommu)
 	init_iommu_perf_ctr(iommu);
 
 	if (amd_iommu_pgtable == AMD_IOMMU_V2) {
-		if (!check_feature(FEATURE_GIOSUP) ||
-		    !check_feature(FEATURE_GT)) {
+		if (!amd_iommu_v2_pgtbl_supported()) {
 			pr_warn("Cannot enable v2 page table for DMA-API. Fallback to v1.\n");
 			amd_iommu_pgtable = AMD_IOMMU_V1;
 		}
-- 
2.31.1

