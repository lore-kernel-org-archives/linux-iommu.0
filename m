Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011029.outbound.protection.outlook.com [52.101.52.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF1D3B6346
	for <iommu@lists.linux.dev>; Thu, 28 May 2026 10:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779963408; cv=fail; b=e5Y1u8bfLLdEbqvvu5npzrFlzmnwgTx1Ile0OYnwfEQHuYR3maF+cdFRJ5U2okiOzNITSGfhstA+V8yjok4BHwyfBrr6lhuDbEGlGwb3s8BQ6LNlYLOlrunycDYDh00eppYAOuRvpLo378/JOM4nfyM4w58irG4gparsXDWMH+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779963408; c=relaxed/simple;
	bh=jP31IA4F4l/sGxuMeZqE9+VX731RQTsspcXqvE+pSik=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NOowIzaSSAzUEUxCMNVxdJT0LMohsV8Gf86ivsic+efEWjjxY0N7V+CeB4Txs4zJ8eKfMLJdSm1OkAyUmykJDsY8/lt+ic69xPzalY7Vka1K1TzWT0oG4ZQsWDXj99GwJhsroRqQ+CD+6kgJQyKua8maHUW67u0j4y4CSak1dEA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RIXQ9q6T; arc=fail smtp.client-ip=52.101.52.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RIXQ9q6T"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ub8fezaNspMekTC/1ivGSH1QwJOUQhe+edu1GU371P5xtqbhhnYW8rJgE98KFqCMzfKSA6uI341pPA3vumImyuxg0RkcjjEHIbPw25FqQBS0aKDHi89Pqr7ECRbQjH/LaVppSMig2LOqgdKErgAtjoq9m/NETGRV/XyTMQxenCNhKb4xJ6IDBm7aLynCbZq3A2LIa1BP7HYiQAV7wr95qtP60U7FRGjGDD18nSFcumoczUTkt0m/zFyYDdH4Y0HZwMpgOWQGh8E8tUFy2JOdoJQeTtidQM2QXc+XlKieNnxKHzHz2PRUkYz4Ey6Ekx8gK7asxVk4yPer7CK6WzhSaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AztdE0bmvYfW5a4aMsO27bjDvNHALW17Cw3HDbI0Cp0=;
 b=rSoPeEacGpYTS7/2q+naUp1V8c94JQ5Pc/K97YVEDLG3wRktqsR8Oc8JPnfXBNG2qNmiN1tZ/HbXlE+lceeZG2jK+KlISfzBNzA9Vqs7w6DkrfZGtfHRT62NrTF4FWgZtao1IcKwz+hYhhmms+AbYYE/QgpVHSAMU5EXxPtekX3O8B5AmGDIMMCmsSQyVD60fpxehPGV+j+viJjFRtdhYDid3dwewRAEb3iVSagJuMBVOPw3nwh/b/SNlsGXTMudvD6J5HMIrc2YHWxygiCn+mya99snW+513Neph1eBz5yz/elvzRCoITuznDuxs//9rs7uVAHHhN7KSBvKc+HlRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AztdE0bmvYfW5a4aMsO27bjDvNHALW17Cw3HDbI0Cp0=;
 b=RIXQ9q6TwC5Aof0rj19McVmwdtjiWTI6UypRlwpOcfBCCVJ8KxRSK58OMce7CWq7f3lih2FeIQpaRajtYHMIquyXyeFz98HVLngeTRDwiiJ+zaaxBisz7SJpBc46DyM2ciuDRc6jUjeELpR2LBO7oY974sHykHWjrX8eWDMvFj8kO8PgNuJUCjfnCXPFj3Zua2vZ3jeRH7gKT4VK5OJemzC1cw8a9Jh5xT3Y2Afg2PPCs0vm91BlncVBzZcHr8ZAeAAz6IxJwPRmY9PAz3meMRiUmiIVT35r1yqb7j2Jf+qFxPZNtfhVrWrYmgWv7Fr5Z/vH5/AktOaeu5HodgsUfA==
Received: from CH5P222CA0020.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::12)
 by MN0PR12MB5738.namprd12.prod.outlook.com (2603:10b6:208:371::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Thu, 28 May
 2026 10:16:41 +0000
Received: from CH1PEPF0000AD79.namprd04.prod.outlook.com
 (2603:10b6:610:1ee:cafe::93) by CH5P222CA0020.outlook.office365.com
 (2603:10b6:610:1ee::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Thu, 28
 May 2026 10:16:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH1PEPF0000AD79.mail.protection.outlook.com (10.167.244.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Thu, 28 May 2026 10:16:41 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 28 May
 2026 03:16:29 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 28 May 2026 03:16:29 -0700
Received: from build-amhetre-focal-20250829.internal (10.127.8.12) by
 mail.nvidia.com (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20
 via Frontend Transport; Thu, 28 May 2026 03:16:28 -0700
From: Ashish Mhetre <amhetre@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<jgg@ziepe.ca>, <nicolinc@nvidia.com>
CC: <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>, Ashish Mhetre
	<amhetre@nvidia.com>
Subject: [PATCH 1/2] iommu/arm-smmu-v3: Detect Tegra264 erratum
Date: Thu, 28 May 2026 10:16:16 +0000
Message-ID: <20260528101617.4068249-2-amhetre@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260528101617.4068249-1-amhetre@nvidia.com>
References: <20260528101617.4068249-1-amhetre@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD79:EE_|MN0PR12MB5738:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c7a0cc4-d2d6-480f-5757-08debca2366c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700016|56012099006|11063799006|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Wi88CMqywCXWcm6LLWO/3wSY2xFwjOz9RjyTlWLUYE3iyv7hxSw/oTsgBIxIEfJEG6fypVkMtXplC7W8Yo3SYxOaiQ5JpbSLKYiU7EFfn/oZC35d4i7Ly/r5130ipFuHmCq1yx7geK5FMqZmPmNumMRjc7pnGyiKz8Qahj0cykjZkIJ8JICVI/scWXkdNu0ZHAqbEfHF/UdO2kUHIoVHWkXsazhHVaM+TRcMfpf8DwSVYUk8dDTYybWLPXvYO3etse8E+7/PwCtkOkQ36Ike3o60HQKErhkvHAUHjP1v/M1NvoWtwlhlJjX+SisMusPfhayV/Bix/sBAEQnmMOSmZgO4JVfJdKsmMMDlgtsLutIMl8NqOtBGyFeDCvWS8G9yle8GPTibdsw8EervLJqGd69Qa0juc2ziE9mvygDVb+HJErutFfENehyQ05DY3A4XT5s7yCbKbuuvIwgb992uAaHxJASxla5twZpbfnu1p+1I1gnDDzVIwc5ZSgq/UUy7vfE43eswrKKyvfNuISdZRHe8ZFpdNT8anb2u5fX3SCh0+CaFV5gu6m2OkrRniEXd3i1JNxo+wRcPicdNcNwCL3zuj86wpCkkWBKgifh4Ssny/jArrh2QsIHRKn4pgXkSPmissoNxfDA6sXqZkho9IMbYP1HK/Py0AnYuZeAoFzlYfLDChSyNQWlgu6U/SXvCCPK/58WsZRh4VRGeeDZxMACQGo1ZhHdvYsxGXvOtPnQ=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(56012099006)(11063799006)(3023799007)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	qPg3d4pq/VEy5XksHMNzfTWne8GgywLp7B7lrPB2g9UaUY8ga0jfY5tuZigssJz2vWJaYUp5evBT0F5G9Xn6vgX15xa6oERry0DerhtYaqttrWDplFSx6Oye2Xjs80giEVY6teTDsf2DUBhALEzfSwlnwWkyLbmz2iVY1W6T5oC18cOmAAAoxb6zsI7x0QWUTXKd3LsZs76DJtEJttd3GY1F6OImYjX5cxa8M5/gNUhgNBMNUhaERCq6eudpR2nSwNe2zAtIF4BP+1W628/3lVJAKBSWJj3sXpLbSd3P4JuBywBuSfuXk7d202t7LCU0VjYiqamhbP65aVYG8rVK6jUaFElGc77AXIgo5ktBIpfcZKEweD4pTUatZOTFU8XMUpik3InD/NqIc1PoyuYpqzCRn1stNrBG0Lo1N/xGu7nMVLu//jjUmRMddmcs+vN8
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 10:16:41.5404
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c7a0cc4-d2d6-480f-5757-08debca2366c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD79.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5738

Tegra264 SMMU is affected by erratum where a TLB entry can survive an
invalidation that races with concurrent traffic targeting the same
entry. The hardware-recommended software workaround is to issue every
CFGI/TLBI command (each followed by CMD_SYNC) twice. The second issue is
guaranteed to evict the entry. ATC_INV is not affected and must not be
doubled.

Add the ARM_SMMU_OPT_TLBI_TWICE option and set it on instances matching
the existing "nvidia,tegra264-smmu" compatible. No callers consume the
option yet, next patch wires the workaround into the CMDQ issue paths.

Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 4 +++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h | 8 ++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 9be589d14a3b..88296c0a5337 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -5229,8 +5229,10 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev,
 	if (of_dma_is_coherent(dev->of_node))
 		smmu->features |= ARM_SMMU_FEAT_COHERENCY;
 
-	if (of_device_is_compatible(dev->of_node, "nvidia,tegra264-smmu"))
+	if (of_device_is_compatible(dev->of_node, "nvidia,tegra264-smmu")) {
 		tegra_cmdqv_dt_probe(dev->of_node, smmu);
+		smmu->options |= ARM_SMMU_OPT_TLBI_TWICE;
+	}
 
 	return ret;
 }
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 16353596e08a..08d1abaf31ae 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -928,6 +928,14 @@ struct arm_smmu_device {
 #define ARM_SMMU_OPT_MSIPOLL		(1 << 2)
 #define ARM_SMMU_OPT_CMDQ_FORCE_SYNC	(1 << 3)
 #define ARM_SMMU_OPT_TEGRA241_CMDQV	(1 << 4)
+/*
+ * Tegra264 erratum: a TLB entry can survive an invalidation that races
+ * with concurrent traffic targeting the same entry. The software
+ * workaround is to issue every CFGI/TLBI command twice, each followed
+ * by CMD_SYNC. The second issue is guaranteed to evict the entry.
+ * ATC_INV commands are not affected and must not be doubled.
+ */
+#define ARM_SMMU_OPT_TLBI_TWICE		(1 << 5)
 	u32				options;
 
 	struct arm_smmu_cmdq		cmdq;
-- 
2.50.1

