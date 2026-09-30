Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010048.outbound.protection.outlook.com [52.101.201.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4487047D959
	for <iommu@lists.linux.dev>; Wed, 30 Sep 2026 09:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790760293; cv=fail; b=iDaW7CFEt0vY6Sh8zk4qpVLUKz7BV4RWOp98NP1yiRDELw5MalzugToNvlz8EjaCKM0npMRKfVPnaXzUYJOOK246Q2w/cfIv5K/Maprn6OydIiqeKHdKR8WfmrALV0aGVoRHwxBQU/XmMMuqHzjQrXJrgFwTJDxxbJLSFkzrUI4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790760293; c=relaxed/simple;
	bh=N+i0zLYYDNQtrz7JB9yYzCOp+nUlxxehdaKL5iOadxo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ay5tQ25+wsf73jlTyETL+DEld42ciF8R5ttp1ji2ApT7sktAiV3QZ2nTNCBb6nr2ajBx1nybjyY/Sk8LCl9bzduZ+mm8dIaFp8gZgCh0ux3Yittl5V7WCgwMcmbmOgJLdNjjfq465WjvI/Lx9/RDPuRwBmhNW/QnbgmxpsChbIs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=w4zolTC6; arc=fail smtp.client-ip=52.101.201.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="w4zolTC6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ulcs/RfduhBtjQ1FRBHs30qgOdsY97DIKgh2EYB3sjZyRrb0W0Xofolz+E14qyE9H0hFxeJ15PKjZ5iIwDUkcbQP9d5UYQqvhg6LClZi4O/JExfQa49BDaEtV3rRg8qa8Q7hzEAqnigQL6+zDijYy7v41/3eotd26J6Dj/dnBf68IksHMWQtTNDU+M27HVkEkmaTPk8x51B/TzDIWAsWdGGX767135OXuBvGMIsK5EeCY9AiKorPWI+fjgzKqnt21eRiiW5HX362BX5bgiwG4TUk+cl1NMrRodVE3+10fYJrG8qKrTXY699KLKgNcI6ooPLZ1tbJptVcYqfjPtZE0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tESWOykCYz+cJPGfENWWIo6x48UBaI74NZ9GWATTCpg=;
 b=Q8Ru9vVVRV0v3zkQWPIyBEe7ms5GqssdjRc8bbVRPZzh66GMdmCYDJ2en/h5KzexG2MLhUUsQVqbBe5MSr1M/TmYziFB5x2rdxGgTk42VlUQEJ4MlUszo9vtmzmofJT458pqkWGhpHLeWKnHz0C7KxFCXiecTL7tCCnEni6kc4k2Y6gTu4dUldWztXHfVcy1lDZQGFMygO/Tw+V7riIDGtkmre0/i+KhNe7XOb/XjA8Y3aO2VmcLPxXokUYc+fUSPAIGw8n0C+b43FsU9xPCS/6CifJ3uC3zxH5gJjK6jshjaBIf0nMew1Gur5LE0usnX3IIZIZIy+M9LTWvSp8Y5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tESWOykCYz+cJPGfENWWIo6x48UBaI74NZ9GWATTCpg=;
 b=w4zolTC6XXnClS0GrabZhLnVjYcRmncuDvd/0l1aEAPiDdeXAH4+x6WBszBERM83lKU8bkUxxacGglD9uwdANMuSaIrgyNwEBG4oP6C4JzjIWDs6M0YBkFVyZppmT5hzmgG7t7aB47aW5cFBZWTXMcFm4w/TJVG5yWyUjvl9vHw=
Received: from SN7PR04CA0191.namprd04.prod.outlook.com (2603:10b6:806:126::16)
 by LV2PR12MB683086.namprd12.prod.outlook.com (2603:10b6:408:414::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.25; Wed, 30 Sep
 2026 09:24:48 +0000
Received: from SN1PEPF000397B2.namprd05.prod.outlook.com
 (2603:10b6:806:126:cafe::92) by SN7PR04CA0191.outlook.office365.com
 (2603:10b6:806:126::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.15 via Frontend Transport; Wed,
 30 Sep 2026 09:24:48 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B2.mail.protection.outlook.com (10.167.248.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Wed, 30 Sep 2026 09:24:48 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 30 Sep
 2026 04:24:41 -0500
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
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <Vasant.Hegde@amd.com>
Subject: [PATCH v6 07/24] iommu/amd: Add support for AMD vIOMMU VF MMIO region
Date: Wed, 30 Sep 2026 09:23:27 +0000
Message-ID: <20260930092344.5616-8-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B2:EE_|LV2PR12MB683086:EE_
X-MS-Office365-Filtering-Correlation-Id: fafb9b6e-b32b-42f7-ae9d-08df1ed4ac43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|23010399003|36860700016|82310400026|22082099003|18002099003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	JBUpKxrS67jZj53b0QSc8HLFuGOZYLgvIfYhI5gUvO4kWjJOLcE3rY04jnzk6UDdKUNHoyF2CjaAErusPwfIELaVR+F2Hn9oshJXXAo2yeFt4VWQFdDNelpnfD/17K/p4mu2gW1qhkJ+GWmX6gcGHJCu8Sjq8ElYjVe7wAjZ8HmhKVKLGUPdbQ4Ai8PUgdWrqLXVBr8zouA/P1/KrWchWmNOR5lqUspbCbWXEuItLtAybswLlfSRHm8qbkpArC8mKVr3BpQIvSMstViP1h5V88zd80CJe0e1l23devwtpnoCWNelionlXivfI1PbomTjvrbGxTsXTQdhCQoQsrFxpu4mNVB/oIchrkb4hOrr7jg35lILGLLBgavjmUyrTCHYZb9EzwnhGiu+mv3oDCkD72l25mFHlwuXSpjFiUO+MMQCUEm8aBDQjrEZ7DW5AhFGtqyLmoW4OOwAVHkT1jqJHTMOMIHIFzoAlinjXKw8guGE0hKzaM9xplvq3i8AcvSPao2vPjCEJHpxVBzxGOaR4qzBrG3cJtx/sPxin6NNVLj6sZVGH8TL5aEmHDAApDm0xRMdpAQbDMa8zn8fSYO24Crr/FDKunvvhpTSSAlqAkE1nba6loCgD1VEbqBkGXYYg1MsiNruEGLWCwiEn2HQKsZgCzFxcSQDvH9wB1XogRfuepq4GosR4O0jJMmB+XrqlHQM0NHHd+SoBUKUuuG/0g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(36860700016)(82310400026)(22082099003)(18002099003)(10067099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	YGA/VbeBvJhIB83WOaFSNQjOxfhHLYY4AdGRQawr4uIhEtY2U/2bEO3u3aXHHtIeoQlFWtjbCDTaIGLXhzGm073Uj8ogtWM6B1ZFwet4dgQkfOwu+R7VnStdsicLXgNFk3tVRyOs8/XV5/Fdx+Rq1U3X774W/KK0lA7vKoqvPvczUdVi5cD15xU2uv34dBJIajzNK7vW0fiiz1Tkt0xkd5FAlVVcPVcMqNevpARiSD8YY4dtlP0k+Dp4DIJpug5GJ8lSC+Fik7KSZ93P1SBPQJ/Tw8pR3fwLIBPAYy1dhPHVmWm3bICPpaOpt9996XOsEmTpGPPmEVOCR9WomVS2ws0s5aE75rWCluy+nC8JIdZ3i6s3OlVoO6O5WLTrUxrp8vyKfPYBiS8webka1G8ZV5Uw8/dzHC5aWzVfV3AO4xFQYxbyARmuRjlYywGeziy9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 09:24:48.1256
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fafb9b6e-b32b-42f7-ae9d-08df1ed4ac43
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB683086

The AMD vIOMMU virtualizes guest MMIO registers at the 3rd 4K region.
This is achieved using the iommufd_viommu_alloc_mmap().

Copy struct iommu_viommu_amd from and to userspace so the VF-MMIO
mmap offset is validated and returned on vIOMMU alloc.

Return -EINVAL if the VF-MMIO page_base is zero so mmap is not
registered at physical address 0.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Co-developed-by: Vasant Hegde <Vasant.Hegde@amd.com>
Signed-off-by: Vasant Hegde <Vasant.Hegde@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  3 +++
 drivers/iommu/amd/amd_viommu.h      |  7 +++++
 drivers/iommu/amd/iommufd.c         | 41 ++++++++++++++++++++++++++++-
 drivers/iommu/amd/viommu.c          | 12 +++++++++
 4 files changed, 62 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index c2257d48e222..3aaaf69a1e7d 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -532,6 +532,9 @@ struct amd_iommu_viommu {
 	 * Indexed by guest domain ID.
 	 */
 	struct xarray gdomid_array;
+
+	/* Offset for mmap() of guest VF MMIO; set after iommufd_viommu_alloc_mmap(). */
+	unsigned long vfmmio_mmap_offset;
 };
 
 /*
diff --git a/drivers/iommu/amd/amd_viommu.h b/drivers/iommu/amd/amd_viommu.h
index e5fbea666e01..276f2126290f 100644
--- a/drivers/iommu/amd/amd_viommu.h
+++ b/drivers/iommu/amd/amd_viommu.h
@@ -14,6 +14,8 @@ int amd_viommu_init(struct amd_iommu *iommu);
 
 void __init amd_viommu_uninit(struct amd_iommu *iommu);
 
+u64 amd_viommu_get_vfmmio_addr(struct amd_iommu *iommu, u16 gid);
+
 #else
 
 /*
@@ -30,6 +32,11 @@ static inline void amd_viommu_uninit(struct amd_iommu *iommu)
 {
 }
 
+static inline u64 amd_viommu_get_vfmmio_addr(struct amd_iommu *iommu, u16 gid)
+{
+	return 0;
+}
+
 #endif /* CONFIG_AMD_IOMMU_IOMMUFD */
 
 #endif /* AMD_VIOMMU_H */
diff --git a/drivers/iommu/amd/iommufd.c b/drivers/iommu/amd/iommufd.c
index 69a0e61bf83d..7f358e57efde 100644
--- a/drivers/iommu/amd/iommufd.c
+++ b/drivers/iommu/amd/iommufd.c
@@ -7,6 +7,7 @@
 
 #include "iommufd.h"
 #include "amd_iommu.h"
+#include "amd_viommu.h"
 #include "amd_iommu_types.h"
 
 static const struct iommufd_viommu_ops amd_viommu_ops;
@@ -51,6 +52,8 @@ int amd_iommufd_viommu_init(struct iommufd_viommu *viommu, struct iommu_domain *
 {
 	int ret;
 	unsigned long flags;
+	phys_addr_t page_base;
+	struct iommu_viommu_amd data = {};
 	struct protection_domain *pdom = to_pdomain(parent);
 	struct amd_iommu_viommu *aviommu = container_of(viommu, struct amd_iommu_viommu, core);
 	struct amd_iommu *iommu = container_of(viommu->iommu_dev, struct amd_iommu, iommu);
@@ -58,14 +61,43 @@ int amd_iommufd_viommu_init(struct iommufd_viommu *viommu, struct iommu_domain *
 	if (!amd_iommu_viommu_enabled(iommu))
 		return -EOPNOTSUPP;
 
+	if (!user_data)
+		return -EINVAL;
+
+	ret = iommu_copy_struct_from_user(&data, user_data,
+					  IOMMU_VIOMMU_TYPE_AMD,
+					  out_vfmmio_mmap_offset);
+	if (ret)
+		return ret;
+
 	xa_init_flags(&aviommu->gdomid_array, XA_FLAGS_ALLOC1);
 	aviommu->parent = pdom;
 
 	ret = amd_iommu_gid_alloc(iommu);
 	if (ret < 0)
-		return ret;
+		goto err_gid;
 	aviommu->gid = ret;
 
+	page_base = amd_viommu_get_vfmmio_addr(iommu, aviommu->gid);
+	if (!page_base) {
+		ret = -EINVAL;
+		goto err_mmap;
+	}
+
+	ret = iommufd_viommu_alloc_mmap(&aviommu->core,
+					page_base, SZ_4K,
+					&aviommu->vfmmio_mmap_offset);
+	if (ret)
+		goto err_mmap;
+
+	data.out_vfmmio_mmap_offset = aviommu->vfmmio_mmap_offset;
+
+	ret = iommu_copy_struct_to_user(user_data, &data,
+					IOMMU_VIOMMU_TYPE_AMD,
+					out_vfmmio_mmap_offset);
+	if (ret)
+		goto err_init;
+
 	viommu->ops = &amd_viommu_ops;
 
 	spin_lock_irqsave(&pdom->lock, flags);
@@ -73,6 +105,12 @@ int amd_iommufd_viommu_init(struct iommufd_viommu *viommu, struct iommu_domain *
 	spin_unlock_irqrestore(&pdom->lock, flags);
 
 	return 0;
+err_init:
+	iommufd_viommu_destroy_mmap(&aviommu->core, aviommu->vfmmio_mmap_offset);
+err_mmap:
+	amd_iommu_gid_free(iommu, aviommu->gid);
+err_gid:
+	return ret;
 }
 
 static void amd_iommufd_viommu_destroy(struct iommufd_viommu *viommu)
@@ -88,6 +126,7 @@ static void amd_iommufd_viommu_destroy(struct iommufd_viommu *viommu)
 	list_del(&aviommu->pdom_list);
 	spin_unlock_irqrestore(&pdom->lock, flags);
 	xa_destroy(&aviommu->gdomid_array);
+	iommufd_viommu_destroy_mmap(&aviommu->core, aviommu->vfmmio_mmap_offset);
 	amd_iommu_gid_free(iommu, aviommu->gid);
 }
 
diff --git a/drivers/iommu/amd/viommu.c b/drivers/iommu/amd/viommu.c
index 7e6c4412ff20..c9207ed47fb6 100644
--- a/drivers/iommu/amd/viommu.c
+++ b/drivers/iommu/amd/viommu.c
@@ -110,6 +110,18 @@ static int __init viommu_vf_vfcntl_init(struct amd_iommu *iommu)
 	return -ENOMEM;
 }
 
+/*
+ * Returns VF MMIO BAR offset for the given guest ID which will be
+ * mapped to guest vIOMMU 3rd 4K MMIO address
+ */
+u64 amd_viommu_get_vfmmio_addr(struct amd_iommu *iommu, u16 gid)
+{
+	if (WARN_ON(!iommu->vf_base_phys || gid > VIOMMU_MAX_GID))
+		return 0;
+
+	return iommu->vf_base_phys + gid * VIOMMU_VF_MMIO_ENTRY_SIZE;
+}
+
 int __init amd_viommu_init(struct amd_iommu *iommu)
 {
 	int ret;
-- 
2.34.1

