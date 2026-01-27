Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012012.outbound.protection.outlook.com [52.101.48.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CEA2328B52
	for <iommu@lists.linux.dev>; Tue, 27 Jan 2026 18:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769540132; cv=fail; b=hjPuWvFEKQOFcFFJi/uH2jln8+IX5+4CtWxGry3Hj7HzKTqEHZGDhvr52tTPdwHQzmFQhHLmZot/YfVogLSRVp94GVWUd0mqrDFISdKjT2IyqwRpxe3P5+SOzJwjM66cauvIOGSf/BOMaYEqAc1CbVb8VWO7IweRBMxrJtgciQQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769540132; c=relaxed/simple;
	bh=/Zmmdbf2RP+Mzk6BaK+3ZN9TpfLi6P6DOgpbG7bI/qE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FcYrZZayk2WIaRdl56QUjdTKBu0Xhd2YSH6XSYeAdpVoRpEc+Hi6TCiICOrbRIWDT9FYolwHcwFaufu2ozxPGNx8VgnKLFDKJ9h0tsudr+06A/9fxdXyWsrWzMtcg66Lk/psPtUDxgXUMe962cd0hCn8rAvyR2kdKBMxPDJuYZc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ir6dCIja; arc=fail smtp.client-ip=52.101.48.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ir6dCIja"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pxveWxgvlyeRiuEoI+6P/LGQudpKJ6XQZuD/S/X3D1i0iM5lZEkKHsQjyeQC7HLiF8Kc4IW9CuQ2sFx1/U93lvMe+94+eYZfDSyPNdk2bYsL5mjOrhZRIgZfT3LsatcO3lCUYu//QOPx7kqTXKNSjqINnFcVG1W7XIr+1ASVKsQlkembzmslHYILtIc5YwcLr465w+L/tLzR/iXyycfGpuaN4dwAuVI3xx4aF+o2a3Pt19g2a+xSyIpqRkTv+EVGAjmfrwH1KbHPYt/01eiPWVTKHxGHMCPsof3UWwWW49KnoElBhyRbcUKqqh++p4SKFbNS4zHIC/Nx+WcYcu/XkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gg7O4T6+DcumjFbxgHM0BeoJlMr/0VGkrnBfw7zDC9k=;
 b=hsyJWqWlETDKArPK0oo6VFaTGcKBSHjD9rwU7ercwpueyJNZ6RH/LKhcKSCU+R1ppEwCF1If1VtPhnn7ufOJ2ewbj8Mw+FrnAMSWWGsqhVlt6ftV13sFUJkb7IAAehjawB9zyv69/skOwfT2NsNXBcy0fhNqiLqnk/2/nsUSncjUNT/7EELdbGcSR8MCJ7cBi0mdB2zsZugTplYUpUE5r7kCUw3q9cQ8l1+YAbDb6+g3+fdtBHnpFK3W76mdbottfq6/csdvva/WdaqhavTJEyLR5epAXTHIxEni+gCSyNt1TzgAIUAMse/Sv6ph6HmPDmmiF9v4lXzKICXMGvJI2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gg7O4T6+DcumjFbxgHM0BeoJlMr/0VGkrnBfw7zDC9k=;
 b=Ir6dCIjatr1AoNgOiBY2U0TPYLjqZrNHkcLV9LwSwMZA5VaLWmP7HvCubjGiv/mO8GcEFcfz3BZRExunVWmpEF3wk9f4WpbYhNHw9ise5BOoh3fOupBznxRgIBlYvXgKSjkWpHwQ/FLx34SiJGzwfoQjNFfXBp3RKjNRm6DyeFT2cKkkDw7JIAtEQOwOmYq6vgNj11TBZdLeIgS8KGBfYRnfYxqWTVq9Awkl6D+0e8qL4YXBlMEAuiNJxFPaCf2WNmJyLfG5//V83nWttbYOM+rat5thTe7Nmttieke/n+9Aqau37C3/8lM+Uk3jto3G60QIzP/AuiyCxN1Z1GtSgw==
Received: from SJ0PR03CA0156.namprd03.prod.outlook.com (2603:10b6:a03:338::11)
 by DM4PR12MB7719.namprd12.prod.outlook.com (2603:10b6:8:101::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Tue, 27 Jan
 2026 18:55:24 +0000
Received: from SJ1PEPF00002320.namprd03.prod.outlook.com
 (2603:10b6:a03:338:cafe::a5) by SJ0PR03CA0156.outlook.office365.com
 (2603:10b6:a03:338::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.7 via Frontend Transport; Tue,
 27 Jan 2026 18:55:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00002320.mail.protection.outlook.com (10.167.242.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Tue, 27 Jan 2026 18:55:23 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 27 Jan
 2026 10:55:07 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 27 Jan
 2026 10:55:07 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 27 Jan 2026 10:55:06 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>
CC: <jean-philippe@linaro.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<jgg@nvidia.com>, <balbirs@nvidia.com>, <miko.lenczewski@arm.com>,
	<peterz@infradead.org>, <kevin.tian@intel.com>, <praan@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v11 2/8] iommu/arm-smmu-v3: Explicitly set smmu_domain->stage for SVA
Date: Tue, 27 Jan 2026 10:54:54 -0800
Message-ID: <444724fc12a62f3746b6ad38d04e88c2872ec9a0.1769539310.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1769539310.git.nicolinc@nvidia.com>
References: <cover.1769539310.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002320:EE_|DM4PR12MB7719:EE_
X-MS-Office365-Filtering-Correlation-Id: 62f1fcd3-4fc1-4c2c-46a8-08de5dd5a096
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9IDxedcweOKwcd6pREi2AARck5TXs2P2GLcMrSlnXSY2pGt7rh54i3DT+XSQ?=
 =?us-ascii?Q?QAoOT0pncM+B/2cbBCobkV8jkrZTA7VyrNlKY6YTrRTtLpjqN6uqwTOAFmcx?=
 =?us-ascii?Q?LSYEOHndpkfV6YuWmcmsls3UrCgKOEWgguSoVq1S4Ko046454RxlKW64EpJA?=
 =?us-ascii?Q?i/MA68/7OqWDDPSnASAx8OiLAeuAS6ywgMe+7w+LBE9hsCldkGm0iQDFHCb8?=
 =?us-ascii?Q?DYRp23VQXtb7QEKYAkqGzLwfKkxMAa3od4HGpEMcrPuAudRFl09ORiBlWDMw?=
 =?us-ascii?Q?80R57pJSryebqBpyu4s5W+rHwNxbNtuwCsF0ysNLh/wuXYwynZBOUjwqnB73?=
 =?us-ascii?Q?wwJWAv7hhBbROMzCsiukeGOOjgVTavUuZowvVkYceIMiS3XTWOycIZlTQIbq?=
 =?us-ascii?Q?cNm3d5EHXYvZqcJmQ6Qwpefs5jwXa3bDEw2/rXTKC7JmUm8JhiSy3JvZumsg?=
 =?us-ascii?Q?AVPOAFGJoQ+mDfNEh3vuaQV3A5zX7nGPyJHH7oLm2vmSn/x9+yQ6fIrxNXqi?=
 =?us-ascii?Q?XKlgLOBJHwTojnrzRj5KZh+iN8C7AQ0mRCXqdh6R98Pt6WlLJkvx7RfUzMVB?=
 =?us-ascii?Q?jsvqci3LsE4SYbm7xeZXKrQliLXVUDYAQWGh9YaCYBXUpOlWaMba5TMQhctU?=
 =?us-ascii?Q?4omX2rMkOnlSGcMC4lKJVfrOB8wAgjXXH6L2RWYan6yZT9amOIWiyFksHDzk?=
 =?us-ascii?Q?zCof+SRXYrvbPC7OFRFJkPuPUmDVyjHnZkfDVHe2HA37d182CyOBSCCqQ/uN?=
 =?us-ascii?Q?Vq3CM6GrFbjbus1UyOxInmlupPQ6HW0ViMgxxki4Ej7f4TJcyKA51h0/0qyD?=
 =?us-ascii?Q?nMKHlINBrXOB91IB+hy/xBTHSxCtxK6mAQCJ5uE32tHw4ykPqaP7FiOnK9Qw?=
 =?us-ascii?Q?ShhYRI+rIlN7G1jd7KHtj4BVE1rBhDZFDPGLQ5tpUHcMPjSBSP7/KdGesfn7?=
 =?us-ascii?Q?lSDpKByOfmG6Ka2NhVEvmuiSE9sAFwBQOQIjreqRpfj882DmHNSNKE50vQfQ?=
 =?us-ascii?Q?WXtsh3C9IFlym4wMVWwyn3r8DIfxovRBpYVELrAPROqD8tU0nQJbeNKFftwl?=
 =?us-ascii?Q?72+/eulaM1Ki+zKKJoKsW50oGPDUoVDXTWpYxYyKD7ZtpaHOSm2WDjjLwDO7?=
 =?us-ascii?Q?tGtHxYUgTmdXVx9h0p9GC2xuEzYQ+BzV4DWX6KjErBDAhkNjpLDwx4cdb9vR?=
 =?us-ascii?Q?Z6dhontwoGgivINEla16XM+MIt9gEzZpJtdCyADL6x+EXecABk1KXWBGVxc8?=
 =?us-ascii?Q?0WVHjhugZgdsXqUJrSdfAtBcNlVfnANG8QfVjfkUIZJoqy+6gap8Uf5pVOao?=
 =?us-ascii?Q?io1EAZvR4+PJtPQvJV3t8lGyfKTReRdCK4yO/YdYK3Yfg9miBMUPYM5X+1JU?=
 =?us-ascii?Q?j9XdgObNufBoBJfFjdbLtQY3DQpfBSkh4QKlyUaRmWoocy3mN0wX/gvhlPA7?=
 =?us-ascii?Q?d6fPnRuO6O03LwBNDmItUqFzCZDwreZ2yipQV61l/6ZUoNJjRvXUm4fKtJcm?=
 =?us-ascii?Q?tYUxJLO9gYbGDAwqe/A3IrP4Wqw67L1U7kWgr9eoC8PDNRJyby9lbf5304ju?=
 =?us-ascii?Q?cNfh9Oy6O3FHipEwUB+KRhdHfNQr7axnkbd3y7d1e7vhaoTfswkcFu+HOqx8?=
 =?us-ascii?Q?qBydhjIQULdck6ZuCpOu1NJaIXg9JSRAuVKZFy9Y3jq91PDDWVpVvcUNr4Cg?=
 =?us-ascii?Q?GQ3syw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 18:55:23.6487
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62f1fcd3-4fc1-4c2c-46a8-08de5dd5a096
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002320.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7719

Both the ARM_SMMU_DOMAIN_S1 case and the SVA case use ASID, requiring ASID
based invalidation commands to flush the TLB.

Define an ARM_SMMU_DOMAIN_SVA to make the SVA case clear to share the same
path with the ARM_SMMU_DOMAIN_S1 case, which will be a part of the routine
to build a new per-domain invalidation array.

There is no function change.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Acked-by: Balbir Singh <balbirs@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h     | 1 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c | 1 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c     | 3 +++
 3 files changed, 5 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 3c6d65d36164..24894b163004 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -856,6 +856,7 @@ struct arm_smmu_master {
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
index f0e3b407c293..a55f9ae95411 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3133,6 +3133,9 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev,
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

