Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010007.outbound.protection.outlook.com [40.93.198.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A780345CCA
	for <iommu@lists.linux.dev>; Fri,  3 Jul 2026 05:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783056745; cv=fail; b=ZCvfmaHRh0zRp0qrdnYaLCwaIdjl3SH6CF4dniUrEgkbE9HaPf/avOjzdrWFCWwEwRXFE+XceQIClSeuIDUXlBjVIWBj5QuzYFzcIkjfidCcU+FMrz876z5c0x2SaWGKW+PD27vD7P+LbBJXQCyzF0nUTViH+2eWqi73VCj+wQE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783056745; c=relaxed/simple;
	bh=vEWsRw9vsztFgudUYU71+9SMAKlOSAZfG8U1m263Gg0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l79DL582uSEPgYFEKaAy+tgGtLvKXhfHmMWlNTlsIEYJiGNUiTG/KaXm+bDu7nhtxaunj+FJ4zTGwELtQT8PkAsdm/AhFg/sEvvLECpC19XCmCmJFc6L0gyHUezo6thmeTO0+0SQ5fvrBi/kmH9Kd12zBtLIfdIEZp/wsYgL3bg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XcAHnnk1; arc=fail smtp.client-ip=40.93.198.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XcAHnnk1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DWIx7vspIJzxiE8VavLx2NBrp+Ighn1DJOgw2NgIdWEz4VUczrspPV8EmSPy8ddxisd0jjV/nvVFWE4UvWkQdTD4kZcyBhjjnbleGz171+1lqUYsYWc4zV17nM4Rmxup1S3HUbgqOuONKwoRj3aLXkPQWN7FfCgpOfS9tjpdHW5HK2YCa8ro6Ug/6FiRkbaxz4pouh1lTZIHzL0IsHlNncpvTyaGykW+ry8zwwNuic3LLZRPTL8ilpaymHznQGbh6oev593GQUQ6LDQEKLPJk28Bv26jZHy0JKwqQ9lv53et9MrWcKoemGlBkGWja7K2/dHiML26kz4XwPZv/jj8AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=raq97SGOE7AEtGZdA0zJbL+0qP/257vDxgadQIvSecY=;
 b=tD1F0dAuXd6UxgJSuZrBTb/T/VYwyiAlb5b5ipAJjsvIX88LnuR/Jd0bXxpXYjhKQl1QpRNmlx8XbHujOraNNmxEemEwSNGiO7yaGGT5m3RoNHS6bL4MovV4Jjj3Tp8Zsy2iuiO65jmsSNtJSShgH21jIslHRgG4hWD6UyqJsGjYdDSB3OgDV6jP19gVFMqQSLR3cKqjjnN7SZaZx0wT1Ex8afKxj7QdpfDOMcrJopDZm8/5cIlnLy/DMRhjOdiLhahnAHLcewkkDc4reSvdtYYrsr5LbnWGzKkfKLTzaFP8sleF5Ht3SDLcVrzpfluiZSoO6emIIHvnVkXF2LtFNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=raq97SGOE7AEtGZdA0zJbL+0qP/257vDxgadQIvSecY=;
 b=XcAHnnk12VywPd5r9ZqooHuiOXIGsgxl3NJJJo4vzDynXE6OCa9DNxhlqAwXeCtlyTK2Z8c7AThk3sCDWl0HuxKW1ptFYifTJP9ey03O/dydR4ANG8oLarXYKSpWC3bAXv4YiAo9JIrVxyHvy59efYd72IdW2TH11VANurnPH3Q1mn23U3rVw87wXa6BjpqeNahw2LWBlapI+kVhGXCShIixqTcRdMb/fq6t77mSMgbJaj31QF5uezrMUfvK0y51NoovyGqH95Q8E8qNTPOlcZh8qjtSVizWiWsmsTzsNeUFgGL/7n/O5/ihGL+BhfZdrnhTCdOnEKf92BYXT86rAQ==
Received: from BN0PR03CA0045.namprd03.prod.outlook.com (2603:10b6:408:e7::20)
 by PH7PR12MB6393.namprd12.prod.outlook.com (2603:10b6:510:1ff::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Fri, 3 Jul
 2026 05:32:11 +0000
Received: from BN2PEPF000044AA.namprd04.prod.outlook.com
 (2603:10b6:408:e7:cafe::41) by BN0PR03CA0045.outlook.office365.com
 (2603:10b6:408:e7::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.10 via Frontend Transport; Fri, 3
 Jul 2026 05:32:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF000044AA.mail.protection.outlook.com (10.167.243.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Fri, 3 Jul 2026 05:32:10 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 2 Jul
 2026 22:31:52 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 2 Jul
 2026 22:31:52 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 2 Jul 2026 22:31:51 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Will Deacon <will@kernel.org>
CC: Robin Murphy <robin.murphy@arm.com>, "Joerg Roedel (AMD)"
	<joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
	<linux-tegra@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 10/11] iommu/tegra241-cmdqv: Warn on a VCMDQ base above the 48-bit hardware limit
Date: Thu, 2 Jul 2026 22:31:36 -0700
Message-ID: <0dc3a146a3d274d7c47e525385830343cea0f675.1783054570.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AA:EE_|PH7PR12MB6393:EE_
X-MS-Office365-Filtering-Correlation-Id: c9ee7f76-724c-4a64-f53b-08ded8c46e6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|82310400026|1800799024|376014|3023799007|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	9a0nykMn1kPEFOlk2LG8QiT6YCtzJH3yJx1Vf3kRArPCfO4TEXG1WC0b3HOs0lIPXmJQEitMl8mmxo6a5qlyb2PrXHxJWre7ciVRbO/fEfF3ZoZ+gmOmVVMNl/t4mjh5/I0azZSFAcHoFJAIToN1RrtJNPGK9RSVEgJbtSy4Kl/erglLAU8jJE7Y0KXXpD9e2ZIoA7h3LpivQdGN0uaPOksC23CGRdiKgZSBmj5vZ2qf4PtR/8MUlGUfpMPfkslbnF/pVFPuL5eoDGzuyU1nrp0DJQnWSrHHD3iiNyooD7h4aHWUrHnNgQpGrfu4r5oBm/Ij+abtW5CI+uMSNKyyCcBtGtwjwMwHAvLMonmYhd1MUCqt9yeTf06TGvZ67bwd/gLF/50+1w1bd6fBe9ehrxHmhIovrhs6I3mI9V5flotvTg2bOPYsoABd3S2PTFHvZPc4e2ZFeVFtytnW9Hh18W6qBJQiZeNjew2CPI9UtP4oGnwJqrWbhweFV3fPBbiPREgFcLZASsi+Qu8m7tpUv09r3uEL4SgE91VWwjYQVGKtX0an3oxbuXZ2oD3YOc3yGB6W9oXfJBK1fx16izONq7j2FHNEVgkxO7sCtyYgEk2Dm1OZQdbCE7CEON8WxICtUY7JpufRmujBoxfRhy3qcK0kCoNV9EsjaA5AMi1waFEWwozcSFa5gzzlELjCnfvH
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(82310400026)(1800799024)(376014)(3023799007)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	0UL1XTPcRTkyEMQa+d+z0yn+JFni67Ssqvq+EXTY8fRDzeiB6bG62XYEy8O7LH3poT93U8v1rossVWEQzr3gKYKUDNL/ekWuSMPeD0G5a7bV11rjcvayjNx95WM/Nt7QUhOKGUnL40vQ3GeVpk2GuaW5T73Q0YEYms9LLkJApzWiF1hQOK3pX9wlivfNIGc++8Tvkfy6O6+KPzBxWtsxKTXHiEmbqfFNvxZlX6BeHpLyUJ6YqXl/Nar/DplUrhRHA4cClVcC4W+U+QYaqN7yegFwOdAxLDu2iwmwiznCVCxSafn3P4BeDONTDY6mI+5vArOOSmoG5jLZupdIf6SI+4xWsA4rDfWaN+Y8PKsWezdKtYM1l8K9sVXz8X6i8kGcRnlGu4SOHE7yDMQZsXs0iuJT/HeexWVtb8Vsq7dDHk/2aPS4bi4ZxS9j4Nh3gWXF
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 05:32:10.9098
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9ee7f76-724c-4a64-f53b-08ded8c46e6c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044AA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6393

tegra241_vcmdq_alloc_smmu_cmdq() allocates the VCMDQ buffer via the common
arm_smmu_init_one_queue(), which uses smmu->dev and its coherent DMA mask
of DMA_BIT_MASK(smmu->oas). The architectural Q_BASE_ADDR_MASK is 52 bits,
but the Tegra241 VCMDQ_BASE holds only 48 (VCMDQ_ADDR), so the masked write
"q_base = base_dma & VCMDQ_ADDR" silently drops bits 48 and up.

A real Tegra241 never reports a 52-bit OAS alongside the 48-bit VCMDQ, so
this cannot happen on correct hardware, but a buggy or hostile hypervisor
could still advertise such an OAS to a guest. The user-VCMDQ path already
rejects a base_addr_pa with bits set outside VCMDQ_ADDR; add the same guard
to the kernel-allocated path, failing the queue init rather than silently
truncating the base. Use dev_warn_once() rather than WARN_ON(): the OAS is
hypervisor-controlled, and a WARN_ON() would let it panic a guest that is
booted with panic_on_warn.

Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
index 2d832d633d030..41046605de9ca 100644
--- a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
+++ b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
@@ -674,6 +674,19 @@ static int tegra241_vcmdq_alloc_smmu_cmdq(struct tegra241_vcmdq *vcmdq)
 	if (ret)
 		return ret;
 
+	/*
+	 * The q->base_dma is bounded by DMA_BIT_MASK of SMMU's IDR5.OAS. On a
+	 * real hardware, VCMDQ_ADDR mask and IDR5.OAS are always aligned. But
+	 * a buggy VM might set a mismatched IDR5.OAS for SMMU. Spit a warning
+	 * instead of a silent truncation.
+	 */
+	if (q->base_dma & ~VCMDQ_ADDR) {
+		dev_warn_once(
+			vcmdq->cmdqv->dev,
+			"VCMDQ base %pad exceeds the 48-bit VCMDQ_ADDR limit\n",
+			&q->base_dma);
+		return -EINVAL;
+	}
 	/* ...override q_base to write VCMDQ_BASE registers */
 	q->q_base = q->base_dma & VCMDQ_ADDR;
 	q->q_base |= FIELD_PREP(VCMDQ_LOG2SIZE, q->llq.max_n_shift);
-- 
2.43.0

