Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2060.outbound.protection.outlook.com [40.107.237.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130B7238157
	for <iommu@lists.linux.dev>; Mon, 21 Jul 2025 20:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753128317; cv=fail; b=dPxF3Vxun10HZw7gG4c0UBNb1gwAIhyHScWVmLfre4r8j8jShC10OZRWXT2mW0mrLFG3iGyVjkzGjkMFHF194sLZrm0D50SVPIXTSz5T0ypdxu2E13+z+V77c9HtrhQIevthCZ57SLOxl5P18GlXP86snwdmpNwXKNW7l+8KD8o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753128317; c=relaxed/simple;
	bh=ywTG86zSrSJYynn8vB7qKILrKKYyCO9vbtvcq6KU9bk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Py6ng8pTVcjo03XVVAUpxAmTP0+l0P8nFPj8AQg+FZ6lanTJh7ZMtwZBQiXAparl3vEHF3wP4I2LehmJ0YJTO1r+2VFdxsXngxeGq5iXtbOiQpzm3pqReLRkQEmQ0rTVNCkc6CDI9EKOtJBxRUKDvbGzCdQZQ3qY7t2ZB02YJWg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=S1WXuieg; arc=fail smtp.client-ip=40.107.237.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="S1WXuieg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wSth1OjPGwC3p4k2pp9O91vLpqsRj47OjkuU97AF0TkQoUqhX5DX63FsF9wBy9UFE2PY8oBRpIQbd99VX0uB1O1K0q/2amDvThGePD4YDFjvfS9VvBL1jrCk36fKRCOFnWjrRFR2C/rEKmi+nCZj/T9f57ytmKBTK6W9YAU7vPzu0Uugg+E5PIJgfJAhUepqn12yJyemdXkuG4rs8BOvPC419oBauiaZD25+8YqmX8a6gxXHVzRBrw3CqAO0+eih52NAnC/PdGMtUdcuFJWjrvLLwppt4yAJbBWkKXi4yeZv34kcuDQOCCUIEkiD8MmVaOxSxD7+mw9qwj+RtmIbdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FHiXigxA4hCOXWGH/DtJQxOyDx/fKf4nLlz61cNzowI=;
 b=XrdgVv04FuDyH7TB3ugvhQSgj72tugGAcbRfCvYrlJMcp1xXS9Hd7wA5g8t3zIz7dVXtlQ2NaGC+3TRWGHxr9TrzQy4+biKQliuo9NP+rzGUHtSTD5ZVCsnrLhUHME8uFBIjnlWuk7GKs4wd6+BpPs3/p244NXCt2A+HdrHyON/0sFx4LnNc5MKToVsYN61+qn412D1zNSQ9oCtMvUznSnNNkoYQDZGxRXuFx8yVEls80udR/ZBI33bW1bDVmC0pf5VdPvQTzwsF6CVOd58lRplgXd/xDJPedhAYhuKxmS2B2CNUFqKtdBrwL36GQr+kiv7KgLsmLtlRLJ8BH0rSKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FHiXigxA4hCOXWGH/DtJQxOyDx/fKf4nLlz61cNzowI=;
 b=S1WXuiegG5c/BiLbgig57ddB8c3fjDmSSyoDLtei7oPTTc4pqW8KOj0INDH2EV/VnB0gGRYNbuHbvz0wB/ebdyRI+QvBUXsheJRsvI4DZXw8pg5cJuVjttvQl3sEGy0yjYzP/MVPWknCEsYvUy2ybPad+vmiJoa4/3MBvSIFuqhztycWkHZaj3xnl71E8ooa42JTAWK4tAIS2eDUSz1B7/VIz3OiRkBiaBShPcx6Y/U4MYnKJxXuRwZxqB8GF7qVqid7J9QRd04dq/A76zZCUeflPC4avP4GXJArI47YAtmd4YGTQkb7dup1VCkDuD8avX1XR1aUioSpeC9dZWfiTg==
Received: from BY3PR04CA0027.namprd04.prod.outlook.com (2603:10b6:a03:217::32)
 by IA0PR12MB8302.namprd12.prod.outlook.com (2603:10b6:208:40f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Mon, 21 Jul
 2025 20:05:11 +0000
Received: from SJ1PEPF00001CE4.namprd03.prod.outlook.com
 (2603:10b6:a03:217:cafe::e1) by BY3PR04CA0027.outlook.office365.com
 (2603:10b6:a03:217::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.29 via Frontend Transport; Mon,
 21 Jul 2025 20:05:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF00001CE4.mail.protection.outlook.com (10.167.242.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8964.20 via Frontend Transport; Mon, 21 Jul 2025 20:05:10 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 21 Jul
 2025 13:04:56 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 21 Jul 2025 13:04:56 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Mon, 21 Jul 2025 13:04:55 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <will@kernel.org>
CC: <joro@8bytes.org>, <robin.murphy@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>
Subject: [PATCH v3 1/2] iommu/arm-smmu-v3: Do not bother impl_ops if IOMMU_VIOMMU_TYPE_ARM_SMMUV3
Date: Mon, 21 Jul 2025 13:04:43 -0700
Message-ID: <20250721200444.1740461-2-nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250721200444.1740461-1-nicolinc@nvidia.com>
References: <20250721200444.1740461-1-nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE4:EE_|IA0PR12MB8302:EE_
X-MS-Office365-Filtering-Correlation-Id: 8269c930-69a4-4de8-3636-08ddc891e5c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HpHcjZtL+mh63H1PBhEic48MpRd986yDOEOaAF2kfnqlk71gilB5Ep/DirzU?=
 =?us-ascii?Q?jwX5AT+j8AA6fF4ikdbSssb9aFu3uYkYAvnLkzsgOGYLxJ8s+t1/W3P6fvtC?=
 =?us-ascii?Q?nBMDFYMy0lbtc8vxgeLTz0GWRUt6/3bAtrGl7IQq9Uv/sqUNSpiXDcQVejYI?=
 =?us-ascii?Q?ikIdWMtwiemFCWN8SJ/do4upJNyhcGUOD5f2ATt800nl9z15P1+1+97AuNdc?=
 =?us-ascii?Q?3WBOoefywHSYnuIYYekypu7IZO1fD7abYx9gHlYa7rCGx/iI2c9DAXEdCWRO?=
 =?us-ascii?Q?Zgx1qb6OxZqyC6hMClt/ZTMVWQ8rxwVqFGxu2ULjvJfHBNP+0n/0PYAbdDIJ?=
 =?us-ascii?Q?xb7A1Z3D/MBxSAfYmWOforg2ADlDwvGNN1Z9qG6FaLGcY049/F29YY0924Yj?=
 =?us-ascii?Q?Pz3S6fcmjLJYjdCWzqMktUuvb3IGzW/cEuTtII1PEUQsO3pu6VgH+GaGmXYa?=
 =?us-ascii?Q?n0/Cz6O9cCSXmt5OSLTnJhYGrka9Ao9GczzwCmkoVbd8ErOU4DgU6wv4tnPw?=
 =?us-ascii?Q?pO/R79pt3baRC6xR+KOI0K5YvzZBAkyFuLbwZ+/fxi5t79njRWCyf+TtGIA+?=
 =?us-ascii?Q?JmhffHlDQ8YXP2T/FLpWKUhTCxXXIqCFaU4UT9OLalE6bIYQqNayXLKrdRyA?=
 =?us-ascii?Q?Pe2oNIGocQ93c6HVlhxWcO+3hX+vSdhnRhyUwUGG+PwUICrK628yVsXahEK4?=
 =?us-ascii?Q?WRNozTBGjdJfVFKy6CYK6GO2QvNodDckcxtv+65LhGo3sx0r9vkH09N49GWW?=
 =?us-ascii?Q?MXRpgvb9j8c87S1Dv+04DtTiYOZgvlNktRrCFN6FHG1FPLHDFBI/YSw3wPhs?=
 =?us-ascii?Q?CSW7Iu634dyIhT2WdNs79hpUVkSZYZyUFjbEVSZIvuu7/nxPt/QBVqGEgQWV?=
 =?us-ascii?Q?82oeSjFw5rCFsHmIULH3PCRNrpISaQG6PNIujgEVGmiNh56LMSAh475VuybH?=
 =?us-ascii?Q?NqEOCGHhZHAZuz3iBp8hoQZ7mhJXM6CeZnhj1rYKtl5YdP+5rCyIZLtx9wOT?=
 =?us-ascii?Q?PbHz4etC/yt3hNfgRWlQs8DwJYnWkDyDoPeZJipnblgtWUEzYvj25O231Js/?=
 =?us-ascii?Q?pBH7TovPNmGbsKAFJFtNTLKjOlFdTJyoe4TmFNtth7Go6Z64jdQIYSLE2SSD?=
 =?us-ascii?Q?ysWJgotyLx/ZubjWYxHyE/vWaSGkHBrq7LM6I/sJ0pUTFW80d1O1nmcSXi5O?=
 =?us-ascii?Q?s3qURR4yU+iiGYBzvxh+E+3jxcxFKXExCIJG+fDm4Mr1ui4JNa3lzE/IY/SR?=
 =?us-ascii?Q?nvRKyzh0NaYC3MxTmajxVtkNgeybO4+dxgga/L7tI0cjA+NZcq3jLyuDMxBa?=
 =?us-ascii?Q?5PhTwwwg5jhNO+zM0rO8gPC9Y5W3xCooot+rVWrN2+tKpI0dMG3PhZ9Y+vz3?=
 =?us-ascii?Q?NWGqlgpvuIpGGYXrMJNu8yRIxLhctkwqm6w4JH09gNlD4W65U2A4sUWpiCLT?=
 =?us-ascii?Q?YozMgUw2Hsy/iZjvmqmfJQmxuIEYBHvRYGkSid1k01USBbmKlZ5d/oa6267H?=
 =?us-ascii?Q?VB428SFfe+JQO8fZkc3dS0M6NfBxnB23gK42?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2025 20:05:10.6999
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8269c930-69a4-4de8-3636-08ddc891e5c5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8302

When viommu type is IOMMU_VIOMMU_TYPE_ARM_SMMUV3, always return or init the
standard struct arm_vsmmu, instead of going through impl_ops that must have
its own viommu type than the standard IOMMU_VIOMMU_TYPE_ARM_SMMUV3.

Given that arm_vsmmu_init() is called after arm_smmu_get_viommu_size(), any
unsupported viommu->type must be a corruption. And it must be a driver bug
that its vsmmu_size and vsmmu_init ops aren't paired. Warn these two cases.

Suggested-by: Will Deacon <will@kernel.org>
Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     | 24 ++++++++++---------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 14 +++++++++++
 2 files changed, 27 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
index d9bea8f1f636..c034d6c5468f 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
@@ -420,14 +420,13 @@ size_t arm_smmu_get_viommu_size(struct device *dev,
 	    !(smmu->features & ARM_SMMU_FEAT_S2FWB))
 		return 0;
 
-	if (smmu->impl_ops && smmu->impl_ops->vsmmu_size &&
-	    viommu_type == smmu->impl_ops->vsmmu_type)
-		return smmu->impl_ops->vsmmu_size;
+	if (viommu_type == IOMMU_VIOMMU_TYPE_ARM_SMMUV3)
+		return VIOMMU_STRUCT_SIZE(struct arm_vsmmu, core);
 
-	if (viommu_type != IOMMU_VIOMMU_TYPE_ARM_SMMUV3)
+	if (!smmu->impl_ops || !smmu->impl_ops->vsmmu_size ||
+	    viommu_type != smmu->impl_ops->vsmmu_type)
 		return 0;
-
-	return VIOMMU_STRUCT_SIZE(struct arm_vsmmu, core);
+	return smmu->impl_ops->vsmmu_size;
 }
 
 int arm_vsmmu_init(struct iommufd_viommu *viommu,
@@ -447,12 +446,15 @@ int arm_vsmmu_init(struct iommufd_viommu *viommu,
 	/* FIXME Move VMID allocation from the S2 domain allocation to here */
 	vsmmu->vmid = s2_parent->s2_cfg.vmid;
 
-	if (smmu->impl_ops && smmu->impl_ops->vsmmu_init &&
-	    viommu->type == smmu->impl_ops->vsmmu_type)
-		return smmu->impl_ops->vsmmu_init(vsmmu, user_data);
+	if (viommu->type == IOMMU_VIOMMU_TYPE_ARM_SMMUV3) {
+		viommu->ops = &arm_vsmmu_ops;
+		return 0;
+	}
 
-	viommu->ops = &arm_vsmmu_ops;
-	return 0;
+	/* Unsupported type was rejected in arm_smmu_get_viommu_size() */
+	if (WARN_ON(viommu->type != smmu->impl_ops->vsmmu_type))
+		return -EOPNOTSUPP;
+	return smmu->impl_ops->vsmmu_init(vsmmu, user_data);
 }
 
 int arm_vmaster_report_event(struct arm_smmu_vmaster *vmaster, u64 *evt)
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 181d07bc1a9d..9f4ad3705801 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -4703,6 +4703,7 @@ static void arm_smmu_impl_remove(void *data)
 static struct arm_smmu_device *arm_smmu_impl_probe(struct arm_smmu_device *smmu)
 {
 	struct arm_smmu_device *new_smmu = ERR_PTR(-ENODEV);
+	const struct arm_smmu_impl_ops *ops;
 	int ret;
 
 	if (smmu->impl_dev && (smmu->options & ARM_SMMU_OPT_TEGRA241_CMDQV))
@@ -4713,11 +4714,24 @@ static struct arm_smmu_device *arm_smmu_impl_probe(struct arm_smmu_device *smmu)
 	if (IS_ERR(new_smmu))
 		return new_smmu;
 
+	ops = new_smmu->impl_ops;
+	if (ops) {
+		/* vsmmu_size and vsmmu_init ops must be paired */
+		if (WARN_ON(!ops->vsmmu_size != !ops->vsmmu_init)) {
+			ret = -EINVAL;
+			goto err_remove;
+		}
+	}
+
 	ret = devm_add_action_or_reset(new_smmu->dev, arm_smmu_impl_remove,
 				       new_smmu);
 	if (ret)
 		return ERR_PTR(ret);
 	return new_smmu;
+
+err_remove:
+	arm_smmu_impl_remove(new_smmu);
+	return ERR_PTR(ret);
 }
 
 static int arm_smmu_device_probe(struct platform_device *pdev)
-- 
2.43.0

