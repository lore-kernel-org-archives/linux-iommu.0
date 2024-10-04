Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11020085.outbound.protection.outlook.com [52.101.85.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0942E83F
	for <iommu@lists.linux.dev>; Fri,  4 Oct 2024 18:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728065072; cv=fail; b=Oc6XQqHQbJouXKmMhrWdkQgQkox+5kvZSV/MN9nq6aaOs/7DsabOkJ9U7+6C7wcWmgCyGdDR8vmAtw5TZQnU2tKIj6lK01GPFa8vMbPQJgfhWW6vuv6PqE4R1k+QGe4sWL2VzU56SbcMZXZstDs8rlvSc45H/MEssykAJXbPWss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728065072; c=relaxed/simple;
	bh=Ty1jsNaL9ID3LEFKl4it+FIu3EOw4XnAq4E/B9LjsN0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=G6hMqjv/og1StDtHiVaPPZy/4EboHDO/lUMRTE/HJNYQhLHCf1yXQiJE9TG1WUYk2ppliwa5GDgeLXQXvKqXXbfySTLLIhVPZy6/rSw5N7sryab+B4ThN9a7JF1xhYNt87IcKY/kxgbGf8Jb5nSJW3AWaanVggTvxUkIH+qwLQ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=B2EP5wWR; arc=fail smtp.client-ip=52.101.85.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="B2EP5wWR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NfACxX1T2Pp8A7fy1j0QuEF/Jh7wWl3SnJI5BgT6FDpfG7NigUujEwmpqn4p3YaX6MOzINawyo2hItl4zQPEoE5otnWlSY8Qazok8ankw9QwdvOd/qm2OMpksTTTW7b+hUV/DHu+l/G0Vu2ZVddBk+DxA+pKazaIQB6C/P2sYEe0l87J5eDct79OZjVjVkpHQX9bfNbksTwWbEVk2b0FItx7q0hjWSFog5w4i4SWdYQM8RTI06SFISm7oDQryAZ82msXKMRjZ94XnwxtCfD4ITVMdmFjakSWndHfJyWoEAPiprQFglsNeNR9zC5JbVRjiuOfonmTZhJS1HzexG9/og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M8FcsShTOMu1idkRdNuc6WIZxCi0YKk18XsCEvMNSdM=;
 b=PGqGUN45xrCDmU0ujw3qPkC/MOHB0Uh6UqrUI7acC3wVv3aE0fD7HFlkPzMjzw4Wl+FvoGpGrWEnxbVTlXV5FnpiuP8Z3yjxo0FkCimzQQVuZNxk0XfdRHsKzHuFLWZn8RS3PU3DKAclPByE/6IFC1EeLTTYEb2UAHyYA++HIc75B/8dR9gGFP8W3Pz6cLnacEIKlLGqwS6gE/aizoSJ/R8WMMuR51ACeHtkxAJJN47/PBNRB2h2uxaZuCPZh192B+hUrANAO3d9CSPmkzDAY6Euqiyfe/H+uPvSGc+p+PgY8u57RCr4HyO2Mymx8s/YcASEUj0GCBeeeZZCid1mZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M8FcsShTOMu1idkRdNuc6WIZxCi0YKk18XsCEvMNSdM=;
 b=B2EP5wWRqNXJiuLBrxFk+WgB+03BFk6yOQGCKMnKWY5SikSG8TwsUASpi+sOllNmEZ39BXXH0churjjWXhgA26vGVEX+KjuvyddwKvRHPJ/C+gewNUo/hk5QSh51i0e4RmpWUDAJWK8Khd09WPKQPFGOv3yu/PPDwQbkZYlaFmY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 SA1PR01MB8396.prod.exchangelabs.com (2603:10b6:806:389::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7982.34; Fri, 4 Oct 2024 18:04:20 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%5]) with mapi id 15.20.7982.022; Fri, 4 Oct 2024
 18:04:20 +0000
From: Yang Shi <yang@os.amperecomputing.com>
To: jgg@ziepe.ca,
	nicolinc@nvidia.com,
	james.morse@arm.com,
	will@kernel.org,
	robin.murphy@arm.com
Cc: yang@os.amperecomputing.com,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [v3 PATCH] iommu/arm-smmu-v3: Fix L1 stream table index calculation for 32-bit sid size
Date: Fri,  4 Oct 2024 11:04:05 -0700
Message-ID: <20241004180405.555194-1-yang@os.amperecomputing.com>
X-Mailer: git-send-email 2.41.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR04CA0027.namprd04.prod.outlook.com
 (2603:10b6:610:52::37) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|SA1PR01MB8396:EE_
