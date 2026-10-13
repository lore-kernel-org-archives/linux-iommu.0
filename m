Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010023.outbound.protection.outlook.com [52.101.85.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D464854F8
	for <iommu@lists.linux.dev>; Tue, 13 Oct 2026 17:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791913330; cv=fail; b=F/+1WzHJrBJs2hhiw20DuWHkCyItSQDeE4j5DICK+quB/F9qfxXkXLj6twRwf8R9Xf9d8d5djPdmA3TE9RYcXasGT+77OqMMHjT1NTL4qYByLnYqxxoVTWNy5g+EyfB58MWDAHRy+js+6yeLq17lgh8l4gbM8fauiDkvK0mRDl4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791913330; c=relaxed/simple;
	bh=F7dW19F3AZHXvWHAmL1aUUNP4MG39l3EpPcRhgyp4Uk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LRXNDCpF23cqjMUjvLVWp1gzuHzjnYvpDPsPi1Tjt29EQT/en6kIFIX04Nz9uorSZVujjM2Ga5oYA/sizzwYUk0KWHy7Z3Byvuum4SdLmQTr6TShegwnYYgpPP1/dqORlpH7X9QaBI1Lx6AcQhMbcL3JDkQMkbz2CFMM/5NqDs4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Sbetmktp; arc=fail smtp.client-ip=52.101.85.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Sbetmktp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dzpIqa9sVbE2s5E2MsMapiaK6U070Fv5z5dnIeCZBWBM6XES4q10rPTcF9RVljt6S0IFX4APwg9gYVbmcpbQDzwtTIMT8rSahggltfA547EIplxOyDu4eGQcppl8CtEw3ZikawUnqIdJCj5wupl41GxKqgBUscePZu7qPjpruyzib8UQsD8r7CJTbm2jac6qO03jWyIJnEjc1jKb3w28eyARF2tFUhLqiGmMZOEaH0IDCJWg++pfwoxEDKAJEnCDd4WxenuGJXh9mLMngx+DEa1pgruG8MoAilYiXL20QRdEboNl6jyTXt/6ef4hea+aqocSLgauxqlAgR6dZZpkiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AWLGk4M8RWnLC331E/eJtLrY3wcwilQb82FAA06rV08=;
 b=p7iGFJNYJdzly4n1gb4V1a4pSaznxQKvK43XbooZexj0rIHI6mAm9S8Wi24HXTTsLizSD9z82AgYXkx3+eucEOc0fGcW2p15XmAnPDRvxCrfZYT0IfHCoZLuamjMsaDNPQNORDLwj0ffJ94J7x+yixBX2XRmRxOY20xbYW97jHhdoTb3VftJ3oWWedevASmdIyt1vEqlGmHtUHAqwj6oVdlBcDodFm2GJBQ/yXnendu/AWOeFCtqsIZenyZZom1olqXGhoGXBPO9QbBQX31jK2kJNfzQG5yWvAX/clpTHQ84f/Sob+cKtSohuvkkOpiKkoCZBE4qVxvlN4BoB2ZVQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AWLGk4M8RWnLC331E/eJtLrY3wcwilQb82FAA06rV08=;
 b=SbetmktpIftuGbxm9a28AaiGFRivSQepos9eGkub9h0VJ0iAbXDGeUq1ZRZW9jMcvf7lACEvi8px1VG4Whc+nx2a0tNyxBX/fB6P+AWRhd6JEpddsjV9UH9SPEqd5lIQ20e3IwxfPYNrdLt1fGnhdWpSXUjUhvVOgz0JdMnvtFbTWhWPAopf1x42GeRHs8XKhrlJDMjSma/mB+aaY+A/b/cC1RD53nbxiNI9ixEh1zm+W2xKadHAZDV3YnG13OMQ5ZHgF8gSIDCdHVIvvR5OAD6A/sHb7jUsZUAstpVmkRIgkTDFeYuMOyMo5w+tk/ckRVJj/pWATLqkMOhc5dpEEg==
Received: from SJ0PR05CA0105.namprd05.prod.outlook.com (2603:10b6:a03:334::20)
 by CY8PR12MB8265.namprd12.prod.outlook.com (2603:10b6:930:72::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.24; Tue, 13 Oct
 2026 17:42:03 +0000
Received: from SJ1PEPF000026CA.namprd04.prod.outlook.com
 (2603:10b6:a03:334:cafe::53) by SJ0PR05CA0105.outlook.office365.com
 (2603:10b6:a03:334::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Tue, 13
 Oct 2026 17:42:03 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000026CA.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Tue, 13 Oct 2026 17:42:03 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 13 Oct
 2026 10:41:44 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 13 Oct
 2026 10:41:44 -0700
Received: from nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49 via Frontend
 Transport; Tue, 13 Oct 2026 10:41:42 -0700
Date: Tue, 13 Oct 2026 10:41:40 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<praan@google.com>, <kevin.tian@intel.com>, <smostafa@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <jamien@nvidia.com>, <kas@kernel.org>,
	Cristian Prundeanu <cpru@amazon.com>, Breno Leitao <leitao@kernel.org>
Subject: Re: [PATCH v11 03/11] iommu/arm-smmu-v3: Swap EVTQ_MSI_INDEX and
 GERROR_MSI_INDEX
Message-ID: <as5tVAzw2TAX5bEq@nvidia.com>
References: <cover.1791226953.git.nicolinc@nvidia.com>
 <630e70ba13639e5bd86fca0b574dd47dddb7fb92.1791226953.git.nicolinc@nvidia.com>
 <179190297652.2261874.5664965715184131627.b4-review@b4>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <179190297652.2261874.5664965715184131627.b4-review@b4>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026CA:EE_|CY8PR12MB8265:EE_
X-MS-Office365-Filtering-Correlation-Id: 549ae4ca-41db-4562-3271-08df29514b01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|36860700016|82310400026|10067099003|261009223027099003|4143699003|11063799006|56012099006|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	ecKrVLO5tLaxMK9JgGLjxHyhnnLQnX5K5K81gTiMJqXoswvULaTErrXpyoIAsF01PmfmySqfZls+JC8INVTwgtRQYHozzEX1qP2aBhnQErHIReQLVDMsnQByRoGIb1ulnyFxj8PVg7vSTYl/fYjYfa/48dZnZ3lkulFMmjNKIRmZhhlCiXM+Bz07oBOo2Z+bFYKJfIkg5JPxEmfB7/COH/XiwpGNlohwzPYfwJYyDzKcPBdtxRhYaC6tjUcwUY2HdYC4hneEy0tsZ2slJgsg+1bUYvB6r7GAzDxCyVNNOvW7SktQiKIKi3gvqu7mWaO+URGGdiw4vDHn2eYauUse8t4prnXUP5P2SU8gDVKwWpA9Sj1vpfw6aVPSXEyfqCeXdPtNUy5vSUVcPqYjBx7txa0KsJqMajfSabBzhnBdNQu8QO2w5wK7jfZXUw6UuxLHJgROwZOUMc9vy34oA1PYGcMlDpSYTQLzDfLL+w6AM+hOQOUepHTgXJY5vZJ4zxh3jy1P1PsTS2d2jzK9CQDi77CyEV+YwCCWJDSWCSWRw4TQG1fjyMx+mprHCxSpCBe1XoUVjKi8wuvtLLR/3+G37ev50PxkagjXCVSTSgVC2NSnEyODFQxWOnQNeqIDcsV2LtNm6WV4VbYO0L0vIc3TsvCxIGOSle0N2D7z9LPME1ed71Tu3NJR4mEWfg+hJlAo6Wm/E2mfpjHkl4b9edIr5w==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(36860700016)(82310400026)(10067099003)(261009223027099003)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	PI5jVFHyIB8t2TJs6ZTSfdEAMEl08QFAmlHAOROp8fePYFrNQMXOg+VjLm3jLuvh0ttoGOCMS/MACzPTPhXmUgr8X43sWocNva2UTC0n52IHhGqohrOpFPSVrnIOafXYHq0QOd4znZ2Rwe2yYMiqQilErJFf5tUTL8T8pkruOgQK5pgc3wvXhcT4uI7OP+VNlGd8jHT7OTfunn6+uhAskMAPwV1wmwIpRNtHbheSiuF12WDGhsltgFNzdD4+2tsBC/YRQdU4dHBGHOhV/LVy6JLFNEC39kjgqOOaA6E9sUSaRRINezi9BEUWZ7EVltzXB4BFKXQe8juoFUBMVr4DEH7UkGytXm4h6EacWq7rFx1O7tRTSlf+6v5J7i/L6JkqPa7C/NNgOEBAj/TxYgso9jI4XZhChmL/kn2OrndJspoZXsYCX0268W/LgW7EG/J1
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 17:42:03.7037
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 549ae4ca-41db-4562-3271-08df29514b01
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026CA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8265

On Tue, Oct 13, 2026 at 11:49:36AM -0300, Jason Gunthorpe wrote:
> I think if you want to compress the nvec's array it should be done
> directly.
> 
> The smmu should have a small array
>    u8 msi_map[]
> 
> Which holds the xx_MSI_INDEX value. Then arm_smmu_write_msi_msg()
> would indirect to get the config:
> 
> 	phys_addr_t *cfg = arm_smmu_msi_cfg[smmu->msi_map[desc->msi_index]];
> 
> And we just compress msi_map as we go through the normal flow
> 
>    index_msi[EVTQ_MSI_INDEX] = nvec;
>    smmu->msi_map[nvec++] = EVTQ_MSI_INDEX
> 
> Then it isn't fragile at all.

Thanks. I replaced this patch with:

Subject: [PATCH] iommu/arm-smmu-v3: Pack the MSI vectors of the used sources

arm_smmu_setup_msis() skips the PRIQ vector by decreasing nvec, which only
works since PRIQ_MSI_INDEX is the last index. A subsequent change will make
the EVTQ optional for kdump, whose index is 0, so that trick won't work.

Pack the vectors of the used sources instead, and record the source of each
vector in a new msi_map, for arm_smmu_write_msi_msg() to find the register
set, regardless of the sources in use.

No functional change intended.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Assisted-by: LLM
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 42 +++++++++++----------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  9 +++++
 2 files changed, 32 insertions(+), 19 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index aeace4335abfe..2ec117d231569 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -56,13 +56,6 @@ static struct iommu_dirty_ops arm_smmu_dirty_ops;
  */
 static DEFINE_STATIC_KEY_FALSE(arm_smmu_erratum_repeat_tlbi_cfgi_key);
 
-enum arm_smmu_msi_index {
-	EVTQ_MSI_INDEX,
-	GERROR_MSI_INDEX,
-	PRIQ_MSI_INDEX,
-	ARM_SMMU_MAX_MSIS,
-};
-
 #define NUM_ENTRY_QWORDS 8
 static_assert(sizeof(struct arm_smmu_ste) == NUM_ENTRY_QWORDS * sizeof(u64));
 static_assert(sizeof(struct arm_smmu_cd) == NUM_ENTRY_QWORDS * sizeof(u64));
@@ -4933,7 +4926,7 @@ static void arm_smmu_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
 	phys_addr_t doorbell;
 	struct device *dev = msi_desc_to_dev(desc);
 	struct arm_smmu_device *smmu = dev_get_drvdata(dev);
-	phys_addr_t *cfg = arm_smmu_msi_cfg[desc->msi_index];
+	phys_addr_t *cfg = arm_smmu_msi_cfg[smmu->msi_map[desc->msi_index]];
 
 	doorbell = (((u64)msg->address_hi) << 32) | msg->address_lo;
 	doorbell &= MSI_CFG0_ADDR_MASK;
@@ -4943,19 +4936,29 @@ static void arm_smmu_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
 	writel_relaxed(ARM_SMMU_MEMATTR_DEVICE_nGnRE, smmu->base + cfg[2]);
 }
 
+static void arm_smmu_setup_msi_vector(struct arm_smmu_device *smmu,
+				      unsigned int *vec, unsigned int *nvec,
+				      enum arm_smmu_msi_index index)
+{
+	writeq_relaxed(0, smmu->base + arm_smmu_msi_cfg[index][0]);
+	vec[index] = *nvec;
+	smmu->msi_map[(*nvec)++] = index;
+}
+
 static void arm_smmu_setup_msis(struct arm_smmu_device *smmu)
 {
-	int ret, nvec = ARM_SMMU_MAX_MSIS;
+	unsigned int vec[ARM_SMMU_MAX_MSIS] = {
+		/* An unused source maps to a vector past nvec */
+		[0 ... ARM_SMMU_MAX_MSIS - 1] = ARM_SMMU_MAX_MSIS,
+	};
 	struct device *dev = smmu->dev;
+	unsigned int nvec = 0;
+	int ret;
 
-	/* Clear the MSI address regs */
-	writeq_relaxed(0, smmu->base + ARM_SMMU_GERROR_IRQ_CFG0);
-	writeq_relaxed(0, smmu->base + ARM_SMMU_EVTQ_IRQ_CFG0);
-
+	arm_smmu_setup_msi_vector(smmu, vec, &nvec, EVTQ_MSI_INDEX);
+	arm_smmu_setup_msi_vector(smmu, vec, &nvec, GERROR_MSI_INDEX);
 	if (smmu->features & ARM_SMMU_FEAT_PRI)
-		writeq_relaxed(0, smmu->base + ARM_SMMU_PRIQ_IRQ_CFG0);
-	else
-		nvec--;
+		arm_smmu_setup_msi_vector(smmu, vec, &nvec, PRIQ_MSI_INDEX);
 
 	if (!(smmu->features & ARM_SMMU_FEAT_MSI))
 		return;
@@ -4972,9 +4975,10 @@ static void arm_smmu_setup_msis(struct arm_smmu_device *smmu)
 		return;
 	}
 
-	smmu->evtq.q.irq = msi_get_virq(dev, EVTQ_MSI_INDEX);
-	smmu->gerr_irq = msi_get_virq(dev, GERROR_MSI_INDEX);
-	smmu->priq.q.irq = msi_get_virq(dev, PRIQ_MSI_INDEX);
+	/* msi_get_virq() returns 0 for an unused source that has no vector */
+	smmu->evtq.q.irq = msi_get_virq(dev, vec[EVTQ_MSI_INDEX]);
+	smmu->gerr_irq = msi_get_virq(dev, vec[GERROR_MSI_INDEX]);
+	smmu->priq.q.irq = msi_get_virq(dev, vec[PRIQ_MSI_INDEX]);
 
 	/* Add callback to free MSIs on teardown */
 	devm_add_action_or_reset(dev, arm_smmu_free_msis, dev);
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 8f2c0b1cc4a8d..bce592fff0b12 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -936,6 +936,13 @@ struct arm_smmu_impl_ops {
 			  const struct iommu_user_data *user_data);
 };
 
+enum arm_smmu_msi_index {
+	EVTQ_MSI_INDEX,
+	GERROR_MSI_INDEX,
+	PRIQ_MSI_INDEX,
+	ARM_SMMU_MAX_MSIS,
+};
+
 /* An SMMUv3 instance */
 struct arm_smmu_device {
 	struct device			*dev;
@@ -993,6 +1000,8 @@ struct arm_smmu_device {
 
 	int				gerr_irq;
 	int				combined_irq;
+	/* MSI vector index to enum arm_smmu_msi_index */
+	u8				msi_map[ARM_SMMU_MAX_MSIS];
 
 	unsigned long			oas; /* PA */
 	unsigned long			pgsize_bitmap;
