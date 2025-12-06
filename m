Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013038.outbound.protection.outlook.com [40.93.196.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7BB4EEB3
	for <iommu@lists.linux.dev>; Sat,  6 Dec 2025 00:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764982354; cv=fail; b=q2aq2q06rMVUQRZa11AFlDL5Yb9VDHH1J7PcZLNUrss6kbralgqBjeDLg6gESMkgWEozdvyfRC+8GvxMvU3HUIPeSYmcITcr3K6jL6ty79yIX++xo8S15O4wejbSlwiaXYl6Rez/IL1abRz1rCMUoYHrrhVW00hQZmpYzpJMlB8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764982354; c=relaxed/simple;
	bh=Jm6563T44a6RsRO7LsS9LFZCIkYYHxoaViEBtaoheVY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PNtgqnMHl9+WkK/BS7YJBpihroOink7sTvrLn5JO11AvMnxCa1jmel8iHpzKJ5UKg/3QSFWbA4YTE2SZ8m+4YoYo/BhR1oq8xxiEhYHODxKpzfqxSjITSORVgG3pxSn1aB7IIOF49ml8kWE7heAiKsx3MaCzEo2uwpF6heMzJ3E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=G/0F54tm; arc=fail smtp.client-ip=40.93.196.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="G/0F54tm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FPUk3M2RgtX/QeBi4QLVSREHo4HqPlqMEYtClhMrrKDH0hid3pk20N2AxfbfT3r5v9S5gS8PQZP5GWyfiXGgc+bjyxnbovsCa0DuCzFBOoQWJR4s1ZDAzcKlNR9PQi2eQEwbPB7dHeCbEgomWKs9onkHrOQ5bea2brq4rOGcFZnuq7u90DEnEwb+h9Ee2Mse4WLiiQYfa5z1oIJ+k+VDr1thyED6FRJDciE5vmAizHPGYGMSMNqNL+1YI5ape651fo3hpt9IX7ZoTtIr1J3GlA7VmK7J8/4XekKoWzoth7V6nACK8Kd8qU8HMD/meGCz3AT6bZz4SMaBrqVfIFMSyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PuFi0zh4CYMy66VphO50HyJCXTBW9vRjoigumRyLaJo=;
 b=N3LRrcey8wfiXMuFe0vHXQ/h8zKTedqfOeKk87+iMN1CsDlp2DrTkv4QHt9vvMPWG7kCPvEhcwBB/kMTZlihEBvVLSqfYxluD0csmOs2hS0s5mXKIuLbHekWKYOuf94jb9uxf4Sz4A5czBa0e/y44BzhGKVT0TgcAQYkJ/kaKFYXKemaXAcy7sOR2xa2Z44Cwptd4Hl/s5w0eBtqbVGOaJ4vXwe8DOPE7BVvpAE/pBZM70A1ilxrr7BJcT7NxHMbFESZ7afNLrHxZw0yntLd+yheFsgX4exCQwx4fVfjOAjnNIH3DvyiI5TtBk8cpWebzPN/qjr6gsOGjVQG0ZNJ0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PuFi0zh4CYMy66VphO50HyJCXTBW9vRjoigumRyLaJo=;
 b=G/0F54tmUhuGU2HzSnQpPt/jfhM/qifMyUlu11FeQLJxAH4RfLt2JH3NKSLlw7oeNhRIs1oV2pasgzhZhCB0i3oCLFwuzx4C6oirkwN8K6X/GPa2fE4PHVEtp+IuiVEd34o3cQwy6OgOuM9R5d5Lz/t4ujeNAYyRMVWL2L0LX9c2busBbr6u48pK+tOElOV7nD9rvSl5YiOQ3lcKfLn1mz+C7IpeHwnmtnvZtgSITn5IFWKoMmr/8UfpjPSW0RSxK3KYCffvdkY9yySH3Lc0hntS2vbPaxaq3wOFSqY53FnsOakZhIya4SXYwqjZqG/CO49/qs2ro4NDr9UkHODdSw==
Received: from SA1PR02CA0005.namprd02.prod.outlook.com (2603:10b6:806:2cf::10)
 by PH8PR12MB7278.namprd12.prod.outlook.com (2603:10b6:510:222::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Sat, 6 Dec
 2025 00:52:28 +0000
Received: from SN1PEPF000252A3.namprd05.prod.outlook.com
 (2603:10b6:806:2cf:cafe::d5) by SA1PR02CA0005.outlook.office365.com
 (2603:10b6:806:2cf::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.12 via Frontend Transport; Sat,
 6 Dec 2025 00:52:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SN1PEPF000252A3.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Sat, 6 Dec 2025 00:52:28 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 5 Dec
 2025 16:52:22 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Fri, 5 Dec 2025 16:52:21 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Fri, 5 Dec 2025 16:52:21 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <will@kernel.org>, <robin.murphy@arm.com>
CC: <joro@8bytes.org>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<skolothumtho@nvidia.com>, <praan@google.com>
Subject: [PATCH rc v1 4/4] iommu/arm-smmu-v3-test: Add nested s1bypass coverage
Date: Fri, 5 Dec 2025 16:52:03 -0800
Message-ID: <3c838833d8bbb69a72a85ddbcc325b22ae7a7d6d.1764982046.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A3:EE_|PH8PR12MB7278:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d2519f5-8c07-40ea-497f-08de3461bac7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KclwJL3+iZsMbuQChIbxw0EUNMDsXl5WHBY6LH+u1F0pBpJkY8QfBpZ0mBam?=
 =?us-ascii?Q?XGkm4FyM6Z3d7ngXsKcpe5p2SPz/vjTc75ZRqdy3WTWIL23Fz8IXFWajG9nM?=
 =?us-ascii?Q?1auuCIkhRYOQXVql0F6S9L1V0b2FivRUTeW3KsJypFGv/B1VXacFBKx+iYKy?=
 =?us-ascii?Q?rEct5NgbpNqyIcU+S9ZAvv1GP0RyPBB9dkOWiWcGA/KZ0/IxRiYI+QtNywfE?=
 =?us-ascii?Q?fU3yS3yPIrvmTiXBFFJoyMSvyPlcZEKQjJOj/T+DWUzSF9uFbMbvysLsH0pi?=
 =?us-ascii?Q?xPaX9GPwKTABtAS2VtXSQD0PJw9/4zE1p2jjD17L3BvdMOi+bT90a8YSHvjY?=
 =?us-ascii?Q?C67NH2pUGkEdTTJhC4I8to3GbZjrNYFCVovvxRoQAp4GYDbXeeTKb1xCtWnI?=
 =?us-ascii?Q?IefkBVjjf2OrK1dcDwb+o9nXOP/NZitQUme/MMvtFq1cyyI9MsjQfIv8o3OD?=
 =?us-ascii?Q?51m2Fi7qLDXXuE/DQ2c4NG/vFs9Tf2xMGsgapk+vWpvEdW5KnI+oLVSCoB2I?=
 =?us-ascii?Q?+Wy9KReLBNmiekpv+ciWomQEdVGrKXhyewi4l/dvH/pWLmpl1MbZoOx/f20y?=
 =?us-ascii?Q?lhbFLfRFTeDPAUzMUKITrsMDA0RByulp7nkY7kilgm7cPI05EoASw2I7c/sA?=
 =?us-ascii?Q?uPRSD436c9x/9rZLl35lr5LiX6XCvANNMfAWXHMHCh2he/T8Lc70ubtpHY8L?=
 =?us-ascii?Q?q+905e8KI4AULbUjacxgRGmzeFB9W6it1TkS6R3sgbWxyxx0KCR6Pdqcxe6R?=
 =?us-ascii?Q?CNcY8oSPRWaf011yt8pHrL0Joxvbv2w06fC10Hvp7Irag5qA9GuzbbkLQo0n?=
 =?us-ascii?Q?Z65NKRGB3wRSA3UC2VC8QPiC+kW9YKhaMBhNEPhjbxL8L7oZaxPXkCwQxQ4h?=
 =?us-ascii?Q?xy36nHTsyPOyRAYnNYMYWdxJ6nI216nc4cJvKYgM8/Fv0alFnplxm0Vsblij?=
 =?us-ascii?Q?O8WuFxPF6vgwtnxY+SrER3b2KH7CGDpt2UIueemRP0oZqDqW+wqDg0pSNc9x?=
 =?us-ascii?Q?ikLIci6N/b/n27QvQ2xjZxo7uVpS82dN87x25K7iWQhiSX+wLEyrW0J5gDM6?=
 =?us-ascii?Q?FRNbXDpS5IZBE6WqGjH86rk5YBZ0deX8kLdmVjqDUGEBYA8KF7zQ7hwTq0/r?=
 =?us-ascii?Q?MmoC9aVI+Mo1nYbqwsDDSjv4x3jZw8gakoloUeZFo/BlB7QNxC8DG9p+lHOc?=
 =?us-ascii?Q?cDyeGqhIBmILkX55YvnwRYkeEP4d+0cvWYaX4NKybA+dkjuxfBOgKpqzPnfv?=
 =?us-ascii?Q?sRcEZnG1pf/EJUUDLTXXqLycaIoVFvy8BowQyLFc8NQy9Jyn78zsHB6nQbuv?=
 =?us-ascii?Q?imBN8wuMghE2eIP0QpNHjyDxCe0R6A7dUrC+ZIudDE+bpK55F+eB39JbMWhS?=
 =?us-ascii?Q?PbgvPSGPzrkb3P9aKMrb1oj/j8KjIC024QWYk28hBa1Q8WaTJU9heTG80R/i?=
 =?us-ascii?Q?yTexYtWabL8dc79cl8+E2B+M3v7vzOaPk+T29CHdKYfHhsBQkHb//2DBVSpq?=
 =?us-ascii?Q?R6sJI5l1gQ+RlejJT6ihvpEXurVp3+Ynis20ej8PI++HS84HqqacEQAnQkyq?=
 =?us-ascii?Q?5pTlXXECjTS5700gfSA=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2025 00:52:28.2037
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d2519f5-8c07-40ea-497f-08de3461bac7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7278

STE in a nested case requires both S1 and S2 fields. And this makes the use
case different from the existing one.

Add coverage for previously failed cases shifting between S2-only and S1+S2
STEs.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c  | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c
index 9287904c93a2..56bdcf5a517e 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c
@@ -553,6 +553,36 @@ static void arm_smmu_v3_write_ste_test_s2_to_s1_stall(struct kunit *test)
 						       NUM_EXPECTED_SYNCS(3));
 }
 
+static void
+arm_smmu_v3_write_ste_test_nested_s1dssbypass_to_s1bypass(struct kunit *test)
+{
+	struct arm_smmu_ste s1_ste;
+	struct arm_smmu_ste s2_ste;
+
+	arm_smmu_test_make_s2_ste(&s1_ste, ARM_SMMU_MASTER_TEST_ATS);
+	arm_smmu_test_make_cdtable_ste(&s1_ste, STRTAB_STE_1_S1DSS_SSID0,
+				       fake_cdtab_dma_addr,
+				       ARM_SMMU_MASTER_TEST_ATS);
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
+	arm_smmu_test_make_s2_ste(&s1_ste, ARM_SMMU_MASTER_TEST_ATS);
+	arm_smmu_test_make_cdtable_ste(&s1_ste, STRTAB_STE_1_S1DSS_SSID0,
+				       fake_cdtab_dma_addr,
+				       ARM_SMMU_MASTER_TEST_ATS);
+	arm_smmu_test_make_s2_ste(&s2_ste, 0);
+	arm_smmu_v3_test_ste_expect_hitless_transition(test, &s2_ste, &s1_ste,
+						       NUM_EXPECTED_SYNCS(3));
+}
+
 static void arm_smmu_v3_write_cd_test_sva_clear(struct kunit *test)
 {
 	struct arm_smmu_cd cd = {};
@@ -599,6 +629,8 @@ static struct kunit_case arm_smmu_v3_test_cases[] = {
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

