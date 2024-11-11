Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9CB6EEA6
	for <iommu@lists.linux.dev>; Mon, 11 Nov 2024 03:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731294169; cv=fail; b=VdAMwVOpPONFJmUcfcx0bv49pG0rh6n/ODH+QPTWTFRzS5OjapzjPduxKULNfQQEguyZ1UkoxelDYfuZZ6kUFnRiJd7/1IlDMLb7aN0lkZJiku60HV12ofqoPUmL6OwD+SW31s4cNEHPPA6ZnWtR0F8nBRU1bSI0ByHx2gcIAvU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731294169; c=relaxed/simple;
	bh=tYCMAIbYJTrhT6y8uX5khL7Mb61AuSx27X7nbtdazz8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DtS6DEXvlpGndx8i5aLlAh9h+LKnWcW9Z8wfimsisAM5izkIB4IB3nk/A9lfMR0apXlmgAq0co/CrQtg4+yKJzU743jxoa7ogOqFfoIvO7srrlyitONF+LqySvqKEuq9bHQunIe9aVsepT4GU9m18+AKAlcgIrLIbIuUlx+JS1M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=F7KeE+yp; arc=fail smtp.client-ip=40.107.92.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="F7KeE+yp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u6OY4vtRWgUsIp9EdfDJStVubcOTkx6odHFQmt90BqG2nXwIs1VZLyyb2zSMYmoPnJv1eYJSKv8mDRciCrRGtay1EIGI9ducQxoPuqhXWw7+mP1ZJBt3Q3mCGoXQqLsZnvil206xN+2fZxSPkBawqj0z7a9mQ/8xqBrB1Y4uWfOsuHVvmCmNqnqaxksDSfXOr4p4mN8mG2jl6Vkk0aQ3GoF4PZP6qEqlwrknYq6Wd+dcvfgDoslA3WGUIpQcjhHpEuDPV4mEV4FBp76TLIN7MYI0aFs5yFp59blaUvIt4/3V1Fju/VrdlWny2QNFfEmHhcoz0Wipn3pvtvrphL7xig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i8DOhwqBztXboW+g1QyWt7kPa0gz4ruzRUPi2ClTzvc=;
 b=mSSY4eC/CP+DtSSSX0svX7z5nGfU2S7/6/WMGrSSyYIaNOkNE3HZwdAZE79LsQJpBWh7Nv527lm5ZNjuasNrHFeKxwGTKSISyjxVWl8DH9IkgNJIkxvzK5J0giMmNuTMYHgn/BY6ePY4msIuOaScYxM/mwKs8o4gzN1IPooYuKi9NnViCp8xcx7Ra46VdqBm9/Ov5xhBl6pmgSvrYA8GwSG7gwyei7EzHW1WEgRqvS+KyIr2bLPJI0i1P15gInf+zkP49E9Cv6se6v1nVFfgDaAd5Tfxk79WHueR/X3pAA6JV4ePWWDRpYIodBzOAJIJzFxZWEsuxoUEcFPa6Slj/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i8DOhwqBztXboW+g1QyWt7kPa0gz4ruzRUPi2ClTzvc=;
 b=F7KeE+ypK5NV9UJp6fVZgVYIh/Po3lDlaYrwIgnjh8GO8+HoJWHaTtdjFYsESxAczZGTZ6wZyy8gPzWkDCOVjGtwT0oW8U7gpgF6Eq7i7oBnOgzWzXeVb+QCY5MnsNatUwaLxU3FmZhVs3Bu0d2ptQ/KK7uJR4qwy6kFTpUR8+hB5ApMBkhJrRUjlH4wXYMcKiMaaL/nfmrmrXhtFi/ppQ6tX0d7z9Cdw3cpWS6l4wDd9uFf8x0c47o1GrRhznITEtMwNphk1RM5ucBxSzRE6t62ks91rOIJ5LXQp01S+5jsO2adTTU3O0M0c2dvq44mLGVFp/J892rGwh3/TmWpVA==
