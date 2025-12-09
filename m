Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013054.outbound.protection.outlook.com [40.93.196.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A26530BBA9
	for <iommu@lists.linux.dev>; Tue,  9 Dec 2025 21:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765314321; cv=fail; b=Z733WlOXL1E1R8m1UbhlWFYrm1oExy5R3ItwYtX9FU4Z+elutg9y7T+OsD5Cq8CPoitU1w5k8vnvryyuxx5alN7Mv8XvIfN/EVlCSddqKE6J+e1ELKj58w7v4mOkQB3Z++MUFqcqbvYGEnW8raVGu+K4/xNTuYHsl6YEQLV5xx4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765314321; c=relaxed/simple;
	bh=CzyFwN2I4MctmyaV8dtX/ixEzfk0xKbbPV8Ynj9Zir4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QRjxRMWiJ4Ba9gl8cbQul6YB8hsumyXOh4r4fNWYWSNJr18VoXzOuPfpzJ0aN3vITYmVxZbujIvm0YGjNsOnfroLkcEuqwHfE93gdMvVQIqPVAjucDv6/fi1HvBKG3DZ04QgOxXzHl9CAgpnFvSNoHwm4W7nOMrf3Tv/RFzTGGU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Na332ux2; arc=fail smtp.client-ip=40.93.196.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Na332ux2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n/Y7/RPDdvWd9jxcVKm18oRayxZiydeyQrj5jkATp2u+mpIpxLGnAQM7d9zcaesOAOBuCMQSVTkZ6iBHYUboFs7qLbEFv/5zmuff9KEo5fKyTCNYrMCBkxwboWwg8HpCVfZNjZ6HFRa6++nvK0opq9zOVOPrVVz2+6nGUU+eYcSchefYt4o4852VJb4uaaGxr6iHdgSCJGL/Vtl2TFm+Rslthxas3DMJIDefPD1tShEwza2ljHoltJIiVQvfK6q20Gby+DhSmC2hSQyYBsSZAQB9xmE7PwsJeKcAugBTwUjdI1H470/5pjspGv00D+nPODAq7YwPSZgqdbtBE3PkSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uOhAdbCHNA6go2R2Hf8tRX0cf2WW3G0Fljw7STNK5Hk=;
 b=uY/UqQ5785Wgeod7gcKS8J+hHWk77PJ2gkMfzxXrIsb96iSQMk+PPG6lGDvPC6M+vYY7ofxqoH7ao2KDnZzPXsJx8TGRMoDd5Atf42wcfsJaDCRgLuUGkwzeT9iN6TzwkeDq3mGpgisS8Q7Mr2dpwFeyccx6Wucfo9VrVAiVdpbPSzzlbl2YYE/+ePHSffuUIh4zX2LAha3mOBeuByY4dqm719gsa39xNzqpdfBrXPXaD4qUpg3ybE2WUzLBkd6Paa06Pv6Uau6DRYKtDT1t0McRfdcitaNXSZgkAyDFSuqr72bkbXtIaTXZ6TNRXbqH6jdhDJSNpqCIfb7nIWguhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linux.alibaba.com
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uOhAdbCHNA6go2R2Hf8tRX0cf2WW3G0Fljw7STNK5Hk=;
 b=Na332ux2X6yZhwzbWqinBmHjcZUxLVMYkZ6PzXgATvUg/iqqlsmKjBwS21dC0juzGWCZXuuXrgvy4KUpFIPBENRf1wqvznl0gJRHjKscJ8J/y64SLUiKtD/s5bzizCyYdCl5CfRFQzJXj+xHu/I2mKFRSb3NNae9t7IQbq4NvxSQLYxSsfCPvK9s5/7pvXt5WMKzKgyzUikrCIKu12QtO/ejl1LVEq8pTzPbXGpuz82qbdq3Malde2Fj0foG4PFHOnYTC3oyncpp3jTWl+8rJjLRkqVweZFJfsAiBBib2pCHj7EHbqZLkLgoY8rKer1qc1sVyAXFvuOXDFWhWhUv3Q==
Received: from BN9PR03CA0694.namprd03.prod.outlook.com (2603:10b6:408:ef::9)
 by CY5PR12MB6382.namprd12.prod.outlook.com (2603:10b6:930:3e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Tue, 9 Dec
 2025 21:05:12 +0000
Received: from BL6PEPF0002256E.namprd02.prod.outlook.com
 (2603:10b6:408:ef:cafe::b1) by BN9PR03CA0694.outlook.office365.com
 (2603:10b6:408:ef::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.14 via Frontend Transport; Tue,
 9 Dec 2025 21:04:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0002256E.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Tue, 9 Dec 2025 21:05:11 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 9 Dec
 2025 13:04:48 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 9 Dec
 2025 13:04:47 -0800
Received: from nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 9 Dec 2025 13:04:45 -0800
Date: Tue, 9 Dec 2025 13:04:43 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shuai Xue <xueshuai@linux.alibaba.com>
CC: <jgg@nvidia.com>, <will@kernel.org>, <robin.murphy@arm.com>,
	<joro@8bytes.org>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<skolothumtho@nvidia.com>, <praan@google.com>
Subject: Re: [PATCH rc v2 4/4] iommu/arm-smmu-v3-test: Add nested
 s1bypass/s1dssbypass coverage
Message-ID: <aTiO69YZ9WA8dFe0@nvidia.com>
References: <cover.1765140287.git.nicolinc@nvidia.com>
 <b6d87901f89c05dd9e1d0c1e819040d205f569a7.1765140287.git.nicolinc@nvidia.com>
 <f52c705d-6032-4d85-b902-dd6d0a40b9ec@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f52c705d-6032-4d85-b902-dd6d0a40b9ec@linux.alibaba.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256E:EE_|CY5PR12MB6382:EE_
X-MS-Office365-Filtering-Correlation-Id: 055b3011-f4df-4ecd-f50d-08de3766a471
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TZzv5ehPaMf/I8Cqhc7Ndvr9ljxMWvNcbax1Nsfs1vmnsfWvITiWSYjZbimj?=
 =?us-ascii?Q?kZoYb4L1U3Cr8/QOl0a49Oas9deiW1whHBIw7zPSW5NkNPO+fYLkPLZQjPzo?=
 =?us-ascii?Q?tohsfvK1oVjzm0CG5YMIvvQEn3utXKXcR4SAVg303x+tzPwgtXvNL1/VMWUA?=
 =?us-ascii?Q?E8BLSQZt5kiW2ZF49g1FOPiXorwJfKUAjwm+uPGsnIRzo+z/iocVUCtV+cI7?=
 =?us-ascii?Q?jkq0AHKBmeaKM56w2cmbqqH8QfgD0x/J8NvWz5uyhfXReaMbLxnK5cU/42JH?=
 =?us-ascii?Q?H+WMCm4q5XGT5eSmYh3ulmGpMvTko+oBwEUlfGR1FDr0ZXB22Jz5tVkad+YK?=
 =?us-ascii?Q?DRhm0i+Yni2TRailIwwKi5C3eZZxG9vKFJJLGsjIJ5DRQXvO+s3ZzOVmEUIX?=
 =?us-ascii?Q?7LD08V6izX9aUXdyJMAcJqGgu7l9nb4/FHcEeaTEdfVbD6/F7Y07bUAsMZAk?=
 =?us-ascii?Q?iQiV7khRHW27uNOgQmhiChgmru/pRGBwU+4fI1lBw9/jpFR9VamX0uWuizXr?=
 =?us-ascii?Q?y7PHfQd1g2sZhuBztB/zHOqxrICtdL7jsfpy3k23e2d9Y8iDO+rRx0e2HUpp?=
 =?us-ascii?Q?NZ2MvujXQVEHvEQhgyTIVXZ3zhz7jnjob4Io/TLTMSoDXJvl0TRyiHd7MzrO?=
 =?us-ascii?Q?GfLO8wMgt9jt7q+XNxbPaBuvpfERhZdVjgpVwwSP05LLjllMM+RQnkvUjt0j?=
 =?us-ascii?Q?CTlQcPbJ88uhC242ip5bzsVvd/CN5b+jNfyBwRNf2fvpjPpyAMWr2Vbqfx5S?=
 =?us-ascii?Q?3icjNehM8LZPBki932oDo1a/rVRnjxtDwEbtof8LaDfwWb9Wycch8b9mmLmG?=
 =?us-ascii?Q?VL3ylOQmJL1Vsv4f9pqluHsGorWJwHLdFSWZqpwFKlZgHqYK75FL6hVq5pt3?=
 =?us-ascii?Q?gyUkeXVIh1+HSRjBxQvl/MAfMVb2t7hhfBCzeZTpKI0AEmLuhVbtZa4o9Stm?=
 =?us-ascii?Q?rhnse6+39bMfDBJtmlpQDA9pw4k9KEymypNNhJcHrP+YAWMqky8gE6LBGnUL?=
 =?us-ascii?Q?JT4VmMfKWBZKeD1ZpMJnPB0rgor/mnWKkz7s9rQSqFYfVKsi6eFanDhheAGk?=
 =?us-ascii?Q?Y9O/AsPnJn+nAM6xTIndWWhBOfiO5IzPYAbRKqNF3DufrdfJulGA2NghhW7m?=
 =?us-ascii?Q?O8km/PSrAqdhiaBm3AAFefHS5zX+z5jrRuD0oN0lyNOoec4BXof5U96C76SA?=
 =?us-ascii?Q?SyzcYWCdLiIOkiO9ZdplyIIEzdPskZ15f2LIPT89xYOMA2u8kGGkGbM1bIkf?=
 =?us-ascii?Q?QxpxiDreD1y+3ObACm9i7GkC1PkgKDY4clqDF4GQXlgLXlIrQagDP8GAmJJK?=
 =?us-ascii?Q?C5nGBggKud2pWQdCbZqZCkPNjbjkwykjIfO2zegf/9gCvAJmrkyEs1QGl286?=
 =?us-ascii?Q?uR4dRCqgHFGn931e+8wlTeWNFPCBLNazlwHYkTmDGk0RswC3KjeywBcak2s5?=
 =?us-ascii?Q?0mjvAQo6pYq5LhyKhK8jnm773F269IDdM87AkxiyWJ1CXOrOP/HK0sCCz/9m?=
 =?us-ascii?Q?0jXMlsOvta6e0Y1f0AxlMHBeRPI9D24G3nOSHFJz76Ec7AsKR5JUB0cSIicD?=
 =?us-ascii?Q?tWBOg45CmR6qmV7cnBY=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 21:05:11.6531
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 055b3011-f4df-4ecd-f50d-08de3766a471
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0002256E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6382

On Mon, Dec 08, 2025 at 11:43:41AM +0800, Shuai Xue wrote:
> Hi, Nicolin,
> 
> Nit. Instead of duplicating this code, we can leverage the existing
> arm_smmu_test_make_cdtable_ste() helper here.

Thanks for the review. I squashed the following changes:

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c
index 1672e75ebffc2..197b8b55fe7a2 100644
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
@@ -198,6 +202,17 @@ static void arm_smmu_test_make_cdtable_ste(struct arm_smmu_ste *ste,
 	};
 
 	arm_smmu_make_cdtable_ste(ste, &master, ats_enabled, s1dss);
+	if (feat & ARM_SMMU_MASTER_TEST_NESTED) {
+		struct arm_smmu_ste s2ste;
+		int i;
+
+		arm_smmu_test_make_s2_ste(&s2ste, ARM_SMMU_MASTER_TEST_ATS);
+		ste->data[0] |= cpu_to_le64(
+			FIELD_PREP(STRTAB_STE_0_CFG, STRTAB_STE_0_CFG_NESTED));
+		ste->data[1] |= cpu_to_le64(STRTAB_STE_1_MEV);
+		for (i = 2; i < NUM_ENTRY_QWORDS; i++)
+			ste->data[i] = s2ste.data[i];
+	}
 }
 
 static void arm_smmu_v3_write_ste_test_bypass_to_abort(struct kunit *test)
@@ -555,46 +570,17 @@ static void arm_smmu_v3_write_ste_test_s2_to_s1_stall(struct kunit *test)
 						       NUM_EXPECTED_SYNCS(3));
 }
 