X-MS-Office365-Filtering-Correlation-Id: f50692ad-bd43-4725-3df3-08dce49ef820
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?A1Lm0Jd+hQWmHNCUGZ1Ft8ibkwn3EhJSTMN1uOEtg4Ivv00LH4yIpuGwWcn4?=
 =?us-ascii?Q?/X54rCul1gC/MmwldY8MtieMe4TOPm4k+t45c75s7Yn0HkUghs7rVGRftlcI?=
 =?us-ascii?Q?TkMNSk3aaWSXz0H/7Qsa5hEfTM0U48XU6KmRpBx0KsyetLDlVJHAv2QmLHlD?=
 =?us-ascii?Q?R2YhL9PcuH+aoi4jUxrHoWK/pSUGdySHTdF1ka3NfkFmj/XYch1qEUR1G8xX?=
 =?us-ascii?Q?/VawBDPR5pTY182AnBZYkqeyLIcBXEBcJdnO+0nktNklMRpO3+hwO0Nps/7z?=
 =?us-ascii?Q?lUdKyKB2UEtZvZrF0dMZUiIRm811lXn5Fk79waPnH2ShH+7g06wWjagJ5feE?=
 =?us-ascii?Q?b4C+xFUZEFW3QrOT8Nc08ZOjeHSgQMkZp624OyyFW7lssEbqg7T4yow0qpLq?=
 =?us-ascii?Q?rSy6xtYQUc5fc3JeT6ZrSrwccLDMPJfr7uq4PrhHIT6OJZPlJsea5R7S8yIr?=
 =?us-ascii?Q?5XzOLpzXVGAIIxO2kLEjSYNACttbSU0mPjmsQlCT8AaM02h70Xxn1AtD2zUu?=
 =?us-ascii?Q?zt6RFPOefQuGws2lhXVnxvQ8bs2l94vTZx9wXUl3/7WvxhN6nRqef32sUi19?=
 =?us-ascii?Q?o4Xvs/66Mh6n6wzyBz6NzCfM213W3v1uTQM1xkuyB6SR0CYebQRjOk4T5HOg?=
 =?us-ascii?Q?TGAs9Kp4c6kAfhDmBcFFic4prYUKNy2HnpXgzCRAhDq8R/U0LSogJGVYptIX?=
 =?us-ascii?Q?8KEtgMoHDzGDtxFnGN1NMH7ZQmhLhzAZMWfnirHjWaZEenWAxstyJCGWM87m?=
 =?us-ascii?Q?LDSkWqQtW2iPZVKoDzUsXT4hV2Km7jIH0XoKXjsvfW3S5X63H37L6YGKi29F?=
 =?us-ascii?Q?f/PFrtU91jeuo+kgYM9FXQusmoM+NaNMRwwgBk4EJwg0U02c95K8o5alRiNL?=
 =?us-ascii?Q?TNUoyXvdbDRTRSLeAvhqQ011Yti6tX35cuh4jIwiSywwI1koZuKqiLxMN5dS?=
 =?us-ascii?Q?oSaurIFCYkPo43PRDZ3KUgsadOxd6MOY62DSqFQPYRlUFRTZGk8O1uvbX/L7?=
 =?us-ascii?Q?dizFBbKpDUffhciHh70H7855ziTvgjXwYhG9WEBEBDJelm89XFwmqJNWTVjQ?=
 =?us-ascii?Q?udJtGS83wDkbNBoazCkdWJ+9Hnu5Ih6ipS7xanIS9l2UD8GAcuHQNrCUbLVF?=
 =?us-ascii?Q?yji1K464ZOZcL7OZx5Unm6gbiAzdDjsLMUjlylQrddHIBIIY6HYB/kYXXi1P?=
 =?us-ascii?Q?hlGcz7YOX9lNATeBB8kyMf7/vL1eHs/OKEMxgReibY91CKLZ5bn0vqJMnB6S?=
 =?us-ascii?Q?hmbtD0F6kO7GxrblfQ1mG7OdbEe+9A3eJFCbBMscBFimfwGZNgJLHa+Tnex/?=
 =?us-ascii?Q?DWJcBSLUZXnklmjGKP9nJog7R2W2rV/+8DHkf43k2eyAJA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KIS5tsRWQWYZ+rX1axjmzYmh21Y4QvJ2PCqjJZVKsP/s8griZoczbiVwS5UZ?=
 =?us-ascii?Q?UzdK6Hi0rSok04n1RKDRra1WrwCj2Qnb/gz5mHofqqgldx3g/0PIKDIMvr3F?=
 =?us-ascii?Q?bEqBlEWTK1iqzB4F9agm5QRGVch0e11TI8Ft3zD6NZBvwv6UgSRc8g//cBdU?=
 =?us-ascii?Q?duYZ8A9k3cP8ZcefUBct2SFIZ2/2oDhyc1LG7E7wV+6SbqD5vjiruhPbEyLw?=
 =?us-ascii?Q?9ZMPLzBT4DGxZAO0pdI8Fe236mkKdoLfZ9Ad//X2n+yKcMXeq5W6pZEOi7Br?=
 =?us-ascii?Q?Vm+vbkoJUx/+9N0FzhZHkRYt3v5cSo2dTT8qZaCq9e9AFH/YIpgI2aAPmrkp?=
 =?us-ascii?Q?b+3CJbYNrzpWarjK8FTYe2QiXasXD36mzykdBqx74GKI8CL/O+JTYwOKqQKw?=
 =?us-ascii?Q?WrNmbW/ZcZncJv5KMc/5P4d24YXYQB1LByJBf9i+e6zW6FTvw86UT9VpT8gR?=
 =?us-ascii?Q?Bq1RBblo3elbWiH1eJ56iIDZE6+VEQ316mkRdStypq1eb6i5kzYyjUUOAPmQ?=
 =?us-ascii?Q?um1Q3NmScIX7D8EmzhyZay4qWAQsa911QC/n0AlxyIN8eoQrzbf5xSK2NMzE?=
 =?us-ascii?Q?YaETBIgmYvpezhWggNMc04C00aV0nFBt3kv8UZYhMbAwM08GudENJrGHKBRv?=
 =?us-ascii?Q?NWv38OUqa8RdKmLt04DTQpJVKRsy4YCS8rG5ERHFX/qEMdDrrnKC4ziGPzkc?=
 =?us-ascii?Q?fqibQXJ+p78SzyQuulRg99s0pRRLpb0DEX1tDUDssHHx58HnL87Ht4eFht0H?=
 =?us-ascii?Q?8zlxQYL5QszzwUQ0lMJlsw3oVdUx5eWa66FCNnoc0FCtOBXqLdAi/gcHmVi7?=
 =?us-ascii?Q?i1+mmb5VWhqP0Qnu/E6QJ1N+8SoRb1I9W5C5HQuWvyKxmKhfPS8P8aJW7MKq?=
 =?us-ascii?Q?wduxbfoHD+sQcnfxdXMvsSRPMMCQJNp5qV6oakv/2QyNCZCi9x9LAgqejLDt?=
 =?us-ascii?Q?SZ+JmskiGaKTKFiyUOEFiFP5Meo28gPuHuoZ4HQm9M1fypbv+FOSLbWbNU1p?=
 =?us-ascii?Q?hpZVFNv9vkwfsYe2vNOVhM9ieRlcQKgdpS4Xn/j+/jQafskFuWuwDxGowV2A?=
 =?us-ascii?Q?deB+VOY47cbw1R+gxjo5+OsWheSRTqCDn2VexnPnvxvUP9zebTOxyV0n0w37?=
 =?us-ascii?Q?EY5vePK8ymMSH+1ibQY+yVeb+UY7t/ABUTk7g548LLWUPQx2MDbExi1MWTHS?=
 =?us-ascii?Q?9rb5j3JqgKUK/UpB5kAzh3Tyv0+KeL+AA+zF79rTdHu1dF3tv7yGbs7R6/7v?=
 =?us-ascii?Q?7mtxvWUxkap4imdAFXP9dBUTcrTcT1WY6K4hlvsu6J/sZej4N/1c+XXtR4xG?=
 =?us-ascii?Q?rCOQc7TmwSY80ZsZ4JOdP6FXL4RvOdnXWwayQ7lMJdxlu9SHn/4ze+cUXT/f?=
 =?us-ascii?Q?uNJFuiFQu01YWqE+80vVjzi3vifxtWVeBg4npK/tNgWKoGsnFYp47T1g7b3M?=
 =?us-ascii?Q?QYwStmi4g62ViYZ6ra2Bcu7RmPKcklW5qLxoe3vcce3vrIoSNBXTLnXVzFqf?=
 =?us-ascii?Q?Y1gYEHhUv4J0kEC28ysqPapHTMbTSo5VU5Ga+RLWuHNPAXa/s/txyMFNcliu?=
 =?us-ascii?Q?CWdGOJZOVwQ4YD1sRGdvV0xuISX7sbW8qLQrh94bobxsySdgnvjLOU5szcNo?=
 =?us-ascii?Q?5uDgpstPMTjDBcPujaJkhBw=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f50692ad-bd43-4725-3df3-08dce49ef820
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 18:04:20.0709
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t3OUcUC2kptNudHe2M8IPCIIvHsYNRdiVz1eFTh6k7EJsRkEmp2Gwn4DcjBM3cCcBr6YqhRofoeCl5H4Qnj4J5HBQQVCu4r2Vm+AIXMGmlY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR01MB8396

