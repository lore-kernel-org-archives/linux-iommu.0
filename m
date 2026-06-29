Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013020.outbound.protection.outlook.com [40.93.201.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3604A40DFB6
	for <iommu@lists.linux.dev>; Mon, 29 Jun 2026 15:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782747746; cv=fail; b=YWllk0FL1DTUxnAuvfdsw7irhBWa+SJA7b8nWpmG55m24m1atZQ+GjGnTq7pj/qSm+xhoIBYDap3w4/ucvf8SlNewfjD99aARqLpTPPQvXoaTsylaEi80aalcdKAd6xgEQbEqojDcZ9sZn4OTj5f52ktyX3ww4GTn2UBCW6/4Sg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782747746; c=relaxed/simple;
	bh=vFPKlE+9L9P0omEq7D/uZ8j2wZND5mXw/zfZPrO4u4k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MdZa9aYRLLTN1ZrMV0mh9l2s9ai/hxaj0w6tLiba6mv0dFNqZPKVFuci5J2astB8hxNbGbaerV948jfaYa6kFjwEh/1YzyRki/LHs3qYokNVNyGbjthHtYPoYM/cZ3+zvxtANFMaauZ07wCA0Dt6RmAKjB79TnCNNZNLCXZuW24=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mdDZXTdU; arc=fail smtp.client-ip=40.93.201.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mdDZXTdU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zFz8pWlDQS50qmlrOjBlJcoXocJmRZOfylWc6OQPxwjwNjDe0VKP9jHruSpV/rhFUHyxRMo4Io7pVZawXx9TDZOkJC4PVEHM6LbhWSVHAWbjizKGenR5C2yMxte/y8Ix9htSCGpzVqcTw1PvjEcKTdOqmGW9U1zoPxElO3LoeEBggap0rXygGFRPffni9+RvqrF3XkKzrpHual3kdkYLRrR3YMgI4g61YrrKqy7qXWG8nVTg1Rd0GWmtN7cQQ0EahiTlQXt+SuOZgm4BXpmTDRijFUnkmg4yXucTPnKlWGjkgnr0vmZabz0RnpjbR6Zg2EjPlkZGbIj2IzmSTuJDLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IPK/yi9wqk8bKkdNhS+etwdln5RMPB8kk1Zpkvu8GjA=;
 b=vxmPAJigu3NGkHdRemH2XMRqXoS3KvDNQgv7TwW+/0T+8rhDZuYSMz1J1grgjjo7b6RXTkRbx6o9pZvhY5WDINNkJLR9pb4yaRyP4Pmplw+u75SRe3hfGaJfcojqWBoA3YZ3AAqXDFeZ2MJ0n9S22qJ+Y22qtPpppGVL2pfAFjS88sW/GYk8g1xrE76mA20OivdldTcnttGxt9m9mhPALhAIZWNqqPQLpbvnsup1TEln1SLknJ0TxJA8wH/XsjS2CfB7YxR7xpB3Kgdh3PvkS7b7ASkvCtimayc6c+ssnIC3Kk04NXoqSO5cWSlhzANdZZ+XpFOLCrNx2o9a0rL4GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IPK/yi9wqk8bKkdNhS+etwdln5RMPB8kk1Zpkvu8GjA=;
 b=mdDZXTdUBfvM4JIIS92/WOPg4mAQn+IvaCuBz+Qg4QHv3kai1rSCeCCaDxBqlBDrSk/e3og1NtY2pWUauRgvIyblUjv2oSVYOFWCNIjG8QxtoZ6E1/UTDvrGoeBqJTpfJ2vJ4i4WvVp3vTxah0xxVJ4wkILp3X0WI1VAoh+57OA=
Received: from BN0PR04CA0191.namprd04.prod.outlook.com (2603:10b6:408:e9::16)
 by SN7PR12MB7788.namprd12.prod.outlook.com (2603:10b6:806:345::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.15; Mon, 29 Jun
 2026 15:42:09 +0000
Received: from BN2PEPF000055DF.namprd21.prod.outlook.com
 (2603:10b6:408:e9:cafe::47) by BN0PR04CA0191.outlook.office365.com
 (2603:10b6:408:e9::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Mon,
 29 Jun 2026 15:42:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF000055DF.mail.protection.outlook.com (10.167.245.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.202.0 via Frontend Transport; Mon, 29 Jun 2026 15:42:09 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 29 Jun
 2026 10:41:57 -0500
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 29 Jun
 2026 08:37:03 -0700
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>, <jgg@nvidia.com>
CC: <yi.l.liu@intel.com>, <kevin.tian@intel.com>, <nicolinc@nvidia.com>,
	<vasant.hegde@amd.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
	<sairaj.arunkodilkar@amd.com>, <jay.chen@amd.com>, <wvw@google.com>,
	<wnliu@google.com>, <dantuluris@google.com>, <chriscli@google.com>,
	<kpsingh@google.com>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v3 15/22] iommu/amd: Add helper functions to manage DevID / DomID mapping tables
Date: Mon, 29 Jun 2026 15:35:28 +0000
Message-ID: <20260629153535.15775-16-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DF:EE_|SN7PR12MB7788:EE_
X-MS-Office365-Filtering-Correlation-Id: 896dc719-c207-4301-0948-08ded5f4fb3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|376014|7416014|23010399003|82310400026|6133799003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	yPhOniVlU7dFcMCG/LBHKY92g3yTtG8qfQ9AdHJRWYM5+q2FSq9ufInWGGeeBqE653C17dcE4TulmqWTfikvGrFk4ab/NUeXZ+NreesJlw3IYFxYVycDxjq6ml7BKv8LLm9KeoJR1EFZErhHWCeye17kvmrWAypArasTsXJ5aShlzWy0ZyGy/BVC6HpmcjSePU1GEf/KkXSVtY2I2fg3xcHk69M1yZfkqJag0EADiGyFnJR3ijb/iT42Z4YIYFRUpP3v23GOb1Rc5rCRi815b/xrliPDUQPZkVVJJq+PC8X0eYbAeFd8fdyfgVd2Aj2Wjrro+y9GBC0zqPFUT53l6L5VQJgnm1o3afeE38E/LbHBlwZUCqjHzf9j/NynFtv3pJ+pV0OVZjDS7zQ395Y+OCdj3K/re6YheZZgDfKaPHltDZmQFIFRY8I9x31cVbmOPnbEVVQ+o5uwwKZqP8YqR9yd5wZhyxzCgdGgG4ZmM15H2ZMNX5x4PJ77C1h2nQzsCAUQ8bWQpHZrydZsPXaVa7OhQSpAnQir/KIYmpsXsDk/R2ZEEil3PRtrKenMessgHsS7Rj+A+wsn9TmDNPHMU4MWqBS74oP/8W4Hg6jChEHhVra8yacmw4K+wY/HBZg6GlNeETmlfahEbL5WRo0C9Dyd6YOZdSVHfyqX4b5DedR0/wdPXHgRgzJEV5/I/OROJV8fUiWuBGBOoEQ55Ii0+Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(376014)(7416014)(23010399003)(82310400026)(6133799003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	uaBRXeQFIqaDLUz1DVTtELZH8MWK9pfERyC1r3WcM/LRQkeA/7Rqe+ErLgTgU9CmL2V63UTF5v5y9NS00tmJZRYXJ1YVzyKGeH909My2nu2YEUMmQ3gMCBzYtjwY5fnZKa1U5oU13OWvWFcNKEP/HtkRPm46DrM0Yjp5AT4cknbX+vsvl+7QcKowhqRQ/PCXUGRwySf3T2+nlsaf///UilAubDcoHnOtGNYFOEgzlp0DdknBO68NIzqT1DZMY6Rv+KAtwe5Ua+LdWc3gTBno+IdAOLcyDjNkgpuGbv5hzkY2jiU5ERIrmT4MVNk1E4pENOPYldVD0ZOfvh06Q5JkM1Poa25MGmMtd/wFFBO89QIi7zemVO1Rhp24Ziw944DkwRQvqJhJfGn/2KuHd0IokUPaQ62pmWGiztTblI0YaHmND2wYFtMXloTgpDUnawnF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 15:42:09.6459
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 896dc719-c207-4301-0948-08ded5f4fb3b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DF.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7788

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
index 340929ae776a..03346258e2dc 100644
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
index e5dc34959c6e..3b59938c2f86 100644
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
index 81e0244348a2..bfc4b0ec22a9 100644
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
 					out_vfmmio_mmap_offset);
@@ -118,6 +122,7 @@ static void amd_iommufd_viommu_destroy(struct iommufd_viommu *viommu)
 	spin_unlock_irqrestore(&pdom->lock, flags);
 	xa_destroy(&aviommu->gdomid_array);
 	iommufd_viommu_destroy_mmap(&aviommu->core, aviommu->vfmmio_mmap_offset);
+	amd_viommu_uninit_one(iommu, aviommu);
 	amd_iommu_gid_free(iommu, aviommu->gid);
 }
 
diff --git a/drivers/iommu/amd/viommu.c b/drivers/iommu/amd/viommu.c
index 808f0b304006..27b17edb910e 100644
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
@@ -412,3 +426,41 @@ static void __maybe_unused free_private_vm_region(struct amd_iommu *iommu, u64 *
 
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

