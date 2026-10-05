Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011035.outbound.protection.outlook.com [40.107.208.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C837E274658
	for <iommu@lists.linux.dev>; Mon,  5 Oct 2026 04:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791175093; cv=fail; b=m+UmK/lVlKsM4rRUQDvcdsdLAyKJpfnu+IQ7VTzi82+jJDBab/1d19o88YSRcO+WXGXtY0kjH3wClTQ4nm9ucSU5whRKVSYSL2aVKwx8p/KbLGtNW1MXca1sHxYCTfFXINs4eYKcH5JgoNADeJmQFWb/mIun/Rb7qGReKbIUZSI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791175093; c=relaxed/simple;
	bh=bEejZcA/AsFK2yaBupjeQ5ZypWTObYKV+8kYHna5jBE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jJCYjf7ctoEap+/iP5nmRBX6MF2M8+yqcvOGWk+fjLG9nqXHCnsQaEm8xW9baX7XNv8xxU97RwurLP0ahk8W2799LzvN0wY9y7gmrbKerZnOXBknRjolkcraB1y6jLI+owDZkYYseLexU2gLcMS2ccKoIhJfw+qa3Ta05knRrqQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EOm4fmrj; arc=fail smtp.client-ip=40.107.208.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EOm4fmrj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DwRrwi2SN3uL/RDyJifpYdQf6Fbm4o8UYhwHbPu9cdKCkqbbFcOSbMSLftPTd2bIqptxbk9KMlvG4f2xmxfbylO2ohDcTINDAXv+TpeK1Msdlq3f3pJqFL9gChIr2zn8Ro1dBp1yKPoA8NvennYYh3CkTU+45OuhjwMObVGEyzrehaWDo2STDlhtRWN2HeOOb47k5uNArm5fYJHpggR8LL9KGob36g1OVxpVn9XPA221NM8RM8ocjl+PE+thihvy/n6ScLAxPA58P6PyFH7dW4kajn908vqoaJHUhDhqn6PUQM6bPjDSJ7rdO/zqL7F7YV8jLuyJ5XoEp2k300nBuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O/ziH18LAbNiH6REnk/O8I8z/GkAviNGuhqg0Og/uFo=;
 b=KzYbgpyiK45S4ErMEgVZ1tyGpJ/KT4QdUKKDgoEQ52BMg9NodC+jLh6jJiYuuCOrqzKsY3jjPTw3qk2E/GhyoYJ+eVq435hte1mL3XssNi51BUccaAp/MNyX9Lj9mwz9VmiV6VPv8ugHyMJ+AP0lDWxrTx5e2vuNI5C3iYM9XxNP9AHdXDM5j5bsE95zAabstFbURzqBoX5+/OQkpwklOBccfLM3m1VvyBiM9nw+Y7KA9MDvRZQNPriAt2MtoOumZcFCBlqcnc/tyLr8Yva2zuGKrzIX7OC8jUN+h9bqnMbNW/Euhq6GH9Y6NwwTna8xt5sRg4BE2fGHe2+uosnv0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O/ziH18LAbNiH6REnk/O8I8z/GkAviNGuhqg0Og/uFo=;
 b=EOm4fmrjYhR2rkyzj1jJD1kuwfKDMA138kMZ+Y4bpEbU11Yr6Qr8gVwDIFpAbC9HAxgxKjiUZk71+CSnaf6egGdZ6pzgMtaGyq7juBTZOVuKkUqVOkRGyJ+UlIL2v944xjq4NJdUXTTXYC+kmMJivYV8sbQuewRPz08VKXFVF5SHISECPTKJ7lf7S2Vu2NBtIHGMmqUst/6iNHsoqpenaOPI+ZWBTFwJErcUO8csjNTo90rlIFEvzsMIilODdgdSuMgC4f2MlJXGQKMfJFlS1Rs14hdAesz1Qezudei6GU11qfYbbD+tPJodSzfSAh1IEM4X98WK50Jt1HnWBX0TZg==
Received: from BN0PR04CA0205.namprd04.prod.outlook.com (2603:10b6:408:e9::30)
 by MN0PR12MB6295.namprd12.prod.outlook.com (2603:10b6:208:3c0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 5 Oct
 2026 04:38:05 +0000
Received: from BN3PEPF0000B069.namprd21.prod.outlook.com
 (2603:10b6:408:e9:cafe::85) by BN0PR04CA0205.outlook.office365.com
 (2603:10b6:408:e9::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Mon, 5
 Oct 2026 04:38:05 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN3PEPF0000B069.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.3 via Frontend Transport; Mon, 5 Oct 2026 04:38:05 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Sun, 4 Oct
 2026 21:37:51 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Sun, 4 Oct
 2026 21:37:51 -0700
Received: from nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49 via Frontend
 Transport; Sun, 4 Oct 2026 21:37:49 -0700
Date: Sun, 4 Oct 2026 21:37:48 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Will Deacon <will@kernel.org>
CC: <robin.murphy@arm.com>, <jgg@nvidia.com>, <joro@8bytes.org>,
	<praan@google.com>, <kevin.tian@intel.com>, <smostafa@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <jamien@nvidia.com>, <kas@kernel.org>
Subject: Re: [PATCH v10 03/13] iommu/arm-smmu-v3: Add ARM_SMMU_FEAT_EVTQ for
 the event queue
Message-ID: <asMpnDFQgry5moXr@nvidia.com>
References: <cover.1788130528.git.nicolinc@nvidia.com>
 <b6493aeece86f44195e8afb6fb8b3497cc237dc2.1788130528.git.nicolinc@nvidia.com>
 <asJTer4cNh4DAQMY@willie-the-truck>
 <asK1JIsTay1yeBEU@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <asK1JIsTay1yeBEU@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B069:EE_|MN0PR12MB6295:EE_
X-MS-Office365-Filtering-Correlation-Id: 86f2abc9-145c-4b64-bd04-08df229a729c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|7416014|82310400026|36860700016|18002099003|22082099003|56012099006|4143699003|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	clfLeG/L8tgcaN7J43Z2CnRijOGk2R/53/l1X4I69udX82FLN3s0XDoVLpaD06XvfathkvIbTYE5YyVbDwTOyOFSzNMEKG/eI2dlXSzVFE24muY7J8rwn1hFgIVXmlJcNiIXaMIA9lPgaTs5nKAdk6vguopLfYwyV4yLsWyRITzGV6grBGvVNtVBwLiONCs+l30cr5Tz5bgsBIpJKxM4j5VzyCN0/VncUvZ0VNVtXAASRc0/Ns2sqgNjam+8GlcFT0E0hdRptpp6hjXrYyQ7q7cZx6Hrm4FvO342HpF8uzFdof2Rk3vTC4Xzsw8+UaVwnod2NxxD+3ZEoYJ71Qk6QV2ZXZLqXuJXX1dze326jKbfjKIdcJe7/dh78JThQIkkN9Rsn2MA2cBIegf7PwZ9/qBllMn80E8OUd9mbcraNyHaU0cwc0coKa0/ASKhhLNGXTIOHwA8evTfw3TiRmLKscVfkfT+QcRm8UnRVyLwd2rGJy+XL5b9lT7+zNh5IG14z67gFCc4o2brAXJpqSRigWoPOkEOx+lWuec9o81hJZNaPVYdE2mUFHqvtEGuAOgti5Xj0n/35M9uPKF6xR8U6VfB36whjm6BIOd0v6xRCS2+uescDaUKbLTQHY5sj8I6jk+wp1oSVlocIetf+cDK4WBqLUTatbOgHBRSGQr9hgfLdxQdAbVC3g5PHq3yA2P4MEZBZ5HBLJo1XYjfr2EzAg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(82310400026)(36860700016)(18002099003)(22082099003)(56012099006)(4143699003)(10067099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	0OLONGkrCschtZ18UPp67Z8gEvIR6B9vTpauU93HDopdtR19EUilmaUqG4Tz3Uy2S7vFvDkUuG79a/EWFUdOQEcYAAq4SacDaVMx3V7J2weP5C0//yxVhGzZbHluhCE2fY/P8lEzoq4ZDYa9jZhdYufx/XsdB0jJWF+yDzeeumJE/eS4vMOVMxMHPaVo04zLVaykX3F0ely9B5UYUhts87SOj9mlgqF+7sE/0NP1qHbHiUzirmnzT00G7QMY+9EVEpWaJkPNlGhzcs5bu4u6csqYyieHVEPrc2HzaumH+17b+LEYFvZeI/29dP59ceFyzcN6gsIMyFv0YHzcws3Xr0CD7PG7dcPM7CpuIsbpBxdBmPB6tslfUwdzFAzv4BdTLWRCtAMPiPaQwO4kq3K/RS3cjtB8Uz+Z0qL6Jypd3AbU+7n6MfotVaDyIm944JrG
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 04:38:05.1228
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86f2abc9-145c-4b64-bd04-08df229a729c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B069.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6295

On Sun, Oct 04, 2026 at 01:20:52PM -0700, Nicolin Chen wrote:
> Sashiko is only right about the small waste of the MSI vector since
> it's unused. But, that nvec decrement trick only works for PRIQ, as
> its MSI index is at top of the list:
> 
>    enum arm_smmu_msi_index {
> 	EVTQ_MSI_INDEX,
> 	GERROR_MSI_INDEX,
> 	PRIQ_MSI_INDEX,
> 	ARM_SMMU_MAX_MSIS, // "nvec--" shifts up this, skipping PRIQ
>    };
> 
> On the other hand, EVTQ_MSI_INDEX is at 0. Skipping it would need to
> shift the entire index list; struct arm_smmu_msi_cfg would not work
> straightforwardly as today.

I made a small change swapping those two indexes. Though it cannot
break the dependency on the vectors, I think we should be fine as
there should be no use case for !FEAT_EVTQ && FEAT_PRI.

-----------------------prep patch--------------------------
@@ -59,4 +59,4 @@ static DEFINE_STATIC_KEY_FALSE(arm_smmu_erratum_repeat_tlbi_cfgi_key);
 enum arm_smmu_msi_index {
-	EVTQ_MSI_INDEX,
 	GERROR_MSI_INDEX,
+	EVTQ_MSI_INDEX,
 	PRIQ_MSI_INDEX,
@@ -70,7 +70,2 @@ static_assert(sizeof(struct arm_smmu_cd) == NUM_ENTRY_QWORDS * sizeof(u64));
 static phys_addr_t arm_smmu_msi_cfg[ARM_SMMU_MAX_MSIS][3] = {
-	[EVTQ_MSI_INDEX] = {
-		ARM_SMMU_EVTQ_IRQ_CFG0,
-		ARM_SMMU_EVTQ_IRQ_CFG1,
-		ARM_SMMU_EVTQ_IRQ_CFG2,
-	},
 	[GERROR_MSI_INDEX] = {
@@ -80,2 +75,7 @@ static phys_addr_t arm_smmu_msi_cfg[ARM_SMMU_MAX_MSIS][3] = {
 	},
+	[EVTQ_MSI_INDEX] = {
+		ARM_SMMU_EVTQ_IRQ_CFG0,
+		ARM_SMMU_EVTQ_IRQ_CFG1,
+		ARM_SMMU_EVTQ_IRQ_CFG2,
+	},
 	[PRIQ_MSI_INDEX] = {
@@ -4967,3 +4967,3 @@ static void arm_smmu_setup_msis(struct arm_smmu_device *smmu)
 
-	/* Allocate MSIs for evtq, gerror and priq. Ignore cmdq */
+	/* Allocate MSIs for gerror, evtq and priq. Ignore cmdq */
 	ret = platform_device_msi_init_and_alloc_irqs(dev, nvec, arm_smmu_write_msi_msg);
@@ -4974,4 +4974,4 @@ static void arm_smmu_setup_msis(struct arm_smmu_device *smmu)
 
-	smmu->evtq.q.irq = msi_get_virq(dev, EVTQ_MSI_INDEX);
 	smmu->gerr_irq = msi_get_virq(dev, GERROR_MSI_INDEX);
+	smmu->evtq.q.irq = msi_get_virq(dev, EVTQ_MSI_INDEX);
 	smmu->priq.q.irq = msi_get_virq(dev, PRIQ_MSI_INDEX);
-----------------------------------------------------------

-----------------------nvec patch--------------------------
@@ -4952,3 +4961,11 @@ static void arm_smmu_setup_msis(struct arm_smmu_device *smmu)
 	writeq_relaxed(0, smmu->base + ARM_SMMU_GERROR_IRQ_CFG0);
-	writeq_relaxed(0, smmu->base + ARM_SMMU_EVTQ_IRQ_CFG0);
+
+	/* PRIQ's vector needs EVTQ's to be kept */
+	WARN_ON_ONCE(!(smmu->features & ARM_SMMU_FEAT_EVTQ) &&
+		     (smmu->features & ARM_SMMU_FEAT_PRI));
+
+	if (smmu->features & ARM_SMMU_FEAT_EVTQ)
+		writeq_relaxed(0, smmu->base + ARM_SMMU_EVTQ_IRQ_CFG0);
+	else
+		nvec--;
 
-----------------------------------------------------------

I also did a rebase on arm/smmu/updates, resolving merge conflict.

I can quickly respin a v11 once we finalize the discussions in the
other thread. 

Thanks
Nicolin
