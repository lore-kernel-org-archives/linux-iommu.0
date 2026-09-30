Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012036.outbound.protection.outlook.com [40.107.200.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281AB469837
	for <iommu@lists.linux.dev>; Wed, 30 Sep 2026 09:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790760453; cv=fail; b=fNFb1vWQA734qvPUCS+uDfA+WdOkul7bBfNpubWqJYodRjUSQjJhEfoT54bCSsE6eZr6Hfr+/MnoZA5ec5T8rpxbPWq9IPdAGmMvGNXrOOxZypluHzvTRQqiSEjSmSaOp1tGIyfH2jU9uzaKtgibNgOiocmcOi3vDPw3I5ygyH0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790760453; c=relaxed/simple;
	bh=GuOlFPIgMhpETNOxEG9oBVqbS6eKwP5Pvd0RmoEtLgc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZLadjuYPw7y6S6fEoxxB0K+tc3wVZfKY9miPK24Omlt4YfUYpL1Hi0/dHf1LTgHx8MB2ciPQNUkeBCIbcMVlxmUD8B9iSFmoRjoH+eDld+69CmFxaF7jADO8Z9/ms5W0EDhpGwwMvlKpdItOe8QJuCY0Th6dJfIB3rLoGAWLKAs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eOxXww9n; arc=fail smtp.client-ip=40.107.200.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eOxXww9n"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M9msCAgsdqt/8GKfklNUR2/WZmf2u4zQFzvkHbVe+096t5t4hjFh+vQpeqGVJHw/Pnq4HQeIfs7Xbx9w+3Zuk0VpWkRlxcEDvQ9CQwGTcQrg2CrSw1fYz6MgHJ4j8qhZjBGjaXdCxMowzcjB/7MrwXhRSju8ULVuufxlzehPcE2KvI353Dqnods3c+9EQWCIXqLH+xBy6W8dCZ9BUDG7OAU2L70sO4/DEFvcpzM2/i4PPcTcYvMtampAadBiHCqQEaylU7210KIRs+JRmov6m+mFJlkvyDOLgQnQj2Z14OT9wSsryMFr9v7GRu9An5zycaB4FjqqAQ2Y9v7X8QpN5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JJAqA0o0XfaGzsGxRGzjxumNTtE+U+EX+WVonhTeJLk=;
 b=e7xxggESu5F9Bs9pDn3N4TG/Tru8bzO5XZw0HREIoyWOZNrKh0A6pb3sj1pwxFeEupJ58N5Yu7Ufe3ArE+ync7jogbZvfeq4MDA1Clwi4R+X5xYNW9elSDgDVr5zRGlvLOhEcn++L2QDZH9YVdVpUJT128wi/FM086Svt7t4tYuNumo5wfbQ+BRlbAlfoh3vWIa/mob3fVG6SIJXxN/A6e655yiJeEaNVDzZUgDl1fv7d8MaKfPGfZztdYXzhmMcLUZev3t+E+z5jcTMDEYDyhRgwdQH5hRTmknLRAijgYFX3zC9KTz6ZsbwBVy32u1WbW+ASsoq8Fkn9WshAauhjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JJAqA0o0XfaGzsGxRGzjxumNTtE+U+EX+WVonhTeJLk=;
 b=eOxXww9n+5nYIFv1OFMpijS6vviUpcAxwGSYqjXOWoMV7O/kALjvUNmMo/xk3AmUUwot9GHBLDdmLWxNH2yT2LBCBsKt3BerK38LuttagZSlzra9OhNBEHbuJmka4TvhkOy/7S41oEn6SwbLl+oJ9CJqXFdZIy/fg/i3wTX7khs=
Received: from CY8P222CA0022.NAMP222.PROD.OUTLOOK.COM (2603:10b6:930:6b::15)
 by DS7PR12MB5863.namprd12.prod.outlook.com (2603:10b6:8:7a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Wed, 30 Sep
 2026 09:25:46 +0000
Received: from SN1PEPF000397B2.namprd05.prod.outlook.com
 (2603:10b6:930:6b:cafe::4) by CY8P222CA0022.outlook.office365.com
 (2603:10b6:930:6b::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.16 via Frontend Transport; Wed,
 30 Sep 2026 09:25:46 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B2.mail.protection.outlook.com (10.167.248.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Wed, 30 Sep 2026 09:25:46 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 30 Sep
 2026 04:25:29 -0500
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
Subject: [PATCH v6 15/24] iommu/amd: Add helper functions to manage DevID / DomID mapping tables
Date: Wed, 30 Sep 2026 09:23:35 +0000
Message-ID: <20260930092344.5616-16-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B2:EE_|DS7PR12MB5863:EE_
X-MS-Office365-Filtering-Correlation-Id: e5b95e87-4b99-4230-fb19-08df1ed4cedc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700016|23010399003|7416014|1800799024|10067099003|260925022911599003|260925021311599003|6133799003|260925021911599003|11063799006|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	QG5AMnN1g7dX4ZD8VobdWApSfAOt+aakbiYOXfRMVnNGPVQl8VupaJO9DT40PMIPa2EWTKQzy+wtB/aCsm3Huj7X8KAvFxxmU7LjPE/POSa7P5d1Vxo+4C/QBPzIcExIAAgHyikg4zPVVyyHM0ka18m5SQFKmd3mdwYVqHpREyiG2k5k8A9CFQawophwUE3UQGXfVzmqX8SGRrR3waS2pr/Fqh5FNzGIyET+FovJodgrYc81WH/vhjEqO8fhGnE02J2d6OD79duAHKE47juR0Yxel8vNgxSyVFwxxRgC0YFblodcBRjA9/QDIwRSDyca2CNB1coRspZWOCs9v3rU/JribsD2czqfuqBnEF1J2vfWFc52qDjEX4Akr+6DJZOFbBd8qRg16ojI5/N1l0ifvrWCmHihrCvLt8VHMrahyBAstjU16r/d86wpb4yO+MF8T6FjDtgO9sSmH9XSMEL5xWeJ1lv9VPe4wpuelDl7pUogxCfxgh0XlWrd75Y242IoHsub9M9jGPTGcjRdR3q0q76HzbAJAQwP5aJ7fR6yhCaMAFSujUjMWmM5AXjbbWLm82HyvADQ1CttPdrMioLfBRKgW3z7NwFSWdisBGN2gbdQ5Vo56X2bQEsBaQO5ilfwYPvJlh9OhflM1ljTAyJ/y7UiiD3HgNP9u8SigQNZRmZjm/LHzYX9YgDb5PAzAhOM0Ln7qaOWdFOBxTfczGT4TQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700016)(23010399003)(7416014)(1800799024)(10067099003)(260925022911599003)(260925021311599003)(6133799003)(260925021911599003)(11063799006)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	zYqwYlSPB1M2F85eWiMXhw7pc9zIqf4qLSWPAIdqMDVm1J+TWL4wq/08RQpfTW2mUWWtWxSvJZwtr0OL6021zopsp0uWSb5+EnQlocWkd8a/mX0RO/3P3Ic+w88ZpGNm00Gko7teAjsBWo5ralc5S9ao8k5sv5uNRcq6EVLERwQ5V4wkuVXUxweYQuyL8xghhlSIGfNdIFd47DDEEul3ck9YbtgwHwkdTLDQr+ZEgpgAyl8O7/DA9/ENdtyovGYsCqpH9urol50z2GXTG4P+GjfKbmiwNFZaJ94QZ2ovm8A7OmvwY33sAsnOdZ827uECQFk7VFeLb9RkkNFcIYA8/UsZN+w8nc4RBhryaEuqSHGZeknkGLg2geQ7G+FtRI4DbHqwrLF+ZODkTN7jN8pdn3jP51cy3QkF93Ogs2iiK9EAAQu5lxBxEmtBAc6w203a
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 09:25:46.2074
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5b95e87-4b99-4230-fb19-08df1ed4cedc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5863

Introduce amd_viommu_init_one() and amd_viommu_uninit_one().
These functions are called during IOMMUFD vIOMMU initialize and destroy.
Currently, it manages the IPA mapping for Device ID and Domain ID mapping
tables.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  3 ++
 drivers/iommu/amd/amd_viommu.h      |  4 ++
 drivers/iommu/amd/iommu.c           |  1 +
 drivers/iommu/amd/iommufd.c         |  9 +++-
 drivers/iommu/amd/viommu.c          | 64 +++++++++++++++++++++++++++++
 5 files changed, 80 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 4b48ec8bacd6..fc8e1378c7ed 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -544,6 +544,9 @@ struct amd_iommu_viommu {
 	 */
 	struct xarray gdomid_array;
 
+	u64 *devid_table;
+	u64 *domid_table;
+
 	/* Offset for mmap() of guest VF MMIO; set after iommufd_viommu_alloc_mmap(). */
 	unsigned long vfmmio_mmap_offset;
 };
diff --git a/drivers/iommu/amd/amd_viommu.h b/drivers/iommu/amd/amd_viommu.h
index 276f2126290f..580cad0f9f5a 100644
--- a/drivers/iommu/amd/amd_viommu.h
+++ b/drivers/iommu/amd/amd_viommu.h
@@ -16,6 +16,10 @@ void __init amd_viommu_uninit(struct amd_iommu *iommu);
 
 u64 amd_viommu_get_vfmmio_addr(struct amd_iommu *iommu, u16 gid);
 
+int amd_viommu_init_one(struct amd_iommu *iommu, struct amd_iommu_viommu *viommu);
+
+void amd_viommu_uninit_one(struct amd_iommu *iommu, struct amd_iommu_viommu *viommu);
+
 #else
 
 /*
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index edeaea48d434..b7073b0ca8b0 100644
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
index 2e34491e3cf7..97de07d3ad10 100644
--- a/drivers/iommu/amd/iommufd.c
+++ b/drivers/iommu/amd/iommufd.c
@@ -97,11 +97,15 @@ int amd_iommufd_viommu_init(struct iommufd_viommu *viommu, struct iommu_domain *
 	if (ret)
 		goto err_init;
 
+	ret = amd_viommu_init_one(iommu, aviommu);
+	if (ret)
+		goto err_init;
+
 	ret = iommu_copy_struct_to_user(user_data, &data,
 					IOMMU_VIOMMU_TYPE_AMD,
 					out_vfmmio_mmap_offset);
 	if (ret)
-		goto err_init;
+		goto err_init_one;
 
 	viommu->ops = &amd_viommu_ops;
 
@@ -110,6 +114,8 @@ int amd_iommufd_viommu_init(struct iommufd_viommu *viommu, struct iommu_domain *
 	spin_unlock_irqrestore(&pdom->lock, flags);
 
 	return 0;
+err_init_one:
+	amd_viommu_uninit_one(iommu, aviommu);
 err_init:
 	iommufd_viommu_destroy_mmap(&aviommu->core, aviommu->vfmmio_mmap_offset);
 err_mmap:
@@ -132,6 +138,7 @@ static void amd_iommufd_viommu_destroy(struct iommufd_viommu *viommu)
 	spin_unlock_irqrestore(&pdom->lock, flags);
 	xa_destroy(&aviommu->gdomid_array);
 	iommufd_viommu_destroy_mmap(&aviommu->core, aviommu->vfmmio_mmap_offset);
+	amd_viommu_uninit_one(iommu, aviommu);
 	amd_iommu_gid_free(iommu, aviommu->gid);
 }
 
diff --git a/drivers/iommu/amd/viommu.c b/drivers/iommu/amd/viommu.c
index d80f545c0648..b160c70f3804 100644
--- a/drivers/iommu/amd/viommu.c
+++ b/drivers/iommu/amd/viommu.c
@@ -19,6 +19,32 @@
 #include "amd_viommu.h"
 #include "../iommu-pages.h"
 
+/*
+ * Per-vIOMMU DevID / DomID tables share iommu->viommu_pdom:
+ *   IOVA = base + gid * entry_size, gid in [1, VIOMMU_MAX_GID].
+ * The 64GB gap between these bases is 0x10000 1MB DevID slots.
+ * VIOMMU_MAX_GID is 0x7FFF, so a max-gid DevID window ends at
+ * 0x1800000000 and cannot meet VIOMMU_DOMID_MAPPING_BASE.
+ *
+ * VIOMMU_MAX_GDEVID / VIOMMU_MAX_GDOMID are 16-bit guest DevID
+ * and DomID table indices (hardware mapping-table width), not GID.
+ */
+#define VIOMMU_MAX_GDEVID		0xFFFF
+#define VIOMMU_DEVID_MAPPING_BASE	0x1000000000ULL
+#define VIOMMU_DEVID_MAPPING_ENTRY_SIZE	(1 << 20)
+
+#define VIOMMU_MAX_GDOMID		0xFFFF
+#define VIOMMU_DOMID_MAPPING_BASE	0x2000000000ULL
+#define VIOMMU_DOMID_MAPPING_ENTRY_SIZE	(1 << 19)
+
+static_assert(VIOMMU_DEVID_MAPPING_BASE +
+	      (VIOMMU_MAX_GID + 1ULL) * VIOMMU_DEVID_MAPPING_ENTRY_SIZE <=
+	      VIOMMU_DOMID_MAPPING_BASE);
+static_assert(VIOMMU_DEVID_MAPPING_ENTRY_SIZE >=
+	      (VIOMMU_MAX_GDEVID + 1ULL) * sizeof(u64));
+static_assert(VIOMMU_DOMID_MAPPING_ENTRY_SIZE >=
+	      (VIOMMU_MAX_GDOMID + 1ULL) * sizeof(u64));
+
 static void __init amd_viommu_vf_vfcntl_unmap(struct amd_iommu *iommu)
 {
 	if (iommu->vfctrl_base) {
@@ -421,3 +447,41 @@ static void __maybe_unused free_private_vm_region(struct amd_iommu *iommu, u64 *
 
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
+	return ret;
+}
-- 
2.34.1

