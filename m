Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013054.outbound.protection.outlook.com [40.107.201.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A6D30F93F
	for <iommu@lists.linux.dev>; Sat,  6 Dec 2025 00:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764982356; cv=fail; b=oz59Ji3KB8ubFwhXfsU3GaFcnCKp7i3nzqVnIz5PwQJLdHy9K0n6G1bKSjturGi5hgHaUreC2AQK2nMjDsM3qBZvXXYMN7wIheTVbPiura7PGvu+W1a+slvQRc/Xb2mV4qn4DTonWWextl0h8QhPpCJhp/sWpeqMTTWzkp90QQM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764982356; c=relaxed/simple;
	bh=gqy0+d+Ac1WYBB223P/NZSyi/mkA4ktI33juahJW9sg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BW0xt2SVI26eSqoiiYfVDj1QJT7OWN4Liby9+jTFIfwFanp5155s5/zWf9hY/VZHudJwbJtEdh4cvFmuRBZ/ySoojtMn6TDJSsUpv6xFXuAUofF8HZ2o1HBpXvToxPPOD3aESnxjrDGvreDIDpLtqEvyGIHTBsBv1cZqEjwQmXQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TBbyXldt; arc=fail smtp.client-ip=40.107.201.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TBbyXldt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rIadJNKpQn36VCMjR9srPSFACNs21jbs7f02M503yTsjdbcA38x1mbknRJJUSAxfkejHRMp/sk6Q5pklOk2t4ZH8b3E472iywJpD0naT6rRHhrl8N765mLmInj+jvknoPrWSWzUFVUN0banH13kC+iVwCZ9E6ujTJdingNNFXLwgbBq4fXSeewfRqyMWHX0FtyDWTrZk9syx9wBde/MtBGW6KPs+pX7jepYIF/l3GW9MopWGH1wYzwqe9we5vmxW8amZ3ckNVryO3/WuZbEnLsr3/NEQDbCV91sxRK34d1i0sXTs6nLXewBjnrwJ2ESPs2EfNSbY3Mv87kM36IxUYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V3EFfVR06bIb5XQcHdUUcpRCGI2WAoB9QxjD7fCK+d8=;
 b=wRwEgpBY4PR5qguL8mCmHjFeJ5csx1/iysxcG/qukvHfgrISYXURdKYncVb2SeEK3rx1hZeCwynCbDE3I46Sn6N5/6okSzEwCGiTxdiDYllBnHanCFIL7wTlIg6ykPA7ojQX8xIxI9F+fsbOpL2FSNbIsTmvOmWO5nonB4cIeWYL9f/Dj5+XKrGfoytGEAkAC8K3/q33Bpds2oIiNyZQ6ysNSzk8Pokvevkk2ziu9VhxSCU3ghsiQs7ayUu5O4Wg/Lkvr8uArfpZL++GmQKMLgnmsL41fCruBznxD3DUX6rPnFliXJDIY7TM53UP6oat3HNULQWGVr8vNC0eFSsYhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V3EFfVR06bIb5XQcHdUUcpRCGI2WAoB9QxjD7fCK+d8=;
 b=TBbyXldtwwbmJZhCl9Pa8f3+ekTGfu5Z74moheEK1Ek0BfOQUEyozMmUVN0Mp9UEVl6XjZ8X74JQpgmr5Hsl92lAV53JanUQHTnka/vBbHTMojKGt2zNX21pzJhz4uYyD7gjbarmfvf8AmRgxJ7mZcLAO3o0w2a6jEcY/hG11iPNG0NsEYntjczT/bhJet2tc/p2BlOHWhUkuTsq7Dvs91cnRhN+SSiO8LrY5gCqjASl0k25trbcfkijNbXnt/dipBd7DvLMMvdMf5/FMISrjkwqHLx6Q2i4cLwBeRcTjCwb5OC/zFKrFoSCiKl5OnliCxblJEBqZcovpm31tz3EFA==
Received: from SJ0PR13CA0188.namprd13.prod.outlook.com (2603:10b6:a03:2c3::13)
 by LV3PR12MB9166.namprd12.prod.outlook.com (2603:10b6:408:19c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.12; Sat, 6 Dec
 2025 00:52:29 +0000
Received: from SJ5PEPF0000020A.namprd05.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::91) by SJ0PR13CA0188.outlook.office365.com
 (2603:10b6:a03:2c3::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.1 via Frontend Transport; Sat, 6
 Dec 2025 00:52:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ5PEPF0000020A.mail.protection.outlook.com (10.167.244.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Sat, 6 Dec 2025 00:52:29 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 5 Dec
 2025 16:52:21 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Fri, 5 Dec 2025 16:52:21 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Fri, 5 Dec 2025 16:52:20 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <will@kernel.org>, <robin.murphy@arm.com>
CC: <joro@8bytes.org>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<skolothumtho@nvidia.com>, <praan@google.com>
Subject: [PATCH rc v1 3/4] iommu/arm-smmu-v3: Ignore STE EATS when computing the update sequence
Date: Fri, 5 Dec 2025 16:52:02 -0800
Message-ID: <db1450e7a5989e51756a7ec3285d70ee90bae24f.1764982046.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1764982046.git.nicolinc@nvidia.com>
References: <cover.1764982046.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF0000020A:EE_|LV3PR12MB9166:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a0bee6c-f3a7-4a31-ac12-08de3461bb56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?om7aFF4TRLval4rABmXgU8M1g+yLiWt8qmspd0sE4Yt3kdZ4JFUWlbSwk8yI?=
 =?us-ascii?Q?kFqd7wX+4ZkM/D6nyXUYn0NVhmnNTzReXm6+gOezcAfOmNqnYCVOs0ojaWb2?=
 =?us-ascii?Q?IhiARzc2RTntvOwbRyZBjpVcAYhxYBffcaXDW8Yyj8D42XJeFCYMzwE6MEMU?=
 =?us-ascii?Q?tURrOCPJdyewyQboh8KGadWaWik4FpSO1aqqBwHY3aSXpd0tzSxbQ50ucrdZ?=
 =?us-ascii?Q?CKCZTkLz6VNPka8PFswhTxgsWxa9kdui9dx6ad3OmnrLMupFd97QP/WJa3Ti?=
 =?us-ascii?Q?alJvSgDRimxZ+tkAhVmT6LSMylB/YmrtOJ7waXfzQC8CATFDCroQLhWHouAO?=
 =?us-ascii?Q?S5/m6wGHU5tFthhxXvXYAABATyFjfmpkqNk52P2nO8NxBE5ZkHDDmyKUL1BW?=
 =?us-ascii?Q?uyqwTLP2/Wc7NPnNcTM6/PRaYrqhRXn6wzTedmNC31Tl1K4QebzgcgyAiLLX?=
 =?us-ascii?Q?Wsh+M9SerH444v7RWij2IRWtfC8FXtycB2oxsNhjhVNCBFTr0CxXke8EtFfF?=
 =?us-ascii?Q?jMB+BOGdoL38EoFRKqpHsG4J4pjAcfc2lXUiTxoU4dHT3VGMovLAttj5b1TR?=
 =?us-ascii?Q?AwAAdkJUztSxTezUAWDsu+8h8v7POYA/EkvyL8WbYoRCsfWCbIuqlKb/exEn?=
 =?us-ascii?Q?18G9jeRuUXS/QAFptkyULVeqz8HRk0rAajMNHsWHG8cHLIOvI0DB1prEjhhY?=
 =?us-ascii?Q?PlhNz3XC4YAU4crW0fntuwvSeIoahhWOAD3d5CBaHPYV1abanLSjNxi79x6U?=
 =?us-ascii?Q?BWsWacqx/WeqlljXVubpwVcaKMYLQbMyHAn5jLMUfoTDyaxw3mTavx8YFq5+?=
 =?us-ascii?Q?nvDu3yEY1s1VlLwevyA/TthFz3KAcDFEEDivaxUR4YUzARb/GpI/qaaroSZ+?=
 =?us-ascii?Q?TEjlVmqXrNRldm6HJ0nyDTy2Q8hit83Lz+6vZzmB319tlj0XfrOIZvi8OVoJ?=
 =?us-ascii?Q?qr3byG0kQqUHq0CbqL1Tm+Ic2ZNa9GaBo3JCK/H/nIPkpkYbTHeXwn13LV3C?=
 =?us-ascii?Q?G33rTHWwrQP7TR6U6wSdSDfQM9ltFYnbG2G0KvXeOy3g6q8HQ7AjZX8EXbkG?=
 =?us-ascii?Q?dnzvMRD2XV6jtNy4Wji6e1AdDDoLaBXRSCZNacoXBrsP3PyL8B8FY6cnIb2X?=
 =?us-ascii?Q?AeWmHDE0VfSVJt5DKvN7pso/k6nvZW0GCKzWz3yrduJLXcOoSPjRoQUJSMEI?=
 =?us-ascii?Q?vLZOMhysFFHXl4qNsTVBIj0Z8mbDf4gKb08FVEMqccnZC2u5+MQ4npS6/eXP?=
 =?us-ascii?Q?g8RxIlnG1BfmVlRha+y+XfD5agHrd0fept4x/zt7Q1ugmR/eeOfT4lbqciWE?=
 =?us-ascii?Q?qW7MsSeldnmIMxcbelqIGqLUCG5gf8D3IPmOO/LD38uHSE3UO+h4PXkMf4ww?=
 =?us-ascii?Q?/Bq7ShHFm9TECd5rLFPqR/aZY64IvonJYRDZBUkBsdqOlmq2g07bhAPEbND5?=
 =?us-ascii?Q?j48U5ITReumRbzhWENXBoWBLeCPesFv9I1S53b9jHR6iUXys3Ilm04KOeQ27?=
 =?us-ascii?Q?fGlodDonHb6S/wb1qMVi5r/pefzrwHW+YcSqrx1B0f3emk+miaWe5mVng0Qi?=
 =?us-ascii?Q?hakWZjhaWKzgpeFpdZM=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2025 00:52:29.2514
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a0bee6c-f3a7-4a31-ac12-08de3461bb56
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF0000020A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9166

From: Jason Gunthorpe <jgg@nvidia.com>

If a VM want to toggle EATS off the hypervisor will see EATS change to 0
and insert a V=0 breaking update into the STE even though the VM did not
ask for that.

Relax the rules for EATS sequencing, we don't need it to be exact because
the enclosing code will always disable ATS at the PCI device if we are
changing EATS. This ensures there are no ATS transactions that can race
with an EATS change so we don't need to carefully sequence these bits.

Fixes: 1e8be08d1c91 ("iommu/arm-smmu-v3: Support IOMMU_DOMAIN_NESTED")
Cc: stable@vger.kernel.org
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 2df657c87abd..6a982051c3c2 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1051,8 +1051,7 @@ void arm_smmu_get_ste_used(const __le64 *ent, __le64 *used_bits)
 		used_bits[1] |=
 			cpu_to_le64(STRTAB_STE_1_S1DSS | STRTAB_STE_1_S1CIR |
 				    STRTAB_STE_1_S1COR | STRTAB_STE_1_S1CSH |
-				    STRTAB_STE_1_S1STALLD | STRTAB_STE_1_STRW |
-				    STRTAB_STE_1_EATS);
+				    STRTAB_STE_1_S1STALLD | STRTAB_STE_1_STRW);
 		used_bits[2] |= cpu_to_le64(STRTAB_STE_2_S2VMID);
 
 		/*
@@ -1067,8 +1066,7 @@ void arm_smmu_get_ste_used(const __le64 *ent, __le64 *used_bits)
 	/* S2 translates */
 	if (cfg & BIT(1)) {
 		used_bits[1] |=
-			cpu_to_le64(STRTAB_STE_1_S2FWB | STRTAB_STE_1_EATS |
-				    STRTAB_STE_1_SHCFG);
+			cpu_to_le64(STRTAB_STE_1_S2FWB | STRTAB_STE_1_SHCFG);
 		used_bits[2] |=
 			cpu_to_le64(STRTAB_STE_2_S2VMID | STRTAB_STE_2_VTCR |
 				    STRTAB_STE_2_S2AA64 | STRTAB_STE_2_S2ENDI |
@@ -1095,6 +1093,15 @@ void arm_smmu_get_ste_ignored(__le64 *ignored_bits)
 	 *  fault records even when MEV == 0.
 	 */
 	ignored_bits[1] |= cpu_to_le64(STRTAB_STE_1_MEV);
+
+	/*
+	 * EATS is used to reject and control the ATS behavior of the device. If
+	 * we are changing it away from 0 then we already trust the device to
+	 * use ATS properly and we have sequenced the device's ATS enable in PCI
+	 * config space to prevent it from issuing ATS while we are changing
+	 * EATS.
+	 */
+	ignored_bits[1] |= cpu_to_le64(STRTAB_STE_1_EATS);
 }
 EXPORT_SYMBOL_IF_KUNIT(arm_smmu_get_ste_ignored);
 
-- 
2.43.0

