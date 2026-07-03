Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012039.outbound.protection.outlook.com [40.107.200.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0983357CF8
	for <iommu@lists.linux.dev>; Fri,  3 Jul 2026 05:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783056730; cv=fail; b=WSFhHXFFqf1ix0IkSzFEIoB2fk6ppA/UBr5ULFke3qp+sqQtNvWeFmDq2h6JPgm8OmXI9+kpqoUmeyE2TeycqoxndUxQFxnrJLSQIelK8s8esHJbnqLerOWUCXLIFJR62cJLKhaFm4vWUWa1nY8uY9vRAI2md12+huTMzXm1PT8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783056730; c=relaxed/simple;
	bh=Urbg6QUsvaHws4O9rajkpTDDHewVWE849Im+8P6nDqc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EYTuSgw1gPtca+SoYb2v9CjlB2z9kNmGN77RxAxgMCdwf/J28CxqjTza3jxTHZyJBENLRu8DiVSJ86JEQVzbI2piB4x0jboTPG709pa41UtpRBBgXR0ImKT1MP6uX1s34B6dPluc58ftmTCIfw6Xbc5LHEmvZVrq9xRVe6alELE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=To/m03jT; arc=fail smtp.client-ip=40.107.200.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="To/m03jT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uP2zB/+PPHU/YCXVlcRhTNO3o8LtknfVTdLlo094niXG2U1ZJrvYD8zmG51JGi8+A7FqBWaBy8DnKET8qhupnJ/vShGArsQE2hjI8aF3/A1cQ10eGS2KOp/2lZOdt+rJ4urWS1WoUaYF2bRxO0JuaQOwqVugqKEsrpIQyNPwy1te7+sjTPOxVWHWnQN93Z6OONThiBUAu50mixsQVBN9GfOdoBtjyWHsouyhPT7rTNhtCVic3FT1/wItQatqqHSgeRMn+iAXScIVKiyaVm2/LkkusBQirHmU0lqpRm+KhYX89F+0GHjzycVToo/ke799A/FK7JWOU+6cUM1JZXCKTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bdn0PEMO559eGmJIGVgBPlKC/Zz31FDwlfVkx8vP6oc=;
 b=JYQKrnHr1a33JY5E+0ie1wNuToMtOPg11vHx91SA7rSO+Yob95nTvyEQjn0KVZuEZTTxhblH84BG7CMHIrm9ZD88WlZzFTs2BUv2L388cc523ra47s8Frokqji7xVcvqkvfTjXNzGxejL3QFw65u3LZwQCsLve0vQwXOlKYqVtFYz9a1mkfxe+Y/L0IriKLAyc48AlkP6sz4qJYLAnp3nDFEWsHFOXOokQJhtjTBLk7ljQe7ZOPseqdC1LqtRtbOZvnzNTgn/1yjdCp+sDR/wOFzux3SJzkRuFhAJ7fRPCzLG053lsgPqSJWt9GlxGQMkwaRbp8wo4JesmMmBlvbyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bdn0PEMO559eGmJIGVgBPlKC/Zz31FDwlfVkx8vP6oc=;
 b=To/m03jT99BLK14mwj7FyOdW+pOrUlSoqNsnliDxfH8wg65gOcI2cvG5BmESHrNOzWEfKyOIvEGyYWjb6jJMFjz/15YFn1eBMW0oNa8drc7l2ieLNM4ZdXh6f7+2kqT1kfLySGFL2MtXvOlPJFkuT1SZuGI2b5EBcxwvIb4AYOIgGVeqqRODKqrxN73XhE8DkJHX8vUT2nXed6OUrwkO1kQkEx7pHK+x6LUOKeo1v11iU2jIxu5wnDwZ0m9KN8GPM6KLlpEbE+2sy8YzrffiGi2YbRhmcZHgmeHo+SUZVatigbhQI+UiL081DtNlA74OsyLdNC3b8pTYwgkOZtnV3A==
Received: from SJ0PR03CA0010.namprd03.prod.outlook.com (2603:10b6:a03:33a::15)
 by DS7PR12MB6165.namprd12.prod.outlook.com (2603:10b6:8:9a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Fri, 3 Jul 2026
 05:32:00 +0000
Received: from BY1PEPF0001AE18.namprd04.prod.outlook.com
 (2603:10b6:a03:33a:cafe::6b) by SJ0PR03CA0010.outlook.office365.com
 (2603:10b6:a03:33a::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Fri, 3
 Jul 2026 05:32:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BY1PEPF0001AE18.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Fri, 3 Jul 2026 05:32:00 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 2 Jul
 2026 22:31:48 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 2 Jul
 2026 22:31:48 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 2 Jul 2026 22:31:47 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Will Deacon <will@kernel.org>
CC: Robin Murphy <robin.murphy@arm.com>, "Joerg Roedel (AMD)"
	<joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
	<linux-tegra@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 06/11] iommu/tegra241-cmdqv: Free the error IRQ before tearing down VINTFs
Date: Thu, 2 Jul 2026 22:31:32 -0700
Message-ID: <cb219d3a195decc5ade9d687162ad545d6999212.1783054570.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1783054570.git.nicolinc@nvidia.com>
References: <cover.1783054570.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE18:EE_|DS7PR12MB6165:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a90f3f5-f127-4d49-271c-08ded8c4680a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|1800799024|23010399003|82310400026|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	VV9vjUtVryrhqCWWbpgDif4W2/RobPvmPbCzDiaYBfP4TmFJFGFb8Hk5YZT/kJs1+RT4bDYIUn18eeC4cswpQK2UpypBD+MDnYNRWBN4QT3Xo+ZfyDAksimV8aJBPwUx0DT2lUWMBIpKfDs+rtYna4hDEZAnMnVky3Q/dhl9cLo+FeaCPM1eZArlUPbesl3I7cbdrcoQiPa86YOH8QB3sRtT48x0CSGCUYUb41shbSZMoifTiaCqbLO9aIOoU8xQPKIpj5hk2Tcm7F/IWnFzjU0ej1XdgMfqYgkrWrGwe0eMa2Wuen4I0h2iiDOMedURsqPlWRr7XTIY3+GtfcKjS1+6o7g2oRBf+xAbn2ucbm0Jdxsj+yPsvYnOtdt0yYaqx9NSP7IwvRHSSNefx+6C0haXupODSqufNaKmKAjPRhEBFFh0DQmyksFGrOEHU+OlSBRPQCM1i2k/xmnKAdQ0ZKzJ9IOfoFg165+AL8yXlA4BttLQYx7Rtd7dh3cyqfq0nNdtooyjE34NQpxHjb14X61L9UH6yFo08MhAV+IcPJDbPbX+W2LqbP58lD6JTGp+PgnxxgTFE2ZOIQKYFOxVnC0yilZnzfB1DxYzhiIM4dArldDLuV909S1gT6h9CQ53jmoq0/AMuLaNNvbQHNPwNy1uVRgoDc8Fa/EDwqJivqP/JuttSYkYU32phlhG8dtom7iaqh9XuVweanlo4FI3zQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(376014)(1800799024)(23010399003)(82310400026)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	/mRruwkC7EVCP18jPHvpAqONCsFakD3QLxWdbedvstk1FGBOFrxvHiey3a8RvanCWGJmXdwrIn7a9jPF7HnQMmW8nmBobGYfYWXc2W0gOkgoV5Ol+LVt7uW6H8zSxIDxoukaXm8DW12WZucvcD8l21UutnfHdO+aKl11r5tmxCwkpM23m3NPF4oJw+DgTQZA3FslOvB5089vwERjl1Tyrfw3R8PuoQSuvx27VnHh/UjQo+LcFqeYrYr8viz3SCGVvj6fdUJvseGcgWXyZ5GeWCJ0D9kb1yzXnpUNifY7g2HwsFR1cfM0TyDpUf2qxh+A17DwBpDHeizfouF1c2pAhiuYHK7TTgW3V5lPLL4hsL2MFJaufKUPHmtLS++GwWP7DWuaONDrJR6TGZiHWzCT350TGWmJu+kP/jG7EWcPWs+VKx0H3pgjyhQNCwUV/w87
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 05:32:00.3238
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a90f3f5-f127-4d49-271c-08ded8c4680a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE18.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6165

tegra241_cmdqv_remove() tears each VINTF down first, then calls free_irq().
Tearing a VINTF down frees vintf0 and clears cmdqv->vintfs[0]. An error in
that window makes tegra241_cmdqv_isr() read the stale slot and hand it to
tegra241_vintf0_handle_error(), which dereferences a NULL or freed pointer.

Free the IRQ before tearing the VINTFs down. free_irq() waits for in-flight
handlers to finish and blocks new ones, so no ISR can observe a VINTF as it
is torn down.

Note: a user-owned VINTF (viommu) could outlive this teardown, which unmaps
cmdqv->base and frees cmdqv->vintfs, so a later viommu close then touches
freed memory. This is neither introduced nor fixed here: a physical IOMMU
is not a pluggable device, so iommufd by design holds no reference on the
one behind a viommu, and this teardown is not expected while that viommu is
still alive.

Fixes: 918eb5c856f6 ("iommu/arm-smmu-v3: Add in-kernel support for NVIDIA Tegra241 (Grace) CMDQV")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
index 262798cd6b8a8..fbf7ecf043a8c 100644
--- a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
+++ b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
@@ -829,6 +829,14 @@ static void tegra241_cmdqv_remove(struct arm_smmu_device *smmu)
 		container_of(smmu, struct tegra241_cmdqv, smmu);
 	u16 idx;
 
+	/*
+	 * Free the IRQ before tearing down the VINTFs. free_irq() waits for any
+	 * in-flight tegra241_cmdqv_isr() to finish and blocks new ones, so the
+	 * ISR cannot dereference a VINTF that is freed by the loop below.
+	 */
+	if (cmdqv->irq > 0)
+		free_irq(cmdqv->irq, cmdqv);
+
 	/* Remove VINTF resources */
 	for (idx = 0; idx < cmdqv->num_vintfs; idx++) {
 		if (cmdqv->vintfs[idx]) {
@@ -841,8 +849,6 @@ static void tegra241_cmdqv_remove(struct arm_smmu_device *smmu)
 	/* Remove cmdqv resources */
 	ida_destroy(&cmdqv->vintf_ids);
 
-	if (cmdqv->irq > 0)
-		free_irq(cmdqv->irq, cmdqv);
 	iounmap(cmdqv->base);
 	kfree(cmdqv->vintfs);
 	put_device(cmdqv->dev); /* smmu->impl_dev */
-- 
2.43.0

