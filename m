Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013066.outbound.protection.outlook.com [40.93.196.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D421329C7A
	for <iommu@lists.linux.dev>; Thu, 18 Dec 2025 21:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766094239; cv=fail; b=ZYDxqxxorbrxUDcV0Y2xMSeJYqyLdhjky9F2hCjzq1a7OjS4h6LAxhtgUlGZbC3LhGxhDCIzj14pwfKldm78LSjGOqatkpTAXsDZ7MOiWHr6dCtvzZnfoc/47+TcfTs7lQ8KjZdRi0c51fAtBLRmGqo2xpndxXSuJqINLRrIqCo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766094239; c=relaxed/simple;
	bh=rYytAPYg+EG0uQF1bVOMRAdX0CCpIAEZ521dDE4GJq8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f/+vx/+Yd62hx8NEh9ewOFuMjJjbba/6YDKAkOOtsINI+e0pmLFlBxr9c5JhA0QfAQ0HSs1Opr0hctcEyoUp1IHtbdgN6RjXKibgkOKsUtZLTZB+kZifhfe45DyF/kZyGxMB6oORffUIOzXo5Mj9F0E19H+9YGnZKFEr0Ca7bvo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Lp1fw2Rb; arc=fail smtp.client-ip=40.93.196.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Lp1fw2Rb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xpi7Hu5o4cvtqAQEwllxTa+dRTp19mOSG8nOv4SMOtL10xaYZHATyD8Q747H+3oPRnSk7iU/KDgD/jytgXupcGOnuGCKJ2MAj6d3OOigW9NB1cFXTEZaHgHqshEeLHJG5s7jV/7F3lMqWYJlBnYX3hjRr9+mbK++WiinAs1LU0FYrECkE3jmv8xGmMZH5HPlaey84oajGhZvsw8MgAkhQmrFa/UHx+1aqRRd1GjXB0H9qvvO4k20IAXksFG2SEBtWxr6rIxiNXY6/W3Tnv3y8coC3ibzYsLjAab9TEBL+6zQXU8kEfK0xaztF88+NazyVXZzNME49MbtHAZM27wndw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wuawAurZ//CBr4pV9CO0gO9eRSo0O+45XoC7AwDeZG8=;
 b=n5J8JVDFsbF9PMVFdcOGu8397C8fciWqaII00VociDz8TCLmDjRvBFRAPXtVG2GPbHUa3hLIsXZ5B8/tLHRstHjAwEnh05EiuUSLQW0sA8eJbI0iJf+wID4V4leCuaU//Tn3f7rWUuXZt2b865rxIlYLFYLtDnJP/UnbkrAxSSFn7xZfWonjGOogxCQ6AZLzHdlngyPFPGNda9jz0qip916KXHj0wKz1aSwvsKzH+xVdJP7iO7ynS9HUhle3FLSxQXMR9rE3Vva00CGFRuR1Xqh5maIC9GOracgWezbhHIpSmHOK9sKvPJ7n2riGk5WtYPDeeWQxqtecRX2/Jv8Deg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wuawAurZ//CBr4pV9CO0gO9eRSo0O+45XoC7AwDeZG8=;
 b=Lp1fw2Rb80F6kALnaaDgaiF2VBTvImHdXNNkQCTCkuwMnzofsj/gFKX1RepXqt0J7pi+GtAA5+8yhtyGVEbG5aL02nnb+PbBIqjk5uH0vo1bE45zqXhn8RdmK5Q2EIkWql/zVJr26CWjLIJzQLaJk/Z6owFq+361q7wOLs4sb4agxBQ7853XfCEGJu3IHXch4iOfcdp8SN8j2w9f3EUY4+O3NA7Qv1esNKqtquQZG8UuJoVL05E6UN/5ffQdT99z/ldIxRsfBIeUX1CDbMVsBnunlGXLpXiOrb5EGGhGnvQ813oShnoXby+7tIhU5yJhJHcX495uouBsNJ91/qKRNA==
Received: from BL1PR13CA0246.namprd13.prod.outlook.com (2603:10b6:208:2ba::11)
 by IA0PPF4D923B935.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bcd) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Thu, 18 Dec
 2025 21:43:45 +0000
