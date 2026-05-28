Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010011.outbound.protection.outlook.com [52.101.201.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5591F31815D
	for <iommu@lists.linux.dev>; Thu, 28 May 2026 05:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779945553; cv=fail; b=SCctyA1K7GOGc6+hnKe1BS8kqYl8q/X4PZDCiu+vcCr3kgPaKgbuzXHxg6FV1+nDTHQ9HxbiyWOgufAzScMKPL0bKDuLdYnovqAoXzz1ASKmjNH6B81XSLJlJNTWd/fJhLdhbb4ujinWYE5UEEK+k8jexPTRKKf9cUnl/mGRIpA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779945553; c=relaxed/simple;
	bh=J+dWIfq8QTs6GZtxGObsHkSwPI4Hh9pKTSV20QXyzpg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RmoZ14ZJ0dnXDAQA4BiR+qKRwU4z9g+cS+wPSY3VxmKWNHFvym6csz1xBCdFTpgQLJHK8MdC3uilpGaPU/j/AAKykQztn/ieD5nN2Vgd/SQm7TP7kUPoL2xiG3f5Kt7W512znkgCACtQTWenKZfBZNX+KGLIod6QSQdgq6VHqeE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PEdRgzdm; arc=fail smtp.client-ip=52.101.201.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PEdRgzdm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RhZgMu/oM5l6RPaEzRjxDLFSi6DKy4zlcx4IcSrN9csdwH0tJzAZmECHJfWDN90wkuH9NHdk/u0DUsbmmzjRDCxp5NTbpweoEQYK0QKB56Cr+Gg4S2wmdf0CnxY1dhHDcZwXeny1QL/fmpXzGdFGFsDBwJcncm45CwfQpQomQ5ZEs5QLCHncqbbHrMnmChBUVFA/S5eu0Jp1F/TEcNl0Ts4et8dt0V+EPWTkVkoNRXVcFDXRWRUYHZEIVwWAWx4q86QNaNR7e3el5bPxQQB6NdasNDoZa65PZb+O7ovCtCz80BZmC8dwV7EsoPR30Riplr2xSYTztE6p/DDN2KVMLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jkM/DZc2XfiYQGkhif8sZd1yvVdeP2kGTqvPi+Gbnkg=;
 b=EE4LWxjN/6efQqKvScdymR1cnlEKPBjBK+7PPPedjipwAPRbuTuaQQD4PL1LdD560DngffdGfFOKgE4+8vymuxJ21HmvRomBI43qHYYbh8yVmu2KZK15tz03dZ+AQ5fSmG+A6w9A3fd4/iYAuZADFsRa4zZSWD0WhMDC7OL4Lz5cm4UMBaez5QtYWYxn3ZVqo9CGx6v0MOsjrPeqxjwMklP9DDvHsKsfmp5qcNliBWwI8ZHKOobNknvccohy0u0rsTMiy62yWrytenkyCIfEDHQIHrqrT8725LI6eRo1dQXz37wTZgAhGSUfRvorl6SGDjRrPanowAyw1QbbDxoRFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jkM/DZc2XfiYQGkhif8sZd1yvVdeP2kGTqvPi+Gbnkg=;
 b=PEdRgzdmoDnkt7TigPF1YSSQgZdBQJGvi566AK5The9yi9sA/mXO4aiYhCn8pk0i0C9IGzyaaREewLQcy3YEAND8QgQudiFmh7/SZ6K5Ant+Rumft1HIw/xqe5SPer5GbId9H4BaSBH8R4U3HLM0DHujqhaVipnK9W5YcyozLgE=
Received: from SN6PR2101CA0026.namprd21.prod.outlook.com
 (2603:10b6:805:106::36) by LV2PR12MB5800.namprd12.prod.outlook.com
 (2603:10b6:408:178::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Thu, 28 May
 2026 05:19:05 +0000
Received: from SN1PEPF00036F3F.namprd05.prod.outlook.com
 (2603:10b6:805:106:cafe::5c) by SN6PR2101CA0026.outlook.office365.com
 (2603:10b6:805:106::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.4 via Frontend Transport; Thu, 28
 May 2026 05:19:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00036F3F.mail.protection.outlook.com (10.167.248.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Thu, 28 May 2026 05:19:05 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 28 May
 2026 00:19:00 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>, <jgg@nvidia.com>
CC: <yi.l.liu@intel.com>, <kevin.tian@intel.com>, <nicolinc@nvidia.com>,
	<vasant.hegde@amd.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
	<sairaj.arunkodilkar@amd.com>, <jay.chen@amd.com>, <wvw@google.com>,
	<wnliu@google.com>, <dantuluris@google.com>, <chriscli@google.com>,
	<kpsingh@google.com>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v2 13/26] iommu/amd: Add helper functions to manage DevID / DomID mapping tables
Date: Thu, 28 May 2026 05:17:25 +0000
Message-ID: <20260528051738.596013-14-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260528051738.596013-1-suravee.suthikulpanit@amd.com>
References: <20260528051738.596013-1-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3F:EE_|LV2PR12MB5800:EE_
X-MS-Office365-Filtering-Correlation-Id: cbe49e7a-dbd0-4f2d-3535-08debc78a35d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700016|82310400026|1800799024|56012099006|11063799006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	qgceGBzUSsT71+QvlQhJvab1E+a2vO7gl7Fx2ilmUrPk+E2Zbpnavs/s6zOvDZ1JA3MLthZniwuJRKvO51Y0/WGD73q/B6klWJgjXcf79LChrPKLqmQJK34bWwShKmG3JUSffYWauw5269uPkXHNFXkkwbeTd2/+m1ZOp1wq3S+chj9Szd30vD2BwXjDqLKU5aInzxxBLw0jzFbQQ2Z7RnkeMkpDgB1YHsOnULWRCJEq33P7DNfEzYLVNLSgx5d2n4gyBXju45Vq87+a3Y1hL8Nr1uaG8D3onCus3bwv9vZgqbVwHkJ1jmc/oZq078O70uRxY2vPE3B1JevTXI9KizU2jlw06QfI4rX+CTLzCwwmG8rAtSIWcILplGVbfl6PA/cMoMGNn1V53gtjIhKToKLGIyUGRB2GkFGMIw7PyWj52r21epQCSNBXkvBcttNxloNP54wrwOyj6E12h7OgE+3gd1+MOR5GaXtOps5Mz6+Z1u4zwkO1YuvV2P67iURmnV8htKQvt8d75JtBQuyXCcvC4HvvAyf1+S01Xd3O5/rt9DbmHInF+NkE/DrxY9qs59mNU+R6hzOS39p93c0e0Fzo70HMVGueLtPHOHQJS3rguyCx8BaPoU3GyHJnNkoJJzeVUcF48ObxOc7+82e/U35JLpTW7KczPhjnbv1lRv98Ydyi67L3NArFm2eGzIpwPGG/XLtEqcFGWNSE04DkDgj5SF7AvbJ7ns1UMOcogto=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700016)(82310400026)(1800799024)(56012099006)(11063799006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	rlON1anqhJUg+Q5MdpnEoVkfMxoPngagoHG48dkk2sVW0pfzefr0NhykKYjw+VKerRZ90Wh/IX8idnt5TnZnKiYxar2wb46dRYc78UeEdS1BR0ksjT9bNgOigTQbIwiP/bV1lCMdOCLpv1t9kW1kfpDLV5XkHNMN8JmyGHeBfB7hra98gQJfInjlnjuocV+hIrqu/MZTe0yY/AQ+9TehBdMz3q86AazTL6XjKZvcQvB6Xi00JOjDGtxg8lqxzkunb63oFZ2nhlJHI8ZeEcufSFRFCfaTX/xYAdkD6eIhAnVnXgLvRu1PmbAuxFTfS5tQ3fLhLs4B/Ndp66WT1atqy2upQQKJs/Jut9Y4X+lIN5rk7unQz9TLKe+NHtGx/VtoO6vHLQIxeOqV0QZgclp2g/Toq9HO0rwRZetupP2JEOh6ZNo1MxHNcnzFzO5c8kOE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 05:19:05.5424
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cbe49e7a-dbd0-4f2d-3535-08debc78a35d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F3F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5800

Introduce amd_viommu_init_one() and amd_viommu_uninit_one().
These functions are called during IOMMUFD vIOMMU initialize and destroy.
Currently, it manages the IPA mapping for Device ID and Domain ID mapping
tables.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  3 ++
 drivers/iommu/amd/amd_viommu.h      | 13 ++++++++
 drivers/iommu/amd/iommu.c           |  1 +
 drivers/iommu/amd/iommufd.c         |  5 +++
 drivers/iommu/amd/viommu.c          | 52 +++++++++++++++++++++++++++++
 5 files changed, 74 insertions(+)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index a5e2f32590d1..63410028bae3 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -549,6 +549,9 @@ struct amd_iommu_viommu {
 	 */
 	struct xarray gdomid_array;
 
+	u64 *devid_table;
+	u64 *domid_table;
+
 	/* Offset for mmap() of guest VF MMIO; set after iommufd_viommu_alloc_mmap(). */
 	unsigned long vfmmio_mmap_offset;
 };
diff --git a/drivers/iommu/amd/amd_viommu.h b/drivers/iommu/amd/amd_viommu.h
index 447692b9101c..8b57717c22a6 100644
--- a/drivers/iommu/amd/amd_viommu.h
+++ b/drivers/iommu/amd/amd_viommu.h
@@ -14,6 +14,10 @@ void __init amd_viommu_uninit(struct amd_iommu *iommu);
 
 u64 amd_viommu_get_vfmmio_addr(struct amd_iommu *iommu, u16 gid);
 
+int amd_viommu_init_one(struct amd_iommu *iommu, struct amd_iommu_viommu *viommu);
+
+void amd_viommu_uninit_one(struct amd_iommu *iommu, struct amd_iommu_viommu *viommu);
+
 #else
 
 static inline int amd_viommu_init(struct amd_iommu *iommu)
@@ -30,6 +34,15 @@ static inline u64 amd_viommu_get_vfmmio_addr(struct amd_iommu *iommu, u16 gid)
 	return 0;
 }
 
+static inline int amd_viommu_init_one(struct amd_iommu *iommu, struct amd_iommu_viommu *viommu)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void amd_viommu_uninit_one(struct amd_iommu *iommu, struct amd_iommu_viommu *viommu)
+{
+}
+
 #endif /* CONFIG_AMD_IOMMU_IOMMUFD */
 
 #endif /* AMD_VIOMMU_H */
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index e0433e65cfa5..44d20e598d85 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -43,6 +43,7 @@
 #include <linux/generic_pt/iommu.h>
 
 #include "amd_iommu.h"
+#include "amd_viommu.h"
 #include "iommufd.h"
 #include "../irq_remapping.h"
 #include "../iommu-pages.h"
diff --git a/drivers/iommu/amd/iommufd.c b/drivers/iommu/amd/iommufd.c
index 42307ae71b24..efa9e1f49550 100644
--- a/drivers/iommu/amd/iommufd.c
+++ b/drivers/iommu/amd/iommufd.c
@@ -83,6 +83,10 @@ int amd_iommufd_viommu_init(struct iommufd_viommu *viommu, struct iommu_domain *
 	/* Reset vIOMMU MMIOs to initialize the vIOMMU */
 	iommu_reset_vmmio(iommu, aviommu->gid);
 
+	ret = amd_viommu_init_one(iommu, aviommu);
+	if (ret)
+		goto err_init;
+
 	ret = iommu_copy_struct_to_user(user_data, &data,
 					IOMMU_VIOMMU_TYPE_AMD,
 					reserved);
@@ -120,6 +124,7 @@ static void amd_iommufd_viommu_destroy(struct iommufd_viommu *viommu)
 	if (aviommu->vfmmio_mmap_offset)
 		iommufd_viommu_destroy_mmap(&aviommu->core, aviommu->vfmmio_mmap_offset);
 	amd_iommu_gid_free(iommu, aviommu->gid);
+	amd_viommu_uninit_one(iommu, aviommu);
 }
 
 /*
diff --git a/drivers/iommu/amd/viommu.c b/drivers/iommu/amd/viommu.c
index 6dcb02b12a28..3636093732ce 100644
--- a/drivers/iommu/amd/viommu.c
+++ b/drivers/iommu/amd/viommu.c
@@ -26,6 +26,20 @@
 #include "amd_viommu.h"
 #include "../iommu-pages.h"
 
+/*
+ * Guest Device ID Mapping Table
+ */
+#define VIOMMU_MAX_GDEVID	0xFFFF
+#define VIOMMU_DEVID_MAPPING_BASE	0x1000000000ULL
+#define VIOMMU_DEVID_MAPPING_ENTRY_SIZE	(1 << 20)
+
+/*
+ * Guest Domain ID Mapping Table
+ */
+#define VIOMMU_MAX_GDOMID	0xFFFF
+#define VIOMMU_DOMID_MAPPING_BASE	0x2000000000ULL
+#define VIOMMU_DOMID_MAPPING_ENTRY_SIZE	(1 << 19)
+
 LIST_HEAD(viommu_devid_map);
 
 static int viommu_init_pci_vsc(struct amd_iommu *iommu)
@@ -352,3 +366,41 @@ static void __maybe_unused free_private_vm_region(struct amd_iommu *iommu, u64 *
 	iommu_free_pages(*entry);
 	*entry = NULL;
 }
+
+void amd_viommu_uninit_one(struct amd_iommu *iommu, struct amd_iommu_viommu *aviommu)
+{
+	pr_debug("%s: gid=%u\n", __func__, aviommu->gid);
+
+	free_private_vm_region(iommu, &aviommu->devid_table,
+			       VIOMMU_DEVID_MAPPING_BASE,
+			       VIOMMU_DEVID_MAPPING_ENTRY_SIZE,
+			       aviommu->gid);
+	free_private_vm_region(iommu, &aviommu->domid_table,
+			       VIOMMU_DOMID_MAPPING_BASE,
+			       VIOMMU_DOMID_MAPPING_ENTRY_SIZE,
+			       aviommu->gid);
+}
+
+int amd_viommu_init_one(struct amd_iommu *iommu, struct amd_iommu_viommu *viommu)
+{
+	int ret;
+
+	ret = alloc_private_vm_region(iommu, &viommu->devid_table,
+				      VIOMMU_DEVID_MAPPING_BASE,
+				      VIOMMU_DEVID_MAPPING_ENTRY_SIZE,
+				      viommu->gid);
+	if (ret)
+		goto err_out;
+
+	ret = alloc_private_vm_region(iommu, &viommu->domid_table,
+				      VIOMMU_DOMID_MAPPING_BASE,
+				      VIOMMU_DOMID_MAPPING_ENTRY_SIZE,
+				      viommu->gid);
+	if (ret)
+		goto err_out;
+
+	return 0;
+err_out:
+	amd_viommu_uninit_one(iommu, viommu);
+	return -ENOMEM;
+}
-- 
2.34.1

