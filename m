Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013025.outbound.protection.outlook.com [40.93.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED66C330B18
	for <iommu@lists.linux.dev>; Mon, 27 Oct 2025 18:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761591298; cv=fail; b=HM3G5Osbr60U1XG3cN0XnrXq5XAj/cAjQ71DaG97CJl35PUHhJANMXJmSDTKOfv67YbkZhbjnLirYZQk4pcgTuFs85Tto+VM1HOY5CaojWmIfeLrqDqvPRporVitop8VB5MJYeSfK8YirMi3er+ZARyqK3bXR+TKcUscxxeJcE4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761591298; c=relaxed/simple;
	bh=xgzFpVrLkzYdxQafr/ZsDBol0x3vUnokHIREs/O0aLE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vB8dK0DDfwmos+IKEtMfcJ3tub4pQsjVl3q6UpR7gUX+RcdxJ0scb4GlWyY6GR4lRQ2dtVBPGAaXi/AEI68Vaf+hEybwCfclLiJZSNudFVrWjgyodXQL3e8RZdsnCcCzyI3XwDSRLlST3RaNyfyViTaczcFUr2cauwlAb7jt9ZU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FQWKY3lm; arc=fail smtp.client-ip=40.93.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FQWKY3lm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kBpEyMbN6HQBxIX20ifSJTV1f3AiuG/WV3JOMO/sV16lr6oo9UCFpcd8lWx6kt74KtyHsPqIiqD6R6MzIuKSq1+VLMgkOVpjYUPhaAHWDIrJw48F2mrz9WxK5EDhw+Ou6Ccl5fJ3Zd/B7OVktQsBqlI6KxzAceRvaKe/UIV+LRVsYrNyvI/1L+eI5oJnIbITEvN+DOrjX8OQxyh+2kvkJ57eB9anaVmNuY1QhH1XxdelSeWIxuwyOf3T/1jDr6AwmMXnFLakriY38AKFs9tNjwrGA/E6ju32BqoJY5srbaFY6cDvn+o/eCei5zKgRnzrhoZ5E2MuzpZSiTrYIqSoaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wyp2uxdJSaWI/GLKYnSpX8UVcm+Vvxd+5Dyzn0Jm0eA=;
 b=ge5YP4MdYW7MKFGd+hPOyHR73+fC9VJI9B9NimSTeaIKl6e8DHQi19gTiKJCSjpkNmZiFDOjLZfiroLS+kBt8P80CA2XmQP2IpMC6sBGOBFBqWN4k5Iukea0q27pseQDeyfhXcFgyHuvxyoTpmXKh042L50VKHQ96+gYHUx32b8hiFoCszHCskDPgR+xv++TE6ISq9h22Hoqr4CZOJWwyoKT5EknJKOZ3i4l7rdQqELxlOS0hMZ2N4AF0byllWWiFKhLV+f76HsYXTepTiM+o8a+wJQwZ0y5Iq3szvnETwW+TymmdVxyLdpfZGt9fZgFkiye564XBD3Fm3XPY68KMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wyp2uxdJSaWI/GLKYnSpX8UVcm+Vvxd+5Dyzn0Jm0eA=;
 b=FQWKY3lmc0/22lLda2HRk7MDHEztCr9zPL/CYSRekeSG+/E7H63GajYfWUHAy6Z+5OvvGc2v0n+typor9eTDx7ZiCeVr3VNDMpvJwO28m+FYqwZ5yvMyGrDPrSokNvkYzp3DxoHRqXgoBw2f7h8FvZMv3aEletsYcrZ8XOeSbWNmu71WqWe1LNhleOIuKHn3/UZ2pAYjDTfo5aZL5Sm6RxecUZgrh61XYTkPRdUwIL3VJzDt2iWHCZ9FQt6s1z1zYIZLUv72F9ZDrVL6nZo6p/ufjwr3ZWkqw35VY0T2+pZ/zAtp0Elae8GptXZKHs2c+41PV1LKsuBXjPYorSDtVQ==
Received: from SA9P221CA0027.NAMP221.PROD.OUTLOOK.COM (2603:10b6:806:25::32)
 by LV8PR12MB9619.namprd12.prod.outlook.com (2603:10b6:408:2a1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Mon, 27 Oct
 2025 18:54:52 +0000
Received: from SN1PEPF0002636C.namprd02.prod.outlook.com
 (2603:10b6:806:25:cafe::db) by SA9P221CA0027.outlook.office365.com
 (2603:10b6:806:25::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.13 via Frontend Transport; Mon,
 27 Oct 2025 18:54:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002636C.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Mon, 27 Oct 2025 18:54:52 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Mon, 27 Oct
 2025 11:54:34 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 27 Oct
 2025 11:54:33 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 27 Oct 2025 11:54:33 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <jgg@nvidia.com>
CC: <jean-philippe@linaro.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<balbirs@nvidia.com>, <miko.lenczewski@arm.com>, <peterz@infradead.org>,
	<kevin.tian@intel.com>, <praan@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v4 1/7] iommu/arm-smmu-v3: Explicitly set smmu_domain->stage for SVA
Date: Mon, 27 Oct 2025 11:54:15 -0700
Message-ID: <b543555be99dc6afa4a9dd61c211f42862b46ac2.1761590851.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1761590851.git.nicolinc@nvidia.com>
References: <cover.1761590851.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636C:EE_|LV8PR12MB9619:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a094855-8823-4619-5b35-08de158a4ff0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lFWVWYFq0sWWSRkoo36RuaQJ/NeYWjIa3g8+8i0fa3R5zKIsPLTGrHo0rDTR?=
 =?us-ascii?Q?XEGwQqdfrTEGcGx66hhNFckDCJX7LJTl8/mDQTvcJ/eg6AFhkq8IB3uuqjg0?=
 =?us-ascii?Q?K7eFEnrq14GYP9xJ+xgRM4C0W592MO9f823WxjfJ5L/sal4xs9xPTR6l1P3L?=
 =?us-ascii?Q?j3oyrg41h8iN581yxO9iBq/BM8tNDQU+SY8QQRdMDWV7vH0pkr0/27fJZXah?=
 =?us-ascii?Q?mVDvr4QQ4Zibp51j1fbi87MMye6u/UoI7fNTJeiOAAx4f5GZbTy6RQrUfWYV?=
 =?us-ascii?Q?rHIjhttkXHAHx4+/fVg1gC9oKyR/yTg+U4r9nnbTXQfeXP2nTZch9wE8RyXj?=
 =?us-ascii?Q?JaZrsjqTf6mklvjs+fvywRpVzgmUsBxlkTr+b3jw6rj4OsStUJVUWtixU311?=
 =?us-ascii?Q?B/+xV8yOz2He4sc2iiNFs1NiiJ1VByro7zHDmF4C0IQnw+Etpo/C8C0y1SrA?=
 =?us-ascii?Q?fDOqJ+fdVS9/bUVME4uHyUbk9lfI1qWlv4TOEKQ3VH1JkcmLUkaZQ4Vi/SQl?=
 =?us-ascii?Q?+V1OV42ZUCzM0lzAx8kHHbgG56CDHPbju0QUJUql1T+BdGX2d7A9YK3YP0wd?=
 =?us-ascii?Q?70lJOrY2+vSkXymiCDDphGbzyRBGKtB96pCdzstcFgBo38zWaNFV4aTczo9d?=
 =?us-ascii?Q?05bQ6gDbwv5ixAWQzJPeZmz5JEzy6qUiAWkTeIZeWtUn7I6B0Cn488GURECK?=
 =?us-ascii?Q?qGTXMW3RMmrImoSSGZpsiTjTDKQAHqWJ2rQ+QTVVTPuhAmHF0JVEqFUvAB1M?=
 =?us-ascii?Q?W6ltuug3xbvWlsdAYpNVZ1W/7gwudS7esz9IeEqVwHnlvFWGBLxxdCVcfxv3?=
 =?us-ascii?Q?J5OfSGsuqO1Let2O+05q/Hxx/fOiBTHbddz+/01Tzm76SaGYgn+RWIiOkdbc?=
 =?us-ascii?Q?QSqn96kcsjktV5Faq+PRWOn7HpfmvBF8/otP7kNJ4yaLLRl0iAbhoqzjuGqO?=
 =?us-ascii?Q?ZwyfBNXvtxJ33XAs1Q6BSpicUoyRH9ZEfiH5bVo1CTSNUgZWQMtD/sVYWNwo?=
 =?us-ascii?Q?sAc6GShUuZahZ67adyevDTjUmzIFnSJ03WIP9KpgZtoXPg08pFvDsNEKLZrA?=
 =?us-ascii?Q?6wAVUPUNomVWOvyA8gR8yc1d8MFJS1AOV3paFktLi8nBpApDX8EL/thDlD94?=
 =?us-ascii?Q?wdO3BcpkXrQk9+rNiWDG8YcpFkFAG7CfeRt4G2z+VKx25C42UhEoO7I9bFnP?=
 =?us-ascii?Q?U1BqrBuVFxBotodPGhqMFgmc4gvzhJuPqoq0+p4toCA5Dd5Amtr25SOXw3tQ?=
 =?us-ascii?Q?gQZyFlRBWR34S+hGnio3wZxikskXi7QddW7ranbEzSqozOzASGy4J8BJlvh6?=
 =?us-ascii?Q?YFpFFO7fQKNYT9YWphjxAWvr6xa3l1jnWkJcJOPGDjOzRjhoCTE6OeC2bSFs?=
 =?us-ascii?Q?L2Bmuesu/LsrnnL3OvLWjIyNQqDa+qaWLoZY1ItWvnQ0JS/12bGdcLR96l+z?=
 =?us-ascii?Q?wMDaMhktIeJxMBsSA2RoX25Kk1Rlz6UCD7k0KSFjArjW7dKngjSQ+zuzGtYN?=
 =?us-ascii?Q?5diEBX7IH3dgTto8lEQuynZuAqvcj/vxb0XwyCmUckDsSuZ3dX7DHRMy9Roq?=
 =?us-ascii?Q?45O0GWdxMjfP9nrnaT4=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 18:54:52.2799
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a094855-8823-4619-5b35-08de158a4ff0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9619

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

