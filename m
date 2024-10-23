Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E45159209
	for <iommu@lists.linux.dev>; Wed, 23 Oct 2024 10:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729680241; cv=fail; b=aWacHdL1d4U129g2D2vSZLoTW3XdESSRLaPk1jWyRaFRAIBBXGuL2v4gfDQDBL2FjY6irjjapaXpePoxInIN0G3/sxXllZz9Q0nPOc9ypL/rYLxTBS8ZFxTvEDHakxsNYv9Ra/LNDnfrwBGoiuLAq+PtrkThOpJmGORUrBmlwqI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729680241; c=relaxed/simple;
	bh=PNRV4etEdqMJL+VG33b3hgOZcXW+RATUFopbMA5bUWM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aKetQYsfbN0sPkg0ULA5BC9s3CohMOjy9z5aYMzL/YJXNI8VSx/HQAWuOdNlnLL85IKZ4djlqSZOi3SSLGu2991q51I/aEQa4plpg1mxBcfZceSCung/+c8ssTbTU6BtM4qbBDzqEHaBo+ldf5IwMGwSVPkCvDgYwSsv9JTmIlo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jZcQSnSO; arc=fail smtp.client-ip=40.107.244.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jZcQSnSO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J2fCqaHAl9jsC5beBgiPoJZRP5CdPxmn0IjXcJQV07IcgBC0JQ0tCIb7JYSzMbP2DwjFo3g9QjnfVMV9S+obxofdHE5ijR4OE4sDH93FfNhC3mcuycTAK0De9oJ6tDjPwAILXuz7ZP2CQ4TkGPtqj2V8RgAA0ZZjEvZw+CpgQapWsp0C2LU4/c3T6KIJxc95QHkQfk6vQTwqB5rtz8WSGQY0LSgUTjvI4m6k9iA0jBzalnRu8gYzaWt7brSnxHhto8ZzrffDs4gS6drwAs8ThDd4OmXkGxvT8e+KewlbiHlEttdz/NR7oH9l6MOGm6Z78p9Qoi3+mpgjUo8oOmM7WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3J6Tqpsa5inp/IrYRolum1xlw+Rglg4XS315BosJIH0=;
 b=ecBjSdsXRCw3W0lVaVttEGJhaioKGb0nHhrvYt7zaFTHG/uMEJvNEDxu4KQYElcyMq9clVh1gYtxKRbANOiqGbQ5uBPuQUKK60h3Fa6PQfYX5KQihzZLWRT8qG3ipF0VnCAujjFGFfs+o9+4jym2ItqmuJx5tUgsKibgTRsFYDQrEKCnLximLJx9F6SC6Souq3A2orK0VZV09ekttkX3qa6NsXd2y78W3ZyKUDgZmGiDkeOIa/g0lHs031BTd0pQKNZ/PjweFOD8QkyI/gltZR2Ay24SoZeoMTRLqzKnL3N8OQe+TwcWuBHbnUKlEcXan+KcxOKDCfUSc5yi8r19Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3J6Tqpsa5inp/IrYRolum1xlw+Rglg4XS315BosJIH0=;
 b=jZcQSnSOSqjE6/9IFS2ubrg06d7gHp7ee8T3mSwBkQM+SoglmANBGojO+6fjt6qLbi6sq7ibIegrDd3XQHRDlET1UfheXLWYHvb5vU1r84eXnRgfSqWvpkP6LH5g2iVKCLufWRoJHohbrc/EUU8oDnS9aRQJPC0Lo658BQFaYsM=
