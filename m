Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2088.outbound.protection.outlook.com [40.107.95.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A780F81749
	for <iommu@lists.linux.dev>; Sun, 28 Jul 2024 22:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722206725; cv=fail; b=Eyi4NcAHxnuY8L+aP3zE/j9PmDCHe0wlkHG91tNccLPGx1qpcXdJL3xuuTovi2yGliQM/UX8Pa3wY444GPp8GpxcY0mIJ52LFLtTWEgLoZabgXPK7P6pEMMziWPLipnL6AYtJ8OVlipocC0P5L/sZeBg/Dsthw3fB2deaMg0EN0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722206725; c=relaxed/simple;
	bh=hiAI0WgtgYqigGFXj8P6PtDw3hUYC7coDdrHRKzo+mM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lc7v6GhIilH7eEUJlJBam+U/6IDIGuMciKg12HMIChpxrpK0Ti9EVwaSvG60rweeNEsBTQuBViJZPLtvdtoeRWF5ZZ86w0rLnnPWFMOL4nac1ynOodHxRMxbHHHSgVXFIhkdqHOaPPb+qFpfGlEspC6vLckuaMopbInHGNJ//d4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HnZ2MfL2; arc=fail smtp.client-ip=40.107.95.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HnZ2MfL2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w6O0tFAMKqbZoaK7UStVy1fi81x8zqU9uWqm3V/Uvn1o+E4f/atu/IIvIvaJMa1djeU30AuK0OgktvLHREXha6NYtlLl6PAWabpfuJO9cWs2em5g1ok4eaf9DBGEa9aolDP/JRdhl9SLm73uuQZoGwTiSy7YATJci+c1/sWUJ93d7bzHLH0jw13bTQ3BSffh+Id00m/FBS1pBi3mSzvop/UhvKMmTa2lWdNH2TfbyfstmXAbre3z0posvS9cE+7otxRMGjMNruT+iUB+rfIPpMl9cvYwDJXRsRWd2C//Ra+ttxnfmIRbONO7eR2cVJ207pkaWrXt3sa77aVN3Ox0tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0lX330gpONN9VLSnuGmr1Xpjw47SVCwsTiFk7BWjFqk=;
 b=d26O9u0DVW+WDElBRrMw/NjD0x5Yl5qWB/7Lxkrjen5NLxAdXA1YjZIv2D9BktVlB1nQ080uBHAtSQB757YHgDl1niukHjzW0hFtGIpqTcC/jeOntXgbiY1aICDvm7BfCWNougg9wDAJYAN8oxogUJy4Ebu0ct8/T+xtv+Ac36/e0JCmztiQP6nyyUnqhwE0j2oZHdgB9koGc647PE51qyxQbWeS7m5ib11z18eufuHeTDEE+23pOJvwUHGqPmAY/v/IekO2qlT8JxEgX/zH2eppzNlOXZzAhNBN6a8Z8+ukR4VEbUm2sGQNsZRghercMl5jDv/28SI5cJHHZ0ElDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0lX330gpONN9VLSnuGmr1Xpjw47SVCwsTiFk7BWjFqk=;
 b=HnZ2MfL2Qrts5+t99O0H8rGkCyWgq05iUMyFGxzDCEHEfJcE/au4Q+6qbsoaeqq1LU1nsm67FHLS5c2mcgoEk1f5EkFtqWIsrzGSgeYw3+LU2aYeHl2xvX9uUWs8mfg0Q6kgmZ/Ptmp6IOjbcCoZLt/wRPYgFuEKL0dgSN9/HMrQTfK81EhQK78ro+w4+NbI8wIUsmJ+TOk4uw5MleqCnD+W72inox+76SHPIAH7sKiHNRkjlsC+kYbMFW8NwzPQxtE2GHb3rWWT/zzGRDYezKHTu+s5XmtPHpI+Jc5iOwRycwa/xD3ScPVAMa8hAFVpn+oU/ogy1mEjAAhpBM4v7Q==
Received: from MW4PR03CA0126.namprd03.prod.outlook.com (2603:10b6:303:8c::11)
 by MW4PR12MB6874.namprd12.prod.outlook.com (2603:10b6:303:20b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.26; Sun, 28 Jul
 2024 22:45:20 +0000
Received: from MWH0EPF000A672E.namprd04.prod.outlook.com
 (2603:10b6:303:8c:cafe::2d) by MW4PR03CA0126.outlook.office365.com
 (2603:10b6:303:8c::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.34 via Frontend
 Transport; Sun, 28 Jul 2024 22:45:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000A672E.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7784.11 via Frontend Transport; Sun, 28 Jul 2024 22:45:19 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 28 Jul
 2024 15:45:08 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 28 Jul
 2024 15:45:07 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sun, 28 Jul 2024 15:45:07 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <jgg@nvidia.com>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>
Subject: [PATCH v10 6/9] iommu/arm-smmu-v3: Add ARM_SMMU_OPT_SECONDARY_CMDQ_CS_NONE_ONLY
Date: Sun, 28 Jul 2024 15:44:51 -0700
Message-ID: <433068cfde6748f3e51aaddfa0ced9be97b0a5c5.1722206275.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1722206275.git.nicolinc@nvidia.com>
References: <cover.1722206275.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672E:EE_|MW4PR12MB6874:EE_
X-MS-Office365-Filtering-Correlation-Id: b6a5712c-7ff9-431a-ecba-08dcaf56f574
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aJa0wDd25pGgxyx+FCWUCm7hAgFSjmJhPLKLdG7jpvP4oZ1UN2UbkO3dmybX?=
 =?us-ascii?Q?eZhPc4jaMQM4acys2mLw06eqIb76fXtX6jhqbz38wtSZWtJBALXU+8yECUeP?=
 =?us-ascii?Q?Y8/Z7vhtlrDetaU42S0shlnqyDasg5IUe4h9M8rylfxO9rBurMpyMRke3zbW?=
 =?us-ascii?Q?32zcE5G24OCn9PBDpAoDtTsKWQAZKchMGdyI9pgYyrqgqZAvzXDuHPSp2t8d?=
 =?us-ascii?Q?y+ILKzLwU6jUtg6qqoDxeEq66sPb0Ku2Yf9MztLQlw9DulMTzSa4tDoRCKBg?=
 =?us-ascii?Q?sQoBhIC0FBEeBcGqdTcD7aLeRxI5DqbXkEcDkTscwYyBWxSI1P0kZf+g8607?=
 =?us-ascii?Q?A97cOBVHTs7tZF5ZYpdGoqcEXQOUKzwYvgBAhkVLLkB2tGPEEnAGFHc4M+Yq?=
 =?us-ascii?Q?qxU+gj/x3Q8pghCTLe8nAnLp20jcDowlwKukRjULhjoEG62xs+OUB0E/PPGx?=
 =?us-ascii?Q?geEPPcHvPbqIindmg952itID91rugMxiXzVYenrrpQZ3nyIijOQ1cZPZEySp?=
 =?us-ascii?Q?cPsQDdoyqgn+NHzJN4uvNUljOIowbZY8kSHBI7Uj6LAZfUBdsPdvN8FgWJM/?=
 =?us-ascii?Q?CQWx/q7YJcVZZt6EnStfEmb+rKeo+7X226bdlO91OMPOHRljF3qP+or6ZUz4?=
 =?us-ascii?Q?N3wEPb68squ2s1qu7sOXkGXFK6FQpzYsgOyy6vLsJmErtaKRktqh/nw/w2xW?=
 =?us-ascii?Q?6LaV13MP4jJ6BlkZaH3QkxjVSN4jEx/z361Ht9hK5n2tZfykk4/DojgjuwVd?=
 =?us-ascii?Q?8obAAKIG+ZrCQs0d0vKzg7HCkaeI4JGsun8Vi96HcCR+/qhuv0fuuBkUsqNg?=
 =?us-ascii?Q?COThFXr/hzoNBg9DM2KSu9IVLauK4j/WlM6jMBKmHDYtTkEisJBxafIiwjb3?=
 =?us-ascii?Q?84WevFTjcZRQBFlQulnQwtVL5+kb2kgLxXhs2/tjmVPZ6lp8k2K4U+Hby8sy?=
 =?us-ascii?Q?OfDgt+j3ZmktrCpj6reXRw1q3wcT99h4QqAlOtw/ZYf7csmNY/Q+1oPTLoJi?=
 =?us-ascii?Q?Vl5Je8RidSUAROyBbdwYHuIMWGQTcT7BD+jsPdljSYHLB3gljPI4jf9mtaVK?=
 =?us-ascii?Q?4b0/NQibvn0BlNP0X86i/mBCW+gS89U3bpd1/5zpSfM20phbuCCvKPCheqnr?=
 =?us-ascii?Q?IIah9LTYfdnjZcabMWejS2QmeYwDOiOfQ6F7j6GT3V1PSQiMEm9q2nO6wdo2?=
 =?us-ascii?Q?1LOGYlOXZz7m5vZcmbgg0yO8vPKzgfiLIxil+3M3Sp9jNihcrImAzElsAdHB?=
 =?us-ascii?Q?4RomFYQFDS4pUUguA+yujMuBYBxpCvBoSNDCEBqKticwz5vbZJuUqFunfQyK?=
 =?us-ascii?Q?EH34Pglf/x1EACBPziYHrBrqOhMIEGsfX41DgGaIm9n9PI4ez/F3CvasLLPx?=
 =?us-ascii?Q?t//ACgfzpPdSLVWZVdlhL0UnjLaYdJHFAGVqfXoxzTeNOHaCFHnI9Ai8Z2Py?=
 =?us-ascii?Q?p1ahrLR24ZeMRtbjiXsR3H9U51JXyvrc?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2024 22:45:19.9115
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6a5712c-7ff9-431a-ecba-08dcaf56f574
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A672E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6874

The CMDQV extension in NVIDIA Tegra241 SoC only supports CS_NONE in the
CS field of CMD_SYNC. Add a new SMMU option to accommodate that.

Suggested-by: Will Deacon <will@kernel.org>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 17 ++++++++++++++++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  9 +++++----
 2 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index df11490958606..e764236a92166 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -341,6 +341,15 @@ static struct arm_smmu_cmdq *arm_smmu_get_cmdq(struct arm_smmu_device *smmu)
 	return &smmu->cmdq;
 }
 
+static bool arm_smmu_cmdq_needs_busy_polling(struct arm_smmu_device *smmu,
+					     struct arm_smmu_cmdq *cmdq)
+{
+	if (cmdq == &smmu->cmdq)
+		return false;
+
+	return smmu->options & ARM_SMMU_OPT_SECONDARY_CMDQ_CS_NONE_ONLY;
+}
+
 static void arm_smmu_cmdq_build_sync_cmd(u64 *cmd, struct arm_smmu_device *smmu,
 					 struct arm_smmu_cmdq *cmdq, u32 prod)
 {
@@ -351,6 +360,11 @@ static void arm_smmu_cmdq_build_sync_cmd(u64 *cmd, struct arm_smmu_device *smmu,
 		 FIELD_PREP(CMDQ_SYNC_0_MSH, ARM_SMMU_SH_ISH) |
 		 FIELD_PREP(CMDQ_SYNC_0_MSIATTR, ARM_SMMU_MEMATTR_OIWB);
 
+	if (arm_smmu_cmdq_needs_busy_polling(smmu, cmdq)) {
+		cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_CS, CMDQ_SYNC_0_CS_NONE);
+		return;
+	}
+
 	if (!(smmu->options & ARM_SMMU_OPT_MSIPOLL)) {
 		cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_CS, CMDQ_SYNC_0_CS_SEV);
 		return;
@@ -697,7 +711,8 @@ static int arm_smmu_cmdq_poll_until_sync(struct arm_smmu_device *smmu,
 					 struct arm_smmu_cmdq *cmdq,
 					 struct arm_smmu_ll_queue *llq)
 {
-	if (smmu->options & ARM_SMMU_OPT_MSIPOLL)
+	if (smmu->options & ARM_SMMU_OPT_MSIPOLL &&
+	    !arm_smmu_cmdq_needs_busy_polling(smmu, cmdq))
 		return __arm_smmu_cmdq_poll_until_msi(smmu, cmdq, llq);
 
 	return __arm_smmu_cmdq_poll_until_consumed(smmu, cmdq, llq);
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 6c5dc2f10a330..71818f5860364 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -658,10 +658,11 @@ struct arm_smmu_device {
 #define ARM_SMMU_FEAT_HD		(1 << 22)
 	u32				features;
 
-#define ARM_SMMU_OPT_SKIP_PREFETCH	(1 << 0)
-#define ARM_SMMU_OPT_PAGE0_REGS_ONLY	(1 << 1)
-#define ARM_SMMU_OPT_MSIPOLL		(1 << 2)
-#define ARM_SMMU_OPT_CMDQ_FORCE_SYNC	(1 << 3)
+#define ARM_SMMU_OPT_SKIP_PREFETCH			(1 << 0)
+#define ARM_SMMU_OPT_PAGE0_REGS_ONLY			(1 << 1)
+#define ARM_SMMU_OPT_MSIPOLL				(1 << 2)
+#define ARM_SMMU_OPT_CMDQ_FORCE_SYNC			(1 << 3)
+#define ARM_SMMU_OPT_SECONDARY_CMDQ_CS_NONE_ONLY	(1 << 4)
 	u32				options;
 
 	struct arm_smmu_cmdq		cmdq;
-- 
2.43.0

