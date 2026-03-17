Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011055.outbound.protection.outlook.com [52.101.52.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA633393DFC
	for <iommu@lists.linux.dev>; Tue, 17 Mar 2026 07:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773734395; cv=fail; b=iRvLLgAkP7sgFoRI6YcXlz3Oquut/Lm5KvJcoqZf17hdI5O2N4pL0UUfUm3/FpWzNYJV5cEK0O2m85qihiqbCrXqhVmnjUrD+zMAJJ8uP1SY0kgwWl90SrjEHfxFV59l/qpv6kO0uKV3LMOux/BtxfybZbj5wXJERzVCxc7lXOA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773734395; c=relaxed/simple;
	bh=M2kdP0zkIqvuJlpUGygTyx57PGFw7DW3DmX/lvkmwOE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RJTfUU2PiNtZsyuyrr1deDRL1jFTxII8FMs3Dnn9+BAQ1tZEj8BCBWBIwlAqlLHPBq9OvauN1wdc6HBJJ56B9iPAgRRRJCP/IdFLEommfvW6wfK/+D8N4Zj9hCnIYeCE3D6e1yHpSDEHr5FxHe3rGy/CjYoRPYXgOHKG2IlL73Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=T3Axa8FC; arc=fail smtp.client-ip=52.101.52.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="T3Axa8FC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UT75laf3XAsBsyOZ078uMIlGZNZKq2RcNXNNB0SSbCtX/qErhYG3UZDWEdA8NECr2IvVJEMs0Bci3AjBGdOTH9i5CXbhmiKQNIsfhfB8xDwkpSXt06oqgEtUnuRoBibtWQNjcsOW47drvkCNUxMFvYkG2rjtUuoI9lD1Wkii9VyLBeb/zoaJHX6e0r5dnk52tojh+FI9oYtqtPK9PTViO4LKRQVJlzu2fh3BZHOKd6JW1HdY91P5dcEQjLjwV8NZJJtDI6+opzO+fkWcIBNmQeNpRfUMbzeQyiiS4XcS4eQ0jcHnUwHCpi3XloxiJPVGNRzQeZf3k5ZRfeadugISNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8gHQEhe6DNThiJVsb0USEYA8QAcJvsy5pD2hCwrW9i4=;
 b=wKywcv0+JKDnKTLx6yNiP8GkYxwk9Tg4zSagvthQiBU54cbITcKj3lUolDtExELaW0BC9M4BqRUsoIloPFNYe1G8nfofOogbUYshpBw+VyARFLDeUVlXFv0tdyXMcEm4jTTdEWvQNDSDwgx4kpzNLCIkCagdhYL/hZAHBsmzKFk0CokKcM5/PTZbhQ2OVFvODMUeb13StAAT1nQfsinz/mLKrCgE0qaLuAJwOdvR7ViOcZRmrsSYuFesEyHNF2lmrqNI4NRpPI5bc7VCjJckJp173JLtRyyhlXIv1K+jWXqiAmu2w8mmg+WVnt6qX22Br9+cugGt7tV/QeWqkURF7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8gHQEhe6DNThiJVsb0USEYA8QAcJvsy5pD2hCwrW9i4=;
 b=T3Axa8FCb/51j4wA31Lyc/sdx7up22frDufk1/0htZ0kb++Nr17Id/+rKMMGdXgOHlHPsXXhLLdpm2d/cakKdFSo2bUrjQFwmSKscmGFjSiopiTZRJxRCMtf5qW+F4zuDSytPZWmmNwshiZl+M5zMuuvESMDiZgWx7nsIdhR+Wlz3WthTbATvRDhjyJ5X04k8TIybnFsWpl056YMTZYdfu94YASg56DMS4kxQsCvQcH0oSzH2m1TP2LCQEvlnHMITSO2pmAouh4NQOajtRvkzg/G4C6PvC6dsqqNZfnLL7ogx/+ysDBxS7uSvafaYMz/Nftg8p9r9lnk3XUTTI9LZg==
Received: from SJ0PR05CA0149.namprd05.prod.outlook.com (2603:10b6:a03:33d::34)
 by BN5PR12MB9487.namprd12.prod.outlook.com (2603:10b6:408:2aa::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Tue, 17 Mar
 2026 07:59:48 +0000
Received: from SJ1PEPF00001CE8.namprd03.prod.outlook.com
 (2603:10b6:a03:33d:cafe::c2) by SJ0PR05CA0149.outlook.office365.com
 (2603:10b6:a03:33d::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.24 via Frontend Transport; Tue,
 17 Mar 2026 07:59:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00001CE8.mail.protection.outlook.com (10.167.242.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Tue, 17 Mar 2026 07:59:48 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 17 Mar
 2026 00:59:35 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 17 Mar
 2026 00:59:34 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 17 Mar 2026 00:59:33 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>
CC: <jpb@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<jgg@nvidia.com>, <balbirs@nvidia.com>, <catalin.marinas@arm.com>,
	<praan@google.com>, <miko.lenczewski@arm.com>, <smostafa@google.com>,
	<xueshuai@linux.alibaba.com>, <baolu.lu@linux.intel.com>,
	<kevin.tian@intel.com>, <mshavit@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <peterz@infradead.org>
Subject: [PATCH v13 3/8] iommu/arm-smmu-v3: Add an inline arm_smmu_domain_free()
Date: Tue, 17 Mar 2026 00:59:18 -0700
Message-ID: <8f4a7064b5f41a7caa9db0740a9003bee88cd7ec.1773733797.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1773733797.git.nicolinc@nvidia.com>
References: <cover.1773733797.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE8:EE_|BN5PR12MB9487:EE_
X-MS-Office365-Filtering-Correlation-Id: f6834d94-0b7e-486c-7bff-08de83fb2943
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|7416014|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	CDbp5g2e/asFFOqbe+ztVvximy2JW8LdOAQGeqHtT9V7gzKenqsrAgECtj5JA4tU+YQd4j2Dg3ClklyaBTYp+/pTN56PiE367byh/iXYnEBcNgI10UqWViskYwV3t10U0619sT2C2dbHzFPcV9ZYo4PkaX+xGZDW498wukv5+zio1fJRvx38i1x9S2JoY33pcyicRftPAdeNENcDpkBBjYouBV6TTTEamzfLdoArN4U/seJIlM3Dx0Lq6S33jgP/PxG6tmAxKf46KIfiI5/yF9FRHhgZsQx68hfyOSj0zqv9a173wbeQMcft92XysKqkhUc7yyCg2iCrM+AEZ7wfHvFvIWkjRIKGdZpIJ90FWk5dlsdSYC0kauCZHdOMCARFvY4RirBXHxg43Ki34TlQ39aBUHoGfEIGGIHU1JABndNrY4vR41VdyYRYx33d33FIQDyF+yU2hoIlrdyDrGAHbrz6N4DmdsJkcgI66/Utkz2qW3YddvIApTfoG1IhzfENgWuXcR2puNPlu8H9a72IzcXYREUysMe5VK3fo1DzlQgf6srt6sWbQlUynmOwaZQqmZu3ahkaPM9CFE2CW2Js0YI9trrQ8w8PRAPGt1eZNUTZuzyaiVRsH+ewGzNNC1GxsbSlxFHFZvrJ6YLO0Z5mDAzcJDOY4ebaTzGpi4kPaUOQTwNPC5hiT6XljnM+yWA7rmGA4OZ9kztqaXnwAHeTsmGcl/WACJ94qxSnvo0e1UgwuwrxwUHRMfBGsrQmbaYc0pS2f7vKBfEMBjbRgAA3aQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(7416014)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	MeKm5rg+RYiUKHO9AhA7ErXTlV7RcJ0EIk139UGIVtJRv0Fa4IyXLedjwyOfyRr/6uYpfXh+02qOklZX9ez0C/wZKQXV5RHsFHFduAkd9ovehr71U+SZH5pNeHDcVYA02UVCM+6bojBpHG+shVipJ41Uu3UqScOJklIPJmiPIV5nD41KT78eWfiItA7EkRDjr+qbxCIx3U/yXP4OnY1eydXrWs6n/l5nhqchtJN9El2GXoz/bszpqtxg0kZarnUJ+brA7l9U3NolyD1WSaLlhwE+aMCtvkswh6fIXF5BRH49PvqbFYWD2tSRUAWOg2AuRrc0L4HlECIN1EZxiOQUZnqp9Vr5sMg8GRSEYTi0jVkJyq2msxTQqikFJDvnu003x4e+DTh5W8Q4q4FK2d4dglCk/dz12kREXKiULWzQ4mVtaDF4h+A0WuWsp76SZmtw
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 07:59:48.5125
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6834d94-0b7e-486c-7bff-08de83fb2943
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9487

There will be a bit more things to free than smmu_domain itself. So keep a
simple inline function in the header to share aross files.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Acked-by: Balbir Singh <balbirs@nvidia.com>
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h     | 5 +++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c | 5 +++--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c     | 4 ++--
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 24894b1630045..cfbedb76c8baa 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -956,6 +956,11 @@ extern struct mutex arm_smmu_asid_lock;
 
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
index 6097f1f540d87..440ad8cc07de2 100644
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
index 117979c96b762..375f2143efc1d 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2559,7 +2559,7 @@ static void arm_smmu_domain_free_paging(struct iommu_domain *domain)
 			ida_free(&smmu->vmid_map, cfg->vmid);
 	}
 
-	kfree(smmu_domain);
+	arm_smmu_domain_free(smmu_domain);
 }
 
 static int arm_smmu_domain_finalise_s1(struct arm_smmu_device *smmu,
@@ -3427,7 +3427,7 @@ arm_smmu_domain_alloc_paging_flags(struct device *dev, u32 flags,
 	return &smmu_domain->domain;
 
 err_free:
-	kfree(smmu_domain);
+	arm_smmu_domain_free(smmu_domain);
 	return ERR_PTR(ret);
 }
 
-- 
2.43.0

