Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87FD23BF91
	for <iommu@lists.linux.dev>; Wed, 20 Aug 2025 04:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755663974; cv=fail; b=GKFA5Qr41yQaJ4Y/D0q3XWuOTLS8RWufTak0p+juMkDqmArsI9TTk5gsiNmezmY046CFOtK/HFBowTBFBaHDR/JOFIS2ygq44JAUIvfXx+JXDJCJIScrmzzFvpUnmXhZd84+r0RHXn/ahpzKlw+hUhXWuWEma2stnYuhAoCHieg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755663974; c=relaxed/simple;
	bh=eKf+MJJgkxlbSm8vifglsyBjMRSYwyeG+bovmEVjK8E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nOlDnOKsO0l/YsUypunAFJTiC3f1K8wom+L1YbXeTal8dtrwGW/y5EIATx1TDdVXaNIEbUFqbjK6VZSJAmj14f7W4lSpVNVX7ULucSQQxK38PyRPmSlrZRIKDSl8CWVZNNcvFnL/zB9mjXxVe7uT2YEvF9cKR9cgmVDUdfWASr8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hM23TLvi; arc=fail smtp.client-ip=40.107.93.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hM23TLvi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TJ9jWe3jdnO+L0cJOpTMBTuMZTyCqsf4t30hUQuY6KS2tJie5z/hQtri3MhXcEoutuKqvhG80TU332JNs0wieKaasCzd8EsUHeWj+tSYk6BlD+vexS0/fn2WXFlbLbECx9WvdC6XdhVLNcNmPmjFhNFW+7YBKgt08GpZ9VxKPRvgAk6NaEgiPqeGHw36WHVVy/y85L77AoDfK+Gs9UNnUtqQLI5IgHjbfmDzAqVC1BFWKWhPcnNoZJMfCt0AbJsr/q61K2ajOgMDxjs1xTYGO4FZe6vyPa1SVFZ0/xkfseKGAvmodAGpAdaeiI2KjJFfRiIyy67Kn03EPybj4/h+Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eGMF+CurBIFd7jptVV3txTA1mXHe0IsnU900vo659AQ=;
 b=hzEWxIouys/J96Gv2WyMae5FDqztBHAZmThCXblhfleW8l+KsS2vQGsjReJWU7AHmdUFlBbsalSEPAQjwdHPgkHoU5YbsOaXDDNNpgbVFTD5FNidqybtcmm9uvddoLN7KvlRYwV2NZJjn8jGgiPYMRHmgWWJ+iHNTPmkGwg/hhIQwdmSGDy5xoL1+h+/QIA0WC7CBcW883KnuIpyeXr+uRYz6E+eZsicmXNvdoMZx7+956fXtbzI7ZUeznLFdGaiMYbNFduwTHq3yMJWNZZzVL8NQZhwawplo/rh9RFo5F73B1HsGMjxpa7MWFn90haCLo00BXZmnpD6a+eO+ilu5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eGMF+CurBIFd7jptVV3txTA1mXHe0IsnU900vo659AQ=;
 b=hM23TLvi6w1HBrtVCHYnDDR1Gr3CCCQNZB31FL52C5tCov/lUXf+Aq0uItwFAcr9e0kvX27BzVjXmTZjkEYZOBNyb8qB3ADV7LUo7wJwvAB5/Q+x3huuxHjR//9MEm4T8pwfzasGNzo5YpOcBG06QEoXosls6ypH0n0+nHJKS34=
