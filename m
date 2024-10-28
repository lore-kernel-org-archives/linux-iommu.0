Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D9B1925A3
	for <iommu@lists.linux.dev>; Mon, 28 Oct 2024 09:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730108404; cv=fail; b=TaixVjfW2Alq3nLup44shpfV77JdDM1k9cX8m4BfOFjxbUfZJp29O4fqlvErDI6rQvJ8rIoLn0/giV+SjMzbAjHFlhX4ZRHXd/TXqA064rxW8TejtbPaID7BaurFEaNn7YQizoAY0wntjOQd2VVgxYPwzOsLA467s8EhfM5hcII=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730108404; c=relaxed/simple;
	bh=PNRV4etEdqMJL+VG33b3hgOZcXW+RATUFopbMA5bUWM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CdmexT3zsXXWMMKJD3LY03OA+i4/YdzcPqtwjgCAWVSAQ4aMftqh4X+KJfI8VKTvS1asAmGi84CWliA6lI91AUfPA4EiIssXItxaaui1tTChQI8PhuDlm7ZF81DIJOWdLw0AoVVZG2xnglHuCezKinWAZx7LpakYEhycdeu6S3k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cJrZN/eu; arc=fail smtp.client-ip=40.107.220.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cJrZN/eu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SEzH8vtgYX8daDcHW22j84z/bZnVRyZMWI5UTxrovMnHYuiEi3cqA/NdZQMGjLkNb/BbYe5rctrgJWehWJrJaSsMfjMrzXsoPJndWyfTcagbijwePIs0nLJ5anyybPJupyK96yrpfE9FrkTjooAm0zcPTEjJcwfGDireOkST1+BhBs04KfhDQlrkg31Nbtk9veYcwtvnCX46lbVpzImv8y56HzBBJWrJulYQM5JO8HECh6cd2DbEC7wWjoccWm8G14HFAmD+hEqE0w2tvZaTnJ7B9hc+d54eokJoqPoLIqERkeRNik3Zj4VEOYVbnG3BHGrJQ9Q4U7Xzz+0KvypE/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3J6Tqpsa5inp/IrYRolum1xlw+Rglg4XS315BosJIH0=;
 b=LHgafx76OaUcoYvukOBvvwkJopAIAam5J3SOUhiIlvTjSB0ichAdFFaDsTPB7O1GeROJAnQ8S/VWsKoyfJoPWUOI7wvCKy70vxqQNg+mN5l8iMftELMDhEACSMXxmYxjVq91veCXz/QaTCGi8Iy0S6Ff44H/6EPOZXfLmT504MmIN6JiRAdjXQokaFIroqei1f4hLZzjjq5aaTYPb48mlAAWUKzq4f86LlKX7OtG/HDEJFTCQOa1p9Wkqr9RWYk1AtyjpDAI/HPMmko0hdrbvwIEv/0u4z3Nk5EhP6NvfsbU88WUKDdqGg5ehwelVGVB7oQckhspjTdY5/Od2BeEsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3J6Tqpsa5inp/IrYRolum1xlw+Rglg4XS315BosJIH0=;
 b=cJrZN/eul6rKQSfK2zBlz6vHpbDNA8OrPz7mzl92o0Siu2rqdL36Tc0s6Z1hc/hRmmthNNzgsDx86UV1NlytvkEY60qMDTTCil8ARfSpZ1bIqKmu2B6FRe0ch26jDshKgXD0vvuFdKt+q2tNz9GUoEGAnnb+oc6UXtgCl98h7eY=
