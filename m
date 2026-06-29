Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010061.outbound.protection.outlook.com [52.101.61.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC900395ACE
	for <iommu@lists.linux.dev>; Mon, 29 Jun 2026 21:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782767793; cv=fail; b=BRCEsyilBa1lomrzIvrwpG8ljZ2Vn69ww+BEi8g8PBf5yTsuS+7H6pydpnUXD78hpSqDP+y/0L8FPlYOKNLbm+9XtFMZMDOWeR14kx6IzAQDqRFq3BjjXGF1C4smVauM5WLYJwz3QN16znXDZLRfZZPom1NAwBBvuVJDihCYKIs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782767793; c=relaxed/simple;
	bh=IoRGZGOHPjamesvyQ+tviXkSVtsrbt0Wa0HJ/h+aM+Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mz5H+yPuhBgiFYZa9ceWgvbX8KTbn5G4mWfwNkj0u4ucMp8uvsq3a7WQtRC2J9kCb784zeHF+nfdu9gR3kqByt8eYTPaPN3yK+iZ1IwU8nid6lC0enqDGW/YxgG7tfcWS4AL58sjNbdkw1H3R9PscsHMVn+PP+hZbZEKRfXgBvU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IhQs9F3h; arc=fail smtp.client-ip=52.101.61.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IhQs9F3h"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BwnT/I024Vc2DF0ZQDiU0Zk7T23ZpayjPRVHvd8UIjxdz8hGFUz5iFI5agqwNKc3M5aLIO7lNDfwGPjyoCNatYLbXDer5QZbc2ymD53wdG/qF7f16JhWhSaniThHJ/rIIv4yjOa87U1+1TiWELxx7AGnfiqlMvkdclGKoMZwIxlvv0qAox4UcmJi/eG1uKi5g6AuAjlrrI99obHVP0Wf+9SmEfAno6vEdFUG4f1zlDqZWsPWb6iIiv1MUS/zWw8FFvSWZwk9zPpr4XNfh9M8xLD3sOveb52VggEMbA6nG69nTA2NfmYpaI6QrxPBaBjm4FLMBFyudRL3xSOHT8CbCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MmQ5gbDW8mHKTSB0lZM1n8Rubmo229qYtzSfviWeNsw=;
 b=ou8x33T3tPquRqYOrmTqDAxKExphpHj54spZp0k+K/1eLawUgkHYAwu9EXqQyXGQX73Oas4YTb5doVDm2HPAd5LaI549zyvLNCzLDFY4Lq3qBUb/HlZvTJj8K0+JH8ANKGXOWBNX+A+tj/jBI5Z/yZxfSjq3J+uUK5QMTQiBvB3qxUF7DXs9jZ9H15WTT7xMrxLZB7Q5HNgGFcWz8V4QoBHOpn/a3YHp+iFrJibeao0biKFe5ufZroYCvwBPSmJC7mW/qwllcQVy9uDyhMG5XrTfFh38H6m9o6q1kL7A3Q8ttFBzmU9bS5uLs0qnKtRozpdnRTuPHOB0TSdl0zRURw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MmQ5gbDW8mHKTSB0lZM1n8Rubmo229qYtzSfviWeNsw=;
 b=IhQs9F3hHtIUPX6Xfq0nErYk3s59YRp8HhzNTOK4ueI+6btZUiExPeH9cGdveBXRKCY6dvt79gJ8xsotYJKzJQhrVXnrGX6q/SIYWsRVvZyj+KvS1bMtNNC24hoZ+FyBIq3FUOfSTViHwCPS6+S5CXKAuMjdb1Cs3Y6O7FPlAZC3a7Gyre7tZJ+utCxRTZ0iSYqENklRYAEEUCPqFk1hBkcl4YW4Rf7JMSHK7dq3rZ+i1sudTkW6LqNe80w4Plc0cQQRaduT9bNhmtegfA9jXkPhQhMYxmNs6zA3XXKLoL4lJhj11Iju+dEbSe07h2j9ilwYEFq9CsTgT1CSqLd2vQ==
Received: from BY1P220CA0014.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::9)
 by SN7PR12MB7853.namprd12.prod.outlook.com (2603:10b6:806:348::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 21:16:22 +0000
Received: from CO1PEPF000066EB.namprd05.prod.outlook.com
 (2603:10b6:a03:59d:cafe::a3) by BY1P220CA0014.outlook.office365.com
 (2603:10b6:a03:59d::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Mon,
 29 Jun 2026 21:16:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000066EB.mail.protection.outlook.com (10.167.249.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 29 Jun 2026 21:16:21 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 29 Jun
 2026 14:16:00 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 29 Jun
 2026 14:15:59 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 29 Jun 2026 14:15:58 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>, "Kevin
 Tian" <kevin.tian@intel.com>, Lu Baolu <baolu.lu@linux.intel.com>
CC: Robin Murphy <robin.murphy@arm.com>, <joro@8bytes.org>, David Woodhouse
	<dwmw2@infradead.org>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 4/5] iommu/arm-smmu-v3-iommufd: Convert cache invalidation to the core array loop
Date: Mon, 29 Jun 2026 14:15:39 -0700
Message-ID: <0e89c623d10ba40e317067e304e30f52866fbe49.1782767398.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1782767398.git.nicolinc@nvidia.com>
References: <cover.1782767398.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EB:EE_|SN7PR12MB7853:EE_
X-MS-Office365-Filtering-Correlation-Id: ddd633f0-3a88-4c9d-d0fd-08ded623ab2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|23010399003|6133799003|3023799007|22082099003|18002099003|56012099006|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info:
	eNHCjvVDHA8hH5Uw1m2qhaWOoR1NLZAUmaplQj+D0+Yf9fxNsRB7OUZu2UdVr4p2tREb2z+iD+rPVbD5IZk3rYOTKcsz+o7j4GDWxboFWw3DG+XzQEW0CeKef0IdmPHf2yfcsrtCf6YIiTiFKqisDznxn+lbSh0fD+Q91Mqp0l03VGSzIOIOUd+5DMk+IsWghEixEkKf8RvIfx4sN46qgu6Iqy8KsK+SYuxEaVjVo+pZ7N2gpIhyEmhZU6GjVGySfZEcFP9BtqqdJFws/XUSzQSlQrKEheA4Bo6u0b+OLD/yd0aiymBg6FuqZyH/RNTOAciDEhtSGD89uVRk8M7CDw+nBIuN2kxkxsEr8t3KI4hPqr0BcR6LmwJEjdpyvz/+g3dY8l7nVa7oyxTAyjychdVUi57A9muEmDypS1o78w4IuTx0SnF/TGrEodtJizvhbUbkhDutdz0dPPmtDEDA3uQAnXMQAkkKlsZE0u620PjFGmvSF/Angul+SybUWTQB+CDG6Qbq2nsszgbCv7Wea0YBjzYx76liI1c2MjkHX4fUb/dHx9fh0ABWojmsu8y9aRHLcZSs3/1a9IgCIZT05Opyj2aaqbE62Sy2m+WsyOcMcqfeRwVMGs+sy8//tTTcA1uxaGZayzm+4TdD5/XhQXW0lEhDUJbIv1kUjULMuc+MwEywVtlgOa6axW1YHZXO65IhOalU80ljcKEDu7TQ5w==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(23010399003)(6133799003)(3023799007)(22082099003)(18002099003)(56012099006)(5023799004)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Tzn73Ef+BnmYSB00gtnkMx0z7fG6jY/Te3PWARbtZienX5h9EWk6P/YCnteayQk2/eZN1MCOgdj1lKU3Pp71UXttgvVv2I1Wg3Ht5gk0Bw8f+cbXZKsvQw9Mnc+5LO/J8heDoRvVz8bZRH4/RvLeSS67BLjCl0V/abZnhi1ykDUJ/WZSOfi7FoAKy/uFvrpjn8C9ubSu5LsQX+3s8zqmOSg3ji9qkdM2qriSIpcfLYZ3kv2SQzODsaT+fdO24PWG8M4S1srA9LzuFcA4JOd9rMW2+uXI7C0NBbc9hCYA2Qrd0JoAEpnW8wvPTxts+TOhmRYqfs3irvzjV87VhJo6yZpkJfmmwj319frpoUhiC4HRKsgJphz5vUiHaEj3LsCU9sTTl2eBF7w4zvFF4QlxVBDpK4u0c2cds1GpALaR7yyEDjBengRB+VD/e245uFz9
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 21:16:21.6070
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ddd633f0-3a88-4c9d-d0fd-08ded623ab2a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066EB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7853

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

Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     | 73 ++++++++++---------
 1 file changed, 39 insertions(+), 34 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
index 393d69783225c..aee58c0be4597 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
@@ -412,49 +412,54 @@ int arm_vsmmu_cache_invalidate(struct iommufd_viommu *viommu,
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
+		array->entry_num = 0;
+		return -EINVAL;
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
-	if (ret)
-		goto out;
-
-	last = cmds;
-	while (cur != end) {
-		ret = arm_vsmmu_convert_user_cmd(vsmmu, cur);
-		if (ret)
-			goto out;
-
-		/* FIXME work in blocks of CMDQ_BATCH_ENTRIES and copy each block? */
-		cur++;
-		if (cur != end && (cur - last) != CMDQ_BATCH_ENTRIES - 1)
-			continue;
-
-		/* FIXME always uses the main cmdq rather than trying to group by type */
-		ret = arm_smmu_cmdq_issue_cmdlist(smmu, &smmu->cmdq, &last->cmd,
-						  cur - last, true);
+	if (ret) {
+		array->entry_num = 0;
+		return ret;
+	}
+
+	/* Convert the whole batch; a single illegal command fails it all */
+	for (i = 0; i < batch.entry_num; i++) {
+		ret = arm_vsmmu_convert_user_cmd(vsmmu, &cmds[i]);
 		if (ret) {
-			cur--;
-			goto out;
+			array->entry_num = 0;
+			return ret;
 		}
-		last = cur;
 	}
-out:
-	array->entry_num = cur - cmds;
-	kfree(cmds);
+
+	/* FIXME always uses the main cmdq rather than trying to group by type */
+	ret = arm_smmu_cmdq_issue_cmdlist(smmu, &smmu->cmdq, &cmds->cmd,
+					  batch.entry_num, true);
+	array->entry_num = ret ? 0 : batch.entry_num;
 	return ret;
 }
 
-- 
2.43.0