Received: from MW4PR04CA0037.namprd04.prod.outlook.com (2603:10b6:303:6a::12)
 by PH7PR12MB8177.namprd12.prod.outlook.com (2603:10b6:510:2b4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.27; Mon, 11 Nov
 2024 03:02:44 +0000
Received: from CO1PEPF000075F2.namprd03.prod.outlook.com
 (2603:10b6:303:6a:cafe::59) by MW4PR04CA0037.outlook.office365.com
 (2603:10b6:303:6a::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.27 via Frontend
 Transport; Mon, 11 Nov 2024 03:02:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1PEPF000075F2.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.14 via Frontend Transport; Mon, 11 Nov 2024 03:02:43 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 10 Nov
 2024 19:02:34 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sun, 10 Nov 2024 19:02:34 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sun, 10 Nov 2024 19:02:33 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <jgg@nvidia.com>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>
Subject: [PATCH rc] iommu/tegra241-cmdqv: Fix alignment failure at max_n_shift
Date: Sun, 10 Nov 2024 19:02:26 -0800
Message-ID: <20241111030226.1940737-1-nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F2:EE_|PH7PR12MB8177:EE_
X-MS-Office365-Filtering-Correlation-Id: 675f1376-f1da-4a35-0663-08dd01fd5009
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OqQ8kc6uUE6Sc4J4O2reNRNZC6woZZN/6EXOl4MU/UOKysngErcxk+ahhrC2?=
 =?us-ascii?Q?8IjqElC12FsnGn4IM2svSqWN1uybA/eTlGB7jwyR4ECzCPgPncATOHPBuI6w?=
 =?us-ascii?Q?S4xf1aCFDwFkJSFv9F+okob+NRCBpplq0kxVcRRXMK9hRkyhCzb+9OP74J+O?=
 =?us-ascii?Q?wtEnQRW2gunOc4LoJRyQ8nQRbGcWfza1xMS94KfCiqMDu8tUPFTQ1XJQxGk7?=
 =?us-ascii?Q?YzTeRPBFSgHbJUIiaVx7+nSYwPA8Jnxinp7UWP4K37EwIOzfH8IqFtmAMp8d?=
 =?us-ascii?Q?TYYGPd81r/ZTxKxZLjEmonOVgCC6Y3/2stZ4rbeUfBYJUdUZ8OgpzSEUBDYZ?=
 =?us-ascii?Q?WuKEJscOmCX3Bw/6cZoWD//G014P3n0VuaJSthVtdnuNQtghYF+oll4D/J7K?=
 =?us-ascii?Q?h2gbQ7uz8+JBjEqV+mbBYetxUcYGF7CWZ6XeL2v/urSkQWPNSnKgfwPUT9Gy?=
 =?us-ascii?Q?VTQzJoe8Zcml0njNowOzGb9OL6lOmtfn0qyWwFI41yeki6YbNdDLhBSmoMzR?=
 =?us-ascii?Q?WUDhi70KE5O0Qc21I24Jz5T1htA4AItXB7/hnWxiXtAyhg2WWak3cRktnGUC?=
 =?us-ascii?Q?XrcAIh/Mvzm10x3Wj0xo9ADK2ybOFZtrXJI1xmdxmWgmWrR72Ou+TFAFruCB?=
 =?us-ascii?Q?qu7GJSEimmw+6DSjgxH5vwnktUnwDOO7My5o+LIDUB2KL3OHYSUwcuWt2i4D?=
 =?us-ascii?Q?LEX6TU0qILQoZv5WI/y7MwL+v7ZHBgPXW17Ns3shUUd4YnT4X8zIvhFgxHYj?=
 =?us-ascii?Q?exJmuBMK1GeN574gmeYx8GH+JCA135M+OCrybyqTCcu1bI3F/yjzvYAttjv3?=
 =?us-ascii?Q?+LlJMMGRo/D1Df7sLjWL1rDeh8MdxT/c5n1dkFwVhrrbytqcDtIKSo+EQXXd?=
 =?us-ascii?Q?t0+yWMR8PFJqGL/MkKZBTPeKinYUYa4DnjrfEPivB8uwEz9w1EvwX19IZfnc?=
 =?us-ascii?Q?kYErwY2b5mCUkYiGrTIhxxPb+sQqy7w/x7xYMQGj13iqECnQKau+sQoe4ucS?=
 =?us-ascii?Q?P5Xxh6KVSClen+RuiP0fWa9m6zhnevLu64HFBqtLAwGgnZiCuQp3roUYCxRF?=
 =?us-ascii?Q?NtQqA3nZRmtDB/EgXYpsqsU0JUiFyvaV0YboHhg/rSzp1+8B9SoBwNgfSsnQ?=
 =?us-ascii?Q?qglpbBdppjw+O49Y0vMTRGdvKpr1UarOMy0/ymFinQnE32v2JF0S3yAIOBoZ?=
 =?us-ascii?Q?GCcnUaYzVMlP2bXgm9spdcbAueUrcNNgM0PpTZEzGUpsjzHKZ4s+qPm8XtYy?=
 =?us-ascii?Q?5arQKCBslBitQFmDc++XTyJyboF86jgNRCe3PCovPEKwbIZcYYSu1G9EBfNX?=
 =?us-ascii?Q?16Gnkv1goVUn9DJWmAjCRSrbshmZphclziZXRTkSB1Ct4PHRUjyc0yLfBZFC?=
 =?us-ascii?Q?bHBZyPZSnAirQQ4naKnTAyGRAnsBiJyZ7NEsUF7krEmPEVWcZw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2024 03:02:43.7288
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 675f1376-f1da-4a35-0663-08dd01fd5009
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075F2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8177

When configuring a kernel with PAGE_SIZE=4KB, depending on its setting of
CONFIG_CMA_ALIGNMENT, VCMDQ_LOG2SIZE_MAX=19 could fail the alignment test
and trigger a WARN_ON:
    WARNING: at drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:3646
    Call trace:
     arm_smmu_init_one_queue+0x15c/0x210
     tegra241_cmdqv_init_structures+0x114/0x338
     arm_smmu_device_probe+0xb48/0x1d90

Fix it by capping max_n_shift to CMDQ_MAX_SZ_SHIFT as SMMUv3 CMDQ does.

Fixes: 918eb5c856f6 ("iommu/arm-smmu-v3: Add in-kernel support for NVIDIA Tegra241 (Grace) CMDQV")
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
index 01a6f0c61f44..8a59f3ed8dde 100644
--- a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
+++ b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
@@ -558,7 +558,8 @@ static int tegra241_vcmdq_alloc_smmu_cmdq(struct tegra241_vcmdq *vcmdq)
 
 	snprintf(name, 16, "vcmdq%u", vcmdq->idx);
 
-	q->llq.max_n_shift = VCMDQ_LOG2SIZE_MAX;
+	/* Queue size, capped to ensure natural alignment */
+	q->llq.max_n_shift = min_t(u32, CMDQ_MAX_SZ_SHIFT, VCMDQ_LOG2SIZE_MAX);
 
 	/* Use the common helper to init the VCMDQ, and then... */
 	ret = arm_smmu_init_one_queue(smmu, q, vcmdq->page0,
-- 
2.34.1

