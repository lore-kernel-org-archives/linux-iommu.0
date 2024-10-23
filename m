Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2089.outbound.protection.outlook.com [40.107.101.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E0D136331
	for <iommu@lists.linux.dev>; Wed, 23 Oct 2024 10:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729680227; cv=fail; b=glQW2DPjTErbM2fvcoUcAeY6Pi8W3PWy4tLYsymXNm1O6SSXXok3XxPweJDp3LcxzO5oJzfbFaCH8uRAKVy6QJA+mHu6N0fK8cUsC20FDFmh5e8NdPwBpuo9hsRFO2ikIa/RC0CUCuiqEgZNiPiAuyNFlD2qliaCSK7CXA6WqU4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729680227; c=relaxed/simple;
	bh=CbmqKLO+PMulqgETx7apy6j56iE6zvzbDf691BLPXks=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t9LDwwO1EtJ017eXNO9wD2yGjAMRlhWTgtgAfE+MtGYvWIeoa61uh770B7ub3ekdBFuRiEYp5p7hdNYRilzehW2ypBi/ChntgPfu/hbomHDpjxZqetx6j+5CP8RcKi2Cp3C4Os9fssYSwuyu8BDKRCO7IwYnQevTwIXGx5ms18M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oILlYHPu; arc=fail smtp.client-ip=40.107.101.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oILlYHPu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fs4Ff7xSw71DJj7BFWy2BJbHo9YeFmCMUqZKHUzfsH0ieCCYT5/aYbz/lNc/3TF4KQB09euXLODOdbvcJ71wsTH9vB2eahKQpGbDBw44gfNnIRauPcohfi4K/Osa1O3mXwH80fgjDPQ2dZoj/AVOU2hbiX1QpJS/G1YVWuS1IZkySAt1xNQpfiBUbp2r4e+BNVinkvOFJv2NdGPGHlyNvKhen6a57cLA0lF77JigAlK9o5yf53EYANfbzJANtCJ6cAyQISqMtgEVf45j9joge9l3TIoQcXlBuGC5qacEjobeC1jq8juRj8pQ8tDWzyFZrUE8Fs6sMS2Fm4ZYLzhv8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bIp3+ND4s9wrnCKUddN7aUfhZnLGQ73jsvcbpKzHqZU=;
 b=SjWVlCiqya8JXbOO/CI4dfdXD4eyIpqipo8qDfsdigFGYkrGkcJ76KbzDuYCGcEB4NW3Z8ljIeaunfUDy2LfnTYR3lyYj/DQ7SQjbCqmZQPL88v2Xrun2ZW3IkNYDEBtiA1fW57vmEsUOvx5XqxmajJTwLXCz34RiB4QKaMEyMgQonZdGEJmAXCI38gymKEj2d8LPLCCnlVPL2CN4mS6dcFq+dbR56ZHD1z5FtELATVyqS17mN+YTG9jgeQJC0lvAuoa3LyoqjliivU9tG5YqpwCsLGD0Q00UT+K6h/vcCFJMHTEWdnSwSYcUVGkwyfBW7+Z/ciLJq3cMVGHU3GKsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bIp3+ND4s9wrnCKUddN7aUfhZnLGQ73jsvcbpKzHqZU=;
 b=oILlYHPutdt13R0Y14m07en8wSAnGv3KZmWb0za+endCvHVzzThtIZxWQHVx2xFKqP3xHCAVIqUdSc6EKSJtjQHpMF98Y8PynR5eSjGxnwAZFOBDEOfTmuWF0ySGP6Ov2MQVTq7i1g32qlBfvvrk83mcs9U6Ygt+XENbiI2FoNw=
Received: from BN9PR03CA0589.namprd03.prod.outlook.com (2603:10b6:408:10d::24)
 by MN2PR12MB4334.namprd12.prod.outlook.com (2603:10b6:208:1d1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Wed, 23 Oct
 2024 10:43:40 +0000
Received: from BL6PEPF00020E61.namprd04.prod.outlook.com
 (2603:10b6:408:10d:cafe::f1) by BN9PR03CA0589.outlook.office365.com
 (2603:10b6:408:10d::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.18 via Frontend
 Transport; Wed, 23 Oct 2024 10:43:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E61.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Wed, 23 Oct 2024 10:43:40 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Oct
 2024 05:43:37 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, <jgg@ziepe.ca>, <yi.l.liu@intel.com>,
	<baolu.lu@linux.intel.com>, <kevin.tian@intel.com>,
	<jacob.pan@linux.microsoft.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v4 04/12] iommu/arm-smmu-v3: Enhance domain_alloc_user() to allocate PASID capable domain
Date: Wed, 23 Oct 2024 10:41:59 +0000
Message-ID: <20241023104207.5894-5-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E61:EE_|MN2PR12MB4334:EE_
X-MS-Office365-Filtering-Correlation-Id: be4184b5-144f-4131-19bd-08dcf34f8f1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MOhwiw8KhPGkpt1qXuuSxFaTMksYYI/qsl7HNSXqI6/AEWXBCmgCG00eFYb6?=
 =?us-ascii?Q?v9MwFjNpzPA1RaJCo42hvT2MayOdlqh1O/UuOwlyDDKKaLIjzIrxwjaxtM9v?=
 =?us-ascii?Q?3shbA3ztBafJHUHTktd0aGD4gkiIpITUI5mC7ICQEnKLMf7EzYWC69bFV9bQ?=
 =?us-ascii?Q?llwg+ph+aBb5B4HrLi8G+azvX/14rRqJeyskh76zmiLet4VymlFDtH3Ge/n8?=
 =?us-ascii?Q?A8wwAlpHMSQKRMi2rfd821IyiDTwfGiFtrVcdCo3R+AsrbWuNDXrxr+i2BsT?=
 =?us-ascii?Q?fFSKvyIPnO65CkcDXYrsoL9syqVpce5UG55Y4bSpyOrdxNknOY8+i4Z19IXQ?=
 =?us-ascii?Q?1qi4Mj3StUHFbRU9DasgcLold25J4J7fnx0+Rv1/4sv+7UaKX1tJraUpYboN?=
 =?us-ascii?Q?X06NtT5mFpi49bps4pd9I3CAjc8BEg9hdCGiw/7hn0vQAQ2kaRRhqn6ZTf22?=
 =?us-ascii?Q?m0MDNtw5nx62sLRRCS7wZOySgi+7py2TnKujzQGBbQGGF53UNApea+EP1mf1?=
 =?us-ascii?Q?Bq85Pa3Iud+yu51LpMtdpUgmhamEf53BdiIKmH/NjGWpB9Gv57/UDrBmW71z?=
 =?us-ascii?Q?HUkY9Nu28TYLsYZkCuldxgNrX0o3CIbA6LSCTvzY07LDh9Mtgcb1DETfGJ2X?=
 =?us-ascii?Q?XJGbvXbk9OKz7Vfeah7w0fJHQZ+kybtUvN+Fb1bn9CPJvNMKdIHV8fgdcvpt?=
 =?us-ascii?Q?oFFHrRtH4wt9iNNaI6K/1L2VVf9rwjGGh9IxLUboo79PrYjKKrSgy0WGjxMp?=
 =?us-ascii?Q?0e2K8u6qNtUdC7RCiGJcD7iEcSVPLVQ0uKCWKLlG+uhGULXu7XoQDkj6Wpnd?=
 =?us-ascii?Q?iHE4A7EoSSAt8D0KzqWYKLUrgWyEBOdkb8d69pql1YdW22596c/mzjkt2hH7?=
 =?us-ascii?Q?4/wPynMHIxctB3IVZSmaCafpewae8o2EMuttqm5UVk2osojZFp81npYVeGQt?=
 =?us-ascii?Q?AFqy0tBQ2z9SC+JUrMB8gEDPhdfpq3FyUBTcHWuFbo8HZFr6PLttMXVnmWqq?=
 =?us-ascii?Q?OyTctjKJ3dRJjdFeKwdA3rltcd4ut1FmTRsA1FoZ0Nz/D4WvFn2O42eidFl5?=
 =?us-ascii?Q?EW4ED4dPyAt0MqHlUUIB+qDH7ARqkwm0MTLGwX2rI/WdkryH217ESnnbOPid?=
 =?us-ascii?Q?iu58GqmC4ymrUL5Xm44mRbEZVoisPqgN53yX3qBipUJE5jn2FwCu2AAoncH+?=
 =?us-ascii?Q?U6c7BJ9XrL0BSkqmApO83rgUVgxEVnGLLKb7ZWzXnFa+j4Vv6ryqa8nZWP9s?=
 =?us-ascii?Q?LGr/qmDeK9p1go+8OFnVqHKYdntA/sMuORRBzMEdPYHSgAa5yzA1Zl25hnmP?=
 =?us-ascii?Q?1gIyr/P/agVG1CMnop7VnsrACUbJ3DYbR2zgN5KKkuvuuQoftaQH13MI6jOD?=
 =?us-ascii?Q?/xxLdYELtbd7Yn9LKdHon5TnJm8oPFmu29/urXMQMgn9BnuXyQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 10:43:40.8223
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be4184b5-144f-4131-19bd-08dcf34f8f1e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4334

Core layer is modified to call domain_alloc_user() to allocate PASID
capable domain. Enhance arm_smmu_domain_alloc_user() to allocate
PASID capable domain based on the 'flags' parameter.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 737c5b882355..8a193141f003 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3084,7 +3084,8 @@ arm_smmu_domain_alloc_user(struct device *dev, u32 flags,
 			   const struct iommu_user_data *user_data)
 {
 	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
-	const u32 PAGING_FLAGS = IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
+	const u32 PAGING_FLAGS = IOMMU_HWPT_ALLOC_DIRTY_TRACKING |
+					IOMMU_HWPT_ALLOC_PASID;
 	struct arm_smmu_domain *smmu_domain;
 	int ret;
 
@@ -3093,6 +3094,9 @@ arm_smmu_domain_alloc_user(struct device *dev, u32 flags,
 	if (parent || user_data)
 		return ERR_PTR(-EOPNOTSUPP);
 
+	if (flags & IOMMU_HWPT_ALLOC_PASID)
+		return arm_smmu_domain_alloc_paging(dev);
+
 	smmu_domain = arm_smmu_domain_alloc();
 	if (IS_ERR(smmu_domain))
 		return ERR_CAST(smmu_domain);
-- 
2.31.1

