Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012009.outbound.protection.outlook.com [52.101.53.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93AD3212F89
	for <iommu@lists.linux.dev>; Sat,  8 Nov 2025 08:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762589321; cv=fail; b=J+Sc8I9J1/f4zfk/eZtUJf4yCNtltl88oMgEsEmSL03NJhsIRQLNFQzK3GxxgBJx4L6YJeXe62QLEesvl2cgL9AIOM8vmkaoxk7gs9AmakEpYFMJEcqJCBI9T0JjCiMrGmEAfsF6whVSXlLzvBuV/lqqzLNn0GrXrtNmNij52NU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762589321; c=relaxed/simple;
	bh=xgzFpVrLkzYdxQafr/ZsDBol0x3vUnokHIREs/O0aLE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GiIWWERZvm8DX1TezRKNQvVcz73NnAuTSLGnSlbmE3xwKl+QFlYKQB/UxTwXVSV+CmcyU6GRt/eA/9ZX59MMm/g0BCV2DyR6XMElrwuKETA+kXnRvWcRNQlxCcmaFzNEge7bVNbSg3WspFk1l0A8x+5rHwuUB60BHNR3eZz4kr4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RSpuv50J; arc=fail smtp.client-ip=52.101.53.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RSpuv50J"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MwtdNC4BBGTSfLHEzdd3xAkX0s+bnVRUQq5ms2xYcLKz4ICJh3OFmmBDkWqV0plPRQGPRgDQNnlsm2E2E9xcYUM2EGPrZPve9nXYGLmRDN+vBeRVg8CDXfN90FsODAbZlGD8/sHJ3bGcTQYg60ZD6uzLwX8RmwlES7SxtrKFS0Hc7SN8C2Kufy28HTJnee0UbCiueyrGDVOi9AdCMM/ogWuhZS3Tk8thCTf6gkeyjbMIuZUCVMxXrax3gNsxxMPTTtc/bt6x07mFo0vDvpJPcR/yJ4H0R0c69tq34AVksz24DKJy7FL7FPdxXCxBj+mmqg/+pHRIfrmEjAhmQt8HRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wyp2uxdJSaWI/GLKYnSpX8UVcm+Vvxd+5Dyzn0Jm0eA=;
 b=Fgvt21apYNdFdwYVKBpzAUYQG3qURi2Cb1iCM7DEMjFZL/QZ3orYOmJeSckefBggjSRnbowl5inhuqYEBvgonKkHhQHdFf6+iQPoUjsUEx65Azb8WBgIFRCV12q66OrJdF6wmo7DXTst9nKbeLAefhN+C0CAurwxPJ/BWHQp8mBPw3NbEhFnydlYmcXxJASH3A3NpVjFTHcHbQCZ6FqxiyP0ShxTpi3bDWp136soAEb1HFkID6tDh1+/IOTqVvprB9KPcImNAUl66w8FP/LhiVGAiY0fG6f87Hc6cEMUlvIilactPV2nrcCQH62eSi9wiF+JRxDFgpqtbk7dzxlsyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wyp2uxdJSaWI/GLKYnSpX8UVcm+Vvxd+5Dyzn0Jm0eA=;
 b=RSpuv50JIP659yMzxuGvkHOh9YeiO0CHWLRJc/UUND2ZGLqrCUvBaDla+xFq2s2ir/a/fZqyIFcBc8qUerRqdburav3Mh0yfeLNsteVGqpAm+B0guzE8Dc0CmpbzUCtymwqUKA12AWxdhdFHa6kT/A3C0yWcQMq60qwk3MKWt5RxJi4WPO/VOpjveFBTVgmAyfEeaEN1lsQcnexTbjRpAjPy1Xvna7V7iuefzcqixTUjgG0FyAeKRI5d4eJamErMy6T94dEI3GWJpryLLRdNJwNtcb8hz3RiYGNLgOqYxgFXAPm6dYtSeMox7wCZINBH1PgWQSEiZkQJLGQ66UG73Q==
Received: from MN2PR14CA0016.namprd14.prod.outlook.com (2603:10b6:208:23e::21)
 by IA1PR12MB7589.namprd12.prod.outlook.com (2603:10b6:208:42b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.13; Sat, 8 Nov
 2025 08:08:33 +0000
Received: from MN1PEPF0000F0DE.namprd04.prod.outlook.com
 (2603:10b6:208:23e:cafe::7) by MN2PR14CA0016.outlook.office365.com
 (2603:10b6:208:23e::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.15 via Frontend Transport; Sat,
 8 Nov 2025 08:08:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MN1PEPF0000F0DE.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Sat, 8 Nov 2025 08:08:32 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 8 Nov
 2025 00:08:18 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 8 Nov
 2025 00:08:18 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sat, 8 Nov 2025 00:08:17 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>
CC: <jean-philippe@linaro.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<jgg@nvidia.com>, <balbirs@nvidia.com>, <miko.lenczewski@arm.com>,
	<peterz@infradead.org>, <kevin.tian@intel.com>, <praan@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v5 1/7] iommu/arm-smmu-v3: Explicitly set smmu_domain->stage for SVA
Date: Sat, 8 Nov 2025 00:08:02 -0800
Message-ID: <65c692221d1b1cf0e8df7329ba9183b92932c40c.1762588839.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1762588839.git.nicolinc@nvidia.com>
References: <cover.1762588839.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DE:EE_|IA1PR12MB7589:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b725529-cd4b-4383-7828-08de1e9e0297
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NhUYSMY3HbZ/TKrMOFZMWy3Jdzktw7fWVgZy1rxYgc1Tzg/VjSh0lpW0SL1u?=
 =?us-ascii?Q?+uAYIc7pC8A2RPgMd537sl+NdR/kboRaCBTm6C2Bn8IpYBPctCliMbMAIexh?=
 =?us-ascii?Q?Ht9cpjfd8kV9Ea17WbnnExeA4kugbJN9JYSqzjcXfP5yNj0S4ylwq6ricqX1?=
 =?us-ascii?Q?ZwQBXlhZ4PtIi7pLSC03p+rUBStaDiecDyGsF1VK/dtIBV1pJDc3gH3L0EJr?=
 =?us-ascii?Q?QGc8oN4yY9Z1e0OBHEjwvi0bAcSoCpRZOJUSnCS7ZfIzyti3dKsxR2vWmWNE?=
 =?us-ascii?Q?mP5ASshYSeYif4ZcsNShkIWALqQIr86jcpGPpj1qehoq7aeeznoZsNxrLjF+?=
 =?us-ascii?Q?CRro/VfIRS6adv3qSKp2CrogY+PjX4Ipv0VFlfbGAfnt2BJ9dlRqBTppqFhl?=
 =?us-ascii?Q?YbKVJtT2fa0dcomdO+srld7GfnkjpzB1qPtqcF+5N1wwdltUwMJB9NlmJDd/?=
 =?us-ascii?Q?FRByGVPzWXJV/ZzcdFhge/jncNFftCKsaDvFBA+PPGp0LD5uumIhIt2GpbB0?=
 =?us-ascii?Q?2HzR8bAZ37XRy1gSj4b7SIvdtw37ccLMY3bDUhMGOsG+iuKiAIEBMuCVaTP/?=
 =?us-ascii?Q?YNkI5Jqx3M3Qa94lt0fm56mQy9Xf/UG/EP+KVZAzPpBauEB+bQ82tLEn/ggd?=
 =?us-ascii?Q?kjqh+ravv1Ig8zA6d5EQlrKx3k9ox9v9WlBJ0dIOiXX8h2oxc4VB4bHyVJ1a?=
 =?us-ascii?Q?hKMiCMfT0R8RClkwzeqYTAr82DkNpw1gCOQAR5OEpbRtJcawJQBIYouGFGLA?=
 =?us-ascii?Q?fhbaFy3Nh0zf6btnKrQEDBLiOg2UxWtttL4Z8s4ZZ0AgmZqN8yOUbAZoHzEK?=
 =?us-ascii?Q?bhxmpwb6scvu5h98FOcKYaeU1rEClkPOJAIipzkZlGvxToS8hSu3nJl7+NAp?=
 =?us-ascii?Q?vAAuXCqFidhWI/vrJD0oZ/ijpIFEjxE9BQKTU1euudf58gSMD0x1nChAn0hW?=
 =?us-ascii?Q?cZQLNn1gix9Jh3s2M2IDsB4B1sMg1mnP1ogiYzYZaK4Omk+nBk9Q4/gwG0gY?=
 =?us-ascii?Q?GgVrkjsDREHnKsi1NkB0BbdyR5Dgpx/2AOnhQ/kVBm+dYxl2Y77/OFbWdxRn?=
 =?us-ascii?Q?xykge3edmNx6eT/GR9WUmkg1wCx2w6aXYzXTzzHCyLkcgsAxDl1rei8m9d+y?=
 =?us-ascii?Q?MtNL+arJX1uz+QQQBVgF65fImAgOJLYiK6Jg7FTJsEJifTNqnPtHpA/gqR9X?=
 =?us-ascii?Q?gZIdOdnvSew0EnKk8nfh5za2/bstJmO6YU4W6+yOJBU9jFLP7tmuMw2oSaFq?=
 =?us-ascii?Q?mQ52N1TymAmWHsutdKYstuwdZ2cvsrr7LZyP/YjDLbX9Z+MbitPAAwljx0Hp?=
 =?us-ascii?Q?8fp35ALuSjaQiUO+qfuRCUywUwz6njXQDTBK0NAW25dgG/OvjbsXfg/nuK/t?=
 =?us-ascii?Q?rAIv12BHw4mEg09jObDJleNgqoNj2kxbvn5C3cHhKdFLdDPAW93aE1sSHJMh?=
 =?us-ascii?Q?EXwczLBFLAhdHoYDhHthpT1jVgVbJ3RjHSywAGdqW6Z/ozfeODwMRaekE6r+?=
 =?us-ascii?Q?Fe7iZ6fQwIA0Y1+FqLuOsfPjfs+jdEfMl5k4XtweNxoV4z4guLCIkuxg2lEx?=
 =?us-ascii?Q?BGgCigKjt2UZIijDkbg=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2025 08:08:32.8418
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b725529-cd4b-4383-7828-08de1e9e0297
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7589

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
index ae23aacc38402..5c0b38595d209 100644
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
index 2a8b46b948f05..0312bb79f1247 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3064,6 +3064,9 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
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

