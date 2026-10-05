Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012013.outbound.protection.outlook.com [52.101.43.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3114DA9C7
	for <iommu@lists.linux.dev>; Mon,  5 Oct 2026 19:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791228709; cv=fail; b=I5uGssJ+yKifR6r8foVVMQ1C4Xn8ZvqA3ZixhHOmcQwB3OdbBYusKzfzLPUQtJsKjd9Vzi3+Ghfx5YXDiB6S28m1MGAzRJs1s7hu1tOY2YpwkhCS0t4CPVA9DQzVAC2QgpzHdjia19BSZO1vtOSyfILKCtOnxU+Q2fqya9XAeQI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791228709; c=relaxed/simple;
	bh=eJUV5CGziAcjaOAbk8edtc1FtOkm48Il+nGH9slsFUc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q55kj9u5kXkRNaNsFD+u7v+BANUBKHzP3lxu/lcg3eqkmLMV7Au2EBh8PdedSxBBpUQhLAy1D4ccXHYC6gfROMJSdkfeaRGJLPqMMzdqkov3V+LGHKmgM1HQy8TYGyLgTGnNsCRYzlFjj8weAIqshWr025JqI61nEtGcbAl1/lA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mlX2WWzP; arc=fail smtp.client-ip=52.101.43.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mlX2WWzP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d9WoHCV8F8+iuC53VzxLu6vspXSERY+oz8MvoOPDY79bHplxR6mByqo7dlexg8qkkISfore451NOBQ8SW2Vyjg7xwhPZE1vh3jdaNulb1A4keFSxMooUgJJus3spdCjol6t0urTMX11casj3qIx17DgpxNm7mAhaVAAbjnvre8BIkr1uiyhcMXFb3GCwhMrPlwGiN7GfpHxTnDIGVx+/H0rHVF7Bggwz8rOZPQ3O9FhE9UKm/PmhkVUdWz6zWcIJpt7/2hopdlNQ5mPbvM/ZMl1/Gxw7esIHs4PSQKj1HcjhJGHRd4jZdg2x5dnpL8c8n2s+4HWvZOn+YRQfsC54IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uqjgewf0FbX8IoHEgl9guKGhLhQ1DeYPrX9XON2xYNI=;
 b=qo/2u60+RbQDYo8YYb4VRKm8951nAt9v8yWH3Wg5ajRFzgCv9MRaPDZ+HQ/XIg7U/qjm0uDTp2VD1BB/XpHtU4d82vvTn1yD9y+5ZtGCaXWfuxDb9yS9t91D84PUSPGG97j6fgYBUPJcoEyuyjrbT41Irge6mJv8tMhimnN8ZYhx9R/yX6311gsOkdWoxjZ/DScSMk1uE34uW66X9Jxccmh6nB3+6pY9nkyO0NgF3/3EuoWMeZQs86p3OlcWsPdhDczvBGVvZ/vTIi1TKcAQfsHEcrW4Ve39xEIgQgxWBskvvSP/D4lnbQzDbPR6jpyuP7xAxR7ejWUZBfKRCnMgEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uqjgewf0FbX8IoHEgl9guKGhLhQ1DeYPrX9XON2xYNI=;
 b=mlX2WWzPzgeX2rysjf+tyvko7bBcW3BTxfTGZJVLXNEenNR2j+W93Y6zb5FEBG66RyVxUdS5voAOIHokpFXPpTNzUBGYATSWR3vKsfa4lZvK+W8YZnBFARlbvAP/2OxtE9WlZO1oWY1l+wof54faLeN7a9RWV6wEZkZkCpWjXshD7MFbWwbnax7j2s3bwrMw+/0GhGfBVsesHigG3JjZUw7yeFfzja1hPIPyf87BQsByeyz6/UYK6DmovKShtQN7jTMHQ7CIru0IHVEecvrMEgyYfWqouTugY3pEJ+k2guR1AtNBh+Q/arRWFkPBMKHIy+W1SKWOxmGjDkmSk+yyXw==
Received: from BN9PR03CA0052.namprd03.prod.outlook.com (2603:10b6:408:fb::27)
 by BY5PR12MB4210.namprd12.prod.outlook.com (2603:10b6:a03:203::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Mon, 5 Oct
 2026 19:31:39 +0000
Received: from BN3PEPF0000B072.namprd04.prod.outlook.com
 (2603:10b6:408:fb:cafe::ae) by BN9PR03CA0052.outlook.office365.com
 (2603:10b6:408:fb::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Mon, 5
 Oct 2026 19:31:38 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.118.233) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN3PEPF0000B072.mail.protection.outlook.com (10.167.243.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Mon, 5 Oct 2026 19:31:38 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 5 Oct
 2026 12:31:08 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 12:31:07 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Mon, 5 Oct 2026 12:31:07 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <jgg@nvidia.com>,
	<praan@google.com>, <kevin.tian@intel.com>, <smostafa@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <jamien@nvidia.com>, <kas@kernel.org>,
	Cristian Prundeanu <cpru@amazon.com>, Breno Leitao <leitao@kernel.org>
Subject: [PATCH v11 09/11] iommu/arm-smmu-v3: Retain CR0_SMMUEN during kdump device reset
Date: Mon, 5 Oct 2026 12:30:52 -0700
Message-ID: <e8f6f198da25cc6b00902cd61bda9e7228cb45ec.1791226953.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B072:EE_|BY5PR12MB4210:EE_
X-MS-Office365-Filtering-Correlation-Id: a694b94b-6d2c-49d4-eac7-08df231746c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|376014|1800799024|36860700016|7416014|6133799003|22082099003|18002099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	ZGGfJFhDpRjJcNgUwlN35rxpX2JUtQMVug0zDYdm7mIWJuWtdcu1nnXrbvjjUPE/6TKV+a4GFL8WCL2BA9NZASXMZ1cFP5uKDDVuiL6jqzzOlrKaRKl6USGAEPmbBuqgg1J57rB15zBwq123teUfo/txejb3ZbehdEc1y7nO8vvJOCNPTKRxYh+XUCvUR4/fVlm066o8FlHBeUSAdC2DLY/BJhAjKhkW0vKs8RWBsYHbsU9vKIKekT2rRw/+YEIibOdrbOv5BdFAkVlStC8MA+XNROzj4TJ0Zjq7sLf2edEY5XBjvTXZIro6Adg2j0suAtBx2ofEix6w2EFwZjd67EVLpuAuY0TLNXlhlGwvTz0/HMQJj6Jz4z9IwhkWUQDixLDjzEWvASREFN1fgnts2weTqnYHb4t0JWqrYBaASmSaXs43pbbnCcMW/TG/1Pbo1RiID3PG01OVcWrt59LecGN7BV7B0iY/X6C1LIlHuv7hTviuRmmLhcC6CdjGWTOk6FfmGFZcrOYk/igFvITN2czqc8ub8Qv2LGksqSVuDmLY9mVzuhO7YoqNTIuH59xVWm0pr75cGEeY+ML4nDvS/tDfKa2JGS1UrDXw4sOMWZlvKv57gHN1LgV0Qfuv7LWk/XzageIeUqlp/QugGqJegZ1WZpQCPCvXar5PiotO+vNuRmEwAH6Yvxtpaf7ZcsloCn0k5pu8XB5GzdK35t+Ntw==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(376014)(1800799024)(36860700016)(7416014)(6133799003)(22082099003)(18002099003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	25VGEE0Mdc/1eipad0mVlcOpb6P5ugWl0zdIAIdxcIrN5T+KK/OkFf3cECETVgrYneH5y8xOJwkoIUSdPWvGNxGzRmeosr2/oJdewm4jSbdRhR9c4isjTuw59DzC94mgxr6NGjzct2PG7b9ROpAoiwaFLr/oopLvGSQ8IpJM7dvFqXbTPVIU8o4ecPVwYF72oO26zW4jczdjhFtqlfAW5lS2uWcfVBXxlGKj6X+RJx5PoSAQpTSKkaq9RGGAFIBiAYQoLidw6ExAaRL65reDKnpB1niWIIuX1bDZODPpL5PhO2F27yqJfloilXMPFOg+rzgpFfVED0Q1cttgPcSR74jLUEsTNnceJi1P5zX5CGSav2DtA2dGACw2kwrb39r1ifnUoWd5f+6okknW8H2eRiAr1xIGEc3QyRcUVDPANGVXDm2ecAgpE39xq/7H4Uam
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 19:31:38.6330
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a694b94b-6d2c-49d4-eac7-08df231746c7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B072.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4210

When ARM_SMMU_OPT_KDUMP_ADOPT is detected, do not disable SMMUEN and skip
the CR1/CR2/STRTAB_BASE update sequence in arm_smmu_device_reset(). Those
register writes are all CONSTRAINED UNPREDICTABLE while CR0_SMMUEN==1, so
leaving them intact lets in-flight DMAs continue to be translated by the
adopted stream table.

Initialize 'enables' to 0, so it can carry the retained CR0 fields in the
kdump case, clearing only the queue enable bits. Then, preserve them when
enabling the command queue.

The retained CR0 keeps the crashed kernel's ATSCHK too, which selects the
fast (0) or the safe (1) mode for the ATS translated traffic. Switching to
the safe mode would start checking the in-flight traffic against STE.EATS
fields that the crashed kernel never set up for a check, aborting the very
DMAs being carried.

Clear latched gerror bits if necessary.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Tested-by: Breno Leitao <leitao@kernel.org>
Tested-by: Cristian Prundeanu <cpru@amazon.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 60 +++++++++++++++++++--
 1 file changed, 56 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index d301f313ba1aa..5542d136c1d77 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -5148,10 +5148,28 @@ static void arm_smmu_write_strtab(struct arm_smmu_device *smmu)
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
@@ -5181,12 +5199,41 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu)
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
@@ -5242,7 +5289,12 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu)
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

