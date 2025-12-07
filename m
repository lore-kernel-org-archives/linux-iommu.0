Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010047.outbound.protection.outlook.com [52.101.85.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9506F2D739D
	for <iommu@lists.linux.dev>; Sun,  7 Dec 2025 20:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765140603; cv=fail; b=leVTvuE7DowvSRtH6ZXEhpo2N/y6TNSK0jAbxW1Wtgc1g+wC57KLuA6JOrjPGi8ucOixWWWCUbJRC2PEcbjDnrgHt74l7pHm7oFPll2NdvZtBQ9TByZd/wxm2Hlm5WsTItGk3yCZppkhormSxLHcWRQSfbuIQmDUIEbScpEtQIs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765140603; c=relaxed/simple;
	bh=bW6cXnbQwf5fAw/7fdD1ybFDuFKHetdAMKbKzj/jHx4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kxjeu6WuMrSDT5yoaoIk3Marnb1Mdietv3ZpjxXhdc6yB3bsyj5sdgwlrGO7caiJh3fCAyPA8DgW31l7chIaigsCiNmj8ZNlvzzSk00vDYMjuoGVqFwMyapvdBrm6We+94HLyyFXPCFh7sYs3yZXdp/Bz4qZFo0cpgVSTC2roXU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XEVW9DRK; arc=fail smtp.client-ip=52.101.85.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XEVW9DRK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cx3sI8oxrdE2Cj8kdRWTeQ3Es7/pm6A45SchcfonjlsaRAJRFI9ncYzqcZ0hyxvRI9HVcIA6HnbhxEwIYnoYR47aCfhPE04DRG5qXnutsjf0P7FBgbS5wnunw35Z8GcWDrve4RzwogonFRF+p98Ed8z9WlvS01gaj99E6Sp0I3BgYdPQkjEjZ8iQyIn+6dUzJkAODbJLQLZdiJIUeN9qxCn9/SohB3mA9Au6w4T6HF9g/zi/8w7SFloUQqul2Mp+aEyu4GP0yw7dxZ7CvXcgGS3mB4B/7bdcTACzTq5NMxtFn9xX4Xx0ilcWKBzw+/1Af017ljYpcfOsitkHZ4hOTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XQ4F7JbpidHvs2HKJ+GDnaAsGwBVRaHzjg7Cq7p2Sz8=;
 b=dJmEpRUN6BFBXM7zWVc2Q+bxfUupA1m2FaI6aARgnJ6m1S9+oqM4Z3xe4S/SMMMwqkdKLxxJbZdVVfoipBrixEpJP4lXXsRP1k88Oils8dUgSkfX7epZNOtSVj8rWzaLoUPcQsgXUK2C/hn4/pM0gh7eV8yu1NyQHERia1tuwZZELPayvxg1TpsHX1o1ZtUmp/qZeNdz6QdkfPt+mbFPd2nlHY9c367HboFnYHFbFX9QK1sFt1U5Jn9oI/WzcDKYFopQAJOrlxk1JIYaeLutUwyhBEoEy5yB/E1tUhugVQhWmOKbB1usXNzhdaD6BXdAJ+QzDbEKU5bRMKWjnmvJRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XQ4F7JbpidHvs2HKJ+GDnaAsGwBVRaHzjg7Cq7p2Sz8=;
 b=XEVW9DRKlNMu8DUk+/Pz39ZbiTYNVtn4InumhmEFcUlrAV7dr3X7Pxygglj743GbyO9Z9p9YG+7g8dUuao71dSWBiNVtQZyp/gHs4nJV3d57m0srw841KQd5BFL3L3iG7MiGGWDiLImGJwNSiZOTnss9HV+QFZVuAwBV3iYjsDi4JK1Zzfvi/X9LZZfH0GIv/A8vdmYxRpPc4kOb3uxlqWc5srRlbX8Uu/kcFlU3xnRN4mp6/UpGZHYLOZrRqQXf/ZyZm7Yws6Hhq48OrdlRWH0IYxHtkvhh1VrraetGlJyspeMmo7MW3T1kDJk8Ny/D3R+ARRRbTN2bYLLqThKIyg==
Received: from DM6PR12CA0003.namprd12.prod.outlook.com (2603:10b6:5:1c0::16)
 by CY1PR12MB9673.namprd12.prod.outlook.com (2603:10b6:930:104::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.13; Sun, 7 Dec
 2025 20:49:57 +0000
Received: from DS1PEPF00017099.namprd05.prod.outlook.com
 (2603:10b6:5:1c0:cafe::bc) by DM6PR12CA0003.outlook.office365.com
 (2603:10b6:5:1c0::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.14 via Frontend Transport; Sun,
 7 Dec 2025 20:49:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF00017099.mail.protection.outlook.com (10.167.18.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Sun, 7 Dec 2025 20:49:56 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 7 Dec
 2025 12:49:50 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 7 Dec
 2025 12:49:49 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sun, 7 Dec 2025 12:49:48 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <will@kernel.org>, <robin.murphy@arm.com>
CC: <joro@8bytes.org>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<skolothumtho@nvidia.com>, <praan@google.com>, <xueshuai@linux.alibaba.com>
Subject: [PATCH rc v2 4/4] iommu/arm-smmu-v3-test: Add nested s1bypass/s1dssbypass coverage
Date: Sun, 7 Dec 2025 12:49:16 -0800
Message-ID: <b6d87901f89c05dd9e1d0c1e819040d205f569a7.1765140287.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1765140287.git.nicolinc@nvidia.com>
References: <cover.1765140287.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017099:EE_|CY1PR12MB9673:EE_
X-MS-Office365-Filtering-Correlation-Id: d3ed688a-5e52-4ea6-b702-08de35d22e45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nQJeB9vooUX9pa+xCsk11ZlNL8R2U2WUrFpx37rZ5L6Xvz+aih2kaF0nqYYd?=
 =?us-ascii?Q?e+POfrOk2tF0NdMeZRxnpkEqeg1a15kcjNOcyek0ZkbxdBx/vsFcZnN6c7Py?=
 =?us-ascii?Q?wvVjO+0EVHm6zr1xIp9rVC1ampw2nUItKbBC9liyGQ/QlZ0b6/WLB2HcLg3y?=
 =?us-ascii?Q?AQGaPqUS31NcUnoY8gxamsiFb8gEqoZsm5IkzxU/X7AiZU/SOyz4hif4JJsE?=
 =?us-ascii?Q?vh5+qIRJA5iuDarurEe16HyTa017RdnYnij+47SqcTQtTtazOfDLZaR20UIT?=
 =?us-ascii?Q?EOHLWKLy3/yhr/I0xDxpDZ0rjuFc2pI7emIal87hHPMiOGbG+JgqnRBKPi81?=
 =?us-ascii?Q?ZaF4Xk1gcomTQAoyy3muN8Ld1/x9cu+gsw63K65RdYVS/sFsGyvfhFCKCQ6b?=
 =?us-ascii?Q?pvnalvD5/MyQE3h2o+Z/XMAAhBpjqh5ejNZM47a29bd3tOKsmuCyWSO/D/7u?=
 =?us-ascii?Q?Bdmu5Lj3SIWATYLuzajZa00GM8G+IIPq1tpI7nNJc3/CMo4CAeh+t+ENgDNV?=
 =?us-ascii?Q?cGkVEsF/B/WgWrOm0hsdgt9gomn2KVP6WuImCsJnHkxUd+XpuD7Ff71iEg5v?=
 =?us-ascii?Q?4LTMZufDTC6Y6DwIFQ6iV3kPMaZX29zB22aRYDgalk2MuwSuCVxo77oRE6Zo?=
 =?us-ascii?Q?td3EFJ5WFEzosmWJaahulUhsCKeoDimTW5VS6iy4jCowvgllFex+W3dVgTaB?=
 =?us-ascii?Q?MXNikxoIlQKnL/eq5TxmS4+m5Ax5JNdnaF/4VhC+36Tbz53R+baXHFnCmWmU?=
 =?us-ascii?Q?ZL82nxWGxdoFX+xajcRl3cQJ8FtGNJhI/jcyqrrxET4CFHuZJD0knubFYUos?=
 =?us-ascii?Q?KGsVsbrBVz5ziCNCX6ZPiO2AQXLHadGfTPAMFXgrvli+4pmGGE5SVNGAwuQ6?=
 =?us-ascii?Q?6KeP68fW002i32D3EEP6EOB+x3+S1VGGqsREAkQUsbQ+QYdSBp0Gd/6tbQ8K?=
 =?us-ascii?Q?tn+LIiBgsH9Fy9Ts6ANEvAcVuTTI+JdiabCpCPay8CTV+clBJpYsOnuOTua2?=
 =?us-ascii?Q?zyJ9S5TSll49/rWHiiyKKTKPdfLeiiDhw3yUruM3c5M+CXfbaJMsFrcbkgEP?=
 =?us-ascii?Q?PkpobXBQVdRIndYNfs5ACiuwC/L3cS8Zf8xkQWpPhY27BNBGTmima6t+hhiK?=
 =?us-ascii?Q?rS43r/6wgKv6semqnCThurvK7qvwBIZLbGdB+QsaFYLOBDvLwuOqMtU71nKw?=
 =?us-ascii?Q?UgvQwNrN2+6Py10rPQRzaHmPNrObw3BILa9FbepLV6g//iwugszsnNVSWkR4?=
 =?us-ascii?Q?LPckSuIxwx+a8VOCthT+nj3lzSs+ZvJTGafiLSYxZFp0Z503GpHWfW4KPxMp?=
 =?us-ascii?Q?gPxVzB8Oslp92j/FprWzCBjjn8CYTDMjMIWsvwLflItqGOPkroIe4vXq9t3t?=
 =?us-ascii?Q?FvlLz/aqloiBWNbxe1pNJuIoX+Mz2XxWHeI2zbnQ1KtAktvG/GXfUurHPI8I?=
 =?us-ascii?Q?J1YKMrP68ltWs/NUPGHZkGLVEu8ImPyV+z5Ypl3WPvTALuxzqTjfoNxl25eu?=
 =?us-ascii?Q?SArMmBXa9cQOnWFrlA8TiE3+ZNgeid1Qq1QhpdzJhYGx2gLcJjzqcG8+oReF?=
 =?us-ascii?Q?XjoxxbgKGdxzIBiBjW4=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2025 20:49:56.7436
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3ed688a-5e52-4ea6-b702-08de35d22e45
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017099.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9673

STE in a nested case requires both S1 and S2 fields. And this makes the use
case different from the existing one.

Add coverage for previously failed cases shifting between S2-only and S1+S2
STEs.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c  | 61 +++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c
index 3556e65cf9ac..1672e75ebffc 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c
@@ -555,6 +555,65 @@ static void arm_smmu_v3_write_ste_test_s2_to_s1_stall(struct kunit *test)
 						       NUM_EXPECTED_SYNCS(3));
 }
 
+static void arm_smmu_test_make_nested_cdtable_ste(
+	struct arm_smmu_ste *ste, unsigned int s1dss, const dma_addr_t dma_addr,
+	enum arm_smmu_test_master_feat feat)
+{
+	bool stall_enabled = feat & ARM_SMMU_MASTER_TEST_STALL;
+	bool ats_enabled = feat & ARM_SMMU_MASTER_TEST_ATS;
+	struct arm_smmu_ste s1ste;
+
+	struct arm_smmu_master master = {
+		.ats_enabled = ats_enabled,
+		.cd_table.cdtab_dma = dma_addr,
+		.cd_table.s1cdmax = 0xFF,
+		.cd_table.s1fmt = STRTAB_STE_0_S1FMT_64K_L2,
+		.smmu = &smmu,
+		.stall_enabled = stall_enabled,
+	};
+
+	arm_smmu_test_make_s2_ste(ste, ARM_SMMU_MASTER_TEST_ATS);
+	arm_smmu_make_cdtable_ste(&s1ste, &master, ats_enabled, s1dss);
+
+	ste->data[0] = cpu_to_le64(
+		STRTAB_STE_0_V |
+		FIELD_PREP(STRTAB_STE_0_CFG, STRTAB_STE_0_CFG_NESTED));
+	ste->data[0] |= s1ste.data[0] & ~cpu_to_le64(STRTAB_STE_0_CFG);
+	ste->data[1] |= s1ste.data[1];
+	/* Merge events for DoS mitigations on eventq */
+	ste->data[1] |= cpu_to_le64(STRTAB_STE_1_MEV);
+}
+
+static void
+arm_smmu_v3_write_ste_test_nested_s1dssbypass_to_s1bypass(struct kunit *test)
+{
+	struct arm_smmu_ste s1_ste;
+	struct arm_smmu_ste s2_ste;
+
+	arm_smmu_test_make_nested_cdtable_ste(&s1_ste,
+					      STRTAB_STE_1_S1DSS_BYPASS,
+					      fake_cdtab_dma_addr,
+					      ARM_SMMU_MASTER_TEST_ATS);
+	arm_smmu_test_make_s2_ste(&s2_ste, 0);
+	arm_smmu_v3_test_ste_expect_hitless_transition(test, &s1_ste, &s2_ste,
+						       NUM_EXPECTED_SYNCS(3));
+}
+
+static void
+arm_smmu_v3_write_ste_test_nested_s1bypass_to_s1dssbypass(struct kunit *test)
+{
+	struct arm_smmu_ste s1_ste;
+	struct arm_smmu_ste s2_ste;
+
+	arm_smmu_test_make_nested_cdtable_ste(&s1_ste,
+					      STRTAB_STE_1_S1DSS_BYPASS,
+					      fake_cdtab_dma_addr,
+					      ARM_SMMU_MASTER_TEST_ATS);
+	arm_smmu_test_make_s2_ste(&s2_ste, 0);
+	arm_smmu_v3_test_ste_expect_hitless_transition(test, &s2_ste, &s1_ste,
+						       NUM_EXPECTED_SYNCS(2));
+}
+
 static void arm_smmu_v3_write_cd_test_sva_clear(struct kunit *test)
 {
 	struct arm_smmu_cd cd = {};
@@ -601,6 +660,8 @@ static struct kunit_case arm_smmu_v3_test_cases[] = {
 	KUNIT_CASE(arm_smmu_v3_write_cd_test_s1_change_asid),
 	KUNIT_CASE(arm_smmu_v3_write_ste_test_s1_to_s2_stall),
 	KUNIT_CASE(arm_smmu_v3_write_ste_test_s2_to_s1_stall),
+	KUNIT_CASE(arm_smmu_v3_write_ste_test_nested_s1dssbypass_to_s1bypass),
+	KUNIT_CASE(arm_smmu_v3_write_ste_test_nested_s1bypass_to_s1dssbypass),
 	KUNIT_CASE(arm_smmu_v3_write_cd_test_sva_clear),
 	KUNIT_CASE(arm_smmu_v3_write_cd_test_sva_release),
 	{},
-- 
2.43.0

