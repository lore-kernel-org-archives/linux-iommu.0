Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012048.outbound.protection.outlook.com [52.101.53.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D88E2C158A
	for <iommu@lists.linux.dev>; Mon, 27 Jul 2026 13:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785159042; cv=fail; b=V+aMmxS0xeBKH3FwZnaApdsJo0mt6hA7ADEDauU6QZkgQ6JJ8tS6zpj03MCo2iA4/DVnc/GFkkDsWWxDPfCv2K/Iyavn9YRj0A476GIG1zl9A4nJDnnxWKAPb17n4diShKhyUcnKRyd8KfG95wG8H29BClevqIpVhmcuoiywl1s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785159042; c=relaxed/simple;
	bh=nvA8JA2BQv/rwTVZUw7QMKlyOqTowANFparXYhBNgO8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u1MnMwXz1QMDNGt/Bl+2KgmkzR5n6UuzWIbpn9Y6NKYeFEcQmfY34J304ACvDLbZDiJQEvLUEm+3Q3S0AQGTdPk5WqxHL3azQrVMOi0v5wPhwlS70Jpujmka9QM4vpi+mIXZhOq0ldu7UXSQJFgRjqa4kTkZqADyF5Y68XaU9GE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2KRI3dlP; arc=fail smtp.client-ip=52.101.53.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2KRI3dlP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wJUfj+z2RtlQ3v+KpiWnQdQsEmlJsyQWmoq0G0xkkOfu0RGpY01XPoMjHzxarJ5KL3epb9DnZU8rp14s1WchwtNSXj7dgGTl18H66VCXMSxpPKKB+dmz3ikC5s7PPQibbv73T/fa0Zs0meMjNKDi9DsZmplxZuKiJFR3DqP1+HwOxzMRc4Nxp4kDdWGs6qQbUbDMHQ6dg8XyiT+1BMA6DATr/3gxV9xbnX7+Ro0fSahgDlJgOsZt7bpF7bbPYtzi6bFd6Gb0RIlYmuJeM/DBINj9izx2XgXmwlVG1GyOFGfiHQ2MtOqAevp2YScJayUy1meomHL5bAjeIGaZPT+YHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z6381B5MQZmQ7XqNIXqs3RoovthCmZGIFckFvbehIuE=;
 b=oiXm1Jqe60CsKf3izlhc3CVrfd2YRKstkl4O/pc5exv8lub/7Di8TWnqU3ytAP9qmm5AE5PqqUzP4UBdOEtqCxmSzSG33Gu9YLUVmLy/+TMfy8eqk7DkwfBNONGGlDBA6zN8Qzz22NfRNf9VV+PlMXNbEEJ1ZF1Ca/h3SbvDfsSbclCBIZ3JcFVMPR1TfxffWJqpUpGfV2FzKQo/pq0W1RS4RZNNAHM1gHuibVqeTOyzAQrFm1tzhrUWK6DlOI2BQ3wc1XYH3p2crrzv9JUZFRrLmq/vEpLDVluPaKFYnAMfV9Hew7JqaeqIifWjV3+0ookFHiDBisOoMVkNvAw/zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z6381B5MQZmQ7XqNIXqs3RoovthCmZGIFckFvbehIuE=;
 b=2KRI3dlP7ZgG2sRoQ6dpfKsVvFSsDyo6ZuQhQqvFdtDf5q6pc8YT12n61gwRidkOhEu8OFC4Sgsq8KN2MIV0qlG3NRJpvt33yhReOEx7k5x4yI/GEpW31HktX7yX1kVsh9zT6ErBsUzT/VCP2GOaVnnZhpaZKxJm0kjFtBOu5q4=
Received: from PH7P221CA0057.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:33c::20)
 by MN0PR12MB5812.namprd12.prod.outlook.com (2603:10b6:208:378::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 13:30:28 +0000
Received: from SN1PEPF000397AE.namprd05.prod.outlook.com
 (2603:10b6:510:33c:cafe::57) by PH7P221CA0057.outlook.office365.com
 (2603:10b6:510:33c::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.13 via Frontend Transport; Mon,
 27 Jul 2026 13:30:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397AE.mail.protection.outlook.com (10.167.248.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Mon, 27 Jul 2026 13:30:28 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 27 Jul
 2026 08:30:21 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>, <jgg@nvidia.com>
CC: <yi.l.liu@intel.com>, <kevin.tian@intel.com>, <nicolinc@nvidia.com>,
	<vasant.hegde@amd.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
	<Sairaj.K@amd.com>, <jay.chen@amd.com>, <wvw@google.com>, <wnliu@google.com>,
	<dantuluris@google.com>, <chriscli@google.com>, <kpsingh@google.com>,
	<alejandro.j.jimenez@oracle.com>, <joao.m.martins@oracle.com>, "Suravee
 Suthikulpanit" <suravee.suthikulpanit@amd.com>
Subject: [PATCH 04/24] iommu/amd: Introduce IOMMUFD vIOMMU support for AMD
Date: Mon, 27 Jul 2026 13:28:53 +0000
Message-ID: <20260727132913.22475-5-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260727132913.22475-1-suravee.suthikulpanit@amd.com>
References: <20260727132913.22475-1-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AE:EE_|MN0PR12MB5812:EE_
X-MS-Office365-Filtering-Correlation-Id: eb5b0d28-817e-4475-7cee-08deebe33923
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|376014|7416014|1800799024|36860700016|6133799003|18002099003|10067099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	XbYrGZ/yk0RzlqUFJ/+ojxrHWLzsCIogxfBrlC6KaOTX6uiWIyZlUIypIM3BOldJ+GD5CzYEk803dsY274+66bWgS7kQAQgPuIBQuN41+QM7+n0yeD/UZxNbCLivoFl+KXVRf5qIibyRKv3g9e4v9oCosdtYnzZpnIgOlv//a7fbTQ0NKzIioKnemWcWzUGB/Pxu9ztjR2QFR0qZLJTYojaKegdenpvxvEqQYi/hymy2HLK2gU79BN5W5BTR+SJs7jcNwnOha9o1JxmdAUDAPBRswvnsjhvzMzZqV8wPKcmbcwhtuPlB7n6vax7bN1QV9l2QTsPyLF32yge6csrfU+KwjNM+9Rc4ceQ2iDIlx3wvfh53AnzQL8kXyTUi5F3cHDtE8KK6jOhZl13T1pBK9upAwRPeM+6TArGU9v3CxConskwGjYz+6zBGwBzZSzaQIwJuD2GFiWn0qqnYwfwpuG1qlJ79b44Y6qVtz6wJu7HumTHlos+gjghzeC6C0qEQddhON6A7O/u3A9jRPtRlxs8Qx2ozNi52e10P0Tasj4b6MMXCmJEEtMKDl6tNIWfRw29Spcva9cHreaolr6+FxtQPlr8LdwUYNtCsaUaZQC1r9nIQqtMeRrBrpAPW9nJICcmoYAtZvhAvFvndV2sAvPFnyJsuTnG7EbcwkNPBmsNzs3h48BsYl97KFcv/3FPbO9ErgRHY+QHPdEOfZpKj3g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(376014)(7416014)(1800799024)(36860700016)(6133799003)(18002099003)(10067099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	frPHh+9hXP2PcGHA/esNBM/IyFfTDxLZXCX6G3VUKd4+XiVourdAO6WqwWV8ELo22uaaSsNLqC0xEUc5wHCAVENeKYK+ft7v93azwS3makUhFNTxCVdO7PNttWKGgr7NlT6ytQ/3WOUxoierZ0Xr+UjVndU4jqadeKwGs7J3Doo3zeh4+Fs60DmPWjxB8jf2NFGutkZN+66Y98snY1kwtToYfJkxF1RGhQkAKkJNfEiGTHlxkFFLZob0bJj8YfiDL0ExuxXBARMWPk4Idd5mLymuhQcRUbppM7svCsxBqHvQTvTuianqldtHHSfv1TfwVMeU4bQaBVhhDOoNoAeuzasLzrUDyUAxbtItoUq91yOIxRzacbSi0logysRUK+6PHdDJQ0SZoB9U1FPk+73iWeK0C+IVPjKmRxfK661nQTezXp4RdCJxnC8vhn1lBy4i
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 13:30:28.1607
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb5b0d28-817e-4475-7cee-08deebe33923
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397AE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5812

Introduce a new enum iommu_viommu_type (IOMMU_VIOMMU_TYPE_AMD) for AMD
vIOMMU along with the struct iommu_viommu_amd, which is used to initialize
IOMMUFD vIOMMU instance when calling struct iommu_ops.viommu_init().

Also, hook up struct iomufd_viomu_ops.alloc_domain_nested to connect
nested domain allocation with AMD vIOMMU implementation.

Additional initialization will be added in subsequent patches.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/iommufd.c  |  4 ++++
 include/uapi/linux/iommufd.h | 10 ++++++++++
 2 files changed, 14 insertions(+)

diff --git a/drivers/iommu/amd/iommufd.c b/drivers/iommu/amd/iommufd.c
index 52300b867c1f..eee29c26169a 100644
--- a/drivers/iommu/amd/iommufd.c
+++ b/drivers/iommu/amd/iommufd.c
@@ -34,6 +34,9 @@ void *amd_iommufd_hw_info(struct device *dev, u32 *length, enum iommu_hw_info_ty
 
 size_t amd_iommufd_get_viommu_size(struct device *dev, enum iommu_viommu_type viommu_type)
 {
+	if (!amd_iommu_viommu || (viommu_type != IOMMU_VIOMMU_TYPE_AMD))
+		return 0;
+
 	return VIOMMU_STRUCT_SIZE(struct amd_iommu_viommu, core);
 }
 
@@ -73,5 +76,6 @@ static void amd_iommufd_viommu_destroy(struct iommufd_viommu *viommu)
  * struct iommufd_viommu_ops - vIOMMU specific operations
  */
 static const struct iommufd_viommu_ops amd_viommu_ops = {
+	.alloc_domain_nested = amd_iommu_alloc_domain_nested,
 	.destroy = amd_iommufd_viommu_destroy,
 };
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index e998dfbd6960..52bcd92975da 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -1052,6 +1052,7 @@ struct iommu_fault_alloc {
  * @IOMMU_VIOMMU_TYPE_ARM_SMMUV3: ARM SMMUv3 driver specific type
  * @IOMMU_VIOMMU_TYPE_TEGRA241_CMDQV: NVIDIA Tegra241 CMDQV (extension for ARM
  *                                    SMMUv3) enabled ARM SMMUv3 type
+ * @IOMMU_VIOMMU_TYPE_AMD: AMD HW-vIOMMU type
  */
 enum iommu_viommu_type {
 	IOMMU_VIOMMU_TYPE_DEFAULT = 0,
@@ -1062,6 +1063,7 @@ enum iommu_viommu_type {
 	 *   VMM must wire the HYP_OWN bit to 0 in guest VINTF_CONFIG register
 	 */
 	IOMMU_VIOMMU_TYPE_TEGRA241_CMDQV = 2,
+	IOMMU_VIOMMU_TYPE_AMD = 3,
 };
 
 /**
@@ -1080,6 +1082,14 @@ struct iommu_viommu_tegra241_cmdqv {
 	__aligned_u64 out_vintf_mmap_length;
 };
 
+/**
+ * struct iommu_viommu_amd - AMD vIOMMU Interface (IOMMU_VIOMMU_TYPE_AMD)
+ * @out_vfmmio_mmap_offset: (out) mmap offset for vIOMMU VF-MMIO
+ */
+struct iommu_viommu_amd {
+	__aligned_u64 out_vfmmio_mmap_offset;
+};
+
 /**
  * struct iommu_viommu_alloc - ioctl(IOMMU_VIOMMU_ALLOC)
  * @size: sizeof(struct iommu_viommu_alloc)
-- 
2.34.1

