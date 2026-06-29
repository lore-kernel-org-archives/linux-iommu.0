Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012058.outbound.protection.outlook.com [52.101.48.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B86943C04D
	for <iommu@lists.linux.dev>; Mon, 29 Jun 2026 15:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782747717; cv=fail; b=QFltq+yFksLaVe/FxxYpdZUFMcLbvrOJ9SS/NdD0EfeTvBxCzUoKsFERLaovCrS0+pSkrOj2eBBy5fF6HCzfa3D4k2mD36TQ9NE2YXyWj+kMLXdkwPgPeHrRH82IuAJENeKGn0yOEtCwiYahq/XfKPr5hAZrzL+EzgvuOxNByzE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782747717; c=relaxed/simple;
	bh=nvA8JA2BQv/rwTVZUw7QMKlyOqTowANFparXYhBNgO8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MZ8anklUZo60lcqrCF9y9grZtg7TeJv1UM0lsxYn0KRR72gy4gGspTNbrDpJR15Muv1RlaOmABnmAXPpgY2LFTSFXF14jDj1GhhTeyyjIsBf3ZnIs6EyxkB3hnQvbDzrQNCrbJBlmhJZZqBT+xQ9PmopZzkr4HI5lhA+o+V3DT8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Dqoe+Vhw; arc=fail smtp.client-ip=52.101.48.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Dqoe+Vhw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W1LULdOwKNXqx7BXPlXTn3PnOCPYtRpL3uTE17g4ZTZEeF/dq5ybLpyqODPQXb7QfdSDav/HAZhoYVhStoJ49eusnSvnlEej93pskYbiANvKvwTyhEq4ahtblRPpLGjS3nwO3aA9V5L+dHL+AV7FPY6F6fADDQR99IfHSBPi4EkB9ZG92Y3O+yv/ADWYhQctdhvfW3vG/rwbn+TlWvtl197lqCGHp/mlD7d0Y3E2oDTFVnIGKSOWpQtDPg3TvD2BdSeBJeXfG7JsFoQeDtkoN/HkpqmSPq05sIj+40N4q2kjm1f3yDEsuvBAPYIOPcZaIZFegWUa4c0/+ozd8e2/Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z6381B5MQZmQ7XqNIXqs3RoovthCmZGIFckFvbehIuE=;
 b=B69rxu7kf9K5uNUar5BfpBi1CzXteM1MXFEWzZYKHNmCyo6ZLXF0kQGMvssoWTpIdOAELyjlx8bJcs963sz+B2n9HXkOx2ea8yTNb1/LNhy+T3wJrYBPJWjqiCdG5/tptLTnysVmfAA1vBxdzixzRGIv47I6KGXJMljQ3BlTn57AHkWG4cnKWbCIQ2bd0pbAcvPaYP8O9UWPfAluoPPR2MbB7M9/4AuAMvkO11m7ZugmhnVaIVIgMzDa9uF6gbwB/KNWJrL+avuYOnf9hD375SlEUvYIPemQJwjazQqMsZlnzE7tUuvUWKP2wwr+0dPrHSh1rYPZt2yGRQ+cFupL1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z6381B5MQZmQ7XqNIXqs3RoovthCmZGIFckFvbehIuE=;
 b=Dqoe+Vhwh/3mRZv1m5kj3Urwf2tfM1sgW/GYWoQfxrHoVij4ywhZ2FW9b9bp93C2JzOMffEGrOQ3UOsu3MpWP9bK7W7wxFAO26iVA1qpqOH2G7tjTaJMmQ75sKWA31FWrGMTMzP3vfe+cgusDKN6kZrVjMZAydGJqRiZLuyZknc=
Received: from BYAPR21CA0029.namprd21.prod.outlook.com (2603:10b6:a03:114::39)
 by IA0PR12MB8840.namprd12.prod.outlook.com (2603:10b6:208:490::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.18; Mon, 29 Jun
 2026 15:41:48 +0000
Received: from SJ1PEPF000026C6.namprd04.prod.outlook.com
 (2603:10b6:a03:114:cafe::61) by BYAPR21CA0029.outlook.office365.com
 (2603:10b6:a03:114::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.1 via Frontend Transport; Mon, 29
 Jun 2026 15:41:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026C6.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 29 Jun 2026 15:41:48 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 29 Jun
 2026 10:41:33 -0500
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 29 Jun
 2026 08:36:11 -0700
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>, <jgg@nvidia.com>
CC: <yi.l.liu@intel.com>, <kevin.tian@intel.com>, <nicolinc@nvidia.com>,
	<vasant.hegde@amd.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
	<sairaj.arunkodilkar@amd.com>, <jay.chen@amd.com>, <wvw@google.com>,
	<wnliu@google.com>, <dantuluris@google.com>, <chriscli@google.com>,
	<kpsingh@google.com>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v3 04/22] iommu/amd: Introduce IOMMUFD vIOMMU support for AMD
Date: Mon, 29 Jun 2026 15:35:17 +0000
Message-ID: <20260629153535.15775-5-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629153535.15775-1-suravee.suthikulpanit@amd.com>
References: <20260629153535.15775-1-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C6:EE_|IA0PR12MB8840:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f602e55-d0ed-4860-5108-08ded5f4ee74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|23010399003|36860700016|7416014|376014|6133799003|11063799006|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	NuipPLWcorGbyNt1JByPNysHNKk6Nr34MER3rtKcHW2JMfXh0IMk1DtKLKduiQFiizdUCDv3HYUWpeElm8a+aYy2z4ifv/sy4DsaRR3kQjxT4KdV6zGVzyWEAM1ogM3LgSx7crr642Ip0oM8eTO2XhVMxAhdTUIjvBItJC1HfBtfvnlKP46AzcGcC92AOLXcaqSkT9bOdb2NjqZXOVKDtV+rf8aRZ8Ed0KRoARs1Sxey6dObu8Ncga+0WYw4NpYaqiYi+j1FNt0i+QsLdZ4RW2FRL/bkcbdV6cQGLLAucBBCM880sYAK9SPJ64W6lYKeTwWCuEtkMxy9ae764V7xZs9uiRU1fBbCY4TPhYOJ3jWDswslBTAr5klT8EU/92fS7G2amsGKwlVCGgtRRsHYirvXCTgfX6RWAHnRdAIhSFA0TdKyEuj/iRMMHnTy+J32YYay4d7OJU2deKbaNBb1485aP+SAUpoLEiWAd+GByetpBMw3dVNJfhMPRVuIRN3Hs1hVIiOClzlSdjwGHPY5ECQN8Jpp+35waWDQPz4LrtfygJnzYUt+sjZ9gOIhSSnO40XK/l0nhMox9HdZY31SSGdYdkzrig5daBuyjqxTiS20RAZzuNN97xaR+kVzSLjrDjkioY5IkFNTZHQBK1XGLm7/5Jc8MxrHnkTqb6e08eHJjtMhZXyjcxYsrwsFbvVn9jJlq3cF401IWHYDOHgBoQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(23010399003)(36860700016)(7416014)(376014)(6133799003)(11063799006)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	KCeeZA550BFpXP1OyhAeOFIf3A2cP3+PRvuK6V1erJDkCeJYiEwtCZUx815tOf8q98qu6yCBkK9I/w4c773L0uZfUzJwnWjV0aropJ5LxOzVCDpio5SVlxji7QwTrCZuNCgrV2tyjT+vV/bPWIZm5FVh0CPQggNtwT9KJo+hyXe4a4EurJFBpCi+iIw/PxZ1f9mfe22tWxptiyuUZDiLo26XSEiD5NMm4qSbFfOi5rxADM8Y/ZwFtoISDQMsutHBJTo33ju7AzHPJoPeJoIB24xkJzJKx96xpW4HCK3HWjAfMZ5HJxDVyrydUGslo8hCUZOju0jv/S7u26rSG6ETcWD5Je9iIFRtmDKunKd1zUH8o/0fHkjjM8W/36rnks7ERna1yNuu1l4rw9XQGjLnMxi6sEkil95jXrLj/Bwde0bsM8AjvqEPD7CVuJ56N2Qz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 15:41:48.1260
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f602e55-d0ed-4860-5108-08ded5f4ee74
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8840

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

