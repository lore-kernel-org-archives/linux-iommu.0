Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011011.outbound.protection.outlook.com [40.93.194.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B9A3B27F8
	for <iommu@lists.linux.dev>; Mon, 30 Mar 2026 08:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774860230; cv=fail; b=bXBk8XBShgseFgP6NzceL18wkitbaer4s1LxDNKY4QWKEgpAtmeZPVO9A3ZQs3Xqibfjaah28OpxIAnuOvkRGt+2npUs01e2TDQLz2GpmUxu9EkF+HmIaHTi0UYeLkUBOWZH4hOk+vuIn61aYr34Ka0Kkusso0lf3B3pu6pJe1Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774860230; c=relaxed/simple;
	bh=N8HlPfqQ3/0c7f5Ovm+OqIxCZLlpqDT+SUrlGEjK3VU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fzcFQP72SI8DePvJii0vKaRWS54QLQqWcv4sJ52VX6bSwmHtPurAildjylJtLUEHJkNLdh0gFubH6Whb6b9bu4eASz7doSx7PMTJBxta8ZUT3GD1RpzgZlAHgdihTB1jEBXS04mU4JdEdPAw4dVvihapennrxmLdolVia9jjsuA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SWgQG3q9; arc=fail smtp.client-ip=40.93.194.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SWgQG3q9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PQsLvaY7yOI+e0v7IqFWfAJ5kprFpIjS++sCg94jlhy9CCRPNjKb0xDHk9dWLz6ggjW+YJPbisaICeoIcGJ/EFiM7MOaokCiBRr0iP4AdV/Qvbn1T5GxpJ3i2bYc82q/uK1qJ7hm+EcLioToNIrkeQ7yctCjyH6BddDbn3VlLKoh8uZYGWueBz1y10xUD+CLZEHa71BaFHkT7eYQ6EaWmEYhfCAlrf+e6WM8bQAKd8ujiWGhWaW+9AaFiQtLyyv5SvEgnEZxcYPciYj3+STSRqztm0ho5w5EcMlJ/+j5P1+ZaGIytU62DNiZUJtA8m39jCU1YgzzyJyljEylUOLm9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3UiVFokzylKjktagquR8L6h9Gm/nonmsqNyMK0mE0EM=;
 b=AM0/66ojfsATzgWlzNIJmQIh380ZBrhQJWwibmKMLVxfo5kjgAaWZeY4CVXGL1BjhQxYQ72unVKNF6r3RPX7rxj4TtkPTHYmbRNXKt35gFYriPGy0bKkk++b1af4rl9Td0FlRXLE1zLaDgp9vcwF046/QF+bXkzY0TBNmZ7/ohDVW+SyGldSFfyjJzYu517ip5Sm4QD22sc8vVK20R0UujtNW97a5gfhknKVJaLOQhcWZ9GBGn8Pwr1YvkSie18RdwtoaZFO76XYpL9oca3I3V3f734mgIAj8ansyIhL1LQFvbfvsnmxC3HbIC2+DNbyMCIBm7VuhrKQo/rYmwp5dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3UiVFokzylKjktagquR8L6h9Gm/nonmsqNyMK0mE0EM=;
 b=SWgQG3q9ocOoCb0WP2xrOuOYqWg0nVGEEUj0HejwfpCEUqlLzohuXn3IYhViFFQ+pZT9NLzc9Nw7CC/vLjI8jMD/z5M835xR93U96HWBSQeQNr/xJVbOXNuOFiRp9nPEYVUGJP1ftSppDkCk7Ctrik1KCa9Me8J5ByTfK5Jx+XY=
Received: from PH7PR13CA0012.namprd13.prod.outlook.com (2603:10b6:510:174::18)
 by SA1PR12MB8859.namprd12.prod.outlook.com (2603:10b6:806:37c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.8; Mon, 30 Mar
 2026 08:43:43 +0000
Received: from CY4PEPF0000E9D0.namprd03.prod.outlook.com
 (2603:10b6:510:174:cafe::91) by PH7PR13CA0012.outlook.office365.com
 (2603:10b6:510:174::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Mon,
 30 Mar 2026 08:43:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D0.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Mon, 30 Mar 2026 08:43:43 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 30 Mar
 2026 03:43:38 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>, <jgg@nvidia.com>
CC: <yi.l.liu@intel.com>, <kevin.tian@intel.com>, <nicolinc@nvidia.com>,
	<vasant.hegde@amd.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
	<sairaj.arunkodilkar@amd.com>, <jay.chen@amd.com>, <wvw@google.com>,
	<wnliu@google.com>, <dantuluris@google.com>, <chriscli@google.com>,
	<kpsingh@google.com>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH 13/22] iommu/amd: Add helper functions to manage DevID / DomID mapping tables
Date: Mon, 30 Mar 2026 08:41:57 +0000
Message-ID: <20260330084206.9251-14-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260330084206.9251-1-suravee.suthikulpanit@amd.com>
References: <20260330084206.9251-1-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D0:EE_|SA1PR12MB8859:EE_
X-MS-Office365-Filtering-Correlation-Id: e5bff740-4140-4fd5-1a66-08de8e38730e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700016|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	0gP1yy8yTsJWitj4Go02GK4mzH9x1++p2vgdhDZDbKuklWDv95D9QyDdb1aPOueJW5cCjxccuW5gHNnXm9NynKH45TzNmq9WzZbJ3gFmJbXqB6p2wfdmkR32klptcdckoq6kMduC466c8Xq3afPPSDvB2ZV/8xxSDZhJ+zSk9CxMPfEbXFIBwyYeiLWtt+2LPkidqlFjf4i2KU4KmjAzQ1kLnUllbFs9sdi7vtSH5YBLPx+krNQ8sPbdu/AJMb8Cbv8ODyMUtwqEG4vou+0voff6UlDmCokrk8gs9YENuY+ipQP+hVs6pEJUqnj4yniR60x+XF1xLbGOilJVJNXNbwzmcS+vQmUM6SuOjlA24c0kVeVwcXyd8hdjSIgMzKjgQjVy4qM6aF5gbs9wPmyIwlnUBdrZlPUr0bGKoOB93ewZVvpS6SLh4ueAZjUMf8xYP18t/DNyH8WxRCt1wI1Q1VVa83mD/Ucwe3GVV6Z1nlIX29rMGFaSmxs6+XI6PpcnzJpo8s031JTvHPIXa6urcb9Gmpm1XqIPY67/cMSngW8qftezjr3T81H8nRqnBXGeObsEALsiQ0X7VpEjXIMuFomAuCBjG+YnfAamQNuXRI/2/SV5mHSp/89fJlCwG5vbDfPKi9bq9DWQeYigDTb6nA588nXkQS6T3O4OCePfLfsinbatYJ+C/zVR0tyDlXov47gp9n/0oWG08dMONBZgcx8zU4T8rCs84Kqo8sbdbfo84S3zD6LSgHrY1JPuKDr9W3v4NghAYCernqZ6drv+zw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700016)(1800799024)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	3HqDzvXWBCuh+MkhfFhb9HZlRazcfDqLVNUchmH30vkP7y7tG4gJ9roe23XXbqiVUUOxxqAB2R2akvPv8jNImnttgjQbyWTvSpZNi/NeUTXhU3CEVmFX5HcCNR5M9xJ3O9LgKekCtRRHEttA3z4oyBHu1KP1npdoclkQBnQNzfntukMQac5sEut51GQT+uMahTKhjSMLhaXIhtBImpDTp+24IDbHVL8q7uMAVTVpdnr0G/m2BaKl4S/32phIkwdvRDMzYhKFY5O+4CNooZm2oGedSXizZOFWn86+IEfnMVLzCH+ad9hKC+vmM9Ygn7gEsiCoIUTZOVVjsibh3WoNgTjmMhIb36UvNEkQIwhBHGzJMzQnOgvDZztDWwkEbkbKbrpULbukLtxVabGfY3rtz7eSxLXCd64b7TjhmpSyCbiZW8z+J8eWk4H6EgZtm/68
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 08:43:43.1918
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5bff740-4140-4fd5-1a66-08de8e38730e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8859

Introduce amd_viommu_init_one() and amd_viommu_uninit_one().
These functions are called during IOMMUFD vIOMMU initialize and destroy.
Currently, it manages the IPA mapping for Device ID and Domain ID mapping
tables.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  3 ++
 drivers/iommu/amd/amd_viommu.h      | 15 +++++++++
 drivers/iommu/amd/iommu.c           |  1 +
 drivers/iommu/amd/iommufd.c         |  5 +++
 drivers/iommu/amd/viommu.c          | 52 +++++++++++++++++++++++++++++
 5 files changed, 76 insertions(+)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 2d96c72ba45f..fda7109766f3 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -543,6 +543,9 @@ struct amd_iommu_viommu {
 	 * Indexed by guest domain ID.
 	 */
 	struct xarray gdomid_array;
+
+	u64 *devid_table;
+	u64 *domid_table;
 };
 
 /*
diff --git a/drivers/iommu/amd/amd_viommu.h b/drivers/iommu/amd/amd_viommu.h
index 8dbb12241e8d..ccdd1cbcec36 100644
--- a/drivers/iommu/amd/amd_viommu.h
+++ b/drivers/iommu/amd/amd_viommu.h
@@ -11,6 +11,11 @@
 int amd_viommu_init(struct amd_iommu *iommu);
 
 u64 amd_viommu_get_vfmmio_addr(struct amd_iommu *iommu, u16 gid);
+
+int amd_viommu_init_one(struct amd_iommu *iommu, struct amd_iommu_viommu *viommu);
+
+void amd_viommu_uninit_one(struct amd_iommu *iommu, struct amd_iommu_viommu *viommu);
+
 #else
 
 static inline int amd_viommu_init(struct amd_iommu *iommu)
@@ -22,6 +27,16 @@ u64 amd_viommu_get_vfmmio_addr(struct amd_iommu *iommu, u16 gid);
 {
 	return 0;
 }
+
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
index 4be3589b9393..8d8f4f374d5f 100644
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
index 06d6aa87cdcd..c2281557b3bf 100644
--- a/drivers/iommu/amd/iommufd.c
+++ b/drivers/iommu/amd/iommufd.c
@@ -82,6 +82,10 @@ int amd_iommufd_viommu_init(struct iommufd_viommu *viommu, struct iommu_domain *
 	/* Reset vIOMMU MMIOs to initialize the vIOMMU */
 	iommu_reset_vmmio(iommu, aviommu->gid);
 
+	ret = amd_viommu_init_one(iommu, aviommu);
+	if (ret)
+		goto err_out;
+
 	ret = iommu_copy_struct_to_user(user_data, &data,
 					IOMMU_VIOMMU_TYPE_AMD,
 					reserved);
@@ -116,6 +120,7 @@ static void amd_iommufd_viommu_destroy(struct iommufd_viommu *viommu)
 	spin_unlock_irqrestore(&pdom->lock, flags);
 	xa_destroy(&aviommu->gdomid_array);
 	amd_iommu_gid_free(aviommu->gid);
+	amd_viommu_uninit_one(iommu, aviommu);
 }
 
 /*
diff --git a/drivers/iommu/amd/viommu.c b/drivers/iommu/amd/viommu.c
index fbc6b37b2517..53cf6ab2db04 100644
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
@@ -335,3 +349,41 @@ static void free_private_vm_region(struct amd_iommu *iommu, u64 **entry,
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