Received: from BN2PEPF000055E1.namprd21.prod.outlook.com
 (2603:10b6:208:2ba:cafe::52) by BL1PR13CA0246.outlook.office365.com
 (2603:10b6:208:2ba::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9456.7 via Frontend Transport; Thu,
 18 Dec 2025 21:43:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN2PEPF000055E1.mail.protection.outlook.com (10.167.245.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9456.0 via Frontend Transport; Thu, 18 Dec 2025 21:43:45 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 18 Dec
 2025 13:43:27 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 18 Dec 2025 13:43:27 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 18 Dec 2025 13:43:26 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>
CC: <jgg@nvidia.com>, <joro@8bytes.org>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <skolothumtho@nvidia.com>,
	<praan@google.com>, <xueshuai@linux.alibaba.com>, <smostafa@google.com>
Subject: [PATCH rc v5 4/4] iommu/arm-smmu-v3-test: Add nested s1bypass/s1dssbypass coverage
Date: Thu, 18 Dec 2025 13:41:59 -0800
Message-ID: <68d48a88a64223a1d9b76b59c05f4743f1953c9c.1766093909.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055E1:EE_|IA0PPF4D923B935:EE_
X-MS-Office365-Filtering-Correlation-Id: ad92a22a-102a-4143-0cac-08de3e7e850a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3+zXfDJEBcrnxFEe8OCqycazJ5j+Yc0FtKXZ0WJWz9U6fWz1YoDzqJXzqn+P?=
 =?us-ascii?Q?4ET75NCu6YTUVXd4eGixcOWwcsWQ43YhGW+5vNAPVhVDtuTjlfCT9UHbwK8m?=
 =?us-ascii?Q?ICnPmBKnRTihGNogGSO0LwLMpwdOh9mGxwplwoqPkOq3ECc62jhNA+xuEWcw?=
 =?us-ascii?Q?WVkRTBizsyKf+vWCt4aG9TfBlZ+hHTsqCAEzyDXObF1qTBxofWvdcVr4ScXJ?=
 =?us-ascii?Q?BN2yQFriERqqh89v8xImryOb0Jy7eaJ1EFSNZOIPI4DWxJoJtJ79WSuKsDx4?=
 =?us-ascii?Q?BozF3nxBEYvi/wzeqQ7SaEST9pBr/8pmj2V2D5v8ggpxtH42nFpYPGjV93gb?=
 =?us-ascii?Q?wo0UFhYeYWf3YTAcf/L2Vzt0+0tKe2tjOptyNNjNRrX8LNUI0+8TVLUt7ZTW?=
 =?us-ascii?Q?TqH9MFLnudYxaFM4kJ1L87TMPVJO8AN8mCzVeZKZvBYW0baxPZ23B5c+VjC4?=
 =?us-ascii?Q?eVuL5UWMH4Qxh9Fi6JzRcGRqbtuep7HY7iR8iUS52GJM84EUCZODWdxqdm2H?=
 =?us-ascii?Q?dm8q8E+Bt/1Q7XshqUG1D+1ARrz7gLWgMIe8BINrvnikRlLWm76RZcMdLEDl?=
 =?us-ascii?Q?fmTZwOw1T/GDqUVWlMCAtB7CsR6KGsxvOQdCVscPeag5kpcThEgE9BB65mAV?=
 =?us-ascii?Q?9ZK3DM0OpLblenAIg5UxgwKMc2uXfyUWkWeHtoyaEOSw3xDY9DaIVmUC/L3c?=
 =?us-ascii?Q?WQfVHnf3lQAAms/LUa6iIrXLtot9wSYbnispLXd8PQUKCbEgk8bUv9MRb1yY?=
 =?us-ascii?Q?2hFSESRY4YdQToyqqFruP7aYwPa9oWVVWNjbe1wYyO+17vSgkjJjSI655RW9?=
 =?us-ascii?Q?w1npi5WBzKYrxYRypK5FlhKph4pIm8nA3ivSmO2RUtI5418X6iLWOSZlj02E?=
 =?us-ascii?Q?7ej15ClS6666NBFmP5Yvwf7pbs2Bexfw92OKRg4fhWNPtpwPV77MJn10TwXC?=
 =?us-ascii?Q?lA6JE18CvI2fq4VZRojYHvRErokVab/59M7ynm8fL0xCSC4Jz5ZcvN0de6UL?=
 =?us-ascii?Q?RveUdM/HSwRlFs1j5a/0IHlyf6u1d2d3CnlZ9Bzg3ITqD16tbK51Od2um4Ay?=
 =?us-ascii?Q?3Sjr3FrS8WWU4t/FneHXEF0RqDOI+TvQxyLIFt3GAFBUG6hakFnzKr265loI?=
 =?us-ascii?Q?AZ7kX6mBSKx6gV67Msp5HfufPLuYx5iPVn5g0beg7mtihgIaWbx6P7UxNVlp?=
 =?us-ascii?Q?dCacQj5oeo6omh7KYzxAdQcGFLAyq6ZeXMBa62l6fZCzuMLu3hmcwtVsv84W?=
 =?us-ascii?Q?t6dXnpqzRp9aXnQD/9MizlGXyO741jeM//ggqIw+GoNx6hiIzs1Fh03NOYHf?=
 =?us-ascii?Q?nBY4QRn1gfm6XCHKLTN4DqOwUOAazDvuG2LpRyWA5OCvEMv9tgIOUrHvJcn6?=
 =?us-ascii?Q?oHZ0e5hCDFRgChfFAcRXr+xtmApW4HxS5Jo3sXuvWLDiicFhuvgKJ4jOD/3i?=
 =?us-ascii?Q?VF0Ef829joLyJ51BQezLV27mrwsNXvK7cudN/FqW437rTY7yfsiJ0D6WnV6G?=
 =?us-ascii?Q?k0T6eWyobms0i3TDOrKkb1sLrOjRWZuZiqXQuiKcJQDh/CtdGulqQ88z9r4E?=
 =?us-ascii?Q?7bdVJ2NGPgLYTRL14eE=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2025 21:43:45.0286
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad92a22a-102a-4143-0cac-08de3e7e850a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055E1.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF4D923B935

STE in a nested case requires both S1 and S2 fields. And this makes the use
case different from the existing one.

Add coverage for previously failed cases shifting between S2-only and S1+S2
STEs.

Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c  | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c
index 5db14718fdd6..4a072c2c367c 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c
@@ -33,8 +33,12 @@ static struct mm_struct sva_mm = {
 enum arm_smmu_test_master_feat {
 	ARM_SMMU_MASTER_TEST_ATS = BIT(0),
 	ARM_SMMU_MASTER_TEST_STALL = BIT(1),
+	ARM_SMMU_MASTER_TEST_NESTED = BIT(2),
 };
 
+static void arm_smmu_test_make_s2_ste(struct arm_smmu_ste *ste,
+				      enum arm_smmu_test_master_feat feat);
+
 static bool arm_smmu_entry_differs_in_used_bits(const __le64 *entry,
 						const __le64 *used_bits,
 						const __le64 *target,
@@ -197,6 +201,18 @@ static void arm_smmu_test_make_cdtable_ste(struct arm_smmu_ste *ste,
 	};
 
 	arm_smmu_make_cdtable_ste(ste, &master, ats_enabled, s1dss);
+	if (feat & ARM_SMMU_MASTER_TEST_NESTED) {
+		struct arm_smmu_ste s2ste;
+		int i;
+
+		arm_smmu_test_make_s2_ste(&s2ste,
+					  feat & ~ARM_SMMU_MASTER_TEST_NESTED);
+		ste->data[0] |= cpu_to_le64(
+			FIELD_PREP(STRTAB_STE_0_CFG, STRTAB_STE_0_CFG_NESTED));
+		ste->data[1] |= cpu_to_le64(STRTAB_STE_1_MEV);
+		for (i = 2; i < NUM_ENTRY_QWORDS; i++)
+			ste->data[i] = s2ste.data[i];
+	}
 }
 
 static void arm_smmu_v3_write_ste_test_bypass_to_abort(struct kunit *test)
@@ -554,6 +570,35 @@ static void arm_smmu_v3_write_ste_test_s2_to_s1_stall(struct kunit *test)
 						       NUM_EXPECTED_SYNCS(3));
 }
 
+static void
+arm_smmu_v3_write_ste_test_nested_s1dssbypass_to_s1bypass(struct kunit *test)
+{
+	struct arm_smmu_ste s1_ste;
+	struct arm_smmu_ste s2_ste;
+
+	arm_smmu_test_make_cdtable_ste(
+		&s1_ste, STRTAB_STE_1_S1DSS_BYPASS, fake_cdtab_dma_addr,
+		ARM_SMMU_MASTER_TEST_ATS | ARM_SMMU_MASTER_TEST_NESTED);
+	arm_smmu_test_make_s2_ste(&s2_ste, 0);
+	/* Expect an additional sync to unset ignored bits: EATS and MEV */
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
+	arm_smmu_test_make_cdtable_ste(
+		&s1_ste, STRTAB_STE_1_S1DSS_BYPASS, fake_cdtab_dma_addr,
+		ARM_SMMU_MASTER_TEST_ATS | ARM_SMMU_MASTER_TEST_NESTED);
+	arm_smmu_test_make_s2_ste(&s2_ste, 0);
+	arm_smmu_v3_test_ste_expect_hitless_transition(test, &s2_ste, &s1_ste,
+						       NUM_EXPECTED_SYNCS(2));
+}
+
 static void arm_smmu_v3_write_cd_test_sva_clear(struct kunit *test)
 {
 	struct arm_smmu_cd cd = {};
@@ -600,6 +645,8 @@ static struct kunit_case arm_smmu_v3_test_cases[] = {
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