Received: from BN0PR02CA0013.namprd02.prod.outlook.com (2603:10b6:408:e4::18)
 by DS4PR12MB9817.namprd12.prod.outlook.com (2603:10b6:8:2ab::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Wed, 20 Aug
 2025 04:26:07 +0000
Received: from BN3PEPF0000B370.namprd21.prod.outlook.com
 (2603:10b6:408:e4:cafe::b1) by BN0PR02CA0013.outlook.office365.com
 (2603:10b6:408:e4::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.14 via Frontend Transport; Wed,
 20 Aug 2025 04:26:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B370.mail.protection.outlook.com (10.167.243.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.0 via Frontend Transport; Wed, 20 Aug 2025 04:26:07 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 19 Aug
 2025 23:26:02 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <joro@8bytes.org>, <jgg@nvidia.com>,
	<kevin.tian@intel.com>, <vasant.hegde@amd.com>
CC: <iommu@lists.linux.dev>, <santosh.shukla@amd.com>,
	<sairaj.arunkodilkar@amd.com>, <jon.grimm@amd.com>,
	<prashanthpra@google.com>, <wvw@google.com>, <wnliu@google.com>,
	<gptran@google.com>, <kpsingh@google.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>
Subject: [PATCH] iommu/amd: Add support for hw_info for iommu capability query
Date: Wed, 20 Aug 2025 04:25:33 +0000
Message-ID: <20250820042533.5962-1-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B370:EE_|DS4PR12MB9817:EE_
X-MS-Office365-Filtering-Correlation-Id: 58d2be75-3300-42cf-5808-08dddfa1aecb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KHJGCYyG3t7sqMjWd+T/y3/4s4A4BsmKoNb1rXo4v3PMyjog11TMi7C06yNM?=
 =?us-ascii?Q?O3S239233RiNg4jllYON0ZGykpNyvnbtwvid8H0yvG8G11KLrP2dc5zFOO7x?=
 =?us-ascii?Q?j1ntY34AlOgWeVdgtEY+pA/AZ8rHORKqxZsr+XqQX1T5nmg6zdBRoeMMEoOI?=
 =?us-ascii?Q?gxEq7whWAdHN8UqaxAX27UrPdTsLtNoW4JuX0FFHqyZ+4J+G9viKDidTUEco?=
 =?us-ascii?Q?aa3KAWjLOElFYlJs+Yt3cl/WVVuwje18kuhjPlYfp8QtW+BCppkpDfFLU7SZ?=
 =?us-ascii?Q?wsEqHjdLkgt55gvmJuTnAtGL9IJzgTN9eBoIEvGbraKe+3NDSIQYqWr6Npkn?=
 =?us-ascii?Q?RhgVO6bO3V6yncXZaGX5t/T0retnpu2//gyiIju2rGtQYu9TWXhkHQGx+DbQ?=
 =?us-ascii?Q?9vYHasSGbQXmWmR/1wbnhKYydZ24Ki5jc7puW2/8rFxqJxa+wkrUB3xuOTVv?=
 =?us-ascii?Q?IN/HJGYSC6uC/eZulwq+P3E4sR7AYyHVX/QmyjfJjI1Fc0EIlGaSPwJXv42g?=
 =?us-ascii?Q?KyRpxJlIhs5oSng1f0VovzN8SkygzK6NLAew2TPztrdGpyrRqMwT0sdodB7m?=
 =?us-ascii?Q?9ifIgh/Kz+AeJ7z4mxh2//ljFlxhWPTRq9vI30c1KpImqzib9jc/HLgEyN23?=
 =?us-ascii?Q?81aV8zqUA13xr4dJAVUVJ0zlqyJwg6fSLxzXb0M0flNlsAxRw/XiWcgIjbKq?=
 =?us-ascii?Q?TiqSYF0JwDcO1tHh6qLvGmimSC+Awz6ybrGm54BXWSjlZW+KKTIhy9mMKGQL?=
 =?us-ascii?Q?g0YHWE6XDFszu5Ijuvh4+T+QUD8TDJ5iapXgaeD3wf8LgkrvUF6qxWOX7cKU?=
 =?us-ascii?Q?Vve0u9ulhgZ+gU0t66tdpEj/6Ez7xMeeRCnnJXqosIKEWE9X6ev1xYS4pp9J?=
 =?us-ascii?Q?5pQsUYruXmJLLWXLfI85zvPxc2X9GEdyFmo6DYBrTNFsIMD2wK1F+NXGRYRz?=
 =?us-ascii?Q?ibxh2yWTcmLqvg3SnLDXBuMRz/PdCod9Y4Cp8oViQaCtX+CqSCCR7l0cmEtT?=
 =?us-ascii?Q?eCku9pMGg+m/Ad3kRnUCtXWu8UQ9sLJvup+64WKaj+iWwcTQto5p83kQVUCR?=
 =?us-ascii?Q?OBcTHXyDxUtjAC0d3DzCZq6hpFLppjIKwX/Mc1/sJdP6yB6vp8P7s/b05yI1?=
 =?us-ascii?Q?IsWyN/8IAPxby5guLy1fW77MKeuK14IbpmY4JQu0KJWDjcHrVbehdaz818/v?=
 =?us-ascii?Q?zd8ZIRLahvys/6PjJ7FWKLTN8SudU9/z1RVYRNxYKidlugqVcEykHKdtNuii?=
 =?us-ascii?Q?UckAv3024Y8ljnZwktgl9y9E3r1bKaQN/8FsFkfJG8oiGOe6WmtyyasNBaLL?=
 =?us-ascii?Q?dBdVqIll+y2N4DkQ17H8iNhnOLdPAM1W7AWDggEL5wcLYGsIiiXTlrX+LBov?=
 =?us-ascii?Q?P2Q6KZSAcpdffN5HDZM4RA4BezZOrKlblkEqtwz/din9hj038UpRjW4KMh4+?=
 =?us-ascii?Q?S5icpn7lISdw6hj0ivfP7BOvKG1mT8qKquE0boVFu9O1p5rACMru7wwrpAtb?=
 =?us-ascii?Q?bimRL4ca3RMfG2qcG2Oc0Bo82tEa+LCRxZomdbKgNCzhZ3Nff8w3JYyvTw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 04:26:07.1341
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58d2be75-3300-42cf-5808-08dddfa1aecb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B370.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9817

AMD IOMMU Extended Feature (EFR) and Extended Feature 2 (EFR2) registers
specify features supported by each IOMMU hardware instance.
The IOMMU driver checks each feature-specific bits before enabling
each feature at run time.

For IOMMUFD, the hypervisor determines which IOMMU features to support
in the guest, and communicates this information to user-space (e.g. QEMU)
via iommufd IOMMU_DEVICE_GET_HW_INFO ioctl.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  3 +++
 drivers/iommu/amd/iommu.c           | 40 +++++++++++++++++++++++++++++
 include/uapi/linux/iommufd.h        | 19 ++++++++++++++
 3 files changed, 62 insertions(+)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 5219d7ddfdaa..efdd0cbda1df 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -95,9 +95,12 @@
 #define FEATURE_HE		BIT_ULL(8)
 #define FEATURE_PC		BIT_ULL(9)
 #define FEATURE_HATS		GENMASK_ULL(11, 10)
+#define FEATURE_GATS_SHIFT	12
 #define FEATURE_GATS		GENMASK_ULL(13, 12)
+#define FEATURE_GLX_SHIFT	14
 #define FEATURE_GLX		GENMASK_ULL(15, 14)
 #define FEATURE_GAM_VAPIC	BIT_ULL(21)
+#define FEATURE_PASMAX_SHIFT	32
 #define FEATURE_PASMAX		GENMASK_ULL(36, 32)
 #define FEATURE_GIOSUP		BIT_ULL(48)
 #define FEATURE_HASUP		BIT_ULL(49)
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index eb348c63a8d0..ebe1cb9b0807 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3038,8 +3038,48 @@ static const struct iommu_dirty_ops amd_dirty_ops = {
 	.read_and_clear_dirty = amd_iommu_read_and_clear_dirty,
 };
 
+#define AMD_VIOMMU_EFR_GUEST_TRANSLATION_FLAGS \
+	(FEATURE_GT | FEATURE_GA | FEATURE_GIOSUP | \
+	 FEATURE_PPR | FEATURE_EPHSUP)
+
+static void _build_efr_guest_translation(struct amd_iommu *iommu, u64 *efr, u64 *efr2)
+{
+	/*
+	 * Build the EFR against the current hardware capabilities
+	 *
+	 * Also, not all IOMMU features are emulated by KVM.
+	 * Therefore, only advertise what KVM can support
+	 * or virtualzied by the hardware.
+	 */
+	if (!efr)
+		return;
+
+	*efr |= (amd_iommu_efr & AMD_VIOMMU_EFR_GUEST_TRANSLATION_FLAGS);
+	*efr |= (FIELD_GET(FEATURE_GATS, amd_iommu_efr) << FEATURE_GATS_SHIFT);
+	*efr |= (FIELD_GET(FEATURE_GLX, amd_iommu_efr) << FEATURE_GLX_SHIFT);
+	*efr |= (FIELD_GET(FEATURE_PASMAX, amd_iommu_efr) << FEATURE_PASMAX_SHIFT);
+	pr_debug("%s: efr=%#llx\n", __func__, *efr);
+}
+
+static void *amd_iommu_hw_info(struct device *dev, u32 *length, u32 *type)
+{
+	struct iommu_hw_info_amd *hwinfo;
+	struct amd_iommu *iommu = rlookup_amd_iommu(dev);
+
+	hwinfo = kzalloc(sizeof(*hwinfo), GFP_KERNEL);
+	if (!hwinfo)
+		return ERR_PTR(-ENOMEM);
+
+	*length = sizeof(*hwinfo);
+	*type = IOMMU_HW_INFO_TYPE_AMD;
+
+	_build_efr_guest_translation(iommu, &hwinfo->efr, &hwinfo->efr2);
+	return hwinfo;
+}
+
 const struct iommu_ops amd_iommu_ops = {
 	.capable = amd_iommu_capable,
+	.hw_info = amd_iommu_hw_info,
 	.blocked_domain = &blocked_domain,
 	.release_domain = &release_domain,
 	.identity_domain = &identity_domain.domain,
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index c218c89e0e2e..0f7212f9e0ce 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -613,6 +613,24 @@ struct iommu_hw_info_tegra241_cmdqv {
 	__u8 __reserved;
 };
 
+/**
+ * struct iommu_hw_info_amd - AMD IOMMU device info
+ *
+ * @efr : Value of AMD IOMMU Extended Feature Register (EFR)
+ * @efr2: Value of AMD IOMMU Extended Feature 2 Register (EFR2)
+ *
+ * Please See description of these registers in the following sections of
+ * the AMD I/O Virtualization Technology (IOMMU) Specification.
+ * (https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/specifications/48882_IOMMU.pdf)
+ *
+ * - MMIO Offset 0030h IOMMU Extended Feature Register
+ * - MMIO Offset 01A0h IOMMU Extended Feature 2 Register
+ */
+struct iommu_hw_info_amd {
+	__aligned_u64 efr;
+	__aligned_u64 efr2;
+};
+
 /**
  * enum iommu_hw_info_type - IOMMU Hardware Info Types
  * @IOMMU_HW_INFO_TYPE_NONE: Output by the drivers that do not report hardware
@@ -629,6 +647,7 @@ enum iommu_hw_info_type {
 	IOMMU_HW_INFO_TYPE_INTEL_VTD = 1,
 	IOMMU_HW_INFO_TYPE_ARM_SMMUV3 = 2,
 	IOMMU_HW_INFO_TYPE_TEGRA241_CMDQV = 3,
+	IOMMU_HW_INFO_TYPE_AMD = 4,
 };
 
 /**
-- 
2.34.1

