Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010042.outbound.protection.outlook.com [52.101.56.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FFDE2C158A
	for <iommu@lists.linux.dev>; Mon, 27 Jul 2026 13:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785159109; cv=fail; b=mwJhUHS5s/rFAtOLM1i7BRJkAtetv7I3/lQCBXYBkKrSWl81o+y9iBtEHDxy7QeDyLumVIL7AeHrG7i8lUtDqp8GClJ6woIetgpBR5TjChwWgxLmYxc+z0ghwpXE0qIStZBOzNHRIqh26hJA5xjHlhLF4UnytWYmNQP7JeJuJZc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785159109; c=relaxed/simple;
	bh=BZRfOZ9x0DH1SsIDpN79laSOf2Q3ksTxwyhfSMIrK+Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qeBGydsn74cDk2tT/y0hj/LWQBhRVbi7J52TqzIq5vM5go6FBjF0m6Mh5Vt8t2y+0s8FxrybqZ5N2ehEUVl9JxSc946wXiaGkXcBPdclEdc3OtTAYFV+wGo2xQEaMpMPfzXSwzr9+1SOUz1EIxBfjOdcVT6JJj+ZZORIY1nMZHo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=34nyPmzU; arc=fail smtp.client-ip=52.101.56.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="34nyPmzU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y2+PvsUYyU9WvcufcY6/fZTc1Q2bH+0wWa1fj3ZKXj1ViWZXGRPp5cJigGKlhVcyOyLxudH3retUpWFqw1tCTuKCyT2nLuiRRYI8SKghsrxphkrga+Xw837r7suuxwLhwEW8jAblYNPm4SrW1oT1aTHyUXmxdm13PK8jbuf6MoaHy7bEs6A6wvBxoTn4M7oy/B30gcYCMKvVyJojYEq8NQsi5mTUnTIjxqEtN8mK8m0oi1tc3+qh7WmDQG+wjWfyVN45xcdE2t7mF8X3bfid1HmzWhJsGeUOlV2t7/zO4vlmTwJ486gYXvqV+ITTUapAW5NFdo1Ht+I7DSVdncvUOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IKCTPsJ/qHleuAdy80rKiSgjYbK4ELziYmh/MdUXWTw=;
 b=EESM2vQeL3DNU14EJ9numWG9IgZ0lqTZT0Lamh4xLYQqczAb4zOMCfgwv+tsdnim2s3cypytwBthETQmvKspVSKqQcAgMSGE8vjM8OEewDPNlju8GK9KZ1e/f9DhZoxpaYWUOVi2snH3cxnD0vcxrrgrnwS3W5PK8Gqn77vSKGVMcgBoZDQ+PcX6tKoGwf8UHv6eLwy5+PtV/LLMVvqN+LPSn5zCMcpDITXjK6D5yt0nMrRgdj2tJSzmUzYUQeyQ+jNLkvnC3lU87FLlj6Nc8dJDuDiUxDu4BUUxk7kob2gohdgpxmIOzwuwOhhFvLiZ0oEcfUDt4dgysEqRewmUUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IKCTPsJ/qHleuAdy80rKiSgjYbK4ELziYmh/MdUXWTw=;
 b=34nyPmzUTuyVSI2ctWu+NfnMAHhslCJO0sX22bXvgzFU9UnjcvxCWH18h67+kQ9He7ONFCqeot7mVi4iGAELroNntNT0aEpOZuCv6igViCoX7d8qgxQeWByvwGr3h8MKNI7Yy1r4EmWhlB+AFFrQZflXHXXcnXz4/SOOI837Rxk=
Received: from PH7P223CA0007.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:338::8)
 by SA1PR12MB5658.namprd12.prod.outlook.com (2603:10b6:806:235::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 13:31:39 +0000
Received: from SN1PEPF000397B0.namprd05.prod.outlook.com
 (2603:10b6:510:338:cafe::35) by PH7P223CA0007.outlook.office365.com
 (2603:10b6:510:338::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.13 via Frontend Transport; Mon,
 27 Jul 2026 13:31:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B0.mail.protection.outlook.com (10.167.248.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Mon, 27 Jul 2026 13:31:38 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 27 Jul
 2026 08:31:21 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>, <jgg@nvidia.com>
CC: <yi.l.liu@intel.com>, <kevin.tian@intel.com>, <nicolinc@nvidia.com>,
	<vasant.hegde@amd.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
	<Sairaj.K@amd.com>, <jay.chen@amd.com>, <wvw@google.com>, <wnliu@google.com>,
	<dantuluris@google.com>, <chriscli@google.com>, <kpsingh@google.com>,
	<alejandro.j.jimenez@oracle.com>, <joao.m.martins@oracle.com>, "Suravee
 Suthikulpanit" <suravee.suthikulpanit@amd.com>
Subject: [PATCH 15/24] iommu/amd: Add helper functions to manage DevID / DomID mapping tables
Date: Mon, 27 Jul 2026 13:29:04 +0000
Message-ID: <20260727132913.22475-16-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B0:EE_|SA1PR12MB5658:EE_
X-MS-Office365-Filtering-Correlation-Id: f5c59243-9b9c-4068-a873-08deebe3634a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|23010399003|376014|7416014|1800799024|6133799003|10067099003|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	kWSol6FyqI12Oo/8WNy+PTKyqF8nrXIs5gVcdLv4CjHJd5L8Q1HJ67FsPRxr5oV2UG3Qz8HTRN1KrqExpAtYIojVe4dw6GBGV1r0KWqhVC8Gj5NnNLikRTMmXLgbNlHfAy854YhiWITFUj4o8Sjtv5rJOsBbCc+mYsJD8g4IDVohUBDNVMHApEiFhQIBwmGvG2CfHbyG4zfvG6P4rGLwSYJ4/v65F4Aqu087d3LnLI3uwpy+ErHMukk9eopMxzLa6XUQCkEcoQrqECuDTX6VJ6npJN8eJezf33Qtx2n8qwL8epV7qev8EQBfYxEACk4eIPkG9hc4HJ2BHB/RkjoCmi+eeVUIEy2iJSMiGP0JILGKcR02YniR4Wo2Of3AgAregT7Je/Q1QcsplgTrICerH0s9hKub2BVSooRwyOHiZ/Q19trKUjz0GLYwQ9vKM+BrIKCh1K4GW6f2BH6r1qTLXV+ORb6JyaLQ/qcQNlS50pxw0M5+p+XXa6bnf7IZi0vzd/hC5lQwijPvEhQnxxcSNQ1Eefmd8zJSqKW7iRhcfFta7k/On1Wb2jrkTejNIenYTGrigTskxNLxVb1eoqDBxQQLzAXjx/FMsijanfFC6Qf7ofeNwaIJU1ASW8MHzvZm7+XarsM1MsVekhVcfWm39+MNZ7LsOWB7UYfYHJjNzuqzP7S4yw99M7GAiyjiMCVaS3fr65EXmoGnCPakBlAo2w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(7416014)(1800799024)(6133799003)(10067099003)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	xGs1c/44GSyjG/lJJjQ28NWIqdbSQWhYdao/92PX6QaAmCMb0DtiJtuQWnygCyxWlwlFkJIhe+zZK+TUW2pROBtwtHmIiW1871g53MLBWz5buFHmZyotdMnRTqB0OefAATZpXBbkWOHplu5Vlg4W8NDqZDof4vZ1ziKkcndsFxo9gFW05YI+iGL2GcK++k0rDOmSz/zx/+hepEQoUMzl2in71nP2xPnN7WgrZQykLND9A3RXrPBCa0UHPURxSsONOOsyPXauEN/GuNpQfJAtF0FbMipKfRaSgb9VUwLtir+UphUv4F/qHOCsj2nqxKF15lV/UegZrHO0OCw1NBLXljc7GqmRz7B7xW5O3AHp0YtVBZk/OWimwQP+zA1aoRY4w24sLTwrqo6GYEuBvhbDPdR//Bm3lETNgbd84W97QhtFm27ZfQELnYH4YVBBLgPa
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 13:31:38.8788
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5c59243-9b9c-4068-a873-08deebe3634a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5658

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
index 79698eec21dc..6895629cc8a5 100644
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
index 2c1a267826dc..91d0dd3ac912 100644
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
@@ -405,3 +419,41 @@ static void __maybe_unused free_private_vm_region(struct amd_iommu *iommu, u64 *
 
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

