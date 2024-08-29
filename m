Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2044.outbound.protection.outlook.com [40.107.93.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C351BC08C
	for <iommu@lists.linux.dev>; Thu, 29 Aug 2024 22:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724970913; cv=fail; b=iy1SAprQILJqbVULNRPU9JQoIL9OPgSjNZewVTUxvjKGCBhNIiTcpPfpP7stKcxMsvVLIdvgc5HuziAE4TdDiNvxoUEWqLevwet9gs9KDIV01i0KTfpq9BVCkGMyj1Q/0R3u64O1G+aGS69zBr0Y2i1ip5Zf82JUXuNo2cGl3mo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724970913; c=relaxed/simple;
	bh=JE/gvcszqG/if5scZe2xM4Wb6oili1D/2fvMoWjWFEA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sCBm2ZwOEZ6uhdUdUtkRgiH4T9v2p5aNcTP63QhWoXKH2I0peRM6lyLWLevh7VWfZ1Rj3M6H0njEowrPnnamJFTzguHFuJJQZwp9PmUk5m0b0AhiZe2ApL12CBt62rhYQ543qKbudvYqlLsjELy5UeVFnGi8oriISsiAISjetgI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=t6Crz9u2; arc=fail smtp.client-ip=40.107.93.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="t6Crz9u2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qst343NLOcsf170f7lFx5yk8HSGQWLpLCUdwMHxczwnHNb5X/clGWKM9coZD86T2MnRguU5FUhFCjUT9+oHpVtzkBkvNh+YKUkT4tf/8DF8MIFwQDMZs++uWr/hyP+cxBxH7l7yRuO7/y5gIF/mnrntsHcChpSLKknMi7ZoSCT3G77cKOVdeMKogkVUyD/jWyZm2MS5OIMSg8nqiZncTYglVPzqYSlRd0SpotcVMDvfXvAOcTuHaN8yG8Uq5ugQLq8jIfOoM6t5/OGB7bT+c5XpPh+N0tm9j2oZyQok3eRPpjEL3tGXgRWocibvmMGxhq2p24oVIimx5z+SneHfK7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VVWIOjnwdruHzC9iF3hjNyuPjKRyhCuwlUXDIEgtrTo=;
 b=ujPb+BdLihmHDjt7bb3bSXzsGSniQ4NBGeN5gBLOLKRNK87+tJWf4SnAdN+tFQx1J1mGEwsd2Jimy83N6sI6gBKDz9vV2r19AO2P/N1GTqCfyt2MXQNztGU7RhOMsxWuNvgO7/fZX70jSXWHdF0MxBBd82Db+9eCeSkkEc2G7X8QoslbH86/xN2AjmFSwf3vDeKUFhihWZG7Uu5q7NvIJRQuAoVh61Qc3DFD0w9BWPlnq3h0Lu5occhF1jCo7BllOzGUqPgBe9lpunQQRWEXwyVksk7ONEnP7nV5AwUCeUzxSHxR2UO7IKTJldORBsHNrOrcLFvK4+LdHGS6g2lbUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VVWIOjnwdruHzC9iF3hjNyuPjKRyhCuwlUXDIEgtrTo=;
 b=t6Crz9u2Tsu0BM4ZntkpLT85rRT4S6YRjDoxvIO/Oq9d7eiwm4km5TafUdHNzB+Y51YwqjEYGx3f2clMAhdxBEOHVbcafNUWifjeGYWUDIhQB/UIQviOaMtuaNGXd5nM2YEHK/9pVAj3Y/XdjNMISxw+jHE0RLXlSVjfRVTeBF0aa8zu1cpDDADgfzsRr3aPYLe6P7k7B8niI12D8i8q007luP5x3Magj3CVvZDsM/rWb6y98HUyDcAG0Ivv0/A2k0h+secOt5ESAVJC6gTnBgtphXVEZMSOOVRG67MfQi4ZMRdquQEb0eR6Y0IfLoOgeWWFKf4d7wy/4bbQuLoYIQ==
Received: from SA9PR13CA0093.namprd13.prod.outlook.com (2603:10b6:806:24::8)
 by CH3PR12MB8257.namprd12.prod.outlook.com (2603:10b6:610:121::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Thu, 29 Aug
 2024 22:35:07 +0000
Received: from SN1PEPF000397AE.namprd05.prod.outlook.com
 (2603:10b6:806:24:cafe::25) by SA9PR13CA0093.outlook.office365.com
 (2603:10b6:806:24::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.19 via Frontend
 Transport; Thu, 29 Aug 2024 22:35:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF000397AE.mail.protection.outlook.com (10.167.248.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Thu, 29 Aug 2024 22:35:06 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 29 Aug
 2024 15:34:51 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 29 Aug
 2024 15:34:50 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 29 Aug 2024 15:34:50 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <jgg@nvidia.com>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>
Subject: [PATCH v14 07/10] iommu/arm-smmu-v3: Add struct arm_smmu_impl_ops
Date: Thu, 29 Aug 2024 15:34:36 -0700
Message-ID: <8fe9f3805568aabf771fc6706c116459016bf62d.1724970714.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AE:EE_|CH3PR12MB8257:EE_
X-MS-Office365-Filtering-Correlation-Id: d0db0b7e-d2e9-4152-684f-08dcc87ad559
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?S5vXADP37gJxCHE3wPUSBPjvMzQYFy+UyFzXnOvaRknYY3rLudm8/MDGRXfq?=
 =?us-ascii?Q?rI/eFFdmEvCt20W+Ue+/7Utf4jvlVZLLccOoQFMTsfgeugDwXOo4lyjkyC1Z?=
 =?us-ascii?Q?Na2GcOZ8LTx+NyAeJ4GRNXd4d7bmypCSop4DRfcWy7kceLEe2SVCiT4a5BwE?=
 =?us-ascii?Q?Isf3qxaTOsNiQwQSUJ5zQEDCyCCtL+rh+OCIyIU1Jjd+LLqm07pdmo072ulz?=
 =?us-ascii?Q?TK0avIODhTfdM30sy89Z4mPs6kgXIINiVMHiL2YkMo58Xa56nhdZZkAiyzhh?=
 =?us-ascii?Q?Cl+F8xi1Olgu+8moRjIHr42nfh0zonpRLXv6Ngf6pIz0OjvpMjyHRKyqzO6H?=
 =?us-ascii?Q?EbnMuMRxUZxbYt76Ctu65tdKEUdGNaHKCOEWDQ8UO5o0b5HyM+yTOJHVQ8Nk?=
 =?us-ascii?Q?ipEaufcQBgy172+73GeMUSb1kKjpd24vF/lqZTn5Q6rpxnU0ZxUr/peKE0jc?=
 =?us-ascii?Q?DXpZaeKNnptp5dz+lNZ01Z0Rh/c9Ns9ow/foWqsmvur7QiY8fwYxlnIuYDpP?=
 =?us-ascii?Q?7Ti2kRxYyIil5UD4g5u4TmnEpW6LzpcAODws+3/ZG+Bd400vl2sRvWOeYbEw?=
 =?us-ascii?Q?NZpMIEbNhHObkds5S4BN3mum2wpcaQTyAvPCH45O7ZIBCUGR4xNnS+Go+/FW?=
 =?us-ascii?Q?z1oUheZyhTG5W5kAnM3PQStZdxHro+wSkQAmayyj5MC59LDEWjZ0xJVxKeH7?=
 =?us-ascii?Q?NVP51kTjJ6pQfYnm8axW42bJOrNfl7tkf7iPV2P//fQthCmyyl82qZ54Ogpt?=
 =?us-ascii?Q?PN/vWkP2f817iRx+zhhfdO3h0gBzg8i/wYCc+8TqNbJAUHfIGFmsL7mCqanU?=
 =?us-ascii?Q?eEk2CFmdF9PTQdSawDBMFdXvclKW27izgaluxa4HzBEFpuELD4UM16LRtPk+?=
 =?us-ascii?Q?oUFvAUAktWNm0mA59cy+13Ze6mhRPO+lmvNOJrPc/w28R0P2apm9NBaY+Z6j?=
 =?us-ascii?Q?6+EmxOoGEUr4qb19+2SlXBrowC7blcJyLz36PQZlEIJ/808uNeIcicI7cgKE?=
 =?us-ascii?Q?BPmal4ZpbTbmmgW2KzLMIMUv0e8BQdiNSFVFX5w8XbEyUNT9Wa1JBwoHy8Zz?=
 =?us-ascii?Q?ntiuIyyg6SXd9XXOwk/v9DVaYBmxpEtwP4xQ/hnicmH5mPr6U8UpTk4gZcGM?=
 =?us-ascii?Q?0SuQd8IhYWOUb+PUV+BSwdU+/aR4AzzVmj4c8f7Y348n8PnxKI9KsdIYKtjg?=
 =?us-ascii?Q?/uOKhrM4b4pdKirHv+zEuZNzT/7z3allmdUIw1VvOvEwOAMuL3Itr3E433GB?=
 =?us-ascii?Q?+PgpLMLR0IVc8zEFLPzlpQq4xoWloMC5diJwHm39HZ3M3nXbme2Hwq+VGCl1?=
 =?us-ascii?Q?l+z0NlF6CILpZ681torUfGimD2Pg6q1byrE+VoLbF0b6jXeUI/aiD+8yyYOb?=
 =?us-ascii?Q?g+0V/dwL6ZDzpm9B1DnM0B8DVG+ZKVB/CBKLkirHGbmPbjqePqWyiA9+y2rC?=
 =?us-ascii?Q?fwe+ez866I8N/mgo5vv9tR/Ky/dvsW8s?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 22:35:06.9176
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0db0b7e-d2e9-4152-684f-08dcc87ad559
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397AE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8257

From: Jason Gunthorpe <jgg@nvidia.com>

Mimicing the arm-smmu (v2) driver, introduce a struct arm_smmu_impl_ops to
accommodate impl routines.

Suggested-by: Will Deacon <will@kernel.org>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 51 ++++++++++++++++++++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h | 10 ++++
 2 files changed, 60 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 8b1437240ce5..ca7b037f4eae 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -348,7 +348,12 @@ static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
 
 static struct arm_smmu_cmdq *arm_smmu_get_cmdq(struct arm_smmu_device *smmu)
 {
-	return &smmu->cmdq;
+	struct arm_smmu_cmdq *cmdq = NULL;
+
+	if (smmu->impl_ops && smmu->impl_ops->get_secondary_cmdq)
+		cmdq = smmu->impl_ops->get_secondary_cmdq(smmu);
+
+	return cmdq ?: &smmu->cmdq;
 }
 
 static bool arm_smmu_cmdq_needs_busy_polling(struct arm_smmu_device *smmu,
@@ -4052,6 +4057,14 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu)
 		return ret;
 	}
 
+	if (smmu->impl_ops && smmu->impl_ops->device_reset) {
+		ret = smmu->impl_ops->device_reset(smmu);
+		if (ret) {
+			dev_err(smmu->dev, "failed to reset impl\n");
+			return ret;
+		}
+	}
+
 	return 0;
 }
 
@@ -4469,6 +4482,38 @@ static void arm_smmu_rmr_install_bypass_ste(struct arm_smmu_device *smmu)
 	iort_put_rmr_sids(dev_fwnode(smmu->dev), &rmr_list);
 }
 
+static void arm_smmu_impl_remove(void *data)
+{
+	struct arm_smmu_device *smmu = data;
+
+	if (smmu->impl_ops && smmu->impl_ops->device_remove)
+		smmu->impl_ops->device_remove(smmu);
+}
+
+/*
+ * Probe all the compiled in implementations. Each one checks to see if it
+ * matches this HW and if so returns a devm_krealloc'd arm_smmu_device which
+ * replaces the callers. Otherwise the original is returned or ERR_PTR.
+ */
+static struct arm_smmu_device *arm_smmu_impl_probe(struct arm_smmu_device *smmu)
+{
+	struct arm_smmu_device *new_smmu = ERR_PTR(-ENODEV);
+	int ret;
+
+	/* Add impl probe */
+
+	if (new_smmu == ERR_PTR(-ENODEV))
+		return smmu;
+	if (IS_ERR(new_smmu))
+		return new_smmu;
+
+	ret = devm_add_action_or_reset(new_smmu->dev, arm_smmu_impl_remove,
+				       new_smmu);
+	if (ret)
+		return ERR_PTR(ret);
+	return new_smmu;
+}
+
 static int arm_smmu_device_probe(struct platform_device *pdev)
 {
 	int irq, ret;
@@ -4490,6 +4535,10 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	smmu = arm_smmu_impl_probe(smmu);
+	if (IS_ERR(smmu))
+		return PTR_ERR(smmu);
+
 	/* Base address */
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res)
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 21f034f0ff4c..8d7a95b0dbd9 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -14,6 +14,8 @@
 #include <linux/mmzone.h>
 #include <linux/sizes.h>
 
+struct arm_smmu_device;
+
 /* MMIO registers */
 #define ARM_SMMU_IDR0			0x0
 #define IDR0_ST_LVL			GENMASK(28, 27)
@@ -630,9 +632,17 @@ struct arm_smmu_strtab_cfg {
 	u32				strtab_base_cfg;
 };
 
+struct arm_smmu_impl_ops {
+	int (*device_reset)(struct arm_smmu_device *smmu);
+	void (*device_remove)(struct arm_smmu_device *smmu);
+	struct arm_smmu_cmdq *(*get_secondary_cmdq)(struct arm_smmu_device *smmu);
+};
+
 /* An SMMUv3 instance */
 struct arm_smmu_device {
 	struct device			*dev;
+	const struct arm_smmu_impl_ops	*impl_ops;
+
 	void __iomem			*base;
 	void __iomem			*page1;
 
-- 
2.43.0