Received: from SJ0PR03CA0368.namprd03.prod.outlook.com (2603:10b6:a03:3a1::13)
 by PH7PR12MB6907.namprd12.prod.outlook.com (2603:10b6:510:1b9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Mon, 28 Oct
 2024 09:39:59 +0000
Received: from SJ1PEPF00002318.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::34) by SJ0PR03CA0368.outlook.office365.com
 (2603:10b6:a03:3a1::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21 via Frontend
 Transport; Mon, 28 Oct 2024 09:39:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002318.mail.protection.outlook.com (10.167.242.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Mon, 28 Oct 2024 09:39:59 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Oct
 2024 04:39:55 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, <jgg@ziepe.ca>, <yi.l.liu@intel.com>,
	<baolu.lu@linux.intel.com>, <kevin.tian@intel.com>,
	<jacob.pan@linux.microsoft.com>, Vasant Hegde <vasant.hegde@amd.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>
Subject: [PATCH v5 05/12] iommu/amd: Add helper function to check GIOSUP/GTSUP
Date: Mon, 28 Oct 2024 09:38:03 +0000
Message-ID: <20241028093810.5901-6-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002318:EE_|PH7PR12MB6907:EE_
X-MS-Office365-Filtering-Correlation-Id: e1ed6788-696f-482c-bf2d-08dcf7347d56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dZdYeU/dJD3+GlIbTbp13fIhnE6Ki+xrajvfjkry40D8+Tbj6BiPx1hCifnu?=
 =?us-ascii?Q?KieCH+sXCi6HbbKBYN7pE+5jU1ssav0whrOvUMBb2BBYgNsD6+Is+617I/7Y?=
 =?us-ascii?Q?8bc2eyculUiwsuSmbqcHLqqzmRdHqEaynTRLFNfEWXLoLZ9/t+JGhPyVXdxk?=
 =?us-ascii?Q?JUTk5LF/Jv6soBfdQ8o0dR8FkzJ1g/axbu87Gix1mQP76HodpCZnnt+/R7tF?=
 =?us-ascii?Q?I7zGDO0VgtFSEutbO11OMwd/PjBC95OXuEGR2tS6EmKvvbK/e/3eTxfw2hNS?=
 =?us-ascii?Q?vDCJKl7L46xV8Yssg2tTa4g4OZJWLF/KrmO/tA0h7Dq2nAjYr3sIegpDAAsf?=
 =?us-ascii?Q?vEHkI8kUN65SUe436BVs+rvjPUvmMwRONbt0IANcIpJJVHc698isowc1qBHF?=
 =?us-ascii?Q?oNBkf81h4Oc360+LWqv1zZgDrVOQJ6VoJO5Psig0eZGEHE2rQfW8Q7V61dhw?=
 =?us-ascii?Q?WPqsq3PGTYDgHoNEmqp4d31c2+3gmUfgAWH+bimzDP/pkeKhON7KvADufgSg?=
 =?us-ascii?Q?qvRS0KvPVpCFUkCFgl53r94wKCIxtK5fkXsmblF+r+QxfReINYfX9dzelvyf?=
 =?us-ascii?Q?+2ar2hgfJvcsqhAKAdb/DH8IsF7qJ5zRRkIOsAm+YaODdgwgEtdUoBOTPkLo?=
 =?us-ascii?Q?JZD0D08dCTunLipf0uyEqE4EutPUVJ6yD7t3OPHyGMBfWB8b76TOrP7IsD0J?=
 =?us-ascii?Q?9Yuz7WDph9etQQ6A0B+n/WxUo71qU9QNal4caXPtMEMHNFBQi+80R8nLgZ+k?=
 =?us-ascii?Q?xAd9K3KpxKWwCxIa8JaiFj0DalnHwPO4AEd/tVLs7jpbkbGZr12aJaf/wPeQ?=
 =?us-ascii?Q?zTiaYpQ1cRTB6lu1zj/1z4l/83/E6FtzCzqf6XUul3nS7fDSj6fd83H0ecog?=
 =?us-ascii?Q?rdilKX/TH37I1WxW+qX6QsZBlCPpytp/M8lZRM++7CwURjzeb2lilKWhDYaR?=
 =?us-ascii?Q?VBkdqO85IZCx0W2R4r9mIimgrzBbY10YMn5mstOCrtYinha7kEXcsk1q93vO?=
 =?us-ascii?Q?QjekhbKeWwY67sL8imn0AkVB/PU+TNf/UPu0yw1pIuAYVBWQ+Y+lpFa1OZHv?=
 =?us-ascii?Q?gs1elX1LOe+jvstcl96klez7Fa7ZiXRnzBxEEdbgPu4OuYvQfOIlPv2v7m/x?=
 =?us-ascii?Q?2VJn3n9ZLfAqaupNgtLvTYyN4M+f2dNLbaj8aWj1sUi/5zxsqv6eLwmkO6JW?=
 =?us-ascii?Q?AZq/L6/pMl9bnHcDgC5G1QBdfT8M6ndFiVvU2ijP+Z+jbey/PzEmjK0G1mMd?=
 =?us-ascii?Q?7k3kZKLqOH823iaPamUMlQQrHtbZ8CablSgS6FONOFHIbcf/Xyrl1CnmqaAn?=
 =?us-ascii?Q?0dq7UhWmHUXz3CSrB5oB7uZ8ZyIwBGnlT+OhMhvK6EmGib/Lsbac+phMF2hg?=
 =?us-ascii?Q?1KSCSoHJYPwG1LtTot/VtFSv4ZKZrMTJfbzSnO3NQa2M6ttZ1w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 09:39:59.1402
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1ed6788-696f-482c-bf2d-08dcf7347d56
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002318.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6907

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

