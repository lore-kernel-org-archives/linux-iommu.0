Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010044.outbound.protection.outlook.com [40.93.198.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3CF3BF66B
	for <iommu@lists.linux.dev>; Mon,  6 Jul 2026 18:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783363674; cv=fail; b=CQxTWogCvIiU5eSm+Fe2ImgaylbIfE/NHMZvNjVHeXsQDdcfDdX9m0+9YHDeopJRFNPNhWZueOU7+1zs82KZR0TYV3vVHIH088kabAtveJD2lLT3BO7REsc2TOBy+esFkAdTXOFykS2liw/QOh7MBmiA5RJwKSSC7bSJtrQYzZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783363674; c=relaxed/simple;
	bh=l9HfjUC8KQ7dwCKB92nJRd1YizpiLnMqdDAP3y/Tu6I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e5ks09zgm13FA6HUTuvuC1anciUsd+HzwLcyCvUKE2hr98ZiS6RbjiierF5DQSlMJ3G4c0voiq7FJyKjzJsrVs2C9MbObX5+AQ6xzQ0cRhmcBYr95P2lEa2+46eRGUjBuz4WMWnLjfsjKW6k2M3jA8dynYiYfZHOLxv5gWJ4Tfo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rypfSVd/; arc=fail smtp.client-ip=40.93.198.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rypfSVd/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ks1RX5Uq8MFgftgm4xBF1TYzN8H9noTSG8sX04lF8IA6OPTOiT5K0q4X74ks6tYx8PPSao25/2Xc89wPUjN2S7sddekvqKhc64ddTCxO6bvbkU9liDKRTBqKrUmE8KJlFje5AdmDT6kDBlbQEpIzE96HqSC9z8RZvOetbOgICv47ygCnkAmGptKy4APnCvin314tWiV4tSa07OYGpOZAcfKcXeWm+xP03OvNkGfq3vC05/nfANrnZQkZN90hoVLZdgruP2/GMqOydfkw7b9B06TAnsRkzpYilJoOCqIaoICEqDxoEjYi7qW55J3MN+QEJJRpKAC8ACN0+0sotFTOfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NOw0zYb2nK+fwsSQD1vwx2Mwc6HZCsgX0cHNurPXzdI=;
 b=aYFz+tQfSGarHegobr2f7be8YTTtgYhTiq+hK+sLDVf+VtwERL+vq/k9wAMgyKbugVEQtMtJ8WtKRCxUuw2Vah1WavEIRfdO0M0zlwZcR6OqjiTjWDvZ2LV1V0l8W4VQhDnf30Y4U1j7rKNh1Z2ycmwN3n/DtNl+S530DfnB/KMrvU9N60YeTmP5WoTBtdjn/fNvbTv12J1K5wrQ/8V7vYRhAKowo238zE5GrUyCxEAh3QF4h/zMbFmILXU7yl4vIeWqAqxaTUobMBhJl/SKUotyeGM44wTqU5M3lgp/Wy0nvx62fIOZMCR2HzypFaMNeJAW/ET8jdnfPBFwgyXs4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NOw0zYb2nK+fwsSQD1vwx2Mwc6HZCsgX0cHNurPXzdI=;
 b=rypfSVd/bYtmLnfioYfv5eYR+lbNBY6XyAsahjLKRIKjZ8+4wPjRSmij+2cJBu0pZu3v2C2SDrPDB6BRBH6WmjTd0pynglUx/5gd2nY/aNvPdkADlwXgNakDDbW+z7CnVMUQN87AFLpiTPr3x0GqCPJwQ0DBD7Boqy30St9HNvdnPQqRayc+9ylJW/Z7oRcfRdnuxbXYl+EunpXC0OM88Ui38gH58mPr4bZcf+67GQrq5OtkbvpPX+XU/t9ObgDwsoax0oiqr4dPwSNHjykbnyLWV10S31fPoomglwTK9EFhdaeQ1UDpsRwkIpYgpO2SFZnjqb0RL9T2P1BkbV60XQ==
Received: from DS7P220CA0120.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:25f::14) by
 IA1PR12MB7759.namprd12.prod.outlook.com (2603:10b6:208:420::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Mon, 6 Jul
 2026 18:47:32 +0000
Received: from CY4PEPF0000E9D6.namprd05.prod.outlook.com
 (2603:10b6:8:25f:cafe::3f) by DS7P220CA0120.outlook.office365.com
 (2603:10b6:8:25f::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.13 via Frontend Transport; Mon, 6
 Jul 2026 18:47:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY4PEPF0000E9D6.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 6 Jul 2026 18:47:32 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 6 Jul
 2026 11:47:13 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 6 Jul 2026 11:47:12 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 6 Jul 2026 11:47:12 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>, "Kevin
 Tian" <kevin.tian@intel.com>, Lu Baolu <baolu.lu@linux.intel.com>
CC: Robin Murphy <robin.murphy@arm.com>, <joro@8bytes.org>, David Woodhouse
	<dwmw2@infradead.org>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 4/5] iommu/arm-smmu-v3-iommufd: Convert cache invalidation to the core array loop
Date: Mon, 6 Jul 2026 11:46:54 -0700
Message-ID: <a83f2cd4145175860c842fd67711094bdc73d52a.1783363477.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1783363477.git.nicolinc@nvidia.com>
References: <cover.1783363477.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D6:EE_|IA1PR12MB7759:EE_
X-MS-Office365-Filtering-Correlation-Id: 593fb6c3-9c8a-4245-c39a-08dedb8f09d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|82310400026|1800799024|376014|11063799006|5023799004|3023799007|56012099006|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	JvNRMRSdmZLd8lY6gkdTZGJH9fSL04/0CUxIY/eyLeiSWaizHxchoLoB3C3dzGf6c2oCtcMkUCilXyhzmHUfJPyUWX1pZHRQqwYLdAPT3hCoUGJzFQT2kGYxvGyT+FFwQKTy//iXyD6fZhJLH9hTAJJR28kDp3sigbLx2iytZghCpBvpDoHT0X4Anf4IVSVv+GwNcdjYBXnhORxuYpouq5P8zFg+71rNS4e00eR2a3RMcA/dXOVigrRSjAPHfDLpRQlxkjThfiPqAqjdM6jy8jlGQZ8zPwMKY0W7Q8Nby0omFSzvUgE/d1lKXN41KXjYl1RU6FlhQVh3uQyTGeqrBR5iPpDtkTNEdj7dEdr0o3zgee2rwof98NiTpalawMYvZ9jTiOF3uY8BcA6xLvYliRU0OfCPdiRTmG0fC7X1PlgWJeytO67ZxzlBCi+Cr+z7FtUb7xkI6aOnn/sLLo+wNLt+6F3SxGcSXmrDj8gaddd84JcJX1TiDi0ll+tYkqqol2K0FXGkFoQCuTJE6mXk7Wx+svrzKP8NniV3b0VI5dhi+m6xLV4kzxVkh5ss591Z5hcnyzR3iyqT/BI/tp2EhGAbCqz6C60sZ7OL1R1nhhz56iu7tPUg0VbeIVCWui7zPH6RFsFTZUG/lF2+vS3T4fJrWKCvhkpyZ1213MXy/NuJjuT3d+I4wNWUjxjxMh2FuSSa6Z0cZcDhs4egesFtmg==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(82310400026)(1800799024)(376014)(11063799006)(5023799004)(3023799007)(56012099006)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	bJtnZyvHN3++jSuAjixlFNEwBlMFRpK3r/DMTV7eyVVBF9LVVDGm4qBmRvlV3QnERIr5dogSJlAUUj7dDth8T2e8yE5uwTF73D1pTTYiw8MnP11sMwUBcDCIU1ecWlbgzipASQjWjR+kru5U4tak70YONDyuHRRop3nJrIwQn1f3+CumtOYUmBjC2kV4ShKG+Pmy6Lo524wic+1EOufp6gMnX4kB4ik3w6CKoupe09J9oqynkgLtFz5Ayg4qEHWehMEd4vwar/olLetLhJg/oMi/bi2UnuqBxcNeRBFUkblWRpTD+9AzXTdzqQmMz/Hpl9xHkOzdMVjsolsKmwhodAisla+jdRan7nJFZrOrTgzpNO99VzZxPYKbY0X2zAI107RpKWr7KS2pXrRdxIv8FqG3783Oh0pjpu1u49kmoyrcJgX8Lxqt//ma0nCdL09h
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 18:47:32.3476
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 593fb6c3-9c8a-4245-c39a-08dedb8f09d3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7759

arm_vsmmu_cache_invalidate() allocated a buffer for the entire user request
array, walked the array converting each of the commands, and issued those
converted commands to the cmdq in CMDQ_BATCH_ENTRIES sized chunks, carrying
the sub-array bookkeeping all on its own.

The iommufd core now iterates the invalidation array and re-invokes the op
with the not-yet-handled sub-array, so the driver only has to proceed with
a single chunk per call.

Instead of a per-array allocation, use a fixed on-stack batch to copy from
the userspace array. If the copy fails due to nonzero padding (VMM violates
the ABI), fail the entire batch.

Convert the whole batch before issuing any of it: a malformed command is a
userspace bug, so the first illegal command fails the batch as a unit,
issuing nothing and leaving array->entry_num at zero, the same way the copy
above bails on nonzero padding. A batch that converts cleanly is issued in
full, so the op returns either a handled count with no error or zero with
an error.

A zero-length array now returns success once the data type gets validated,
matching the documented probe behavior, rather than the -EINVAL that the
full-array copy helper would previously return.

This also fixes two long-standing bugs:
 1) On a conversion failure the old code reported commands that it had
    converted but not yet issued, so user space advanced its consumer
    index past invalidations that never reached the cmdq.
 2) A zero-length array was rejected with -EINVAL, although the uAPI
    documents it as a valid request that only probes the data type.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     | 68 +++++++++++--------
 1 file changed, 38 insertions(+), 30 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
