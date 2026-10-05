Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010020.outbound.protection.outlook.com [52.101.61.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E721A4DAF90
	for <iommu@lists.linux.dev>; Mon,  5 Oct 2026 19:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791228709; cv=fail; b=oaeBs3+gfYMHHCAoITDEW0mHnznRAN2wp8delnc4aaxapYR1bT5hvk/u8daxK7/fMJIO4JwojhCPnl/Z+k169Mppk8a6zHidhOqqTkvQq++5pM69oCkW1vY76d3Rah3ng921h/ZKLULWbUEarqyCjgg+OReLhvih64e+T5bxxuE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791228709; c=relaxed/simple;
	bh=X3rvtlpIcAUVuEJvUYnh3G4Uw28ZeBCt+KdpobbFlUo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mF9SUmVYCHOTwWc5Uf/v/XBEf82DCffLCgGaeJRzezD42JgvzhHKw3yGyvs/0p3e2OelQTik1GMJcpn35fMUAxkrTVgQ1N/6JOXgXXFM92POzuTO8876KNsF/b6dJXVK1Z3pHJPYjqK3m6whsM5huHMh+Do7Jr3JfmudoaOoOMs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EnsEG8ZB; arc=fail smtp.client-ip=52.101.61.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EnsEG8ZB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PPPjnSXnhRYL6eog2CctX+oopCi18g8ue5HjjgxKKUsUMhU+acHDc3c6aNVqjJP3oNd0S9BJHEEPqHO5A5szC0DxSBt/pok+Db+Y7/vZ/U7sOsWGPRkFsUtebBjpObGjPZg2wNBPMX2CbEbRB4pAlmyHLZs2XJQv3IaR3lUiSpjvYig2PuE89z7INHuik1jxhfETB73kryzmzPpxC3CpXeNR4rlkaLdlUeckPIXfU5l5gCBY30FLjNiF1PbhzcFwJm6tXVBz05+gUPYY1atmModqtCXKmTM6j3W+HISojjQiM960WCkJpWjD4WMB3c+1iSwt+MWfIRwZIMktetP2zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QSYK6LdXpUthsM0YT2ejjzx+1coMYG6wgMsp6KNDyzM=;
 b=sZLrgLmdfsoChn78QRAVa8+0QFOllP4bdQG0Xt8MtQnmuvi7ja53qNsicAcRpvtf+kUZo4AVfLCcrYGZava8goVhsbptcQVPzHP8QZoZKVB/X1e0QeZ04czKfNyW+U5t3CkpJCdxJgQeaEUJJIwmUA3XQvIYLKww0dp628veu9Ktv0DINXuAzZ1tLVzSe1b4/cTqH1YXfx9kX7PS8dxClvtTqZcT7o101D2WWqNJI+/fiGy38haXP/NUzvTCRGZhxkuqJuxfoqdgZLAaWhQwaUB3lzuFu583DLCuHDcG8GAPL1V/KUNLVismZ8+hli7Y3pKaSm03SDODB/Ofd18NWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QSYK6LdXpUthsM0YT2ejjzx+1coMYG6wgMsp6KNDyzM=;
 b=EnsEG8ZBQF4CKCbIXodxg1aIamgaJXxjdXUdhK4yKhqM+440HFHemjnXqTkP6mKG1cmoIlIZM/Fd0btOBE7Mn8Jz/yhYp/XGG8mrYTJMva9ep5wxt0nDP+U2qV1kTipY2eNfWTIIkrdXARWnXf4uRU1AjsfDlJ5Jdjp9y8W4oUohpeXm3BIryOHdoPpx9nhdnnBDMrRNPekYEtY2yXFkVqoJYavHl1uIwvWL9QPBSJU0+ckYDb9ZPILxkEf78RrZCiiMpxA3gWAtrGHSHhw6M3EIBjbxy3JL0X9p8ibAnpp5qoC8YxfOgc6WYRbLDUD2WD1wbAxXeJBXUVH5GyPscA==
Received: from SJ0PR03CA0267.namprd03.prod.outlook.com (2603:10b6:a03:3a0::32)
 by SN7PR12MB7786.namprd12.prod.outlook.com (2603:10b6:806:349::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.27; Mon, 5 Oct
 2026 19:31:33 +0000
Received: from BY1PEPF0001AE1A.namprd04.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::13) by SJ0PR03CA0267.outlook.office365.com
 (2603:10b6:a03:3a0::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Mon, 5
 Oct 2026 19:31:32 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.118.232) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BY1PEPF0001AE1A.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Mon, 5 Oct 2026 19:31:32 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 5 Oct
 2026 12:31:04 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 12:31:04 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Mon, 5 Oct 2026 12:31:04 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <jgg@nvidia.com>,
	<praan@google.com>, <kevin.tian@intel.com>, <smostafa@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <jamien@nvidia.com>, <kas@kernel.org>,
	Cristian Prundeanu <cpru@amazon.com>, Breno Leitao <leitao@kernel.org>
Subject: [PATCH v11 05/11] iommu/arm-smmu-v3: Disable the EVTQ and the PRIQ in a kdump kernel
Date: Mon, 5 Oct 2026 12:30:48 -0700
Message-ID: <fdebf9f372ebabd7a44581a2068d6fcbff058783.1791226953.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1791226953.git.nicolinc@nvidia.com>
References: <cover.1791226953.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1A:EE_|SN7PR12MB7786:EE_
X-MS-Office365-Filtering-Correlation-Id: 3de7c58c-ea4f-48bb-6220-08df2317430d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|23010399003|82310400026|36860700016|22082099003|18002099003|6133799003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	FHbyZnYZDCg3B3Gr2//0vqgEH8pflBjCLWf3Xk44XGk2wkyNJP4LdJv7mvta9HiZXUHjwxH/sxCUPrbfwmvtcf+sPokzrGJrnMf0zbtY2mcMA4IlXY2c5hkR3+LtGWbwmfDvvTSvCn3yuYY2sod3+Qa0zT9r5upOSsS4QD7IPFs8hv+Qq4icTmWxRPRTc3hUrM/gaoWMZCjw6zC5nRt2FzJsO2Npng1Fjxs6jxPfj/17ZEotBlW1Kvw2N5iuDBporI8TX9NJk2ZwdySKHaxzN1dMDJehxPl2oKWLbDS3DGBcYnLA4enfKOMvBuKedEsN708Ky8vkIqffI625z9ze+QKzPKuJt6PnXYla0hRazKk6coXHv8l4u1EqkjsTeQuZEmXCWR1TtaXclXdTFaTC2qyjOgjr5VE3GmdARQDMMMaIvkLZhipOb8jFMAqfo/rvFAIDK+MxjR4Bg/ciwnI2DVh2rRxMcKgAaGNnlxaWlcXKYz+jqiAYHDgpwfDx6O95shgyDi9p3vuSDammL43GUFRHktUjcRWBzdIw7QxUgQQaP2Gl3CHyho5ZlDy1KDxWKhKpQ10S7bvLxPd3MsJt2dbOD8yB7BnOPIgIR/NHmSThLpgZfw+LoPIE5EZL27aqAkpS1jpyooT5nEoeWA3MppFDZEhvj5gZ5KkDdPhQluDFb6TA3eyNIEwihs906PtAoLbNAheZ4yv/F7KG9Bx/vg==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(23010399003)(82310400026)(36860700016)(22082099003)(18002099003)(6133799003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	NHewLC9PFy7w2Lq6V4kcxbh3imGISJDoqsN+Y9e79Xs5uSn/rZfW1k/efYZBIluGDTpFnyXe3YzMQmA8oY7kgCfxGXHsn3OkJIJ3YaxaBqABmGj5rZcPbLFEuxBuRW0runl1CX/mErsBTIf8TOZ+DpayRQhlanLgspDltxTtSy6YxoLnZxOYgEANhzjmcvKZ56CALM3l3ZlpSeGWmHdfaGi/21XHdjLd7C2B1aJB4XIAh/ZIxbegjcJYFitVFijxix+COHO5UklxjJLcNW2QkAVUnGtOlPCgYJhDhy5qZM/Dk+ug7K1gx2I38C9PFMNaasyqiyFuZy2KFsnPnO1Gxb8howkoC8tvPRRb0AJ88Xe6bY2WWyuS/xgD75tdlg2DaYOtgZEsazDqZyIftFDsKVSVZId6cfBtEkhyz/HgpQo3dtK7dlAVLJF42S7O/HVP
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 19:31:32.5218
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3de7c58c-ea4f-48bb-6220-08df2317430d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE1A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7786

A kdump kernel cannot use either queue. The crashed kernel's CDs and page
tables might be corrupted, so events would spam the EVTQ, and there is no
way to serve the page requests that would arrive at the PRIQ.

The reset routine still enables both of the queues and then masks the two
enable bits back out, having already programmed the queue bases and taken
the interrupts of both.

Clear ARM_SMMU_FEAT_EVTQ and ARM_SMMU_FEAT_PRI in the probe instead, so as
to entirely skip the queue initialization and handling in a kdump kernel.

Suggested-by: Will Deacon <will@kernel.org>
Link: https://lore.kernel.org/all/amiBagGKn-Aym1DK@willie-the-truck/
Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Tested-by: Breno Leitao <leitao@kernel.org>
Tested-by: Cristian Prundeanu <cpru@amazon.com>
Assisted-by: LLM
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 756825e004774..42cd30c79211e 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -5247,9 +5247,6 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu)
 		return ret;
 	}
 
-	if (is_kdump_kernel())
-		enables &= ~(CR0_EVTQEN | CR0_PRIQEN);
-
 	/* Enable the SMMU interface */
 	enables |= CR0_SMMUEN;
 	ret = arm_smmu_write_reg_sync(smmu, enables, ARM_SMMU_CR0,
@@ -5576,6 +5573,15 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
 	if (arm_smmu_sva_supported(smmu))
 		smmu->features |= ARM_SMMU_FEAT_SVA;
 
+	/*
+	 * A kdump kernel wants neither queue: the crashed kernel's CDs and page
+	 * tables might be corrupted, spamming events, and page requests cannot
+	 * be served. A disabled queue discards new records without raising any
+	 * global error.
+	 */
+	if (is_kdump_kernel())
+		smmu->features &= ~(ARM_SMMU_FEAT_EVTQ | ARM_SMMU_FEAT_PRI);
+
 	dev_info(smmu->dev, "oas %lu-bit (features 0x%08x)\n",
 		 smmu->oas, smmu->features);
 	return 0;
-- 
2.43.0

