Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011028.outbound.protection.outlook.com [52.101.62.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0943621CC5A
	for <iommu@lists.linux.dev>; Sat, 11 Jul 2026 00:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783731200; cv=fail; b=TV1dOG5ECzPfJyXO9IoVPj9y7qvzC7FiU4E1ohS2UCjSo1KQNGg/+xlu6B4Na+o5UH6yixhZPCIA4mX9/gr0oGB8CcHxHu4ndFSQS4VSNGYD24Owk9EB/h7bcy6GYdJVQg3shm4/A5Inzl1OtgNjktB4pZ1BfOPTbogEafUrg0U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783731200; c=relaxed/simple;
	bh=ijTe8LhBQ7sirnvHm7QD8sB18eLaOnWqrSiFDKbIL18=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LILauGJtMoQTGAq9mnzM1UqYEnCcbP9CLIlSoCp/xJojbqPyn/IWM1QEvk8qGJAub/xru5iQ9p38f6B2PiTFPBpdfGLBw/LM8lhePCfjrhbxcsy9aw01M8DUd60giGpNTLCrwiMkVxDyryOjkA50BowDFeKr88yqmh8mICdx8zE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iFjT7qJR; arc=fail smtp.client-ip=52.101.62.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iFjT7qJR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=crYUiDSDPPSzWpoHHrwPh8DdbngoDyPvy3bgvdL4BrSEqM+jcum21PalHbQl3jtnEtSlaOJP7e5bSp+ZALfP8OT5gquZbkK/NW4s8nUUghNuNizUubpoageiqYzWDvas6/g5IF/IWfo1AYF/tdjuPquuzByxKSBRMO6pdczKnAFmDtJ0Pt8u5nij6p2Jt7dRi2n/KE/dRox0YUl9V00S5RKJkvtYMt6uwjrro7Rn+2ueb4HvPjexdtOSmd5szkZ+QWfHJGqjIs4QAwttnM9UMY31v4vVkdUkCFykJ2l7sENHj5Rl/chrVJL/fmCvQZR1peUSfNpxU+8g6KzMrl+RlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p5pT36nqb1+MuEyIOL+WrcfHNl25MJNp5XeOnEX0WGI=;
 b=lq7APpbExdZLUpKyOHT8g0fJ+sA9kVP2kAVOmgt2nigDyY6QjVMWGeubRAkaLxCkjEfDLM22hbZYvntX/EMQM1SeA5rxSTKV86j1tJFNZnIoPI6mgeLw83cnnwUfh/4G1Jy6XhBYV5AdwRVREecVug8h/gxrBfl8pPe9zFGF+t8b2O+rImw68WKUzkAXALnhwhCH06nN0MonaysurX2Jaq/u9kmTEQzlHcImeeyq9Vhjz3MZ7y3L34z9h3CdrIVLd4HDknqEp93W/eKjOIC/1XpowD1jAZlkc66Zj+IdA1pTSneErCG17tH08Buu2IrUQVbCWjvaVGoWZDqzdRhPeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p5pT36nqb1+MuEyIOL+WrcfHNl25MJNp5XeOnEX0WGI=;
 b=iFjT7qJR6CeAJXjxdsljT+8YEdmcivQG5yh2OTl2DthfNeCWzoQ4oIHLfmXXXK8E3XjX8OlfYGVWFSSZAHkIzmz+oNFFaouPr9gLJ3J0h0+UX1AN7xwPfCZPXH3dOh7ZVamKgdD1hSYuLXI2+3sch3xJ3dDmOosBsxHxJNrRLFK6JUsQoaqwBcacH7MEllCeHs7E3BUocBZGUePFS6hVVm1lubYG/K4ZMCLs56GYEf6cIrvC9LloiWj2k1HX2q3q6alxWvH74/fLmRAsycdbR1hABmWqnar/hbfba+0eGIQZWNkp2hAAIGmhMEHEuddDNM9Be7Eh7AQNNFG8WJc2jg==
Received: from SJ0PR13CA0079.namprd13.prod.outlook.com (2603:10b6:a03:2c4::24)
 by CY8PR12MB8338.namprd12.prod.outlook.com (2603:10b6:930:7b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.17; Sat, 11 Jul
 2026 00:53:13 +0000
Received: from SJ1PEPF00001CEB.namprd03.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::27) by SJ0PR13CA0079.outlook.office365.com
 (2603:10b6:a03:2c4::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.6 via Frontend Transport; Sat, 11
 Jul 2026 00:53:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00001CEB.mail.protection.outlook.com (10.167.242.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Sat, 11 Jul 2026 00:53:13 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 10 Jul
 2026 17:53:03 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 10 Jul
 2026 17:53:02 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Fri, 10 Jul 2026 17:53:02 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>
CC: <joro@8bytes.org>, <praan@google.com>, <kevin.tian@intel.com>,
	<smostafa@google.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>, <jamien@nvidia.com>
Subject: [PATCH v8 7/9] iommu/arm-smmu-v3: Retain CR0_SMMUEN during kdump device reset
Date: Fri, 10 Jul 2026 17:52:48 -0700
Message-ID: <28cc228a127cccecaf86eeafedc852a9ea456c3d.1783729633.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1783729633.git.nicolinc@nvidia.com>
References: <cover.1783729633.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEB:EE_|CY8PR12MB8338:EE_
X-MS-Office365-Filtering-Correlation-Id: 693b38e1-cb4a-4f80-110d-08dedee6c986
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|23010399003|36860700016|22082099003|18002099003|11063799006|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info:
	GVvUM3S862BaijlPospCSeswXM3A8CRNHi4OK/lHFgH1tNV9d5cU7p7r5VYyTjOB7+U3KXRC2K4C+K4rkJZXqO2Z8S2DA9s+9rdGM7xYKQ35Tw3vguFnd+2vn8boAWDKX+ZX96iaWiAkRMU+NNK1u9c7c17LP22MOltd9VZkEXUqfyw8BPCDQTyNbQLjsrtL98lF6I24o6suqNb3kAlAuI9SIjNLdoMH0gPUOjyj4PD90W7fuX7dtBV/2AOokZ3roffCx2YOFXbf/ab4c5V/lOYWXp31kW9d7FcuJLZ7TgmuK1bk/o0IVIDUXY1P8S4ZZyKTg0l0FxQ9YmhUPZj6Sdh53Y+8tlpr+Wu64Mnr/+39qEc54liRqgWJoSMRVLQ/dySdWbMoa0Dl/vTEiZOetdOvaXhw1yNYt1pPLhPIu19IooaVTHqE9VqDM3xh8srchTyvYoWs6Cyqnl4RkavxB1nQGlGelh8CDlvtc/OKFzJGsZG4KZQQOHIbrfb02ZuFNTMN5/CPbu4CU4zdKXaDimFvT2C9jloiSP4s89tdi0kuQEAyLRaALy3A7s8WSFycr1X7XtfrlBV5Hk0w66MCsjq4r454pPBsue6VAbyFyoV1xLeIXFNwFSJ480wwYGw6fQO4oZwR66R/G7Ng/ZO6f+M8v+XF0r6WSqCiizvce96kPXvpYw0/XTzNdUjrseHdWn2O631H88gP3VvVgK4nxw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(23010399003)(36860700016)(22082099003)(18002099003)(11063799006)(6133799003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	cCynMVruQnM0gUKdL5TMAldpam5U4ntF3Vk/nnW1uv8hJOcqJw+A/37pWELCBQ44Py+5E2Sn3glMm3h2O7cU4vnlH8z9yoB1+e/35kby4Fj36CyP7PsLLGedODFSlwpEWqpv8JA+e1Bqek6Ht0mrxELz8OK4zERuDYAGvyyoxaCoNIqHOMAWHPQRvtNk1mDFhC4of2JAAL1Czd0lxLTpzf9HphIAU/x1hwxiBqa3nvd7MTFlhkU58Wn3uJ1ZOwfmwrgAnTjQyiIwEyZmEOJJfb8irbK30aVba0GqOj3ORWMX1oDtfwdVpvuHOL2vgHGFs0XK7XddOb181F54kqZbm/KX2ZaDXP6mam56JxgtrR8XC1/fg/qLZ3m3iLejeVpbeSCPiaEPs2cUk3XLNppXfQcQUmKwWKjUwRDqaOJ5zsutAaeY/XMq48BFWMig9xf8
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2026 00:53:13.7611
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 693b38e1-cb4a-4f80-110d-08dedee6c986
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CEB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8338

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
index 97c024c133f41..9aa1df1e53cf5 100644
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

