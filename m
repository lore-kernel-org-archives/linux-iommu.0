Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012036.outbound.protection.outlook.com [40.107.209.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11A14718E9
	for <iommu@lists.linux.dev>; Wed, 30 Sep 2026 09:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790760275; cv=fail; b=hSXe5xJCvpHyB9fGsSLDkKOWydVwhsuOJ1oKkEsz0rT696oyle5Fb43pkL6Z3ENlIppejLapMIofQXjorLgN0XhITL+ii8OtbGql4ZUPBJN2z1Ks+XNfnLbr1tl1+c2b8vhaf1QXw8BqLfO9qMb7J/n2r1Ef4VGaql2zIugtUvc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790760275; c=relaxed/simple;
	bh=aM5YyIs2+bqiLRrppmSnsqCD4aP0AOClDbnE6zYrB5s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gzmauVu9cxSD0YYyvJmG2EfUoTjoJvGm9koS7rBIyPyQMYrjv5ldDyve+uvAkBBXpDXxWsrQXSRCu2AQvgC44/pUYPRkKqYxNhZViCnyFMJgLyMS2SbXRaGE29k+5tDjw8JnMmXKEgDcTwfqYYJZ4Dh6/BzmsfFX1vGXfo4J82U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EAziH9Kf; arc=fail smtp.client-ip=40.107.209.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EAziH9Kf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gbd4EzZetl0Jt2CsWbZR+/RGU2zlCrCJgNepGuRPKNqCaylvhtBeTm2dHKZXcPVf0N5P3Wa9BNxT+ULfiHs1+GbEH8l1rwiglSg3Q/s53M33nqn1heciXh4Fq3szIiobMs0bj+WCwIYZ9gz29eBGLFYunNtTC2ZxcophdDMYFHqWxHkDHM2to4eeNRPtwphoA70g2LuNRb6bIORtC0ZQo9pMylJBp2enul4fsUsAgevyOkTFkK+OgMyiMPbux2+7cn7ZRI0qYOy4NMH6vy2tKva6n65qUpsVVwaCFaVQIwh7WWpWuOk5jTmUUY241f0L0laGL02AykuYRNO7nllWBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=19sO4iDheBBltlk/+QgZNz9plcUhwScMBtiKHphznMQ=;
 b=u9ylRR7awryYZoDdrS/Hvk1KRkITWHapUX8kHmy4mH6w3AI0lADEPHYVzo/txwI2TM/HKcr7uVcxiBH7ulocTdvVXurDxAwyM5nzuFOgnpTpeh/l28/JgZw0KZSwv5NrhUUWjIxdrWPe026w3oD1FzE4e3qs+a1QHpgcUn6NzR5wrA0zBsKkppfipyfBtxA7plMVaWb/4k161jjK74gQohx5hgv3YVIvgeAJ0Kijs2t+u1lGPa7ZGZSq6npj6cJOW9IgODYwaglAvvwEtLNyTMaKE9vYNzsYPyVdCJGbLDQ0w1k15B+V0MxstAqMTjnA6F6zMLumJl4ilDoG/U7bQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=19sO4iDheBBltlk/+QgZNz9plcUhwScMBtiKHphznMQ=;
 b=EAziH9Kf9uOyh6LkxstHExMhfL/wmU8F/mTDnw7X8h49DYjQxGlErk0j1ueVDtt1KF8qZVYxZKj9CxUTpA+0ekv0TmVN622paN7qpvA5QjuounxfH/8lxpXSQfPVp0u54pB80dFl69FRYN1OEuVuFyhL/TpcNBD3WmV5rw+2dTg=
Received: from PH8PR20CA0019.namprd20.prod.outlook.com (2603:10b6:510:23c::25)
 by CY3PR12MB9553.namprd12.prod.outlook.com (2603:10b6:930:109::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Wed, 30 Sep
 2026 09:24:30 +0000
Received: from SN1PEPF000397B0.namprd05.prod.outlook.com
 (2603:10b6:510:23c:cafe::80) by PH8PR20CA0019.outlook.office365.com
 (2603:10b6:510:23c::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.16 via Frontend Transport; Wed,
 30 Sep 2026 09:24:29 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B0.mail.protection.outlook.com (10.167.248.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Wed, 30 Sep 2026 09:24:29 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 30 Sep
 2026 04:24:23 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>, <jgg@nvidia.com>
CC: <yi.l.liu@intel.com>, <kevin.tian@intel.com>, <nicolinc@nvidia.com>,
	<vasant.hegde@amd.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
	<Sairaj.K@amd.com>, <jay.chen@amd.com>, <Ming.Shu@amd.com>,
	<SooJin.Tan@amd.com>, <chrisl@kernel.org>, <wvw@google.com>,
	<wnliu@google.com>, <dantuluris@google.com>, <kpsingh@google.com>,
	<alejandro.j.jimenez@oracle.com>, <joao.m.martins@oracle.com>,
	<guanghuifeng@linux.alibaba.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>
Subject: [PATCH v6 04/24] iommu/amd: Introduce IOMMUFD vIOMMU support for AMD
Date: Wed, 30 Sep 2026 09:23:24 +0000
Message-ID: <20260930092344.5616-5-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260930092344.5616-1-suravee.suthikulpanit@amd.com>
References: <20260930092344.5616-1-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B0:EE_|CY3PR12MB9553:EE_
X-MS-Office365-Filtering-Correlation-Id: 6598bba3-f6e7-4012-61f1-08df1ed4a130
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|376014|7416014|1800799024|82310400026|22082099003|18002099003|6133799003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	ZCQjUX5k1hurEScZXOtoBvFktwPY8o2IahLY8zHw+a91sAXEMXNnMAI8oT1WscRhxU1xoXznQCRlhUOKN4+zMZClmBFPaWapAny19x4IiEeK/TUAgxiyZB7WGkjLogk9UgHYVIm1VIrnf00l4XCJ+zq7R8PrO9RtWp8xchN1f5j0gZo/Lzsoha4bS0DRuWxvZA+SWV6YwT95Z/ab4pmjfFuI1KTEzcat/XZwXxY0Q0k5DnzWCMfeDMumANdmbrVbK47nzbQjI6LfjvXDNXkHkoNoxA3q0U1E9OznYnkCQlyyzWd9RNKGgKl2y/uPsg77NMhf551GMuI2034mQgKg7ZwjwNryDT9tN4CdP+ZprRyKjNV4zkG5HnU45O3MF6JLfklugXzsfhMBg8gMnXU0ro3h9EUJ9xdl9bDNRJFjq3WhV61Y5M4EDsprk0rJhcxt/uD44Za06wBlS1uEOCzWHBMXoweDrDtPQpvYPzTJaMbhIRCAHUaQIE6S2qkqneGP/VOv25d6xcdcKKgjNBfH2GCLRmTX3dntm0U0tboZu0GzTk2z0wawps86FtTDBBMpMmpqMAAwRCVAaFFUgAAqZ5hJn3UNOScXkEYCfMCzRsH9pwI3kYxWxDhDp0ej7zmrBDulcxmGAG6F29085/28VfGcB3i+Q4aJh3zBT1iefm5/adUspqRluWpmJHAfGKmI24sek8dMRZFHhETnfqIXMg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(376014)(7416014)(1800799024)(82310400026)(22082099003)(18002099003)(6133799003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	vnliecfJGVq2joooxYBDpIzmjWdjidIg58rCE9bxIMBX6tBwsMsphexqLSx0WubGUiU5tHJ+uiHAC9du/8lJ/IUGc7MnEi3M9DtXLihyeiThpO2bF86Se9Ktf3SvTSU43zOb5BVVjk3slGof/X99MladJHVkzbM1WnTHlS9s+RnvWfNErb3DEAY2q3FbO4EUJeMDmb6nDzT8inflqQv9CjSGH5czGPSOsbLPiu02UcX6upe7ubPqlnrmXpn43oPx2fUtDMZ+RjnnUNLrl94KgyuQdSInQkABxiCNeAJvrdqUk0pEs9+xpLlBX62bbdqT0vp2QZCu1mUCdAtgge3nstRI+LQxLKSkINRVjJEOcTZlBCq4lDsvZT9leNygWfqiTI/Z/mDJcnUAnNSs3pKsBV492cKJ2luXBs7IRS4/yPU2n5+RJWdFvU162T0vWxYT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 09:24:29.5452
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6598bba3-f6e7-4012-61f1-08df1ed4a130
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9553

Introduce a new enum iommu_viommu_type (IOMMU_VIOMMU_TYPE_AMD) for AMD
vIOMMU along with the struct iommu_viommu_amd, which is used to initialize
IOMMUFD vIOMMU instance when calling struct iommu_ops.viommu_init().

Also, hook up struct iomufd_viomu_ops.alloc_domain_nested to connect
nested domain allocation with AMD vIOMMU implementation.

Only report a non-zero viommu size when the type is AMD and
amd_iommu_viommu_enabled() is true for the device's IOMMU.

Additional initialization will be added in subsequent patches.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/iommufd.c  | 10 ++++++++++
 include/uapi/linux/iommufd.h | 10 ++++++++++
 2 files changed, 20 insertions(+)

diff --git a/drivers/iommu/amd/iommufd.c b/drivers/iommu/amd/iommufd.c
index 52300b867c1f..e8e7807f2a33 100644
--- a/drivers/iommu/amd/iommufd.c
+++ b/drivers/iommu/amd/iommufd.c
@@ -34,6 +34,15 @@ void *amd_iommufd_hw_info(struct device *dev, u32 *length, enum iommu_hw_info_ty
 
 size_t amd_iommufd_get_viommu_size(struct device *dev, enum iommu_viommu_type viommu_type)
 {
+	struct amd_iommu *iommu;
+
+	if (viommu_type != IOMMU_VIOMMU_TYPE_AMD)
+		return 0;
+
+	iommu = get_amd_iommu_from_dev(dev);
+	if (!amd_iommu_viommu_enabled(iommu))
+		return 0;
+
 	return VIOMMU_STRUCT_SIZE(struct amd_iommu_viommu, core);
 }
 
@@ -73,5 +82,6 @@ static void amd_iommufd_viommu_destroy(struct iommufd_viommu *viommu)
  * struct iommufd_viommu_ops - vIOMMU specific operations
  */
 static const struct iommufd_viommu_ops amd_viommu_ops = {
+	.alloc_domain_nested = amd_iommu_alloc_domain_nested,
 	.destroy = amd_iommufd_viommu_destroy,
 };
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 206fa667c782..e1080b997e8f 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -1095,6 +1095,7 @@ struct iommu_fault_alloc {
  * @IOMMU_VIOMMU_TYPE_ARM_SMMUV3: ARM SMMUv3 driver specific type
  * @IOMMU_VIOMMU_TYPE_TEGRA241_CMDQV: NVIDIA Tegra241 CMDQV (extension for ARM
  *                                    SMMUv3) enabled ARM SMMUv3 type
+ * @IOMMU_VIOMMU_TYPE_AMD: AMD HW-vIOMMU type
  */
 enum iommu_viommu_type {
 	IOMMU_VIOMMU_TYPE_DEFAULT = 0,
@@ -1105,6 +1106,7 @@ enum iommu_viommu_type {
 	 *   VMM must wire the HYP_OWN bit to 0 in guest VINTF_CONFIG register
 	 */
 	IOMMU_VIOMMU_TYPE_TEGRA241_CMDQV = 2,
+	IOMMU_VIOMMU_TYPE_AMD = 3,
 };
 
 /**
@@ -1123,6 +1125,14 @@ struct iommu_viommu_tegra241_cmdqv {
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

