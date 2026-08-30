Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010047.outbound.protection.outlook.com [40.93.198.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A8935674F
	for <iommu@lists.linux.dev>; Sun, 30 Aug 2026 23:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788131938; cv=fail; b=hfu0jFvMlfd2GlsBx/CKl+xLFkVITXFJv/x+mceuFZCSyHlFq13xsQkCpdRAdwvav8P+sat7qzkLv16Z1RjatAKVjgUjPryFpekeqTisUgYnCgwZS9tTUh2qWGA3FIX5oKnZ4HNa8IZMqrmj4zavwqpMJbeG5XHzDTd+Yn16lP4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788131938; c=relaxed/simple;
	bh=gNmz1HnrWvrM9A/a+djPcM/fOOcZlLMmEZVgKISxkkk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fkgbYf1GsIh43aB46s4uEnvKg1eCaBBKo6am9APogdBR/Plq5PQ/uMdTyYmHuKwoq47M1g4anjLmRhVaV/AoP9gOf2aQPvAnSEAElCqARa5RfmK1buoxQFYeNIJpIb61Cu+CvXM8iZiFJjhpfKet1kXq6PSz+1LL4IzQCCGM2eg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=P3znxJb0; arc=fail smtp.client-ip=40.93.198.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="P3znxJb0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ciNC+PHP0jRxEoTJmKBJqevD5HBqoWDbxhsQ1Z5ST76UpV5+FUIkVtrnlyHgu7au5afGHgOXGDXkciSE6FmQsvaLKJVmvhVKgwIsi+2NIoWKc5wM9Ha3TPpuU5vd1FbgVauBDemHv983uzleOMI0PbXEdXpEGHZKW7tGHd5DpT7JYCYb4nsC02ZEBxugCIkHaQVtDSeX7d+4UWpWFqJ6MMW+YzfFNsIXaaK4QP48AfVcXJeqGBMupLN1+FJUJGeihQRF5eyL+IzMvp0WZifEZzv2j3t+q8DmpPXLq5szxgnkrCh2b7XYrrJkWCIN4cFSfHkm0JhlAd/oC6b+YOCrOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=alY8bgBiJ5Jc9CJGKo6EDyKl/A/E0xJpb5wHTjyXSoY=;
 b=SIomk4J1hpi/kjcLs/e7czpQhp36nd6gYuzQ2NkYjrBSUICommbMaZPxutiSj2Vsa1Y8ETg9KW7/9DF9sGiDFXCwNrw+7Mk40nUetsO1YO12I6LTBL3iDZqaOepTd5KKa5bS4V3IBGcvAvUBHj0tGf8QTmPTh62/AXNwblG2hwWs4AtvI4hSdDpnbWTZUBkFAfxdyoazggjyTfYuwqbAr8P3rxC03L/ikXC1k5riTpJ5gzqPyZdJpUjHRD22m7gUgjuSXFvxRZBwe4AvqDyueqxuwiDUx8bBvojl7kZ1Bo35vh9Pwj819vF3Bd+x7yzUfA2Wy4DcmNTxZezdOQEVGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=alY8bgBiJ5Jc9CJGKo6EDyKl/A/E0xJpb5wHTjyXSoY=;
 b=P3znxJb0/hN3Ty8yMHVaNPTeKedy/jnhhzxgmDyo1WuUdA1KSLqATVx+kO75c4/BcjozYdP1nSaO/NpgMjstzq6Z5YmQCiBkWQqtMAobyrNKWQpG8btVOj7eCb/x53jqDLQ5NqwaaCDmkUc3p5K+6sh9GzTJ0chqUDR0kJLinbcEkDSEBQHnpMf2qvJ18QL6iPrjauIgCJPgid/6gp0PEMQSZzHrnIr695UkweuMKVFx1ZSfuvlFw7pmSU2sNVUfsIuKtam9S4FzlVAlA3ZQ43tHUA7i8kHhZORCcsAi3YtAboA4IEE1qaJcbxW79R0vfvKE2zFt5dzwVuQd/dudMA==
Received: from DS7P220CA0096.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:25a::8) by
 DS0PR12MB7725.namprd12.prod.outlook.com (2603:10b6:8:136::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.13; Sun, 30 Aug 2026 23:18:51 +0000
Received: from DS3PEPF0000C37D.namprd04.prod.outlook.com
 (2603:10b6:8:25a:cafe::1c) by DS7P220CA0096.outlook.office365.com
 (2603:10b6:8:25a::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Sun,
 30 Aug 2026 23:18:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS3PEPF0000C37D.mail.protection.outlook.com (10.167.23.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Sun, 30 Aug 2026 23:18:50 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Sun, 30 Aug
 2026 16:18:42 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Sun, 30 Aug 2026 16:18:42 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Sun, 30 Aug 2026 16:18:41 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>
CC: <joro@8bytes.org>, <praan@google.com>, <kevin.tian@intel.com>,
	<smostafa@google.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>, <jamien@nvidia.com>,
	<kas@kernel.org>
Subject: [PATCH v10 12/13] iommu/arm-smmu-v3: Skip RMR bypass for kdump adoption
Date: Sun, 30 Aug 2026 16:18:13 -0700
Message-ID: <89285912833ba2aea8e43d10d66f0e7e01e1c256.1788130528.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1788130528.git.nicolinc@nvidia.com>
References: <cover.1788130528.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37D:EE_|DS0PR12MB7725:EE_
X-MS-Office365-Filtering-Correlation-Id: 742db65c-0e2e-42a7-ced0-08df06ed0d57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|30052699003|23010399003|7416014|376014|6133799003|22082099003|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	zLin/SSLIh9iDCw/act5piNDAuK0uIcvgibCEsqf+AKko+wWyR0BhF9uwBD7xjSe3jvomTJTWJ3+I1zxnFCytnwoxfT0TE2ejAS4a4p7I6u4VnO0im86acz1i/HHf+ILKqZS1aFcEDFwYWxL5aLZO8ckgD0nT+ZSIcDYi7WO5xwRSz4VSQljJg/2jvdCJCdX+0m115Pspca9pGrapojZ/WgyPfE7KSmYXu/+HzOXh+Qp/vYAZBa5sxTFkmIMqOXSxldQ82dgyvIsgXhgQXwIdog0h7GG/smEmvEeF85FnJVUJQ3wJn5CIpZfBzwSVBRb4GjEXHZqMwghsMIwoD7/yGvBEwqL4xWSpl43/6WF/Zai08dFGl/yPJ2iQDbIETXKFD4O6F0HF5xLsWc88rmiiWCRNfO4YdGnlhltBoYDMT9lh1A72yY/GeMR5R+tNTmEFNkc7wjK5A1uoG3cUL29yaYodHLV7tMfdxU0vkwh76wsvad3fVxmzS1QMgtM0A5ddzhW19clYg5U42JL1pkJg20XZDDqmT+oAKINTJQYmP1cTr2gVPnUe37mrIg9h6fcC4tEYQplFp+o8EU/MScE1m8Qq6npnZnZSG6bKNEVtsY2Mu6Qcvp0MZ6ipBWXAIDQ9J5stKU66c7PMnAYpRwH2eeC3jm9iPOQ9oP8ZPptyrpPFxnQFetnyMxBFck3WOtbSEDg/rIRXKCZstt25YRaCg==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(30052699003)(23010399003)(7416014)(376014)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	0i1Bo7Ft0UufmFS9rGaln2QHxYNn4QbAJRASnNta+hSDpi8knCIHmGQh0OW0506MKJCMV/cWSNFORJNe5SkpirO2FJnbzDjgk2bX8+MvT3V2UmdCLYlVCNi8kdAkJOEqtz6zqQ3oaBuffcGHIklKfcD9ziA20pMX+FAp9PIK1iQWCZ9nn9dsvRYxNnUfhonzHQ3nhLgipgGXD/8j48IXIdaYWA92LrKOiClgJvM1fTFLrqmw865NtUP39XYTrA7H2CKB+mD+MuCinbUz6cYOHlxL1IDa6xoOBlskFx/Mm2/9FrQ7tFkQLLc2Di6sQiitDUswDhzdKzA3f2wMFcz1p5O6c+uJ3sMqdsa17+9GYbjPdeBm9NSybhm2R8cUJZTW0DdnPvRHhCgQH2xBigTxPqqwxv1lrQyRzrK+S+Ev1PHaRj0UcnI82P3TPeQyIOEh
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2026 23:18:50.9390
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 742db65c-0e2e-42a7-ced0-08df06ed0d57
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7725

RMR bypass STEs are installed during SMMUv3 probe for StreamIDs listed by
IORT RMR nodes. A normal boot switches the driver to a fresh stream table
whose initial STEs abort, so those RMR SIDs need bypass entries before it
becomes live. This preserves firmware/guest-owned traffic, including vSMMU
guest MSI cases built around RMR-described SIDs.

ARM_SMMU_OPT_KDUMP_ADOPT is the opposite case: the driver keeps SMMUEN set
and adopts the crashed kernel's stream table, so RMR SIDs already have the
only translation state known to be safe for active in-flight DMA. Replacing
an adopted STE with bypass can turn translated DMA into physical DMA, then
point it at the wrong memory.

arm_smmu_make_bypass_ste() also rewrites the STE in place after clearing it
first. While the table is live, a concurrent hardware STE fetch can observe
V=0 or mixed old/new state.

Leaving the adopted STE unmodified keeps the kdump kernel using the crashed
kernel's translation. That gives the endpoint driver a chance to probe and
quiesce the device.

If the old STE was already abort or invalid, installing bypass would create
new DMA permission; leaving it alone is a safer failure mode. Later domain
setup still gets the RMR direct mappings through the reserved-region path.

Reviewed-by: Pranjal Shrivastava <praan@google.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Assisted-by: Codex:gpt-5.5
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 0fb8c60526699..525cdc2e7d495 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -5536,6 +5536,14 @@ static void arm_smmu_rmr_install_bypass_ste(struct arm_smmu_device *smmu)
 	struct list_head rmr_list;
 	struct iommu_resv_region *e;
 
+	/*
+	 * Kdump adoption keeps the crashed kernel's table live. Rewriting the
+	 * adopted STE here could expose an in-flight fetch to a transient V=0
+	 * entry, or change Cfg=translate to Cfg=bypass. Must skip here.
+	 */
+	if (smmu->options & ARM_SMMU_OPT_KDUMP_ADOPT)
+		return;
+
 	INIT_LIST_HEAD(&rmr_list);
 	iort_get_rmr_sids(dev_fwnode(smmu->dev), &rmr_list);
 
@@ -5552,10 +5560,7 @@ static void arm_smmu_rmr_install_bypass_ste(struct arm_smmu_device *smmu)
 				continue;
 			}
 
-			/*
-			 * STE table is not programmed to HW, see
-			 * arm_smmu_initial_bypass_stes()
-			 */
+			/* The fresh stream table is not yet live. */
 			arm_smmu_make_bypass_ste(smmu,
 				arm_smmu_get_step_for_sid(smmu, rmr->sids[i]));
 		}
-- 
2.43.0

