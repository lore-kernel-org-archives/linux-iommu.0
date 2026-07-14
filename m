Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012001.outbound.protection.outlook.com [40.107.209.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0195C362133
	for <iommu@lists.linux.dev>; Tue, 14 Jul 2026 18:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784055004; cv=fail; b=PiRGQIH9CfaEIu/fDgv2raDX5eeLpBDypSm81cu1rD7elcmfhKenv+vQZskX5AHtMyQKtiQmFZEBLxuPz1n2eTFpuFSgh7Avut7uOj/NmhnSKD7yQruNpBbufBTvNTbOUhNAHJTLEn8zm1AzKNiGbPGJPNv2HW/r4feM2ziB2WQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784055004; c=relaxed/simple;
	bh=cBjNTS5koAe6CN8cv2RkXif1EYixwbXYUCAeomXoUM0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WS03XTqfaDnUDgvNlZU7k0ZLtgXqbIca5oLX+qreWBnBJYzNeW35V2npbDLrAQjxIH2Q6M9Jn6+yMvI9c5gfMlVDQvnjrzx+J45EPfNarySvtSPa2FmUy6WlzxDpd9TkmOvBGZxRTZTf/4G7JSHn3uqXfh9bFijXXL0OLYdGzbw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nXIyteNU; arc=fail smtp.client-ip=40.107.209.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nXIyteNU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mwyV3AwuzBp6ocJZIujh4IgeLLrGungDUCsHWNWzMCdIE9lHSvXmcxXaKx9pjmHtMvw/HHZ4qf5sk2/2eW0dxIwGAJD7Ot9CZ96lCCeSypVKhwjEyXqQsCkYKbBjUkcZ0wcEMSqHLIwuiKYuhfigRaMclivaLH23vXGkvDQs1EI2+emu3trsstIVZgfDYIDrZEr11tHL1+gn2A7oBGYIjbBxjOmluuKc2FUCrPw76I5lijyZFg0ES2ZxpuWdgsgnfkcaiQ6X/YGAA/tZZjcNdlrBooNno1HrO0ej4dqh5QncUuVk5HRDL/J2xxtv1ROCPstajrT1/UXs/ll7flQE7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+txxj+KWXXmT6H2jQ01XkaPRn0lJYJLwceJWiWnCf5s=;
 b=zCpImNU3ahEP3v8/APvdbmZW4u3WnlPmlVRKOEZP6qtVo3gyLyibvYeHxvCXa4wqS4idsqL77VT93VjFK3D7+NqdBgKip0K7en1UkoF2IWGF0tPfMgOBMkjgVxmLsmF09/KJBy39VVtWjHXZyQrUzhSRV3sVpBHbbodEgFlfVUpIr1Mag4aqzfGs9zaZraVKMpobqwY7pHuO5lshhEMQhrDGldkFlpVvjfjRRU4IG6VGABIIb8dSX7ISR0WrXqlNsKsVK7jYhSaBk7z/36YshKLkABNh0B8qYjqLmTm4Qmy2ug/72Rr63bwKjiF1e/ERHgj9a1iu2c1eZy01v25x7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+txxj+KWXXmT6H2jQ01XkaPRn0lJYJLwceJWiWnCf5s=;
 b=nXIyteNUUham8BDLlSvX+oOqzb0A80q6k+D33mpEVVkWNNMId08duABxP/ZtEZXTjJTEKgM8OeSLC4Qm11Vwu2F5YtedjkKerBWDjAjcALvER7fpJgoYBK9E3460rTVxDJ2CXUXMGTt3kM52xSA7Kb7FkMTkynV4qamMv8dFuHqKXd0O4auaYdC6UfOqn74OHrOc63/GHIEjWEr3Smp4KLLiXMedGx6N8Vj58Wx2ruDY9cfZHphCdllMlhIYibn0CLRZSeQpZv8ZG+5ikMG0nxgGtKXWlx/UYVz2xtCG6aiP0Acf4em4T6tgLbWeXL4JnkrJMWfsJxbM3nFVd48AgA==
Received: from CH0PR07CA0017.namprd07.prod.outlook.com (2603:10b6:610:32::22)
 by SJ2PR12MB8807.namprd12.prod.outlook.com (2603:10b6:a03:4d0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.9; Tue, 14 Jul
 2026 18:49:48 +0000
Received: from BN3PEPF0000B372.namprd21.prod.outlook.com
 (2603:10b6:610:32:cafe::a0) by CH0PR07CA0017.outlook.office365.com
 (2603:10b6:610:32::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.10 via Frontend Transport; Tue,
 14 Jul 2026 18:49:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN3PEPF0000B372.mail.protection.outlook.com (10.167.243.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.3 via Frontend Transport; Tue, 14 Jul 2026 18:49:48 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 14 Jul
 2026 11:49:21 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 14 Jul
 2026 11:49:20 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 14 Jul 2026 11:49:20 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>, "Kevin
 Tian" <kevin.tian@intel.com>
CC: Robin Murphy <robin.murphy@arm.com>, <joro@8bytes.org>, David Woodhouse
	<dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, Pranjal Shrivastava <praan@google.com>
Subject: [PATCH v4 5/6] iommu/arm-smmu-v3-iommufd: Convert cache invalidation to the core array loop
Date: Tue, 14 Jul 2026 11:48:51 -0700
Message-ID: <4c85d0d43e9871b8dc8ea8e393210bd62654c0b5.1784054606.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1784054606.git.nicolinc@nvidia.com>
References: <cover.1784054606.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B372:EE_|SJ2PR12MB8807:EE_
X-MS-Office365-Filtering-Correlation-Id: bf0ce9c5-ab9c-4b8a-76d8-08dee1d8ae32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|36860700016|1800799024|82310400026|3023799007|18002099003|22082099003|5023799004|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	4ASyleA9Et1lt7YVKw7230cn4Gw6DoPm6mS3ANE5T6B5hnbg8QGSeBL9ZPZO0Fd7jgQI59ItO3nth3OLgu6ZImd06eONrsLKKNObGmualjaOEB9wvmFsP2zkeZUVFDdqzDpoo50VriEHmgN8Q3So90tU3c26vyhICq4lBvh35+IgKaBQA9qPLI6un39BjWl6ksXzV0PJR9MJo8nM14GNWkMN84XdWRJiRWVcnOOyXZmfKMyUB5CMsytvLCr56ZxbWWjIRGHLva4sZSJW7oMucHAndWDZ5OuGoUP79tf4/6b+KLO9J+VH/QPnmItKMH7Xxy3SY0NQpK0T/y51XEGWnes7phByb6JUDCi1IoGUbYo2ILWOYvgRxHppfAFbLqzoGFqX+/3zZqU1UhTgb+uk2oG6O75maYRZaA6JwGk8W/Tvkho7/wD/tXAlXCL7YZte1E89gOyeQgdsUgkSv/B97WpDdvV9RZqfkflIsmAPMkKuU8BQ/uN6EJPaDPj/8AsJc+ubD9blOlyDA/WrarPQ+jYr1AzP0kfYOdnOhNWTlZK9NpQdGcO3erfQbjqC0zfSlXbWTjroIJN+6JW9N9JmMVCXjRKvT959vB+65ffNBHZzMcxUTom88EnpIH9/zgO4I2LKk3yB5mVpFsnVfmJUgL1V5eoUMrFE7ozUqWFu97SOUXVJVzLP+tdP0/kdEvgufEj17Hwmki9PQQW+fIEUCw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(36860700016)(1800799024)(82310400026)(3023799007)(18002099003)(22082099003)(5023799004)(56012099006)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	/vXIoGjS/Ebhy286vfcPOCaoxLh4raAQHeGQwtXMeL8AghO7zHaJalGIPCGdvCah+8quNPm1rIbQtJzMVCPwdQrLrZy7xQ507W0soZKqmwVvd0UKsFYQCxe5BZ3U9u8ujPMKY89rIQV6Vb05EU9De3N/T0JyBukts/cZI1f7KqIJiOZB5e5WBvCWoh9OfZ+vzDPYd39LYXxyjw0KgT5Y3f4k6JWCRuvONToW/I3LMPHSsNONTcfCnVGjkS4tfOBrfxD8/Bqm4H07LFDUeB/dwYEIm/R9wkReYUCvtIaVktUBWzwQtOsbxejUYt+jAGsO7dZBi2L+2+1tTYUSMHdmrxtWKaqhAqImAFG+EZW7FopmpjcG0dqfiJTVSgwb1I6h3WJIetV+AZGze1WrwAaxWDuVrim2fLETigDwDsPG1TsrVpc2lHoLZZYPeYZTd4co
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 18:49:48.3110
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf0ce9c5-ab9c-4b8a-76d8-08dee1d8ae32
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B372.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8807

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
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     | 68 +++++++++++--------
 1 file changed, 38 insertions(+), 30 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
index 07e502879dffc..42a3f30b9f3be 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
@@ -457,49 +457,57 @@ int arm_vsmmu_cache_invalidate(struct iommufd_viommu *viommu,
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