index ee68a13025cab..19d2849a5294e 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
@@ -443,49 +443,57 @@ int arm_vsmmu_cache_invalidate(struct iommufd_viommu *viommu,
 			       struct iommu_user_data_array *array)
 {
 	struct arm_vsmmu *vsmmu = container_of(viommu, struct arm_vsmmu, core);
+	struct arm_vsmmu_invalidation_cmd cmds[CMDQ_BATCH_ENTRIES - 1];
 	struct arm_smmu_device *smmu = vsmmu->smmu;
-	struct arm_vsmmu_invalidation_cmd *last;
-	struct arm_vsmmu_invalidation_cmd *cmds;
-	struct arm_vsmmu_invalidation_cmd *cur;
-	struct arm_vsmmu_invalidation_cmd *end;
+	struct iommu_user_data_array batch = {
+		.type = array->type,
+		.uptr = array->uptr,
+		.entry_len = array->entry_len,
+	};
+	u32 processed = 0;
 	int ret;
-
-	cmds = kzalloc_objs(*cmds, array->entry_num);
-	if (!cmds)
-		return -ENOMEM;
-	cur = cmds;
-	end = cmds + array->entry_num;
+	u32 i;
 
 	static_assert(sizeof(*cmds) == 2 * sizeof(u64));
+
+	if (array->type != IOMMU_VIOMMU_INVALIDATE_DATA_ARM_SMMUV3) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	/* A zero-length array only probes the type, validated above */
+	if (!array->entry_num)
+		return 0;
+
+	/*
+	 * The core re-invokes this op for the remaining requests, so copy one
+	 * cmdq batch worth of commands into a fixed on-stack buffer rather than
+	 * allocating for the whole array.
+	 */
+	batch.entry_num = min_t(u32, array->entry_num, ARRAY_SIZE(cmds));
 	ret = iommu_copy_struct_from_full_user_array(
-		cmds, sizeof(*cmds), array,
+		cmds, sizeof(*cmds), &batch,
 		IOMMU_VIOMMU_INVALIDATE_DATA_ARM_SMMUV3);
 	if (ret)
 		goto out;
 
-	last = cmds;
-	while (cur != end) {
-		ret = arm_vsmmu_convert_user_cmd(vsmmu, cur);
+	/*
+	 * Convert the whole batch. Sending an illegal command is a VMM bug, so
+	 * a single one fails the entire batch, issuing nothing.
+	 */
+	for (i = 0; i < batch.entry_num; i++) {
+		ret = arm_vsmmu_convert_user_cmd(vsmmu, &cmds[i]);
 		if (ret)
 			goto out;
-
-		/* FIXME work in blocks of CMDQ_BATCH_ENTRIES and copy each block? */
-		cur++;
-		if (cur != end && (cur - last) != CMDQ_BATCH_ENTRIES - 1)
-			continue;
-
-		/* FIXME always uses the main cmdq rather than trying to group by type */
-		ret = arm_smmu_cmdq_issue_cmdlist(smmu, &smmu->cmdq, &last->cmd,
-						  cur - last, true);
-		if (ret) {
-			cur--;
-			goto out;
-		}
-		last = cur;
 	}
+
+	/* FIXME always uses the main cmdq rather than trying to group by type */
+	ret = arm_smmu_cmdq_issue_cmdlist(smmu, &smmu->cmdq, &cmds->cmd,
+					  batch.entry_num, true);
+	if (!ret)
+		processed = batch.entry_num;
 out:
-	array->entry_num = cur - cmds;
-	kfree(cmds);
+	array->entry_num = processed;
 	return ret;
 }
 
-- 
2.43.0

