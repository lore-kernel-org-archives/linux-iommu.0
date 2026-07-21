Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010055.outbound.protection.outlook.com [52.101.85.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85344307AD
	for <iommu@lists.linux.dev>; Tue, 21 Jul 2026 21:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784669947; cv=fail; b=Hy/QFpkSk/xK5mX8xZtOTkJzzt+X9c2cmwgIJIXP6Uex1gaLPXWpzS9PgeDgaOds6m+fHDmLl853g+x6dKF+LCHtSKRt9jdRtfKtu4gz41LbXNQ2S8LJb+0MWppLsuyHdLKJikxAjHVteODkkBN9QkPeFlrW2yLFhRWFa0aiEoQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784669947; c=relaxed/simple;
	bh=wx5lzu8ij5dsskIXUk5NCbsIgE9VSOqRyMvYnrNLwN4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TESjfVrmH8L8CJeOlSkAvnTBA7gvyIwx9bkoUY80iePHc9hf9CqgeYwJx68IlciCMNRFxJDYPor4qh9CZhGcyotIwAReDfG884s/SoH8UdvVr2FyhDSco1jfBhcDFXQjH7V2uixL4OEhpDvU70s0PAsSG+RGoUNuz6jZVb0FU2s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FJLzFk6w; arc=fail smtp.client-ip=52.101.85.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FJLzFk6w"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WPrHJma7YXjR9XCWzn3qf8yuYoC5vdhmPUA6QdGriHCAgbTkAfGFLl7PNZku6i8hUCEaaGBQZvbiot9og1SsluKmX4A81M5dI3/HZLLrXu+/NaifSWZ0chsJK65Od44Dqy5p5OXoWHnpyG04VzjScu9fTNRBRejZxUgagrSgJNPiYaYwem6mHX/7YsGTTm0p0KmR6RW2iDNrgXE4al0vrMHpaJ47rgTta/GwLMq/Bc6iWUJoz7PyKq1hjarjlW1AoLayGqdKizbLCQXbZOLaafVkFbTkK9ETfUXIQeBzzeRN9BTQGU1ZhKrJFLMo1EZY6OlcWKU6pt+NqkOkrlPNog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W9P3vws4w5HswrYp8KQrTpZhQIyy8K3WwtSm5u6Ky6Q=;
 b=yeheL7OSxpaUG3I2SPP8YWjdWg7A8qqaCdcTjkJWE/EBO79s7Y5hoyEYBEie6kK+IGFugrwTp1xqqyoKSdyFjUxV17Nju6fF5BX5OYexamszd+6dG9dMvL7DhKbYxmcIse+aoS6Hq/C9ZmQTwH7C65uwp9XHdGqyQAQNYg+oIqRWFKb6xzzJ47ubMCbwT919F1sO6XRZRuidBbZ50UOB7UU2FssElG1YK8Wo+iMrXYHdQZAKS3QfkwdTY3inlkfHnmf6JKOaQ2UI3/YMkDf9wE6foq+c5lWfbI9hE4p1kphyjku5PwCCcxCieU83ca65u7yRHFsGNlD4rMchV+j+iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W9P3vws4w5HswrYp8KQrTpZhQIyy8K3WwtSm5u6Ky6Q=;
 b=FJLzFk6wx2CTQbitgfBNxYNSyqlM6WoJXayaN7vvi6SxwHKroa+Xv6LG+YGpArif6FOp/y1o0/FMtegzpEJ8LRl9q5J35UT309CqzIbfIku8srgJUhqeynOOvH4va1EWCiNCI+ksFp6n88+ZLBkdg9thySvmr3TdnAxrbNpIFVEI3jwTUhKO7pKiYjlJJTsMLGUESMkgbM/VGBN5Fm94jtKPBGkFgsMrFZz/K8+NC/KkwUyHrS5leqCRfTSYhILBuTV1KJ0SnEodNbH4umM8tCWQfA059n9FTIQ9NIky41+jm2TTcPengyqkBjvLyJ3oKDBLTJyFLcQZp2tTNiZ7Rw==
Received: from SA0PR11CA0056.namprd11.prod.outlook.com (2603:10b6:806:d0::31)
 by LVXPR12MB999195.namprd12.prod.outlook.com (2603:10b6:408:3dc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Tue, 21 Jul
 2026 21:39:00 +0000
Received: from SN1PEPF0002636C.namprd02.prod.outlook.com
 (2603:10b6:806:d0:cafe::54) by SA0PR11CA0056.outlook.office365.com
 (2603:10b6:806:d0::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.18 via Frontend Transport; Tue,
 21 Jul 2026 21:39:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002636C.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Tue, 21 Jul 2026 21:39:00 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 21 Jul
 2026 14:38:44 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 21 Jul
 2026 14:38:43 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 21 Jul 2026 14:38:42 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>
CC: <joro@8bytes.org>, <praan@google.com>, <kevin.tian@intel.com>,
	<smostafa@google.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>, <jamien@nvidia.com>
Subject: [PATCH v9 10/12] iommu/arm-smmu-v3: Retain CR0_SMMUEN during kdump device reset
Date: Tue, 21 Jul 2026 14:38:37 -0700
Message-ID: <255196e7cc7c444726fdeaf30aec4583f52ada99.1784663184.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636C:EE_|LVXPR12MB999195:EE_
X-MS-Office365-Filtering-Correlation-Id: 4aa938c7-8fa5-4ad7-3ddd-08dee7707a07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700016|23010399003|82310400026|22082099003|6133799003|11063799006|56012099006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	jDt9qkNhrDB7cToAs90huVEooAhjtQ5PMpHpgoQus8Cez4jTVKUAHEDQo35MQV27nIZoSjYRhHCH59bKN03cxWuOntXPgYRB+XDY6tAwJuPgXO1bkfl7vU26/kCaHxrMljlE/lvSDXApkajTnm1SkQ9x0A0FhTqbv6tzm/V5qK5kdjx+MHX861lU7fQccobwd0ynhxUSeXLCLasMehul2Mp2bJ9wmgOsetje8GqObayryfF0CzROTqaZba7zJVivPUMxDURbxRIoHWjyXz0xDKSVZAxcivVGOMaKqkcNWxAbSWyv1gRmxrmw1jD0JfIdV/nQ06nha2rdH1OD9wjrWKmTl3iRZlaT98W4/iPtej3qyhQ4O4xt204/neRylEPRcLqiRriEROkYRsGzo5BEUINSoowlCfgy+pi+NOlZtKj2VtgCzeGlW5oeAx6LEVlyBr7oSgm5tzmqxzV0zMq7HbY1ZXVIkUlqQqK9Rd1ze99TCbDndv5FhwE+/Bxj2lIXwHOHaDYQjt5N8Sx1iVXICL9dBSmq92xKfut1EK0nc6sprL3+jSd1J7uauBCHFzty1yinGj79EJT7nfm63h/Tot5ZampBu+sOxhR/q35m/jJfqlLHIGU5ADw0Y+w5grNdTZodSnXgpuUv4E7GK/oSZOqaW/7LkeFuv7/1hfw0eOFyJCbhKSRpbmVnv2E1Scp9AS899lJzvCvMidv0Q8QQ8A==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700016)(23010399003)(82310400026)(22082099003)(6133799003)(11063799006)(56012099006)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	pUgKVT5gFXwNhqc/+LwRkvw+rAhHgwsBySXcukcXn17H0cZWvYHtW4DHwGyybk1eeOLVGu/RL6FNC1QqboX8HK91ZLn3V990pf64020+RUkLk1nAMFAccWC/Nul5F72Ls2tHzcLorPDvcYAYgnphsDTOhO2hb357NmeJLmxWHDkY1j1VcBggOyXRG2SpfNKVEmMSUAS099pGM7n2Mplzpnjt4j+6hLoFnWLr26zgUsEnQc7YxfrNxm2qqvgGJbQQymB1vVG293mbmahgZxM/Nb0GAl93K2XlmpbaYaQmOOsD7xb3TVLe5UaFMkDySY/+Q2up+AeGuphHuFXr/WAdZDDighg7TZSIxOOWbbhf/GNUyMj5AOh4WkzybwHetd7tR5kqNk1nKxJ7bd0D4eK/9c9944zuxOYJ8xDUSrCXzgrjsZ9ebsNK6MvajErKJp0N
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 21:39:00.1479
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4aa938c7-8fa5-4ad7-3ddd-08dee7707a07
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVXPR12MB999195

When ARM_SMMU_OPT_KDUMP_ADOPT is detected, do not disable SMMUEN and skip
the CR1/CR2/STRTAB_BASE update sequence in arm_smmu_device_reset(). Those
register writes are all CONSTRAINED UNPREDICTABLE while CR0_SMMUEN==1, so
leaving them intact lets in-flight DMAs continue to be translated by the
adopted stream table.

Initialize 'enables' to 0, so it can carry the retained CR0 fields in the
kdump case, clearing only the queue enable bits. Then, preserve them when
enabling the command queue.

Clear latched gerror bits if necessary.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 60 +++++++++++++++++++--
 1 file changed, 56 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index fdfb69d2e51ac..aff7b6b4527a5 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -4781,10 +4781,28 @@ static void arm_smmu_write_strtab(struct arm_smmu_device *smmu)
 static int arm_smmu_device_reset(struct arm_smmu_device *smmu)
 {
 	int ret;
-	u32 reg, enables;
+	u32 reg, enables = 0;
 
-	/* Clear CR0 and sync (disables SMMU and queue processing) */
 	reg = readl_relaxed(smmu->base + ARM_SMMU_CR0);
+
+	/*
+	 * In a kdump case (set when CR0_SMMUEN=1 and !GERROR_SFM_ERR), retain
+	 * all the live CR0 fields, e.g. CR0_SMMUEN to avoid aborting in-flight
+	 * DMA and CR0_ATSCHK to carry on the ATS-check policy, while clearing
+	 * only the queue enable bits for this kernel to take over the queues.
+	 *
+	 * According to spec, updating STRTAB_BASE/CR1/CR2 when CR0_SMMUEN=1 is
+	 * CONSTRAINED UNPREDICTABLE. So, skip those register updates and rely
+	 * on the adopted stream table from the crashed kernel.
+	 */
+	if (smmu->options & ARM_SMMU_OPT_KDUMP_ADOPT) {
+		dev_info(smmu->dev,
+			 "kdump: retaining SMMUEN for in-flight DMA\n");
+		enables = reg & ~(CR0_CMDQEN | CR0_EVTQEN | CR0_PRIQEN);
+		goto reset_queues;
+	}
+
+	/* Clear CR0 and sync (disables SMMU and queue processing) */
 	if (reg & CR0_SMMUEN) {
 		dev_warn(smmu->dev, "SMMU currently enabled! Resetting...\n");
 		arm_smmu_update_gbpa(smmu, GBPA_ABORT, 0);
@@ -4814,12 +4832,41 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu)
 	/* Stream table */
 	arm_smmu_write_strtab(smmu);
 
+reset_queues:
+	if (smmu->options & ARM_SMMU_OPT_KDUMP_ADOPT) {
+		/*
+		 * Disable queues since arm_smmu_device_disable() was skipped.
+		 * CR0 fields are independent per spec, so the queue enable bits
+		 * can be cleared while retaining SMMUEN=1.
+		 */
+		ret = arm_smmu_write_reg_sync(smmu, enables, ARM_SMMU_CR0,
+					      ARM_SMMU_CR0ACK);
+		if (ret) {
+			dev_err(smmu->dev, "failed to disable queues\n");
+			return ret;
+		}
+	}
+
+	/*
+	 * GERROR bits are latched. Read after queue disabling so that unhandled
+	 * errors would be visible. Ack everything prior to re-enabling the CMDQ
+	 * as a stale CMDQ_ERR would halt the CMDQ and new command will timeout.
+	 * Acking SFM_ERR is defined too, although it would not exit the SFM.
+	 */
+	if (is_kdump_kernel()) {
+		u32 gerror = readl_relaxed(smmu->base + ARM_SMMU_GERROR);
+		u32 gerrorn = readl_relaxed(smmu->base + ARM_SMMU_GERRORN);
+
+		if ((gerror ^ gerrorn) & GERROR_ERR_MASK)
+			writel(gerror, smmu->base + ARM_SMMU_GERRORN);
+	}
+
 	/* Command queue */
 	writeq_relaxed(smmu->cmdq.q.q_base, smmu->base + ARM_SMMU_CMDQ_BASE);
 	writel_relaxed(smmu->cmdq.q.llq.prod, smmu->base + ARM_SMMU_CMDQ_PROD);
 	writel_relaxed(smmu->cmdq.q.llq.cons, smmu->base + ARM_SMMU_CMDQ_CONS);
 
-	enables = CR0_CMDQEN;
+	enables |= CR0_CMDQEN;
 	ret = arm_smmu_write_reg_sync(smmu, enables, ARM_SMMU_CR0,
 				      ARM_SMMU_CR0ACK);
 	if (ret) {
@@ -4885,7 +4932,12 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu)
 		}
 	}
 
-	if (smmu->features & ARM_SMMU_FEAT_ATS) {
+	/*
+	 * In a kdump adopt case, retain the crashed kernel's ATS-check policy
+	 * captured above rather than forcing it on.
+	 */
+	if (!(smmu->options & ARM_SMMU_OPT_KDUMP_ADOPT) &&
+	    (smmu->features & ARM_SMMU_FEAT_ATS)) {
 		enables |= CR0_ATSCHK;
 		ret = arm_smmu_write_reg_sync(smmu, enables, ARM_SMMU_CR0,
 					      ARM_SMMU_CR0ACK);
-- 
2.43.0