The commit ce410410f1a7 ("iommu/arm-smmu-v3: Add arm_smmu_strtab_l1/2_idx()")
calculated the last index of L1 stream table by 1 << smmu->sid_bits. 1
is 32 bit value.
However some platforms, for example, AmpereOne and the platforms with
ARM MMU-700, have 32-bit stream id size.  This resulted in ouf-of-bound shift.
The disassembly of shift is:

    ldr     w2, [x19, 828]  //, smmu_7(D)->sid_bits
    mov     w20, 1
    lsl     w20, w20, w2

According to ARM spec, if the registers are 32 bit, the instruction actually
does:
    dest = src << (shift % 32)

So it actually shifted by zero bit.

The out-of-bound shift is also undefined behavior according to C
language standard.

This caused v6.12-rc1 failed to boot on such platforms.

UBSAN also reported:

UBSAN: shift-out-of-bounds in drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:3628:29
shift exponent 32 is too large for 32-bit type 'int'

Using 64 bit immediate when doing shift can solve the problem.  The
disassembly after the fix looks like:
    ldr     w20, [x19, 828] //, smmu_7(D)->sid_bits
    mov     x0, 1
    lsl     x0, x0, x20

There are a couple of problematic places, extracted the shift into a helper.

Fixes: ce410410f1a7 ("iommu/arm-smmu-v3: Add arm_smmu_strtab_l1/2_idx()")
Tested-by: James Morse <james.morse@arm.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 16 +++++++++++-----
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  5 +++++
 2 files changed, 16 insertions(+), 5 deletions(-)

