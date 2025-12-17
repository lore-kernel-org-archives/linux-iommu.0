Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011045.outbound.protection.outlook.com [40.107.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E913A33064F
	for <iommu@lists.linux.dev>; Wed, 17 Dec 2025 23:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766014816; cv=fail; b=NA40M2ruoc95NdKbepECR9O1prbQgxaJtJ32mLNs3zkbCqyvwQ/n9ftHszJAghQuegprDlC5xPy9YbAh7bUzhLUT8OylcOjijTOVr5dpS/mggpEmlyDR0cQIQZDDNwy9LvhXZDx/v1tOXwMevoIPhfEx25jiHQZS6NIpmKcqJOA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766014816; c=relaxed/simple;
	bh=C/xdiENoWhh3rgO4t49jItVKw+boHDVfQj9OVDyFq1s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g9n5bcW2giq6885jdImMABehfxxn3xi3ZROpWqSJKwM36X5ZLHU1I60Mec/23LRiQfZETE2Q+6P3wt5Tyb31oenDSDDP8rQlvTan1jyv1ndiNKd+01FO1FPztN+befenLFWHsTNdJQdOyjL5FkZlkPXmBrCpQmfePdSxnhVMPeU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=E2QC+d1D; arc=fail smtp.client-ip=40.107.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="E2QC+d1D"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L7c1XLUmARMyP/GU73PkHDouOca91emXpEESpl+QBiLDp+a97hrQ22nOGj4l5gqwdkKD2QlIZP8P9kJr76sZCSLhjWp+UoM2Nng01uWcUNL4vsfs2cgzFqGTBSVqaR6a3PkSTTmNnfxfCG53a6h99/xrka1wF4YLiKT5UnsI2uytQcofehaQ/Mqy05cvJ95sQE2yX9kp+65u99dq5Osi0kgkxfMcDaviLR/R4rkL6/nNtOnXX5VE2/6z2ivBhty1siikB8WWtbZhqLTGG2QtoEk/87s/R8iYVTQ0FmSOd3x8Q10kFjrcOHbYQuUkJALI1k2SIr9qw1ZSjvh1wEZgjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bg12Yw8tY3diF76Z9B9BKu6uy1ZeELmLDqKgcSNmnuU=;
 b=QrTF0CoRbj1qlgn2v7+7CppYhmNqz2Pd93rF8memMh7mRa1Sgkfzi1QsUzjjC3m+cuR/C4Cj1BMR/DoLm36RUddn7M9G+/RnmZYVtxLeFcqEQ+mtjAOm9jcB96ooh5zLC3rv7fJLcLP1QWKJmF6sTON2iFKPKv2D9cN4gbhgF6FlIiL+FqiEdQjSEKMtmzI7zlLnkwUdFK7SzFeXc8SnL/a0vO+1sWvxIZZmK9qRWSLTrWB3DlTkC39KBDLl3Nx/NWVpbhpmWeEb6p+nzefDdPBQzDw+jcN6ua4wFBa5PGcFO94OWcmIyCRjd3so5AqB3JWmjHf5XXQPk3Ipt0ylpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bg12Yw8tY3diF76Z9B9BKu6uy1ZeELmLDqKgcSNmnuU=;
 b=E2QC+d1Dopz2oCmBlCU6kp+CHyM1/+ld3OLCNVT6la/Yan1OZOnL6zXQJVb0ly48+OmOyHXupmMpckYzFvz7IuGfjQryhtfjMtCyQV+HbBAvoxUEJ+8rYq0O+5rm73oo9LubMs90qemYUN4pSA1Yh04o6iEexlhBmTRK8PGuEWZgWfLvyBBwa56tbQDUy9nmPKeItWSGvLGK3W/s4AOPqEfKMl1smuY5f3BPSNEoo+5gXItEhhA7P4kxqcb94FHZQDDaNeyqFH6WcCxwGsoj6BBSxmXynLL9pR4eX/+XZpNDzdqe0b6QgC+qJ5N/zL1RKjbRZC4zOIobVC7m5T6lGA==
Received: from MN2PR04CA0015.namprd04.prod.outlook.com (2603:10b6:208:d4::28)
 by SN7PR12MB8769.namprd12.prod.outlook.com (2603:10b6:806:34b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 23:24:59 +0000
Received: from BL6PEPF00020E61.namprd04.prod.outlook.com
 (2603:10b6:208:d4:cafe::2c) by MN2PR04CA0015.outlook.office365.com
 (2603:10b6:208:d4::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.6 via Frontend Transport; Wed,
 17 Dec 2025 23:24:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF00020E61.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Wed, 17 Dec 2025 23:24:59 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 17 Dec
 2025 15:24:46 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 17 Dec
 2025 15:24:45 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 17 Dec 2025 15:24:45 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>
CC: <jean-philippe@linaro.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<jgg@nvidia.com>, <balbirs@nvidia.com>, <miko.lenczewski@arm.com>,
	<peterz@infradead.org>, <kevin.tian@intel.com>, <praan@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v8 1/7] iommu/arm-smmu-v3: Explicitly set smmu_domain->stage for SVA
Date: Wed, 17 Dec 2025 15:24:26 -0800
Message-ID: <df4b8cbc0d67a0bfcccb09be868e0da5f0cbb743.1766013662.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1766013662.git.nicolinc@nvidia.com>
References: <cover.1766013662.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E61:EE_|SN7PR12MB8769:EE_
X-MS-Office365-Filtering-Correlation-Id: 4eec842f-5c71-4938-837a-08de3dc37f5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?hj9/yq9TY7haNB6EiAO3PY1gDq3LB+qxoT+GK4cmmzqS3gM0dffg9G/NjMYP?=
 =?us-ascii?Q?grmS3ha3ytshccTf3rbG1E/Aj5xrYKR5uuUqVJeIdcuotXyeObkVO0yoAPmI?=
 =?us-ascii?Q?nGIMO5xitfKa7GJFjoyghj3DUezbqxwO2U9fHYOU6Go0h+E93lmKPFTTC0wU?=
 =?us-ascii?Q?SHMQcCX8u+Wp6IyAWyWMRM1KxlLSQfFdFWalf0KMMZanZKVLbzwfL/vCraDg?=
 =?us-ascii?Q?qLn8EQH6K/9DoT737SySfuxwk+KPTQQp1JwNl8RkuuIEWbJqongS/nowK7s0?=
 =?us-ascii?Q?SDKsZU1n+xs/fb7MUu0OZafRrOXQXSBzcVFU6wyeoIjxMfK2h3Wj/PiPAmKR?=
 =?us-ascii?Q?aB8yqAjmarVChSsbVgHlRJynkGMo5MSBoqDKZVDMxhlRxuODz79cAkyve0qW?=
 =?us-ascii?Q?afC4Pd1j+WH46NpnLsK/DQetzcfOHeSOvVVlLB8uN2pQCBSfEH2WS1RQaqeg?=
 =?us-ascii?Q?E6QRgb3PuaMWzjt4i0qcTcru8FmKEf+deeqUz4SkzlKAZWJ4NPw0RX1AbnB8?=
 =?us-ascii?Q?ptFvpAaYgRwlXEsUy2F/eFc/xCrWVxSrdKz/YvrKMuvIGeFZp77qxxT/SXzI?=
 =?us-ascii?Q?PIJBy831z38UmkI3oExiqCHjzdHD+bQTEcUPiFIAYSBVINOaNXSmUycP+VwB?=
 =?us-ascii?Q?SW2DhxpvdKI/bOwFP4bn4691xJmSygXYwZyBvLs8kaOvbl+D23mM/6zHLP3H?=
 =?us-ascii?Q?kdOkO+AVYuBkO5Gzs5vqZBXMJRlgVfEu1xBiM+s3LJGpJ7g6j5e6qh813g9R?=
 =?us-ascii?Q?YzWQKfRsuno/zl9HBrAzllxEzoktxc2Lny/n7aIs8cAg5Bz6ySge336f3O5c?=
 =?us-ascii?Q?YZmhFTAn5p/ZnJYhOx9GYqoKzaQ0tHstg+ouW2U73Or+DkwZW7V0dBzJB2i9?=
 =?us-ascii?Q?wPrQfJolARX2WKzvycUzk098ajVeJBBYXMoG9sg77lTaMPcCbuOlYEgE4g1F?=
 =?us-ascii?Q?iffel97kps20SHlpizYM7QXovjGwW0Cm4r9A5HMI1lgV+bDq8wWGGWUFCwR9?=
 =?us-ascii?Q?RhzPKixGsqtgIKC8iegrsoNtGp3La0bGiH5OdqVtAbMpe/3xaopUuUUFjkcL?=
 =?us-ascii?Q?Q0HCZBWZ3xzcX+CgTIujkT1iGrQoJlUyhLM5cpvP4TNbl+j8L4NKJPF7oi/T?=
 =?us-ascii?Q?J4dz6aAZVUQWVUGj0rptEfS11V0pFDgXA3K+fTKol/md1fqroLXKGP9+CrEp?=
 =?us-ascii?Q?j//jF9sBbdG/1wjS5Sl3sn5S+5WZe0Vj73GEuEzt+H6Jtd/CjbZinVmF9Lft?=
 =?us-ascii?Q?zX7KMcN3GPOVuTG+sdqHr3+1lBsH8/Nurof7G0NI1wG6xKiDa7aF6wAtr96/?=
 =?us-ascii?Q?31UiMvYpbDClGtEMp8ZRfVYeweLYCUP1OEgeUDjsxQhOKdyqZqfbl0cvwDqh?=
 =?us-ascii?Q?cW+17AJjOWAptbgvV/QDKtFGOcSDTqh2hfClhsy5sXnae9EtfSS2bGTKWLe0?=
 =?us-ascii?Q?TgvAuvKtpDUmAA/dreWP1PL3lALQCQvA2QngEuLRPK9l/PfYwEgFK4m4F/b+?=
 =?us-ascii?Q?ye0JSlAoCK7jNhyUmqWgHbnEV+IMlVSAYu8ksh4NKCbz5v321IEBpFxnJzvc?=
 =?us-ascii?Q?+eL3oVAKJX6FY1aVgz8=3D?=
X-Forefront-Antispam-Report:
 CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 23:24:59.5991
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4eec842f-5c71-4938-837a-08de3dc37f5d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
 BL6PEPF00020E61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8769

Both the ARM_SMMU_DOMAIN_S1 case and the SVA case use ASID, requiring ASID
based invalidation commands to flush the TLB.

Define an ARM_SMMU_DOMAIN_SVA to make the SVA case clear to share the same
path with the ARM_SMMU_DOMAIN_S1 case, which will be a part of the routine
to build a new per-domain invalidation array.

There is no function change.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Acked-by: Balbir Singh <balbirs@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h     | 1 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c | 1 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c     | 3 +++
 3 files changed, 5 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index ae23aacc3840..5c0b38595d20 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -858,6 +858,7 @@ struct arm_smmu_master {
 enum arm_smmu_domain_stage {
 	ARM_SMMU_DOMAIN_S1 = 0,
 	ARM_SMMU_DOMAIN_S2,
+	ARM_SMMU_DOMAIN_SVA,
 };
 
 struct arm_smmu_domain {
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index 59a480974d80..6097f1f540d8 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -346,6 +346,7 @@ struct iommu_domain *arm_smmu_sva_domain_alloc(struct device *dev,
 	 * ARM_SMMU_FEAT_RANGE_INV is present
 	 */
 	smmu_domain->domain.pgsize_bitmap = PAGE_SIZE;
+	smmu_domain->stage = ARM_SMMU_DOMAIN_SVA;
 	smmu_domain->smmu = smmu;
 
 	ret = xa_alloc(&arm_smmu_asid_xa, &asid, smmu_domain,
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index d16d35c78c06..9d9f24a08062 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3065,6 +3065,9 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev,
 		arm_smmu_install_ste_for_dev(master, &target);
 		arm_smmu_clear_cd(master, IOMMU_NO_PASID);
 		break;
+	default:
+		WARN_ON(true);
+		break;
 	}
 
 	arm_smmu_attach_commit(&state);
-- 
2.43.0

