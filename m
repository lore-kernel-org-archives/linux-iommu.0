Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010061.outbound.protection.outlook.com [52.101.61.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5BE357CEA
	for <iommu@lists.linux.dev>; Sun, 30 Aug 2026 23:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788131934; cv=fail; b=VBoRYSAGYPdxmayfrV4+SFz+ojo6qlKiKfdQg6vK9/f1TVkbdyRGpXNfdn4KvawAVoalMa67xGGJkGnhnnhLj6gn9Gu1H04D36XBcqeEdpYSeXAxkMSYx4Xnw0izUkWD8U+BnIPrkeobibRBKIcuXhkl8xxcEsYaxaJ5iyqsMgM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788131934; c=relaxed/simple;
	bh=Cy9TXLqyzFYbXVW1n8ZdYPybsDNsb4o7nMlBK3r7s2w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aBEQe018bxsa0DEUcnRxZWoguuDCMrMDUQdedB7iXmknB6VVRjLTBEwZ0iLX31hCoJd4I3HYyhHCsXsiFcIZ9gmMPvEbIWSwVVITPi3nF6DiRxpy1O3pr4F0przg4a3E64PL8AxfT4zqEypxRO2R6cKe/yn6hyCFeT7z8hnU24g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CDFR6qBE; arc=fail smtp.client-ip=52.101.61.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CDFR6qBE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OI2I2MZSWIUPt/eJP4gtNgPBTvHGJQJJrMdhn9PDT6DWJ1pvznlr9RrGMeTvqAErBxJeMgBnOHsdnuzIHjYL1SKDaR/AOB1IcD2zu6eWXeYrjZhGX5DDtNlEm4Za7QGGYJJN7FHukkIT1wVuKj0E3NHd84oBdjKjrJ20g1kMfbCFGOdCAZpSg6RLDfQ8Ni4akjjuT2KW5oX5qKwC5718hsCQBxaLNj8XPPjg5Ku5cKrw7/aUj3bKak9+82oziAlbua6b1btCgqXRamGjR3lEQUd0kJoozcQdb+0KpUzVYFMBKFto1JQKcHrHetqyhiwk06vcqImwkE8YgRSFLS7/RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pZheI3Fv83R6TjpDtDlNg1Csb2GpSlwR+QyGbeoVFWs=;
 b=VdSeDuAweh4AKhRp/ZjXaxkV4t4ii/zS1g451K0+UcT3cdiIGgwK16tOVCIRnzTglbcJQQmqjWW1EQPKRKytkG+Qv3L6H86CuJVcXNTCjI0QU43Ox0E5lSHKnUUYR9oZZvR0lcy/Iuwk86ST2L9ev47jjRoi/qmp27Dde6vY/dKqOreVm8gfKmiVscrb63wEAZNItFYeqL0/D5EVsDEVuak+9lj7V6EsBQTCjyRt8IJFEPEEWels3SHaGJ93PVbZlnjn9QO+I/sC6YbBXtMSWZslAQMcG/8t2rVFUHGL00mHMIMQROFyGvDmE5vo86daUua4GLpuRtLLpEPLEb5htg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pZheI3Fv83R6TjpDtDlNg1Csb2GpSlwR+QyGbeoVFWs=;
 b=CDFR6qBEjwweTb0M334ct9o0fiT6dE4wz4/nsoO/A2OcldaDQhvgMewrNz2YcgEBCmcyJyymxJaPyzwB7pdtL5ZyJoe8iZ58E9vjOSuDREHNBoSY0pzF0k/qi83nKJw7zVysh+ZlTYypU2EksK2fhrbQkP0UQjyDvn2VZ3MxTfDaBhYx5i46v+CXmamt5/Fnaii/DofbCYHPoYRSn7uymxxVe2onS/F+t0K3FdS4KzV2gUw/i3V5l7xkTKGD5/ytvYtDZbPf5QPLAldrrZ9/4SPCt3FUO88/nHlgXSKK5IKqopv1p2G+T+yv79yLX4RhBtgJdhysTX+sMVoS0RUlkQ==
Received: from CH0PR04CA0092.namprd04.prod.outlook.com (2603:10b6:610:75::7)
 by DS0PR12MB7608.namprd12.prod.outlook.com (2603:10b6:8:13b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Sun, 30 Aug
 2026 23:18:45 +0000
Received: from DS3PEPF0000C37E.namprd04.prod.outlook.com
 (2603:10b6:610:75:cafe::4a) by CH0PR04CA0092.outlook.office365.com
 (2603:10b6:610:75::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Sun,
 30 Aug 2026 23:18:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS3PEPF0000C37E.mail.protection.outlook.com (10.167.23.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Sun, 30 Aug 2026 23:18:44 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Sun, 30 Aug
 2026 16:18:35 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Sun, 30 Aug 2026 16:18:35 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Sun, 30 Aug 2026 16:18:34 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>
CC: <joro@8bytes.org>, <praan@google.com>, <kevin.tian@intel.com>,
	<smostafa@google.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>, <jamien@nvidia.com>,
	<kas@kernel.org>
Subject: [PATCH v10 04/13] iommu/arm-smmu-v3: Disable the EVTQ and the PRIQ in a kdump kernel
Date: Sun, 30 Aug 2026 16:18:05 -0700
Message-ID: <861f488cbbfa84a4d222a22615adbe5d2617bc87.1788130528.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1788130528.git.nicolinc@nvidia.com>
References: <cover.1788130528.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37E:EE_|DS0PR12MB7608:EE_
X-MS-Office365-Filtering-Correlation-Id: c2519056-6b78-4e25-b0a2-08df06ed09b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|23010399003|36860700016|13003099007|6133799003|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	AyyEgVlHUyxW9llJyWZ4i2QeM636TLNeu05uK7qf4sjdMIKs/ulW7qKBVV27B3JHSjUbW3BBZ1LWuZcKpsGQKEIlAIlD865JonU5UUiieOEZUXeQUB+uOtZ3RaoNO923RRbSIjZy4FBvLpc1ao3SvtLUc+5T+WwDR9gXOWKm2t5eq/mo0tQq1ALdzFjo0R9aTf2nnBYlSinnNN11r59A0ngQyBfv8Xxg4EV4qQBpOTURdU+EjJs3zi6sEOCmRzEvjl3fvVJobU+Ok3AOw2S22mxjzXEwTm3fWzx+NR89fCgwDP70yW8vUl9n3dwSbP5cseFzYlnFZvD8zbn1JBQQZIsoa50Q/VdkirSZmgppesVWKPsblPc2QxnAZO9azQNNR75tZzbjWsEl9M9PGZevGqm0UtFkbVyrsglX4QPzfeAs7J7X9HPPYIzdDmOP+58uj73DHk1WmTxavyRTgXpaP32dMkNo62xZEihCh7s7PyZ2XOU9J++sBpHXx3RfEyWC5S6rj8NLqRbawA+UkDCTXdkpOpAyxv3/LTxo2ek6StcPvJD9EiE3tIlhXYW73Bp9FwKiCZMAVTXlXi6I5i/r6i+8pqMtJkQvtUvkkk5XaeVPZ5mG29O+zbjndDDEDWoj74T396/7lp9Wikl8Be20DDCwmzp9wT8Gl2CbuTXJujeiSKCpd6D+crozvcL/MBoxGXalCBlHhjfzrTxxWED/Ug==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(23010399003)(36860700016)(13003099007)(6133799003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	N0BrZP+CbTdhvmsWkx8k5lswffzxn8h8UvgMKS2sLrV7+rBDZLYWo9DXkEIeIODlwiZ3vT+lBkq7zB6I5UH3LXN1MGF730hPUQcUoymrP3AxnWLouPAupfeiM/qKRNJbm6dYnyk6HmaehsLFXFuqbU2j++BSWcgC8wCsn5CKAH1mmvDqmWfc3vJgYcXHYhQoqh9TBVYuohMYciK1aH1ubloRn9OHgyjjn767eKxkuGKwji2d4TOkbIt7+lUmeCY/g5PydbsyhdvR2TwtiW73P65r9tNenNYHoMLO3SIEXv/qyHCEr9TbWraI0Hehq7G6kyyAEOSmFNB5s7UBT3bsUYxpPPz4gClAH9EjdbyJOKlj4W1MoR+wTIms8Xn68E2vIUiiDzBQ8Hx3JaT7/V7D8/GX/qB80DJ6uF3ShcgLy9n3FHSTTEOPW0A8fMaO61QJ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2026 23:18:44.8607
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2519056-6b78-4e25-b0a2-08df06ed09b9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7608

A kdump kernel cannot use either queue. The crashed kernel's CDs and page
tables might be corrupted, so events would spam the EVTQ, and there is no
way to serve the page requests that would arrive at the PRIQ.

The reset routine still enables both of the queues and then masks the two
enable bits back out, having already programmed the queue bases and taken
the interrupts of both.

Clear ARM_SMMU_FEAT_EVTQ and ARM_SMMU_FEAT_PRI in the probe instead, so all
of the queue handling, i.e. the interrupts, the IRQ_CTRL bits and the CR0
enables, keeps away from a kdump kernel via the feature tests.

Both queues also go unallocated now, as the two allocations test the same
features. Each of them is sized from the maxima that IDR1 advertises, so up
to 4MB apiece on a 4K-page kernel, which a kdump kernel would otherwise pay
for every SMMU instance out of a small crashkernel reservation.

The IOPF workqueue of the event queue stays allocated here, as untangling
it from the SVA and the stall features takes a pair of changes carried by
the PRI series. It costs a struct and a workqueue rather than the megabytes
that the two queues take, so leave it to that series.

Suggested-by: Kevin Tian <kevin.tian@intel.com>
Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Suggested-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Suggested-by: Will Deacon <will@kernel.org>
Link: https://lore.kernel.org/all/amiBagGKn-Aym1DK@willie-the-truck/
Assisted-by: Claude:claude-opus-5
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index c776fdd43325d..7b9ef1ad1f688 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -4981,9 +4981,6 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu)
 		return ret;
 	}
 
-	if (is_kdump_kernel())
-		enables &= ~(CR0_EVTQEN | CR0_PRIQEN);
-
 	/* Enable the SMMU interface */
 	enables |= CR0_SMMUEN;
 	ret = arm_smmu_write_reg_sync(smmu, enables, ARM_SMMU_CR0,
@@ -5296,6 +5293,15 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
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

