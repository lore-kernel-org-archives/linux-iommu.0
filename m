Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011000.outbound.protection.outlook.com [52.101.62.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC283D6493
	for <iommu@lists.linux.dev>; Tue, 28 Jul 2026 17:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785260069; cv=fail; b=lpGiI5IbKppQPUsZOjmUyUj8dfEWLP+BvKJu517+uhm2BDDCeXk3AdB0ncEP7mr8bDeBRYXG98Dxp1miXkfzEeh+bKMBH58ASa09tf1aOgWweYfCe57XRGBTYzdm0viK/CfW5ubm0H4bvR4Cae2CGLuOwQ6HynMmDKMDGkVbgxA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785260069; c=relaxed/simple;
	bh=3oMWp++uxNw97r0by+/m3qvUiGujEPkLZRMDgdR4D2o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ts2b8HJKyA7dFVUAI/g7EImgCzXYtPtsjRmrfm84JPuzfblcQH7piPd+ViY3baG5kxrReq9PPwy3/dO/mfbfCxpu9J26QnOsTW06XJD3fKuauFvo+jdfU1V3YuhhzfkIKSWxpT5xvCQa9JmdujAZYoQYqDm4C/CHEhlFu0+6XBo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nh5lrL2X; arc=fail smtp.client-ip=52.101.62.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nh5lrL2X"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XxmLzCfDv3j0Hm8VjOX/BpnTsrL1p2Vk1wLW9oLNLVeqjOjS5KKvRBhX6yBYEBm/obdNGc67cqYJObwQw/+bJXrS4kCMMgA0fqjkOSi+zBfpDMJdOHZLo7iCbU4I1fsX1ftvu5scNLXeRFbnhapcFKkgPtK30mMIC51X1TtWrjtD3NkfnzGfsUxMaaV27BHTk7LBTlXFwl1RJtohRujuhyIHvEVrbJKaWifmgDxl3O1wm0jCYqSeWnJfjCFuCX6igaVfhVk2xCR8UdzgzkGUDdjDa94RemqJTNosfTZlQ8zW35P3GxbgIQidZDgngoLvUn2xOXuXDBYagsuX0G8LjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GBlTITtmnme4113wtp+Y7xVcxy6NM90GuGnNQs3ctHI=;
 b=qwlCL4zZ/G5g8ZWXR4H/rbGYHauBG/2WD5sB4Ww9AKjiZcPvv1VZveRrkDVEAzkNX+jysj+/NVJj8CRKBdfPG621tdBOQbAgjKBrMM/ZPUgzji+jeUHcWbQNOk/KDbJX0AvKWRkrqmhmWOUOu8ss3bQ+0vZ7hQ/A5uWe4cjG1eZqBb3MKZtpeUn/CyZ9L450fuL4vzaWDMb6BzozDGAaTHOX+fVMnzLTgstXQ1643bb6BmV3hjc4Y0eixa1b6F4paeaQJ9mMFEHFAW8ki29wAOOM/MZmWFbBH3JUnAe4CmGLxIVvbeXH4fTbmmnzlYRyacBMUazW8cp4YiriCFPpcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GBlTITtmnme4113wtp+Y7xVcxy6NM90GuGnNQs3ctHI=;
 b=nh5lrL2XzbKA45IDPFM3gvh1toH9CQbMMXSfYi+Fbg2V0+TbQVjvlVGjvjVa338F5kTaWlKcoKCmZx+m+0Q41E1WZE9NSSjnTcyIgy+vqyCpHU2zDFQd45zTBjcoySofj7/TJy0CIuCrQuJL1/4gMqgFvixaF1rir4v6VCncy2lkDslBsobAR7XM0dzkrwddMBS1bXVqd6pyiN/kxkz7Ci++WU9c26iCw5rhUCPsc+1MYjKIlEQuvixZmzGWGsk9W9xATR2xzdsUJuwWbWoG/7jrVELufwwn7L4JwsgQZNJ+Q2L+aqF/67nmetx0PuicJarNrrvzrRcWVxYYU8bMxQ==
Received: from DS2PEPF00004556.namprd21.prod.outlook.com
 (2603:10b6:f:fc00::510) by LV8PR12MB9451.namprd12.prod.outlook.com
 (2603:10b6:408:206::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Tue, 28 Jul
 2026 17:34:15 +0000
Received: from DS1PEPF00017097.namprd05.prod.outlook.com
 (2603:10b6:2c:400:0:1007:0:5) by DS2PEPF00004556.outlook.office365.com
 (2603:10b6:f:fc00::510) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.7 via Frontend Transport; Tue, 28
 Jul 2026 17:34:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF00017097.mail.protection.outlook.com (10.167.18.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Tue, 28 Jul 2026 17:34:14 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 28 Jul
 2026 10:33:51 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 28 Jul
 2026 10:33:51 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 28 Jul 2026 10:33:50 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>
CC: Robin Murphy <robin.murphy@arm.com>, <joro@8bytes.org>, Kevin Tian
	<kevin.tian@intel.com>, David Woodhouse <dwmw2@infradead.org>, Lu Baolu
	<baolu.lu@linux.intel.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>, Pranjal Shrivastava
	<praan@google.com>
Subject: [PATCH v5 5/6] iommu/arm-smmu-v3-iommufd: Convert cache invalidation to the core array loop
Date: Tue, 28 Jul 2026 10:33:37 -0700
Message-ID: <3f8da1d7073219ac6f78045d4942e19c55252cb4.1785258826.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1785258826.git.nicolinc@nvidia.com>
References: <cover.1785258826.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017097:EE_|LV8PR12MB9451:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e1cf7d7-9294-4476-2827-08deecce71ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|1800799024|36860700016|376014|23010399003|6133799003|5023799004|56012099006|11063799006|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	wlHYkWIk3kWD3cmTBx0XkDlGh7rG/aIlVlHhyx1OmGxCxS4UNVU1u6RRQet8uPe+7dzdPJzG2fFX20fWR6eHBij/Cxotn6g1BxCwuD6/WCbiRSLnKBShBR3Yw6yTS5CO4hsv3PWMR0Z9qTztp0yoXy6iqbBctBm0dXSB5em2KdMd6TVkAQ0xK7yILhP4aXLDLlLTnV3OWOgVf6HwEkUjDC4g1hIR4a5Lrq//CQSAx+dnxHiPh0iz+oJ/NU3BFWNcqeMquuE1dHP4PT/0cVkcyt3UKPi+4B4CAK8ciePXDPaXCtqXQUgf5q/7ziR3fj0ntBkaRREqMGi+yy3OKOwjsUR+1xpkgmirWJUHglpzX/LdYlOtk/WoiOlyv5KuLDDAot+1TtpWOz0vsGUaaiKAE9jMCK+gzazXdsLlE9SDS3H6o4E+l0LRJtq9fxchDCIo0bOmJIpWQX6v/gJe6WYbEFfaGoD9bKPaEdzcbjNJpXT0B3zCwvcsWmGTdRbzBuUuvh+SYtMg+0XGr2AqJX/y5FelPer76i25ICi68Z3KoSQFDv+Yb54GoyqMoi1TvgNLGV+PtLtvL3INhQRUKfWI9We3Uor0ff8Vli+imiCg9uDnRCbcaIbas5nu/k2XPDlnP0N044MAvC3CuyAI3fKoF5ffU8dKYkmobz5eBXUHdO7iDE54oXXD8rtSbL4oAC77fQjOScsxKQx51hWUgOQChQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(1800799024)(36860700016)(376014)(23010399003)(6133799003)(5023799004)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	LvcRrlHpCTkGpp4HFIfTYEzvdW/WtjBX347CCiloKNVTUN16/uLLj3ddEYrUyLYl6MciE4Y5ZkbuV1leHG9Sb8voIJYMTLCZHSDWkFQ+TAVL2DXCybzzMsQcqKb6M+PQoo6bJfgULGB6Kj+obNjgBq+Q93TARIFs12ZJG2GlkvAC8nhD4tm4s5aFzHRfzDResBozONHLrdvcJK71l3Wzeg0s9tPBFCgsmbDWlMeEg1DsLUNb3kFne2PalunZvFzRGFvJZlTcd3S1XS+cGTTuGleCz3suMO6GtkjeOKGX7nf4Sm+VzLsLLevdvI7oTaBHVqR7n9hiWAlhgZr3+qSAKHugOgRHYRXn9VcEtcxZ0zp8w1WTaLAsC1hF3iwLzWtuzeSLWpfD+Jbpg9Lme+ApNI0hVtNhp/38I4u/1oK0bXfdKgiDveQTpnxk8RREw0JV
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 17:34:14.8516
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e1cf7d7-9294-4476-2827-08deecce71ce
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017097.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9451

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
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     | 68 +++++++++++--------
 1 file changed, 38 insertions(+), 30 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
index c76573c65f80f..221883e20658f 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
@@ -464,49 +464,57 @@ int arm_vsmmu_cache_invalidate(struct iommufd_viommu *viommu,
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
-		ret = __arm_smmu_cmdq_issue_cmdlist(smmu, &smmu->cmdq, &last->cmd,
-						    cur - last, true);
-		if (ret) {
-			cur--;
-			goto out;
-		}
-		last = cur;
 	}
+
+	/* FIXME always uses the main cmdq rather than trying to group by type */
+	ret = __arm_smmu_cmdq_issue_cmdlist(smmu, &smmu->cmdq, &cmds->cmd,
+					    batch.entry_num, true);
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

