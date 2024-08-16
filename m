Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2056.outbound.protection.outlook.com [40.107.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A347829C
	for <iommu@lists.linux.dev>; Fri, 16 Aug 2024 00:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723769773; cv=fail; b=WHg3YHpBu5f6A5N+RtBGoaguo7vz+CkuTKZBUWJ2/VkT7mSKRzHAcLvZnWpsIF5LN5MLS/8C3XMurB2hrToxtfVaFOy2gB9iHLge+wmCFVugo3W8r7lg963VeSTU27Pk+tPt/mb2jxZnkaavQetsgl805WO5V1RKBsQZzgqy7oY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723769773; c=relaxed/simple;
	bh=cL0SuVXskFMGGuDWk/bBaA96Z934vEyQqyxWMzuV83Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dvlE82j10r2yUth7KzeUk7YuruLXuArZuOj8PmlT7HrzNd7MXEYlgUHb3wO6b7HU4m5avAj9FRp1JkFHF/4+0CX85BQRV6u2Emf443YV4ABwnm3DHUVvyKpoxbKioK2T9E1WiyVIMj/09PWBR3o7jKxC29RTwnc8oAFuI+EzhRU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=i1NuNJGf; arc=fail smtp.client-ip=40.107.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="i1NuNJGf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IeRX9uBL9Fh7EQTpEF5zSiDb1qDJ2WoDlJBd+k/RI8SkiwLoXuHH0AOj8XLbn7rRYCnzjRcaiiAiE7bGbo3c9lv7CwdZulX5scB19d5fzQrzH/CL6povLh7q3tV1PhWhXhBXse2SKgk8iA4Oo98cm/OrccD4Dd1iGrdQd5HTpc/2xrWM6kPEHtKzRYPWLmfepVmHvv8fHmoAcdv0Ac6k6PZ8hiHZX9FGO8yaWfdJuMw4b5l04bWB4Yj59Wc/bkskba12G9CQP58V5+mjStH+LCjQ6lOGoLhi+H5YQhpvm98avOgZUKZ9UqO/xJ/WJvwRlsoGf5upOTB6cl0GJX7Htg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rRBHgCa2fI5PFHtlQ1sEeaKdbsvPnZTX0ZyiiWHSRKk=;
 b=Le0Am1flP2PXhySaBsq6BAWecqYWfMSUQQCFI6BRUNIbIFVNYY7wLhbOcnD0uORZ7VQmUz1BkfucpzzMLb0uh1Zd+e5aQ/ckm0aAjTVRHpmXCSLhv28e4oh/02+lZrAI5FzNZdC1Qdq1DQ8yVFs/dzSKKYQgCaZ0jcOI6QT/zB15kmbAc1u3+WksQ5KxQZ54p/BYe5+VD5Z9MPwBIdYmlgwzEUUH5jOw/p+c1GJqw5Xjw4KAAlOhUNdXUf90SsxU8HS/bAcLR94ZomFFpVvG+GdYta8boce8kkNfG20jbTpXIpuxWnfNOU5jO6dvThjfurguRuP/Z09ZJE9KaAI9CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rRBHgCa2fI5PFHtlQ1sEeaKdbsvPnZTX0ZyiiWHSRKk=;
 b=i1NuNJGfz0AO1adPegq5l0ATdneOZNHpfPlzI6MDT3HdsN7i0PkOjdCgWb7x1+d/2AJTSCTYvNNcwJG1e0IJE5fH2bWR6ker7KrxB0KrzZO3SO6XH0Hl2cigi3I8ErMEm/+Dv6nzK6M6CUdz90zU2tDRnoi2TBa2TNupj0T3HgFUQvEVu+yI/Bqfe7yiC8Qn6RONOQSEEnP9iiQFHuv4/5InUB4E7WAAHiHSOE60F8O/lJQHdG7XeNh+y0tjAj4Mi/WB1zUpFIn9Xiim0L6BsM7mLQe+bACxxB6RLK4ru5HO1xfTh6U/NeGlUOnSYx4f65tHe2GzLBw11grzcR2HTg==
Received: from BN9PR03CA0570.namprd03.prod.outlook.com (2603:10b6:408:138::35)
 by IA1PR12MB8358.namprd12.prod.outlook.com (2603:10b6:208:3fa::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.17; Fri, 16 Aug
 2024 00:56:06 +0000
Received: from BL6PEPF00020E63.namprd04.prod.outlook.com
 (2603:10b6:408:138:cafe::e8) by BN9PR03CA0570.outlook.office365.com
 (2603:10b6:408:138::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.33 via Frontend
 Transport; Fri, 16 Aug 2024 00:56:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF00020E63.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Fri, 16 Aug 2024 00:56:06 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 15 Aug
 2024 17:55:45 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 15 Aug
 2024 17:55:45 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 15 Aug 2024 17:55:44 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <jgg@nvidia.com>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>
Subject: [PATCH v12 07/10] iommu/arm-smmu-v3: Add an arm_smmu_get_iort_node helper
Date: Thu, 15 Aug 2024 17:55:28 -0700
Message-ID: <dd197b5c9244d66c5fc56431763054b3502ee1c0.1723754745.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1723754745.git.nicolinc@nvidia.com>
References: <cover.1723754745.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E63:EE_|IA1PR12MB8358:EE_
X-MS-Office365-Filtering-Correlation-Id: bb81efb7-1726-4dbd-29ea-08dcbd8e35bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7JWzTaAkRbM6HAt6XR+Ec7t6bLyFRGTsZp/kmPGz6Bnx9jZRd/8kg2sKZCQ/?=
 =?us-ascii?Q?DuT7beb12nMBvERT/KQYVQwgLpMLJJqsmkL11XodLmzzx+SY4Q6maV3e5SrZ?=
 =?us-ascii?Q?7X2L5PXsijRrsdCaq5DteisY85xLbzXTRAJ54yqMEWeNuQhreXg2Qc257PVr?=
 =?us-ascii?Q?NUDtMQ3f/fPGgQa5Hkgj5nPdPI+sLQzGS444G8vmGTl/q6NoaNEmQBxL2gN5?=
 =?us-ascii?Q?itrFTmZ6AMsUlISWMwIC/dQ18Q2l1epEStpvX333kVQ8Ak8crlYnAYMvF8ZG?=
 =?us-ascii?Q?bk3qsZdnnQ/1zR2TV72+yurKNidbW23g09luPDRPQiNm7GimRwbGFjl01Xf/?=
 =?us-ascii?Q?x6IRTZSzg/fyI1cuc/nh1KJq0r1mblzlFZbNvBBiIVxxSdVh6Bqn6sQvpSyg?=
 =?us-ascii?Q?NO/dyRSek92OaNz0lcCKuinodx1kU/i4wVhnuURoPzBPLJyKC+SsqYxKKpH7?=
 =?us-ascii?Q?y7FtU594YyFh4u3AYKbrag4Vpj7SDp6m1M/3Jnw5i/xUZ5TNwQNO9G1ZRpxZ?=
 =?us-ascii?Q?eUxB4GAuTjdW2n/fQuix+ktzYTw0ahs8/X24g1vuahboJZ6HQXx6N8q+CroY?=
 =?us-ascii?Q?d1Op2QENJ75z2oIak57sUJLm0tkETQr0Pjwwd25Y27O1ubCIQV6FhetvosOW?=
 =?us-ascii?Q?pUvHPOQnF/RkNJ4ev/ac3Yq+9E0bh/yWKEaoWIKcLlbjEOK7rK5B8DWLLPBX?=
 =?us-ascii?Q?9/RdHHoT0FfERBsqpGgsJ8lb5dp3XjzjhzdvPuGZcXqsaUsWaRakqvbHeFk0?=
 =?us-ascii?Q?leg58NpK4Udx6E/byIJIhBEudbdNQ1/tGGkfAWDro0bCVMmtqbb9ghCQiyLs?=
 =?us-ascii?Q?AmsAm4D6/24OONsPUXmJfjWRnPOHLNOKqmRslzrWl+w5zbuN0/ZJrRI9inE9?=
 =?us-ascii?Q?bjnsju8RuJmRurAqfArfRHOZpIysWg0syBn/OFWee9QITDhljQahsQ0rRK4e?=
 =?us-ascii?Q?Ax3j3K3/dhM8k3aANLCEl5WB1OVTR8aTGYQWyudgYeUBOrnpa0yNphgCoNFA?=
 =?us-ascii?Q?LhMpePzT6kuK6uYaz4K1bM9k1KOfO/VaaOTlawoidXx9Go+thmR6Je6nBX3L?=
 =?us-ascii?Q?EQ/3//+CT5npEkXixB1m/86oz02ZTB9Tpq02vRkVRPo0NSwqU5KraAWP5UXI?=
 =?us-ascii?Q?eM5KVEpQSURko5IkQ0SEnVBrbFza5ve6V201Hyh8KMvG4QPdLiwtJB3h0CGd?=
 =?us-ascii?Q?iqN9MPJthrWejC2xubtfBIZP8eKzGST7MlmkdlQeZoEy2ZMaiHjO8EKBQROi?=
 =?us-ascii?Q?j0WCFYiDmNjwBn5N1kbSK9nPkfrHD9sHWRP21nh/cBZbc5CqZhNXZ1kaQw2Q?=
 =?us-ascii?Q?ansdYqzKSS8vWy/OP+FNRskCOEHdDrjkOIr6Ex+Bx6ziVA22z7OiLyxbN628?=
 =?us-ascii?Q?awDG3gTWqAn6pilHzkaWfqcPZiWQU5FtX5jHiOPfbqo6hAQzw/Q+NnPUxG34?=
 =?us-ascii?Q?zahG4xO9jR0Yc7D8NU9XezxdWv5z0KP9?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 00:56:06.2044
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb81efb7-1726-4dbd-29ea-08dcbd8e35bb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8358

From: Jason Gunthorpe <jgg@nvidia.com>

This will be later used by Tegra241 CMDQV driver too.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 5 +----
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h | 8 ++++++++
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index e764236a9216..6df3cb0bc406 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -4350,11 +4350,8 @@ static void acpi_smmu_get_options(u32 model, struct arm_smmu_device *smmu)
 static int arm_smmu_device_acpi_probe(struct platform_device *pdev,
 				      struct arm_smmu_device *smmu)
 {
+	struct acpi_iort_node *node = arm_smmu_get_iort_node(smmu);
 	struct acpi_iort_smmu_v3 *iort_smmu;
-	struct device *dev = smmu->dev;
-	struct acpi_iort_node *node;
-
-	node = *(struct acpi_iort_node **)dev_get_platdata(dev);
 
 	/* Retrieve SMMUv3 specific data */
 	iort_smmu = (struct acpi_iort_smmu_v3 *)node->node_data;
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 71818f586036..9f5d156b73af 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -14,6 +14,8 @@
 #include <linux/mmzone.h>
 #include <linux/sizes.h>
 
+struct acpi_iort_node;
+
 /* MMIO registers */
 #define ARM_SMMU_IDR0			0x0
 #define IDR0_ST_LVL			GENMASK(28, 27)
@@ -791,6 +793,12 @@ static inline struct arm_smmu_domain *to_smmu_domain(struct iommu_domain *dom)
 extern struct xarray arm_smmu_asid_xa;
 extern struct mutex arm_smmu_asid_lock;
 
+static inline struct acpi_iort_node *
+arm_smmu_get_iort_node(struct arm_smmu_device *smmu)
+{
+	return *(struct acpi_iort_node **)dev_get_platdata(smmu->dev);
+}
+
 struct arm_smmu_domain *arm_smmu_domain_alloc(void);
 
 void arm_smmu_clear_cd(struct arm_smmu_master *master, ioasid_t ssid);
-- 
2.43.0

