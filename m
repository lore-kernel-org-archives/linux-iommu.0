Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013002.outbound.protection.outlook.com [40.107.201.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA1C4DD3B2
	for <iommu@lists.linux.dev>; Mon,  5 Oct 2026 19:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791228716; cv=fail; b=uT14QciQnKLV4fkvWQ1f62NYWuR8rT1ixSSPv+R7FhOxDOivgZMaU2DqpY4v6BzvZ/NVtGhuF+qOK8CJz0WqUPe0BIxLgc0QPtUAN/Mzg4Ns263qW6FfKb5NgN0/8XrX4sMm1RlgGllGdKB5YCT7JbXUkueSPcTEQ/cA8tHIjJE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791228716; c=relaxed/simple;
	bh=knFFpZxaClfCY2y+0gD25HVApjetK+12R6+ayQSmA2Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P8F+IKUZByEXUcrkUvDw9AH+th90O8/Kbd78yHqAzysvu/RPrmmh/mW2OwkyGLY8Gi5rcW2gDEiYY4nUp/vkquPkvoy2xbYMr4z2nBjhlhFi+ICZKiusIv4DLsbWbpc62IkdrEkODPoNCpCMR9Xuru/PSULaeB9eJYzZsTS4KvI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=up2lUdmF; arc=fail smtp.client-ip=40.107.201.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="up2lUdmF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eQNxJV5vj9BT4Qn5Ros4zs3RpMH8LrMO+1YadeGH3WfEZaFzRDsl+FYHHLDgbcn033Dj0GHVkFJudUWJrtvlJBxMQRkDdMFsutPWPHwHFPrCXyh4hak9jLaTcpWqea27DQYLWQz1D7IUaIFePv7wmR1MOjbvpEMQCoKh4blyTrr7YHZYowkvAM7Mnmg2tBKl8qN/URau/JeTzN4Zu1h5TZ84AT33i50UF3BnFxEmNpqRHlDL08cJm/08ToPqaLSuUOXGhpdXuog5jaoiaJazUBAb89+3BDO4l1dWfizgCMlZitlCcH5gBotiE5ej7M/zfeybvEbEvXiNgK2OTbfL/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T90pCDIKLW8pjWeGyN8mdIbJ3ptJ1YJjOmsgwf188Qw=;
 b=vqioX4FZJHiQQ49Iv5ZKX8QTiNtr8cIXqswqraBP+rCpQPVxhExKejDQfZjSSFjfls7CYVUpZRR2F6K5Tq5sj3znxI8rppdNLNTXInbgKrWj9rmx512URgFlRMZxlqehsextqX+7W0iqU6dhbqBl57p2HKN/3FJMzCkhbWJ8hCkT7uUNnTOThrK1o8Ne59UZlDRYOzL0qJyADepyDlLLRgTe27IRw+QJsucF3X/Oaaf2eGrGV89oeLTBeyDpjxYY10KWWdTJOT/sC431OaTgf7jrEj7dJ6gECGmUh0Hg352GBJVSJ6tiG3lqixyKtoEWy4pm/M3B9TwRwSzD1mDtGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T90pCDIKLW8pjWeGyN8mdIbJ3ptJ1YJjOmsgwf188Qw=;
 b=up2lUdmFzhQpA7Q5a1l5/YMWV8TIruVY/UUxR4wmBFHSl591ZvetnCK9syTRsMohjR9LC0RHTtI3J1Wpcx/AjWiTJe2In5JcvNGWKerTe2tT8NMQwqJVDkkslhZth+V9w0TJAikr06IQXxJ9XrmO9LrWzs2QzCJsYI/IGM5hNsMo73FOxrHkCNtl+SdKM1Yi+bCdSMuTFhl3w4zrFfYWOrBcBU/Nec1IFcmeWCL5lloIkKMfmmWpPQxxesQhMQzC8Mh4pq42DxCqiM4w0UtkgpY0N5Pm7zdiz1fxNk5YDkcdPnMAX58MqUtJFCn3xyOiDi60yn8IrG/WbRS/PU9o2w==
Received: from BY5PR04CA0019.namprd04.prod.outlook.com (2603:10b6:a03:1d0::29)
 by SJ2PR12MB8875.namprd12.prod.outlook.com (2603:10b6:a03:543::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Mon, 5 Oct
 2026 19:31:40 +0000
Received: from SJ1PEPF000023CB.namprd02.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::3d) by BY5PR04CA0019.outlook.office365.com
 (2603:10b6:a03:1d0::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Mon, 5
 Oct 2026 19:31:40 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.118.233) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF000023CB.mail.protection.outlook.com (10.167.244.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Mon, 5 Oct 2026 19:31:40 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 5 Oct
 2026 12:31:09 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 12:31:09 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Mon, 5 Oct 2026 12:31:08 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <jgg@nvidia.com>,
	<praan@google.com>, <kevin.tian@intel.com>, <smostafa@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <jamien@nvidia.com>, <kas@kernel.org>,
	Cristian Prundeanu <cpru@amazon.com>, Breno Leitao <leitao@kernel.org>
Subject: [PATCH v11 11/11] iommu/arm-smmu-v3: Detect ARM_SMMU_OPT_KDUMP_ADOPT in probe()
Date: Mon, 5 Oct 2026 12:30:54 -0700
Message-ID: <404c7d33026aa6281cca9020a7aa7e31d214e611.1791226953.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1791226953.git.nicolinc@nvidia.com>
References: <cover.1791226953.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CB:EE_|SJ2PR12MB8875:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bbfcf88-3cab-4f4e-af98-08df231747d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|23010399003|82310400026|36860700016|22082099003|18002099003|56012099006|10067099003|6133799003|11063799006;
X-Microsoft-Antispam-Message-Info:
	kscrs6ODMIUH+OTHR2rDoVm6G7zLjQczm340wcyIwqflLKQ1ESzifteZEXU/G2h+Vv86qunpjpVnY2uN0RZpixnSVbHjA7WE6lEA8k85DkLqYvu2fHFgMM3CUKG5QwGEfzSLdtH+WZo4qTuNDkN+zehQh6AeWiILsZMoxeRScjOco9amkNOejJu7zmRRwmtTD4dUFiDeb64xIUi1CXl7eVeh5m3oDQIUK2kWnLu/5XcxiBxe2K4pQFisVqlDhhk/LB5qsvk9rgqhP5lGZ6+ihk6vLv/9m9kd/om1PtEcajZ8VMJJAigPM0/5c6evaFLFGsI41Ek07PouAYrSnubycnz1sYf65JchKK7HqFh7s852RbdJS6+j7EwfrnVFIwNHcGTeFNlkDlSFallI2y2vxN98bCONrcbF4TAw5Ggohc8ByOFR/qUPralXhfQjvtdOwE3PwibXkj2kAOYlbqt1wjQickfRqFIWxEmV9BbjxfNx/vWq5p1mjacP8PqHDMpzBL/MB4lzLOITDX9SNxJygF2Gz3nXgz1ggeIq14ebrwYRKPYlDpgsdsg8trwZteHTtply2FFU/RxMaHLCaoJJ4VYRcG4u+O8w5/DG1ZSHUZTUUlUsqZdHjr+4anObB6pglflU8U0zaHzVl+AsTqCNy1cY/lJL08WLl6OzbFSpBgQNqIpFPxnOAck4EEaIWhRLl99Ec7FInTLL4ky63FfsMw==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(82310400026)(36860700016)(22082099003)(18002099003)(56012099006)(10067099003)(6133799003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	j4iFyBWzUZzLPFfzamSgNiFJS4bTyshNtJQmaH3ExG13dlBWdqCHeM6MR/i/XwVMRtx0ZJEO1OfmomlV8oFmmpcsU6j0mVSasvfHutrayJ9noXWQQjPUCLnVTsEkBrSl/0o3Bes2svq90rP+YYqC+1kGTXgLQLghUuS4M8NdJ6GOIp9WQFCbzOvyKb8CTZg/EjBDw7SepWpWq1ySNkQ4BrVq0Tnee06FeDDwn/9m5wsvGgz/Lx9A0pGIP/GCcYm8mPLVGK/dq8JNkLmyWnx2+ovBKVh6ZTQ4/9C8xa7wF4g5HbZYCsaHK6s8yvDBXsb7/5/19OLF0RgKAhXRYbjhGc1JTD22Caa6twzZj+pZj0K8/OpUT3q8TzcX0hLmGrK6TznaQcb3aC54SVJsrP3K3XujmsHfq2qIXzgx7mfkpnzFYKRg9HMHP4l3BCW1Fn5b
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 19:31:40.5906
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bbfcf88-3cab-4f4e-af98-08df231747d1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023CB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8875

arm_smmu_device_hw_probe() runs before arm_smmu_init_structures(), so it's
natural to decide whether the kdump kernel must adopt the crashed kernel's
stream table.

Given that memremap is used to adopt the old stream table, set this option
only on a coherent SMMU.

And make sure SMMU isn't in Service Failure Mode.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Tested-by: Breno Leitao <leitao@kernel.org>
Tested-by: Cristian Prundeanu <cpru@amazon.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  5 ++++
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-kexec.c | 27 +++++++++++++++++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  4 +++
 3 files changed, 36 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 49604550e3b9f..228ccdf9c6f5d 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -1335,6 +1335,7 @@ int arm_smmu_kdump_adopt_deferred_l2_strtab(struct arm_smmu_device *smmu,
 					    u32 sid, phys_addr_t base, u32 span,
 					    struct arm_smmu_strtab_l2 **l2table);
 bool arm_smmu_kdump_is_attach_deferred(struct arm_smmu_master *master);
+void arm_smmu_device_kdump_probe(struct arm_smmu_device *smmu);
 #else /* CONFIG_CRASH_DUMP */
 static inline int arm_smmu_kdump_adopt_strtab(struct arm_smmu_device *smmu)
 {
@@ -1354,6 +1355,10 @@ arm_smmu_kdump_is_attach_deferred(struct arm_smmu_master *master)
 {
 	return false;
 }
+
+static inline void arm_smmu_device_kdump_probe(struct arm_smmu_device *smmu)
+{
+}
 #endif /* CONFIG_CRASH_DUMP */
 
 struct arm_vsmmu {
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kexec.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kexec.c
index 8a76b8cb4ef0a..f664de3697e0e 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kexec.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kexec.c
@@ -716,4 +716,31 @@ bool arm_smmu_kdump_is_attach_deferred(struct arm_smmu_master *master)
 
 	return false;
 }
+
+void arm_smmu_device_kdump_probe(struct arm_smmu_device *smmu)
+{
+	u32 gerror, gerrorn, active;
+
+	/* No adoption if SMMU is disabled (i.e., there is no in-flight DMA) */
+	if (!(readl_relaxed(smmu->base + ARM_SMMU_CR0) & CR0_SMMUEN))
+		return;
+
+	/* For now, only support a coherent SMMU that works with MEMREMAP_WB */
+	if (!(smmu->features & ARM_SMMU_FEAT_COHERENCY)) {
+		dev_warn(smmu->dev,
+			 "non-coherent SMMU unsupported; reset to block all DMAs\n");
+		return;
+	}
+
+	gerror = readl_relaxed(smmu->base + ARM_SMMU_GERROR);
+	gerrorn = readl_relaxed(smmu->base + ARM_SMMU_GERRORN);
+	active = gerror ^ gerrorn;
+	if (active & GERROR_SFM_ERR) {
+		dev_warn(smmu->dev,
+			 "SMMU in Service Failure Mode, must reset\n");
+		return;
+	}
+
+	smmu->options |= ARM_SMMU_OPT_KDUMP_ADOPT;
+}
 #endif /* CONFIG_CRASH_DUMP */
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 78a24bca44202..3ada71fe7239f 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -5647,6 +5647,10 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
 
 	dev_info(smmu->dev, "oas %lu-bit (features 0x%08x)\n",
 		 smmu->oas, smmu->features);
+
+	if (is_kdump_kernel())
+		arm_smmu_device_kdump_probe(smmu);
+
 	return 0;
 }
 
-- 
2.43.0

