Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010027.outbound.protection.outlook.com [52.101.85.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B762B4C77BB
	for <iommu@lists.linux.dev>; Wed, 22 Jul 2026 10:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784715663; cv=fail; b=Hr3y0CcbJTutA648byee1z9p/diLpScFYbubyUoqph5KxgfOTu5HPRuntECdLua4/oUChBtuZ72kWT3QJ5XJ751RMEWV4BknthFYNo/oYpHqFcJ50rRsy3ai61afFRLnSovgfVkJzl5f5/RKJQu2G7tFFb4Gl0qqlAmPuViR5hU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784715663; c=relaxed/simple;
	bh=8qPFOBKV1yBvJI7Kz556PeV646Y7jyjqt4CGSTILBSI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P67Yoz4o+3Y0zmk+MjQo/4JWdlL/qb11hnRdF0nNAfeoOUe9DhrdAz/L4n2+wFlSaRd7TYfr01rFQDspWcbFOR28mFM9ur3n+aulgrOgw+P6iBwNlF2rTOaa9gm9211HHDedNYDvXGHi/ErwfmglW53i11U3GqJLJy4XiNJZz3k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SWkzWRlf; arc=fail smtp.client-ip=52.101.85.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SWkzWRlf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PJnCqxmS7/L+0KGteZmkBqrCaLJrCdQV4a57469hxAI6tkSgptcgoIZIHFyv5WxIyfb3KJRSoWEVkBiHCUS1OkZrVbzhIddNNfRCaKIjnCOuA3mcyM47Fy6jAsGkxmU7LoeyRw07bxRynuNMF5pNkIbwHJEXl3GBcxQAKiGxSZBtWMYtdalmS5sytPwQ2wlAbIx2bXhlOvJqRl5PCrLCDeBsCDdxVnO/BFFQQIZZf01FaEu3IrJD7J0H5dJ80nCg7dCwVTpU+B4mtAx5B2q1KwgfML7iQ0p48Sqajl3EC7DiAhgdXADZ91lwxzD3gsURPLDwjwA0SOwvuntpO8bYOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JBcTf+VBPoKFhDIvMOxs9muMQhi7qnuSSPqBFt7Flxk=;
 b=E/ZCaC+x/QxhkwIGlLmX3R+hEX7uoFh0j3kXKlIxAPKk0WPzu7FzJ1nSYj0y7ssIp5su6G5T9K/tm0SvRSPW+eIusKGiw/w6GVMg/J6iP6vatfHStDsubl6vEBVSkZotTzpbgZL+EPsS4oufHAug1PsQ5TGoFjKWszYLSctCQEtm0iUMvYi9ykMtJYubuUkjYuFvd/LVfHqFEHulpsOFksrVQHGiOudfSaiF3HWzGmFwrznOdNVUrjevKtUxYGk8b8uZhvHl8+wjRiDac9lCcgT1JvaZp8XYmCJIcCAbmtoalnE4MCO7QMOJen0QjkvMFVgyTK7LEoxjOK86R/WPbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JBcTf+VBPoKFhDIvMOxs9muMQhi7qnuSSPqBFt7Flxk=;
 b=SWkzWRlfKIKunJOVayrQIB+ngw07OsA3oDhoIcyTyAiHGwIj1IjkTo33qxsTIdbyye2Exjw4DhM4uceq6NIF6YvEL8a6w/xknRklr6nUQM2S4s5zW6YsK4STzeriA6k+iO7C84T5XVCsV6O+2+rXevYkigb750WLoIkFE4NVkJEXpzQB6IpreOPJzjEXZUMSHxj2xcGes132w+F17RbxgdppCCJy3D4UCH1gWf+b9NRX1Eey2rBwmJrN5YQBzExvXq0+RRVW9eRmxyDNKmiI086x0aF7DAInv7yz0Et5NwhaRbi+qmSC9gHskCMKgOPlN+SfqfuYWkXjqsE290xPXA==
Received: from CH2PR03CA0028.namprd03.prod.outlook.com (2603:10b6:610:59::38)
 by LV2PR12MB5728.namprd12.prod.outlook.com (2603:10b6:408:17c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 10:20:52 +0000
Received: from CH1PEPF0000A349.namprd04.prod.outlook.com
 (2603:10b6:610:59:cafe::79) by CH2PR03CA0028.outlook.office365.com
 (2603:10b6:610:59::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.10 via Frontend Transport; Wed,
 22 Jul 2026 10:20:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000A349.mail.protection.outlook.com (10.167.244.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Wed, 22 Jul 2026 10:20:52 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 22 Jul
 2026 03:20:37 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 22 Jul
 2026 03:20:36 -0700
Received: from build-amhetre-focal-20260716.internal (10.127.8.12) by
 mail.nvidia.com (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.20 via
 Frontend Transport; Wed, 22 Jul 2026 03:20:36 -0700
From: Ashish Mhetre <amhetre@nvidia.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <corbet@lwn.net>,
	<skhan@linuxfoundation.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<nicolinc@nvidia.com>, <jgg@ziepe.ca>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-tegra@vger.kernel.org>, Ashish Mhetre <amhetre@nvidia.com>
Subject: [PATCH v8 3/3] iommu/arm-smmu-v3: Enable CFGI/TLBI-repeat workaround on Tegra264
Date: Wed, 22 Jul 2026 10:20:33 +0000
Message-ID: <20260722102033.1122277-4-amhetre@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260722102033.1122277-1-amhetre@nvidia.com>
References: <20260722102033.1122277-1-amhetre@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A349:EE_|LV2PR12MB5728:EE_
X-MS-Office365-Filtering-Correlation-Id: 22d9a404-d8db-4303-1c9e-08dee7dae889
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|1800799024|23010399003|376014|82310400026|56012099006|10067099003|3023799007|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	+t+y+gPWz2UB8q+j0OniVxBILT/KXYHFN+bS2eF3Mb/8nfGju+urrhefCEjxaeEcnSMTKXf9P2gK6locRseSJ2cYAFMiUSNbXd4P7l10++Qo1gTGeyUXhq8ijqzfVbXphqG1xRhe571rq7iGbJ8Q2BrNQngmnxaRHa1TASV7ouzuRHL4UWb/O4jWINxTv02YhHC+8kF23S4lLT4L/FSuF9flm8+WonDYmnWA7Xi1sgLs/VPfdSavIAuKno0W8635YTFEu4pDVyYmc8v84oXCK4u4wLAQmMgjwDkW6dw7Fyy7G0hvlZqMeGlMlKoDZcv1+6ChmRAqEzQPQjG2RMMntwZlMF4/5LGZ9xwoaQnZFjHcP//Hl0AV8wCjGrqwBmz+GQ8F9lluca1cYL/1Z7OoRUvv+X+jmCh/1bblPaBV7bwztbq32NRtzWJYl/8L2cv/j8QOcYhJyFO1Bw2ZzDDPA2JFPRiQ/ja8kKRxTWHok+7tDRQ0i7T2vFHRu0jKucr1CyxLXvPdw2F82kf9BRb1xH48ggcUhO/ko6WNhMl0PZLNnDqr9rMVCkuF68toNByllXRADbq9IB7NepCiqqyLYebeEKCAwP6CxlTmg8xrcliGlB7yRvVoQrW6LVbo7YaCo+fV/fgLre6Eo/PPDN9jSo1ZC3i5F9l7AsENltcsk9T8LHNaqUNQKWaKMTn1OQ0K6GIiYI5I1qi/2hMrbwwryA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(1800799024)(23010399003)(376014)(82310400026)(56012099006)(10067099003)(3023799007)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	uqN4QO6ve5CGewb9dI55W1v3j0Sd0hv1n3md99lHtErs6J46b7df4um4AcPDY5Vn4pLYylulG0CZ/HRNLde/ezqifeutJqPs1F0HfdO9tbuiDXGywLi6fdalH9835NukZLkPqQTwp+yxMLVxWl4RrFpHIptduP5LSuL0Be3RyuL5eYFnQYa2KzOs21J2IwmcfOnEyvbtEGu1KN9cGmZM+8yQ+FfwrUrNFv+QZ+KGUUX7iRcvv0BU98JnTlwVdAT4r+GiK+Y/pnoxLBYmPQEuLzCyQRBfUvaCRZOXcjjd5iK9O67vqo/Q9nL3mVxNwz3qUhrWUUhlhwJw17wi8nlnrFigRb9ir1taWCbbqcJry88dJ0FmRQlMI+x6n+LiJDwy4xTrB6vVktb3Dz/FgIVnNpQeL7FBUe19khC48QeWjQ0pJSPUt5mn/XzJaUG0p5U3
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 10:20:52.1630
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22d9a404-d8db-4303-1c9e-08dee7dae889
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A349.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5728

Nvidia Tegra264 SMMU is affected by an erratum where a TLB entry can
survive an invalidation that races with concurrent traffic targeting
the same entry. The hardware-recommended software workaround is to
issue every CFGI/TLBI command (each followed by CMD_SYNC) twice, and
that infrastructure is already in place behind
arm_smmu_erratum_repeat_tlbi_cfgi_key.

Neither IDR nor IIDR flags this Tegra264-specific bug, so hardware
detection is not possible. Tegra264 is device-tree-only (no ACPI/IORT
support) and already has a dedicated "nvidia,tegra264-smmu" compatible,
so DT-probe is the only viable detection path.

Enable the workaround on instances matching the existing
"nvidia,tegra264-smmu" compatible by calling static_branch_enable() on
arm_smmu_erratum_repeat_tlbi_cfgi_key. Document the erratum in
Documentation/arch/arm64/silicon-errata.rst.

The host repeats only the invalidations it issues itself. On a nesting
setup the guest submits its own invalidations, either directly through
VCMDQ or via the iommufd user-invalidation path, so the guest is the one
that has to apply the workaround there. Report the erratum to user space
through the new IOMMU_HW_INFO_ARM_SMMUV3_ERRATA_REPEAT_TLBI_CFGI hw_info
flag so a VMM can confirm the guest runs a matching "nvidia,tegra264-smmu"
(or otherwise double the commands itself). The host therefore does not
repeat the guest's user-issued invalidations, which would otherwise be
doubled a second time.

Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
---
 Documentation/arch/arm64/silicon-errata.rst         |  2 ++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c |  3 +++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c         | 11 +++++++++--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h         |  1 +
 include/uapi/linux/iommufd.h                        | 12 +++++++++++-
 5 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/Documentation/arch/arm64/silicon-errata.rst b/Documentation/arch/arm64/silicon-errata.rst
index b0c68b64f5ac..744591598dfc 100644
--- a/Documentation/arch/arm64/silicon-errata.rst
+++ b/Documentation/arch/arm64/silicon-errata.rst
@@ -312,6 +312,8 @@ stable kernels.
 |                |                 | T241-MPAM-4,    |                             |
 |                |                 | T241-MPAM-6     |                             |
 +----------------+-----------------+-----------------+-----------------------------+
+| NVIDIA         | T264 SMMU       | T264-SMMU-3     | N/A                         |
++----------------+-----------------+-----------------+-----------------------------+
 +----------------+-----------------+-----------------+-----------------------------+
 | Freescale/NXP  | LS2080A/LS1043A | A-008585        | FSL_ERRATUM_A008585         |
 +----------------+-----------------+-----------------+-----------------------------+
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
index 032d0c272f3f..25982bdbcbd9 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
@@ -33,6 +33,9 @@ void *arm_smmu_hw_info(struct device *dev, u32 *length,
 	info->iidr = readl_relaxed(master->smmu->base + ARM_SMMU_IIDR);
 	info->aidr = readl_relaxed(master->smmu->base + ARM_SMMU_AIDR);
 
+	if (arm_smmu_erratum_repeat_tlbi_cfgi())
+		info->flags |= IOMMU_HW_INFO_ARM_SMMUV3_ERRATA_REPEAT_TLBI_CFGI;
+
 	*length = sizeof(*info);
 	*type = IOMMU_HW_INFO_TYPE_ARM_SMMUV3;
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index f0f8b2daf8d5..67e19c240ea5 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -829,11 +829,16 @@ int __arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
 	return ret;
 }
 
+bool arm_smmu_erratum_repeat_tlbi_cfgi(void)
+{
+	return static_branch_unlikely(&arm_smmu_erratum_repeat_tlbi_cfgi_key);
+}
+
 bool arm_smmu_erratum_cmd_needs_repeating(struct arm_smmu_cmd *cmd)
 {
 	u8 opcode;
 
-	if (!static_branch_unlikely(&arm_smmu_erratum_repeat_tlbi_cfgi_key))
+	if (!arm_smmu_erratum_repeat_tlbi_cfgi())
 		return false;
 
 	opcode = FIELD_GET(CMDQ_0_OP, cmd->data[0]);
@@ -5357,8 +5362,10 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev,
 	if (of_dma_is_coherent(dev->of_node))
 		smmu->features |= ARM_SMMU_FEAT_COHERENCY;
 
-	if (of_device_is_compatible(dev->of_node, "nvidia,tegra264-smmu"))
+	if (of_device_is_compatible(dev->of_node, "nvidia,tegra264-smmu")) {
 		tegra_cmdqv_dt_probe(dev->of_node, smmu);
+		static_branch_enable(&arm_smmu_erratum_repeat_tlbi_cfgi_key);
+	}
 
 	return ret;
 }
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 9508bf50d14c..6465c0357fb5 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -1216,6 +1216,7 @@ int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
 				struct arm_smmu_cmd *cmds, int n,
 				bool sync);
 bool arm_smmu_erratum_cmd_needs_repeating(struct arm_smmu_cmd *cmd);
+bool arm_smmu_erratum_repeat_tlbi_cfgi(void);
 
 #ifdef CONFIG_ARM_SMMU_V3_SVA
 bool arm_smmu_sva_supported(struct arm_smmu_device *smmu);
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index fddaf14cfdd2..be23922b053a 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -602,11 +602,21 @@ struct iommu_hw_info_vtd {
 	__aligned_u64 ecap_reg;
 };
 
+/**
+ * enum iommu_hw_info_arm_smmuv3_flags - Flags for ARM SMMUv3 hw_info
+ * @IOMMU_HW_INFO_ARM_SMMUV3_ERRATA_REPEAT_TLBI_CFGI: If set, user space must
+ *	issue TLBI/CFGI+SYNC commands twice due to a hardware erratum T264-SMMU-3.
+ *	See the description at arm_smmu_erratum_repeat_tlbi_cfgi_key.
+ */
+enum iommu_hw_info_arm_smmuv3_flags {
+	IOMMU_HW_INFO_ARM_SMMUV3_ERRATA_REPEAT_TLBI_CFGI = 1 << 0,
+};
+
 /**
  * struct iommu_hw_info_arm_smmuv3 - ARM SMMUv3 hardware information
  *                                   (IOMMU_HW_INFO_TYPE_ARM_SMMUV3)
  *
- * @flags: Must be set to 0
+ * @flags: Combination of enum iommu_hw_info_arm_smmuv3_flags
  * @__reserved: Must be 0
  * @idr: Implemented features for ARM SMMU Non-secure programming interface
  * @iidr: Information about the implementation and implementer of ARM SMMU,
-- 
2.50.1

