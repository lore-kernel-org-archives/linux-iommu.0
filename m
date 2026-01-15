Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010041.outbound.protection.outlook.com [52.101.193.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1E03C0081
	for <iommu@lists.linux.dev>; Thu, 15 Jan 2026 18:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768501443; cv=fail; b=hPFiFr3x9uH47G4uYoyuFZI0nTkG+5fmM1w3isA9zXHvASlp+J3vIm6MHJwULSpVSYZl6T/0h+fHxVWuqaerWhOrlhrcNDoGWQd53BpYY9wZvlMvYBt6xplmJKa09UObRoVYk9wUH9MunHLYqPEmHwobc01xn0xltgKvRVJxTRg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768501443; c=relaxed/simple;
	bh=8zcJHuum/JEODeumWtKMtdWVymLuX3f8auxAuPa49nM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W/tOgG4m495FoDuYQW9w0evF7K9MU0czCjiHd2lsCkn0xmGEPWJSgQ1wegdEIO8UMZ4MxtQRRvjXdM8CKzqUt9T804T8+Q1uY6GhKP2jvY1U/CEE9VKeSoMXT7ylj4zHJVMEmUm3ZRg9n+62hWBAxeEg7eeGkTaYrUl4YGvsXFA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GGCzdOwG; arc=fail smtp.client-ip=52.101.193.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GGCzdOwG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ra38PtYTzAiOCRH/izjkwb68XsVZo9S68v5Z+3XG49NXTE3yRy0frvq19Mzj9oNUL8Q70zAuG4Px8KZwbCWuSUW1z1fMRodhqtDKfxVYTS6R0EIXEIuGXDLTREo8Sl2RuqNkQXkcWHHQOM+jXdMnehWp+L1viouZ/1SL9EmCK84WCcWpCWO7D0MNJa2Lqmqy3ywNqufYwptBQHc8AS1LUj7Fb1AHJhOVicngda4SInQyKng3wVHxgV5S48h7wu/NVNwrL0lt7mcRAihmw64ZXIVwr2z6To2SSrm509achsVNTEMu4c0y/1MLG9KoFwau4y+3IHQTOqVtfLJOM24Wsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jjfig5FliQUs9ADQ/ZTAenbmONQVMcTNTez6nPlyfpk=;
 b=ncQHE/vXNo/CCqgfG+rTdlBkKBzLZ1np9DaFbHDE5QsiH0bFmNXVNnt1xL2mC4WaYHflJr8WW6BdaUnUAMl93bhxwkQbyobzD7tVzxHiJBp6Nt7J1c0lbQnvJ91bw43xmsfSdK9yfyJu5ITOZ0oXTmEkhnRFsRHtmeWh29w6yEBkfGWIb4tFAcelP0MTcjav4ZpRzDex4xkSmfKGuhzBA2nGQsdexNGbBxDWlIFGFLeyscDR+af/ziVeVsaEHQKx9ATX+VQOkrktHnsLFxyReKEyv5JhmhBUpGotjdewo+QgA01bNKnjRQQi1GCiKJcngsmXGpbKRlxP3aHcFEI0Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jjfig5FliQUs9ADQ/ZTAenbmONQVMcTNTez6nPlyfpk=;
 b=GGCzdOwGnggpIKMPeEWm4zTNktNgewZ3BlLMel25pEO/yw0YXsdQpdViyH3xj0ZK9vqgD4HONzhi4k0unQF9RKS1v9PYGUIeJ13S6o2T7s7a5QA0+ROSn5ClWL3ULaEUX81h5Ic6D3cmrOReEa5BJcRLAcm2qLCShgS+L4Ddt4nnJO42U4uotZHq87WicuGIawwq2WSFrX7H57BNuDXhdikjCXJVEHddXMYyqjO8rM4ISLu0qVTGwxY+hz1i5WiymSBxNvrjWL9vFvLkONQ3zxO4QYBgNRFquWJ+VM2lAf3cwwNmFsaMvXdCnQTObhzsSoGU2sO7MpF7A9n03b8wOw==
Received: from BLAPR03CA0076.namprd03.prod.outlook.com (2603:10b6:208:329::21)
 by MW6PR12MB8664.namprd12.prod.outlook.com (2603:10b6:303:23c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Thu, 15 Jan
 2026 18:23:56 +0000
Received: from BN2PEPF00004FC1.namprd04.prod.outlook.com
 (2603:10b6:208:329:cafe::de) by BLAPR03CA0076.outlook.office365.com
 (2603:10b6:208:329::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.6 via Frontend Transport; Thu,
 15 Jan 2026 18:23:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN2PEPF00004FC1.mail.protection.outlook.com (10.167.243.187) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Thu, 15 Jan 2026 18:23:56 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 15 Jan
 2026 10:23:38 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 15 Jan 2026 10:23:37 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 15 Jan 2026 10:23:37 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>
CC: <jgg@nvidia.com>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <skolothumtho@nvidia.com>,
	<praan@google.com>, <xueshuai@linux.alibaba.com>, <smostafa@google.com>
Subject: [PATCH rc v7 3/4] iommu/arm-smmu-v3: Mark EATS_TRANS safe when computing the update sequence
Date: Thu, 15 Jan 2026 10:23:30 -0800
Message-ID: <d7af5227af69d3e12023e29eb79785e792ce5b5c.1768501336.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1768501336.git.nicolinc@nvidia.com>
References: <cover.1768501336.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FC1:EE_|MW6PR12MB8664:EE_
X-MS-Office365-Filtering-Correlation-Id: c4b5bcda-684a-40d7-3047-08de54633edb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Wsv5Kt8be5vcJX6IBayqyW1FMYNQdkpnTCxgjXJSYXKjQnVmBhyKx/wdtwBG?=
 =?us-ascii?Q?9gNO8ludGp4eEPcqIZF0VFD5sCQ166RxkTaw+oZ1Kp180To86QjDHKwKehAF?=
 =?us-ascii?Q?RHzU5Lb+bHednGapKuOli1k/E0eqZ6brRvdF1Oa2oojsu0prlyJfvppI/oQx?=
 =?us-ascii?Q?QJX0fALPohytouiWnChc+9jH4XvnNmkcA6UMoMhzmPcQyMvC5DBbNVowYrNk?=
 =?us-ascii?Q?lKOb2v3/x/avueugbLNhaY1sLDya48dlKpnpOUk+vAhbuVvuxi3dcfhK9BCE?=
 =?us-ascii?Q?Zr+ii1tLnJqKatNh/kiNXCCYqRyFMckYu65gTYzVeXnVZ8X4HIUDaCDTf2wP?=
 =?us-ascii?Q?TvRlcc10HTrkdbdjWoa4o+KdkV2hgnBpdOLOPBPzxq+OOzoh3jGssBA4i46c?=
 =?us-ascii?Q?tplXMJmSptW1P4LZUy+8tKotGAy3hcoVHOZTbWY/NHlWhcXE7gV6e7TGzdjJ?=
 =?us-ascii?Q?caSiRr4GXtd4N/hog5Uq4a+HQrWdO5ZX+as39KEc1opE2hKIyAOxMAixT2a3?=
 =?us-ascii?Q?jazWEpdTyX4x7epX0PKdLLyqcmpLBtA5eYH9ON7V0S1Sz1OxZGYXl5iGeJ+Q?=
 =?us-ascii?Q?LjchMq3DMFBo34h1Xr1toT+0HtvjfSCkIaxM9x+S2RwcU1Kq6Hhb7MqDf247?=
 =?us-ascii?Q?lYFYqPpVTiLrsYlQw7i0FoOse/S1OawAK3H9fMlFfGLRblV9YkyyqVLWRFec?=
 =?us-ascii?Q?uR8KH5tsY3mKjwFkAMjsCLWsOx/QNZfgwyS8/1J1IiTN/isGZcf+2Tawm6oe?=
 =?us-ascii?Q?V8xU2DYHB96NyoCYR/CiaSs9zWR6hXPJZj1hPTrc3MJY4PB1VbWuPyRIrfWC?=
 =?us-ascii?Q?xZ/RteSQVe/FEoR5wjPBziYjLrHp2roVXhLIHmzK6s9DKptXgo+/xIPuUitF?=
 =?us-ascii?Q?3tUhbns8VOBohgDflUUiSz1cafzmOpbOSFAscTRq02tm4UyZIW8rJP5KzU+z?=
 =?us-ascii?Q?+eJ/SotUwrkse+oDkm/vQnVTWymfaFpnDqA72gfggB7hHUwuT0o3JwW5uUZ+?=
 =?us-ascii?Q?kHLPjHOEE5gW94/QE9CmjDHuH0xAm6ohXmka36Q1f5n6Zpx5SRrA6n36cA4v?=
 =?us-ascii?Q?15cbTTBY8EtK3jxJ+hJ5lIR4WFbE9kRhuooso9rIlZPdK8z0BToSe9940OEi?=
 =?us-ascii?Q?iOJ+26MSizneKqObJ++CJVDPtDoS5lB9PngdjXnKOdY/ng3qaj+jHAvaAS/k?=
 =?us-ascii?Q?vsXFHQOdppstoEKrbBrFIwm78tYlbj45PuGN+PAkaxYmrVZnGx0FnKU8HDHz?=
 =?us-ascii?Q?HrQtoc2cAn9ZORV6ic/O3H9rEzl14M5cldiXHjGIfwbAYMRLEu9ocyAV1EI7?=
 =?us-ascii?Q?de+nl1zr/7vgQ0Ewmq4dMYYwDDwObcNdR8xsyLkq0YhWyiLGKB2haQl/GEH1?=
 =?us-ascii?Q?zF9hRTJ6QCd3akCXwsjMktY2vMjIfmGEwuAUdT0s6ZT1HU4twL27AUeBhKTM?=
 =?us-ascii?Q?ZROHXKav4hucSFtJKXrCu2cd97r0eUFpv2JTuVOERR3pegdvKShlTmLnoJcY?=
 =?us-ascii?Q?1Cq2a1BppCPndJi8voGCtzh6uQX4PNUz4oRl73uSnGWEDGllTPwCbPiW8Qma?=
 =?us-ascii?Q?dfh9TMw8ELDbtawm9fQbGcmHnaxTbAvK7IPd54laow0wswUyvp+YAVrRb2E9?=
 =?us-ascii?Q?8jatXTJYdV5Jj2NpDg1zXshnH1kNch0np4tkHoOSrIelvdGVYZi5ZwTmhoY/?=
 =?us-ascii?Q?RL5bYg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 18:23:56.4508
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4b5bcda-684a-40d7-3047-08de54633edb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FC1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8664

From: Jason Gunthorpe <jgg@nvidia.com>

If VM wants to toggle EATS_TRANS off at the same time as changing the CFG,
hypervisor will see EATS change to 0 and insert a V=0 breaking update into
the STE even though the VM did not ask for that.

In bare metal, EATS_TRANS is ignored by CFG=ABORT/BYPASS, which is why this
does not cause a problem until we have the nested case where CFG is always
a variation of S2 trans that does use EATS_TRANS.

Relax the rules for EATS_TRANS sequencing, we don't need it to be exact as
the enclosing code will always disable ATS at the PCI device when changing
EATS_TRANS. This ensures there are no ATS transactions that can race with
an EATS_TRANS change so we don't need to carefully sequence these bits.

Fixes: 1e8be08d1c91 ("iommu/arm-smmu-v3: Support IOMMU_DOMAIN_NESTED")
Cc: stable@vger.kernel.org
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 26 +++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index ccd6357fa5a8..77a87af5c673 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1086,6 +1086,32 @@ VISIBLE_IF_KUNIT
 void arm_smmu_get_ste_update_safe(const __le64 *cur, const __le64 *target,
 				  __le64 *safe_bits)
 {
+	const __le64 eats_s1chk =
+		FIELD_PREP(STRTAB_STE_1_EATS, STRTAB_STE_1_EATS_S1CHK);
+	const __le64 eats_trans =
+		FIELD_PREP(STRTAB_STE_1_EATS, STRTAB_STE_1_EATS_TRANS);
+
+	/*
+	 * When an STE changes EATS_TRANS, the sequencing code in the attach
+	 * logic already will have the PCI cap for ATS disabled. Thus at this
+	 * moment we can expect that the device will not generate ATS queries
+	 * and so we don't care about the sequencing of EATS. The purpose of
+	 * EATS_TRANS is to protect the system from hostile untrusted devices
+	 * that issue ATS when the PCI config space is disabled. However, if
+	 * EATS_TRANS is being changed, then we must have already trusted the
+	 * device as the EATS_TRANS security block is being disabled.
+	 *
+	 *  Note: now the EATS_TRANS update is moved to the first entry_set().
+	 *  Changing S2S and EATS might transiently result in S2S=1 and EATS=1
+	 *  which is a bad STE (see "5.2 Stream Table Entry"). In such a case,
+	 *  we can't do a hitless update. Also, it should not be added to the
+	 *  safe bits with STRTAB_STE_1_EATS_S1CHK, because EATS=0b11 would be
+	 *  effectively an errant 0b00 configuration.
+	 */
+	if (!((cur[1] | target[1]) & cpu_to_le64(eats_s1chk)) &&
+	    !((cur[2] | target[2]) & cpu_to_le64(STRTAB_STE_2_S2S)))
+		safe_bits[1] |= cpu_to_le64(eats_trans);
+
 	/*
 	 * MEV does not meaningfully impact the operation of the HW, it only
 	 * changes how many fault events are generated, thus we can relax it
-- 
2.43.0