v3: * Some trivial modification to the commit log per Robin Murphy.
    * Used "num_sids" instead of "max_sids" per Robin Murphy.
    * Returned u64 type for arm_smmu_strtab_num_sids() per Nicolin Chen.
    * Checked size in arm_smmu_init_strtab_linear() in order to avoid
      overflow per Jason Gunthorpe.
    * Collected r-b tag from Jason Gunthorpe.
v2: * Extracted the shift into a helper per Jason Gunthorpe.
    * Covered more places per Nicolin Chen and Jason Gunthorpe.
    * Used 1ULL instead of 1UL to guarantee 64 bit per Robin Murphy.
    * Made the subject more general since this is not AmpereOne specific
      problem per the report from James Morse.
    * Collected t-b tag from James Morse.
    * Added Fixes tag in commit log.

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 737c5b882355..9d4fc91d9258 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3624,8 +3624,9 @@ static int arm_smmu_init_strtab_2lvl(struct arm_smmu_device *smmu)
 {
 	u32 l1size;
 	struct arm_smmu_strtab_cfg *cfg = &smmu->strtab_cfg;
+	u64 num_sids = arm_smmu_strtab_num_sids(smmu);
 	unsigned int last_sid_idx =
-		arm_smmu_strtab_l1_idx((1 << smmu->sid_bits) - 1);
+		arm_smmu_strtab_l1_idx(num_sids - 1);
 
 	/* Calculate the L1 size, capped to the SIDSIZE. */
 	cfg->l2.num_l1_ents = min(last_sid_idx + 1, STRTAB_MAX_L1_ENTRIES);
@@ -3655,20 +3656,25 @@ static int arm_smmu_init_strtab_2lvl(struct arm_smmu_device *smmu)
 
 static int arm_smmu_init_strtab_linear(struct arm_smmu_device *smmu)
 {
-	u32 size;
+	u64 size;
 	struct arm_smmu_strtab_cfg *cfg = &smmu->strtab_cfg;
+	u64 num_sids = arm_smmu_strtab_num_sids(smmu);
+
+	size = num_sids * sizeof(struct arm_smmu_ste);
+	/* The max size for dmam_alloc_coherent() is 32-bit */
+	if (size > SIZE_MAX)
+		return -EINVAL;
 
-	size = (1 << smmu->sid_bits) * sizeof(struct arm_smmu_ste);
 	cfg->linear.table = dmam_alloc_coherent(smmu->dev, size,
 						&cfg->linear.ste_dma,
 						GFP_KERNEL);
 	if (!cfg->linear.table) {
 		dev_err(smmu->dev,
-			"failed to allocate linear stream table (%u bytes)\n",
+			"failed to allocate linear stream table (%llu bytes)\n",
 			size);
 		return -ENOMEM;
 	}
-	cfg->linear.num_ents = 1 << smmu->sid_bits;
+	cfg->linear.num_ents = num_sids;
 
 	arm_smmu_init_initial_stes(cfg->linear.table, cfg->linear.num_ents);
 	return 0;
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 1e9952ca989f..c8ceddc5e8ef 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -853,6 +853,11 @@ struct arm_smmu_master_domain {
 	ioasid_t ssid;
 };
 
+static inline u64 arm_smmu_strtab_num_sids(struct arm_smmu_device *smmu)
+{
+	return (1ULL << smmu->sid_bits);
+}
+
 static inline struct arm_smmu_domain *to_smmu_domain(struct iommu_domain *dom)
 {
 	return container_of(dom, struct arm_smmu_domain, domain);
-- 
2.41.0

