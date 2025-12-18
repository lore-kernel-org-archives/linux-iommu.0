Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012030.outbound.protection.outlook.com [52.101.53.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD252EDD40
	for <iommu@lists.linux.dev>; Thu, 18 Dec 2025 21:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766094228; cv=fail; b=RzoJLg6iFaYSVeTZe5EWSLrHXj1cttUhD29wsqSz6o7Wll6NPX7ZKVjOPwHwKtCjVJQc0N9f6X8mG6PnM1x1ITFTqX8Nl4wsGhplaw3BdBAY2NRrw5aZ0P+liCUT8fqMkHBct5NIN8lL7GGqROnrKUoHzl6LGvKb4duxeWMfbkw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766094228; c=relaxed/simple;
	bh=gXwgOZgc4q7jbU0gpr/3RhQGdCsbBeMtx87nvc9lwn0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HGJrG+PFDvinUCAR5eyb3MpoiLGt9pq9D2NRTd04M/aZgAEY8uGsZ+oskj7DOlGm3UXVneD3RxGfxzsMYUVWs/a0BJ83pq9FneSt4fDhVl5+JfvCe5C/jEcquEQYxsqnxAiaojbLExQD9V+UtJRGniwnIRhU782bIVvZymvhkn4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tboKmXh5; arc=fail smtp.client-ip=52.101.53.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tboKmXh5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ABNpAxeeV46i8tiwY5oyG/o3SajOx7U8tdNXimqi0w7R0VYF9GlMjorLQHpQAonY7DW/6ugohIYG9q/qmKt3nsWdYLvDs0wZfXkEH6WIqgSkI+U8d6fhmrZixRxaVaFYX7u01PDemzAQXdvqp0rvGo0ZDhWVFHkduhBvd94NZN1AWLUU7iv0F0mxV7Lh4GhqT/Rfx49apHoM5E36MpVkKR/xrlEdTLufaBZ9dnobzg/+ZnM4XIspeE2/KhJRnQodQTFkQyucPF22k3T08pis1fTfEDO1JHX8hO7uQ2cWNw6EHEvXMz1E6ubR8XqnbnBxYyGbFy2Hg911GWloMIGCKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q1/2gbWY14USf/ZRRGMLw5BTrQhGRXHBzIduyjESg2s=;
 b=c/UWN5TH2xK7W6PhmodPWCHk1W+gyGnJiopOs6rUnipA9fa6hoWeOAaLmzYkLJiZQHdMW+gwLu6YSko7K9duU58LGVthoJHfHJo1FOKEMMaLONAYNdzK4HK3KKITSeCeEQMpeEWc2ihY90Crv9rjriDV+/yef5ZkfG/15yq+IsQ/iOZYwJxnYsXi/I1uT3RhJPXULIIspVEu/xqLMMy3wbykubel3j/F84Htu9aoA9RETVvQ5iomJeE5cF3VXM+3p04tdL0mKrgK9kisE1+/O+5ud2UDAS2Vo5RPIkKB82IqjhIQoBBg/NGdDyvTsuH0UaXKloApnHZ0r10ivZ05ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q1/2gbWY14USf/ZRRGMLw5BTrQhGRXHBzIduyjESg2s=;
 b=tboKmXh59rrQxfOugALvn7YmxxeFMRduYYQXVVLyJnxmyiisetWU/Jzkw4Ha1bQrw1A/9BSTTTGYdSvhAp/z96gPwHk5R9qSWBniWE7yk47DwyBMEhMZHFLqR35y9SIm6cvr1Bzg4At2SrjK4usTvm9NpDTlUrdkoyYqYmhmDnnJGx9pARlbylqY8PB4dLgPql62gP6nW2TuR5XuEzv3vR1crIrk4Ba/PeKYb7uPXN1vGu9Lc+hKSad27K+nG/QHTy/DpryXlSVOC/H9CInS88ga0qaFa1/S9Yq3EvzlOAII9yEm56wcu8RfasutnwCtpLzNalBc5MoXVgN/i+J2uQ==
Received: from BL1PR13CA0246.namprd13.prod.outlook.com (2603:10b6:208:2ba::11)
 by IA4PR12MB9785.namprd12.prod.outlook.com (2603:10b6:208:55b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Thu, 18 Dec
 2025 21:43:42 +0000
Received: from BN2PEPF000055E1.namprd21.prod.outlook.com
 (2603:10b6:208:2ba:cafe::f6) by BL1PR13CA0246.outlook.office365.com
 (2603:10b6:208:2ba::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9456.7 via Frontend Transport; Thu,
 18 Dec 2025 21:43:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN2PEPF000055E1.mail.protection.outlook.com (10.167.245.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9456.0 via Frontend Transport; Thu, 18 Dec 2025 21:43:42 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 18 Dec
 2025 13:43:26 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 18 Dec 2025 13:43:25 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 18 Dec 2025 13:43:25 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>
CC: <jgg@nvidia.com>, <joro@8bytes.org>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <skolothumtho@nvidia.com>,
	<praan@google.com>, <xueshuai@linux.alibaba.com>, <smostafa@google.com>
Subject: [PATCH rc v5 2/4] iommu/arm-smmu-v3: Mark STE MEV safe when computing the update sequence
Date: Thu, 18 Dec 2025 13:41:57 -0800
Message-ID: <83f991cbbb1331213aabe7c1fc5f725e79f60ecd.1766093909.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1766093909.git.nicolinc@nvidia.com>
References: <cover.1766093909.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055E1:EE_|IA4PR12MB9785:EE_
X-MS-Office365-Filtering-Correlation-Id: 5aec7b5d-1e45-42b4-5846-08de3e7e83aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?D9IBsunJ8A4zlYCyZ0vodUIeHauOeZOQ5Jrf6Ygkiez25UDAbK3a02puJAGq?=
 =?us-ascii?Q?nj/MobZ3H51uVMN/maJbUPbQRLbw9ij3CyeEUQQIf04SFRu0VKb++0lUnNme?=
 =?us-ascii?Q?hMhaGd0/EYr9w+7zpN1O0xqP/GQ+RG4Qry4F5My5OYY0wzv8WorhywWHuMkC?=
 =?us-ascii?Q?OH3qnxpc3T2K1T+lhlANGHhywz6RViL7SNbz2JKogjFfcJxrU0TX5DAhkmR0?=
 =?us-ascii?Q?hNRo39QfqALBuJ6qvSCjW0TVM0kyeoluYuzNE24mg7sjJB2aKXsHh5RTds4p?=
 =?us-ascii?Q?Zflv5h29yYGW6H8yCx14GykmjUhYsFlvYgWeHOioqFs2eVaHTlWMnnv0W2ZK?=
 =?us-ascii?Q?vqoxxDa4a8o09P/H3y+byahtWB77sjTL/wwJuT+0PKLX1F98pqu1ptDrRWh2?=
 =?us-ascii?Q?Lbjmu1lfxATyoYHYwhgLeQGifKm1XuFTaYBfTckac2ZuON6JkkCMryvnvr2z?=
 =?us-ascii?Q?u7IchhBbYGedT4cqKOegmVMsVwgyo5wHCToSNeH4LKHAciWtKnPiTYCINLeW?=
 =?us-ascii?Q?qhF6DbSi9geAgBUGOhHAmF+SFq9isupgTLuhhezXd3KGBIvwNsC1pD47/GV5?=
 =?us-ascii?Q?2OzSY45bIAoPoIzSKUT7/Cxj4g5wMcFj6Pw3ZfeNJFVgQiUAp1PewYFvHCF9?=
 =?us-ascii?Q?uL+wgiCVipeuTi+0a2yCCtM15C0X8uc3oI45karGlqwSjyfg422FTDGPpu6l?=
 =?us-ascii?Q?ic8GMQMd8WsYSlY/7S5M3atyo4qM0z1rqg6TdCzSEwQEnjjs0e3Ij6mL8wHm?=
 =?us-ascii?Q?/LFiOccovP8zxKIwrGTAbF9DilnuElZxeQRnYYMkq6pdxekBCIVghld8wB6d?=
 =?us-ascii?Q?qFSMYZ1BftSaMCOx/3GTOK4bKj/pV8RBIFme/NwjZbinuknm1Hxy1feCcYUS?=
 =?us-ascii?Q?YuEmZvBIeWgiUrd6Yd1PtebHR5DA2F5NAzFNThnGPMpvlsTSm5ihmhzdbCtv?=
 =?us-ascii?Q?35ottXt6nWt+yeL79hxFz0+x9ev/j2owj3xuK/6IAe19r9kcQQI1QXppszcx?=
 =?us-ascii?Q?pd7QTkuBREL+bXhPW54aAgEzBinydf10TZahll3lwe8bC2kpv/2kpMHnfWR3?=
 =?us-ascii?Q?UQjqehXyYUKP+C12y8eivdxJ7KC+WOqSE8Pkfj8K+/jXMxdARSGLvNKfS5Wh?=
 =?us-ascii?Q?q5Pmn5saLvU/nkuHmzwfxjA9e0dGqCuOzJukeSHrJYJYGle4D9A0tmOsRHzB?=
 =?us-ascii?Q?8dSyLGDh3C2YyMAZMkOC8LNs+ylcGK52g/RLewhAYhoRvgwz/isuwl2prKst?=
 =?us-ascii?Q?nedPpt79kSyBes61vFVlaKDTnt4M0UzSh/U2XaBKC4Pn4qSuOwObvyeYuDro?=
 =?us-ascii?Q?g374x6OADr9KQkWisKmzzUwSR/Z4vCQpVBqSfrdpDn9THOSAt7wR7ZzAd1WW?=
 =?us-ascii?Q?R2Cv1+hhoh1T5NABYkkJa9Kpgu363KlmBOy8aLx4XveNAOnkzGvcJHh3wc5D?=
 =?us-ascii?Q?HE1dTuuEaajWgygSoy8A8rP3zrRw30bXO/UFu3gBvFm6G/Bivro3yADwqtNg?=
 =?us-ascii?Q?1cL2dsGQ9KadpOP51JPNjbSdE7a0oKVvYGArBFevwCcTNwMrVvfRwNfeMyhC?=
 =?us-ascii?Q?v4sVIn1t9SUmbgItlsM=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2025 21:43:42.7280
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5aec7b5d-1e45-42b4-5846-08de3e7e83aa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055E1.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9785

From: Jason Gunthorpe <jgg@nvidia.com>

Nested CD tables set the MEV bit to try to reduce multi-fault spamming on
the hypervisor. Since MEV is in STE word 1 this causes a breaking update
sequence that is not required and impacts real workloads.

For the purposes of STE updates the value of MEV doesn't matter, if it is
set/cleared early or late it just results in a change to the fault reports
that must be supported by the kernel anyhow. The spec says:

 Note: Software must expect, and be able to deal with, coalesced fault
 records even when MEV == 0.

So mark STE MEV safe when computing the update sequence, to avoid creating
a breaking update.

Fixes: da0c56520e88 ("iommu/arm-smmu-v3: Set MEV bit in nested STE for DoS mitigations")
Cc: stable@vger.kernel.org
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 8dbf4ad5b51e..12a9669bcc83 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1085,6 +1085,16 @@ EXPORT_SYMBOL_IF_KUNIT(arm_smmu_get_ste_used);
 VISIBLE_IF_KUNIT
 void arm_smmu_get_ste_update_safe(__le64 *safe_bits)
 {
+	/*
+	 * MEV does not meaningfully impact the operation of the HW, it only
+	 * changes how many fault events are generated, thus we can relax it
+	 * when computing the ordering. The spec notes the device can act like
+	 * MEV=1 anyhow:
+	 *
+	 *  Note: Software must expect, and be able to deal with, coalesced
+	 *  fault records even when MEV == 0.
+	 */
+	safe_bits[1] |= cpu_to_le64(STRTAB_STE_1_MEV);
 }
 EXPORT_SYMBOL_IF_KUNIT(arm_smmu_get_ste_update_safe);
 
-- 
2.43.0

