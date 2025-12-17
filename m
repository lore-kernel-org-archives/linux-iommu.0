Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012051.outbound.protection.outlook.com [40.107.209.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718D117BCA
	for <iommu@lists.linux.dev>; Wed, 17 Dec 2025 23:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766015892; cv=fail; b=A79qMmfxQAg3OW4HulKtKmNVTa58sGax38WhRb2V8jFlYqRLQ7toDWTeAaCAAJ+U9zZwxY48/aq6awYiSPnbfMOnnsh8SDvV9HEcG8ZaF6lKYrdQklHnXmFmp7MN0vX2ISj7nJUk4Aajwz0nbtNpyPyXGJMaYaPsgtlkJqwR014=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766015892; c=relaxed/simple;
	bh=vVGB0lPKN/pv18vEZZZt4tefmNsDV8+XzzlYCxL8LyQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LEViqzgg+KI2s9d7T/AYurZ5dVBGS61r/P6YLo3Lb5QK6Jh71BRwby+W5q8qBblZiphEIe6lUXo+R0Q/d7XOcnRBSU2v1CePz5BLd7FdlV4muDWuYYztm5ein2d7y6AG+JSoFVXwH209h+hx0MpoKEkeZEogRaRBScSea9GrSTk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FzTjZVc+; arc=fail smtp.client-ip=40.107.209.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FzTjZVc+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GyR9QTkpOOLXSiqpIUaEJ1IUvav2NIq9TZNDjw6i1RKxmyfMBt7mygE0e+3i8/tuWMRpItUzoBEer6vjqcYIt3miy1rEnHQ6aDJbMU3ANa6ZJg0pNGjj2sQZcQBAlnshOmNaMz4XvTelB0Pv58RoZ3rCi15KYzWPLy8XlHeJAqykSa+kq+GvqQmhrZyCUR/7d98rBS0VQbBGLeRmps3cc4s1O9aw59lYOtf+oXHmzlAW3Nq4E9ctE2wiF3xtlTjLqnEpuepIJaqyUYpdUjWVd7F1K5Y82SCiPV0+Jd0mOqCnSCkV17kzfQiALYjuzCMPJyRsVoPN0670oYyP1wNIkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3FUS3J7ddqTG9iTzGTOqOIvTTqkZWKjY7Lu16MSGs34=;
 b=sGXJro4mGEUiifcfgHiVWotuQ0o+hRkHn7MDZ/6qofRLH8J95ywLt2vix9568HXUKqJSToUYvwrJ8UVIxUK9oApox2qD4GIGD5O0tJ6mILz+L7s/nQYCAHOBM1rov0ZCCqmdFSMF1IYgkPDwPOTtPAfld/cJhRIAeFSyHqBJDJtPX4nnYQ/VnJmDXkCABwjkv+25u+yV2AE0QWbLzNPgurc2Zr4QwfFNzqpSEAtB7/Za/BEf9dNRSzEB5f63Lluh6vGuitmNxQ3PHK4RTgOTfccPz6mMJHF0nLhsXOi1nJlrxOrkCZtPxgkifWibEOh49KIhRXgk7BPOOmxIDdsakg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3FUS3J7ddqTG9iTzGTOqOIvTTqkZWKjY7Lu16MSGs34=;
 b=FzTjZVc+rgUBGwSr0poEKEGQ9GfGQ8dZ2MTV6txTQO4QQb7tWoGk7QQw0s6XrEuGrlE77ExS3d7XAFqV101LwWckL4pdePqMCK1A9Np6c5VLFPzQzuOWtO7WfsJDOMettfIvZIO4u6NhZTUiM0uMIrfXTNHvl33MDgnZnz6veTvljGMdVJAfkJMcPkZ23HxttvX+pWbCRbjMPo5K2LEdZhApFtU7wWZ8kPziI6Y40US/3y1haBaTr3Sfj6SihNsIsSq3qnVaJIeFYLCY1QUDZR31pe9wh3CxOhzscP8UVznUZhHZ2ajJGr1Y0ftq3TC00oOse/Ip8ffKqNtZZupTLw==
Received: from CH0P223CA0003.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:116::15)
 by CY1PR12MB9651.namprd12.prod.outlook.com (2603:10b6:930:104::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 23:25:04 +0000
Received: from CH2PEPF00000144.namprd02.prod.outlook.com
 (2603:10b6:610:116:cafe::1d) by CH0P223CA0003.outlook.office365.com
 (2603:10b6:610:116::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.7 via Frontend Transport; Wed,
 17 Dec 2025 23:24:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF00000144.mail.protection.outlook.com (10.167.244.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Wed, 17 Dec 2025 23:25:04 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 17 Dec
 2025 15:24:47 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 17 Dec
 2025 15:24:46 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 17 Dec 2025 15:24:46 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>
CC: <jean-philippe@linaro.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<jgg@nvidia.com>, <balbirs@nvidia.com>, <miko.lenczewski@arm.com>,
	<peterz@infradead.org>, <kevin.tian@intel.com>, <praan@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v8 2/7] iommu/arm-smmu-v3: Add an inline arm_smmu_domain_free()
Date: Wed, 17 Dec 2025 15:24:27 -0800
Message-ID: <b516338bdde0bc6f06e2719b9292ffa260085a67.1766013662.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000144:EE_|CY1PR12MB9651:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f270d09-f832-4a7a-25de-08de3dc38227
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XJ9yqmxW7WEkQvR9C2kT/cjMW4u3FBoLwUTV59mKm18qev3tlmKkWjUGLoU+?=
 =?us-ascii?Q?rCiiiehNeX/uEeo60NlAAz7xmPR5QYJjvGHqOQOSREZ1hWBX84mpfR3J/KH3?=
 =?us-ascii?Q?6ZcCqUXkbmqC3fUTHc0SCkPT31zRizYcQGb0gw1t3s8uf+GwjD2TVkSaRogE?=
 =?us-ascii?Q?0XYsc26DDuPGvBuJgma0mivh7d2o0TrPUNzbLsVS+eeA6P6KNtzslHylwCrG?=
 =?us-ascii?Q?QkOinBhZk4Q+BBXlEvnzNfAJ28/YE63g7Upnl3S+1KecNQw+Dt3P9joZIazL?=
 =?us-ascii?Q?HgCbsi3LSz9A27VLnl5Lmy5VEC8u+nI3hG8V2poh5qnWamaCM0jaUSFD1dGX?=
 =?us-ascii?Q?CCMA/80TbGyxUJtLH5Tc1F1EQrZP6/uiuXlNYRyByC9n0Eqz10AuAhR4kKWB?=
 =?us-ascii?Q?mi/p9zY+UFz2KBvjrBjZA36+FcjnP+tdFTtHXqzdMm6FlMrcwWiaQoY3qRXx?=
 =?us-ascii?Q?IwH3DSC5qUp3UIBY99xRC8CZTm6IDYewNqOx6EmOhBcHwp/FqguheZqh40EB?=
 =?us-ascii?Q?H6OAw6IrjDk7GZcxwOD50L89H3Ath276NY/ZKGeAwWk2ccdESGaiugVGklaj?=
 =?us-ascii?Q?TaFmFPsar0AD5Kz2AAw0J5VMd4PEOHWDQ5pVSLXdALbwxbKLXWoWg8FYhS/5?=
 =?us-ascii?Q?zjrVZMA/CAe37obuDgn+U7yk4nyQ5jrcojDA71UKv63mx4yPPS6VLd/LH1Z2?=
 =?us-ascii?Q?oQROW7fGSACx+DvKx/YprmB8aG+fhsgaJUl6kjjB4r9a/yl7YM70gDn5gnCN?=
 =?us-ascii?Q?ChLelmGLtO42dpsG+bH3oa6tIikiEQE2McQJBZvitocD8tR3at8qhP8MV0xv?=
 =?us-ascii?Q?TYvZkKIzzEDZRbo7jHYiRZKZo/2sV8Kk1nt1fYUyfNaGhamUMriaBNQy1RFZ?=
 =?us-ascii?Q?5wte3gUf8+LS4tF/SyBHysRYd9BtR180O+AxFPa5ouZSUtzT9KWg0B9THNCC?=
 =?us-ascii?Q?xZ3C5SB1kZ5KPKZCTDVrgQjuxvhOlux18h0rIBcBd/cHEOVNBkepEZN0L8ji?=
 =?us-ascii?Q?8dRwRdV9FjoVBaGJMwbsM0UaMpYI/4wlSlpOjnDmeaqkMHSb6vYExN4mTKgo?=
 =?us-ascii?Q?J0qS23RyPnc1Ulb1oacvWXDMzU61nIw3OnepJQqe+cQZKHpuBpj4mrICCt1Y?=
 =?us-ascii?Q?advbfmBW3NCYD5kwe6GMHDX/h22p9B7cmRTOzKt5buKcpBwHN/+EstL7d4oH?=
 =?us-ascii?Q?h0tDBXx8Q5MJDhfM1DlN8Z9z/hwLRmHOcorEntx/CWd9DYsdvC2LzocPxHaX?=
 =?us-ascii?Q?Gygfsqnna8zjx3AlCipqmADM1ZowKmtqVpTYWvvyxWjaG3zlzYEsp5mb1iDM?=
 =?us-ascii?Q?8+YdtzM2Dl2F+u0Ri6xu2fVvtxY1RlbwVOXPEORsf23deko1Hf/6jA+U86t2?=
 =?us-ascii?Q?EQsBojQcKEK3Ep5lTbvQI9wHecwR+qBv1apVE8aZ77UP0Xm4+uMKqI6OV6Bw?=
 =?us-ascii?Q?81FOz8ROHmEOeIFi19xVCzSEyZSopFzybLw0sxyc5TTbxmY9pn9JFH8vW6F2?=
 =?us-ascii?Q?rABt1JVo811R6fgg1J36DnLR/TYlSQqowazvT9lT+3vLQH6RCkQXKNMJxbpl?=
 =?us-ascii?Q?HHVtzFD86mMfzDbGM8U=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 23:25:04.3088
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f270d09-f832-4a7a-25de-08de3dc38227
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000144.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9651

There will be a bit more things to free than smmu_domain itself. So keep a
simple inline function in the header to share aross files.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Acked-by: Balbir Singh <balbirs@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h     | 5 +++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c | 5 +++--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c     | 4 ++--
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 5c0b38595d20..96a23ca633cb 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -954,6 +954,11 @@ extern struct mutex arm_smmu_asid_lock;
 
 struct arm_smmu_domain *arm_smmu_domain_alloc(void);
 
+static inline void arm_smmu_domain_free(struct arm_smmu_domain *smmu_domain)
+{
+	kfree(smmu_domain);
+}
+
 void arm_smmu_clear_cd(struct arm_smmu_master *master, ioasid_t ssid);
 struct arm_smmu_cd *arm_smmu_get_cd_ptr(struct arm_smmu_master *master,
 					u32 ssid);
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index 6097f1f540d8..440ad8cc07de 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -197,7 +197,8 @@ static void arm_smmu_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
 
 static void arm_smmu_mmu_notifier_free(struct mmu_notifier *mn)
 {
-	kfree(container_of(mn, struct arm_smmu_domain, mmu_notifier));
+	arm_smmu_domain_free(
+		container_of(mn, struct arm_smmu_domain, mmu_notifier));
 }
 
 static const struct mmu_notifier_ops arm_smmu_mmu_notifier_ops = {
@@ -365,6 +366,6 @@ struct iommu_domain *arm_smmu_sva_domain_alloc(struct device *dev,
 err_asid:
 	xa_erase(&arm_smmu_asid_xa, smmu_domain->cd.asid);
 err_free:
-	kfree(smmu_domain);
+	arm_smmu_domain_free(smmu_domain);
 	return ERR_PTR(ret);
 }
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 9d9f24a08062..e9759e8af0c0 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2492,7 +2492,7 @@ static void arm_smmu_domain_free_paging(struct iommu_domain *domain)
 			ida_free(&smmu->vmid_map, cfg->vmid);
 	}
 
-	kfree(smmu_domain);
+	arm_smmu_domain_free(smmu_domain);
 }
 
 static int arm_smmu_domain_finalise_s1(struct arm_smmu_device *smmu,
@@ -3359,7 +3359,7 @@ arm_smmu_domain_alloc_paging_flags(struct device *dev, u32 flags,
 	return &smmu_domain->domain;
 
 err_free:
-	kfree(smmu_domain);
+	arm_smmu_domain_free(smmu_domain);
 	return ERR_PTR(ret);
 }
 
-- 
2.43.0

