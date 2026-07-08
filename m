Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012058.outbound.protection.outlook.com [40.107.209.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF25A3D0918
	for <iommu@lists.linux.dev>; Wed,  8 Jul 2026 19:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783539902; cv=fail; b=sUohbLsduVSFjBJEouCxI+8BirlNgXuyiMHVi6VdCSNxrlqK7j2wswFSsNr8cx5E0/Uml3xi8Sgba+8dnJlbipYB0m32R9FHaburMyljuLcIc3QuvaWZkd+cjiQFIFNz5oOIFvaDkpdbX86QINuXSyZYEursJGbEnJ+XyFUzccc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783539902; c=relaxed/simple;
	bh=5T+LqRwyjB/2wkNs7y+IVqhdJsD5Awf0ybJqptkVag0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YozH1tXciHUzenf4Z08cnp9FBA11cIoabFHHMEX+2ymcer0ve7NGgcJUvhizlFb+oHPSmFHHLmRpgbVxQ4QWmqakTzAO0haTIZtGNSa8HdLxaXfabAeDGQVsea2AhR+8KeI5tkVhtfVOMF/WanUou98fAvADZmdXe1Qd5wyygGA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LjRGfpw8; arc=fail smtp.client-ip=40.107.209.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LjRGfpw8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vSZGjje0A0YgU+NK9kCkc1N8k85LoiGagFDwgR5JjopoRwTRbpXNxnEKfgKlJ3WjaGHkph2YSG/A9zXegEBUEpR9p9ZAJOeEKnNjP8yUW6FSmQPzL0wLIDJrw3CQM7DyOtOniVNU4tFT/ogGf7bVbgC3jOlXksnU53tTkg1V3QBmfLVeL4yfKKuY9CvjgnNpEPv+AexJudjdArS8lW5evd68F40b08hPkzFUOwlLcl9mUo/jsIUie9C4tvDfDXkjomM2tPIIgbUo120Ddcd9qP/O1PgqsAK7YPolFqtGXh+bOTBI2IXwdLGhQYMIi9k/EXA1B8aBBKx8YEEdyXBfBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jljs3sagk1VTXhPhgMdrFxfPA3jCnRW751d6bs78X/A=;
 b=NRWL4wcoiI2IZGm90GuZd7fKBZxRgfQShRboVuOlpjSUrpCDO4S5tFSn4f+09OVsPtnzDUqtqVG8VuBs7nRzAsQdIiZdGhaJvCxsQheRuBrFLMIQuZ0KopcvJ9njaoq0g+ijnXZDxIgruSlS6diboXfMzdqH5pclhVlN1ZrCeRGHLh3daLQxqmAAcz6fat4HupKZIwBRu+5xNKvZurzX4vhmhLO9Xm154/79Z6gbpRoJ/nIEmFsxUupy2CKrBSyPGgpyeFMXDSudePcDWMWYGfImE2qAsUGaEB0OjQO49Q5b/LQNn3+67cM3J3ywglLtB1BUMt6mHG6W2kv3NoxzIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jljs3sagk1VTXhPhgMdrFxfPA3jCnRW751d6bs78X/A=;
 b=LjRGfpw8H1YSmbCWiG1iSFXGUXSBETOos0fyM5KZOev2ICqnWpcV/TSYGtcEtwvQdK3Ct1PH9pTTNFWtd7+d4bC5E2DeQi2fuPzG1DcpPY6ZmhdjOXKLqUqP0MChYFbNibBTDpeACgJlrKsKw6C81sMaVmpFaalRa0GtAF4wxD8aNfL/yOtgSD+KVAH46JNU9UlYzWySz2GHnlC6G0XkWj4a5PCJM4sh1n6fL6vxcXt41Hj9WaGI9p8g1Qaj7HUs33k7Q97jf7t2jd9VAltzAAQqO7uI5jgDPrzhtf3xSOzMuictplfgeRhpEZoJb6VtfH54Q51Jqpyh030IJkqp1w==
Received: from BY3PR03CA0005.namprd03.prod.outlook.com (2603:10b6:a03:39a::10)
 by IA1PR12MB8359.namprd12.prod.outlook.com (2603:10b6:208:3fc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Wed, 8 Jul
 2026 19:44:50 +0000
Received: from SJ1PEPF00002314.namprd03.prod.outlook.com
 (2603:10b6:a03:39a:cafe::14) by BY3PR03CA0005.outlook.office365.com
 (2603:10b6:a03:39a::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.10 via Frontend Transport; Wed, 8
 Jul 2026 19:44:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF00002314.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 8 Jul 2026 19:44:50 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Wed, 8 Jul
 2026 12:44:41 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 8 Jul 2026 12:44:40 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 8 Jul 2026 12:44:40 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>, "Kevin
 Tian" <kevin.tian@intel.com>, Lu Baolu <baolu.lu@linux.intel.com>
CC: Robin Murphy <robin.murphy@arm.com>, <joro@8bytes.org>, David Woodhouse
	<dwmw2@infradead.org>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 4/5] iommu/arm-smmu-v3-iommufd: Convert cache invalidation to the core array loop
Date: Wed, 8 Jul 2026 12:44:19 -0700
Message-ID: <e21c0adeb86fcb82238b1f9d29f7ba7ae423ea47.1783539724.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1783539724.git.nicolinc@nvidia.com>
References: <cover.1783539724.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002314:EE_|IA1PR12MB8359:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e18d9dc-f85c-4688-ca81-08dedd295fb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|82310400026|36860700016|376014|18002099003|22082099003|3023799007|5023799004|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	mB5YD6aRbmInq89AlyyRt2zotGA49lWk7oLy3xO1lkJC+I6miCAgW4FGlNXDQ33we2aGkW3O6qLxkU/0Kzr+np3Kjm+feVo27GBC+8ra+HJVJwCfpMEDR17PTIRdTrSznsiFmbMO3SRVwzB6O2iI0lf3J7Fu9DrjqRPP2THaOTJ10o/TpVjc6qdwtgaCI6ZMW/Z2K6Efld1cHnjprivI5+7p/PEGPeydSPPser8ADxHOKv+X0VEoad82s9eOSbYAp9+zQJvq3xAKPr/5EsF0ANi6FAxd8n1aRUau8GeoFKINt+qjB59lJkrjLXo43GT00mOrYzHnR6Thn9UHkRWCZ1ft81N5dVTwRVNdiCgmYe2cAIgZxRbBDNZmmcu5D5CjpkQSx+d5PZrQcAMkihyk1NaJ/TXNqY0/V0sFP8icXSK8hVV8Zvc8rQwj/ArIAS44JTcHiHL9Kbj5FtSmBscZCsu1Fyf1N3xrSWxH46KYjOMdlA0Ond/InVa2gZyKxUicqYiTa/6Fn0ChSziRvcPBuEhUD+Nwic3GoS5NR2a35O0h8o32bqqu9ndmTWUcDe9C6DXjyv1na9KbUxi64Kh1GDh+xtsnJ0XvMruxuahr+Dj/SD1VKeD+vzLiT17E4nmDSjkmVturBbjFYAAQwnWItfCjmDL6MDH63Vjj/MGrqUfMU6i4RtPQB6rLWgmIVIuzjkquXR6+l67sYIpKgcQ8Zg==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(82310400026)(36860700016)(376014)(18002099003)(22082099003)(3023799007)(5023799004)(56012099006)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	qbbm0O0pXllL156nXY71ggAX0yPTHFWucRTofLCDtlzXOzqgxW/rlEoWp/JdD039vYbn+HkISngmVqrwvMCI7kr/Eage8nbmIXlcWtF/qqHp6LQN/UVyLgzmRZgXsPyGmdAHElOj4Shf8Zo+HWd9FU8UZv4vue6xoVg4R5PjPwXH/4JfED6qbnfvEDVcW0RHgBL2LQJNHxo5JXTSsi9qxk8MYQHZvfFrDfJ5tzzT20AbM0e7n0dGscujhlOUYDSNuWa1MJSQgTlaP8UVGM5SQWSpNkd0PS4TPpmbixa4OZBeZ5bE4aKGQmtqJ370Aq+nP6AtObhHyqQZu7gPIcGvBqyuOlir3T4J8qKFurI2lqAdoN6Lubd3f+Am/B2EgkepapuBt9CsOpGXqFFDta010ZXmqEJKF6WHB9AwOfRKUnk0wkP2jkmlQpNTzP8v0g1r
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 19:44:50.2242
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e18d9dc-f85c-4688-ca81-08dedd295fb7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002314.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8359

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
index a5cfbc2499034..678ea842ba541 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
@@ -448,49 +448,57 @@ int arm_vsmmu_cache_invalidate(struct iommufd_viommu *viommu,
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