-static void arm_smmu_test_make_nested_cdtable_ste(
-	struct arm_smmu_ste *ste, unsigned int s1dss, const dma_addr_t dma_addr,
-	enum arm_smmu_test_master_feat feat)
-{
-	bool stall_enabled = feat & ARM_SMMU_MASTER_TEST_STALL;
-	bool ats_enabled = feat & ARM_SMMU_MASTER_TEST_ATS;
-	struct arm_smmu_ste s1ste;
-
-	struct arm_smmu_master master = {
-		.ats_enabled = ats_enabled,
-		.cd_table.cdtab_dma = dma_addr,
-		.cd_table.s1cdmax = 0xFF,
-		.cd_table.s1fmt = STRTAB_STE_0_S1FMT_64K_L2,
-		.smmu = &smmu,
-		.stall_enabled = stall_enabled,
-	};
-
-	arm_smmu_test_make_s2_ste(ste, ARM_SMMU_MASTER_TEST_ATS);
-	arm_smmu_make_cdtable_ste(&s1ste, &master, ats_enabled, s1dss);
-
-	ste->data[0] = cpu_to_le64(
-		STRTAB_STE_0_V |
-		FIELD_PREP(STRTAB_STE_0_CFG, STRTAB_STE_0_CFG_NESTED));
-	ste->data[0] |= s1ste.data[0] & ~cpu_to_le64(STRTAB_STE_0_CFG);
-	ste->data[1] |= s1ste.data[1];
-	/* Merge events for DoS mitigations on eventq */
-	ste->data[1] |= cpu_to_le64(STRTAB_STE_1_MEV);
-}
-
 static void
 arm_smmu_v3_write_ste_test_nested_s1dssbypass_to_s1bypass(struct kunit *test)
 {
 	struct arm_smmu_ste s1_ste;
 	struct arm_smmu_ste s2_ste;
 
-	arm_smmu_test_make_nested_cdtable_ste(&s1_ste,
-					      STRTAB_STE_1_S1DSS_BYPASS,
-					      fake_cdtab_dma_addr,
-					      ARM_SMMU_MASTER_TEST_ATS);
+	arm_smmu_test_make_cdtable_ste(
+		&s1_ste, STRTAB_STE_1_S1DSS_BYPASS, fake_cdtab_dma_addr,
+		ARM_SMMU_MASTER_TEST_ATS | ARM_SMMU_MASTER_TEST_NESTED);
 	arm_smmu_test_make_s2_ste(&s2_ste, 0);
+	/* Expect an additional sync to unset ignored bits: EATS and MEV */
 	arm_smmu_v3_test_ste_expect_hitless_transition(test, &s1_ste, &s2_ste,
 						       NUM_EXPECTED_SYNCS(3));
 }
@@ -605,10 +591,9 @@ arm_smmu_v3_write_ste_test_nested_s1bypass_to_s1dssbypass(struct kunit *test)
 	struct arm_smmu_ste s1_ste;
 	struct arm_smmu_ste s2_ste;
 
-	arm_smmu_test_make_nested_cdtable_ste(&s1_ste,
-					      STRTAB_STE_1_S1DSS_BYPASS,
-					      fake_cdtab_dma_addr,
-					      ARM_SMMU_MASTER_TEST_ATS);
+	arm_smmu_test_make_cdtable_ste(
+		&s1_ste, STRTAB_STE_1_S1DSS_BYPASS, fake_cdtab_dma_addr,
+		ARM_SMMU_MASTER_TEST_ATS | ARM_SMMU_MASTER_TEST_NESTED);
 	arm_smmu_test_make_s2_ste(&s2_ste, 0);
 	arm_smmu_v3_test_ste_expect_hitless_transition(test, &s2_ste, &s1_ste,
 						       NUM_EXPECTED_SYNCS(2));
