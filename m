Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010057.outbound.protection.outlook.com [40.93.198.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E9B3876D7
	for <iommu@lists.linux.dev>; Mon, 14 Sep 2026 18:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789411797; cv=fail; b=uPW8+E8yAgPJwT0KVAUox4wNrWTOZA8JTIPk9y7xipeWiGROysluZD7nwG0JVFmN9CcewLSrsHg/tLtCLZTOofG6eRoe4gg9rO8Wqugi4qtxaS4lGlJCnXHiR8lL8WbqH1epqgoVn9kRHi6yugSHm3ZNfsuWNb9wq1NdUmIvxdc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789411797; c=relaxed/simple;
	bh=Wep0WN1PQT34DBB3wwnr+fX7MAZzFK8ChvhhrhIV6cw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=arTUjotDwSjJc2FiiVz0JYvO6I/oZzu+iJzFbHjI5aGDUjCPKVAhCKDnfoXoJB/xjsv9kOyzURASg/PiensgO9cDpJGCco8w6rrAbhd83L3xr61Ly9eFwFSrieRPu6dz48uuePmCUBH+QznnJ4FeI2fMk7PEFu7Z2/pkBcIM98c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HN76IM7/; arc=fail smtp.client-ip=40.93.198.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HN76IM7/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gfadn+z5oypMyrmPwcbziCSaOG6cDbhGbWaIE7wB93kpI20llsnuh4CS9sSz7J3k7t2fvMRC7a4G2MJLH1PM8m2YS07RPDz2e6kVHxJPpKP4sYl2Flle29aUAzG5exMzPEeE80e+9VU316Bfq3eqvCgBZBxnk35DsCn7td5AOYj9jqsoPhySZsj+SuHMsylvE8PR3Ftm9VQzzOBUt0aLk3wSj8lXs6lMj9X8D6n9w0Q3gigAX1sJM377FHqFUUOi+4G7XMZu/8fK2AwOPIFodgap47f6zdTA3zpruQjMdN0UX+Zhpn4DG2pqO32EfKkdCtplcktrYuOPPbFi5jC8dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jjdOnBxtL2aQdcodo0iQ5iE1RPP/y9FpkOyZW4aJvak=;
 b=KYrrRdq2CZU8IMITka8N/72rKo73RiewRpq+TWOjs+QfUdtxC+wvrTromdRbb5N2wb06+y9o9m77lOl/hktIzlfmI9YEJWRyspWiz1e0BabxQqHLQz+KNAli+9AV3bMvakYPiP470/oU+EG5D0SoD7XtY9bAgQ0sOF7kL04TdP/b3x2UoNxvhRtzqxhJLvgv7lA9XzNTL8YjSkzgNdZ5A1C62fsCdTdA9Mo6Mpoi8MrO6Kb+/mqCjdPSeJ32XkFB5tQ3sBcH9/n9q4UiSQs7McmQR+51ajF2YMTxjbnYKunAggKtPNnjAcQaa6T5WAwIV0tF0MTCLOU/DKkWsPR80w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jjdOnBxtL2aQdcodo0iQ5iE1RPP/y9FpkOyZW4aJvak=;
 b=HN76IM7/1R4QYthtX4+r1aJPadrdK/9++BKUgxjD+KDYi6QaSXuvPy29+zqndQQHZhSvRO96ZH06fJiXDv40tFA+f/mqpqo1JCo1K/HXjMgFms7zKcVYcWTdEMHUp/riI/fm+VPXofNCqvQ8Rpq+e6uy2MId/f4oJ6ws6sASTXs=
Received: from BN9PR03CA0946.namprd03.prod.outlook.com (2603:10b6:408:108::21)
 by PH0PR12MB8006.namprd12.prod.outlook.com (2603:10b6:510:28d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 18:49:48 +0000
Received: from BL02EPF00021F6E.namprd02.prod.outlook.com
 (2603:10b6:408:108:cafe::8) by BN9PR03CA0946.outlook.office365.com
 (2603:10b6:408:108::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.12 via Frontend Transport; Mon,
 14 Sep 2026 18:49:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F6E.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Mon, 14 Sep 2026 18:49:47 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 14 Sep
 2026 13:49:41 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>, <jgg@nvidia.com>
CC: <yi.l.liu@intel.com>, <kevin.tian@intel.com>, <nicolinc@nvidia.com>,
	<vasant.hegde@amd.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
	<Sairaj.K@amd.com>, <jay.chen@amd.com>, <Ming.Shu@amd.com>,
	<SooJin.Tan@amd.com>, <wvw@google.com>, <wnliu@google.com>,
	<dantuluris@google.com>, <chriscli@google.com>, <kpsingh@google.com>,
	<alejandro.j.jimenez@oracle.com>, <joao.m.martins@oracle.com>,
	<guanghuifeng@linux.alibaba.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>
Subject: [PATCH v5 15/24] iommu/amd: Add helper functions to manage DevID / DomID mapping tables
Date: Mon, 14 Sep 2026 18:47:41 +0000
Message-ID: <20260914184750.222939-16-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260914184750.222939-1-suravee.suthikulpanit@amd.com>
References: <20260914184750.222939-1-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6E:EE_|PH0PR12MB8006:EE_
X-MS-Office365-Filtering-Correlation-Id: 322acb3e-62d3-4a5e-449c-08df1290f356
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|23010399003|376014|36860700016|6133799003|18002099003|22082099003|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	3q8A/9k3kYI7c6IGwBEpo1HFLCvC7cFbJlgEZcm8yIEFbmfRtsa5oUR2bbRLSLtYsFvSwO+4UqM4j+tJjy9Eca6kBGe7/buW00XMoDlEZvb51ru4D/q71oL5gZXERBYqi/cTEg2LNjYBaSVYIuAiyzhirylEy3Ht/Nxs0SbfS+OMSizWbhkCbd/c4KcQkw1Phtz+z5n64ZNHTaoGc4xLwgaeNced4D5gM/KRPQK8Y1hRQ00lo/ACJj6jgQZXWlXjlyEMKDjAxMBkTPpYuRNAgTnK6hUB/mRFOwTjRqyH0Q9UZReNRrjkX9MuwdLrmJui4tq/G/5qBnoq+gSkijJ/uHZBMiGRnrCG1dTtXFXGj5w4djMtDt1JdK2kDP6eIZACnxCReQivH15mDchojzwtU9I1Sqp8Qy6MQu0ZqzCwtMUQJBY9wsJyeCbmVHCKuqcD3pgmBfET4rfBwl0eV/Z8ELG8NQRiCO1byPS76E6bwbBEZduX82YoAAq4vb4PsS5Cc+B80bd3Sste9WylGbDiz9LgUQrsmCBTJzPNRYIXksAVTi1HupCBDpfmSmqtJ6H6qkL0XyOgrpQVe54fvyJlGMGJfZn2J/XIR68obdZY1KiZoYkr6MGqZ1s0MM3xxOXNFskUkAAhGmWZnPUR6HgItIawDHfrg58dWO9NxoccUbKR25tehbVvMAyn7EPISJ9h+jXh4BszDI3Y5K0bekIqGg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(23010399003)(376014)(36860700016)(6133799003)(18002099003)(22082099003)(11063799006)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	kMkUdc2HrvbbzD8ZymGArjZguKIXCbBxtAr6x4zKcDfwBOCreNc0eKYQrs39zgXJ1yzTi28K9ipCzJ/F/ZTHMW5CjoRRTR3Qq5YWpfd1W8pnxoIb9MFei+UlBDzXK5NfbJGqCnJzF8lwqeh9sJ1DN7WQ0eS5jPL2/ewccywxfZmy5/EKORfYhReiQHAQpP9+Wu7ZxlSjoV6C4e61A3vqD0TAYeJnBCQ2XLSyDESrQ+4ZaoD0Se9B3AirUPrcz6YYN3smurZNgJStbP0hoIYAKp+YGAV+gqf2cIVMNg0XID5lkHlr5IufoeFVI4vGZGQ0k3QIIPy0YIlQTYcGD5eZidNqQgHOqwnfI3aOXZ9gtJyALWuR+HGgik7Q6XrQm4kcoNC56KreyjcXGkjGCohM8e1qRCI93FfE/ir3pFzvMqzLgKtq/Tmk/2S2BTa/aRlD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 18:49:47.6571
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 322acb3e-62d3-4a5e-449c-08df1290f356
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8006

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
index bcbd5af75d00..d620586d5734 100644
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
index ad5f754f25a4..06a21f14b2a5 100644
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
@@ -412,3 +438,41 @@ static void __maybe_unused free_private_vm_region(struct amd_iommu *iommu, u64 *
 
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

