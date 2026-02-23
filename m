Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012064.outbound.protection.outlook.com [52.101.53.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C96B345CC0
	for <iommu@lists.linux.dev>; Mon, 23 Feb 2026 06:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771827527; cv=fail; b=rrZjdiwiA6SkHSKXagT2EyqDsrIDv+TKOZRXtFFFbooB3fgoTJOo6kVbgsy8N8MWjWiRuDRVwGjMqSe+7VcRZlN3mme9bjtjs3EmCRU6W9oc16rJgTH62P38cyXXHwlovdWmf3by91tO68Iihpv1lo/Aw7P/d5hwVYwXlf5i1bU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771827527; c=relaxed/simple;
	bh=kRk85MxcPEAORIDdbxmHPCHoBAvSAL5AKo4T6IbzdZM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V72ms4BHI5/tjXosjWgCmF92+4H4UImsihgH5KKwsdYAYfchA118BAbTgXZfT4QKTSZTya1ZTw4uvlNvM9FQVcXIisW6qGlarpzRvzkW+yYUhKnMS0vevv//fMs8AQyH/dDncNZI7SXJgD9tPQFeUcXBlHcPaWASJI83v3a5OT8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KeXaciUk; arc=fail smtp.client-ip=52.101.53.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KeXaciUk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JOGCNLGjEbQ+JydJRukHiZhEQMmZZ0juC/l40AY3MoojaegI6/kPgKlADmuQvapzthnJTUBRRfolmSQ7x1xgdfxEX5OzvyMxK/RZ96K4lxAEWpJ8A4eEK9CrEFTfp3v/I3e/1j+RbkEOkfPubEIqfe6R0rVwtBB4KeRzivqeqIMfZZUh1ULTHFg8IT+6N9pdCgLES9YanIS0kzbTEdUM7tfN5m8sxEvpNzNwkheKjG41oYaGtonBAp4fPsVBYVRHn2kOao9yi+NNs6Wnl5A6XZejgMBfJCG3MhVZGaIquHnfcOzfih9O//EqfD2d9gTPAC21DsgRVSa7VNPCtZoLtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cM38idNKQ/eB4qkXYpbNTY+EKm/TuCFi5lgZaJuVGTA=;
 b=P9h5VRsFbRNDvaZ6dtBR4qo+6B72KrwRVH9VPprdkJLPi789z5aqt8xugncto82R6XXzRqxBNe8MLao0k7Zmf2KqUGNiq7uRELKGwPsDg6jGAiwUOE3Mw9vqTpj5wM0gk2OvOPBXSmQG4+au4fuWcPLC1tb2O3cwCyoMpCu8WBNrIwMba9W3AYMs1zhTuiNy99w4+2yQ08BgVbL2hxKOZ9142AY3PHy64f/wQLuOCBxu6nx/BUoJ4Y9NyJ8e31PQbSRg0Ss9weQbgk+1ytu2mb6tKGNCGs4Hs6yPm3C+x2EaASLI1eMRgzP6rPiJUP2wRQpqPnqNrC8W2+rYfnHhdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cM38idNKQ/eB4qkXYpbNTY+EKm/TuCFi5lgZaJuVGTA=;
 b=KeXaciUkmNZQ+nmDfx6xXHy9keDHqKcWNc8pJSRKnOxPHG66fmZTgRbBIaGnXaCWjjmU3IQX2uOK6nSrjcSYGeH4kOlUfgz5OCi97zJRKfNP8OyHVVK1wh9ZQydG2E5hKluGgpheuZ+kg4+5pPGeZO2yUDTmjZju0Urp2ICvXxYIYNuncJUYWgUmQLWvZRvd24T8cJFLz0ekwFyNbzFOtsGpIUwiGRh7Ua3Vp5am4yYXcI32n5a2aiDzSbqrblg1EkS5ljN4KeyjW/0Zt1Rvu97hfQFDb5DE/EwfaJrYAlAH06v63LxtNydPY9RWKQqVb8n/G5fw6jftxGYlA/3rcA==
Received: from SJ0PR03CA0231.namprd03.prod.outlook.com (2603:10b6:a03:39f::26)
 by DS0PR12MB8069.namprd12.prod.outlook.com (2603:10b6:8:f0::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.21; Mon, 23 Feb 2026 06:18:41 +0000
Received: from MWH0EPF000A672E.namprd04.prod.outlook.com
 (2603:10b6:a03:39f:cafe::b1) by SJ0PR03CA0231.outlook.office365.com
 (2603:10b6:a03:39f::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.21 via Frontend Transport; Mon,
 23 Feb 2026 06:18:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000A672E.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Mon, 23 Feb 2026 06:18:40 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 22 Feb
 2026 22:18:19 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 22 Feb
 2026 22:18:19 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sun, 22 Feb 2026 22:18:18 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>
CC: <jean-philippe@linaro.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<jgg@nvidia.com>, <balbirs@nvidia.com>, <miko.lenczewski@arm.com>,
	<peterz@infradead.org>, <kevin.tian@intel.com>, <praan@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v12 2/8] iommu/arm-smmu-v3: Explicitly set smmu_domain->stage for SVA
Date: Sun, 22 Feb 2026 22:18:03 -0800
Message-ID: <b30c2a8621414384bd6ed3cbdcb3af0210dd0d70.1771815709.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1771815709.git.nicolinc@nvidia.com>
References: <cover.1771815709.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672E:EE_|DS0PR12MB8069:EE_
X-MS-Office365-Filtering-Correlation-Id: 6427ba22-2abe-4009-4cce-08de72a36392
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?K0d/HCz766y3ESg81IYpS3AdwFtvYbvUSKGxyC2S+DhCkjLUbM0Lb6HjLLNw?=
 =?us-ascii?Q?bJ3yZL3QLlTBmNYAhv91NKVBdxOal6qUNvGSj2EVzWgpdRVzA/lshdGQL/rO?=
 =?us-ascii?Q?9n1FA0DGFpMa+Nfg7Y0a95sVF11jDi2yt2Q1qhxBnnQWmK8UUyqqMSKZWLXE?=
 =?us-ascii?Q?td5Md1wYJ9OyVlapL5j6PcjxvcrBcCuGCaBu9KK6CuurQJghQmvx4fmIHsl+?=
 =?us-ascii?Q?wyuh+XuVVu2rxbJ98/ZRuhIsmoiN+kfgCJk70taAweLrDU8YL3paaUQE0Pmf?=
 =?us-ascii?Q?s1U89hzrLuW4Zgka+ko6g35Mc85BZr7TLQmt2TEyCxCkY36go3SPxmq4ewo5?=
 =?us-ascii?Q?P+TjE6dAEDz3CfKwg0HKA/4LYCo3Jn2c/SAPEQv1UKfUDiff0d8s4W3GYaGm?=
 =?us-ascii?Q?siU09gW/Peqm1//t/ELAKC/CUZbVsJykuD4wWLf3/5WkJmXNaye4FU5Foxvh?=
 =?us-ascii?Q?JW70rsD1lVoXeWi3IKt0njHNW1vT/AgBCkABlLf8tfGGPhIdoHfY0fclDCaY?=
 =?us-ascii?Q?0e3+kY6AtiZmww5jlVmSlDWKakMMMC3JCGtwbwLsDp1wHCoo0lu95T8Ak9Gy?=
 =?us-ascii?Q?0UTkaizgSryHigC6OC4BKY3VFUty5SQxkfBfYLaotG4vkhh1q4o4DSGjn/Hs?=
 =?us-ascii?Q?4TIA6DGOzLf6TIT5wGI2K37FXxJrIvoXNwQzctIY7ZH2vcLhrueRFz7gNb/g?=
 =?us-ascii?Q?tyvHu4+aYUMjENiSNEJZ0g23C8Yvkza1SHVbXE7x0XxVMNC9HQ4YJkZ8H0eG?=
 =?us-ascii?Q?cSdgh7iegb2zwkASneOmjAqJLq2PUqeOG/QA30iSaM46hUs7+Ox/iSbgXeH5?=
 =?us-ascii?Q?fLKDQATfRMFvcsVUdOf4IpX6IRZDzwCyXjrs4VVAKpTYv89gqbKEUDls7IPf?=
 =?us-ascii?Q?Fhz3Fr4UsbSQH+s4Og9iN/OJ/BDRucxKy0bVw0PWJjUtdgFV9QPXLcVsNDJo?=
 =?us-ascii?Q?DL4hlMW1s+hI79wYPOWBUoRc0sh0s5ajih0uvzud83iy8OiOTQIGmLrgvbpr?=
 =?us-ascii?Q?j3C5jzAEC71mX5ZDi6+FncTbLqb8K17LktpfHRlAVQXTm2hOj9RbfZqbN9nN?=
 =?us-ascii?Q?IzpyxPEfnj2rCU+/B7DaVFi4yx2MAM+bhe4so19anyU5wdrzofY8SMfkF9nk?=
 =?us-ascii?Q?TSRGAfv50ZD5UbkLborzYRwKKUYkggxdAINeRhKrgnRmqi3uN47grRxSw5LS?=
 =?us-ascii?Q?xX7tJFqJPy+XEDiDx0USGWiWHBs+9xZMB/uVGGm4up2abr4tShBc/gRLFV0q?=
 =?us-ascii?Q?BVf2Md75wCQyIQsehTXbBpSixVOvBCQwYC7hh9ore37R4uLeqvCVZhaV1m8P?=
 =?us-ascii?Q?vFb43pQp9zgESMky4cOurAaHtA8B+4o9xdXgraW3NIHVgfHTDoMUwx5gKS12?=
 =?us-ascii?Q?XyyHLwEg2U5vcRMRXPKJ9P4T7hSm+6bfowU79OZb04WCvHn5BBFHPxq6Wasv?=
 =?us-ascii?Q?yFOQ/q+OJ1TFnqjcus2megXG6jNrf08BbAEBho2QZ8yEyDMQgwVslmToB951?=
 =?us-ascii?Q?wXWDXJuFAdXLEhHpvlxz9CNXlLdur2n45jaUn/TZ+zG60S7y1/76yUGI/Fdb?=
 =?us-ascii?Q?5nqLDo6rHWX2+E54xkuQB7i+nnOiatQetZqqbip60h5CqKMwqy/GjOr6hOea?=
 =?us-ascii?Q?lWyVC2/z5h0F+sUl8VhiRWm0rxH4PV3gKtQRnx1YnvIiiZs4PrsFVu40sKQ/?=
 =?us-ascii?Q?VRkJmA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	tdtFX1NscTqs1rT3Iudp2/1qyTuC3CLmhGjcymIi5EOidlsZFXr1IQ7ulm9SHpEQACHF0GmSbqhPv48IYD4NmSvx6gSdyTOTEF0KMIOmlGFykIep2V3A8AGGrobeqvxgKMt69A5GBXYHFkW6sj/oV1Dm7AVoIinCsGyakvTeHM3Q0V2kAZuNPHgDpzEFbRRiFeQGwnfwdSMzoWxODaAFmkSDuxMZ79ayxVvUp9K61DJluBWrK0wWC4yn697FJSuz9UDgkwzFYxQkMhuWFXBN8HD/nF6AisEG4JgHYiT9mFGytWX5KDgDq3CF2jBjhu+EniwUIbe1cDAjyYSVPVaG9iD1C8Ymct1xBw5QYlit1Y3CtX18Hflc1Q1SjoR5qt+C7pgIsQLqojYuPlwLbVdCjp29k9nIUJsmpcKFsykaWroF/Vk4psypHh6216XX4fJo
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 06:18:40.7511
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6427ba22-2abe-4009-4cce-08de72a36392
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A672E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8069

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
index 3c6d65d36164f..24894b1630045 100644
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
index 59a480974d80f..6097f1f540d87 100644
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
index 606abe051e68b..117979c96b762 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3132,6 +3132,9 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev,
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

