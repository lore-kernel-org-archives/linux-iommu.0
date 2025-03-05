Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2076.outbound.protection.outlook.com [40.107.93.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4486F1C8635
	for <iommu@lists.linux.dev>; Wed,  5 Mar 2025 05:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741151132; cv=fail; b=kB7Mgqt2kTS3VW+KNXgw1G83HXHKoGNMPY2P2f+Yp2wgUMWCpDqJPGTQgSHCDGS+XzG4p7IniAA+ObNyE7HCjE5jtPJzrPF5dzo8DKD+gnJirm6GOOTvaHC/gQtl2Ku7PmTk9IYKHNc/U6qL2uj5sWcfVtGEZqYgBO8xhFujJHM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741151132; c=relaxed/simple;
	bh=So8pdj/UApTASv5Rzrau2K84dyq7MP2/3iU1dS3a4rs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jOnSgIsRM0k+lXo2mNaEp2MXOIjUoX5N377+CeN4XzyP4N3vNk00t6LlNkJA94PiFeMdP8i6TSEJgP3Uj/aTkK8t4yaoIBHz1Jld/jkoNLtAn+MRx783FIMSqkIfSe0GH/G5SUbERu/Wm0QkRbhI3WVNGk/9olGrzgb/nLwn4QI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=R5PODvIb; arc=fail smtp.client-ip=40.107.93.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="R5PODvIb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AmFoz1WUViECgwwcYdAyLFimPggmfkASWq0i9CRoIkHL5KCeVUmUphVUG0ZtWQ+M2eQSuAgqq5XbWSftsQQwyoN3Jq9jbblMzzZs1E1jlewYkoJroMsTj0WcZsaqQIWRW0KfIqvG9oJjdsaRT+MpdRU8DRDS9gKSeohmunbhZIKhyWDepml8SuiHwwaaCzlG9itXQ7LyBz7lQ8pydzlJmKRBGewLhv/zjHwYOulh5U5G7TyK2yqIiOaz5JwAbEIFwrqQE/nkj2cUMUN7MDB8QDlBRyhGezQKvRtV81aSOpMD4XOGV8k+49N/3Bfm+Wl1OgkG6CgeNE+Ac8q/WETtow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ciy15pXvvqFuxkL5oWMTeHZZtT/G2p38jUfBO+rRozM=;
 b=ROp83yQ2cy9MhSEKGcycHAnV8M8qRCWWJR+Ym6Sb5e/e7dkS3ooWhc0J0oZe0F/grKF0PpI0l5iKARbORQnb/LkY8FSz1Nq5ufAncIKxwghLglsibetHYJrtv3ejOG5MRq2R1jGXlLS3wWZWxWyaeAbL8k2m0gNKsDTjm75JlFQo9WsKuueQ26ptqw1zuLr2CQzifithFmmi/+umnQCaH/Hlnpnnel8msouCncMfUlPEUd65EXQDk3cvZtulPfDb5HIzuDfMtaNvh3lJKcqc1Re71Mezw+A16CEHpXiUt0XU7V9CKgCpsDhpymlHFWK/oQP2NUfu5JfBd6hd0FPYzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ciy15pXvvqFuxkL5oWMTeHZZtT/G2p38jUfBO+rRozM=;
 b=R5PODvIbwBNRwm46hpnYrcMK58fgo3U6bZ1ysgz8ZRIgaxs8NE62KtRQ2431+ODGxVMaDOGsOvJA6QtzpKS4x2NriRs9B8KIfftTtiRpjRDT0/TL3abpttySzDjvP0sAw6MfkCTUnOui5xNAkeMu78b/qObk6gsm8DvjDB4shJElk5VyvSBzy4Zs9HO0DgJ3vavkSouh3Ft3rY7FMk+ml+jzhnKpiq3dC59Oj9V7zacjw0rvqXWQThprgni8NwrGl2QqBuWz/OjtSz0yFONiVMTB7tjXxhuupRitppupQHjuTA3lBxwWlELsmk9xDEWA6u9jHxpOhdMeKYZKooDcKg==
Received: from CH0PR03CA0052.namprd03.prod.outlook.com (2603:10b6:610:b3::27)
 by DS0PR12MB8070.namprd12.prod.outlook.com (2603:10b6:8:dc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Wed, 5 Mar
 2025 05:05:25 +0000
Received: from CH2PEPF00000147.namprd02.prod.outlook.com
 (2603:10b6:610:b3:cafe::1) by CH0PR03CA0052.outlook.office365.com
 (2603:10b6:610:b3::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.16 via Frontend Transport; Wed,
 5 Mar 2025 05:05:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF00000147.mail.protection.outlook.com (10.167.244.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.15 via Frontend Transport; Wed, 5 Mar 2025 05:05:25 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 4 Mar 2025
 21:05:10 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 4 Mar
 2025 21:05:09 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Tue, 4 Mar 2025 21:05:09 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>
CC: <joro@8bytes.org>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<shameerali.kolothum.thodi@huawei.com>
Subject: [PATCH v1 2/4] iommu/arm-smmu-v3: Share arm_smmu_cmdq_issue_cmd_with_sync() with vsmmu
Date: Tue, 4 Mar 2025 21:04:01 -0800
Message-ID: <e9e8df0b9dadfb8c716b8b9072657327ab14898c.1741150594.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1741150594.git.nicolinc@nvidia.com>
References: <cover.1741150594.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000147:EE_|DS0PR12MB8070:EE_
X-MS-Office365-Filtering-Correlation-Id: cd5177a2-7231-420f-1514-08dd5ba35728
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xMWblpBRSYQeNgc2Zi+pmJ2YgY1ywsVQWi5nqBr/CCbfZqDCUkSc5S48GA3H?=
 =?us-ascii?Q?uo9aI1Bm7lf4PD/O0nSFAvoYwJq+DmRIeTI35F/X6mrZacoRhYw3AHHxLpK4?=
 =?us-ascii?Q?MdRbaU314mxUMstMzZEBv9Uh4jKXGHrWpoi4XDHOkWvMNBwc2qvZkbT0ERNH?=
 =?us-ascii?Q?3MOSEB3HpTHw0BA+y4Wg2sZRbBKIngGEyOgBdmEm7vroUjXDyt/MqbaIT9JA?=
 =?us-ascii?Q?c1RNibPKJcKf7/REPfXohJACfGQJ59Eb31jbd7cwQDLqYm8BZKWzFHb7yqS3?=
 =?us-ascii?Q?JUjHfQ5nSH1OAl+Dr27hWcvnmg+OGb5hoZRBD/PQ8AIvlcqNf8mXHsFjv8SX?=
 =?us-ascii?Q?yfC4h4gXwvUYURsDoYXfI+Esxlb62yR55xujRF/neiU3YWw6LrHb3RKWYYIZ?=
 =?us-ascii?Q?XTC6rksVZWsqPSi3CJFqMoyCWaJQyE/gH/R8bjzByZomqmQ3RxT1lVO0PVy0?=
 =?us-ascii?Q?XbFqq6qQXL/Kd6XEGi1ovnjmWX5HUCncmGlqATah47ssU5/lRPljePyG3GLU?=
 =?us-ascii?Q?xvXfrG1eXcd1/D0qVb35RV+CFjofLUEiNYCNxLC0IzCsZl4+xK3JzhSeT2vZ?=
 =?us-ascii?Q?Aw3vd2lTOQndIRDwqrJbSDctprWSVQZapT4MmyZHuGzn9lRyaaAJJ9AuNkeP?=
 =?us-ascii?Q?ufaUFv3pcq43ppdgl+IpyYkgzoXN9P5wCafgHdSrLIDX/jJ5HUnliQ4pZ+nX?=
 =?us-ascii?Q?RJTxyW2sxGwtKyA2O/hOE3tsehgLHh8T0sMIAENhX0wccx//9vqJpkGW2gPq?=
 =?us-ascii?Q?PTuK1JtYViGkLTgAgrelRyTmsEnZwZxafdURgVQqLmokWbJlP+lz1zVvnb53?=
 =?us-ascii?Q?tYx9i8Czo3NILEVAzIEX4O+32BD/Pt+c2swsMKhkD9FB5AFB79R1rh6hP8AG?=
 =?us-ascii?Q?zCWmT+svwCpX2HNaYzZD7T2rELeKerkIG4sIL9o03trqmOJaWqtdgsKsJF7v?=
 =?us-ascii?Q?52D49gFcG+ZWFyBPX5xObSRRza5a0qL4FrCWWp5/NevVxnWzHYc1cVzpaUZG?=
 =?us-ascii?Q?OG6Lp+oO5K8DzJgFv4KLMYLnnQh9yYsOhoSWwnf5q2kvjpN3c5LMOwjN8j0K?=
 =?us-ascii?Q?llyLU3OJXaxtDyk74UnyCRxvKC36ChhYF7E1VlhaJK+eijhbXH/LwVXi7gOX?=
 =?us-ascii?Q?sRidlYf4ou47ltI83Nqu7UFuZgsipMO2aBgHzfeaz5CoXcif23QixgML520s?=
 =?us-ascii?Q?O9/LbkInKER3bKiFXb+7gNpXYxEy5yHN69HK8zt3VCh+ii8u+iZhth9ilkOp?=
 =?us-ascii?Q?ua4j+EEPecgBvy+OzHFGNGK+b7UPEFt9ODIR1LACxVg3y6404O7NnjAUzjiu?=
 =?us-ascii?Q?wxAcdbjGgChYZySLDPsFuk+5xBMq5HGPoa6CekkfnnNwZz33y5HmLYZH997r?=
 =?us-ascii?Q?BRv8XQKxA7QLUQUnULp8vCw5s4gNWS3HG9x786n/Mjo1BityXT0fq4dlfmMu?=
 =?us-ascii?Q?fadWUEOTu7s+jw8hA3OQyw0qz5gCc978LtxYQt7WQxr21XSAb0MbjFIyDXcn?=
 =?us-ascii?Q?uAZ0+HUmOKvMQUc=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 05:05:25.4957
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd5177a2-7231-420f-1514-08dd5ba35728
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000147.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8070

Allow arm-smmu-v3-iommufd to call it for S2 cache invalidations.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h | 2 ++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index e08c4ede4b2d..3336d196062c 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -984,6 +984,8 @@ void arm_smmu_install_ste_for_dev(struct arm_smmu_master *master,
 int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
 				struct arm_smmu_cmdq *cmdq, u64 *cmds, int n,
 				bool sync);
+int arm_smmu_cmdq_issue_cmd_with_sync(struct arm_smmu_device *smmu,
+				      struct arm_smmu_cmdq_ent *ent);
 
 #ifdef CONFIG_ARM_SMMU_V3_SVA
 bool arm_smmu_sva_supported(struct arm_smmu_device *smmu);
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 310bb4109ec9..0462eb1b2912 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -929,8 +929,8 @@ static int arm_smmu_cmdq_issue_cmd(struct arm_smmu_device *smmu,
 	return __arm_smmu_cmdq_issue_cmd(smmu, ent, false);
 }
 
-static int arm_smmu_cmdq_issue_cmd_with_sync(struct arm_smmu_device *smmu,
-					     struct arm_smmu_cmdq_ent *ent)
+int arm_smmu_cmdq_issue_cmd_with_sync(struct arm_smmu_device *smmu,
+				      struct arm_smmu_cmdq_ent *ent)
 {
 	return __arm_smmu_cmdq_issue_cmd(smmu, ent, true);
 }
-- 
2.43.0