Received: from MN2PR01CA0038.prod.exchangelabs.com (2603:10b6:208:23f::7) by
 SN7PR12MB6886.namprd12.prod.outlook.com (2603:10b6:806:262::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.16; Wed, 23 Oct 2024 10:43:57 +0000
Received: from BL6PEPF00020E60.namprd04.prod.outlook.com
 (2603:10b6:208:23f:cafe::88) by MN2PR01CA0038.outlook.office365.com
 (2603:10b6:208:23f::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.30 via Frontend
 Transport; Wed, 23 Oct 2024 10:43:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E60.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Wed, 23 Oct 2024 10:43:57 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Oct
 2024 05:43:53 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, <jgg@ziepe.ca>, <yi.l.liu@intel.com>,
	<baolu.lu@linux.intel.com>, <kevin.tian@intel.com>,
	<jacob.pan@linux.microsoft.com>, Vasant Hegde <vasant.hegde@amd.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>
Subject: [PATCH v4 05/12] iommu/amd: Add helper function to check GIOSUP/GTSUP
Date: Wed, 23 Oct 2024 10:42:00 +0000
Message-ID: <20241023104207.5894-6-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E60:EE_|SN7PR12MB6886:EE_
X-MS-Office365-Filtering-Correlation-Id: a1fcdbf8-043f-48ae-3118-08dcf34f98f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tivw/JYoSkdrHxxhOlQbAKFJaS/kpfR59QyoXw9pPzM/tJ9KGy63XLbbDWh7?=
 =?us-ascii?Q?S65A+Wc9e2o2Bs94ZGx/8RLZB7qKq5ykwBBX49DToqy9fgTsiviB39SaTjnY?=
 =?us-ascii?Q?mu2rFcMKLzvOJ+7lKbyKmSnDCwblEP7oeXUiUiATm8TGn7bi4bt9lC1ouZ2k?=
 =?us-ascii?Q?/puTM3Qg2McSii/2v545I2htkaiHRDSjngQflUhlPwMyv/KG4uhToszC1ZNv?=
 =?us-ascii?Q?gPNXpWjjHmEFCcO3RHMZYNdeNNBMhHJSJWisb2U9S3oFzcWKTBZtlmzhdpKN?=
 =?us-ascii?Q?mhoxtXWnaC8ZUT2hn0zmmVWWxcpqD5oNtorrLuC6gJy6mo+ECVYW1swnkUO1?=
 =?us-ascii?Q?yla+aI7htO5U+W6rK7cAAH/X8yZ7yI6hoLF1JjC0gn/lkcHgkgbrTwKMCrfl?=
 =?us-ascii?Q?yLNQtG9q6NdimDDLm0XhLckf7/gA67XYED5pPSd1ClQsLKVgzmWHNuI7Rp9Q?=
 =?us-ascii?Q?2LMUUh4Tk3y22SGoy0yQpIkodcOOWtc/zZWjZ3Ovr0Yv64qIYEPLwdp/LrPN?=
 =?us-ascii?Q?1nL5QXdDYA6IZKkNJKom6MzaMOzdqhXq5QVcWF0CIqWUt3GTmkTr++jnOZkN?=
 =?us-ascii?Q?+iBM8n28vdnePGRS4FC9wmcPUne+r9RciZd02jTzHEeBtzDEXu+xvwf8wP4v?=
 =?us-ascii?Q?BY+Qsiqsr8V0YlHvENOAoas3AnBm1/zsOGwh19TPjFt/B8U+0wWchIzuy9eC?=
 =?us-ascii?Q?lw/k04lYez4K2s2O5n0UR3Rk1KrQsalHrmFDmdZV/dTWTTy1yZ8KeUiLY/5Q?=
 =?us-ascii?Q?yNfkcU7WM2f57C/4jlkrfT2LCvyvAN69yF33ARScJ1yjtHwF2698qbTUz2zZ?=
 =?us-ascii?Q?w+v3LKc5wW1Qe6o5MNua2kqR7ilRADSV38foi1iM28pV7aFHO/rhfc2YfsAr?=
 =?us-ascii?Q?1hooKepPEgS0Dxoq2tP+rzZ1z/0UguHaBhKKsLtLp7CspkmaeMi3B7cgCgkr?=
 =?us-ascii?Q?rTgMYqAe9YkhNeJ9+i1r5zy59sgPh9ZI0PIFcZYWEQcKYbaxQIQuB0myZjBD?=
 =?us-ascii?Q?rDO2aFJYHRI6qcWx96ygiEq9HVH8dIOjI0mq0JNOJYEHhGYSOACtTu1NM69k?=
 =?us-ascii?Q?gH/r+0tWsDw6s+SD4Cp4fmBvtPndIBogpvtkznFFB9R1Vq6WOHDs2hMyKhdq?=
 =?us-ascii?Q?WLl3m5RATudHy9h2SFKxeoSPC5sWMxcbJvEpY35RHF3qE9TzzfnZGVaibrZT?=
 =?us-ascii?Q?XjZEb2diYYLFrd3XtG9p3kDr+hrxINPE8J+Y1KvVK8EewQLpiqE9DX/FcjDe?=
 =?us-ascii?Q?uGvMCBSYfjtyB242Dnk/1InG79Wo6UC8MPCwe6yhjqGVwo8A8GKDVubEwbhg?=
 =?us-ascii?Q?sdX62Xu1LNVBM+a5iD3Cl43SjzuPNK+HmGKrCeW97tzq58+Sp+ii7v+iZ7Av?=
 =?us-ascii?Q?gG/DxlzAA65lQeeHYxItSbL30Eic1kBvs0C/Tjfhg/I+agBK9Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 10:43:57.3380
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1fcdbf8-043f-48ae-3118-08dcf34f98f6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E60.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6886

amd_iommu_gt_ppr_supported() only checks for GTSUP. To support PASID
with V2 page table we need GIOSUP as well. Hence add new helper function
to check GIOSUP/GTSUP.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
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

