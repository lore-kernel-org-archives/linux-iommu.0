Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2077.outbound.protection.outlook.com [40.107.94.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403F418B47B
	for <iommu@lists.linux.dev>; Thu, 29 Aug 2024 22:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724970913; cv=fail; b=cD0HBjOPpo62rT506p0XOB29f3OtT7YhzFLsDalvsVGqAOuA3Ut8hAPWQ4ySnIczmoyA0e+7cKEMgyuP3+gV9GauB4bPg8RB7VM+nJDPVOstNQHVb93STk4kK6ttxbroaakrkGBwVxfbeZfHUjhOWrsJMHwBXYVwLy/8/OR9NbY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724970913; c=relaxed/simple;
	bh=e8M9tqC1ajI6NFfmvfAnknOkCPHfjoZbju/a/T1kyZ0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y07dzrGmWVuq3V00rT8Yne6IPGhj7dbSEGMVFifc7OVTeOmBG7a5f8pOaXqLjSIKjDeLV2CoHvz2TnWnJyYXr3wMvHss6grLfGPa4fnsXRI89cpbp1aXU6x+OaOy8B8IIPmTL9rbDyKMxNJ0PX2zwDeJR2ChWerB8ClKMVCE/ZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=clTmNF5b; arc=fail smtp.client-ip=40.107.94.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="clTmNF5b"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AuYVVMELpSnyhceAS27QO4ElriXkMX3U+IxVMthTQJ/TrQ5VdC8f/N5aI0lTyQomxYz39v1vIpkZEXtcL1dlEVfyBJ1ZexY1cEFJ++FgEN5H2YNvB2iPlWjQXW5YD04m1mDyviePcKkCBlDegp6Ma6f4aotykRgTmmbROM2HIpLnMwrM5G73bTvTK68j7rUXifKGwVwPc50+XEQgrFELC4/xGDlVuMdXUvRwARnCOU28347dJlv04tbaYEc8zhNByrsjZKZZGLmn9Bz4Lii9b56/qS7e4oX7B44e541pNu8AKxt88J+v8YfI65BPp6MrSylh3fV1sC6K6ivrg5+Flw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gRSMMVqdw5+aOnt0Ueaq1uh6NKA0iHoK4V3nwEJnv5s=;
 b=Ntn14hU6IBw+JSD0CIwz5cFk5RBEoOwAV9fQJzq6KUqL9s6vgEmLhC/kS+J/q1fz+7W+5OzqtCC7+Y3RGwvRJTrxbIS6NQ+R95C6+PSjwLbg/72EMsTuPhuWUIFIihQSPXj2i0iHq0yQmJ4m/0XEiOpFM5ELFvlwjHgq4vy/jz6mbNtrZ1v3B9KFrfvlGY23hrtVD597kHpW/GnSIVv8kpk1MZmmGafiOs8efIv6/BfRIIu7IzJWlUYKTSaBTDNDv+yzf5Q2NciDc1+tkzw9EsK+uETXG2wwe+V6e8g0+obDgzVdcu41Flwccny0STurkPnP0FJJsKvg+o2VCfBIyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gRSMMVqdw5+aOnt0Ueaq1uh6NKA0iHoK4V3nwEJnv5s=;
 b=clTmNF5bg7X03eJIshETNogGki2IE35fZ4vDOQ9YxeLXcqISVdmPVNcZ3OuT0EGZ0vtnsFGCP3Qpq0/JRTh+OfPw6vE3tZSss4Y5v/6LQdiX4FwCVCO5LZWPLJdULDTGQQVoy1w8mqX4iHKPqluyLU4Si0CA2DzaZYsa4c+GaTiRouTRzRf96OJ/xe3otAVdiwn+RZKFppcyKgdR6/PeUrBzWFIfpSWKcsoUQT8WMjGFX6bcDlkAICPJqYyd5DCXF0pFhBliBddAdMfIHCeptAyDkjPclV8cMYsD3e/0PwJfIdaRxEgAW+VBpP/MIySXOYCMtZbTKx7s2GKTXBpLPQ==
Received: from SA9PR13CA0093.namprd13.prod.outlook.com (2603:10b6:806:24::8)
 by CY5PR12MB6273.namprd12.prod.outlook.com (2603:10b6:930:22::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26; Thu, 29 Aug
 2024 22:35:08 +0000
Received: from SN1PEPF000397AE.namprd05.prod.outlook.com
 (2603:10b6:806:24:cafe::23) by SA9PR13CA0093.outlook.office365.com
 (2603:10b6:806:24::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.19 via Frontend
 Transport; Thu, 29 Aug 2024 22:35:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF000397AE.mail.protection.outlook.com (10.167.248.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Thu, 29 Aug 2024 22:35:08 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 29 Aug
 2024 15:34:53 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 29 Aug
 2024 15:34:53 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 29 Aug 2024 15:34:52 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <jgg@nvidia.com>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>
Subject: [PATCH v14 09/10] iommu/arm-smmu-v3: Start a new batch if new command is not supported
Date: Thu, 29 Aug 2024 15:34:38 -0700
Message-ID: <aafb24b881504f18c5d0c7c15f2134e40ad2c486.1724970714.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1724970714.git.nicolinc@nvidia.com>
References: <cover.1724970714.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AE:EE_|CY5PR12MB6273:EE_
X-MS-Office365-Filtering-Correlation-Id: 6521e92b-56c9-4e3a-875e-08dcc87ad61a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?amlAG7i/7j6Vrdw/4rlPyFhu6nttvgwE/JNKzIdAd+OphoZIxPvewoKva7GT?=
 =?us-ascii?Q?UpktKnGQ9bLP+RNfUuOgPL0T4JkxcByzMnIgHIOoX8Ll2oxZRALnV4phlU4V?=
 =?us-ascii?Q?NeqgkolXUNJOCs+qTpE7QB2OKSwq0HdVxifLQ86Vv+VO2rgHpmEsKY3fY+ia?=
 =?us-ascii?Q?G1/ZDrlfChylO2CWLTNB8HRkWUQrTYfC12GLtNc+Vl/txXvHevLNFQLQSEAs?=
 =?us-ascii?Q?rRXuqpXALTBnd32p9zR+dCnrpPYcYEtgfJaPfyQzCrAiKoPZoK+rZoUoGVuk?=
 =?us-ascii?Q?Iadaz2sPdXshPkwUXjuzCqbJLnKesSBLkfcK3yYAEKhyQmWmwijBUYK951Ij?=
 =?us-ascii?Q?M1yrjCRO0SDc+Ff3uQemR40jKcWaqkybYB5MKx3g4pUc9YVueAt8nI7SKPRe?=
 =?us-ascii?Q?xpAdo0e2YjUk1F2hQyUgUQHcbs9XsMDZSFfxTRs8BGFbLtnI5LvIiCfDYOt/?=
 =?us-ascii?Q?t8svrgTnibbXwHDHv/5v3xi2krG4DCs/o2dLn6lALDBJHAOKDBUHUZGODaez?=
 =?us-ascii?Q?jFKgOTyMcIHbgBZEPT5ZE8NC7VoZRmQ+MtrR1LEojBUHspcpKfGiWZLgTYF9?=
 =?us-ascii?Q?0BIoNrlmX0HQzE2/98k6G1nf4i+tWkU3ERVo+g8dxgntu5HE3hJE0sIjsj2T?=
 =?us-ascii?Q?nyG+Y/x9v7bRrauKkk+Ykb8wYumJe0dbnmZmfg24DBYPHr9oirqfnuEYqGyl?=
 =?us-ascii?Q?Wyl+mu7eQW37YSYvX2l4eNbmFrYSMZNGxWwiX9/n9EA/M0uSiawqZPbpB0k6?=
 =?us-ascii?Q?oGGp+I/E0T7aqhwlmv4RVe//1vW63gs9kJ68KEJL5fZNBvEdyDN5RSj+ZABO?=
 =?us-ascii?Q?hbH6TjJ7YcGAjkPPfdVNDkWWNSNnigKqzMDYOU2ocIyaOrBbrM3VVrJ3/atV?=
 =?us-ascii?Q?dvsHOxtqXxl35d6ipMCsPZeh1pJlsstqHuFsg3sRPJ5HinwoM7XjiomcKPK9?=
 =?us-ascii?Q?CzDIcbz27Ykdii7MmEV0G9ouez/OezXu3IIPOyHx4AAEkR5SdlMw9SW2Q83M?=
 =?us-ascii?Q?flJGmRWaXFKHTFoWYStSa7PtcfF/FSjiTVn1ituRb/IpCksD372rLliI+KWN?=
 =?us-ascii?Q?8VO5TNWHEHAKNMSHvSapLqKKJeLiKCnxoasdwrWjBxuC2fV5405IX6y/1wzk?=
 =?us-ascii?Q?DVwGELs9xAE3PeG/1s9XBjn8lh34sP8a0wo/5lXlcGhFwINUhT59BcknhrSv?=
 =?us-ascii?Q?VzOW8iATwNHtPYlTG93cBpsbSawCfDXtb8IusJOF/A06HAMb7OSAv3IlER+M?=
 =?us-ascii?Q?Bq+0vCuO9uAn8bD/3UJR4bp0h1l0WVgpkGmhDeXlKgc/CJZ5lfeo3G2FK9ys?=
 =?us-ascii?Q?U98vEAd3r20IUPRCu+8ryIP4wjfn9pCsRbILPaU2SYmFDh5m3fIJtj3iw9iv?=
 =?us-ascii?Q?IbYRWmee4X2BPUYaE9Wz1DUvYQpNESQYh2XKqIvc0ysJNHEES6mN31iRrKP0?=
 =?us-ascii?Q?3DWklkYoMCLOqyaRTMTHxsASDjcs8zFV?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 22:35:08.1989
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6521e92b-56c9-4e3a-875e-08dcc87ad61a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397AE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6273

The VCMDQ in the tegra241-cmdqv driver has a guest mode that supports only
a few invalidation commands. A batch is initialized with a cmdq, so it has
to confirm whether a new command is supported or not.

Add a supports_cmd function pointer to the cmdq structure, where the vcmdq
driver should hook a command scan function. Add an inline helper too so it
can be used by both sides.

If a new command is not supported, simply issue the existing batch and re-
init it as a new batch.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 6 ++++--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h | 7 +++++++
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 9e71e404fd7f..9cd0e8fd78eb 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -923,10 +923,12 @@ static void arm_smmu_cmdq_batch_add(struct arm_smmu_device *smmu,
 				    struct arm_smmu_cmdq_batch *cmds,
 				    struct arm_smmu_cmdq_ent *cmd)
 {
+	bool unsupported_cmd = !arm_smmu_cmdq_supports_cmd(cmds->cmdq, cmd);
+	bool force_sync = (cmds->num == CMDQ_BATCH_ENTRIES - 1) &&
+			  (smmu->options & ARM_SMMU_OPT_CMDQ_FORCE_SYNC);
 	int index;
 
-	if (cmds->num == CMDQ_BATCH_ENTRIES - 1 &&
-	    (smmu->options & ARM_SMMU_OPT_CMDQ_FORCE_SYNC)) {
+	if (force_sync || unsupported_cmd) {
 		arm_smmu_cmdq_issue_cmdlist(smmu, cmds->cmdq, cmds->cmds,
 					    cmds->num, true);
 		arm_smmu_cmdq_batch_init(smmu, cmds);
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 9fa22ee2383d..4deb40cfe2e1 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -568,8 +568,15 @@ struct arm_smmu_cmdq {
 	atomic_long_t			*valid_map;
 	atomic_t			owner_prod;
 	atomic_t			lock;
+	bool				(*supports_cmd)(struct arm_smmu_cmdq_ent *ent);
 };
 
+static inline bool arm_smmu_cmdq_supports_cmd(struct arm_smmu_cmdq *cmdq,
+					      struct arm_smmu_cmdq_ent *ent)
+{
+	return cmdq->supports_cmd ? cmdq->supports_cmd(ent) : true;
+}
+
 struct arm_smmu_cmdq_batch {
 	u64				cmds[CMDQ_BATCH_ENTRIES * CMDQ_ENT_DWORDS];
 	struct arm_smmu_cmdq		*cmdq;
-- 
2.43.0

