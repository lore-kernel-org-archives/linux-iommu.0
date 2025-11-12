Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012067.outbound.protection.outlook.com [40.93.195.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9654E358D09
	for <iommu@lists.linux.dev>; Wed, 12 Nov 2025 18:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762971989; cv=fail; b=YL2XupagOWV3LNB5Kx9hUhotNco8gvbYzSZnNqQuo0JEKAzqS8VbjQ78KmYXPQmnfw5W5YD+w4oqCAM+xmPN5lqZehy8tVVfGk98owUb6bCqBRahkhIos+YncUJN3qULHYnKQOGXiMwm0zoI1opjNQzVo+tQNho30zuGxhZiywc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762971989; c=relaxed/simple;
	bh=uWPCyUilgD4TrlmDm4kG33cJskt7j7mmg8QB3AxtLvo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=khyjBrXvEG+T+DJn67oWPfvo12Gcp530U5TfS6PMUxZaBDoh3AbA84grB98beyBmzpxWVcd/0baSaxFexO+MoDFFGuro/lOX/u4qeY5AugyKuR4WSaymyHtZ6X/w2gpgEgknEI0uFACFvSkACtSgQcuJCmgW+1WCuxAwUPIASP8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TMiX4OuA; arc=fail smtp.client-ip=40.93.195.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TMiX4OuA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D47oEH7Eu4r91JAZ/utkTMUn+pFLH10dhhh+N7xs2UUunhyGxnRSplI8P/cGT/CeF/4JTpePwLy8HH7sOv9LfUHHvMLqxE6QQM03ppVUYmOm6daxDmhug0C/8oHwBRg3cqrfBizbreGR6Y0qc6lVt34oDn53z2NIyq20hMgBiYbYHpL2ouSSp7nuM/y+uWugCeqv664Zb0cWdsbiPUd1MC4GsatHyKrPBqQopYJFb0hZtg8QmLPY97ojmOx0hfyd+Fvz5tDamR36dduoGw8zJRw0jM+RUwWsl9us6FqdSeNkUPCE923ljLLrOTGhHZ+ehWN5wQTY7HRGKxmlxhCBoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rdpq30fAEWQr9AZoNhaQurZ1m4IOAATur56wRwTaCp0=;
 b=LkgRkpPx6hv5+ymunL90YjlyEVoBsVmBD1Zthrr/P9KjxaP5jngnWPjiSKMiEgtEkqHrngOsAFElAs8z8ymnSkvpJd4qrJHaAbcfBeCGgjngBb506ViAzUg8FSDq0svBL9W3m0sONIhIcsNPZ12foJd1xoB1Jqy4dWrR10g8ln3dHEG8efP+DSHl8lLmovVyFVsYAqBtBqxu53XijMMBIhW3kdHbJeArkiMxWmj60lyYotzmr64AiqkoUnr/A9+VlDwN6W9gkFwkBoa+tsdPSTzC/GOBR2Gd4uDvL26xzZgNOjqBy0E1URVh3jEHaeTZN9kWLQ0x6YCsMUmKKFc/yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rdpq30fAEWQr9AZoNhaQurZ1m4IOAATur56wRwTaCp0=;
 b=TMiX4OuAgJmopRDoW3oRAGTFVNcBuhVLg9fg6u1nJBnOuchhSV/ZEyU2fTuh5B993uZT+cloGTfl8cRlmqPOcXyCohXjM2Ar6LLQgfNHVl9CjXule5NFp2BBbzWL0yG05KeQZdsKbjULyU2Yr2ZsZqbYVITHa8wGcxzvCjsOaCQ=
Received: from BL1PR13CA0092.namprd13.prod.outlook.com (2603:10b6:208:2b9::7)
 by IA1PR12MB7495.namprd12.prod.outlook.com (2603:10b6:208:419::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Wed, 12 Nov
 2025 18:26:23 +0000
Received: from BL6PEPF0001AB55.namprd02.prod.outlook.com
 (2603:10b6:208:2b9:cafe::83) by BL1PR13CA0092.outlook.office365.com
 (2603:10b6:208:2b9::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.16 via Frontend Transport; Wed,
 12 Nov 2025 18:25:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB55.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 18:26:23 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 12 Nov
 2025 10:26:17 -0800
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <jgg@nvidia.com>, <nicolinc@nvidia.com>
CC: <linux-kernel@vger.kernel.org>, <robin.murphy@arm.com>, <will@kernel.org>,
	<joro@8bytes.org>, <kevin.tian@intel.com>, <jsnitsel@redhat.com>,
	<vasant.hegde@amd.com>, <iommu@lists.linux.dev>, <santosh.shukla@amd.com>,
	<sairaj.arunkodilkar@amd.com>, <jon.grimm@amd.com>,
	<prashanthpra@google.com>, <wvw@google.com>, <wnliu@google.com>,
	<gptran@google.com>, <kpsingh@google.com>, <joao.m.martins@oracle.com>,
	<alejandro.j.jimenez@oracle.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>
Subject: [PATCH v5 10/14] iommu/amd: Add support for nested domain allocation
Date: Wed, 12 Nov 2025 18:25:02 +0000
Message-ID: <20251112182506.7165-11-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251112182506.7165-1-suravee.suthikulpanit@amd.com>
References: <20251112182506.7165-1-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB55:EE_|IA1PR12MB7495:EE_
X-MS-Office365-Filtering-Correlation-Id: 3be61e93-4d3e-46de-7d28-08de2218fbbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|82310400026|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cXkVq3e1XSi2x8gScDb2UucAuomNRYxRltrDFYPyZN700wBZVALwql22lCdE?=
 =?us-ascii?Q?V/+m9/8ZirePUfILr+GruxwjnnEA7I0pog0rwvVX21caF63lKtBVITGg2ac4?=
 =?us-ascii?Q?MK8CW46OYTQXkVIqZbqh4ztObOAElnc1iUXAkRxpJmvONr5mXUz/yljmUx7a?=
 =?us-ascii?Q?Bs9NgR45JJgQAKwIzKlwKojOrawMudrF0P2QKmIo5SS92vvdrl0ZlRi8C9e3?=
 =?us-ascii?Q?QJvdTmqUpBnaN2uq344dg/fAFItcYsmCN3mCHhqDuc0NFdUgRemQQl39VY8k?=
 =?us-ascii?Q?SKWM5vgQjv83KbtF0Jjen1EkutIhF9ypdFmZxywwK7FfKX9ZBeUzuBmvdGBS?=
 =?us-ascii?Q?4diRzLNhJtYsyMHGpvmIfPV4AZbrUX5TJ8rthDM2qhwHjAQNsP0RGUxShj9L?=
 =?us-ascii?Q?OILzCoLBEeSxmZwCCsDXge7LvSi0Uzrxi04QbpalygBc+kqtglfJ/hZ/eoIB?=
 =?us-ascii?Q?Spasq6Go9XIMBeIRXxpGbawJlUUNHtRDEsTlX8ejRLaMxnw9yeVhWGkLLLXW?=
 =?us-ascii?Q?ELPrXsWUoBUTv1/vvMugtqZQX2LpZHBQHDSSfQMw2sfehrG99BZLi3jZsuIa?=
 =?us-ascii?Q?LMWHVtBgJnPoe2uV5fTzAU3FN+6olYdPfhau/WkiA3wHgkT16DuHRD7xL1Yg?=
 =?us-ascii?Q?9QogeIdkUHsA2RZDdFNB8nMx5qPqBcGTaCuriKvWpY9UYsxfen8cfdEQb9RF?=
 =?us-ascii?Q?F+gPTOvSpJ1N7BGDzjZesWix0fhgLxx3YBi501Q4lKcm7TtFqJmG7VTkWB5e?=
 =?us-ascii?Q?r8sK6yn2i4psEaLb9Yxgbt49pMSxcg4yHWh0r+6dPRYmAAFflSH85+o/dgHG?=
 =?us-ascii?Q?pT+AEHniOGbdsKt8NiCyBAsFJhNxX3A2v0ahvRXMrWBc9TBNc8g+3HRhyUUU?=
 =?us-ascii?Q?/NFBpTUOW8KAQnJA63arOC5mr7OGRtI1EdVHuBcfi19N83d5JAJG+FW8bFbk?=
 =?us-ascii?Q?tXEoK02+q0khxuiLvfnwWstJIM8NOGm4J0MSHMf1LjZcLRJe1Qwt8l0k9Hz9?=
 =?us-ascii?Q?w1PcShBOxW6CiniJX9ESGqv5hTgOiMuQ3reelQhbAcXb/tBrveHCZoa/+X7p?=
 =?us-ascii?Q?Y1/3mvmdlE4hkCC+cPrEmNWKA6Ngpt3cg0PrQQDbQb3sqWAio26SWwutlMTb?=
 =?us-ascii?Q?7Z/bnbsbXf4/MHJx5RdVwPK0vdR8rRsOr/3DoQc0plp2gqwIivtKnjz2zwcV?=
 =?us-ascii?Q?sHmmvOtgXkPKDM8FVHXWFYFP/Ukbu0qHbdDK+vuFUsIMq3g0b38Dx608Tlqj?=
 =?us-ascii?Q?8OJVGH6gFaxmSCBrSfDVAuy2ap9p1WaKnaWeiK48BnyfkB3D/g7rJSNzNGu2?=
 =?us-ascii?Q?+9qF/x7XZ8NEJnu+73volUWLmVNzpxocIYN2yLwpHyjv1hyGJfq2+zT+VKpq?=
 =?us-ascii?Q?/mKNlGgARQjG4Vq2fnobN6MTCGShGvpwG/3+L81sQj/0o6Y47FxU4I3I1/7V?=
 =?us-ascii?Q?j9eIU/2FoF/gTEvuXe49HLuCoVe8Kz19vwpyedgCY/9Q/QdO/5tHDbnZ/ND2?=
 =?us-ascii?Q?xAED+FHmxty1EhM72P3oTVVqGruAFZlVUivBEjO9c72YXdcNhupjyB7b0M/P?=
 =?us-ascii?Q?b6Lb1jpGwYcM4pUez1w=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(82310400026)(376014)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 18:26:23.0734
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3be61e93-4d3e-46de-7d28-08de2218fbbc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB55.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7495

The nested domain is allocated with IOMMU_DOMAIN_NESTED type to store
stage-1 translation (i.e. GVA->GPA). This includes the GCR3 root pointer
table along with guest page tables. The struct iommu_hwpt_amd_guest
contains this information, and is passed from user-space as a parameter
of the struct iommu_ops.domain_alloc_nested().

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/Makefile          |   2 +-
 drivers/iommu/amd/amd_iommu.h       |   4 +
 drivers/iommu/amd/amd_iommu_types.h |  14 ++++
 drivers/iommu/amd/nested.c          | 110 ++++++++++++++++++++++++++++
 4 files changed, 129 insertions(+), 1 deletion(-)
 create mode 100644 drivers/iommu/amd/nested.c

diff --git a/drivers/iommu/amd/Makefile b/drivers/iommu/amd/Makefile
index 41f053b49dce..94b8ef2acb18 100644
--- a/drivers/iommu/amd/Makefile
+++ b/drivers/iommu/amd/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-y += iommu.o init.o quirks.o ppr.o pasid.o
-obj-$(CONFIG_AMD_IOMMU_IOMMUFD) += iommufd.o
+obj-$(CONFIG_AMD_IOMMU_IOMMUFD) += iommufd.o nested.o
 obj-$(CONFIG_AMD_IOMMU_DEBUGFS) += debugfs.o
diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 3ad8b5e65a82..57f9f4fb8a4b 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -199,4 +199,8 @@ amd_iommu_make_clear_dte(struct iommu_dev_data *dev_data, struct dev_table_entry
 	new->data128[1] = 0;
 }
 
+/* NESTED */
+struct iommu_domain *
+amd_iommu_alloc_domain_nested(struct iommufd_viommu *viommu, u32 flags,
+			      const struct iommu_user_data *user_data);
 #endif /* AMD_IOMMU_H */
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 446be08c88c8..e46f346fd6c5 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -21,6 +21,8 @@
 #include <linux/irqreturn.h>
 #include <linux/generic_pt/iommu.h>
 
+#include <uapi/linux/iommufd.h>
+
 /*
  * Maximum number of IOMMUs supported
  */
@@ -348,6 +350,8 @@
 #define DTE_FLAG_V	BIT_ULL(0)
 #define DTE_FLAG_TV	BIT_ULL(1)
 #define DTE_FLAG_HAD	(3ULL << 7)
+#define DTE_MODE_MASK	GENMASK_ULL(11, 9)
+#define DTE_HOST_TRP	GENMASK_ULL(51, 12)
 #define DTE_FLAG_GIOV	BIT_ULL(54)
 #define DTE_FLAG_GV	BIT_ULL(55)
 #define DTE_GLX		GENMASK_ULL(57, 56)
@@ -496,6 +500,16 @@ struct amd_iommu_viommu {
 	struct protection_domain *parent; /* nest parent domain for this viommu */
 };
 
+/*
+ * Nested domain is specifically used for nested translation
+ */
+struct nested_domain {
+	struct iommu_domain domain; /* generic domain handle used by iommu core code */
+	u16 gdom_id;                /* domain ID from gDTE */
+	struct iommu_hwpt_amd_guest gdte; /* Guest vIOMMU DTE */
+	struct amd_iommu_viommu *viommu;  /* AMD hw-viommu this nested domain belong to */
+};
+
 /*
  * This structure contains generic data for  IOMMU protection domains
  * independent of their use.
diff --git a/drivers/iommu/amd/nested.c b/drivers/iommu/amd/nested.c
new file mode 100644
index 000000000000..dd3e53dd16ea
--- /dev/null
+++ b/drivers/iommu/amd/nested.c
@@ -0,0 +1,110 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2025 Advanced Micro Devices, Inc.
+ */
+
+#define dev_fmt(fmt)	"AMD-Vi: " fmt
+
+#include <linux/iommu.h>
+#include <uapi/linux/iommufd.h>
+
+#include "amd_iommu.h"
+
+static const struct iommu_domain_ops nested_domain_ops;
+
+static inline struct nested_domain *to_ndomain(struct iommu_domain *dom)
+{
+	return container_of(dom, struct nested_domain, domain);
+}
+
+/*
+ * Validate guest DTE to make sure that configuration for host (v1)
+ * and guest (v2) page tables are valid when allocating nested domain.
+ */
+static int validate_gdte_nested(struct iommu_hwpt_amd_guest *gdte)
+{
+	u32 gpt_level = FIELD_GET(DTE_GPT_LEVEL_MASK, gdte->dte[2]);
+
+	/* Must be zero: Mode, Host-TPR */
+	if (FIELD_GET(DTE_MODE_MASK, gdte->dte[0]) != 0 ||
+	    FIELD_GET(DTE_HOST_TRP, gdte->dte[0]) != 0)
+		return -EINVAL;
+
+	/* Must be non-zero: V, GIOV, GV, GCR3 TRP */
+	if (FIELD_GET(DTE_FLAG_V, gdte->dte[0]) == 0 ||
+	    FIELD_GET(DTE_FLAG_GV, gdte->dte[0]) == 0 ||
+	    (FIELD_GET(DTE_GCR3_14_12, gdte->dte[0]) == 0 &&
+	     FIELD_GET(DTE_GCR3_30_15, gdte->dte[1]) == 0 &&
+	     FIELD_GET(DTE_GCR3_51_31, gdte->dte[1]) == 0))
+		return -EINVAL;
+
+	/* Valid Guest Paging Mode values are 0 and 1 */
+	if (gpt_level != GUEST_PGTABLE_4_LEVEL &&
+	    gpt_level != GUEST_PGTABLE_5_LEVEL)
+		return -EINVAL;
+
+	/* GLX = 3 is reserved */
+	if (FIELD_GET(DTE_GLX, gdte->dte[0]) == 3)
+		return -EINVAL;
+
+	/*
+	 * We need to check host capability before setting
+	 * the Guest Paging Mode
+	 */
+	if (gpt_level == GUEST_PGTABLE_5_LEVEL &&
+	    amd_iommu_gpt_level < PAGE_MODE_5_LEVEL)
+		return -EOPNOTSUPP;
+
+	return 0;
+}
+
+/*
+ * This function is assigned to struct iommufd_viommu_ops.alloc_domain_nested()
+ * during the call to struct iommu_ops.viommu_init().
+ */
+struct iommu_domain *
+amd_iommu_alloc_domain_nested(struct iommufd_viommu *viommu, u32 flags,
+			      const struct iommu_user_data *user_data)
+{
+	int ret;
+	struct nested_domain *ndom;
+	struct amd_iommu_viommu *aviommu = container_of(viommu, struct amd_iommu_viommu, core);
+
+	if (user_data->type != IOMMU_HWPT_DATA_AMD_GUEST)
+		return ERR_PTR(-EOPNOTSUPP);
+
+	ndom = kzalloc(sizeof(*ndom), GFP_KERNEL);
+	if (!ndom)
+		return ERR_PTR(-ENOMEM);
+
+	ret = iommu_copy_struct_from_user(&ndom->gdte, user_data,
+					  IOMMU_HWPT_DATA_AMD_GUEST,
+					  dte);
+	if (ret)
+		goto out_err;
+
+	ret = validate_gdte_nested(&ndom->gdte);
+	if (ret)
+		goto out_err;
+
+	ndom->gdom_id = FIELD_GET(DTE_DOMID_MASK, ndom->gdte.dte[1]);
+	ndom->domain.ops = &nested_domain_ops;
+	ndom->domain.type = IOMMU_DOMAIN_NESTED;
+	ndom->viommu = aviommu;
+
+	return &ndom->domain;
+out_err:
+	kfree(ndom);
+	return ERR_PTR(ret);
+}
+
+static void nested_domain_free(struct iommu_domain *dom)
+{
+	struct nested_domain *ndom = to_ndomain(dom);
+
+	kfree(ndom);
+}
+
+static const struct iommu_domain_ops nested_domain_ops = {
+	.free = nested_domain_free,
+};
-- 
2.34.1

