Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010013.outbound.protection.outlook.com [40.93.198.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E183B9D9D
	for <iommu@lists.linux.dev>; Tue, 21 Jul 2026 21:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784669948; cv=fail; b=e6A4qWat0QJEIR9eKWWNXW6bzPRnmXHmAA5BR4WEoMltsnapCAlmjeBareH/JLJY4twTSKPnv7wF8679SAfGeGdJQDGvBIW7CjkwLAJdHw7H2MOyWdtCB4pSwt/DuNlpoEl/kZz09gBblPyxbzhTarhUhg9doYPXN+43EkFQcXw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784669948; c=relaxed/simple;
	bh=UergahTC6c3/FVCvNWA4rPKSL3j4toYJjGckmF6sUa8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qV71w4nurpwrjlSrTQY19nE21GWX7cttta1ilrN1/Olrp0rX+hjbIE21nQsiDKaHQ26o5C61EJLXL5ZZZPglLaejCfwAwrsl6e21tllTARvahcRgwPSgY3xHpg4uHLJxfwMb2Bg+suNFV4kHlJJUDXzGWNOmOBnnJ9MlAnr53o4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OG4hsQhQ; arc=fail smtp.client-ip=40.93.198.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OG4hsQhQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wUWsEomSlxI2CG82ecqJtPBSq1r6kFjdnhUfrKDAba6318Q0vLOEXVcUYVb82kMSUIsMqjrarwdCrjttLux7GNYKe0GOZx+XbQy8SfDaQuoQ7lqkj1vt4W/ZiYkgjH3zrS6DbyHxTt3p/miO+PcgNBxc76kY+vaI7guUoiTLTFfJao74oMpRGNyGmlyZSTuEivQRV+KlglRDFQiC0YwxR3IBI1Q7bhpjdPhfFR1We5FTS1V4Q6Mpp0TaRpEKd9I+yh/DHwp0r65IZ1qCPNRKkxbYCyhJzqO/CKhWpsMJ85tJCuec4cvlZos7AZxBo/Ttg9lWySaZVvfEywNtPiZ6qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uWINbuYSW6lgh/AzF7TvovqvT9fTYN1oiEEVah7JEl8=;
 b=XuGZnv1iP1SXJdeHEEqhFq6Ndz+GDgpMhXqyA0s5Syl9uQZSxwBgt9GyXyODTCsSa5grrvU8K7GjiIx/g+OMUTwNG/meWJzgYQixAGmooJxqVBEoAco3VNn3cE6TVSKnRTacyVJnZGYjjwRyV+U9QGiUyc7AHradMc92yIBMWp5SRJR+X5a41L8ar+BDAOrmB1NDv3i+KRo7J1mfXCsIB/9r0mZXV9hYS46dx1BoID4ZtoyrERUjG+dn3o/9ewjuhsVynqrRAhgg4z80HV70Fp+Fkq0FqRTUJ6rgwB7jouR6ZViJez0kF0fqvhHvF6fsyBIGgXuUIvsTQS3GpaUe2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uWINbuYSW6lgh/AzF7TvovqvT9fTYN1oiEEVah7JEl8=;
 b=OG4hsQhQ5ZqAwrnNJZyM8yFBhfPWmjjI4lWEdC/N9pUK+Oue8N2Siawq7HIilaqMdBRiEYWMHmbt6E696haJ3VsKPJAy3PwJMKLvDIguOWj7BO65exC7uqsont1SQgfRR/IVhW8RG65b2pCEhFnhWkcpxKRuzCJISJlqkkmnxltj+TcPi2Yt9eRrmTjy0cywmTFuL7PQM8VAsELUPeYlCXlYkqqcezSmfIW+D5ljw9Gem5xDN3vZ7rkGoOl7dCDWZhWPrZraRd/LjhBKDROZNinKLrlIV3OvljHg27vNdsZoSequ2784NyFwFNrywb/iIrehv5IF4jgZ0Tnlkx5zCw==
Received: from SA1P222CA0156.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c3::19)
 by SN7PR12MB7324.namprd12.prod.outlook.com (2603:10b6:806:29b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Tue, 21 Jul
 2026 21:39:01 +0000
Received: from SN1PEPF00026369.namprd02.prod.outlook.com
 (2603:10b6:806:3c3:cafe::9f) by SA1P222CA0156.outlook.office365.com
 (2603:10b6:806:3c3::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.10 via Frontend Transport; Tue,
 21 Jul 2026 21:39:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF00026369.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Tue, 21 Jul 2026 21:39:01 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 21 Jul
 2026 14:38:45 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 21 Jul
 2026 14:38:44 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 21 Jul 2026 14:38:44 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>
CC: <joro@8bytes.org>, <praan@google.com>, <kevin.tian@intel.com>,
	<smostafa@google.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>, <jamien@nvidia.com>
Subject: [PATCH v9 11/12] iommu/arm-smmu-v3: Skip RMR bypass for kdump adoption
Date: Tue, 21 Jul 2026 14:38:38 -0700
Message-ID: <dfdaefd08bc5e61b1b569919aa4f34118dcc98cb.1784663184.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1784663183.git.nicolinc@nvidia.com>
References: <cover.1784663183.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00026369:EE_|SN7PR12MB7324:EE_
X-MS-Office365-Filtering-Correlation-Id: d69333fe-e217-446b-be5e-08dee7707ac5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|30052699003|376014|82310400026|23010399003|11063799006|56012099006|10067099003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	iaeZnLTGuRIGfJvypEPBWNhzq58A4r42zQQL9K0F4j7DR6TlqZEeXL5IbA5xPF1xTMnwyf3SgbsBjwUC97/i4+D3y+wr9tNRSisGidMaFNiC+E5ukg5Oqz2kMJStSWYNxudi3xn4GkugYqkuyO8p9/1GaYKVEo8t0DJsv0gpkzJNqtCHrUqMJgoE877zfY5s0KsEFm52CrgkkO0+dl6Lxd4NLKzMdtB+rJdmpGSBK1iLjkbqehNhizDb8bYc9Sft8MIl2Bs6yJbFgP8c2z75/v4tzH4YIP0JsjF+KnXQPKlK44c8O0itGpN8qn6cX0GL21sth77L6Xwy4lGIZEV3B8XnHjKUQKtTx5lTj6+yXmc6oV2lNokcoVm1yxVw9RMQThcO4Z7MIP+2I8Hy3btvO9U9nM1rUvnjjZdqpdOTKMZs/hEvycQcLbGShisy88+g7SNv5WfAma2xZ7YdzDEW5lCAlDFarp4w/Vr7dJQyNfkyIHF/jBQlA8l5wmBCdYcPU02JpjVg8Utjb47gUCiDlCXB70CAo6bgivOHOXdfgFTX/w+GhYAjUta3w8v+jueHH9BTaTBxm8nuCkOmkDPwf8vR+Yyrv++FNTEp9XkCZQwKf3+uO5DH7fTyREV08mevvkLEiCnjc3Df8mvxfcvLdv0nKCuxfIowTMdNnwtWpvccu2YU+AkMRsJXftxerwBfWawjR8YZc7np66OIiLhZVw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(30052699003)(376014)(82310400026)(23010399003)(11063799006)(56012099006)(10067099003)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ZARte6+2VWqU9NLrA6qpo5/QWek7K54M+7JPnPty4ThBKjcVx7V0dYRn+0VLIlYYzP2j6ywOpjqDiW5b/5418m7TgasrjxG16PsGYPO0lfuPVH+68SWPxww75oKrBB78uwqenhkXpT2xsn8DzanWCrDhJESf3mIkcmeyBbHvK0wdEboAf4gk0d+OE95R1f6vFwJeLAPXSjuqY0GVPWtPTOjBN1PW474pB5ZbaBgnMUQPqpPR8LD9Ub41xvS1aX/xp7WhP5Ppx7bkYwZDZFRf1mP3yUfNbxBeDTZw+EXDzVv7J4XKU2sRDi4Q765B0zxemKIeGvFZld7F7Vy7KQIStNOXbOZmD8IKbC2xa0AJ6map9HtyKRCHFvaaGaW84Pf5VCi762iyaHxZAiWJ3cyve2KvkdWewDP+QdNe+rIa2bunb9Mt3btpATbG2971UvlQ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 21:39:01.3812
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d69333fe-e217-446b-be5e-08dee7707ac5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026369.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7324

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
Assisted-by: Codex:gpt-5.5
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index aff7b6b4527a5..168865af868ad 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -5421,6 +5421,14 @@ static void arm_smmu_rmr_install_bypass_ste(struct arm_smmu_device *smmu)
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
 
@@ -5437,10 +5445,7 @@ static void arm_smmu_rmr_install_bypass_ste(struct arm_smmu_device *smmu)
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

